IMPORT bankrupt, doxie, doxie_raw, Residency_Services, ut;

EXPORT fn_getBankruptcy(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids) := FUNCTION

  // Project input onto layout needed by doxie_raw.bk_raw, also stripping off the acctno
	ds_bk_in_did := PROJECT(ds_in_acctnos_dids, doxie.layout_references);
													
	ds_bk_in_did_dd := DEDUP(SORT(ds_bk_in_did, did), did);
	
	ds_bk_recs:= Doxie_Raw.bk_raw(ds_bk_in_did_dd, 
	                              DATASET([],Doxie.Layout_ref_bdid),
																in_party_type := Residency_Services.Constants.DEBTOR);

	TodaysDate := Residency_Services.Constants.TodaysDate;

	ds_bk_recs_fltrd := ds_bk_recs(ut.DaysApart(date_filed, TodaysDate)
	                                < Residency_Services.Constants.Days_in_Year);

	ds_bk_recs_debtors:= ds_bk_recs_fltrd.debtor_records;
	
	rec_layout_debtor := RECORD
		UNSIGNED6 debtor_DID;
		bankrupt.layout_bk_search_addr;
	END;
	
	rec_layout_debtor tf_norm_debtors(ds_bk_recs_debtors l, 
	                                  bankrupt.layout_bk_search_addr r) := TRANSFORM
		SELF.debtor_DID := (UNSIGNED8)l.debtor_DID;
		SELF := r;
	END;

	ds_debtors_normalized := NORMALIZE(ds_bk_recs_debtors, LEFT.addresses,
																		 tf_norm_debtors(LEFT,RIGHT));
	
	ds_debtors_norm_fltrd_did := ds_debtors_normalized(debtor_did IN SET(ds_bk_in_did_dd, did));
	
	ds_bk_wacctno := JOIN(ds_debtors_norm_fltrd_did, ds_in_acctnos_dids,
													LEFT.debtor_DID = RIGHT.did, 
												TRANSFORM(Residency_Services.Layouts.Int_Service_output,
												  SELF.acctno       := RIGHT.acctno,
													SELF.did          := RIGHT.did,
													SELF.expired_flag := 'N',
													SELF.county_name  := LEFT.county_name,
													SELF.st           := LEFT.st));

  // OUTPUT(ds_input,               NAMED('fgBK_ds_input'));
	// OUTPUT(ds_input_acctno_did_dd, NAMED('fgBK_ds_input_acctno_did'_dd));
  // OUTPUT(ds_bk_in_did,           NAMED('fgBK_ds_bk_in_did'));
  // OUTPUT(ds_bk_in_did_dd,        NAMED('fgBK_ds_bk_in_did_dd'));
  // OUTPUT(ds_bk_recs,             NAMED('fgBK_ds_bk_recs'));
  // OUTPUT(ds_bk_recs_fltrd,       NAMED('fgBK_ds_bk_recs_fltrd'));
  // OUTPUT(ds_bk_recs_debtors,     NAMED('fgBK_ds_bk_recs_debtors'));
  // OUTPUT(ds_debtors_normalized,  NAMED('fgBK_ds_debtors_normalized'));
  // OUTPUT(ds_debtors_norm_fltrd_did,  NAMED('fgBK_ds_debtors_norm_fltrd_did'));

	RETURN ds_bk_wacctno;
	
END;
