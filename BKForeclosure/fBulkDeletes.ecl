IMPORT $;
/*This is to be used if multiple updates are run at once.
1) Must add all input updates to the superfiles:
thor_data400::in::BKForeclosure::reo_infile
thor_data400::in::BKForeclosure::nod_infile

2) Make sure delete superfiles are clear:
thor_data400::in::BKForeclosure::delete_reo
thor_data400::in::BKForeclosure::delete_nod

3) Run build process

4) Run fBulkDeletes (no parameters need to be passed because it uses latest base file)

5) Verify delete count makes sense and input/output is correct. 

6) Remove previous base file and move new base file to superfile. Can run BKForeclosure.run_base_stats as a secondary check of new base file
*/

EXPORT fBulkDeletes := FUNCTION
//Flag REO delete records
dsReo_curr := BKForeclosure.File_BK_Foreclosure.fReo(Delete_Flag <> 'DELETE');
FlagReoDel	:= BKForeclosure.File_BK_Foreclosure.fReo(Delete_Flag = 'DELETE'); //Already flagged records
ds_Reodel	:= DEDUP(SORT(BKForeclosure.File_BK_Foreclosure.Reo_Delete,fips_cd,pid,-ln_filedate),ALL);

BKForeclosure.layout_BK.base_reo FlagDelReo(BKForeclosure.layout_BK.base_reo L, BKForeclosure.Layout_BK.Delete_Reo R) := TRANSFORM
	SELF.Delete_Flag := IF(R.Delete_Flag = 'DELETE',R.Delete_Flag,L.Delete_flag);
	SELF.ln_filedate := IF(R.Delete_Flag = 'DELETE',R.ln_filedate,L.ln_filedate);
	SELF.bk_infile_type := IF(R.Delete_Flag = 'DELETE', 'REO_DELETE', L.bk_infile_type);
	SELF.date_vendor_last_reported := IF(R.Delete_Flag = 'DELETE',R.ln_filedate, L.date_vendor_last_reported);
	SELF := L;
END;
		
//	Set Delete flag for current matching base file records - Do not remove these records, only flag them for key filtering	
jDelReo	:= JOIN(SORT(dsReo_curr,fips_cd,lps_internal_pid,ln_filedate),
								SORT(ds_Reodel,fips_cd,pid,-ln_filedate),
								TRIM(LEFT.fips_cd,LEFT,RIGHT) = TRIM(RIGHT.fips_cd,LEFT,RIGHT) AND
								TRIM(LEFT.lps_internal_pid,LEFT,RIGHT) = TRIM(RIGHT.pid,LEFT,RIGHT) AND
								TRIM(LEFT.ln_filedate,LEFT,RIGHT) < TRIM(RIGHT.ln_filedate,LEFT,RIGHT),
								FlagDelReo(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);
								
Reoout	:= DEDUP(SORT(jDelReo + FlagReoDel,fips_cd,lps_internal_pid,-ln_filedate),ALL);

NewReoBase	:= output(Reoout,,'~thor_data400::base::BKForeclosure::Reo_'+thorlib.wuid(),overwrite,compressed);

ReoCounts	:= SEQUENTIAL(output(count(FlagReoDel),NAMED('REOBaseFileDeletes')),
												output(count(ds_Reodel),NAMED('TotalREODeletesIn')),
												output(count(Reoout(Delete_Flag = 'DELETE')),NAMED('TotalREODeletesOut')),
												output(count(Reoout),NAMED('TotalReoBaseOut')),
												output(count(Reoout(Delete_Flag <> 'DELETE')),NAMED('TotalCurrentReoBaseOut'))
												);


//Flag Nod delete records
dsNod_curr := BKForeclosure.File_BK_Foreclosure.fNod(Delete_Flag <> 'DELETE');
FlagNodDel	:= BKForeclosure.File_BK_Foreclosure.fNod(Delete_Flag = 'DELETE'); //Already flagged records
ds_Noddel	:= DEDUP(SORT(BKForeclosure.File_BK_Foreclosure.Nod_Delete,fips_cd,pid,-ln_filedate),ALL);

BKForeclosure.layout_BK.base_nod FlagDelNod(BKForeclosure.layout_BK.base_nod L, BKForeclosure.Layout_BK.Delete_Nod R) := TRANSFORM
			SELF.Delete_Flag := IF(R.Delete_Flag = 'DELETE',R.Delete_Flag,L.Delete_flag);
			SELF.ln_filedate := IF(R.Delete_Flag = 'DELETE',R.ln_filedate,L.ln_filedate);
			SELF.bk_infile_type := IF(R.Delete_Flag = 'DELETE', 'NOD_DELETE', L.bk_infile_type);
			SELF.date_vendor_last_reported := IF(R.Delete_Flag = 'DELETE',R.ln_filedate, L.date_vendor_last_reported);
			SELF := L;
		END;
		
	//Set Delete flag for current matching base file records - Do not remove these records, only flag them for key filtering	
		jDelNod	:= JOIN(SORT(dsNod_curr,fips_cd,lps_internal_pid,nod_source),
										SORT(ds_Noddel,fips_cd,pid,nod_source),
										TRIM(LEFT.fips_cd,LEFT,RIGHT) = TRIM(RIGHT.fips_cd,LEFT,RIGHT) AND
										TRIM(LEFT.lps_internal_pid,LEFT,RIGHT) = TRIM(RIGHT.pid,LEFT,RIGHT) AND
										TRIM(LEFT.nod_Source) = TRIM(RIGHT.nod_Source) AND
										TRIM(LEFT.ln_filedate,LEFT,RIGHT) < TRIM(RIGHT.ln_filedate,LEFT,RIGHT),
										FlagDelNod(LEFT,RIGHT), LEFT OUTER, MANY LOOKUP);	
								
Nodout	:= DEDUP(SORT(jDelNod + FlagNodDel,fips_cd,lps_internal_pid,-ln_filedate),ALL);

NewNODBase	:= output(Nodout,,'~thor_data400::base::BKForeclosure::Nod_'+thorlib.wuid(),overwrite,compressed);

NodCounts	:= SEQUENTIAL(output(count(FlagNodDel),NAMED('NODBaseFileDeletes')),
												output(count(ds_Noddel),NAMED('TotalNODDeletesIn')),
												output(count(Nodout(Delete_Flag = 'DELETE')),NAMED('TotalNODDeletesOut')),
												output(count(Nodout),NAMED('TotalNODBaseOut')),
												output(count(Nodout(Delete_Flag <> 'DELETE')),NAMED('TotalCurrentNODBaseOut')) //Records that are not deletes
												);
												
RETURN SEQUENTIAL(NewReoBase, ReoCounts, NewNODBase, NodCounts);

END;

