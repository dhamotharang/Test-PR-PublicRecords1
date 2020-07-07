IMPORT $, doxie, ut, codes, iesp, std;
IMPORT AutoStandardI, VehicleV2_Services, Autokey_batch, CriminalRecords_Services;
IMPORT VehicleV2, VehicleCodes, suppress, Census_Data, doxie_raw, MDR, Driversv2;


EXPORT Functions := MODULE;



  EXPORT STRING getSearchDataSource(VehicleV2_Services.IParam.polkParams in_mod, BOOLEAN doCombined) := FUNCTION
    /* doCombined = true Rules: if state with in list LOCAL_STATES_SEARCH,
      datasource should be local. If no state provided datasource should be
      all (local and realtime) unless the datasource in in_mod has value
      Constant.Local_val*/
      
    state := in_mod.state;

    IsLocalState := state IN Constant.LOCAL_STATES_SEARCH;
      
    datasource := IF (doCombined AND in_mod.datasource != Constant.Local_val
                        ,IF(isLocalState, Constant.LOCAL_VAL, Constant.All_val)
                        ,in_mod.datasource);
    
    RETURN DataSource;
  END;
  
/* Need to change this lic_plate_filter to FUNCTION instead of MODULE */
EXPORT lic_plate_filter_New(DATASET(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New) pre_DEDUP,UNSIGNED return_count,UNSIGNED starting_record,
    UNSIGNED penalt_threshold,UNSIGNED max_results, UNSIGNED in_LIMIT,UNSIGNED dppa_purpose,STRING1 state_type_val)
  := MODULE
  
    SORT_fields_rec := RECORD
    STRING30 Vehicle_Key;
    STRING15 Iteration_Key;
    STRING15 Sequence_Key;
    BOOLEAN is_current;
    UNSIGNED4 date;
    UNSIGNED2 party_penalty;
    STRING1 state_type;
    END;
    
    SORT_fields_rec get_penalt(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New l):=TRANSFORM
      SELF.party_penalty := doxie.FN_Tra_Penalty_SSN(l.use_ssn) +
              doxie.FN_Tra_Penalty_Name(l.fname,
                l.mname, l.lname)+
              doxie.FN_Tra_Penalty_Addr(l.predir,
                l.prim_range,
                l.prim_name,
                l.addr_suffix,
                l.postdir,
                l.sec_range,
                l.v_city_name,
                l.State_origin, l.zip5)+
                doxie.FN_Tra_Penalty_CName(l.append_clean_cname);
      SELF := l;
    END;
    
    
    w_penalt := PROJECT(pre_DEDUP,get_penalt(LEFT));

    srt_w_penalt := SORT(w_penalt,vehicle_key,iteration_key,sequence_key);
    
    w_penalt_group0 := GROUP(srt_w_penalt,vehicle_key,iteration_key,sequence_key);
    
    VehicleV2_Services.Mac_DppaCheck(w_penalt_group0,w_penalt_group)
    // Date and is_current should be unIForm across group within the key. This is because during key build
    // we only took the latest date per group and is current is always the same per group in the data
    
    SORT_fields_rec get_fields_trickle(w_penalt_group l, DATASET(RECORDOF(w_penalt_group)) r) :=TRANSFORM
      SELF.party_penalty :=MIN(r,party_penalty);
      SELF.state_type := MIN(r,state_type);
      SELF := l;
    END;



    veh_res_trickle0 := UNGROUP(ROLLUP(w_penalt_group,GROUP,get_fields_trickle(LEFT,rows(LEFT))));
        

    rep_w_seq :=RECORD
      veh_res_trickle0;
      UNSIGNED2 seq_srt;
      UNSIGNED2 seq_srt2 :=0;
    END;
    
    rep_w_seq add_seq(veh_res_trickle0 l,INTEGER C):=TRANSFORM
      SELF.seq_srt := C;
      SELF := l;
    END;
    
    
    // IF state type is 'A' that means moxie search with state_origin input so we only want records
    // where the state origin field matches. If state type is 'B' that means moxie search with state input
    // so we only want records where the state origin or the state fields match the input. This excludes
    // previously registered states
    state_type_set := IF(state_type_val='A',['A'],['A','B']);

    vehs_wseq0 := PROJECT(SORT(veh_res_trickle0(party_penalty < penalt_threshold AND (state_type_val='C' OR state_type in state_type_set) ),
      party_penalty,IF(is_current,0,1), -Date, - ((UNSIGNED) sequence_key[1..6])), add_seq(LEFT,COUNTER));

    rep_w_seq roll_seq(vehs_wseq0 l,vehs_wseq0 r):=TRANSFORM
      SELF.seq_srt := IF(l.vehicle_key=r.vehicle_key,l.seq_srt,r.seq_srt);
      SELF.seq_srt2 := r.seq_srt;
      SELF := r;
    END;
    
    vehs0 := ITERATE(SORT(vehs_wseq0,vehicle_key,seq_srt),roll_seq(LEFT,RIGHT));

    SHARED vehs1 := CHOOSEN(vehs0,max_results);
    
    SHARED vehs2 := CHOOSEN(SORT(vehs1, seq_srt,seq_srt2),
    return_Count,starting_Record);
    
    vehs3 := PROJECT(vehs2,TRANSFORM(Layout_VehKey_wseq,SELF:=LEFT,SELF.seq:=COUNTER));
    
    EXPORT recs := IF(in_LIMIT = 0,vehs3,CHOOSEN(vehs3,in_LIMIT));
    EXPORT cnt := COUNT(vehs1);

  END;
  

  SHARED Layout_Report_out_veh := RECORD
    Layout_Report_Vehicle;
    VehicleV2_Services.Layout_Vehicle_Key.Sequence_Key;
    Autokey_batch.Layouts.rec_inBatchMaster.acctno;
    BOOLEAN cnp_entered;
  END;
      
      
  
  
  SHARED MAC_Report_Out := MACRO
    best_major_color_desc := VehicleCodes.getColor(r.best_Major_Color_Code); // use keycodes instead?
    best_minor_color_desc := VehicleCodes.getColor(r.best_Minor_Color_Code);
    
    BrandCodeType1 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_1);
    BrandCodeType2 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_2);
    BrandCodeType3 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_3);
    BrandCodeType4 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_4);
    BrandCodeType5 := VehicleV2_Services.Exp_Code_Translations.get_brandType(r.brand_code_5);
    BrandDS := DATASET([{ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_1),r.brand_state_1,r.brand_code_1,BrandCodeType1},
                        {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_2),r.brand_state_2,r.brand_code_2,BrandCodeType2},
                        {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_3),r.brand_state_3,r.brand_code_3,BrandCodeType3},
                        {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_4),r.brand_state_4,r.brand_code_4,BrandCodeType4},
                        {ut.date_slashed_MMDDYYYY_to_YYYYMMDD(r.brand_date_5),r.brand_state_5,r.brand_code_5,BrandCodeType5}
                ],
                VehicleV2_Services.assorted_layouts.layout_brand);
    
    SELF.vin := IF(r.vina_vin<>'', r.vina_vin, r.orig_vin);
    SELF.series_desc := IF(r.VINA_Series_Desc<>'',r.VINA_Series_Desc,
                            IF(r.orig_series_desc[1..3] !='000',r.orig_series_desc,''));
    veh_type_desc := VehicleV2_Services.Polk_Code_Translations.Veh_Type_Description(r.Orig_Vehicle_Type_Code[1]);
    SELF.vehicle_type_desc := veh_type_desc;
    SELF.body_style_desc := r.VINA_Body_Style_Desc;
    SELF.major_color_desc := best_major_color_desc;
    SELF.minor_color_desc := best_minor_color_desc;
    SELF.VINA_VP_RESTRAINT_Desc := Codes.VEHICLE_REGISTRATION.VP_RESTRAINT(r.VINA_VP_Restraint);
    SELF.VINA_VP_AIR_CONDITIONING_Desc := codes.VEHICLE_REGISTRATION.VP_AIR_CONDITIONING(r.VINA_VP_AIR_CONDITIONING);
    SELF.VINA_VP_POWER_STEERING_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_STEERING(r.VINA_VP_POWER_STEERING);
    SELF.VINA_VP_POWER_BRAKES_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_BRAKES(r.VINA_VP_POWER_BRAKES);
    SELF.VINA_VP_Power_Windows_Desc := codes.VEHICLE_REGISTRATION.VP_POWER_WINDOWS(r.VINA_VP_Power_Windows);
    SELF.VINA_VP_Tilt_Wheel_Desc := codes.VEHICLE_REGISTRATION.VP_Tilt_Wheel(r.VINA_VP_Tilt_Wheel);
    SELF.VINA_VP_Roof_Desc := codes.VEHICLE_REGISTRATION.VP_ROOF(r.VINA_VP_Roof);
    SELF.VINA_VP_Optional_Roof1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF1(r.VINA_VP_Optional_Roof1);
    SELF.VINA_VP_Optional_Roof2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_ROOF2(r.VINA_VP_Optional_Roof2);
    SELF.VINA_VP_Radio_Desc := codes.VEHICLE_REGISTRATION.VP_RADIO(r.VINA_VP_Radio);
    SELF.VINA_VP_Optional_Radio1_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO1(r.VINA_VP_Optional_Radio1);
    SELF.VINA_VP_Optional_Radio2_Desc := codes.VEHICLE_REGISTRATION.VP_OPTIONAL_RADIO2(r.VINA_VP_Optional_Radio2);
    SELF.VINA_VP_Transmission_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.VINA_VP_Transmission);
    SELF.VINA_VP_Optional_Transmission1_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.VINA_VP_Optional_Transmission1);
    SELF.VINA_VP_Optional_Transmission2_Desc := codes.VEHICLE_REGISTRATION.VP_TRANSMISSION(r.VINA_VP_Optional_Transmission2);
    SELF.VINA_VP_Anti_Lock_Brakes_Desc := codes.VEHICLE_REGISTRATION.VP_ANTI_LOCK_BRAKES(r.VINA_VP_Anti_Lock_Brakes);
    SELF.VINA_VP_Front_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FRONT_WHEEL_DRIVE(r.VINA_VP_Front_Wheel_Drive);
    SELF.VINA_VP_Four_Wheel_Drive_Desc := codes.VEHICLE_REGISTRATION.VP_FOUR_WHEEL_DRIVE(r.VINA_VP_Four_Wheel_Drive);
    SELF.VINA_VP_Security_System_Desc := codes.VEHICLE_REGISTRATION.VP_SECURITY_SYSTEM(r.VINA_VP_Security_System);
    SELF.VINA_VP_Daytime_Running_Lights_Desc := codes.VEHICLE_REGISTRATION.VP_DAYTIME_RUNNING_LIGHTS(r.VINA_VP_Daytime_Running_Lights);
    SELF.BASE_PRICE := r.vina_price;
    SELF.fuel_type_name := codes.VEHICLE_REGISTRATION.FUEL_CODE(r.VINA_Fuel_Code);
    SELF.brands := (DEDUP(BrandDS, ALL))(brand_state <> '');
    SELF := r; // sets tod_flag for MVR combined DGL 2015
    SELF.state_origin_decoded :=codes.general.state_long(r.state_origin);
    SELF.is_deep_dive := l.is_deep_dive;
    SELF.Sequence_Key := l.Sequence_Key;
  ENDMACRO;
  
  SHARED Layout_Report_Out_Veh makeVehReport(Layout_Vehicle_Key l, VehicleV2.Key_Vehicle_Main_Key r) := TRANSFORM
    SELF.model_year := r.best_model_year;
    SELF.make_desc := IF(r.vina_make_desc != '',r.vina_make_desc,r.orig_make_desc);
    SELF.model_desc := IF(r.vina_model_desc != '',r.vina_model_desc,r.orig_model_desc);
    MAC_Report_Out();
    SELF := L;
    SELF := [];
  END;
  
  SHARED Layout_Report_Out_Veh makeVehSearch(Layout_VKeysWithInput l, VehicleV2.Key_Vehicle_Main_Key r, VehicleV2_Services.IParam.searchParams aInputData) := TRANSFORM
    
    make_description := IF(r.vina_make_desc != '',r.vina_make_desc,r.orig_make_desc);
    model_description := IF(r.vina_model_desc != '',r.vina_model_desc,r.orig_model_desc);
    STRING year_make := aInputData.ModelYear;
    STRING make_desc := aInputData.make;
    STRING model_desc := aInputData.model;
    model_year := r.best_model_year;
    SELF.model_year := IF(year_make = '' OR model_year = year_make, model_year,SKIP);

    SELF.make_desc := IF( std.str.ToUpperCase(make_description) = std.str.ToUpperCase(make_desc)[1..LENGTH(TRIM(make_description))] OR make_desc='',make_description,SKIP);
   
    SELF.model_desc := IF( std.str.ToUpperCase(model_description) = std.str.ToUpperCase(model_desc)[1..LENGTH(TRIM(model_description))] OR model_desc='',model_description,SKIP);
    MAC_Report_Out();
    SELF.cnp_entered := aInputData.companyname != ''
                  OR aInputData.lastname != ''
                  OR aInputData.firstname != '';
    SELF := L;
    SELF.Target_Sequence_Keys := [];
  END;

  // Keys
  SHARED keyVParty := VehicleV2.Key_Vehicle_Party_Key;
  SHARED keyCd3 := Codes.Key_Codes_V3;

  SHARED rec_party := RECORD
    VehicleV2_Services.Layouts.Layout_Report_Party_New;
    keyVParty.orig_lien_date;
    keyVParty.orig_name_type;
    keyVParty.vehicle_key;
    keyVParty.iteration_key;
    keyVParty.Source_Code;
    STRING70 std_lienholder_name;
    BOOLEAN HasCriminalConviction;
    BOOLEAN IsSexualOffender;
    STRING1 name_source_cd;
    STRING30 name_source;
    STRING8 title_issue_date;
    STRING17 title_number;
    STRING30 reported_name;
  END;
  
  SHARED rec_party_plus := RECORD (rec_party)
   UNSIGNED4 global_sid;
   UNSIGNED8 record_sid;
  END;

    // Constant
  SHARED STRING UNDER_AGE_LNAME := 'UNDERAGE INDIVIDUAL';
  SHARED STRING PARTY_T_INDV := 'I';
  SHARED STRING BLNK := '';
  SHARED STRING SP := ' ';

  ///// ======================== penalty functions ======================== /////
  SHARED penaltyCName(VehicleV2_Services.IParam.searchParams aInputData, STRING cnameFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full, OPT))
      EXPORT cname_field := cnameFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tm);
  END;

  SHARED penaltyDID(VehicleV2_Services.IParam.searchParams aInputData, STRING didFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_DID.full, OPT))
      EXPORT did_field := didFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tm);
  END;

  SHARED penaltySSN(VehicleV2_Services.IParam.searchParams aInputData, STRING ssnFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_SSN.full, OPT))
      EXPORT ssn_field := ssnFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(tm);
  END;

  SHARED penaltyName(VehicleV2_Services.IParam.searchParams aInputData, STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
      EXPORT fname_field := fnameFld;
      EXPORT mname_field := mnameFld;
      EXPORT lname_field := lnameFld;
      EXPORT allow_wildcard := allowWld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
  END;

  SHARED penaltyAddr(VehicleV2_Services.IParam.searchParams aInputData,
                STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
                STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
                STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = BLNK) := FUNCTION
      tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
        EXPORT allow_wildcard := allowWld;
        EXPORT city_field := cityFld;
        EXPORT city2_field := city2Fld;
        EXPORT pname_field := pnameFld;
        EXPORT postdir_field := postdirFld;
        EXPORT prange_field := prangeFld;
        EXPORT predir_field := predirFld;
        EXPORT state_field := stateFld;
        EXPORT suffix_field := suffixFld;
        EXPORT zip_field := zipFld;
        EXPORT sec_range_field := secRangeFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tm);
  END;
  
  SHARED partyPenaltyAddr(Layout_VKeysWithInput l, STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
                STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
                STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = BLNK) := FUNCTION
                
    addr := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
    
        // The 'input' address:
        EXPORT predir := l.predir;
        EXPORT prim_name := l.prim_name;
        EXPORT prim_range := l.prim_range;
        EXPORT postdir := l.postdir;
        EXPORT addr_suffix := l.addr_suffix;
        EXPORT sec_range := l.sec_range;
        EXPORT p_city_name := l.p_city_name;
        EXPORT st := l.st;
        EXPORT z5 := l.z5;
      
        // The address in the matching record:
        EXPORT allow_wildcard := allowWld;
        EXPORT city_field := cityFld;
        EXPORT city2_field := city2Fld;
        EXPORT pname_field := pnameFld;
        EXPORT postdir_field := postdirFld;
        EXPORT prange_field := prangeFld;
        EXPORT predir_field := predirFld;
        EXPORT state_field := stateFld;
        EXPORT suffix_field := suffixFld;
        EXPORT zip_field := zipFld;
        EXPORT sec_range_field := secRangeFld;
        EXPORT useGlobalScope := FALSE;
      END;
      RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(addr);
  END;
  
  SHARED penaltyBDID(IParam.searchParams aInputData, STRING bdidFld) := FUNCTION
    tm := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_BDID.full, OPT))
      EXPORT bdid_field := bdidFld;
    END;
    RETURN AutoStandardI.LIBCALL_PenaltyI_BDID.val(tm);
  END;
  ///// ======================== penalty FUNCTIONs end ======================== /////

  SHARED STRING70 ms(STRING70 a, STRING70 b, STRING70 c) :=
      MAP(a = BLNK => b,
          b = BLNK => a,
          ut.StringSimilar(a, c) <= ut.StringSimilar(b, c) => a,
          b);

  SHARED rec_party_plus get_parties_report ( keyVParty r, BOOLEAN minors_allowed) := TRANSFORM
    UNSIGNED1 age := IF(r.Orig_DOB = BLNK, 0, ut.age((INTEGER) r.Orig_DOB));
    BOOLEAN ofage := doxie.compliance.minor_ok(age, minors_allowed);
    SELF.history_desc := IF(ofage, Codes.VEHICLE_REGISTRATION.HISTORY_FLAG(r.History), BLNK);
    SELF.Append_DID := IF (ofage AND r.Append_DID != 0, INTFORMAT (r.Append_DID, 12, 1), BLNK);
    SELF.Append_BDID := IF(ofage AND r.Append_BDID != 0, INTFORMAT (r.Append_BDID, 12, 1), BLNK);
    SELF.party_penalty := 0;
    SELF.orig_sex_desc := IF(ofage, Codes.GENERAL.GENDER(r.Orig_Sex), BLNK);
    SELF.lname := IF(ofage, r.Append_Clean_Name.lname, UNDER_AGE_LNAME);
    SELF := IF(ofage, r.Append_Clean_Name);
    SELF := IF(ofage, r.Append_Clean_Address);
    SELF.age := IF(ofage, (STRING) age, BLNK);
    SELF.Vehicle_Key := r.Vehicle_Key;
    SELF.Iteration_Key := r.Iteration_Key;
    SELF.Sequence_Key := r.Sequence_Key;
    SELF.Orig_Name_Type := r.Orig_Name_Type;
    SELF := IF(ofage, r);
    SELF.County_Name := '';
    SELF.HasCriminalConviction := FALSE;
    SELF.IsSexualOffender := FALSE;
    SELF.reported_name := r.raw_name;
    SELF := r; //business ids /global_sid/record_sid
    SELF := [];
  END;
    
  // same as report but with penalty calculations; implemented as a function to minimize transform content
  SHARED rec_party_plus get_parties_search (Layout_VKeysWithInput l, keyVParty r,
    IParam.searchParams aInputData, BOOLEAN penalize_by_party_addr = FALSE) := FUNCTION

    aInputData_E2 := VehicleV2_Services.IParam.getSearchModule_entity2();
    
    rec_party_plus mTransform := TRANSFORM
      UNSIGNED1 age := IF(r.Orig_DOB = BLNK, 0, ut.age ((INTEGER) r.Orig_DOB));
      BOOLEAN ofage := doxie.compliance.minor_ok(age, aInputData.show_minors);
      
      //company name and its penalty
      STRING company := IF(r.Orig_Party_Type = PARTY_T_INDV, BLNK, TRIM(r.Orig_Name));
      comp_name_E1 := TRIM(aInputData.company);
      comp_name_E2 := TRIM(aInputData_E2.company);
      cname_penalty_E1 := penaltyCName(aInputData, company);
      cname_penalty_E2 := penaltyCName(aInputData_E2, company);
      penaltyCompany_E1 := IF(STD.STR.Find(company, SP + comp_name_E1 + SP, 1) > 0 OR
       std.str.Find(company, comp_name_E1 + SP, 1) = 1 OR
       std.str.Reverse(company)[1..LENGTH(comp_name_E1)+1] =std.str.Reverse(SP + comp_name_E1) OR
        ut.StringSimilar(company, aInputData.Company) = 0,
        IF(cname_penalty_E1 > 1, 1, cname_penalty_E1), cname_penalty_E1);
        
      penaltyCompany_E2 := IF(STD.STR.Find(company, SP + comp_name_E2 + SP, 1) > 0 OR
       std.str.Find(company, comp_name_E2 + SP, 1) = 1 OR
       std.str.Reverse(company)[1..LENGTH(comp_name_E2)+1] = std.str.Reverse(SP + comp_name_E2) OR
        ut.StringSimilar(company, aInputData_E2.Company) = 0,
        IF(cname_penalty_E2 > 1, 1, cname_penalty_E2), cname_penalty_E2);

      byparty_addr_penalty := partyPenaltyAddr(l,r.Append_Clean_Address.predir,
                                     r.Append_Clean_Address.prim_range,
                                     r.Append_Clean_Address.prim_name,
                                     r.Append_Clean_Address.addr_suffix,
                                     r.Append_Clean_Address.postdir,
                                     r.Append_Clean_Address.sec_range,
                                     ms(r.Orig_City, r.Append_Clean_Address.v_city_name, l.p_city_name),
                                     r.Orig_State, r.Append_Clean_Address.zip5);
      addr_penalty := penaltyAddr(aInputData,r.Append_Clean_Address.predir,
                                     r.Append_Clean_Address.prim_range,
                                     r.Append_Clean_Address.prim_name,
                                     r.Append_Clean_Address.addr_suffix,
                                     r.Append_Clean_Address.postdir,
                                     r.Append_Clean_Address.sec_range,
                                     ms(r.Orig_City, r.Append_Clean_Address.v_city_name, aInputData.city),
                                     r.Orig_State, r.Append_Clean_Address.zip5);

      computed_addr_penalty := IF(penalize_by_party_addr, byparty_addr_penalty, addr_penalty);
      
      //penalty E1 = single party search , E2 = two party search
      penalty_E1 := IF(NOT ofage, 0,
                      penaltyDID(aInputData,(STRING) r.Append_DID) +
                      penaltySSN(aInputData, ms(r.Orig_SSN, r.Append_SSN, aInputData.ssn)) +
                      penaltyName(aInputData, r.Append_Clean_Name.fname,
                                  r.Append_Clean_Name.mname,
                                  r.Append_Clean_Name.lname) +
                      computed_addr_penalty +
                      penaltyBDID(aInputData, (STRING) r.Append_BDID) +
                      penaltyCompany_E1);
      penalty_E2 := IF(NOT ofage, 0,
                      penaltyDID(aInputData_E2,(STRING) r.Append_DID) +
                      penaltySSN(aInputData_E2, ms(r.Orig_SSN, r.Append_SSN, aInputData_E2.ssn)) +
                      penaltyName(aInputData_E2, r.Append_Clean_Name.fname,
                                  r.Append_Clean_Name.mname,
                                  r.Append_Clean_Name.lname) +
                      penaltyAddr(aInputData_E2,r.Append_Clean_Address.predir,
                                  r.Append_Clean_Address.prim_range,
                                  r.Append_Clean_Address.prim_name,
                                  r.Append_Clean_Address.addr_suffix,
                                  r.Append_Clean_Address.postdir,
                                  r.Append_Clean_Address.sec_range,
                                  ms(r.Orig_City, r.Append_Clean_Address.v_city_name, aInputData_E2.city),
                                  r.Orig_State, r.Append_Clean_Address.zip5) +
                      penaltyBDID(aInputData_E2, (STRING) r.Append_BDID) +
                      penaltyCompany_E2);
                      
      raw_penalty := IF(AutoStandardI.GlobalModule().TwoPartySearch,MAX(penalty_E1,penalty_E2),penalty_E1);
      
      SELF.history_desc := IF(ofage, Codes.VEHICLE_REGISTRATION.HISTORY_FLAG(r.History), BLNK);
      SELF.Append_DID := IF(ofage AND r.Append_DID != 0, INTFORMAT (r.Append_DID, 12, 1), BLNK);
      SELF.Append_BDID := IF(ofage AND r.Append_BDID != 0, INTFORMAT (r.Append_BDID, 12, 1), BLNK);
      SELF.party_penalty := raw_penalty;
      SELF.orig_sex_desc := IF(ofage, Codes.GENERAL.GENDER(r.Orig_Sex), BLNK);
      SELF.lname := IF(ofage, r.Append_Clean_Name.lname, UNDER_AGE_LNAME);
      SELF := IF(ofage, r.Append_Clean_Name);
      SELF := IF(ofage, r.Append_Clean_Address);
      SELF.age := IF(ofage, (STRING) age, BLNK);
      SELF.Vehicle_Key := r.Vehicle_Key;
      SELF.Iteration_Key := r.Iteration_Key;
      SELF.Sequence_Key := r.Sequence_Key;
      SELF.Orig_Name_Type := r.Orig_Name_Type;
      SELF := IF(ofage, r);
      SELF.County_Name := '';
      SELF.reported_name := r.raw_name;
      SELF.HasCriminalConviction := FALSE;
      SELF.IsSexualOffender := FALSE;
      SELF := [];
    END;
    RETURN mTransform;
  END;

  SHARED Layout_Report_Batch_Extra := RECORD(VehicleV2_Services.Layouts.Layout_Report_Batch_New)
    Layout_Report_Out_Veh.cnp_entered;
  END;
  
  SHARED VehicleV2_Services.Layouts.Layout_Report_Batch_New GetRolledView (
    GROUPED DATASET (Layout_Report_Out_Veh) pre_veh_recs1,
    DATASET (rec_party) pre_party_recs0,
    $.IParam.reportParams aInputData,
    BOOLEAN report_mode) := FUNCTION
    
    UNSIGNED2 penalty_threshold := aInputData.penalty_threshold;
    STRING title_issue_date := aInputData.titleIssueDate;
    STRING previous_title_issue_date := aInputData.previousTitleIssueDate;

    //Added the ENTRP FILTER
    party_active := pre_party_recs0(reg_latest_expiration_date>ut.IndustryClass.sys_Date);
    party_inactive := pre_party_recs0(reg_latest_expiration_date<=ut.IndustryClass.sys_Date);
    doxie_raw.MAC_ENTRP_CLEAN(party_inactive,reg_latest_expiration_date,party_entrp);
    
    party_ftr_recs := (party_entrp+party_active);

    //Pick Current
    party_curr_reg := CHOOSEN(SORT(party_ftr_recs,-reg_latest_expiration_date,RECORD),1);
    
    //Need to pick all the registrants for the VehKey.ItrKey,SeqKey
    party_curr_key := JOIN(party_curr_reg,pre_party_recs0
                            ,LEFT.Vehicle_key = RIGHT.Vehicle_key AND
                             LEFT.Iteration_key = RIGHT.Iteration_key AND
                             LEFT.Sequence_key = RIGHT.Sequence_key,
                             TRANSFORM(RECORDOF(pre_party_recs0),SELF := RIGHT));

    //Pick Curr or filter ENTRP res
    party_entrp_recs := IF(ut.industryClass.EntDateVal=1,party_curr_key,party_ftr_recs);
    party_res_1 := IF(ut.IndustryClass.is_entrp,party_entrp_recs,pre_party_recs0);
    party_res := GROUP(SORT(party_res_1, Vehicle_Key, -Iteration_Key), Vehicle_key, Iteration_key);
      
    Census_Data.MAC_Fips2County_Keyed(party_res, st, fips_county, county_name, pre_party_recs1)

    Suppress.MAC_Suppress(pre_party_recs1,pull_dids,aInputData.application_type,Suppress.Constants.LinkTypes.DID,append_DID);
    Suppress.MAC_Suppress(pull_dids,pull_ssns0,aInputData.application_type,Suppress.Constants.LinkTypes.SSN,append_ssn);
    Suppress.MAC_Suppress(pull_ssns0,pull_ssns,aInputData.application_type,Suppress.Constants.LinkTypes.SSN,orig_ssn);
    doxie.MAC_PruneOldSSNs(pull_ssns, party_recs_pruned0, append_ssn, append_did);
    doxie.MAC_PruneOldSSNs(party_recs_pruned0,party_recs_pruned,orig_ssn,append_did);
    
    
    ssn_mask_value := aInputData.ssn_mask;
    dl_mask_value := aInputData.dl_mask = 1;
    exclude_lessors := aInputData.excludeLessors;
    displayMatchedParty_value := aInputData.displayMatchedParty;
      
    suppress.mac_mask(party_recs_pruned, party_recs0, append_ssn, blank, TRUE, FALSE);
    suppress.mac_mask(party_recs0,party_recs1,orig_ssn,blank,TRUE,FALSE)
    suppress.mac_mask(party_recs1,party_recs,blank,Orig_DL_Number,FALSE,TRUE)

    dppa_ok := aInputData.isValidDppa();
    glb_ok := aInputData.isValidGlb();
    
    temp_rec := RECORD
      party_recs;
      INTEGER did;
    END;
  
    temp := PROJECT(party_recs, TRANSFORM(temp_rec, SELF.did := (INTEGER)LEFT.append_did, SELF := LEFT));
  
    doxie.mac_best_records(temp,
                           did,
                           outfile,
                           dppa_ok,
                           glb_ok,
                           ,
                           aInputData.DataRestrictionMask);
            
            
      // use best file to get DOB and SEX, IF missing in the original data.
    rec_party get_dob_sex(party_recs r, outfile ri) := TRANSFORM
      age := IF(r.orig_dob != '', ut.age((INTEGER)r.orig_dob), IF (ri.dob = 0, 0, ut.age(ri.dob)));
      ofage :=doxie.compliance.minor_ok(age, aInputData.show_minors);
      best_sex := MAP (ri.title = 'MS' => 'F', ri.title = 'MR' => 'M','U'); // same as in drivers

      SELF.orig_dob := IF( r.orig_dob <> '' AND ofage,r.orig_dob,(STRING8) ri.dob);
      SELF.orig_sex := IF(r.orig_sex <>'' AND ofage,r.orig_sex,best_sex);
      SELF.orig_sex_desc := IF(ofage AND r.orig_sex_desc='', CODES.GENERAl.GENDER(best_sex),r.orig_sex_desc);
      SELF.age := IF(ofage, (STRING) age, '');
      SELF.Vehicle_Key := r.Vehicle_Key;
      SELF.Iteration_Key := r.Iteration_Key;
      SELF.Sequence_Key := r.Sequence_Key;
      SELF.Orig_Name_Type := r.Orig_Name_Type;
      SELF := IF(ofage, r);
    END;

    w_dl_fields := JOIN(party_recs, outfile,
      (INTEGER)LEFT.append_did = RIGHT.did,
      get_dob_sex(LEFT, RIGHT), KEEP(1), LEFT OUTER);
                     
    Layout_Report_Out_Veh getDecode_fuel(Layout_Report_Out_Veh l, keyCd3 r):=TRANSFORM
      SELF.fuel_type_name := r.long_desc;
      SELF := l;
    END;
    
    pre_veh_recs2 := JOIN(pre_veh_recs1 ,keyCd3, KEYED(RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
      KEYED(RIGHT.field_name= (STRING50)'FUEL_TYPE') AND
      KEYED(RIGHT.field_name2 = LEFT.state_origin) AND
      KEYED((STRING15)LEFT.vina_fuel_code = RIGHT.code),
    getDecode_fuel(LEFT,RIGHT),LEFT OUTER, KEEP(1), LIMIT(1000,SKIP));

    Layout_Report_Batch_Extra getDecode_body(Layout_Report_Out_Veh l, keyCd3 r):=TRANSFORM
      SELF.body_style_desc := IF(r.long_desc<>'', r.long_desc,l.body_style_desc);
      SELF.nonDMVSource := l.source_code in MDR.sourceTools.set_infutor_all_veh;
      SELF := l;
      SELF := [];
    END;

    veh_recs := JOIN(pre_veh_recs2, keyCd3, KEYED(RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
      KEYED(RIGHT.field_name= (STRING50)'BODY_CODE') AND
      KEYED(LEFT.state_origin = RIGHT.field_name2) AND
      KEYED(LEFT.body_style_desc = RIGHT.code),
    getDecode_body(LEFT,RIGHT),LEFT OUTER, KEEP(1), LIMIT(1000,SKIP));
    

    VehicleV2_Services.Layouts.Layout_Report_Batch_New rollIt (Layout_Report_Batch_Extra l, DATASET(rec_party) r, BOOLEAN report_mode) := TRANSFORM

      party_r := r;
     
      //get dIFferent kinds of records (owner/registrant/lessee/lienholder/lessor)
      r_recs := party_r(orig_name_type = '4');
      l_recs := party_r(orig_name_type = '7');
      pre_o_recs := party_r(orig_name_type = '1');
      lessee_recs := party_r(orig_name_type = '5');
      lessor_recs := IF(~Exclude_lessors, party_r(orig_name_type = '2'));

      len_ttl_issue_dt := LENGTH(title_issue_date);
      len_prev_ttl_issue_dt := LENGTH(previous_title_issue_date);
      ttl_issue_dt := (UNSIGNED4) title_issue_date;
      ttl_prev_issue_dt := previous_title_issue_date;

      o_recs := pre_o_recs (
        MAP (len_ttl_issue_dt = 4=>ttl_issue_dt BETWEEN (UNSIGNED4) (ttl_earliest_issue_date[1..4]) AND (UNSIGNED4) (ttl_latest_issue_date[1..4]),
             len_ttl_issue_dt = 6=>ttl_issue_dt BETWEEN (UNSIGNED4) (ttl_earliest_issue_date[1..6]) AND (UNSIGNED4) (ttl_latest_issue_date[1..6]),
             len_ttl_issue_dt = 8=>ttl_issue_dt BETWEEN (UNSIGNED4) (ttl_earliest_issue_date[1..8]) AND (UNSIGNED4) (ttl_latest_issue_date[1..8]),
             ttl_issue_dt=0) AND
                          MAP(len_prev_ttl_issue_dt = 4 => ttl_prev_issue_dt = ttl_previous_issue_date[1..4],
                              len_prev_ttl_issue_dt = 6 => ttl_prev_issue_dt = ttl_previous_issue_date[1..6],
                              len_prev_ttl_issue_dt = 8 => ttl_prev_issue_dt = ttl_previous_issue_date[1..8],
                              ttl_prev_issue_dt=''));
      

      party_dup(DATASET(rec_party) recs) := IF(report_mode,
        DEDUP(SORT(recs,
              EXCEPT sequence_key, orig_address, orig_city, orig_state, orig_zip),
        EXCEPT sequence_key, orig_address, orig_city, orig_state, orig_zip),
      DEDUP(SORT(recs,
          fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir,
          unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Reg_True_License_Plate,
          Reg_License_Plate,Reg_First_Date,Reg_Earliest_Effective_Date,Reg_Latest_Effective_Date),
        fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir,
        unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Reg_True_License_Plate,
        Reg_License_Plate,Reg_First_Date,Reg_Earliest_Effective_Date,Reg_Latest_Effective_Date));
      
      SELF.matched_party := IF(DisplayMatchedParty_value AND l.cnp_entered,
        SORT(party_r,vehicle_key, iteration_key, sequence_key,party_penalty,orig_name_type,RECORD)[1]);
      registrants := party_dup(r_recs);
      lessees := party_dup(lessee_recs);

      lessors := CHOOSEN(DEDUP(SORT(lessor_recs,
                                        EXCEPT sequence_key, orig_address, orig_city, orig_state, orig_zip),
                                   EXCEPT sequence_key, orig_address, orig_city, orig_state, orig_zip),Constant.max_child_count);
   

      owners := IF(report_mode,DEDUP(SORT(o_recs,
                                         EXCEPT sequence_key, orig_address, orig_city, orig_state, orig_zip),
                                       EXCEPT sequence_key, orig_address, orig_city, orig_state, orig_zip),
                                         DEDUP(SORT(o_recs,
                    fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir,
                    unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Ttl_Number,Ttl_Earliest_Issue_Date,
                    Ttl_Latest_Issue_Date),
                    fname,mname,lname,append_clean_cname,name_suffix,title, append_ssn,orig_ssn,prim_range,predir, prim_name,addr_suffix, postdir,
                    unit_desig, sec_range, v_city_name, st, zip5 ,zip4 ,Orig_DL_Number,history,Ttl_Number,Ttl_Earliest_Issue_Date,
                    Ttl_Latest_Issue_Date ));

            lienholders := CHOOSEN(DEDUP(SORT(l_recs,
                                       EXCEPT sequence_key),
                                 EXCEPT sequence_key),Constant.max_child_count);
      
      rec_party roll_parties(rec_party le, rec_party ri) :=
      TRANSFORM
        SELF.Reg_First_Date := (STRING8) ut.min2 ((UNSIGNED)le.Reg_First_Date, (UNSIGNED)ri.Reg_First_Date);
        SELF.Reg_Earliest_Effective_date := (STRING8) ut.min2 ((UNSIGNED)le.Reg_Earliest_Effective_date,(UNSIGNED)ri.Reg_Earliest_Effective_date);
        SELF.Reg_Latest_Effective_Date := (STRING8) MAX ((UNSIGNED)le.Reg_Latest_Effective_Date, (UNSIGNED)ri.Reg_Latest_Effective_Date);
        SELF.Reg_Latest_Expiration_Date := (STRING8) MAX((UNSIGNED)le.Reg_Latest_Expiration_Date, (UNSIGNED)ri.Reg_Latest_Expiration_Date);
        SELF := le;
      END;

      party_roller(DATASET(rec_party) pty) :=
                            ROLLUP(SORT(pty, RECORD,
                                EXCEPT Reg_First_Date, Reg_Earliest_Effective_date, Reg_Latest_Effective_Date, Reg_Latest_Expiration_Date),
                            roll_parties(LEFT,RIGHT), RECORD,
                                EXCEPT Reg_First_Date, Reg_Earliest_Effective_date, Reg_Latest_Effective_Date, Reg_Latest_Expiration_Date);
      
      SELF.is_current := IF(EXISTS(pre_o_recs) AND ~EXISTS(owners),SKIP,EXISTS(r_recs(history='')) OR EXISTS(lessee_recs(history='')) OR l.is_current);
      SELF.datasource := Constant.local_val_out;
    
      SELF.registrants :=
            CHOOSEN(SORT(PROJECT(party_roller(registrants), TRANSFORM(VehicleV2_Services.asSORTed_layouts.layout_registrant,SELF.matchFlags:=[],SELF:=LEFT)),
          sequence_key, IF(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name),VehicleV2_Services.Constant.max_child_count);
                              
      SELF.owners := CHOOSEN(SORT(PROJECT(party_roller(owners), TRANSFORM(VehicleV2_Services.Layouts.Layout_owner,SELF.matchFlags:=[],SELF:=LEFT)),
                              sequence_key, IF(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name),Constant.max_child_count);
      SELF.lienholders := SORT(PROJECT(lienholders,TRANSFORM(VehicleV2_Services.AsSORTed_Layouts.Layout_lienholder,SELF.matchFlags:=[],SELF:=LEFT)),
                              sequence_key, IF(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name);
      SELF.lessees := CHOOSEN(SORT(PROJECT(party_roller(lessees), TRANSFORM(VehicleV2_Services.AsSORTed_Layouts.layout_lessee,SELF.matchFlags:=[],SELF:=LEFT)),
                              sequence_key, IF(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name),Constant.max_child_count);
      SELF.lessors := SORT(PROJECT(lessors,TRANSFORM(VehicleV2_Services.AsSORTed_Layouts.layout_lessee_or_lessor,SELF.matchFlags:=[],SELF:=LEFT)),
                            sequence_key, IF(report_mode,0,party_penalty), lname,fname, mname,name_suffix,orig_name);
        // SELF.plate := r_recs[1];
      // SELF.title := o_recs[1];
      
      /* Web not ready to be able to search on leasees yet */
      // mpp := ut.imin2(
      // ut.iMin2(IF(EXISTS(registrants),MIN(registrants, party_penalty),100),IF(EXISTS(owners), MIN(owners, party_penalty),100)),
      // IF(EXISTS(lessees),MIN(lessees, party_penalty),100));
      
      mpp := MIN (IF(EXISTS(registrants),MIN(registrants, party_penalty),100),IF(EXISTS(owners), MIN(owners, party_penalty),100));

      SELF.min_party_penalty :=IF(report_mode, 0, IF(mpp > penalty_threshold, SKIP, mpp));

      SELF := l;
    END;


    rolled_recs := denormalize(veh_recs,w_dl_fields,
      LEFT.vehicle_key=RIGHT.vehicle_key AND LEFT.iteration_key=RIGHT.iteration_key
      AND LEFT.sequence_key = RIGHT.sequence_key,GROUP,rollIt(LEFT,rows(RIGHT), report_mode),GROUPED)
      (EXISTS(owners) OR EXISTS(registrants) OR EXISTS(lienholders) OR EXISTS(lessees) OR
      EXISTS(lessors) OR EXISTS(Brands));
      
    //might need a ROLLUP here
    rolled_out_recs := DEDUP(SORT(rolled_recs, EXCEPT iteration_key), EXCEPT iteration_key);
    
    RETURN rolled_out_recs;
  END;

  SHARED MAC_JoinLatestDLAndPrePartyRecs(inputPrePartyRecs, outputPrePartyRecs) := MACRO
    // latest DL recs by expire date by did
    latest_dl_recs := DEDUP(
                                    SORT(
                                        JOIN(inputPrePartyRecs, Driversv2.Key_DL_DID,
                                                KEYED((UNSIGNED)LEFT.append_did = RIGHT.did),
                                                TRANSFORM(RIGHT),
                                                LEFT OUTER,
                                                LIMIT(DriversV2.Constants.DL_PER_DID, SKIP)
                                                ),
                                      did,-expiration_date,-lic_issue_date),
                                did);

    // add driver license number
    outputPrePartyRecs := JOIN(inputPrePartyRecs,
                latest_dl_recs,
                (UNSIGNED)LEFT.append_did = RIGHT.did,
                  TRANSFORM(RECORDOF(inputPrePartyRecs),
                    SELF.orig_dl_number := IF(LEFT.orig_dl_number!='', LEFT.orig_dl_number,
                                  IF(LEFT.orig_name_type IN ['1','4'], RIGHT.dl_number, '')), // owner/registrant
                                  SELF:=LEFT),
                  LEFT OUTER,KEEP(1));
  ENDMACRO;

  EXPORT GetVehicleReport (VehicleV2_Services.IParam.reportParams aInputData,
                           GROUPED DATASET(Layout_Vehicle_Key) in_veh_keys) := FUNCTION
                     
    BOOLEAN isCNSMR := aInputData.isConsumer();
    BOOLEAN include_non_regulated_data := aInputData.IncludeNonRegulatedSources AND ~doxie.compliance.isInfutorMVRestricted(aInputData.DataRestrictionMask);
    
    pre_veh_recs0_info := JOIN(in_veh_keys, VehicleV2.Key_Vehicle_Main_Key,
                          KEYED(LEFT.Vehicle_Key = RIGHT.Vehicle_Key) AND
                          KEYED((LEFT.Iteration_Key = '') OR LEFT.Iteration_Key = RIGHT.Iteration_Key) AND
                          (include_non_regulated_data OR RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh),
                          makeVehReport(LEFT, RIGHT),
                          LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_KEY,SKIP));

      pre_veh_recs0 := IF(~isCNSMR, pre_veh_recs0_info);

    _pre_veh_recs1 := pre_veh_recs0(aInputData.isValidDppaState(state_origin,,source_code) OR
                                    (source_code in MDR.sourceTools.set_infutor_all_veh AND aInputData.isValidDppa()));

    r_j_vehicleparty_pre := JOIN(in_veh_keys, keyVParty,
                KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_key) AND
                KEYED(LEFT.Iteration_key = RIGHT.Iteration_key) AND
                KEYED(LEFT.Sequence_key = RIGHT.Sequence_key) AND
                (include_non_regulated_data OR RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh),
                get_parties_report (RIGHT, aInputData.show_minors),
                KEEP(VehicleV2_Services.Constant.PARTIES_PER_VEHICLE),
                LIMIT(0));
  r_j_vehicleparty_1 := suppress.mac_suppresssource(r_j_vehicleparty_pre,aInputData,append_did);
  r_j_vehicleparty := PROJECT(r_j_vehicleparty_1,rec_party);
   r_j := IF(~isCNSMR, r_j_vehicleparty);
    pre_party_recs0 := UNGROUP(r_j);
    MAC_JoinLatestDLAndPrePartyRecs(pre_party_recs0, outputPrePartyRecs);
    
    RETURN GetRolledView (_pre_veh_recs1, outputPrePartyRecs, aInputData, TRUE);
  END;

  EXPORT Get_VehicleSearch (VehicleV2_Services.IParam.searchParams aInputData, GROUPED DATASET(VehicleV2_Services.Layout_VKeysWithInput) in_veh_keys,
                            BOOLEAN penalize_by_party = FALSE) := FUNCTION
                      
    BOOLEAN isCNSMR := aInputData.isConsumer();
    UNSIGNED2 penalty_threshold := aInputData.penalty_threshold;
    BOOLEAN include_non_regulated_data := aInputData.IncludeNonRegulatedSources AND ~doxie.compliance.isInfutorMVRestricted(aInputData.DataRestrictionMask);
    
    pre_veh_recs0_info := JOIN(in_veh_keys, VehicleV2.Key_Vehicle_Main_Key,
                          KEYED(LEFT.Vehicle_Key = RIGHT.Vehicle_Key) AND
                          KEYED(LEFT.Iteration_Key = RIGHT.Iteration_Key) AND
                          (include_non_regulated_data OR RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh),
                          makeVehSearch(LEFT, RIGHT, aInputData),
                          LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_KEY,SKIP));
                            
      pre_veh_recs0 := IF(~isCNSMR, pre_veh_recs0_info);

    pre_veh_recs1 := pre_veh_recs0(aInputData.isValidDppaState(state_origin,,source_code) OR
                                   (source_code in MDR.sourceTools.set_infutor_all_veh AND aInputData.isValidDppa()));
    
    r_j_vehicleparty_pre := JOIN(in_veh_keys, keyVParty,
                KEYED(LEFT.Vehicle_key = RIGHT.Vehicle_key) AND
                KEYED(LEFT.Iteration_key = RIGHT.Iteration_key) AND
                KEYED(LEFT.Sequence_key = RIGHT.Sequence_key) AND
                (include_non_regulated_data OR RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh),
                get_parties_search (LEFT, RIGHT, aInputData, penalize_by_party),
                KEEP(Constant.PARTIES_PER_VEHICLE),
                LIMIT(0));
              
  r_j_vehicleparty_1 := suppress.mac_suppresssource(r_j_vehicleparty_pre,aInputData,append_did);
  r_j_vehicleparty := PROJECT(r_j_vehicleparty_1, rec_party);

    r_j := IF(~isCNSMR, r_j_vehicleparty);

    pre_party_recs := UNGROUP(r_j(party_penalty <= penalty_threshold));

    MAC_JoinLatestDLAndPrePartyRecs(pre_party_recs, outputPrePartyRecs);

    // add crim indicators
    recsIn := PROJECT(outputPrePartyRecs,TRANSFORM({rec_party,STRING12 UniqueId},SELF.UniqueId:=LEFT.append_did,SELF:=LEFT));
    CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
    pre_party_recs1 := IF(aInputData.IncludeCriminalIndicators,PROJECT(recsOut,rec_party),outputPrePartyRecs);

    commonParam := MODULE(PROJECT(aInputData, VehicleV2_Services.IParam.reportParams)) END;
    
    RETURN GetRolledView (pre_veh_recs1, pre_party_recs1, commonParam, FALSE);
  END;

MAC_SetPersonOrBusiness(childRecord):= MACRO
  childRecord.UniqueId := L.append_did;
  childRecord.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, '');
  childRecord.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix,
                                    L.unit_desig, L.sec_range, L.v_city_name, L.st, L.zip5, L.zip4, L.county_name);
  childRecord.SSN := L.Orig_SSN;
  childRecord.AppendSSN := L.append_ssn;
  childRecord.DriverLicenseNumber := L.Orig_DL_Number;
  childRecord.Gender := L.orig_sex_desc;
  childRecord.DOB := iesp.ECL2ESP.toDate ((INTEGER4) L.Orig_DOB);
  childRecord.BusinessName := L.Append_Clean_CName;
  childRecord.BusinessId := L.append_bdid;
  childRecord.SurnameMatch := L.matchFlags.surnameFlag='Y';
  childRecord.FullNameMatch := L.matchFlags.fullNameFlag='Y';
  childRecord.AddressMatch := L.matchFlags.addressMatchFlag='Y';
  childRecord.HasCriminalConviction := L.HasCriminalConviction;
  childRecord.IsSexualOffender := L.IsSexualOffender;
ENDMACRO;

EXPORT transform_vehicles (DATASET (VehicleV2_Services.Layout_Report) vehi) := FUNCTION


  iesp.motorvehicle.t_MotorVehicleSearchRegistrant SetRecordRegistrants (VehicleV2_Services.Layouts.Layout_registrant_New L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
    MAC_SetPersonOrBusiness(SELF.RegistrantInfo);
    SELF.RegistrantInfo.NameSource := L.name_source;
    SELF.RegistrantInfo.ReportedName := L.reported_name;
    SELF.RegistrationInfo.TrueLicensePlate := L.reg_true_license_plate;
    SELF.RegistrationInfo.LicenseState := L.reg_license_state;
    SELF.RegistrationInfo.FirstDate := iesp.ECL2ESP.toDatestring8(L.reg_first_date);
    SELF.RegistrationInfo.EarliestEffectiveDate := iesp.ECL2ESP.toDatestring8(L.reg_earliest_effective_date);
    SELF.RegistrationInfo.LatestEffectiveDate := iesp.ECL2ESP.toDatestring8(L.reg_latest_effective_date);
    SELF.RegistrationInfo.LatestExpirationDate := iesp.ECL2ESP.toDatestring8(L.reg_latest_expiration_date);
    SELF.RegistrationInfo.LicensePlate := L.Reg_License_Plate;
    SELF.RegistrationInfo.LicensePlateTypeCode := L.Reg_License_Plate_Type_Code;
    SELF.RegistrationInfo.LicensePlateTypeDesc := L.Reg_License_Plate_Type_Desc;
    SELF.RegistrationInfo.PreviousLicensePlate := L.reg_previous_license_plate;
    SELF.RegistrationInfo.PreviousLicenseState := L.reg_previous_license_state;
  
    SELF.VendorInfo.FirstReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_first_reported);
    SELF.VendorInfo.LastReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_last_reported);
    SELF.TitleIssueDate := iesp.ECL2ESP.toDatestring8(L.title_issue_date);
    SELF.TitleNumber := L.title_number;
  END;

  iesp.motorvehicle.t_MotorVehicleSearchOwner SetRecordOwners (VehicleV2_Services.Layouts.Layout_owner L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
    
    MAC_SetPersonOrBusiness(SELF.OwnerInfo);
    SELF.OwnerInfo.NameSource := '';
    SELF.OwnerInfo.ReportedName := L.reported_name;
    SELF.TitleInfo.Number := L.Ttl_Number;
    SELF.TitleInfo.EarliestIssueDate := iesp.ECL2ESP.toDatestring8(L.ttl_earliest_issue_date) ;
    SELF.VendorInfo.FirstReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_first_reported);
    SELF.VendorInfo.LastReportedDate := iesp.ECL2ESP.toDateYM(L.date_vendor_last_reported);
    SELF.SourceDateFirstSeen := iesp.ECL2ESP.toDatestring8(L.SRC_FIRST_DATE) ;
    SELF.SourceDateLastSeen := iesp.ECL2ESP.toDatestring8(L.SRC_LAST_DATE) ;
  END;
  
  iesp.motorvehicle.t_MotorVehicleSearchLienHolder setRecordLienHolders(VehicleV2_Services.Assorted_Layouts.Layout_lienholder L) := TRANSFORM
    SELF.HistoryDescription := L.history_desc;
    MAC_SetPersonOrBusiness(SELF.LienHolderInfo);
    SELF.LienHolderInfo.ReportedName := '';
    SELF.LienHolderInfo.NameSource := L.name_source;
    SELF.LienDate := iesp.ECL2ESP.toDatestring8(L.orig_lien_date);
    SELF.StandardizedName := L.std_lienholder_name;
  END;
  
  iesp.motorvehicle.t_MotorVehicleSearchLessee SetRecordLessees(VehicleV2_Services.Assorted_Layouts.Layout_lessee L) := TRANSFORM
    SELF.HistoryDescription := L.History_desc;
    MAC_SetPersonOrBusiness(SELF.LesseeInfo);
    SELF.LesseeInfo.NameSource := '';
    SELF.LesseeInfo.ReportedName := '';
  END;
  
  iesp.motorvehicle.t_MotorVehicleSearchLessor SetRecordLessors(VehicleV2_Services.Assorted_Layouts.layout_lessee_or_lessor L) := TRANSFORM
    SELF.HistoryDescription := L.History_desc;
    MAC_SetPersonOrBusiness(SELF.LessorInfo);
    SELF.LessorInfo.NameSource := L.name_source;
    SELF.LessorInfo.ReportedName := '';
  END;
  
  iesp.motorvehicle.t_MotorVehicleSearchBrand SetRecordBrand(VehicleV2_Services.Assorted_Layouts.layout_brand L) := TRANSFORM
    SELF.Date := iesp.ECL2ESP.toDatestring8(L.Brand_Date);
    SELF.State := L.Brand_State;
    SELF.Code := L.Brand_Code;
    SELF._Type := L.Brand_Type;
  END;
  
  iesp.motorvehicle.t_MotorVehicleSearch2Record toOutRecord (VehicleV2_Services.Layout_Report L) := TRANSFORM
  
    SELF.DataSource := L.DataSource;
    SELF.ExternalKey := (STRING)l.Vehicle_Key+l.Iteration_Key+l.Sequence_Key;
    SELF.AlsoFound := L.is_deep_dive;
    SELF.NonDMVSource := L.NonDMVSource;
    SELF.VehicleInfo := PROJECT(L, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchVehicleInfo,
      SELF.VehicleRecordId := LEFT.Vehicle_Key;
      SELF.IterationKey := LEFT.iteration_key;
      SELF.SequenceKey := LEFT.sequence_key;
      SELF.VIN := LEFT.Vin;
      SELF.YearMake := (INTEGER4)LEFT.model_year;
      SELF.Make := LEFT.make_desc;
      SELF.Model := LEFT.model_desc;
      //SELF.Series := LEFT.vina_vp_series;
      SELF.Series := LEFT.series_desc;
      SELF.MajorColor := LEFT.major_color_desc;
      SELF.MinorColor := LEFT.minor_color_desc;
      SELF._Type := LEFT.vehicle_type_desc;
      SELF.Style := LEFT.body_style_desc;
      SELF.StateOfOrigin := LEFT.state_origin;
      SELF.MatchCode := LEFT.matchCode;
    ));
    
    SELF.MatchedParty := PROJECT(L.matched_party, TRANSFORM(iesp.motorvehicle.t_MotorVehicleSearchMatchedParty,
      //SELF.UniqueId := ;
      SELF.OriginName := LEFT.Orig_Name;
      SELF.OriginNameType := LEFT.orig_name_type;
      //SELF.SSN := ;
      //SELF.AppendSSN := ;
      SELF.Name := iesp.ECL2ESP.SetName(LEFT.fname, LEFT.mname, LEFT.lname, LEFT.name_suffix, '');
      SELF.Address := iesp.ECL2ESP.SetAddress (LEFT.prim_name, LEFT.prim_range, LEFT.predir, LEFT.postdir, LEFT.addr_suffix,
        LEFT.unit_desig, LEFT.sec_range, LEFT.v_city_name, LEFT.st, LEFT.zip5, LEFT.zip4, '');

      //SELF.DriverLicenseNumber := };
      //SELF.Gender := ;
      //share.t_Date DOB := ;
      //SELF.BusinessName := ;
      //SELF.BusinessId := ;
      SELF := [];
    ));
     SELF.registrants := PROJECT (CHOOSEN (L.registrants, iesp.Constants.MV.MaxCountRegistrants), SetRecordRegistrants(LEFT));
    
     SELF.owners := PROJECT (CHOOSEN (L.owners, iesp.Constants.MV.MaxCountOwners), setRecordOwners(LEFT));
     SELF.lienHolders := PROJECT (CHOOSEN (L.LienHolders, iesp.Constants.MV.MaxCountLienHolders), setRecordLienHolders(LEFT));
     SELF.Lessees := PROJECT (CHOOSEN (L.Lessees, 1), SetRecordLessees(LEFT));
     SELF.Lessors := PROJECT (CHOOSEN (L.lessors, 1), SetRecordLessors(LEFT));
     SELF.Brands := PROJECT(CHOOSEN(L.brands, iesp.Constants.MV.MaxCountBrands), SetRecordBrand(LEFT));
    SELF := [];
  END;


  RETURN PROJECT (vehi, toOutRecord(LEFT));

