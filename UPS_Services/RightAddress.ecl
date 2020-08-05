IMPORT iesp, AutoStandardI, CAN_PH, Address, ut, Fedex_Services, doxie;

// This module provides the main logic for executing UPS "RightAddress"
// searches.
EXPORT RightAddress(DATASET(iesp.rightaddress.t_RightAddressSearchRequest) inReq = DATASET([], iesp.rightaddress.t_RightAddressSearchRequest)) := MODULE
  ds_in := DATASET([], iesp.rightaddress.t_RightAddressSearchRequest) : STORED ('RightAddressSearchRequest', FEW);
  SHARED first_row := IF (EXISTS(inReq), inReq[1], ds_in[1]) : INDEPENDENT;

  //set options (translate from the pre-determined xml style into the stored/soap style that roxie is expecting
  SHARED search_options := GLOBAL(first_row.options);
  SHARED BOOLEAN isCanada := search_options.isCanada;
  SHARED search_by := GLOBAL (first_row.SearchBy);
  SHARED powersearch := GLOBAL(search_by.PowerSearch);
  SHARED BOOLEAN isZipSearch := search_options.ZipPostalSearch;

  addr_origin_country := IF(isCanada, Address.Components.Country.CA, address.Components.Country.US);
  #STORED ('AddressOrigin', addr_origin_country);

  SHARED search_by_name := mod_Names(search_by).bestParser() : INDEPENDENT;
  SHARED ps := mod_PowerSearch(powersearch,isCanada);
  SHARED ps_name := ps.getName() : INDEPENDENT;
  SHARED ps_phone := ps.getPhone() : INDEPENDENT;

  SHARED addr_in := IF(powersearch='', search_by.Address, ps.paddr);
  SHARED addr_out := mod_Address(addr_in,isCanada).bestParser() : INDEPENDENT;

  SHARED zip_only_response := addr_out ;
  //set main search criteria:
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(search_options);

  // the UPS service has allowed Options/MaxResults to be set to 0. When
  // MaxResults is 0, though, we miss some records in the individual header
  // lookup (gong?). Due to a WSDL/ESDL bug (Options/MaxResults isn't
  // currently visible to the middleware) we can't directly set it in the
  // request. This creates a bit of a problem, so if maxresults=0 we'll set
  // a reasonable default value here.
  maxResults := IF(search_options.maxresults = 0, iesp.Constants.RA.MAX_RESPONSE_RECORDS, search_options.maxresults);
  #STORED('MaxResults', maxResults);

  // set the query inputs (from XML) so they can be picked up by GlobalModule.
  NameToUse := IF(powersearch <> '', ps_name, search_by_name);
  iesp.ECL2ESP.SetInputName (NameToUse);

  #STORED('CompanyName', IF(powersearch <> '', ps_name.CompanyName, search_by_name.CompanyName));
  aout := PROJECT(addr_out,TRANSFORM(iesp.share.t_Address,SELF := LEFT));
  iesp.ECL2ESP.SetInputAddress(aout);
  iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

  // filter out invalid phone inputs, such as "000-0000" or "(561) 000-0000"
  // (per Bugzilla 38423)
  SHARED validPhone := MAP(powersearch <> ''=> ps_phone,
                           LENGTH(search_by.Phone10) = 7 AND (INTEGER) search_by.Phone10 <> 0 => search_by.Phone10,
                           LENGTH(search_by.Phone10) = 10 AND (INTEGER)(search_by.Phone10[4..10]) <> 0 => search_by.Phone10,
                           '');

  #STORED ('phone', validPhone);

  fname_was_input := TRIM(search_by.name.first) <> '';
  lname_doesnt_look_like_a_biz := ut.Word(search_by.lastnameorcompany,2,' ') = '';//only has 1 word

  SHARED EntityType := MAP(fname_was_input
                          AND lname_doesnt_look_like_a_biz //IF it looks like a person
                          AND search_by.EntityType <> Constants.TAG_ENTITY_BIZ //then we can assume they are looking for a person AND NOT a business (unless specified otherwise)
                          => Constants.TAG_ENTITY_IND,
                          search_by.EntityType = Constants.TAG_ENTITY_IND
                          OR search_by.EntityType = Constants.TAG_ENTITY_BIZ
                          OR search_by.EntityType = Constants.TAG_ENTITY_UNK
                          => search_by.EntityType,
                          Constants.TAG_ENTITY_UNK
                          );
 // pack input parameters into a module
  SHARED inputmod := AutoStandardI.GlobalModule();

  SHARED search_inputs := MODULE(SearchParams)
    EXPORT nameQueryInputs := IF (powersearch <> '', ps_name, search_by_name);
    EXPORT addrQueryInputs := addr_out;
    EXPORT phoneQueryInput := validPhone;
  END;

  // *** Do a person search
  EXPORT PersonSearch := MODULE

   PSearchMod := MODULE( PROJECT( inputmod, mod_Params.PersonSearch, opt))
                 END;

   header_res := mod_Searches.personSearch.records(PSearchMod);

   // *** Penalize person search results
   header_res_pen := mod_Score(search_inputs).score(header_res);

   // do not do a person search if we're searching businesses
   EXPORT records := IF (EntityType = Constants.TAG_ENTITY_BIZ,
                         DATASET( [], RECORDOF(header_res_pen)),
                         header_res_pen);
  END;

  EXPORT BusinessSearch := MODULE

    // Do a business search
    BSearchMod := MODULE (PROJECT (inputmod, mod_Params.BusinessSearch, opt))
    END;

    biz_res := ups_services.mod_Searches.businessSearch.records(search_inputs,BSearchMod);

    // Penalize business search results
    biz_res_pen := mod_Score(search_inputs).score(biz_res);

    // don't do a business search if we're searching individuals
    EXPORT records := IF (EntityType = Constants.TAG_ENTITY_IND,
                          DATASET( [], RECORDOF(biz_res_pen)),
                          biz_res_pen);
  END;

  EXPORT FedExSearch := MODULE

    fedex_raw := Fedex_Services.mod_Searches.FedexNoHit;
    fedex_sort := SORT(fedex_raw, company_name, lname, fname, mname, prim_range, prim_name, zip5, -dt_last_seen);
    fedex_dedup := DEDUP(fedex_sort, company_name, lname, fname, mname, prim_range, prim_name, zip5);


     fedex_filtered := MAP (EntityType = Constants.TAG_ENTITY_IND => fedex_dedup(TRIM(business_indicator) <> 'Y'),
                           EntityType = Constants.TAG_ENTITY_BIZ => fedex_dedup(TRIM(business_indicator) = 'Y'),
                           fedex_dedup ) ;
     fedex_format := PROJECT(fedex_filtered,
      TRANSFORM(UPS_Services.layout_Common,
        SELF.rollup_key := LEFT.fakeid;
        SELF.rollup_key_type := Constants.TAG_ROLLUP_KEY_FAKEID,
        SELF.phone := LEFT.phone,
        SELF.fname := LEFT.fname,
        SELF.mname := LEFT.mname,
        SELF.lname := LEFT.lname,
        SELF.company_name := LEFT.company_name,
        SELF.prim_range := LEFT.prim_range,
        SELF.predir := LEFT.predir ,
        SELF.prim_name := LEFT.prim_name,
        SELF.suffix := LEFT.addr_suffix,
        SELF.sec_range := LEFT.sec_range ,
        SELF.city_name := LEFT.p_city_name,
        SELF.state := LEFT.state,
        SELF.zip := LEFT.zip5,
        SELF.dt_first_seen := 0,
        SELF.dt_last_seen := (UNSIGNED4) LEFT.dt_last_seen,
        SELF.listing_type := IF(TRIM(LEFT.business_indicator) = 'Y','B','R');
        // assumption , need to check if they have any non current records here.
        SELF.Current := 'Y';
        //self.history_flag;
        SELF := LEFT,
        SELF := []));

      fedex_pen := mod_Score(search_inputs).score(fedex_format);

      EXPORT records := fedex_pen;

  END;


  EXPORT CanadaSearch := MODULE

   // Do a Canada Address search

   // Gets raw records (canadianphones_V2) without penalty calculated.
   can_res := Can_PH.GetRawRecords(TRUE);
   can_res_sort := SORT(can_res, phonenumber, lastname, firstname, middlename, housenumber, streetname, postalcode, -date_last_reported);
   can_res_dedup := DEDUP(can_res_sort, phonenumber, lastname, firstname, middlename, housenumber, streetname, postalcode);


   can_res_filtered := MAP (EntityType = Constants.TAG_ENTITY_IND => can_res(TRIM(Listing_Type) = 'R'),
                           EntityType = Constants.TAG_ENTITY_BIZ => can_res(TRIM(Listing_Type) = 'B'),
                           can_res_sort);

   can_res_format := PROJECT(can_res_filtered,
    TRANSFORM(UPS_Services.layout_Common,
      SELF.rollup_key := LEFT.fdid;
      SELF.rollup_key_type := Constants.TAG_ROLLUP_KEY_FDID,
      SELF.phone := LEFT.phonenumber,
      SELF.fname := LEFT.firstname,
      SELF.mname := LEFT.middlename,
      SELF.lname := LEFT.lastname,
      SELF.company_name := LEFT.company_name,
      SELF.prim_range := LEFT.housenumber,
      SELF.predir := LEFT.directional ,
      SELF.prim_name := LEFT.streetname,
      SELF.suffix := LEFT.streetsuffix,
      SELF.sec_range := LEFT.suitenumber ,
      SELF.city_name := LEFT.city,
      SELF.state := LEFT.province,
      SELF.zip := LEFT.postalcode,
      SELF.dt_first_seen := (UNSIGNED4) LEFT.date_first_reported,
      SELF.dt_last_seen := (UNSIGNED4) LEFT.date_last_reported,
      SELF := LEFT,
      SELF := []));

   can_res_pen := mod_Score(search_inputs).score(can_res_format);

   EXPORT records := can_res_pen;
  END;


  // note that number of records returned here are limited in mod_Searches to
  // iesp.Constants.MAX_SEARCH_RESULTS for each individuals and businesses.

  permissions := AutoStandardI.DataPermissionI.val(PROJECT(inputmod, AutoStandardI.DataPermissionI.params));
  us_person_business_fedex_records := IF(permissions.use_FedExData,FedExSearch.records);
  us_person_records_pre := PersonSearch.records + us_person_business_fedex_records(company_name = '');
  us_person_records := UPS_Services.fn_CurrentPersonAddressLookup(us_person_records_pre);
  us_business_records := BusinessSearch.records + us_person_business_fedex_records(company_name <> '');
  us_records_pre := us_person_records + us_business_records;
  us_records := UPS_Services.fn_AdvoLookup(us_records_pre);
  can_records := CanadaSearch.records;

  #IF(Debug.debug_flag)
    OUTPUT(search_by_name, NAMED('SearchByName'));
    OUTPUT(validPhone, NAMED('SearchByPhone'));
    OUTPUT(ps_name, NAMED('psName'));
    OUTPUT(ps_phone, NAMED('psPhone'));
    OUTPUT(FedExSearch.records, NAMED('FedExSearch'));
    OUTPUT(permissions.use_FedExData, NAMED('use_FedExData'));
  #END



  EXPORT records := IF(isCanada,can_records,us_records);

  EXPORT rolled_records := mod_Rollup(search_inputs).roll(records, inputmod.MaxResults);

  MaxNumPhoneSubjectPre := (INTEGER)search_options.MaxNumPhoneSubject;
  TrueMaxNumPhoneSubject := MAP(MaxNumPhoneSubjectPre > 3 => 3, // MAX is 3
                                MaxNumPhoneSubjectPre = 0 => 3, // default is 3
                                MaxNumPhoneSubjectPre < 0 => 0, // internal testing to turn off WFP
                                MaxNumPhoneSubjectPre);

  PSearchMod := MODULE( PROJECT( inputmod, mod_Params.PersonSearch, opt))
      EXPORT STRING20 PhoneScoreModel := IF(TRIM(search_options.PhoneScoreModel)='','PHONESCORE_V2' ,search_options.PhoneScoreModel );
      EXPORT INTEGER MaxNumPhoneSubject := TrueMaxNumPhoneSubject ;
  END;

  // Choose top 5 DIDs
  temp_rec := RECORDOF(rolled_records);

  temp_rec xrollup(temp_rec l , temp_rec r) := TRANSFORM
   SELF := IF(l.score > r.score, l, r );
  END;
  QualifyingRecords := rolled_records(score > UPS_Services.Constants.SCORE_THRESHOLD_WATERFALL_PHONES AND
                                      EntityType = UPS_Services.Constants.TAG_ENTITY_IND);
  RollupAndTopScoreUp := SORT(ROLLUP(QualifyingRecords,LEFT.UniqueID = RIGHT.UniqueID,
                              xrollup(LEFT,RIGHT) ),-score);

  topDids := PROJECT(CHOOSEN(RollupAndTopScoreUp,5),
              TRANSFORM(doxie.layout_references_hh,
                SELF.DID := (UNSIGNED) LEFT.UniqueID));

  BOOLEAN doWaterfallPhones := EXISTS(topDids) AND ~isCanada AND TrueMaxNumPhoneSubject > 0;

  wfpRecords := IF( doWaterfallPhones, UPS_Services.fn_WaterfallPhonesLookup(topDids,PSearchMod));

  rolled_records_with_phones := IF(doWaterfallPhones,
    JOIN(rolled_records, wfpRecords,
      ~isCanada AND LEFT.EntityType = UPS_Services.Constants.TAG_ENTITY_IND AND
      LEFT.score > UPS_Services.Constants.SCORE_THRESHOLD_WATERFALL_PHONES AND
      LEFT.UniqueID = (STRING)RIGHT.DID,
        TRANSFORM(RECORDOF(rolled_records),
          firstAddress := LEFT.Addresses[1];
          phones := PROJECT(RIGHT.phones,TRANSFORM(iesp.rightaddress.t_HighlightedPhoneInfo,
                            SELF.phone10 := LEFT.phone10, SELF := [])) +
                            firstAddress.phones;
          firstAddressWithPhones := PROJECT(firstAddress,TRANSFORM(iesp.rightaddress.t_RAAddressWithPhones,
                                    SELF.phones := phones, SELF := LEFT ));

          SELF.addresses := firstAddressWithPhones + CHOOSEN(LEFT.Addresses,all,2),
          SELF := LEFT), 
    LEFT OUTER,LIMIT(0),KEEP(1)),
    rolled_records);

 rolled_records_with_phones_dedup := PROJECT(rolled_records_with_phones,
                                       TRANSFORM(RECORDOF(rolled_records_with_phones),
                                         SELF.Addresses := PROJECT(LEFT.Addresses, TRANSFORM(iesp.rightaddress.t_RAAddressWithPhones,
                                                             SELF.Phones := DEDUP(SORT(LEFT.Phones, phone10), phone10),
                                                             SELF := LEFT));,
                                         SELF := LEFT
                                       ));

  BOOLEAN doHighlight := search_options.highlight;
  EXPORT highlighted_records_with_phones := IF(doHighlight, mod_Highlight(search_inputs).doBest(rolled_records_with_phones_dedup), rolled_records_with_phones_dedup);

  //**** START TEMP DEMO CODE FOR CUSTOMER REVIEW
  //**** This is temp because, if they want this behavior, we need to do the filtering much earlier.
  #STORED('DemoMode',search_options.DemoMode);
  #STORED('DemoModeEditDistance',search_options.DemoModeEditDistance);
  inDemoMode := FALSE : STORED('DemoMode');
  inEditDistanceAllowed := 1 : STORED('DemoModeEditDistance');

  iesp.share.t_Address MA() := TRANSFORM
   SELF.StreetName := UPS_Services.mod_Address(search_by.address,isCanada).bestparser().StreetName;
   SELF.StreetNumber:= UPS_Services.mod_Address(search_by.address,isCanada).bestparser().StreetNumber;
   SELF := search_by.address
  END;

  Addr := DATASET([MA()])[1];

 filtered_records_pre := IF(inDemoMode,
                            UPS_Services.mod_Filter(recs := highlighted_records_with_phones,
                                                    inName := UPS_Services.mod_Names(search_by).bestparser(),
                                                    inAddr := Addr,
                                                    inPhone := validPhone,
                                                    powersearch := powersearch,
                                                    EditDistanceAllowed0 := inEditDistanceAllowed
                                                    ).results,
                            highlighted_records_with_phones
                            );

 filtered_records := IF(isZipSearch,DATASET([],iesp.rightaddress.t_RightAddressSearchRecord),filtered_records_pre);


 iesp.ECL2ESP.Marshall.MAC_Marshall_Results(filtered_records , response, iesp.rightaddress.t_RightAddressSearchResponse,
                                              ,,,ZipPostalLookup,zip_only_response);

  //***** END TEMP DEMO CODE

  // build a soap response and returns a single result row.
  // iesp.ECL2ESP.Marshall.MAC_Marshall_Results(highlighted_records, response, iesp.rightaddress.t_RightAddressSearchResponse); //UNCOMMENT THIS WHEN TEMP DEMO CODE IS GONE


  // export soap_response := project(response,
                                  // transform(iesp.rightaddress.t_RightAddressSearchResponse),
                                              // self := left,
  EXPORT soap_response := response;

END;
