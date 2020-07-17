IMPORT doxie, dx_header, ut, AutoStandardI, BIPV2;

EXPORT mod_SecondSearch := MODULE

  SHARED IT := AutoStandardI.InterfaceTranslator;
  SHARED maxRecs := 10; // was originally coded as 100, but we really just want SOMETHING to RETURN AND 10 provides less impact to latency
  SHARED message_code := 999;//temp. i dont know what we should use for internal messages.
  SHARED message_prefix := 'UPS_Services.mod_SecondSearch: ';

  // Make a last-ditch effort to find /something/. Very broad queries!

  // NOTE: any query which does not use zip codes should filter on state
  // unless the state input is not set since non-matching state records will
  // be filtered in the rollup.
  EXPORT Individual(mod_Params.PersonSearch search_mod) := MODULE
    layout := doxie.layout_references_hh;

    inLastName := IT.lname_value.val(PROJECT(search_mod, IT.lname_val.params));
    inPhoneticLastName := IF(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], ''); //most OR all of these keys have dph_lname limited to STRING6
    inPrimRange := IT.prange_value.val(PROJECT(search_mod, IT.prange_value.params));
    inPrimName := IT.pname_value.val(PROJECT(search_mod, IT.pname_value.params));
    inCity := IT.city_value.val(PROJECT(search_mod, IT.city_value.params));
    inCityCode := doxie.Make_CityCodes(inCity).rox;
    inState := IT.state_value.val(PROJECT(search_mod, IT.state_value.params));
    inStateSet := IF(inState <> '', [ inState ],
                                    IF(inCity <> '', fn_BestStates(inCity, 5), []));
    inZip5 := (INTEGER) IT.zip_val.val(PROJECT(search_mod, IT.zip_val.params));
    derrivedZipFromCity := IF(inState <> '' AND inCity <> '', ut.ZipsWithinCity(inState, inCity), [] );
    inZip5Set := [inZip5] + derrivedZipFromCity;
    
    inPhone := IT.phone_value.val(PROJECT(search_mod, IT.phone_value.params));
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

    LastStateQuery := PROJECT(CHOOSEN(dx_header.key_StFnameLname()(
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

    LastStateQuery2 := PROJECT(CHOOSEN(dx_header.key_StFnameLname()(
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
          ut.limits.PHONE_PER_PERSON, KEYED, SKIP
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
    CHOOSEN(
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
                                      TRUE, 203, FALSE, FALSE, limit_dids);

    EXPORT records := limit_dids;
  END;


  EXPORT Business(UPS_Services.SearchParams SearchParams,
                  UPS_Services.mod_Params.BusinessSearch BizParams) := MODULE

    layout := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(DATASET([],BIPV2.IDfunctions.rec_SearchInput)).RecordOut2;
  
    
    inCompanyName := '';
    inPrimRange := SearchParams.addrQueryInputs.StreetNumber;
    inPrimName := SearchParams.addrQueryInputs.StreetName;
    inCity := SearchParams.addrQueryInputs.City;
    inState := SearchParams.addrQueryInputs.State;
    inStateSet := IF(inState <> '', [ inState ],
      IF(inCity <> '', fn_BestStates(inCity, 5), []));
    inZip5 := (INTEGER) SearchParams.addrQueryInputs.Zip5;
    derrivedZipFromCity := IF(inState <> '' AND inCity <> '', ut.ZipsWithinCity(inState, inCity), [] );
    inZip5Set := [inZip5] + derrivedZipFromCity;
    
    inPhone := SearchParams.phoneQueryInput;
    phoneLen := LENGTH(TRIM(inPhone));
      
    dsStates := DATASET([inStateSet],{STRING state});
    StateStreetInput1 := PROJECT(dsStates, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
      SELF.state := LEFT.state,
      SELF.prim_name := inPrimName,
      SELF := []));
                                                  
    StateStreetInput2 := PROJECT(dsStates, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
      SELF.state := LEFT.state,
      SELF.prim_name := ut.Word(inPrimName, 1, ' '),
      SELF := []));
                                                
    StateStreetInput := StateStreetInput1 + StateStreetInput2;
      
    dsZips := DATASET([inZip5Set],{INTEGER zip5});
    Zip5StreetInput1 := PROJECT(dsZips, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
      SELF.prim_name := inPrimName;
      SELF.zip5 := (STRING)LEFT.zip5;
      SELF := []));
                                                  
    Zip5StreetInput2 := PROJECT(dsZips, TRANSFORM (BIPV2.IDfunctions.rec_SearchInput,
      SELF.prim_name := ut.Word(inPrimName, 1, ' ');
      SELF.zip5 := (STRING)LEFT.zip5;
      SELF := []));
                                                  
    Zip5StreetInput := Zip5StreetInput1 + Zip5StreetInput2;
    
      ////EVEN LOOSER
    PrimRangeStreetInput1 := DATASET([TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
      SELF.prim_range := SearchParams.AddrQueryInputs.StreetNumber,
      SELF.prim_name := inPrimName,
      SELF := [])]);
                                                      
    PrimRangeStreetInput2 := DATASET([TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
      SELF.prim_range := SearchParams.AddrQueryInputs.StreetNumber,
      SELF.prim_name := ut.Word(inPrimName, 1, ' '),
      SELF := [])]);
                                                      
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
    
    dsErrantPhones_7 := DATASET(errantPhones_7,{STRING phone7});
    dsErrantPhones_10 := DATASET(errantPhones,{STRING phone10});
    dsErrantPhones_7Input := PROJECT(dsErrantPhones_7,
      TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
        SELF.phone10 := LEFT.phone7,
        SELF.allow7digitmatch := TRUE,
        SELF := []));
                                                  
    dsErrantPhones_10Input := PROJECT(dsErrantPhones_10,
      TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
        SELF.phone10 := LEFT.phone10,
        SELF.allow7digitmatch := FALSE,
        SELF := []));
                                                  
    PhonesInput := dsErrantPhones_7Input + dsErrantPhones_10Input;
    
    doStateStreetQuery := EXISTS(inStateSet) AND inPrimName <> '';
    doZipStreetQuery := EXISTS(inZip5Set) AND inPrimName <> '';
    doPhone := inPhone <> '' AND (phoneLen = 10);
    doPRPNQuery := inPrimName <> '' AND inPrimRange <> '';
   
    FinalInput := IF(doStateStreetQuery,StateStreetInput)
                  & IF(doZipStreetQuery,Zip5StreetInput)
                  & IF(doPhone,PhonesInput)
                  & IF(doPRPNQuery,PrimRangeStreetInput);
       
    // Get links ids for the search criteria
  
    // begin new code ********* to emulate top biz ranking
    
    in_mod2 := MODULE(AutoStandardI.DataRestrictionI.params)
      EXPORT BOOLEAN AllowAll := FALSE;
      EXPORT BOOLEAN AllowDPPA := FALSE;
      EXPORT BOOLEAN AllowGLB := FALSE;
      EXPORT STRING DataRestrictionMask := BizParams.datarestrictionmask;
      EXPORT UNSIGNED1 DPPAPurpose := BizParams.dppapurpose;
      EXPORT UNSIGNED1 GLBPurpose := BizParams.glbpurpose;
      EXPORT BOOLEAN ignoreFares := FALSE;
      EXPORT BOOLEAN ignoreFidelity := FALSE;
      EXPORT BOOLEAN includeMinors := FALSE;
    END;
      
    FinalOutput := UPS_Services.fn_BIPLookup(FinalInput,in_mod2);
    FinalOutput_choosen := CHOOSEN(FinalOutput,maxRecs);

    #IF(Debug.debug_flag)
    OUTPUT(FinalOutput_choosen, NAMED('second_bip'));
    #END

    EXPORT records := FinalOutput_choosen;
  END;

END;
