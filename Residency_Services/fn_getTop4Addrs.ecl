IMPORT Address, doxie, Residency_Services;

EXPORT fn_getTop4Addrs(DATASET(Residency_Services.Layouts.IntermediateData_ext) ds_input) 
			 := FUNCTION

	doxie.layout_references_hh tf_didonly(ds_input l) := TRANSFORM
    SELF := l;
		SELF := [];
  END;

	ds_dids_in := PROJECT(ds_input, doxie.layout_references_hh);

	ds_hdr_recs := doxie.header_records_byDID(ds_dids_in); //note no params need passed in, use defaults

	// Filter to only include hdr recs with non-blanks in 3 important address fields.
	// Some header recs don't have a full/complete address (i.e. only city & state is non-blank, 
	// see did=9, 10 or 19) and might cause problems if sent to the model.
  // Then project onto needed layout
	ds_hdr_recs_toberolled := PROJECT(ds_hdr_recs
	                                  (prim_name !='' AND city_name !='' AND st !=''),
																		TRANSFORM(doxie.Layout_Comp_Addresses, 
													            SELF := LEFT, 
														          SELF.hri_address := []));

  // Roll up the header recs by address
	doxie.MAC_Address_Rollup(ds_hdr_recs_toberolled,Residency_Services.Constants.max_addresses,
													 ds_hdr_recs_rolled,FALSE);

  // Next, reduce all rolled hdr recs to just the top 4 addresses per did(acctno)
  ds_hdr_recs_rolled_top4 := TOPN(GROUP(SORT(ds_hdr_recs_rolled, did, -dt_last_seen),
	                                      did),
									                Residency_Services.Constants.Max_Total_Addresses, did); 
	          							        // ^--- need 3 in addition to the best, so get 4 total

	// Join to input to re-attach acctno and other input fields
	ds_top4_winput   := JOIN(UNGROUP(ds_hdr_recs_rolled_top4),
													 ds_input,
													   LEFT.did = RIGHT.did,
											     TRANSFORM(Residency_Services.Layouts.IntermediateData_ext, 
														  // Keep 3 fields from input
														  SELF.acctno           := RIGHT.acctno,
															SELF.Residency_County := RIGHT.Residency_County,
															SELF.Residency_State	:= RIGHT.Residency_State,
                              // Fields with different names from header
															SELF.addr_suffix      := LEFT.suffix,
															SELF.p_city_name      := LEFT.city_name,
															SELF.z5               := LEFT.zip,

															SELF.isBestAddress    := 'N',  // will be checked/set in func DedupeAdddrs
															SELF :=LEFT, // keep hdr rec address fields with same name,
															             // plus dt_last_seen & county_name  
															SELF :=RIGHT)); // keep rest of fields from input 
  

	// OUTPUT(ds_input,                   NAMED('fgt4_ds_input'));
	// OUTPUT(ds_dids_in,                 NAMED('fgt4_ds_dids_in'));
	// OUTPUT(ds_hdr_recs,                NAMED('fgt4_ds_hdr_recs'));
	// OUTPUT(ds_hdr_recs_toberolled,     NAMED('fgt4_ds_hdr_recs_toberolled'));
	// OUTPUT(ds_hdr_recs_rolled,         NAMED('fgt4_ds_hdr_recs_rolled'));
  // OUTPUT(ds_hdr_recs_rolled_top4,    NAMED('fgt4_ds_hdr_recs_rolled_top4'));
	// OUTPUT(ds_top4_winput,             NAMED('fgt4_top4_winput'));   
	
	RETURN ds_top4_winput;

END;