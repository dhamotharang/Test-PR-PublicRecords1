IMPORT doxie, Residency_Services, WatercraftV2_Services, BatchShare;

EXPORT fn_getWC(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                Residency_Services.IParam.BatchParams mod_params_in) := FUNCTION

	mod_batch_params := MODULE(PROJECT(mod_params_in, 
	                                   WatercraftV2_Services.Interfaces.batch_params, OPT))
		EXPORT BOOLEAN include_non_regulated_sources := FALSE : STORED('IncludeNonRegulatedWatercraftSources');
	END;

  // Project input onto layout needed by WatercraftV2_Services.BatchRecords
	WCbatch_In := PROJECT(ds_in_acctnos_dids, TRANSFORM(WatercraftV2_Services.Layouts.batch_in,
												                      SELF.acctno := LEFT.acctno,
												                      SELF.did    := LEFT.did ,
												                      SELF := [] ));

	ds_wcbatch_out := WatercraftV2_Services.BatchRecords(mod_batch_params, WCbatch_In, FALSE);

	ds_ded_wcbatch_out := DEDUP(SORT(ds_wcbatch_out, acctno, watercraft_key,
	                                                 -(UNSIGNED8)registration_date),
	                            acctno, watercraft_key);

	TodaysDate := Residency_Services.Constants.TodaysDate;

	Residency_Services.Layouts.Int_Service_output tf_normwcraft(
	           ds_ded_wcbatch_out l, watercraftV2_Services.Layouts.owner_report_rec r) := TRANSFORM
	  SELF.acctno       := l.acctno;
		SELF.expired_flag := IF(l.registration_expiration_date <= TodaysDate,'Y','N');
		SELF.did          := (UNSIGNED6)r.did;
		SELF.dt_last_seen := l.date_last_seen ;
		SELF := r;
		SELF := [];
  END;

  // Normalize to split out owners
 	wcraftnormalized := NORMALIZE(ds_ded_wcbatch_out,LEFT.owners,
	                              tf_normwcraft(LEFT,RIGHT));
	
	// OUTPUT(WCbatch_In,         NAMED('WCbatch_In'));
	// OUTPUT(ds_wcbatch_out,     NAMED('ds_wcbatch_out'));
	// OUTPUT(ds_ded_wcbatch_out, NAMED('ds_ded_wcbatch_out'));
	// OUTPUT(wcraftnormalized,   NAMED('wcraftnormalized'));
		
	RETURN wcraftnormalized;

END;
