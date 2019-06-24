// High level flow
	// 1. Get Property assessment information for the input person using 
	//    BatchDatasets.fetch_Property_recs, to get homestead_exemption information.
	// 2. Check 3 fields for homestead information and set as needed.
	// 3. Attach homestead info to appropriate input acctno/address record(s).
IMPORT BatchDatasets,BatchServices,HomesteadExemption_Services,
       Residency_Services,Suppress,ut;

EXPORT fn_getProperty(DATASET(Residency_Services.Layouts.IntermediateData) ds_input) := FUNCTION

	// Fetch property records for the SSNs/names from the batch input
	// NOTE: This is similar to coding in part of/step 1 of HomesteadExemption_Services/fn_getPropertyRecs
  //
  // Project certain input fields onto appropriate layout
  ds_in_prop_fetch_projtd := PROJECT(ds_input, TRANSFORM(BatchDatasets.Layouts.batch_in,
    //clear the address fields so the property recs returned are for the person instead of 
		// just the property recs at a specific address.
		                                    SELF.addr        := '',
		                                    SELF.prim_range  := '',
		                                    SELF.predir      := '',
		                                    SELF.prim_name   := '',
		                                    SELF.addr_suffix := '',
		                                    SELF.postdir     := '',
		                                    SELF.unit_desig  := '',
		                                    SELF.sec_range   := '',
		                                    SELF.p_city_name := '',
		                                    SELF.st          := '',
		                                    SELF.z5      		 := '',
		                                    SELF.zip4        := '',
		                                    SELF.county_name := '',
																				SELF := LEFT // all other fields from input
																		));

	// Sort/dedup on acctno/ssn since BatchDatasets.fetch_Property_recs mainly uses ssns.
	// See comments in there for more detail.
	ds_in_prop_fetch_pdd := DEDUP(SORT(ds_in_prop_fetch_projtd(ssn <>''), acctno, ssn), acctno, ssn);	

  // Call an existing function to actually fetch the property records. 
	// NOTE: 3 of next 4 steps similar to HomesteadExemption_Services/fn_getPropertyBatch, but could
	//       not use that since other "tweaks" were needed here.
	ds_prop_recs_fetched := BatchDatasets.fetch_Property_recs(
												     ds_in_prop_fetch_pdd,
	                           suppress.constants.NonSubjectSuppression.doNothing,
														 FALSE); //isFCRA?

	// Filter for only "Assessment" records that are "Current"
	ds_prop_recs_currassess := ds_prop_recs_fetched(fid_type = 'A' AND current_record = 'Y');

	// Flatten property recs
	ds_prop_recs_notflat := PROJECT(ds_prop_recs_currassess,
	                                TRANSFORM(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes, 
												            SELF := LEFT, 
													          SELF := []));

	ds_prop_recs_flat := PROJECT(ds_prop_recs_notflat, BatchServices.xfm_Property_make_flat(LEFT, 
															                          FALSE)); //return_unformatted_values?

	// Check/set homestead indicator
	rec_property_layout :=  RECORD
		BatchServices.layout_Property_Batch_out;
		STRING1 homestead;
	END;

	rec_property_layout tf_set_hs(ds_prop_recs_flat l) := TRANSFORM
    // Examine 3 assessment related fields for "Homestead exemption" info
		homeEx   := l.assess_homestead_homeowner_exemption ='Y';
		OwnerOcc := l.assess_owner_occupied = 'Y';  
		taxEx    := HomesteadExemption_Services.Functions.fn_findTerm(l.assess_tax_exemption1_desc) OR
								HomesteadExemption_Services.Functions.fn_findTerm(l.assess_tax_exemption2_desc) OR
								HomesteadExemption_Services.Functions.fn_findTerm(l.assess_tax_exemption3_desc) OR
								HomesteadExemption_Services.Functions.fn_findTerm(l.assess_tax_exemption4_desc) ;
		SELF.homestead := IF(homeEx OR OwnerOcc OR taxEx,'Y','N'),
		SELF := l,
	END;
	
	ds_prop_recs_flat_whs := PROJECT(ds_prop_recs_flat, tf_set_hs(LEFT));
	
	// Sort/dedup property records flat with homestead indicator
	// Note: In the property/assessment records, sometimes recs with vendor_source_flag = B 
	//   (LN/OK City) recs seem to have the assess_owner_occupied = 'Y'; 
	//   whereas recs for the same APN with vendor_source_flag = A (Fares) seem to have the 
	//   assess_owner_occupied = 'N'; even when the "A" rec "sortby_date" is more recent than 
	//   the "B" rec.  
	//   Therefore, use the recs where the Homestead was set to 'Y' even if it is not the most
	//   recent (highest sortby_date) rec for a property address.
	ds_prop_recs_flat_whs_dd := DEDUP(SORT(ds_prop_recs_flat_whs,
	                                       acctno,property_address1,property_p_city_name,
																				 property_st,property_zip, 
																         -homestead,  // any 'Y's before 'N's (see above)
	                                       -sortby_date), // in case all else dupe, use most recent
	                                  acctno,property_address1,property_p_city_name,
																		property_st,property_zip);

  // Join ds input to the prop recs with homestead appended only keeping ones that match
	// and transforming onto the final layout out of this function.
	Residency_Services.Layouts.Prop_Service_output tf_final_output(ds_input l,
	                                                               ds_prop_recs_flat_whs_dd r
																																) := TRANSFORM
		SELF.Homestead := r.homestead, // save from right ds_prop_recs_flat_whs_dd from above 
		SELF := l, // all other fields keep from left/ds_input
	END;

	ds_get_prop_ret := JOIN(ds_input, ds_prop_recs_flat_whs_dd,
											      LEFT.acctno = RIGHT.acctno AND
														LEFT.address1 = RIGHT.property_address1              AND
														// v--- only ones where input did is an owner
														(ut.NZEQ(LEFT.did, (UNSIGNED6)RIGHT.owner_1_did) or 
														 ut.NZEQ(LEFT.did, (UNSIGNED6)RIGHT.owner_2_did))    AND
														// v--- address2/property_address2 = unit_desig + sec_range
														//      (which may or may not be present)
                            ut.NNEQ(LEFT.address2, RIGHT.property_address2)      AND															
														LEFT.p_city_name = RIGHT.property_p_city_name        AND
													  LEFT.st				   = RIGHT.property_st                 AND
													  LEFT.z5			     = RIGHT.property_zip, 
												  tf_final_output(LEFT,RIGHT),
												  INNER); //intentionally only keep left that match right


   // OUTPUT(ds_input,                 NAMED('fgPr_ds_input'));
	 // OUTPUT(ds_in_prop_fetch_projtd,  NAMED('fgPr_ds_in_prop_fetch_projtd'));
	 // OUTPUT(ds_in_prop_fetch_pdd,     NAMED('fgPr_ds_in_prop_fetch_pdd'));
	 // OUTPUT(ds_prop_recs_fetched,     NAMED('fgPr_ds_prop_recs_fetched'));
	 // OUTPUT(ds_prop_recs_currassess,  NAMED('fgPr_ds_prop_recs_currassess'));
	 // OUTPUT(ds_prop_recs_notflat,     NAMED('fgPr_ds_prop_recs_notflat'));
	 // OUTPUT(ds_prop_recs_flat,        NAMED('fgPr_ds_prop_recs_flat'));
	 // OUTPUT(ds_prop_recs_flat_whs,    NAMED('fgPr_ds_prop_recs_flat_whs'));
	 // OUTPUT(ds_prop_recs_flat_whs_dd, NAMED('fgPr_ds_prop_recs_flat_whs_dd'));
	 // OUTPUT(ds_get_prop_ret,        NAMED('fgPr_ds_get_prop_ret'));
	
	RETURN ds_get_prop_ret;

END;
