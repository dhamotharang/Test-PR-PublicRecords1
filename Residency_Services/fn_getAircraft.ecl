IMPORT BatchShare, BatchDatasets, doxie, Residency_Services, ut;

EXPORT fn_getAircraft(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                      Residency_Services.IParam.BatchParams   mod_params_in) := FUNCTION

	in_mod := MODULE(PROJECT(mod_params_in, BatchShare.IParam.BatchParamsV2)) 
	          END;

	ds_aircraft_recs := BatchDatasets.fetch_Aircraft_recs(ds_in_acctnos_dids, in_mod);

	TodaysDate := Residency_Services.Constants.TodaysDate;

	ds_aircraft_recs_fltrd := ds_aircraft_recs(ut.DaysApart((STRING8)date_last_seen, TodaysDate)
	                                           <  Residency_Services.Constants.Days_in_Year);

	Residency_Services.Layouts.Int_Service_Output tf_AC_recs(ds_aircraft_recs_fltrd l) := TRANSFORM
		SELF.acctno       := l.acctno;
		SELF.did          := l.did;
		SELF.expired_flag := 'N';
		SELF.county_name  := l.county_name;
		SELF.st           := l.st;
	END;

	ds_aircraft_ret := PROJECT(ds_aircraft_recs_fltrd, tf_AC_recs(LEFT));

  // OUTPUT(ds_input,               NAMED('fgAC_ds_input'));
	// OUTPUT(ds_input_acctno_did_dd, NAMED('fgAC_ds_input_acctno_did'_dd));
  // OUTPUT(ds_aircraft_recs,       NAMED('fgAC_ds_aircraft_recs'));
  // OUTPUT(ds_aircraft_recs_fltrd, NAMED('fgAC_ds_aircraft_recs_fltrd'));

	RETURN  ds_aircraft_ret ;

END;