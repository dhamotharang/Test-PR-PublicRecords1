IMPORT mdr, VehicleV2, driversv2, doxie, ut, suppress, Census_Data, VehicleV2_services, codes,
       doxie_Raw, doxie_build, CriminalRecords_Services, Address;

layout_w_keys := RECORD
  VehicleV2_Services.Layouts.flat_vehicle;
  UNSIGNED2 party_penalty := 0;
  //adding the plate type desc for the wildcard_search service
  STRING65 license_plate_desc := '';
END;

EXPORT Fn_Find(
  GROUPED DATASET(doxie_Raw.Layout_VehRawBatchInput.input_w_keys) in_veh_keys,
  doxie.IDataAccess mod_access,
  BOOLEAN report_mode = TRUE,
  BOOLEAN ExcludeLessors= FALSE,
  BOOLEAN alternate_route = FALSE,
  BOOLEAN includeCriminalIndicators=FALSE,
  BOOLEAN include_non_regulated_data = FALSE)
  := FUNCTION

  isCNSMR := mod_access.isConsumer();
  includeNonRegulatedData := include_non_regulated_data AND ~mod_access.isInfutorMVRestricted();

  layout_w_keys makeVehReport(in_veh_keys l, VehicleV2.Key_Vehicle_Main_Key r) := TRANSFORM
    SELF.vehicle_numberxbg1 := r.vehicle_key[1..20];
    SELF.year_make := r.Orig_Year;
    SELF.number_of_axles := r.orig_number_of_axles;
    SELF.net_weight := r.orig_net_weight;
    SELF.gross_weight := r.orig_gross_weight;
    SELF.source_field := r.source_code;
    SELF.make_code := r.best_make_code;
    SELF.vehicle_type := IF(r.Orig_Vehicle_Type_Code<>'', r.Orig_Vehicle_Type_Code[1..4],r.orig_vehicle_type_desc[1..4]) ;
    SELF.model := IF(r.Orig_Model_Code <> '', r.orig_model_code,r.vina_model);
    SELF.body_code := r.Orig_Body_Code;
    SELF.Major_color_code := r.Orig_Major_Color_Code;
    SELF.Minor_color_code := r.Orig_Minor_Color_Code;
    SELF.orig_vin := r.Orig_VIN;
    SELF.vin_2 := r.vina_vin;
    SELF.veh_type := r.VINA_Veh_Type;
    SELF.ncic_make :=r.VINA_NCIC_Make;
    SELF.model_year_yy := r.VINA_Model_Year_YY;
    SELF.vin := r.orig_vin;
    SELF.vin_pattern_indicator :=r.VINA_VIN_Pattern_Indicator;
    SELF.bypass_code := r.VINA_bypass_code;
    SELF.vp_restraint := r.VINA_VP_Restraint;
    SELF.vp_abbrev_make_name := r.vina_vp_abbrev_make_name;
    SELF.vp_year := r.VINA_vp_year;
    SELF.vp_series := r.VINA_vp_series;
    SELF.vp_model := r.VINA_vp_model;
    SELF.vp_air_conditioning := r.VINA_vp_air_conditioning;
    SELF.vp_power_steering := r.VINA_vp_power_steering;
    SELF.vp_power_brakes := r.VINA_vp_power_brakes;
    SELF.vp_power_windows := r.VINA_vp_power_windows;
    SELF.vp_tilt_wheel := r.VINA_vp_tilt_wheel;
    SELF.vp_roof := r.VINA_vp_roof;
    SELF.vp_optional_roof1 := r.VINA_vp_optional_roof1;
    SELF.vp_optional_roof2 := r.VINA_vp_optional_roof2;
    SELF.vp_radio := r.VINA_vp_radio;
    SELF.vp_optional_radio1 := r.VINA_vp_optional_radio1;
    SELF.vp_optional_radio2 := r.VINA_vp_optional_radio2;
    SELF.vp_transmission := r.VINA_vp_transmission;
    SELF.vp_optional_transmission1 := r.VINA_vp_optional_transmission1;
    SELF.vp_optional_transmission2 := r.VINA_vp_optional_transmission2;
    SELF.vp_anti_lock_brakes := r.VINA_vp_anti_lock_brakes;
    SELF.vp_front_wheel_drive := r.VINA_vp_front_wheel_drive;
    SELF.vp_four_wheel_drive := r.VINA_vp_four_wheel_drive;
    SELF.vp_security_system := r.VINA_vp_security_system;
    SELF.vp_daytime_running_lights := r.VINA_vp_daytime_running_lights;
    SELF.vp_series_name := r.VINA_vp_series_name;
    SELF.model_year := r.VINA_Model_Year;
    SELF.vina_series := r.VINA_Series;
    SELF.vina_model := r.VINA_Model;
    SELF.vina_body_style := r.VINA_Body_Style;
    SELF.make_description := r.VINA_Make_Desc;
    SELF.model_description := r.VINA_Model_Desc;
    SELF.series_description := r.VINA_Series_Desc;
    SELF.body_style_description := r.VINA_Body_Style_Desc;
    SELF.number_of_cylinders := r.VINA_Number_Of_Cylinders;
    SELF.engine_size := r.VINA_Engine_Size;
    SELF.fuel_code := r.VINA_Fuel_Code;
    SELF.fuel_type := r.VINA_Fuel_Code;
    SELF.vina_price := r.VINA_Price;
    SELF.source_code := r.source_code;
    SELF.vehicle_use := r.orig_vehicle_use_code;
    SELF.seq := l.input.seq;
    SELF := r;
    SELF := l;
    SELF.history_flag := ''; // SELF := [];
  END;

  // Probably this code do not always work as it was intended:
  // there are more than 1,000 records matching by vehicle-key,
  // and ~200 by vehicle- and iteration-key.
  veh_recs0_mainkeyinfo := JOIN(in_veh_keys,
    VehicleV2.Key_Vehicle_Main_Key,
    KEYED(LEFT.Vehicle_Key = RIGHT.Vehicle_Key[1..LENGTH(TRIM(LEFT.vehicle_key))]) AND
    // it =looks= like LEFT.iteration_key cannot be blank here.
    KEYED(LEFT.iteration_key='' OR LEFT.Iteration_Key = RIGHT.Iteration_Key) AND
    (includeNonRegulatedData OR RIGHT.source_code NOT IN MDR.sourceTools.set_infutor_all_veh),
    makeVehReport(LEFT, RIGHT),
    KEEP (VehicleV2_services.Constant.VEHICLE_PER_KEY), LIMIT (10000));


 veh_recs0 := IF(~isCNSMR, veh_recs0_mainkeyinfo);

  // for moxie queries this filtering is now done in runall
  veh_recs := IF(alternate_route,
                  veh_recs0,
                  veh_recs0(mod_access.isValidDppaState(state_origin,,source_code)OR
                            (source_code IN MDR.sourceTools.set_infutor_all_veh AND mod_access.isValidDppa())));

  // Similar issue: 3,000,000 by vehicle-key, ~4,500 by vehicle-, iteration-, sequence-key.
  owner_recs0_info_pre :=JOIN(in_veh_keys, vehiclev2.Key_Vehicle_Party_Key,
                  KEYED(LEFT.vehicle_key=RIGHT.vehicle_key[1..LENGTH(TRIM(LEFT.vehicle_key))]) AND
                  KEYED(LEFT.iteration_key='' OR LEFT.Iteration_key = RIGHT.Iteration_key) AND// AND
                  KEYED(LEFT.sequence_key='' OR LEFT.sequence_key= RIGHT.sequence_key) AND
                  (includeNonRegulatedData OR RIGHT.source_code NOT in MDR.sourceTools.set_infutor_all_veh),
                  TRANSFORM (vehiclev2.Layout_Base_Party, SELF := RIGHT),
                  // TODO: should rather be PARTIES_PER_VEHICLE
                  KEEP(VehicleV2_services.Constant.VEHICLE_PER_KEY), LIMIT (10000));

  owner_recs0_info := suppress.MAC_SuppressSource(owner_recs0_info_pre,mod_access,append_did);
  owner_recs0 := IF(~isCNSMR, owner_recs0_info);

  vehiclev2.Layout_Base_Party get_dob_sex(owner_recs0 l, driversv2.Key_DL_DID r) := TRANSFORM
    SELF.orig_dob := IF(((UNSIGNED) l.orig_dob) <> 0,l.orig_dob,(STRING8) r.dob);
    SELF.orig_sex := IF(l.orig_sex <>'',l.orig_sex,r.sex_flag);
    SELF.orig_dl_number := IF(l.orig_dl_number <>'',l.orig_dl_number,r.dl_number);
    SELF := l;
  END;

  // latest DL recs by expire date by did
  latest_dl_recs := PROJECT(DEDUP(SORT(
    JOIN(owner_recs0,Driversv2.Key_DL_DID,
         KEYED((UNSIGNED)LEFT.append_did=RIGHT.did),
         LEFT OUTER,LIMIT(10000,SKIP)),
      did,-expiration_date),did),RECORDOF(Driversv2.Key_DL_DID));

  owner_recs1 := JOIN(owner_recs0,latest_dl_recs,LEFT.append_did=RIGHT.did,
      get_dob_sex(LEFT,RIGHT),KEEP(1),LEFT OUTER);

  rec_base_w_ssn := RECORD (vehiclev2.Layout_Base_Party)
    STRING9 use_ssn;
    STRING18 county_name;
    BOOLEAN hasCriminalConviction;
    BOOLEAN isSexualOffender;
  END;

  rec_base_w_ssn is_ofage( vehiclev2.Layout_Base_Party l):=TRANSFORM
    ofage := doxie.compliance.minor_ok(IF(l.orig_dob ='',0, ut.age((INTEGER) l.orig_dob)), mod_access.show_minors);

    underage := 'UNDERAGE INDIVIDUAL';

    SELF.vehicle_key := l.vehicle_key;
    SELF.iteration_key := l.iteration_key;
    SELF.sequence_key := l.sequence_key;
    SELF.orig_name_type := l.orig_name_type;
    SELF.Append_Clean_Name.lname := IF(ofage, l.Append_Clean_Name.lname, underage);
    SELF.use_ssn := IF(ofage,IF(l.orig_ssn<>'',l.orig_ssn,l.append_ssn),'');
    SELF := IF(ofage,l);
    SELF := [];
  END;

  owner_recs := PROJECT(owner_recs1,is_ofage(LEFT));

  doxie.MAC_PruneOldSSNs(owner_recs,pruned_owner_recs,use_ssn,append_did);

  rec_base_w_ssn get_county(pruned_owner_recs l,census_data.Key_Fips2County r):=TRANSFORM
    SELF.county_name := r.county_name;
    SELF := l;
  END;

  owner_recs_w_county := JOIN(pruned_owner_recs,Census_Data.Key_Fips2County,KEYED(LEFT.Append_Clean_Address.st = RIGHT.state_code) AND
      KEYED(LEFT.Append_Clean_Address.fips_county=RIGHT.county_fips),get_county(LEFT,RIGHT),KEEP(1),LEFT OUTER);

  dup_own_recs := DEDUP(SORT(owner_recs_w_county,-date_last_seen,-reg_latest_effective_date, history, RECORD,EXCEPT Source_Code,State_Bitmap_Flag,Latest_Vehicle_Flag,Latest_Vehicle_Iteration_Flag,History,Date_First_Seen,Date_Last_Seen,Date_Vendor_First_Reported,
    Date_Vendor_Last_Reported,Orig_Party_Type,Orig_Conjunction),
    RECORD,EXCEPT Source_Code,State_Bitmap_Flag,Latest_Vehicle_Flag,Latest_Vehicle_Iteration_Flag,History,Date_First_Seen,Date_Last_Seen,Date_Vendor_First_Reported,
    Date_Vendor_Last_Reported,Orig_Party_Type,Orig_Conjunction);

  // add crim indicators
  recsIn := PROJECT(dup_own_recs,TRANSFORM({rec_base_w_ssn,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.append_did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
  dup_owner_recs := PROJECT(IF(includeCriminalIndicators,recsOut,recsIn),rec_base_w_ssn);

  layout_w_keys get_own(veh_recs l, dup_owner_recs r,INTEGER C):=TRANSFORM,skip(r.orig_name_type NOT IN ['1','2','4','5','7'] OR (r.orig_name_type in ['1','2'] AND l.owner_2_customer_type<>'') OR (r.orig_name_type in ['4','5'] AND l.registrant_2_customer_type<>'') OR (r.orig_name_type='7' AND l.lein_holder_3_customer_type <>'') OR
      (r.orig_name_type = '2' AND ExcludeLessors = TRUE))


      name_type := MAP(r.orig_name_type IN ['4','5'] AND l.registrant_1_customer_typexbg5=''=>'reg1',
                     r.orig_name_type IN ['4','5'] AND l.registrant_2_customer_type=''=>'reg2',
                     r.orig_name_type IN ['1','2'] AND l.owner_1_customer_typexbg3 = '' => 'own1',
                     r.orig_name_type IN ['1','2'] AND l.owner_2_customer_type = '' => 'own2',
                     r.orig_name_type = '7' AND l.lein_holder_1_customer_type = '' => 'lh1',
                     r.orig_name_type = '7' AND l.lein_holder_2_customer_type = '' => 'lh2',
                      'lh3');


    // county_from_key := choosen(Census_Data.Key_Fips2County(KEYED(state_code = r.Append_Clean_Address.st) and
    // KEYED(county_fips = r.Append_Clean_Address.fips_county)),1)[1].county_name;


      STRING company := IF(r.Orig_Party_Type='I','',TRIM(r.Orig_Name));
      raw_penalty := IF(report_mode OR alternate_route,0, doxie.FN_Tra_Penalty_DID((STRING)r.Append_did) +
            doxie.FN_Tra_Penalty_SSN(r.use_ssn) +
            doxie.FN_Tra_Penalty_Name(r.Append_Clean_Name.fname,
              r.Append_Clean_Name.mname, r.Append_Clean_Name.lname)+
            doxie.FN_Tra_Penalty_Addr(r.Append_Clean_Address.predir,
              r.Append_Clean_Address.prim_range,
              r.Append_Clean_Address.prim_name,
              r.Append_Clean_Address.addr_suffix,
              r.Append_Clean_Address.postdir,
              r.Append_Clean_Address.sec_range,
              r.Append_Clean_Address.v_city_name,
              r.Append_Clean_Address.St, r.Append_Clean_Address.zip5)+
              doxie.FN_Tra_Penalty_CName(company));
    SELF.party_penalty := MAP(report_mode OR alternate_route=> 0,
                              l.party_penalty < raw_penalty AND C <> 1 =>l.party_penalty,
                              raw_penalty);


    SELF.NonDMVSource := r.source_code in MDR.sourceTools.set_infutor_all_veh;
    SELF.odometer_status := IF(l.odometer_status<>'',l.odometer_status, r.Ttl_Odometer_Status_Code); //party
    SELF.odometer_date := IF(l.odometer_date<>'',l.odometer_date, r.Ttl_Odometer_Date); // party
    SELF.odometer_mileage := IF(l.odometer_mileage<>'',l.odometer_mileage, r.Ttl_Odometer_Mileage); // party

    SELF.owner_1_customer_typexbg3 := IF(name_type='own1',
    IF(r.Append_Clean_CName <> '','B','I'),l.owner_1_customer_typexbg3);
    SELF.own_1_feid_ssn :=IF(name_type= 'own1',r.use_ssn,l.own_1_feid_ssn) ; // party
    SELF.own_1_customer_name :=IF(name_type= 'own1', r.Orig_Name,l.own_1_customer_name); //party
    SELF.own_1_driver_license_number :=IF(name_type= 'own1', r.Orig_DL_Number,l.own_1_driver_license_number);// party
    SELF.own_1_dob := IF(name_type= 'own1',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.own_1_dob); // party
    SELF.own_1_sex :=IF(name_type= 'own1', r.orig_sex,l.own_1_sex);//party
    SELF.own_1_address_number := IF(name_type= 'own1',r.Append_Clean_Address.prim_range,l.own_1_address_number);//party
    SELF.own_1_street_address := IF(name_type= 'own1',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
      r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.own_1_street_address); //party
    SELF.own_1_apartment_number := IF(name_type= 'own1',r.Append_Clean_Address.sec_range,l.own_1_apartment_number); //party
    SELF.own_1_city := IF(name_type= 'own1',r.Append_Clean_Address.v_city_name,l.own_1_city); // party
    SELF.own_1_state :=IF(name_type= 'own1', r.Append_Clean_Address.st,l.own_1_state); //party
    SELF.own_1_state_2 := IF(name_type= 'own1', r.Append_Clean_Address.st,l.own_1_state);
    SELF.own_1_zip5_zip4_foreign_postal := IF(name_type= 'own1',r.Append_Clean_Address.zip5,l.own_1_zip5_zip4_foreign_postal); // party
    SELF.own_1_title := IF(name_type= 'own1',r.Append_Clean_Name.title,l.own_1_title);
    SELF.own_1_fname := IF(name_type= 'own1',r.Append_Clean_Name.fname,l.own_1_fname) ;
    SELF.own_1_mname :=IF(name_type= 'own1', r.Append_Clean_Name.mname,l.own_1_mname);
    SELF.own_1_lname :=IF(name_type= 'own1', r.Append_Clean_Name.lname,l.own_1_lname);
    SELF.own_1_name_suffix := IF(name_type= 'own1',r.Append_Clean_Name.name_suffix, l.own_1_name_suffix);
    SELF.own_1_did :=IF(name_type= 'own1', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.own_1_did) ;
    SELF.own_1_ssn := IF(name_type= 'own1',r.append_ssn, l.own_1_ssn);
    SELF.own_1_company_name := IF(name_type= 'own1',r.Append_Clean_CName,l.own_1_company_name);
    SELF.own_1_prim_range := IF(name_type= 'own1',r.Append_Clean_Address.prim_range,l.own_1_prim_range);
    SELF.own_1_predir:= IF(name_type= 'own1',r.Append_Clean_Address.predir,l.own_1_predir);
    SELF.own_1_prim_name := IF(name_type= 'own1',r.Append_Clean_Address.prim_name,l.own_1_prim_name);
    SELF.own_1_suffix := IF(name_type= 'own1',r.Append_Clean_Address.addr_suffix,l.own_1_suffix);
    SELF.own_1_postdir:= IF(name_type= 'own1',r.Append_Clean_Address.postdir,l.own_1_postdir);
    SELF.own_1_unit_desig := IF(name_type= 'own1',r.Append_Clean_Address.unit_desig,l.own_1_unit_desig);
    SELF.own_1_sec_range := IF(name_type= 'own1',r.Append_Clean_Address.sec_range,l.own_1_sec_range);
    SELF.own_1_p_city_name := IF(name_type= 'own1',r.Append_Clean_Address.v_city_name,l.own_1_p_city_name);
    SELF.own_1_v_city_name:= IF(name_type= 'own1',r.Append_Clean_Address.v_city_name,l.own_1_v_city_name);
    SELF.own_1_zip5 := IF(name_type= 'own1',r.Append_Clean_Address.Zip5,l.own_1_zip5);
    SELF.own_1_zip4 := IF(name_type='own1',r.Append_Clean_Address.Zip4,l.own_1_zip4);
    SELF.own_1_county := IF(name_type='own1',r.Append_Clean_Address.fips_county,l.own_1_county);
    SELF.own_1_residence_county := IF(name_type='own1',r.Append_Clean_Address.fips_county,l.own_1_residence_county);

    SELF.own_1_bdid := IF(name_type='own1',r.Append_bdid,l.own_1_bdid);
    SELF.OWN_1_CUSTOMER_NUMBER := '';
    SELF.own_1_county_name := IF(name_type='own1',r.county_name,l.own_1_county_name);
    SELF.own_1_geo_lat := IF(name_type='own1',r.Append_Clean_Address.geo_lat, l.own_1_geo_lat);
    SELF.own_1_geo_long := IF(name_type='own1',r.Append_Clean_Address.geo_long,l.own_1_geo_long);
    SELF.own_1_preglb_did := '';
    SELF.own_1_hasCriminalConviction := IF(name_type='own1',r.hasCriminalConviction,l.own_1_hasCriminalConviction);
    SELF.own_1_isSexualOffender := IF(name_type='own1',r.isSexualOffender,l.own_1_isSexualOffender);
    SELF.own_1_src_first_date := IF(name_type='own1',(STRING8)ut.min2((UNSIGNED)l.own_1_src_first_date,(UNSIGNED)r.src_first_date),l.own_1_src_first_date);
    SELF.own_1_src_last_date := IF(name_type='own1',(STRING8)MAX((UNSIGNED)l.own_1_src_last_date,(UNSIGNED)r.src_last_date),l.own_1_src_last_date);

    SELF.owner_2_customer_type := IF(name_type='own2',
      IF(r.Append_Clean_CName <> '','B','I'),l.owner_2_customer_type);
    SELF.own_2_feid_ssn :=IF(name_type= 'own2',r.use_ssn,l.own_2_feid_ssn) ; // party
    SELF.own_2_customer_name :=IF(name_type= 'own2', r.Orig_Name,l.own_2_customer_name); //party
    SELF.own_2_driver_license_number :=IF(name_type= 'own2', r.Orig_DL_Number,l.own_2_driver_license_number);// party
    SELF.own_2_dob := IF(name_type= 'own2',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.own_2_dob); // party
    SELF.own_2_sex :=IF(name_type= 'own2', r.orig_sex,l.own_2_sex);//party
    SELF.own_2_address_number := IF(name_type= 'own2',r.Append_Clean_Address.prim_range,l.own_2_address_number);//party
    SELF.own_2_street_address := IF(name_type= 'own2',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.own_2_street_address); //party
    SELF.own_2_apartment_number := IF(name_type= 'own2',r.Append_Clean_Address.sec_range,l.own_2_apartment_number); //party
    SELF.own_2_city := IF(name_type= 'own2',r.Append_Clean_Address.v_city_name,l.own_2_city); // party
    SELF.own_2_state :=IF(name_type= 'own2', r.Append_Clean_Address.st,l.own_2_state); //party
    SELF.own_2_state_2 :=IF(name_type= 'own2', r.Append_Clean_Address.st,l.own_2_state); //party
    SELF.own_2_zip5_zip4_foreign_postal := IF(name_type= 'own2',r.Append_Clean_Address.zip5,l.own_2_zip5_zip4_foreign_postal); // party
    SELF.own_2_title := IF(name_type= 'own2',r.Append_Clean_Name.title,l.own_2_title);
    SELF.own_2_fname := IF(name_type= 'own2',r.Append_Clean_Name.fname,l.own_2_fname) ;
    SELF.own_2_mname :=IF(name_type= 'own2', r.Append_Clean_Name.mname,l.own_2_mname);
    SELF.own_2_lname :=IF(name_type= 'own2', r.Append_Clean_Name.lname,l.own_2_lname);
    SELF.own_2_name_suffix := IF(name_type= 'own2',r.Append_Clean_Name.name_suffix, l.own_2_name_suffix);
    SELF.own_2_did :=IF(name_type= 'own2', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.own_2_did);
    SELF.own_2_ssn := IF(name_type= 'own2',r.append_ssn, l.own_2_ssn);
    SELF.own_2_company_name := IF(name_type= 'own2',r.Append_Clean_CName,l.own_2_company_name);
    SELF.own_2_prim_range := IF(name_type= 'own2',r.Append_Clean_Address.prim_range,l.own_2_prim_range);
    SELF.own_2_predir:= IF(name_type= 'own2',r.Append_Clean_Address.predir,l.own_2_predir);
    SELF.own_2_prim_name := IF(name_type= 'own2',r.Append_Clean_Address.prim_name,l.own_2_prim_name);
    SELF.own_2_suffix := IF(name_type= 'own2',r.Append_Clean_Address.addr_suffix,l.own_2_suffix);
    SELF.own_2_postdir:= IF(name_type= 'own2',r.Append_Clean_Address.postdir,l.own_2_postdir);
    SELF.own_2_unit_desig := IF(name_type= 'own2',r.Append_Clean_Address.unit_desig,l.own_2_unit_desig);
    SELF.own_2_sec_range := IF(name_type= 'own2',r.Append_Clean_Address.sec_range,l.own_2_sec_range);
    SELF.own_2_p_city_name := IF(name_type= 'own2',r.Append_Clean_Address.v_city_name,l.own_2_p_city_name);
    SELF.own_2_v_city_name:= IF(name_type= 'own2',r.Append_Clean_Address.v_city_name,l.own_2_v_city_name);
    SELF.own_2_zip5 := IF(name_type= 'own2',r.Append_Clean_Address.Zip5,l.own_2_zip5);
    SELF.own_2_zip4 := IF(name_type='own2',r.Append_Clean_Address.Zip4,l.own_2_zip4);
    SELF.own_2_county := IF(name_type='own2',r.Append_Clean_Address.fips_county,l.own_2_county);
    SELF.own_2_residence_county := IF(name_type='own2',r.Append_Clean_Address.fips_county,l.own_2_residence_county);

    SELF.own_2_bdid := IF(name_type='own2',r.Append_bdid,l.own_2_bdid);
    SELF.OWN_2_CUSTOMER_NUMBER := '';
    SELF.own_2_county_name := IF(name_type='own2',r.county_name,l.own_2_county_name);
    SELF.own_2_geo_lat := IF(name_type='own2',r.Append_Clean_Address.geo_lat, l.own_2_geo_lat);
    SELF.own_2_geo_long := IF(name_type='own2',r.Append_Clean_Address.geo_long,l.own_2_geo_long);
    SELF.own_2_preglb_did := '';
    SELF.own_2_hasCriminalConviction := IF(name_type='own2',r.hasCriminalConviction,l.own_2_hasCriminalConviction);
    SELF.own_2_isSexualOffender := IF(name_type='own2',r.isSexualOffender,l.own_2_isSexualOffender);
    SELF.own_2_src_first_date := IF(name_type='own2',(STRING8)ut.min2((UNSIGNED)l.own_2_src_first_date,(UNSIGNED)r.src_first_date),l.own_2_src_first_date);
    SELF.own_2_src_last_date := IF(name_type='own2',(STRING8)MAX((UNSIGNED)l.own_2_src_last_date,(UNSIGNED)r.src_last_date),l.own_2_src_last_date);

    SELF.registrant_1_customer_typexbg5 := IF(name_type='reg1',
        IF(r.Append_Clean_CName <> '','B','I'),l.registrant_1_customer_typexbg5);
    SELF.reg_1_feid_ssn :=IF(name_type= 'reg1',r.use_ssn,l.reg_1_feid_ssn) ; // party
    SELF.reg_1_customer_name :=IF(name_type= 'reg1', r.Orig_Name,l.reg_1_customer_name); //party
    SELF.reg_1_driver_license_number :=IF(name_type= 'reg1', r.Orig_DL_Number,l.reg_1_driver_license_number);// party
    SELF.reg_1_dob := IF(name_type= 'reg1',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.reg_1_dob); // party
    SELF.reg_1_sex :=IF(name_type= 'reg1', r.orig_sex,l.reg_1_sex);//party
    SELF.reg_1_address_number := IF(name_type= 'reg1',r.Append_Clean_Address.prim_range,l.reg_1_address_number);//party
    SELF.reg_1_street_address := IF(name_type= 'reg1',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.reg_1_street_address); //party
    SELF.reg_1_apartment_number := IF(name_type= 'reg1',r.Append_Clean_Address.sec_range,l.reg_1_apartment_number); //party
    SELF.reg_1_city := IF(name_type= 'reg1',r.Append_Clean_Address.v_city_name,l.reg_1_city); // party
    SELF.reg_1_state :=IF(name_type= 'reg1', r.Append_Clean_Address.st,l.reg_1_state); //party
    SELF.reg_1_state_2 :=IF(name_type= 'reg1', r.Append_Clean_Address.st,l.reg_1_state);
    SELF.reg_1_zip5_zip4_foreign_postal := IF(name_type= 'reg1',r.Append_Clean_Address.zip5,l.reg_1_zip5_zip4_foreign_postal); // party
    SELF.reg_1_title := IF(name_type= 'reg1',r.Append_Clean_Name.title,l.reg_1_title);
    SELF.reg_1_fname := IF(name_type= 'reg1',r.Append_Clean_Name.fname,l.reg_1_fname) ;
    SELF.reg_1_mname :=IF(name_type= 'reg1', r.Append_Clean_Name.mname,l.reg_1_mname);
    SELF.reg_1_lname :=IF(name_type= 'reg1', r.Append_Clean_Name.lname,l.reg_1_lname);
    SELF.reg_1_name_suffix := IF(name_type= 'reg1',r.Append_Clean_Name.name_suffix, l.reg_1_name_suffix);
    SELF.reg_1_did :=IF(name_type= 'reg1', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.reg_1_did) ;
    SELF.reg_1_ssn := IF(name_type= 'reg1',r.append_ssn, l.reg_1_ssn);
    SELF.reg_1_company_name := IF(name_type= 'reg1',r.Append_Clean_CName,l.reg_1_company_name);
    SELF.reg_1_prim_range := IF(name_type= 'reg1',r.Append_Clean_Address.prim_range,l.reg_1_prim_range);
    SELF.reg_1_predir:= IF(name_type= 'reg1',r.Append_Clean_Address.predir,l.reg_1_predir);
    SELF.reg_1_prim_name := IF(name_type= 'reg1',r.Append_Clean_Address.prim_name,l.reg_1_prim_name);
    SELF.reg_1_suffix := IF(name_type= 'reg1',r.Append_Clean_Address.addr_suffix,l.reg_1_suffix);
    SELF.reg_1_postdir:= IF(name_type= 'reg1',r.Append_Clean_Address.postdir,l.reg_1_postdir);
    SELF.reg_1_unit_desig := IF(name_type= 'reg1',r.Append_Clean_Address.unit_desig,l.reg_1_unit_desig);
    SELF.reg_1_sec_range := IF(name_type= 'reg1',r.Append_Clean_Address.sec_range,l.reg_1_sec_range);
    SELF.reg_1_p_city_name := IF(name_type= 'reg1',r.Append_Clean_Address.v_city_name,l.reg_1_p_city_name);
    SELF.reg_1_v_city_name:= IF(name_type= 'reg1',r.Append_Clean_Address.v_city_name,l.reg_1_v_city_name);
    SELF.reg_1_zip5 := IF(name_type= 'reg1',r.Append_Clean_Address.Zip5,l.reg_1_zip5);
    SELF.reg_1_zip4 := IF(name_type='reg1',r.Append_Clean_Address.Zip4,l.reg_1_zip4);
    SELF.reg_1_county := IF(name_type='reg1',r.Append_Clean_Address.fips_county,l.reg_1_county);
    SELF.reg_1_residence_county := IF(name_type='reg1',r.Append_Clean_Address.fips_county,l.reg_1_residence_county);

    SELF.reg_1_bdid := IF(name_type='reg1',r.Append_bdid,l.reg_1_bdid);
    SELF.reg_1_CUSTOMER_NUMBER := '';
    SELF.reg_1_county_name := IF(name_type='reg1',r.county_name,l.reg_1_county_name);
    SELF.reg_1_geo_lat := IF(name_type='reg1',r.Append_Clean_Address.geo_lat, l.reg_1_geo_lat);
    SELF.reg_1_geo_long := IF(name_type='reg1',r.Append_Clean_Address.geo_long,l.reg_1_geo_long);
    SELF.reg_1_preglb_did := '';
    SELF.reg_1_hasCriminalConviction := IF(name_type='reg1',r.hasCriminalConviction,l.reg_1_hasCriminalConviction);
    SELF.reg_1_isSexualOffender := IF(name_type='reg1',r.isSexualOffender,l.reg_1_isSexualOffender);


    SELF.registrant_2_customer_type :=IF(name_type='reg2',
        IF(r.Append_Clean_CName <> '','B','I'),l.registrant_2_customer_type);
    SELF.reg_2_feid_ssn :=IF(name_type= 'reg2',r.use_ssn,l.reg_2_feid_ssn) ; // party
    SELF.reg_2_customer_name :=IF(name_type= 'reg2', r.Orig_Name,l.reg_2_customer_name); //party
    SELF.reg_2_driver_license_number :=IF(name_type= 'reg2', r.Orig_DL_Number,l.reg_2_driver_license_number);// party
    SELF.reg_2_dob := IF(name_type= 'reg2',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.reg_2_dob); // party
    SELF.reg_2_sex :=IF(name_type= 'reg2', r.orig_sex,l.reg_2_sex);//party
    SELF.reg_2_address_number := IF(name_type= 'reg2',r.Append_Clean_Address.prim_range,l.reg_2_address_number);//party
    SELF.reg_2_street_address := IF(name_type= 'reg2',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.reg_2_street_address); //party
    SELF.reg_2_apartment_number := IF(name_type= 'reg2',r.Append_Clean_Address.sec_range,l.reg_2_apartment_number); //party
    SELF.reg_2_city := IF(name_type= 'reg2',r.Append_Clean_Address.v_city_name,l.reg_2_city); // party
    SELF.reg_2_state :=IF(name_type= 'reg2', r.Append_Clean_Address.st,l.reg_2_state); //party
    SELF.reg_2_state_2 :=IF(name_type= 'reg2', r.Append_Clean_Address.st,l.reg_2_state);
    SELF.reg_2_zip5_zip4_foreign_postal := IF(name_type= 'reg2',r.Append_Clean_Address.zip5,l.reg_2_zip5_zip4_foreign_postal); // party
    SELF.reg_2_title := IF(name_type= 'reg2',r.Append_Clean_Name.title,l.reg_2_title);
    SELF.reg_2_fname := IF(name_type= 'reg2',r.Append_Clean_Name.fname,l.reg_2_fname) ;
    SELF.reg_2_mname :=IF(name_type= 'reg2', r.Append_Clean_Name.mname,l.reg_2_mname);
    SELF.reg_2_lname :=IF(name_type= 'reg2', r.Append_Clean_Name.lname,l.reg_2_lname);
    SELF.reg_2_name_suffix := IF(name_type= 'reg2',r.Append_Clean_Name.name_suffix, l.reg_2_name_suffix);
    SELF.reg_2_did :=IF(name_type= 'reg2', IF (r.append_did = 0, '', INTFORMAT (r.append_did, 12, 1)), l.reg_2_did);
    SELF.reg_2_ssn := IF(name_type= 'reg2',r.append_ssn, l.reg_2_ssn);
    SELF.reg_2_company_name := IF(name_type= 'reg2',r.Append_Clean_CName,l.reg_2_company_name);
    SELF.reg_2_prim_range := IF(name_type= 'reg2',r.Append_Clean_Address.prim_range,l.reg_2_prim_range);
    SELF.reg_2_predir:= IF(name_type= 'reg2',r.Append_Clean_Address.predir,l.reg_2_predir);
    SELF.reg_2_prim_name := IF(name_type= 'reg2',r.Append_Clean_Address.prim_name,l.reg_2_prim_name);
    SELF.reg_2_suffix := IF(name_type= 'reg2',r.Append_Clean_Address.addr_suffix,l.reg_2_suffix);
    SELF.reg_2_postdir:= IF(name_type= 'reg2',r.Append_Clean_Address.postdir,l.reg_2_postdir);
    SELF.reg_2_unit_desig := IF(name_type= 'reg2',r.Append_Clean_Address.unit_desig,l.reg_2_unit_desig);
    SELF.reg_2_sec_range := IF(name_type= 'reg2',r.Append_Clean_Address.sec_range,l.reg_2_sec_range);
    SELF.reg_2_p_city_name := IF(name_type= 'reg2',r.Append_Clean_Address.v_city_name,l.reg_2_p_city_name);
    SELF.reg_2_v_city_name:= IF(name_type= 'reg2',r.Append_Clean_Address.v_city_name,l.reg_2_v_city_name);
    SELF.reg_2_zip5 := IF(name_type= 'reg2',r.Append_Clean_Address.Zip5,l.reg_2_zip5);
    SELF.reg_2_zip4 := IF(name_type='reg2',r.Append_Clean_Address.Zip4,l.reg_2_zip4);
    SELF.reg_2_county := IF(name_type='reg2',r.Append_Clean_Address.fips_county,l.reg_2_county);
    SELF.reg_2_residence_county := IF(name_type='reg2',r.Append_Clean_Address.fips_county,l.reg_2_residence_county);

    SELF.reg_2_bdid := IF(name_type='reg2',r.Append_bdid,l.reg_2_bdid);
    SELF.reg_2_CUSTOMER_NUMBER := '';
    SELF.reg_2_county_name := IF(name_type='reg2',r.county_name,l.reg_2_county_name);
    SELF.reg_2_geo_lat := IF(name_type='reg2',r.Append_Clean_Address.geo_lat, l.reg_2_geo_lat);
    SELF.reg_2_geo_long := IF(name_type='reg2',r.Append_Clean_Address.geo_long,l.reg_2_geo_long);
    SELF.reg_2_preglb_did := '';
    SELF.reg_2_hasCriminalConviction := IF(name_type='reg2',r.hasCriminalConviction,l.reg_2_hasCriminalConviction);
    SELF.reg_2_isSexualOffender := IF(name_type='reg2',r.isSexualOffender,l.reg_2_isSexualOffender);


    SELF.lein_holder_1_customer_type := IF(name_type='lh1',
        IF(r.Append_Clean_CName <> '','B','I'),l.lein_holder_1_customer_type);
    SELF.lh_1_feid_ssn :=IF(name_type= 'lh1',r.use_ssn,l.lh_1_feid_ssn) ; // party
    SELF.lh_1_customer_name :=IF(name_type= 'lh1', r.Orig_Name,l.lh_1_customer_name); //party
    SELF.lh_1_driver_license_number :=IF(name_type= 'lh1', r.Orig_DL_Number,l.lh_1_driver_license_number);// party
    SELF.lh_1_dob := IF(name_type= 'lh1',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.lh_1_dob); // party
    SELF.lh_1_sex :=IF(name_type= 'lh1', r.orig_sex,l.lh_1_sex);//party
    SELF.lh_1_address_number := IF(name_type= 'lh1',r.Append_Clean_Address.prim_range,l.lh_1_address_number);//party
    SELF.lh_1_street_address := IF(name_type= 'lh1',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.lh_1_street_address); //party
    SELF.lh_1_apartment_number := IF(name_type= 'lh1',r.Append_Clean_Address.sec_range,l.lh_1_apartment_number); //party
    SELF.lh_1_city := IF(name_type= 'lh1',r.Append_Clean_Address.v_city_name,l.lh_1_city); // party
    SELF.lh_1_state :=IF(name_type= 'lh1', r.Append_Clean_Address.st,l.lh_1_state); //party
    SELF.lh_1_zip5_zip4_foreign_postal := IF(name_type= 'lh1',r.Append_Clean_Address.zip5,l.lh_1_zip5_zip4_foreign_postal); // party
    SELF.lh_1_residence_county := IF(name_type='lh1',r.Append_Clean_Address.fips_county,l.lh_1_residence_county);
    SELF.lh_1_county_name := IF(name_type='lh1',r.county_name,l.lh_1_county_name);
    SELF.lh_1_zip5 := IF(name_type= 'lh1',r.Append_Clean_Address.Zip5,l.lh_1_zip5);
    SELF.lh_1_zip4 := IF(name_type='lh1',r.Append_Clean_Address.Zip4,l.lh_1_zip4);
    SELF.lh_1_lien_date := IF(name_type[1..2]='lh' AND l.lh_1_lien_date='',r.orig_lien_date, l.lh_1_lien_date);

    SELF.lein_holder_2_customer_type := IF(name_type='lh2',
        IF(r.Append_Clean_CName <> '','B','I'),l.lein_holder_2_customer_type);
    SELF.lh_2_feid_ssn :=IF(name_type= 'lh2',r.use_ssn,l.lh_2_feid_ssn) ; // party
    SELF.lh_2_customer_name :=IF(name_type= 'lh2', r.Orig_Name,l.lh_2_customer_name); //party
    SELF.lh_2_driver_license_number :=IF(name_type= 'lh2', r.Orig_DL_Number,l.lh_2_driver_license_number);// party
    SELF.lh_2_dob := IF(name_type= 'lh2',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.lh_2_dob); // party
    SELF.lh_2_sex :=IF(name_type= 'lh2', r.orig_sex,l.lh_2_sex);//party
    SELF.lh_2_address_number := IF(name_type= 'lh2',r.Append_Clean_Address.prim_range,l.lh_2_address_number);//party
    SELF.lh_2_street_address := IF(name_type= 'lh2',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.lh_2_street_address); //party
    SELF.lh_2_apartment_number := IF(name_type= 'lh2',r.Append_Clean_Address.sec_range,l.lh_2_apartment_number); //party
    SELF.lh_2_city := IF(name_type= 'lh2',r.Append_Clean_Address.v_city_name,l.lh_2_city); // party
    SELF.lh_2_state :=IF(name_type= 'lh2', r.Append_Clean_Address.st,l.lh_2_state); //party
    SELF.lh_2_zip5_zip4_foreign_postal := IF(name_type= 'lh2',r.Append_Clean_Address.zip5,l.lh_2_zip5_zip4_foreign_postal); // party
    SELF.lh_2_residence_county := IF(name_type='lh2',r.Append_Clean_Address.fips_county,l.lh_2_residence_county);
    SELF.lh_2_county_name := IF(name_type='lh2',r.county_name,l.lh_2_county_name);
    SELF.lh_2_zip5 := IF(name_type= 'lh2',r.Append_Clean_Address.Zip5,l.lh_2_zip5);
    SELF.lh_2_zip4 := IF(name_type='lh2',r.Append_Clean_Address.Zip4,l.lh_2_zip4);


    SELF.lein_holder_3_customer_type := IF(name_type='lh3',
            IF(r.Append_Clean_CName <> '','B','I'),l.lein_holder_3_customer_type);
    SELF.lh_3_feid_ssn :=IF(name_type= 'lh3',r.use_ssn,l.lh_3_feid_ssn) ; // party
    SELF.lh_3_customer_name :=IF(name_type= 'lh3', r.Orig_Name,l.lh_3_customer_name); //party
    SELF.lh_3_driver_license_number :=IF(name_type= 'lh3', r.Orig_DL_Number,l.lh_3_driver_license_number);// party
    SELF.lh_3_dob := IF(name_type= 'lh3',IF(((INTEGER)r.Orig_DOB) <> 0,r.Orig_Dob,''),l.lh_3_dob); // party
    SELF.lh_3_sex :=IF(name_type= 'lh3', r.orig_sex,l.lh_3_sex);//party
    SELF.lh_3_address_number := IF(name_type= 'lh3',r.Append_Clean_Address.prim_range,l.lh_3_address_number);//party
    SELF.lh_3_street_address := IF(name_type= 'lh3',
    Address.Addr1FromComponents(r.Append_Clean_Address.prim_range, r.Append_Clean_Address.predir, r.Append_Clean_Address.prim_name,
                         r.Append_Clean_Address.addr_suffix, r.Append_Clean_Address.postdir,r.Append_Clean_Address.unit_desig, r.Append_Clean_Address.sec_range)
    ,l.lh_3_street_address); //party
    SELF.lh_3_apartment_number := IF(name_type= 'lh3',r.Append_Clean_Address.sec_range,l.lh_3_apartment_number); //party
    SELF.lh_3_city := IF(name_type= 'lh3',r.Append_Clean_Address.v_city_name,l.lh_3_city); // party
    SELF.lh_3_state :=IF(name_type= 'lh3', r.Append_Clean_Address.st,l.lh_3_state); //party
    SELF.lh_3_zip5_zip4_foreign_postal := IF(name_type= 'lh3',r.Append_Clean_Address.zip5,l.lh_3_zip5_zip4_foreign_postal); // party
    SELF.lh_3_residence_county := IF(name_type='lh3',r.Append_Clean_Address.fips_county,l.lh_3_residence_county);
    SELF.lh_3_county_name := IF(name_type='lh3',r.county_name,l.lh_3_county_name);
    SELF.lh_3_zip5 := IF(name_type= 'lh3',r.Append_Clean_Address.Zip5,l.lh_3_zip5);
    SELF.lh_3_zip4 := IF(name_type='lh3',r.Append_Clean_Address.Zip4,l.lh_3_zip4);

    SELF.license_plate_numberxbg4 := IF(l.license_plate_numberxbg4<>'',l.license_plate_numberxbg4, r.Reg_License_Plate); //party
    SELF.true_license_plste_number := IF(l.true_license_plste_number<>'',l.true_license_plste_number, r.Reg_License_Plate);

    SELF.registration_effective_date :=IF(l.registration_effective_date<>'',l.registration_effective_date, r.Reg_Latest_Effective_Date);
    SELF.registration_expiration_date :=IF(l.registration_expiration_date<>'',l.registration_expiration_date, r.Reg_Latest_Expiration_Date);
    SELF.decal_number := IF(l.decal_number<>'',l.decal_number, r.Reg_Decal_Number); // party
    SELF.decal_year := IF(l.decal_year<>'',l.decal_year,r.Reg_Decal_Year);
    SELF.registration_status_code := IF(l.registration_status_code<>'',l.registration_status_code, r.Reg_Status_Code);
    SELF.license_plate_code := IF(l.license_plate_code<>'',l.license_plate_code, r.Reg_License_Plate_Type_Code);
    SELF.license_plate_desc := if(l.license_plate_desc<>'',l.license_plate_desc, r.Reg_License_Plate_Type_Desc);
    SELF.title_numberxbg9:=IF(l.title_numberxbg9<>'',l.title_numberxbg9, r.Ttl_Number);
    SELF.title_issue_date :=IF(l.title_issue_date<>'',l.title_issue_date, r.Ttl_Latest_Issue_Date);
    SELF.previous_title_issue_date := IF(l.previous_title_issue_date<>'',l.previous_title_issue_date, r.Ttl_Previous_Issue_Date);
    SELF.title_status_code :=IF(l.title_status_code<>'',l.title_status_code, r.Ttl_Status_Code);
    SELF.history_flag := IF(C=1 OR r.history='' OR (r.history='E' AND l.history_flag='H'), r.history,l.history_flag);

    date_last_seen := IF(r.date_last_seen > l.dt_last_seen, r.date_last_seen,l.dt_last_seen);

    SELF.dt_last_seen := IF(mod_access.date_threshold > 0 AND date_last_seen > mod_access.date_threshold,
        mod_access.date_threshold, date_last_seen);
    SELF.dt_vendor_last_reported := IF(r.date_vendor_last_reported > l.dt_vendor_last_reported,
      r.date_vendor_last_reported,l.dt_vendor_last_reported);
    SELF.dt_first_seen := IF((r.date_first_seen < l.dt_first_seen AND r.date_first_seen <> 0) OR C=1, r.date_first_seen,
      l.dt_first_seen);
    SELF.dt_vendor_first_reported := IF((r.date_vendor_first_reported < l.dt_vendor_first_reported AND r.date_vendor_first_reported <> 0) OR C=1, r.date_vendor_first_reported,
      l.dt_vendor_first_reported);
    SELF.price := l.vina_price;
    SELF.history := SELF.history_flag;
    SELF.orig_state := r.state_origin;
    SELF.source := doxie_build.buildstate;
    SELF.first_registration_date :=IF( ((UNSIGNED4) r.reg_first_date < (UNSIGNED4) l.first_registration_date AND (UNSIGNED4) r.reg_first_date <> 0) OR c=1, r.reg_first_date,l.first_registration_date);
    pick := CASE((UNSIGNED1) r.orig_name_type,
                1 => 1,
                2 => 2,
                4 => 3,
                5 => 4, 0);
    SELF.pick := IF(l.wd_person_source=pick AND l.pick = 0,
        MAP(name_type='own1'=> 1,
            name_type='own2' => 2,
            name_type='reg1' => 3,
            name_type='reg2'=>4,
            0),l.pick);//IF(pick > 0 AND pick < l.pick, pick, l.pick);
    SELF.seq := l.input.seq;
    SELF := l;
    SELF := r;
    SELF := [];
  END;


  veh_w_owners0 := DENORMALIZE(veh_recs,dup_owner_recs,
    LEFT.vehicle_key=RIGHT.vehicle_key AND LEFT.iteration_key=RIGHT.iteration_key
    AND LEFT.sequence_key = RIGHT.sequence_key,get_own(LEFT,RIGHT,COUNTER),GROUPED)
    (owner_1_customer_typexbg3 <> '' OR registrant_1_customer_typexbg5 <> '' OR
    lein_holder_1_customer_type <> '');

  ssn_mask_value := mod_access.ssn_mask;
  Suppress.MAC_Mask(veh_w_owners0, veh_w_owners1, own_1_feid_ssn, null, TRUE, FALSE);
  Suppress.MAC_Mask(veh_w_owners1, veh_w_owners2, own_2_feid_ssn, null, TRUE, FALSE);
  Suppress.MAC_Mask(veh_w_owners2, veh_w_owners3, reg_1_feid_ssn, null, TRUE, FALSE);
  Suppress.MAC_Mask(veh_w_owners3, veh_w_owners4, reg_2_feid_ssn, null, TRUE, FALSE);
  Suppress.MAC_Mask(veh_w_owners4, veh_w_owners5, lh_1_feid_ssn, null, TRUE, FALSE);
  Suppress.MAC_Mask(veh_w_owners5, veh_w_owners6, lh_2_feid_ssn, null, TRUE, FALSE);
  Suppress.MAC_Mask(veh_w_owners6, gr_veh_w_owners, lh_3_feid_ssn, null, TRUE, FALSE);

  veh_w_owners := UNGROUP(gr_veh_w_owners);


  veh_w_owners_allowed := veh_w_owners((mod_access.ln_branded OR source_code NOT IN mdr.Source_is_lnOnly) AND
            (mod_access.date_threshold=0 OR dt_first_seen <= mod_access.date_threshold));


  cdk := codes.Key_Codes_V3;


layout_w_keys getDecode(layout_w_keys L, cdk R, STRING field) :=
TRANSFORM
  SELF.history_name := IF(field = 'history_name',
    IF((R.long_desc='CURRENT' AND (l.registrant_1_customer_typexbg5<>'' OR l.registrant_2_customer_type<>'')) OR R.long_desc ='UNKNOWN'
    ,R.long_desc,'HISTORICAL'),L.history_name);
  SELF.major_color_name := IF(field = 'major_color_name', R.long_desc, L.major_color_name);
  SELF.minor_color_name := IF(field = 'minor_color_name', R.long_desc, L.minor_color_name);
  SELF.orig_state_name := IF(field = 'state_origin_name', R.long_desc, L.orig_state_name);
  SELF.body_code_name := IF(field = 'body_code_name', R.long_desc, L.body_code_name);
  SELF.fuel_type_name := IF(field = 'fuel_type_name', R.long_desc, L.fuel_type_name);
  SELF.hull_material_type_name := IF(field = 'hull_material_type_name', R.long_desc, L.hull_material_type_name);
  SELF.license_plate_code_name := IF(field = 'license_plate_code_name', R.long_desc, L.license_plate_code_name);
  SELF.odometer_status_name := IF(field = 'odometer_status_name', R.long_desc, L.odometer_status_name);
  SELF.title_status_code_name := IF(field = 'title_status_code_name', R.long_desc, L.title_status_code_name);
  SELF.vehicle_type_name := IF(field = 'vehicle_type_name', R.long_desc, L.vehicle_type_name);
  SELF.vehicle_use_name := IF(field = 'vehicle_use_name', R.long_desc, L.vehicle_use_name);
  SELF.vessel_propulsion_type_name := IF(field = 'vessel_propulsion_type_name', R.long_desc, L.vessel_propulsion_type_name);
  SELF.vessel_type_name := IF(field = 'vessel_type_name', R.long_desc, L.vessel_type_name);
  SELF := L;
END;

o1 := JOIN(veh_w_owners_allowed,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'HISTORY_FLAG') AND
        (STRING15)LEFT.history = RIGHT.code,
      getDecode(LEFT,RIGHT,'history_name'),LEFT OUTER, KEEP(1), LIMIT(0));

o2 := JOIN(o1,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'MAJOR_COLOR_CODE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.major_color_code = RIGHT.code),
      getDecode(LEFT, RIGHT, 'major_color_name'), LEFT OUTER, KEEP(1), LIMIT(0));
o3 := JOIN(o2,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'MINOR_COLOR_CODE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.minor_color_code = RIGHT.code),
      getDecode(LEFT,RIGHT, 'minor_color_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o4 := JOIN(o3,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'BODY_CODE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.body_code = RIGHT.code),
      getDecode(LEFT,RIGHT,'body_code_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o5 := JOIN(o4,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'FUEL_TYPE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.fuel_type = RIGHT.code),
      getDecode(LEFT,RIGHT,'fuel_type_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o6 := JOIN(o5,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'HULL_MATERIAL_TYPE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.hull_material_type = RIGHT.code),
      getDecode(LEFT,RIGHT,'hull_material_type_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o7 := JOIN(o6,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'LICENSE_PLATE_CODE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.license_plate_code = RIGHT.code),
      getDecode(LEFT,RIGHT,'license_plate_code_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o8 := JOIN(o7,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'ODOMETER_STATUS') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.odometer_status = RIGHT.code),
      getDecode(LEFT,RIGHT,'odometer_status_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o9 := JOIN(o8,cdk, KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'TITLE_STATUS_CODE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.title_status_code = RIGHT.code),
      getDecode(LEFT,RIGHT,'title_status_code_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o10 := JOIN(o9,cdk, KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'VEHICLE_TYPE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.vehicle_type = RIGHT.code),
      getDecode(LEFT,RIGHT,'vehicle_type_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o11 := JOIN(o10,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'VEHICLE_USE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.vehicle_use = RIGHT.code),
      getDecode(LEFT,RIGHT,'vehicle_use_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o12 := JOIN(o11,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'VESSEL_PROPULSION_TYPE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.vessel_propulsion_type = RIGHT.code),
      getDecode(LEFT,RIGHT,'vessel_propulsion_type_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o13 := JOIN(o12,cdk,
        KEYED (RIGHT.file_name = (STRING35)'VEHICLE_REGISTRATION') AND
        KEYED (RIGHT.field_name= (STRING50)'VESSEL_TYPE') AND
        KEYED ((STRING5)LEFT.state_origin = RIGHT.field_name2) AND
        KEYED ((STRING15)LEFT.vessel_type = RIGHT.code),
      getDecode(LEFT,RIGHT,'vessel_type_name'),LEFT OUTER, KEEP(1), LIMIT(0));
o14 := JOIN(o13,cdk,
        KEYED (RIGHT.file_name = (STRING35)'GENERAL') AND
        KEYED (RIGHT.field_name= (STRING50)'STATE_LONG') AND
        (STRING15)LEFT.state_origin = RIGHT.code,
      getDecode(LEFT,RIGHT,'state_origin_name'),LEFT OUTER, KEEP(1), LIMIT(0));

  out_layout := RECORD
    doxie_Raw.Layout_VehRawBatchInput.input_layout input;
    doxie.Layout_VehicleSearch_wCrimInd;
    //adding the plate type desc for the wildcard_search service
    STRING65 license_plate_desc := '';
  END;

  out_layout map_lein_holder_county_names(o14 L) := TRANSFORM
    SELF.vid :=(QSTRING25) L.vehicle_numberxbg1;
    SELF := L;
  END;

  o15 := UNGROUP(PROJECT(o14,map_lein_holder_county_names(LEFT)));

  RETURN o15;

END;
