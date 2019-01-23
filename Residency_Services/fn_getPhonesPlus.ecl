IMPORT doxie, Residency_Services, ut;

export fn_getPhonesPlus(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                        Residency_Services.IParam.BatchParams mod_params_in) := FUNCTION	

	Phonesplus_In := PROJECT(ds_in_acctnos_dids, doxie.layout_references);

  // params to be passed into doxie.MAC_Get_GLB_DPPA_PhonesPlus below
	drm_value             := mod_params_in.DataRestrictionMask;
  dppa_value            := mod_params_in.DPPAPurpose;
	glb_value             := mod_params_in.GLBPurpose;
	industry_class_value  := mod_params_in.industry_class;

	// NOTE: The first comment in doxie.MAC_Get_GLB_DPPA_PhonesPlus says it should be called after 
	//       doxie.MAC_Header_Field_Declare.  However all it appears to need is the 
	//       score_threshold_value out of that mac_hdr_fld_decl.  
	//       So did not think it was worthwhile to use the full doxie.MAC_Header_Field_Declare and 
	//       the overhead incurred.
	// Instead score_threshold_value is set/exported here and it is set to the same default('10')
	// as in AutoStandardI.GlobalModule.  It should not need to be used from passed in 
	// mod_params_in(i.e. 'STORED') since we aren't overriding it.
  EXPORT UNSIGNED1 score_threshold_value := Residency_Services.Constants.ScoreThreshold; 

	doxie.MAC_Get_GLB_DPPA_PhonesPlus(Phonesplus_In, phonesp_recs_out,
	                                  TRUE, // is_roxie?  override default of "false" which seems to    
																		      // be what most other attrs that call this macro do.
																		, // skipAutokeys, use default of false
																		glb_value, 
																		dppa_value,
																		industry_class_value,
																	  , // min_confidencescore, use default of 11
																		, // company_name_value, use default
																		, // autokey_skipset, use default
																		FALSE, // autokey_fetch_nofail?  override default of "true" 
																	         // which seems to be what most other attrs that call
																					 // this macro do.
																		drm_value
																		// is_CompReport, use default of false 
																		// checkRNA, use default of false 
																		);

  TodaysDate := Residency_Services.Constants.TodaysDate;

	recs_fltrd := phonesp_recs_out(ut.DaysApart(dt_last_seen, TodaysDate) 
	                               < Residency_Services.Constants.Days_in_Year);

	recs_ded := DEDUP(SORT(recs_fltrd, did, phone, -dt_last_seen), did, phone);

	// Try finding county with FIPS code																	
	doxie.layout_pp_raw_common tf_AddCountyname(recs_ded L) := TRANSFORM
		SELF.county_name := Residency_Services.Functions.get_county_name(l.st,l.county_code[3..5]);
		SELF := l ;
	END;

	recswithfipscounty := PROJECT(recs_fltrd, tf_AddCountyname(LEFT));

	//split the records into two, one with countyname and one without
	withcounty    := recswithfipscounty(county_name <>'');
	withoutcounty := recswithfipscounty(county_name ='');

	// For Records without county name even after fips code lookup, find county from Advo key
	Residency_Services.MAC_addCountyname(withoutcounty,zip,addcountyadvo);
	
	Tot_recs := withcounty + addcountyadvo;

	PPwacctno := JOIN(Tot_recs, ds_in_acctnos_dids, 
										  (UNSIGNED6)LEFT.did = RIGHT.did, 
										TRANSFORM(Residency_Services.Layouts.Int_Service_output,
															SELF.acctno       := RIGHT.acctno,
															SELF.did          := RIGHT.did,
															SELF.expired_flag := 'N',
															SELF.county_name  := LEFT.county_name,
															SELF.st           := LEFT.st
															));

  // OUTPUT(Phonesplus_In,      NAMED('Phonesplus_In'));
	// OUTPUT(phonesp_recs_out,   NAMED('phonesp_recs_out'));
	// OUTPUT(recs_fltrd,         NAMED('recs_fltrd'));
	// OUTPUT(recs_ded,           NAMED('recs_ded'));
	// OUTPUT(recswithfipscounty, NAMED('recswithfipscounty')); 
  // OUTPUT(withcounty,         NAMED('withcounty'));
  // OUTPUT(withoutcounty,      NAMED('withoutcounty'));
  // OUTPUT(addcountyadvo,      NAMED('addcountyadvo'));
  // OUTPUT(Tot_recs,           NAMED('Tot_recs'));

	RETURN PPwacctno;

END;