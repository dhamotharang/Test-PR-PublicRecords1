import ut;

export BH_Industry(

	 dataset(Layouts.Base.Layout_Industry				)	pInIndustryFile			= PRTE2_BIPV2_BusHeader.Industry_sources
	
) :=
function

	dInIndustryFile := pInIndustryFile;
	
	pBaseFile_fil := project(dInIndustryFile((ultid <> 0 or orgid <> 0 or seleid <> 0 or proxid <> 0 or powid <> 0 or empid <> 0 or dotid <> 0 or bdid <> 0) and
																		 (trim(siccode) <> '' or trim(naics) <> '' or trim(industry_description) <> '' or trim(business_description) <> '')),
													 transform(Layouts.base.layout_industry, 
																		 self.industry_description := ut.CleanSpacesAndUpper(left.industry_description),
																		 self.business_description := ut.CleanSpacesAndUpper(left.business_description),
																		 self 										 := left));

	//*** filter bad records and sort the file for rollup.
	dBaseFile_srt := sort(distribute(pBaseFile_fil, hash64(source, ultid, orgid, seleid, proxid, bdid)),
												source, ultid, orgid, seleid, proxid, powid, empid, dotid, bdid, source_docid, source_rec_id, siccode, naics, industry_description,
												business_description, record_type, local);
		
	//*** rollup the file to remove the dupicate records.
	Layouts.base.layout_industry rollupTrf(dBaseFile_srt l, dBaseFile_srt r) := transform
		self.dt_first_seen 						:= ut.EarliestDate(l.dt_first_seen, r.dt_first_seen);
		self.dt_last_seen 						:= max(l.dt_last_seen, r.dt_last_seen);
		self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.dt_vendor_last_reported 	:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.record_date 							:= max(l.record_date, r.record_date);
		self 													:= l;
	end;

	dBaseFile_rollup := rollup(dBaseFile_srt, rollupTrf(left, right), 
														 except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, record_date,
														 ultscore, orgscore, selescore, proxscore, powscore, empscore, dotscore,
														 ultweight, orgweight, seleweight, proxweight, powweight, empweight, dotweight, bdid_score, local);
	
	return dBaseFile_rollup;
	
end;
