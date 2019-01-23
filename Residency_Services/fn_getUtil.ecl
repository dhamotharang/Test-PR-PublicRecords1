IMPORT AutoStandardI, doxie, doxie_raw, Residency_Services, STD, ut;

EXPORT fn_getUtil(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
					                Residency_Services.IParam.BatchParams mod_params_in):= FUNCTION

  // Project input onto layout needed by doxie_raw.util_daily_raw, also stripping off the acctno
	ds_util_in := PROJECT(ds_in_acctnos_dids, doxie.layout_references_hh);

	ds_util_in_dd := DEDUP(SORT(ds_util_in, did), did);

	ds_util_recs := doxie_raw.Util_Daily_Raw(ds_util_in_dd,
	                                         dppa_purpose         := mod_params_in.DPPAPurpose,
																				   glb_purpose          := mod_params_in.GLBPurpose,
																				   industry_class_value := mod_params_in.industry_class);
	
	TodaysDate := Residency_Services.Constants.TodaysDate;

	ds_util_fltrd := ds_util_recs(ut.DaysApart(IF(connect_date > record_date,
	                                              connect_date,record_date), 
	                                           TodaysDate) 
													      < Residency_Services.Constants.Days_in_Year);
		
	ds_util_wacctno := JOIN(ds_util_fltrd,ds_in_acctnos_dids, 
												    (UNSIGNED6)LEFT.did = RIGHT.did, 
												  TRANSFORM(Residency_Services.Layouts.Int_Service_output,
													  SELF.acctno       := RIGHT.acctno,
														SELF.did          := RIGHT.did,
														SELF.expired_flag := 'N',
														SELF.county_name  := LEFT.county_name,
														SELF.st           := LEFT.st
												 ));

	// OUTPUT(ds_input,         NAMED('fgu_ds_input'));
	// OUTPUT(ds_acctno_did_dd, NAMED('fgu_ds_acctno_did_dd'));
	// OUTPUT(ds_util_in,       NAMED('fgu_ds_util_in'));
	// OUTPUT(ds_util_in_dd,    NAMED('fgu_ds_util_in_dd'));
	// OUTPUT(ds_util_recs,     NAMED('fgu_ds_util_recs'));
	// OUTPUT(ds_util_fltrd,    NAMED('fgu_ds_util_fltrd'));
	// OUTPUT(ds_util_wacctno,  NAMED('fgu_ds_util_wacctno'));

	RETURN ds_util_wacctno;

END;