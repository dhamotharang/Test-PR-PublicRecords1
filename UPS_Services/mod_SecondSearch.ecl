import doxie, dx_header, ut, AutoStandardI, BIPV2;

export mod_SecondSearch := MODULE

	shared IT := AutoStandardI.InterfaceTranslator;
	shared maxRecs := 10;  // was originally coded as 100, but we really just want SOMETHING to return and 10 provides less impact to latency
	shared message_code 		:= 999;//temp.  i dont know what we should use for internal messages.
	shared message_prefix 	:= 'UPS_Services.mod_SecondSearch: ';

	// Make a last-ditch effort to find /something/.  Very broad queries!

	// NOTE: any query which does not use zip codes should filter on state 
	// unless the state input is not set since non-matching state records will
	// be filtered in the rollup.
	export Individual(mod_Params.PersonSearch search_mod) := MODULE
		layout := doxie.layout_references_hh;

		inLastName := IT.lname_value.val(project(search_mod, IT.lname_val.params));
		inPhoneticLastName := if(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], '');  //most or all of these keys have dph_lname limited to string6
		inPrimRange := IT.prange_value.val(project(search_mod, IT.prange_value.params));
		inPrimName := IT.pname_value.val(project(search_mod, IT.pname_value.params));
		inCity := IT.city_value.val(project(search_mod, IT.city_value.params));
		inCityCode := doxie.Make_CityCodes(inCity).rox;
		inState := IT.state_value.val(project(search_mod, IT.state_value.params));
		inStateSet := if(inState <> '', [ inState ],
																	  if(inCity <> '', fn_BestStates(inCity, 5), []));
		inZip5 := (INTEGER) IT.zip_val.val(project(search_mod, IT.zip_val.params));
		derrivedZipFromCity := IF(inState <> '' and inCity <> '', ut.ZipsWithinCity(inState, inCity), [] );
		inZip5Set := [inZip5] + derrivedZipFromCity;
		
		inPhone := IT.phone_value.val(project(search_mod, IT.phone_value.params));
		phoneLen := LENGTH(TRIM(inPhone));

		StreetQuery := PROJECT(CHOOSEN(dx_header.key_DTS_address()(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(prim_range = inPrimRange) AND
															KEYED(st IN inStateSet OR NOT EXISTS(inStateSet))), maxRecs), 
													 TRANSFORM(layout, SELF := LEFT));

		RangeZipQuery := PROJECT(CHOOSEN(dx_header.key_zipprlname()(
															KEYED(zip IN inZip5Set) AND
															KEYED(prim_range = inPrimRange)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		StreetZipQuery := PROJECT(CHOOSEN(dx_header.key_DTS_StreetZipName()(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(zip IN inZip5Set) AND
															(dph_lname = inPhoneticLastName OR dph_lname = '')), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		inPiz5Set := ut.PizTools.reverseZipset(inZip5Set);
	
		LastZipQuery := PROJECT(CHOOSEN(dx_header.key_piz()(
															KEYED(piz IN inPiz5Set) AND
															KEYED(dph_lname = inPhoneticLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));
		
		LastCityStateQuery := PROJECT(CHOOSEN(dx_header.key_StCityLFName()(
															KEYED(city_code in inCityCode) AND
															KEYED(st = inState) AND
															KEYED(dph_lname = inPhoneticLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		LastStateQuery :=	PROJECT(CHOOSEN(dx_header.key_StFnameLname()(
															KEYED(st = inState) AND
															KEYED(dph_lname = inPhoneticLastName) AND
															KEYED(lname = inLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));
		
		//EVEN LOOSER
		StreetQuery2 := PROJECT(CHOOSEN(dx_header.key_DTS_address()(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(prim_range = inPrimRange)), maxRecs), 
													 TRANSFORM(layout, SELF := LEFT));

		StreetZipQuery2 := PROJECT(CHOOSEN(dx_header.key_DTS_StreetZipName()(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(zip IN inZip5Set)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		LastStateQuery2 :=	PROJECT(CHOOSEN(dx_header.key_StFnameLname()(
															KEYED(st = inState) AND
															KEYED(dph_lname = inPhoneticLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));													 
													 

		errantPhones_7 :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone7 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone7;
		
		errantPhones_3 :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone3 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone3;

		errantPhones :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone10 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone10;
			
		PhoneQuery :=	
		PROJECT(
			CHOOSEN(
				LIMIT(
					dx_header.key_wild_phone()( //ups right address service is already using this key (as opposed to non-wild version)
						KEYED(p7 in errantPhones_7) AND
						KEYED(p3 in errantPhones_3) AND
						p3+p7 in errantPhones
					), 
					ut.limits.PHONE_PER_PERSON, keyed, skip
				),
				maxRecs
			),
			TRANSFORM(
				layout, 
				SELF := LEFT
			)
		);
													 
		doStreetQuery := inPrimName <> '' AND inPrimRange <> '';
		doRangeZipQuery := inPrimRange <> '' AND EXISTS(inZip5Set);
		doStreetZipQuery := inPrimName <> '' AND EXISTS(inZip5Set);
		doLastZipQuery := inPhoneticLastName <> '' AND EXISTS(inZip5Set);
		doLastCityStateQuery := inPhoneticLastName <> '' AND inCity <> '' AND inState <> '';
		doLastStateQuery := inLastName <> '' AND inState <> '';
		doPhone := inPhone <> '' AND (phoneLen = 10);
		
		raw_recs := 
		choosen(
			StreetQuery(doStreetQuery) 
			& RangeZipQuery(doRangeZipQuery) 
			& StreetZipQuery(doStreetZipQuery) 
			& LastZipQuery(doLastZipQuery) 
			& LastCityStateQuery(doLastCityStateQuery) 
			& LastStateQuery(doLastStateQuery) 
			& PhoneQuery(doPhone)
			& StreetQuery2(doStreetQuery)
			& StreetZipQuery2(doStreetZipQuery)
			& LastStateQuery2(doLastStateQuery)
			,maxRecs
		);

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);

		export records := limit_dids;
	END;


 	export Business(UPS_Services.SearchParams SearchParams,
										UPS_Services.mod_Params.BusinessSearch BizParams) := MODULE

   		layout := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(dataset([],BIPV2.IDfunctions.rec_SearchInput)).RecordOut2;
			
     	
   		inCompanyName := '';
   		inPrimRange := SearchParams.addrQueryInputs.StreetNumber;
   		inPrimName := SearchParams.addrQueryInputs.StreetName; 
   		inCity := SearchParams.addrQueryInputs.City; 
   		inState := SearchParams.addrQueryInputs.State;
   		inStateSet := if(inState <> '', [ inState ],
   																	  if(inCity <> '', fn_BestStates(inCity, 5), []));
   		inZip5 := (INTEGER) SearchParams.addrQueryInputs.Zip5; 
   		derrivedZipFromCity := IF(inState <> '' and inCity <> '', ut.ZipsWithinCity(inState, inCity), [] );
   		inZip5Set := [inZip5] + derrivedZipFromCity;
   		
   		inPhone := SearchParams.phoneQueryInput; 
   		phoneLen := LENGTH(TRIM(inPhone));
			
			dsStates := DATASET([inStateSet],{string state});			
			StateStreetInput1 := project(dsStates, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
                                                  self.state := LEFT.state,
                                                  self.prim_name := inPrimName,
                                                  self := []));
																									
			StateStreetInput2 := project(dsStates, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
                                                  self.state := left.state,
                                                  self.prim_name := ut.Word(inPrimName, 1, ' '),
                                                  self := []));
																									
			StateStreetInput := StateStreetInput1 + StateStreetInput2;
				
			dsZips := DATASET([inZip5Set],{INTEGER zip5});
			Zip5StreetInput1  := project(dsZips, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
                                      					self.prim_name :=  inPrimName;
																										self.zip5 := (string)left.zip5;
																										self := []));
																									
			Zip5StreetInput2  := project(dsZips, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
                                      					self.prim_name :=  ut.Word(inPrimName, 1, ' ');
																										self.zip5 := (string)left.zip5;
																										self := []));
																										
			Zip5StreetInput := Zip5StreetInput1 + Zip5StreetInput2;
			
			 ////EVEN LOOSER	
			PrimRangeStreetInput1  := dataset([transform(BIPV2.IDfunctions.rec_SearchInput,
																												self.prim_range := SearchParams.AddrQueryInputs.StreetNumber, 
																												self.prim_name :=  inPrimName,
																												self := [])]);
																												
			PrimRangeStreetInput2  := dataset([transform(BIPV2.IDfunctions.rec_SearchInput,
																												self.prim_range := SearchParams.AddrQueryInputs.StreetNumber, 
																												self.prim_name :=  ut.Word(inPrimName, 1, ' '),
																												self := [])]);
																												
			PrimRangeStreetInput := PrimRangeStreetInput1 + PrimRangeStreetInput2;
			
   		errantPhones_7 :=
   			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone7 +
   			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone7;
   		
   		errantPhones_3 :=
   			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone3 +
   			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone3;
   			
   		errantPhones :=
   			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone10 +
   			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone10;	
			
			dsErrantPhones_7 := dataset(errantPhones_7,{string phone7});
			dsErrantPhones_10 := dataset(errantPhones,{string phone10}); 
			dsErrantPhones_7Input :=  project(dsErrantPhones_7,
																			transform(BIPV2.IDfunctions.rec_SearchInput,
																									self.phone10 := left.phone7,
																									self.allow7digitmatch := true,
																									self := []));
																									
	   dsErrantPhones_10Input :=  project(dsErrantPhones_10,
																			transform(BIPV2.IDfunctions.rec_SearchInput,
																									self.phone10 := left.phone10,
																									self.allow7digitmatch := false,
																									self := []));
																									
			PhonesInput := 	dsErrantPhones_7Input + 	dsErrantPhones_10Input;
			
   		doStateStreetQuery := EXISTS(inStateSet) AND inPrimName <> '';
   		doZipStreetQuery := EXISTS(inZip5Set) AND inPrimName <> '';
   		doPhone := inPhone <> '' AND (phoneLen = 10);
   		doPRPNQuery := inPrimName <> '' AND inPrimRange <> '';
   
   		FinalInput := 	if(doStateStreetQuery,StateStreetInput) 
											& if(doZipStreetQuery,Zip5StreetInput) 
											& if(doPhone,PhonesInput)
											& if(doPRPNQuery,PrimRangeStreetInput);
   		
			
			

  // Get links ids for the search criteria
	
	
	// begin new code *********		to emulate	top biz ranking		
	
	in_mod2 := module(AutoStandardI.DataRestrictionI.params)  
	  export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := BizParams.datarestrictionmask;
		export unsigned1 DPPAPurpose := BizParams.dppapurpose;
		export unsigned1 GLBPurpose := BizParams.glbpurpose;
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;	
	end;
	
			
     FinalOutput := UPS_Services.fn_BIPLookup(FinalInput,in_mod2); 
		  FinalOutput_choosen := choosen(FinalOutput,maxRecs);

   		#IF(Debug.debug_flag)
   		output(FinalOutput_choosen, NAMED('second_bip'));
   		#END
   
   		export records := FinalOutput_choosen;
   	END;

END;