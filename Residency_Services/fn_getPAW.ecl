IMPORT doxie, doxie_raw, Residency_Services, STD, ut;

EXPORT fn_getPAW(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids, 
                 Residency_Services.IParam.BatchParams mod_params_in) := FUNCTION

  // Project input onto layout needed by doxie-raw.paw_raw, also stripping off the acctno
	PAW_In := PROJECT(ds_in_acctnos_dids, doxie.layout_references);
													
	Ded_PAW_In := DEDUP(SORT(PAW_In, did), did);
													
	PAW_recs := Doxie_Raw.paw_raw(Ded_PAW_In,
	                              dppa_purpose := mod_params_in.dppa,
	                              glb_purpose  := mod_params_in.glb);

  TodaysDate := Residency_Services.Constants.TodaysDate;
	
	PAW_fltrd := PAW_recs(ut.DaysApart(dt_last_Seen, TodaysDate) 
	                      < Residency_Services.Constants.Days_in_Year);
		
	PAWwacctno := JOIN(PAW_fltrd, ds_in_acctnos_dids,
										    (UNSIGNED6)LEFT.did = RIGHT.did, 
										 TRANSFORM(Residency_Services.Layouts.Int_Service_output,
											  SELF.acctno       := RIGHT.acctno,
												SELF.did          := RIGHT.did,
												SELF.expired_flag := 'N',
												SELF.county_name  := Residency_Services.Functions.get_county_name(LEFT.state,LEFT.county),
												SELF.st           := LEFT.state
										 ));
	
	// output(ded_acct_did,named('ded_acct_did')); 
	// output(Ded_PAW_In,named('Ded_PAW_In')); 
	// output(PAW_recs,named('PAW_recs')); 
	// output(PAW_fltrd,named('PAW_fltrd')); 

	RETURN PAWwacctno;

END;