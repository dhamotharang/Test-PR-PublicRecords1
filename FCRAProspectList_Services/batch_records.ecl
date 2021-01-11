import address, FCRA_LIST, dx_fcra_opt_out, FCRAProspectList_Services, Suppress;

EXPORT batch_records ( DATASET(FCRAProspectList_Services.Layouts.Input_Processed) ds_BatchIn,
                               FCRAProspectList_Services.iParam.BatchParams inMod
							       ) := FUNCTION
  // Take input DID and join against the FCRA only source key made of of a
	// restricted set of FCRA sources.  Key is built weekly and it already
	// takes into the notion of FCRA corrections and overrides in the build logic of key.
	//
	ds_resultsRaw := JOIN(ds_batchIN, FCRA_List.key_best_did,
	                        KEYED(LEFT.DID = RIGHT.DID),
													TRANSFORM(FCRAProspectList_Services.Layouts.OutLayout,
													  SELF.LexID := LEFT.did;
														SELF.fname := RIGHT.fname;
														SELF.mname := RIGHT.mname;
														SELF.lname := RIGHT.lname;
														SELF.Name_suffix := RIGHT.Name_suffix;
														SELF.StreetAddress1 := address.Addr1FromComponents(RIGHT.prim_range,
													                       RIGHT.predir,RIGHT.prim_name,RIGHT.suffix,
																								 RIGHT.postdir,'','');
														SELF.StreetAddress2 := IF(RIGHT.unit_desig <> '' AND RIGHT.sec_range <> '', trim(RIGHT.unit_desig)+' ','')
																									  + trim(RIGHT.sec_range);
														SELF.city  := RIGHT.city_name;
														SELF.st    := RIGHT.st;
														SELF.zip   := RIGHT.zip;
														SELF.zip4  := RIGHT.zip4;
														SELF.ssn   := RIGHT.ssn;
														SELF := [];
													), LIMIT(0),KEEP(1));

	  // as per requirement 5.1.2.B for FCRA prospect list generation.
		// remove any recs that are in the opt out index before returning results
		// so this left only join accomplishes this.
	  ds_resultsRawOptOut := JOIN(ds_resultsRaw , dx_fcra_opt_out.key_did,
		                              KEYED(LEFT.LexID = RIGHT.L_DID),
																	TRANSFORM(LEFT),
																	LEFT ONLY);

    // remove recs that have 'SSN' values that are in the suppression list	(over and above FCRA opt out)
    Suppress.MAC_Suppress(ds_resultsRawOptOut,
			  ds_resultsRaw_SSNpulled,inMod.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := true);

		// remove recs that have the particular lexid (did) values that are in the suppression list (over and above FCRA opt out)
		Suppress.MAC_Suppress(ds_resultsRaw_SSNpulled,
		    ds_resultsRawDIDPulled,inMod.application_type,Suppress.Constants.LinkTypes.DID,LexID, isFCRA := true);

		// Mask SSN values if so desired from the results.
	  Suppress.MAC_Mask(ds_resultsRawDIDPulled,
			  ds_resultsRaw_SSNmasked, ssn, null, true, false, maskVal:=inMod.ssn_mask);

    ds_resultsWAcctno := JOIN(ds_BatchIn, ds_resultsRaw_SSNmasked,
		                        LEFT.DID = RIGHT.LexID,
														TRANSFORM(FCRAProspectList_Services.Layouts.OutLayout,
														 SELF.acctno := LEFT.Acctno;
														 SELF := RIGHT),
														  LEFT OUTER);

    // output(ds_resultsRaw, named('ds_resultsRaw'));
		// output(ds_resultsRawOptOut, named('ds_resultsRawOptOut'));
		// output(ds_resultsRaw_SSNpulled, named('ds_resultsRaw_SSNpulled'));
		// output(ds_resultsRawDIDPulled, named('ds_resultsRawDIDPulled'));
		//output(ds_resultsRaw_SSNmasked, named('ds_resultsRaw_SSNmasked'));
		RETURN (ds_resultsWAcctno);

END;
