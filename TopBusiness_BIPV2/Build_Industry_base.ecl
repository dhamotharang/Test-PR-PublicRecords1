/*
IMPORT BusReg,DNB_FEINV2,MDR,TopBusiness_BIPV2,BIPV2;

EXPORT Build_Industry_base := MODULE

Industry_Base_file_name :='~thor_data400::base::Industry_base'+thorlib.wuid();

	export All := sequential(
								OUTPUT(BIPV2.Industry_sources,,Industry_Base_file_name ,OVERWRITE)
								// ,fileservices.StartSuperFileTransaction 
								,fileservices.ClearSuperFile ('~thor_data400::BASE::Industry_Base') 
								,fileservices.AddSuperFile ('~thor_data400::BASE::Industry_Base', Industry_Base_file_name) 
								// ,fileservices.FinishSuperFileTransaction 
							 
	);
	
END;
*/
// Build_Industry_base(pversion, pIsTesting, pInFile)



import _control, tools, BIPV2, ut;

export Build_Industry_base(

	 string														              pversion
	,dataset(Layouts.rec_industry_combined_layout	)	pBaseFile						= BIPV2.Industry_sources								
) :=
module

	pBaseFile_fil := project(pBaseFile((ultid <> 0 or orgid <> 0 or seleid <> 0 or proxid <> 0 or powid <> 0 or empid <> 0 or dotid <> 0 or bdid <> 0) and
																		 (trim(siccode) <> '' or trim(naics) <> '' or trim(industry_description) <> '' or trim(business_description) <> '')),
													 transform(Layouts.rec_industry_combined_layout, 
																		 self.industry_description := ut.fnTrim2Upper(left.industry_description),
																		 self.business_description := ut.fnTrim2Upper(left.business_description),
																		 self.siccode      := trim(left.siccode[1..4]),
																		 self.siccode_plus := trim(left.siccode[5..8]),
																		 self 										 := left));

	//*** filter bad records and sort the file for rollup.
	dBaseFile_srt := sort(distribute(pBaseFile_fil, hash64(source, ultid, orgid, seleid, proxid, bdid)),
												source, ultid, orgid, seleid, proxid, powid, empid, dotid, bdid, source_docid, source_rec_id, siccode, siccode_plus, naics, industry_description,
												business_description, record_type, local);
		
	//*** rollup the file to remove the dupicate records.
	Layouts.rec_industry_combined_layout rollupTrf(dBaseFile_srt l, dBaseFile_srt r) := transform
		self.dt_first_seen 						:= ut.EarliestDate(l.dt_first_seen, r.dt_first_seen);
		self.dt_last_seen 						:= ut.LatestDate(l.dt_last_seen, r.dt_last_seen);
		self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.dt_vendor_last_reported 	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.record_date 							:= ut.LatestDate(l.record_date, r.record_date);
		self 													:= l;
	end;

	dBaseFile_rollup := rollup(dBaseFile_srt, rollupTrf(left, right), 
														 except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, record_date,
														 ultscore, orgscore, selescore, proxscore, powscore, empscore, dotscore,
														 ultweight, orgweight, seleweight, proxweight, powweight, empweight, dotweight, bdid_score, local);
   
	Build_Base_File := tools.macf_WriteFile(Filenames(pversion).Industry_LinkIds.new	,dBaseFile_rollup);
																													
	export full_base := sequential(Build_Base_File  ,promote(pversion).new2built);
		
end;