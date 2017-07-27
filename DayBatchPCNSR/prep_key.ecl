import DayBatchPCNSR;

export prep_key := FUNCTION


DayBatchPCNSR.Layout_PCNSR_prekey  reformat(DayBatchPCNSR.File_PCNSR l) := transform 

   self:= l ;
end; 

   file_prekey_in:= project(DayBatchPCNSR.File_PCNSR ,reformat(left));  
	
	in_file := file_prekey_in(name_score <> '000' AND LENGTH(TRIM(phone_number)) = 7);
	
	unDIDed_recs := in_file(did = 0);
	DIDed_recs := in_file(did <> 0) : persist('pcnsr_prep_key');
	
	dist_infile := DISTRIBUTE(dided_recs,did);
	grp_infile := GROUP( SORT(dist_infile,did,-household_arrival_date,-refresh_date,LOCAL),did );
	
	d_infile := DEDUP(grp_infile,true);
	
	out := undided_recs + d_infile;
	
	RETURN out;
	
END;