END;


EXPORT VehicleV2_Services.Layout_Report RemoveLatLong(VehicleV2_Services.Layout_Report L) := TRANSFORM
  SELF.registrants := PROJECT(L.registrants, TRANSFORM(VehicleV2_Services.asSORTed_layouts.layout_registrant,
    SELF.geo_lat := '', SELF.geo_long := '', SELF := LEFT));
                                                          
  SELF.owners := PROJECT(L.owners, TRANSFORM(VehicleV2_Services.Layouts.Layout_owner,
    SELF.geo_lat := '', SELF.geo_long := '', SELF := LEFT));
                                                          
  SELF.lienholders := PROJECT(L.lienholders, TRANSFORM(VehicleV2_Services.asSORTed_Layouts.Layout_lienholder,
    SELF.geo_lat := '', SELF.geo_long := '', SELF := LEFT));
                                                          
  SELF.lessees := PROJECT(L.lessees, TRANSFORM(VehicleV2_Services.asSORTed_Layouts.layout_lessee,
     SELF.geo_lat := '', SELF.geo_long := '', SELF := LEFT));
                                                          
  SELF.lessors := PROJECT(L.lessors, TRANSFORM(VehicleV2_Services.asSORTed_Layouts.layout_lessee_or_lessor,
    SELF.geo_lat := '', SELF.geo_long := '', SELF := LEFT));
                                                           
  SELF := L;
END;


END;
