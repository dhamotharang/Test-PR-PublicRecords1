IMPORT BatchServices, BatchShare, doxie, Govt_Collections_Services, LN_PropertyV2_Services, Suppress, ut;

EXPORT fn_getPropertyRecs(DATASET(Govt_Collections_Services.Layouts.batch_working) ds_batch_in,
                          Govt_Collections_Services.IParams.BatchParams in_mod) := FUNCTION
													
	ds_prop_in := PROJECT(ds_batch_in, Govt_Collections_Services.Transforms.xfm_to_Property_batchIn(LEFT) );
																			
	nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.doNothing);

	#STORED('Run_Deep_Dive',TRUE);  // Force a DID search.
	#STORED('Return_Current_Only',TRUE);
	
	ds_prop := BatchServices.Property_BatchCommon(FALSE, nss, FALSE, ds_prop_in).Records;
	
	ds_prop_sort := GROUP(SORT(ds_prop, acctno, property_address1, property_address2, property_p_city_name,
											 property_v_city_name, property_st, property_zip, property_zip4, -sortby_date), acctno);
										
	ds_prop_dedup := DEDUP(ds_prop_sort, acctno, property_address1, property_address2, property_p_city_name,
												 property_v_city_name, property_st, property_zip, property_zip4);
													
	ds_prop_top := TOPN(ds_prop_dedup, 3, acctno, -sortby_date);
	ds_prop_top_ungroup := PROJECT(UNGROUP(ds_prop_top), TRANSFORM(BatchServices.layout_property_batch_out, SELF := LEFT));
	
	ds_PropertySubjects := PROJECT(ds_prop_top_ungroup, Govt_Collections_Services.Transforms.xform_PropertySubjects(LEFT, ds_batch_in));

	ds_PropertySubjects_dedup := DEDUP(SORT(ds_PropertySubjects, acctno, PropertySubject_did), acctno, PropertySubject_did);

	ds_best_address_in := PROJECT(ds_PropertySubjects_dedup, 
													TRANSFORM(Govt_Collections_Services.Layouts.batch_working,
														SELF.name_first := LEFT.PropertySubject_fname,
														SELF.name_last := LEFT.PropertySubject_lname,
														SELF.lex_id := LEFT.PropertySubject_did,
														SELF.ssn := LEFT.PropertySubject_ssn,
														SELF.orig_acctno := LEFT.acctno,
														SELF.acctno := (STRING)COUNTER,
														SELF := []));
						
	ds_best_address_out := Govt_Collections_Services.fn_getBestAddressRecs(ds_best_address_in, in_mod);
	
	ds_adlBest_out := Govt_Collections_Services.fn_getBestADLRecs(ds_best_address_out, in_mod);
	
	ds_phone_recs_out := Govt_Collections_Services.fn_getPhoneRecs(ds_adlBest_out, in_mod);
	
	ds_phone_recs :=
		DENORMALIZE(
			ds_batch_in, ds_phone_recs_out,
			LEFT.acctno = RIGHT.orig_acctno,
			GROUP,
			Govt_Collections_Services.Transforms.xfm_property_subjects_denorm(LEFT,ROWS(RIGHT))
		);														
	
	IF( in_mod.ViewDebugs, 
		OUTPUT( ds_prop, NAMED('ds_prop_intm_recs') ) );
	
	RETURN ds_phone_recs;
END;