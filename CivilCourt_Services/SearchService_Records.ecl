IMPORT AutoStandardI,civilCourt_Services,civil_Court,iesp, ut, Address, doxie, NID, D2C, STD;

EXPORT SearchService_Records := MODULE

  EXPORT params := INTERFACE(civilCourt_Services.SearchService_IDs.params)
     EXPORT STRING120 unparsedFullName := '';
     EXPORT STRING30 firstname := '';
     EXPORT STRING30 middlename := '';
     EXPORT STRING30 lastname := '';
     EXPORT STRING25 city_in :='';
     EXPORT STRING2 state_in := '';
     EXPORT STRING60 jurisdiction_in := '';
     EXPORT STRING120 CompanyName := '';
  END;

  EXPORT val(params in_mod) := FUNCTION
  
    fullName := Address.CleanNameFields(Address.CleanPerson73(in_mod.unparsedFullName));
    
    unparsedFullNameNotFilled := IF (TRIM(in_mod.unparsedFullName, LEFT,RIGHT) = '', TRUE, FALSE);
  
    trim_companyname := STD.STR.ToUpperCase(TRIM(in_mod.companyName,LEFT,RIGHT));
    trim_firstname := IF (unparsedFullNameNotFilled, STD.STR.ToUpperCase(TRIM(in_mod.firstname,LEFT,RIGHT)),
      STD.STR.ToUpperCase(TRIM(fullName.fname, LEFT, RIGHT)));
    trim_lastname := IF (unparsedFullNameNotFilled, STD.STR.ToUpperCase(TRIM(in_mod.lastname,LEFT,RIGHT)),
      STD.STR.ToUpperCase(TRIM(fullName.lname, LEFT, RIGHT)));    
    trim_middlename := IF (unparsedFullNameNotFilled, STD.STR.ToUpperCase(TRIM(in_mod.middlename,LEFT,RIGHT)),
      STD.STR.ToUpperCase(TRIM(fullName.mname, LEFT, RIGHT)));
                                                                                                                                               
    trim_jurisdiction := STD.STR.ToUpperCase(TRIM(in_mod.jurisdiction_in,LEFT,RIGHT));
    trim_state_tmp := STD.STR.ToUpperCase(TRIM(in_mod.state_in,LEFT,RIGHT));
    trim_state := IF (trim_state_tmp = '', STD.STR.ToUpperCase(TRIM(in_mod.state,LEFT,RIGHT)),trim_state_tmp);
    trim_city_tmp := STD.STR.ToUpperCase(TRIM(in_mod.city_in,LEFT,RIGHT));
    trim_city := IF (trim_city_tmp = '', STD.STR.ToUpperCase(TRIM(in_mod.city,LEFT,RIGHT)),trim_city_tmp);
    nicknamesON := AutoStandardI.InterfaceTranslator.nicknames.val(PROJECT(in_mod,
      AutoStandardI.InterfaceTranslator.nicknames.params));
    strictMatchOn := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(PROJECT(in_mod,
      AutoStandardI.InterfaceTranslator.strictMatch_value.params));
    phoneticsOn := AutoStandardI.InterfaceTranslator.Phonetics.val(PROJECT(in_mod,
      AutoStandardI.InterfaceTranslator.phonetics.params));
    industryclass := AutoStandardI.InterfaceTranslator.industry_class_value.val(PROJECT(in_mod,
      AutoStandardI.InterfaceTranslator.industry_class_value.params));
    
    // Get the IDs, pull the payload records and add Aircraft_number (n_number to them.
    ids := civilCourt_Services.SearchService_IDs.val(in_mod);
    
    // join to payload key.
    recs := JOIN(ids, civil_court.key_caseID,
      KEYED(LEFT.case_key = RIGHT.case_key) AND
      (~ut.IndustryClass.is_Knowx OR RIGHT.vendor NOT IN D2c.Constants.CivilCourtRestrictedSources),
      TRANSFORM(civilCourt_Services.Layouts.PartyLayoutPlusSlim,
        SELF:=RIGHT, // SET for use later.
        SELF := []),
      LIMIT(iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS, SKIP));
                                  
    recs_company_slim_rework := IF (trim_companyName <> '', 
      PROJECT(recs, TRANSFORM(civilCourt_services.layouts.partyLayoutPlusSlim,
        SELF.e1_cname1 := IF (LEFT.e1_lname1 = '' AND LEFT.e1_cname1 <> '', LEFT.e1_cname1,
          IF (LEFT.v1_cname1 <> '' AND LEFT.e1_lname1 = '', LEFT.v1_cname1, LEFT.e1_cname1));
        SELF := LEFT)), 
      recs);
    recs_slim := IF (trim_companyName <> '',
      recs_company_slim_rework( 
        (STD.STR.Find(v1_cname1,trim_companyname,1) > 0) OR
        (STD.STR.Find(e1_cname1,trim_companyname,1) > 0) OR
        (STD.STR.Find(v2_cname1,trim_companyname,1) > 0) OR
        (STD.STR.Find(e2_cname1,trim_companyname,1) > 0)),
      recs_company_slim_rework);
    // in case just the v1_lname1 and v2_lname1 field are populated and not e.g. e1_lname1
    // then move info from that field into the e1_* field so filtering is easier farther down.
    recs_person_slim_rework := IF (trim_lastname <> '', 
      PROJECT(recs_slim, TRANSFORM(civilCourt_services.layouts.partyLayoutPlusSlim,
        BOOLEAN v1_field_pop := IF (LEFT.v1_lname1 <> '', TRUE, FALSE);
        BOOLEAN v2_field_pop := IF (LEFT.v2_lname1 <> '', TRUE, FALSE);
        SELF.e1_lname1 := IF (
          LEFT.e1_lname1 = '' AND LEFT.e1_cname1 = '' AND v1_field_pop
            AND (STD.STR.Find(LEFT.v1_lname1, trim_lastname, 1) > 0) , LEFT.v1_lname1,
          IF (LEFT.e1_lname1 = '' AND LEFT.e1_cname1 = '' AND v2_field_pop
            AND (STD.STR.Find(LEFT.v2_lname1, trim_lastname, 1) > 0) , LEFT.v2_lname1, 
          LEFT.e1_lname1));
        SELF.e1_mname1 := IF (
          LEFT.e1_mname1 = '' AND LEFT.e1_cname1 = '' AND v1_field_pop
            AND (STD.STR.Find(LEFT.v1_lname1, trim_lastname, 1) > 0), LEFT.v1_mname1,
          IF (LEFT.e1_mname1 = '' AND LEFT.e1_cname1 = '' AND v2_field_pop
            AND (STD.STR.Find(LEFT.v2_lname1, trim_lastname, 1) > 0), LEFT.v2_mname1, 
          LEFT.e1_mname1));
        SELF.e1_fname1 := IF (
          LEFT.e1_fname1 = '' AND LEFT.e1_cname1 = '' AND v1_field_pop
            AND (STD.STR.Find(LEFT.v1_lname1, trim_lastname, 1) > 0) , LEFT.v1_fname1,
          IF (LEFT.e1_fname1 = '' AND LEFT.e1_cname1 = '' AND v2_field_pop
            AND (STD.STR.Find(LEFT.v2_lname1, trim_lastname, 1) > 0), LEFT.v2_fname1, 
          LEFT.e1_fname1));
        SELF.e1_suffix1 := IF (
          LEFT.e1_fname1 = '' AND LEFT.e1_cname1 = '' AND v1_field_pop
            AND (STD.STR.Find(LEFT.v1_lname1, trim_lastname, 1) > 0), LEFT.v1_suffix1,
          IF (LEFT.e1_fname1 = '' AND LEFT.e1_cname1 = '' AND v2_field_pop
            AND (STD.STR.Find(LEFT.v2_lname1, trim_lastname, 1) > 0), LEFT.v2_suffix1, 
          LEFT.e1_suffix1));
        SELF := LEFT)), 
      recs_slim);
                                  
    // filter out last names
    recs_person_slim := IF (trim_firstname <> '' OR trim_lastname <> '',
      recs_person_slim_rework((e1_lname1=trim_lastname) OR
        (phoneticsOn AND (metaphonelib.DMetaPhone1(e1_lname1)[1..6] =
          metaphonelib.DMetaPhone1(trim_lastname)[1..6])))
      , recs_person_slim_rework);
    
    // filter out first names
    recs_person_slim_fname := IF (trim_firstname <> '',
      recs_person_slim(e1_fname1=trim_firstname OR
        ((nicknamesON AND NID.mod_PFirstTools.PFLeqPFR(TRIM(e1_fname1,LEFT,RIGHT), trim_firstname))))
      , recs_person_slim);
   
    // filter out middle name
    recs_person_slim_mname := IF (trim_middlename <> '' ,
      recs_person_slim_fname((e1_mname1=trim_middlename AND strictMatchOn)
        OR (e1_mname1[1]=trim_middlename[1] AND (~(strictMatchOn)))
        OR (v2_mname1=trim_middlename AND e1_mname1[1]=trim_middlename[1] AND (~(strictMatchOn)))
      ), recs_person_slim_fname);
    
    // now get the other parties from each particular case and filter based on search criteria
    function_recs := JOIN(recs_person_slim_mname, civil_court.key_caseID,
      KEYED(LEFT.case_key = RIGHT.case_key) AND
      (~ut.IndustryClass.is_Knowx OR RIGHT.vendor NOT IN D2c.Constants.CivilCourtRestrictedSources),
      TRANSFORM(civilCourt_Services.Layouts.PartyLayoutPlus, SELF:=RIGHT), 
      LIMIT(iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS, SKIP));
                                 
   // grab all the recs that do have a case_title
   case_title_filter := function_recs(case_title <> '');
   
   // need to filter on any cases that do not have input in the case title and then look through
   // that set and output just recs that have input criteria in the party name
    case_title_filter_slim_nocontain_fnamelname := IF (trim_firstname <> '' AND trim_lastname <> '',
      case_title_filter(~((STD.STR.Find(case_title, trim_firstname,1) > 0) AND
                          (STD.STR.Find(case_title, trim_lastname, 1) > 0))),
      case_title_filter);
    // first filter the recs that DO NOT have input criteria in the title to see which ones to keep use this attr later.
    case_title_filter_slim_nocontain_tmp := IF (trim_firstname <> '' AND trim_lastname <> '',
      case_title_filter_slim_nocontain_fnamelname(
        (
          (STD.STR.Find(entity_1, trim_firstname, 1) > 0) AND (STD.STR.Find(entity_1, trim_lastname, 1) > 0))
          OR 
          ( 
            (nicknamesOn) AND
            (STD.STR.Find(entity_1, NID.PreferredFirstNew(trim_firstname),1) > 0 OR
              STD.STR.Find(entity_1, NID.PreferredFirstNew(trim_firstname, FALSE),1) > 0) AND
            (STD.STR.Find(entity_1, trim_lastname, 1) > 0)
          )
          OR
          (
            PhoneticsOn AND
            (STD.STR.Find(entity_1, metaphonelib.DMetaPhone1(trim_lastname)[1..6],1) > 0) AND
            (STD.STR.Find(entity_1, trim_firstname, 1) > 0)
          )
        )
      , case_title_filter_slim_nocontain_fnamelname);
                                                                 
    // now get list of recs that do have fname/lname criteria in title
    // and if its in title thus need to keep all parties (i.e. recs) for this particular case_id
    case_title_filter_slim_contain_fnamelastname := IF (trim_firstname <> '' AND trim_lastname <> '',
      case_title_filter(
        ((STD.STR.Find(case_title, trim_firstname, 1) > 0) AND
          (STD.STR.Find(case_title, trim_lastname, 1) > 0))
        OR
        (
          (nicknamesOn) AND
          (STD.STR.Find(case_title, NID.PreferredFirstNew(trim_firstname),1) > 0 OR
            STD.STR.Find(case_title, NID.PreferredFirstNew(trim_firstname, FALSE),1) > 0) AND
          (STD.STR.Find(case_title, trim_lastname, 1) > 0))
        OR
          (phoneticsOn AND 
          (STD.STR.Find(case_title, metaphonelib.DMetaPhone1(trim_lastname)[1..6],1) > 0) AND
          (STD.STR.Find(case_title, trim_firstname, 1) > 0))
        )
      , case_title_filter);
    // now add recs without input crit in title +
    // recs that have input crit in title otherwise just use recs with some kind of title.
    case_title_filter_slim := IF (trim_firstname <> '' AND trim_lastname <> '',
      case_title_filter_slim_nocontain_tmp + case_title_filter_slim_contain_fnamelastname,
      case_title_filter);
                                                       
    case_title_company_entity1_filter := IF (strictMatchOn,
        function_recs(STD.STR.Find(ut.CleanCompany(e1_cname1),
          ut.cleanCompany(trim_companyName), 1) > 0),
        function_recs(STD.STR.Find(entity_1, trim_companyName, 1) > 0));

    // check for strict match and filter on company name if its on
    // otherwise filter on case title
    case_title_company_filter := IF (strictMatchOn,
        function_recs(STD.STR.Find(e1_cname1,ut.cleanCompany(trim_companyName),1) > 0),
        function_recs(STD.STR.Find(case_title, trim_companyName, 1) > 0));
   
    // get the recs that do NOT have a case title and then futher filter on these.
    case_title_blank_filter := function_recs(case_title = '');
    
    case_title_blank_filter_slim_firstname := IF (trim_firstname <> '',
        case_title_blank_filter(( e1_fname1=trim_firstname) OR
          (nicknamesON AND (NID.mod_PFirstTools.PFLeqPFR(e1_fname1,trim_firstname)))),
        case_title_blank_filter);
                                                  
    case_title_blank_filter_slim_middlename := IF (trim_middlename <> '',
      case_title_blank_filter_slim_firstname(
        (e1_mname1=trim_middlename AND strictMatchOn)
        OR
        (e1_mname1[1]=trim_middlename[1] AND ~(strictMatchOn))),
      case_title_blank_filter_slim_firstname);

    case_title_blank_filter_slim_lastname := IF (trim_lastname <> '',
      case_title_blank_filter_slim_middlename((e1_lname1=trim_lastname) OR
        (phoneticsOn AND (metaphonelib.DMetaPhone1(e1_lname1)[1..6] =
                          metaphonelib.DMetaPhone1(trim_lastname)[1..6]))),
      case_title_blank_filter_slim_middlename);
                                                          
    // case where there is company criteria in the search
    // get recs that have no case title but do have company name in the record and it matches input criteria
    // also check for strict match
    case_title_blank_filter_slim_companyname :=
      IF (trim_companyname <> '',
        IF (StrictMatchOn,
          case_title_blank_filter(ut.CleanCompany(e1_cname1)=ut.CleanCompany(trim_companyName)),
          case_title_blank_filter(e1_cname1=trim_companyName)),
        case_title_blank_filter);

    //
    // 1st check for name criteria matching and then company criteria matching
    //
    // NOTE: doesn't ever return case of just case_title_filter as there
    // will always be some kind of name search or company search
    // NOTE1: temp_function_set still could be just same as case_title_filter_slim
    // cause case_title_filter_slim might be same as case_title_filter
    temp_function_set := IF ((trim_firstname <> '' OR trim_middlename <> '' OR trim_lastname <> ''),
      case_title_filter_slim + case_title_blank_filter_slim_lastname,
      IF (trim_companyname <> '',
        case_title_company_entity1_filter + case_title_company_filter +
          case_title_blank_filter_slim_companyname,
        case_title_filter_slim)
      );

    //make this a dummy value so that if not both state/city input it doesn't impact result set.
    zip_match := IF (trim_state <> '' AND trim_city <> '',
      zipLib.CityToZip5(trim_state, trim_city), 'AAAAA');
                                                        
    temp_function_slim_state := IF (trim_state <> '',
      temp_function_set(STD.STR.ToUpperCase(state_origin) = trim_state OR STD.STR.ToUpperCase(st1) = trim_state),
      temp_function_set);
                             
    temp_function_slim_city := IF (trim_city <> '',
      temp_function_slim_state(STD.STR.ToUpperCase(v_city_name1) = trim_city OR zip1 = zip_match),
      temp_function_slim_state);
    
    temp_function_jurisdiction_slim := IF (trim_jurisdiction <> '',
      temp_function_slim_city((STD.STR.Find(STD.STR.ToUpperCase(court), trim_jurisdiction,1) > 0)),
      temp_function_slim_city);
         
    temp_function_slim_dedup := DEDUP(SORT(temp_function_jurisdiction_slim,
      e1_lname1, e1_fname1, state_origin,
      case_key,
      case_type, entity_type_description_1_orig, entity_1),
      e1_lname1, e1_fname1, state_origin,
      case_key,
      case_type, entity_type_description_1_orig, entity_1);
    // Format for output
        
    recs_fmt := civilCourt_Services.Functions.fnCivilCourtSearchval(temp_function_slim_dedup);
    recs_final := PROJECT(CHOOSEN(recs_fmt,iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS),
      iesp.civilcourt.t_CivilCourtSearchRecord);
    //output(recs_fmt,named('recs_fmt'));
    // output(recs,named('SSR_recs'));
    // output(recs_person_slim_mname,named('SSR_recs_person_slim_mname'));
    
    ////
    // output(recs,named('recs'));
    // output(recs_company_slim_rework,named('recs_company_slim_rework'));
     // output(recs_slim, named('recs_slim'));
    // output(recs_person_slim, named('recs_person_slim'));
    // output(recs_person_slim_rework, named('recs_person_slim_rework'));
    // output(recs_person_slim_fname,named('recs_person_slim_fname'));
     //output(recs_person_slim_mname,named('recs_person_slim_mname'));
     // output(function_recs,named('function_recs'));
     // output(temp_function_set,named('temp_function_set'));
    
    // output(case_title_filter,named('case_title_filter'));
     // output(case_title_filter_slim_nocontain_fnamelname, named('case_title_filter_slim_nocontain_fnamelname'));
     // output(case_title_filter_slim_nocontain_tmp, named('case_title_filter_slim_nocontain_tmp'));
     // output(case_title_filter_slim_contain_fnamelastname, named('case_title_filter_slim_contain_fnamelastname'));
    
    // output(case_title_filter_slim,named('case_title_filter_slim'));
    
     // output(case_title_company_entity1_filter,named('case_title_company_entity1_filter'));
     // output(case_title_blank_filter_slim_companyname,named('case_title_blank_filter_slim_companyname'));
    // output(case_title_company_filter,named('case_title_company_filter'));
    
    // output(case_title_blank_filter,named('case_title_blank_filter'));
    // output(case_title_blank_filter_slim_lastname ,named('case_title_blank_filter_slim_lastname'));
     //output(case_title_blank_filter_slim_companyname,named('case_title_blank_filter_slim_companyname'));
    // output(temp_function_slim_state, named('temp_function_slim_state'));
    // output(temp_function_slim_city, named('temp_function_slim_city'));
    
    // output(temp_function_slim_city,named('temp_function_slim_city'));
    // output(temp_function_jurisdiction_slim,named('temp_function_jurisdiction_slim'));
    //output(temp_function_slim_dedup, named('temp_function_slim_dedup'));
    //output(in_mod.state_in,named('inmodstatein'));
    //output(trim_state,named('trim_state'));
    
    // output(temp_function_slim_dedup, named('temp_function_slim_dedup'));
      /////
    // output(case_title_filter_slim_lastname,named('case_title_filter_slim_lastname'));
    // output(case_title_filter_slim_firstname,named('case_title_filter_slim_firstname'));
    // output(case_title_filter_slim_middlename,named('case_title_filter_slim_middlename'));
    //output(function_recs_slim,named('function_recs_slim'));
    //output(name_filter,named('SSR_name_filter'));
    //output(nicknames,named('nicknames'));
    // output(fullName.fname);
    // output(fullName.mname);
    // output(fullName.lname);
    // output(fullName);
    // output(unparsedFullNameFilled);
     // output(trim_jurisdiction,named('trim_jurisdiction'));
     // output(trim_companyname,named('trim_companyname'));
    
    RETURN recs_final;
    END;
END;
