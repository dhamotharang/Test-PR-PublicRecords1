IMPORT Autokey_batch, VehicleV2_Services, Address, VehicleV2, BatchServices,
       AutokeyB2, AutoStandardI, BIPV2, STD, doxie, Suppress;

EXPORT Vin_Batch_Service_records(DATASET(VehicleV2_Services.Batch_Layout.Vin_BatchIn) data_in,
                                 VehicleV2_Services.IParam.RTBatch_V2_params in_param) := FUNCTION

mod_access := PROJECT(in_param,doxie.IDataAccess,opt);

// Keys
  keyVDID := VehicleV2.Key_Vehicle_DID;
  keyVVIN := VehicleV2.Key_vehicle_VIN;
  keyVPK := VehicleV2.Key_Vehicle_Party_Key;

  // Aliases
  Consts := VehicleV2.Constant;
  AutoKeyBatchInput := Autokey_batch.Layouts.rec_inBatchMaster;
  ResultFlat := Batch_Layout.layout_out;
  OutRec := Batch_Layout.final_layout;

  // Constants
  STRING BLNK := '';
  STRING NOT_NUMBER := '\\D+';
  UNSIGNED MaxDIDs := 100;

  // Functions
  trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);
  toUpper(STRING input) := STD.Str.ToUpperCase(trimBoth(input));

  // Records/Transforms
  AutoKeyBatchInput cleanInput(VehicleV2_Services.Batch_Layout.VIN_BatchIn input) := TRANSFORM
    state_in := toUpper(input.st);
    dlstate_in := toUpper(input.dlstate);
    plstate_in := toUpper(input.PlateState);

    SELF.name_first := toUpper(input.name_first);
    SELF.name_middle := toUpper(input.name_middle);
    SELF.name_last := toUpper(input.name_last);
    SELF.name_suffix := toUpper(input.name_suffix);
    SELF.p_city_name := toUpper(input.p_city_name);
    SELF.st := IF(LENGTH(state_in) > 2, Address.Map_State_Name_To_Abbrev(state_in), state_in);
    SELF.ssn := REGEXREPLACE(NOT_NUMBER, input.ssn, BLNK);
    SELF.dl := toUpper(input.dl);
    SELF.dlstate := IF(LENGTH(dlstate_in) > 2, Address.Map_State_Name_To_Abbrev(dlstate_in), dlstate_in);
    SELF.vin := toUpper(input.vin);
    SELF.Plate := toUpper(input.Plate);
    SELF.PlateState := IF(LENGTH(plstate_in) > 2, Address.Map_State_Name_To_Abbrev(plstate_in), plstate_in);
    SELF := input;
  END;

  AcctRec := RECORD(VehicleV2_Services.Layout_Vehicle_Key)
    VehicleV2_Services.Batch_Layout.vin_rec - st;
    UNSIGNED6 did := 0;
    VehicleV2_Services.Batch_Layout.bip_ids;
  END;
  AcctRec_Plus := RECORD(AcctRec)
   UNSIGNED4 global_sid;
   UNSIGNED8 record_sid;
  END;

  AcctRec fromKeyVDID(AcctRec l, keyVDID r) := TRANSFORM
    SELF.did := r.Append_DID;
    SELF := r;
    SELF := l;
  END;

  AcctRec_Plus fromKeyVPK(AcctRec l, keyVPK r) := TRANSFORM
    SELF.did := r.Append_DID;
    SELF := r;
    SELF := l;
  END;

  OutRec toOutput(ResultFlat l, AutoKeyBatchInput r) := TRANSFORM

    _effective_date := IF(in_param.Is_UseDate, Functions_RTBatch_V2.min_date(l.reg_latest_effective_date, l.reg_earliest_effective_date), l.reg_latest_effective_date);

    BOOLEAN filterByDate := LENGTH(TRIM(r.date))=8 AND _effective_date<>'' AND l.reg_latest_expiration_date<>'';

    BOOLEAN filterByYear := LENGTH(TRIM(r.date))=4 AND _effective_date<>'' AND (~in_param.Is_UseDate OR l.reg_latest_expiration_date<>'');

    BOOLEAN keepRec := MAP(
      filterByDate => r.date BETWEEN _effective_date AND l.reg_latest_expiration_date,
      filterByYear => IF(in_param.Is_UseDate, r.date BETWEEN _effective_date[1..4] AND l.reg_latest_expiration_date[1..4],
        l.reg_latest_effective_date[1..4] >= r.date),
      TRUE);
    SELF.acctNo := IF(keepRec,l.acctNo,SKIP);
    SELF := l;
  END;

  OutRec trimSpaces(OutRec L) := TRANSFORM
    SELF.acctNo := TRIM(L.acctNo);
    SELF.state_origin := TRIM(L.state_origin);
    SELF.source_code := TRIM(L.source_code);
    SELF.NonDMVSource := L.NonDMVSource;
    SELF.vendor_first_reported_date := TRIM(L.vendor_first_reported_date);
    SELF.vendor_date := TRIM(L.vendor_date);
    SELF.vin := TRIM(L.vin);
    SELF.model_year := TRIM(L.model_year);
    SELF.make_desc := TRIM(L.make_desc);
    SELF.vehicle_type_desc := TRIM(L.vehicle_type_desc);
    SELF.series_desc := TRIM(L.series_desc);
    SELF.model_desc := TRIM(L.model_desc);
    SELF.body_style_desc := TRIM(L.body_style_desc);
    SELF.major_color_desc := TRIM(L.major_color_desc);
    SELF.minor_color_desc := TRIM(L.minor_color_desc);
    SELF.base_price := TRIM(L.base_price);
    SELF.orig_net_weight := TRIM(L.orig_net_weight);
    SELF.vina_vp_air_conditioning_desc := TRIM(L.vina_vp_air_conditioning_desc);
    SELF.vina_vp_power_steering_desc := TRIM(L.vina_vp_power_steering_desc);
    SELF.vina_vp_power_brakes_desc := TRIM(L.vina_vp_power_brakes_desc);
    SELF.vina_vp_power_windows_desc := TRIM(L.vina_vp_power_windows_desc);
    SELF.vina_vp_tilt_wheel_desc := TRIM(L.vina_vp_tilt_wheel_desc);
    SELF.vina_vp_roof_desc := TRIM(L.vina_vp_roof_desc);
    SELF.vina_vp_optional_roof1_desc := TRIM(L.vina_vp_optional_roof1_desc);
    SELF.vina_vp_optional_roof2_desc := TRIM(L.vina_vp_optional_roof2_desc);
    SELF.vina_vp_radio_desc := TRIM(L.vina_vp_radio_desc);
    SELF.vina_vp_optional_radio1_desc := TRIM(L.vina_vp_optional_radio1_desc);
    SELF.vina_vp_optional_radio2_desc := TRIM(L.vina_vp_optional_radio2_desc);
    SELF.vina_vp_transmission_desc := TRIM(L.vina_vp_transmission_desc);
    SELF.vina_vp_optional_transmission1_desc:= TRIM(L.vina_vp_optional_transmission1_desc);
    SELF.vina_vp_optional_transmission2_desc:= TRIM(L.vina_vp_optional_transmission2_desc);
    SELF.vina_vp_anti_lock_brakes_desc := TRIM(L.vina_vp_anti_lock_brakes_desc);
    SELF.vina_vp_front_wheel_drive_desc := TRIM(L.vina_vp_front_wheel_drive_desc);
    SELF.vina_vp_four_wheel_drive_desc := TRIM(L.vina_vp_four_wheel_drive_desc);
    SELF.vina_vp_security_system_desc := TRIM(L.vina_vp_security_system_desc);
    SELF.vina_vp_daytime_running_lights_desc:= TRIM(L.vina_vp_daytime_running_lights_desc);
    SELF.vina_number_of_cylinders := TRIM(L.vina_number_of_cylinders);
    SELF.vina_engine_size := TRIM(L.vina_engine_size);
    SELF.fuel_type_name := TRIM(L.fuel_type_name);
    SELF.reg_true_license_plate := TRIM(L.reg_true_license_plate);
    SELF.reg_license_plate := TRIM(L.reg_license_plate);
    SELF.reg_license_plate_type_code := TRIM(L.reg_license_plate_type_code);
    SELF.reg_license_plate_type_desc := TRIM(L.reg_license_plate_type_desc);
    SELF.reg_license_state := TRIM(L.reg_license_state);
    SELF.reg_previous_license_plate := TRIM(L.reg_previous_license_plate);
    SELF.reg_previous_license_state := TRIM(L.reg_previous_license_state);
    SELF.reg_first_date := TRIM(L.reg_first_date);
    SELF.reg_earliest_effective_date := TRIM(L.reg_earliest_effective_date);
    SELF.reg_latest_effective_date := TRIM(L.reg_latest_effective_date);
    SELF.reg_latest_expiration_date := TRIM(L.reg_latest_expiration_date);
    SELF.reg_decal_number := TRIM(L.reg_decal_number);
    SELF.ttl_number := TRIM(L.ttl_number);
    SELF.ttl_earliest_issue_date := TRIM(L.ttl_earliest_issue_date);
    SELF.ttl_latest_issue_date := TRIM(L.ttl_latest_issue_date);
    SELF.ttl_previous_issue_date := TRIM(L.ttl_previous_issue_date);
    SELF.ttl_status_code := TRIM(L.ttl_status_code);
    SELF.ttl_status_desc := TRIM(L.ttl_status_desc);
    SELF.ttl_odometer_mileage := TRIM(L.ttl_odometer_mileage);
    SELF.own_1_title := TRIM(L.own_1_title);
    SELF.own_1_fname := TRIM(L.own_1_fname);
    SELF.own_1_mname := TRIM(L.own_1_mname);
    SELF.own_1_lname := TRIM(L.own_1_lname);
    SELF.own_1_name_suffix := TRIM(L.own_1_name_suffix);
    SELF.own_1_orig_name := TRIM(L.own_1_orig_name);
    SELF.own_1_orig_sex := TRIM(L.own_1_orig_sex);
    SELF.own_1_did := TRIM(L.own_1_did);
    SELF.own_1_driver_license_number := TRIM(L.own_1_driver_license_number);
    SELF.own_1_dob := TRIM(L.own_1_dob);
    SELF.own_1_ssn := TRIM(L.own_1_ssn);
    SELF.own_1_company_name := TRIM(L.own_1_company_name);
    SELF.own_1_bdid := TRIM(L.own_1_bdid);
    SELF.own_1_fein := TRIM(L.own_1_fein);
    SELF.own_1_addr1 := TRIM(L.own_1_addr1);
    SELF.own_1_addr2 := TRIM(L.own_1_addr2);
    SELF.own_1_v_city_name := TRIM(L.own_1_v_city_name);
    SELF.own_1_city := TRIM(L.own_1_city);
    SELF.own_1_state := TRIM(L.own_1_state);
    SELF.own_1_zip := TRIM(L.own_1_zip);
    SELF.own_1_county := TRIM(L.own_1_county);
    SELF.own_1_src_first_date := TRIM(L.own_1_src_first_date);
    SELF.own_1_src_last_date := TRIM(L.own_1_src_last_date);
    SELF.reg_1_title := TRIM(L.reg_1_title);
    SELF.reg_1_fname := TRIM(L.reg_1_fname);
    SELF.reg_1_mname := TRIM(L.reg_1_mname);
    SELF.reg_1_lname := TRIM(L.reg_1_lname);
    SELF.reg_1_name_suffix := TRIM(L.reg_1_name_suffix);
    SELF.reg_1_orig_name := TRIM(L.reg_1_orig_name);
    SELF.reg_1_orig_sex := TRIM(L.reg_1_orig_sex);
    SELF.reg_1_did := TRIM(L.reg_1_did);
    SELF.reg_1_driver_license_number := TRIM(L.reg_1_driver_license_number);
    SELF.reg_1_dob := TRIM(L.reg_1_dob);
    SELF.reg_1_ssn := TRIM(L.reg_1_ssn);
    SELF.reg_1_company_name := TRIM(L.reg_1_company_name);
    SELF.reg_1_bdid := TRIM(L.reg_1_bdid);
    SELF.reg_1_fein := TRIM(L.reg_1_fein);
    SELF.reg_1_addr1 := TRIM(L.reg_1_addr1);
    SELF.reg_1_addr2 := TRIM(L.reg_1_addr2);
    SELF.reg_1_v_city_name := TRIM(L.reg_1_v_city_name);
    SELF.reg_1_city := TRIM(L.reg_1_city);
    SELF.reg_1_state := TRIM(L.reg_1_state);
    SELF.reg_1_zip := TRIM(L.reg_1_zip);
    SELF.reg_1_county := TRIM(L.reg_1_county);
    SELF.lh_1_title := TRIM(L.lh_1_title);
    SELF.lh_1_fname := TRIM(L.lh_1_fname);
    SELF.lh_1_mname := TRIM(L.lh_1_mname);
    SELF.lh_1_lname := TRIM(L.lh_1_lname);
    SELF.lh_1_name_suffix := TRIM(L.lh_1_name_suffix);
    SELF.lh_1_lien_date := TRIM(L.lh_1_lien_date);
    SELF.lh_1_orig_name := TRIM(L.lh_1_orig_name);
    SELF.lh_1_orig_sex := TRIM(L.lh_1_orig_sex);
    SELF.lh_1_did := TRIM(L.lh_1_did);
    SELF.lh_1_driver_license_number := TRIM(L.lh_1_driver_license_number);
    SELF.lh_1_dob := TRIM(L.lh_1_dob);
    SELF.lh_1_ssn := TRIM(L.lh_1_ssn);
    SELF.lh_1_company_name := TRIM(L.lh_1_company_name);
    SELF.lh_1_bdid := TRIM(L.lh_1_bdid);
    SELF.lh_1_fein := TRIM(L.lh_1_fein);
    SELF.lh_1_addr1 := TRIM(L.lh_1_addr1);
    SELF.lh_1_addr2 := TRIM(L.lh_1_addr2);
    SELF.lh_1_v_city_name := TRIM(L.lh_1_v_city_name);
    SELF.lh_1_city := TRIM(L.lh_1_city);
    SELF.lh_1_state := TRIM(L.lh_1_state);
    SELF.lh_1_zip := TRIM(L.lh_1_zip);
    SELF.lh_1_county := TRIM(L.lh_1_county);
    SELF.le_1_title := TRIM(L.le_1_title);
    SELF.le_1_fname := TRIM(L.le_1_fname);
    SELF.le_1_mname := TRIM(L.le_1_mname);
    SELF.le_1_lname := TRIM(L.le_1_lname);
    SELF.le_1_name_suffix := TRIM(L.le_1_name_suffix);
    SELF.le_1_orig_name := TRIM(L.le_1_orig_name);
    SELF.le_1_orig_sex := TRIM(L.le_1_orig_sex);
    SELF.le_1_did := TRIM(L.le_1_did);
    SELF.le_1_driver_license_number := TRIM(L.le_1_driver_license_number);
    SELF.le_1_dob := TRIM(L.le_1_dob);
    SELF.le_1_ssn := TRIM(L.le_1_ssn);
    SELF.le_1_company_name := TRIM(L.le_1_company_name);
    SELF.le_1_bdid := TRIM(L.le_1_bdid);
    SELF.le_1_fein := TRIM(L.le_1_fein);
    SELF.le_1_addr1 := TRIM(L.le_1_addr1);
    SELF.le_1_addr2 := TRIM(L.le_1_addr2);
    SELF.le_1_v_city_name := TRIM(L.le_1_v_city_name);
    SELF.le_1_city := TRIM(L.le_1_city);
    SELF.le_1_state := TRIM(L.le_1_state);
    SELF.le_1_zip := TRIM(L.le_1_zip);
    SELF.le_1_county := TRIM(L.le_1_county);
    SELF.lo_1_title := TRIM(L.lo_1_title);
    SELF.lo_1_fname := TRIM(L.lo_1_fname);
    SELF.lo_1_mname := TRIM(L.lo_1_mname);
    SELF.lo_1_lname := TRIM(L.lo_1_lname);
    SELF.lo_1_name_suffix := TRIM(L.lo_1_name_suffix);
    SELF.lo_1_orig_name := TRIM(L.lo_1_orig_name);
    SELF.lo_1_orig_sex := TRIM(L.lo_1_orig_sex);
    SELF.lo_1_did := TRIM(L.lo_1_did);
    SELF.lo_1_driver_license_number := TRIM(L.lo_1_driver_license_number);
    SELF.lo_1_dob := TRIM(L.lo_1_dob);
    SELF.lo_1_ssn := TRIM(L.lo_1_ssn);
    SELF.lo_1_company_name := TRIM(L.lo_1_company_name);
    SELF.lo_1_bdid := TRIM(L.lo_1_bdid);
    SELF.lo_1_fein := TRIM(L.lo_1_fein);
    SELF.lo_1_addr1 := TRIM(L.lo_1_addr1);
    SELF.lo_1_addr2 := TRIM(L.lo_1_addr2);
    SELF.lo_1_v_city_name := TRIM(L.lo_1_v_city_name);
    SELF.lo_1_city := TRIM(L.lo_1_city);
    SELF.lo_1_state := TRIM(L.lo_1_state);
    SELF.lo_1_zip := TRIM(L.lo_1_zip);
    SELF.lo_1_county := TRIM(L.lo_1_county);
    SELF.own_2_title := TRIM(L.own_2_title);
    SELF.own_2_fname := TRIM(L.own_2_fname);
    SELF.own_2_mname := TRIM(L.own_2_mname);
    SELF.own_2_lname := TRIM(L.own_2_lname);
    SELF.own_2_name_suffix := TRIM(L.own_2_name_suffix);
    SELF.own_2_orig_name := TRIM(L.own_2_orig_name);
    SELF.own_2_orig_sex := TRIM(L.own_2_orig_sex);
    SELF.own_2_did := TRIM(L.own_2_did);
    SELF.own_2_driver_license_number := TRIM(L.own_2_driver_license_number);
    SELF.own_2_dob := TRIM(L.own_2_dob);
    SELF.own_2_ssn := TRIM(L.own_2_ssn);
    SELF.own_2_company_name := TRIM(L.own_2_company_name);
    SELF.own_2_bdid := TRIM(L.own_2_bdid);
    SELF.own_2_fein := TRIM(L.own_2_fein);
    SELF.own_2_addr1 := TRIM(L.own_2_addr1);
    SELF.own_2_addr2 := TRIM(L.own_2_addr2);
    SELF.own_2_v_city_name := TRIM(L.own_2_v_city_name);
    SELF.own_2_city := TRIM(L.own_2_city);
    SELF.own_2_state := TRIM(L.own_2_state);
    SELF.own_2_zip := TRIM(L.own_2_zip);
    SELF.own_2_county := TRIM(L.own_2_county);
    SELF.own_2_src_first_date := TRIM(L.own_2_src_first_date);
    SELF.own_2_src_last_date := TRIM(L.own_2_src_last_date);
    SELF.reg_2_title := TRIM(L.reg_2_title);
    SELF.reg_2_fname := TRIM(L.reg_2_fname);
    SELF.reg_2_mname := TRIM(L.reg_2_mname);
    SELF.reg_2_lname := TRIM(L.reg_2_lname);
    SELF.reg_2_name_suffix := TRIM(L.reg_2_name_suffix);
    SELF.reg_2_orig_name := TRIM(L.reg_2_orig_name);
    SELF.reg_2_orig_sex := TRIM(L.reg_2_orig_sex);
    SELF.reg_2_did := TRIM(L.reg_2_did);
    SELF.reg_2_driver_license_number := TRIM(L.reg_2_driver_license_number);
    SELF.reg_2_dob := TRIM(L.reg_2_dob);
    SELF.reg_2_ssn := TRIM(L.reg_2_ssn);
    SELF.reg_2_company_name := TRIM(L.reg_2_company_name);
    SELF.reg_2_bdid := TRIM(L.reg_2_bdid);
    SELF.reg_2_fein := TRIM(L.reg_2_fein);
    SELF.reg_2_addr1 := TRIM(L.reg_2_addr1);
    SELF.reg_2_addr2 := TRIM(L.reg_2_addr2);
    SELF.reg_2_v_city_name := TRIM(L.reg_2_v_city_name);
    SELF.reg_2_city := TRIM(L.reg_2_city);
    SELF.reg_2_state := TRIM(L.reg_2_state);
    SELF.reg_2_zip := TRIM(L.reg_2_zip);
    SELF.reg_2_county := TRIM(L.reg_2_county);
    SELF.lh_2_title := TRIM(L.lh_2_title);
    SELF.lh_2_fname := TRIM(L.lh_2_fname);
    SELF.lh_2_mname := TRIM(L.lh_2_mname);
    SELF.lh_2_lname := TRIM(L.lh_2_lname);
    SELF.lh_2_name_suffix := TRIM(L.lh_2_name_suffix);
    SELF.lh_2_lien_date := TRIM(L.lh_2_lien_date);
    SELF.lh_2_orig_name := TRIM(L.lh_2_orig_name);
    SELF.lh_2_orig_sex := TRIM(L.lh_2_orig_sex);
    SELF.lh_2_did := TRIM(L.lh_2_did);
    SELF.lh_2_driver_license_number := TRIM(L.lh_2_driver_license_number);
    SELF.lh_2_dob := TRIM(L.lh_2_dob);
    SELF.lh_2_ssn := TRIM(L.lh_2_ssn);
    SELF.lh_2_company_name := TRIM(L.lh_2_company_name);
    SELF.lh_2_bdid := TRIM(L.lh_2_bdid);
    SELF.lh_2_fein := TRIM(L.lh_2_fein);
    SELF.lh_2_addr1 := TRIM(L.lh_2_addr1);
    SELF.lh_2_addr2 := TRIM(L.lh_2_addr2);
    SELF.lh_2_v_city_name := TRIM(L.lh_2_v_city_name);
    SELF.lh_2_city := TRIM(L.lh_2_city);
    SELF.lh_2_state := TRIM(L.lh_2_state);
    SELF.lh_2_zip := TRIM(L.lh_2_zip);
    SELF.lh_2_county := TRIM(L.lh_2_county);
    SELF.le_2_title := TRIM(L.le_2_title);
    SELF.le_2_fname := TRIM(L.le_2_fname);
    SELF.le_2_mname := TRIM(L.le_2_mname);
    SELF.le_2_lname := TRIM(L.le_2_lname);
    SELF.le_2_name_suffix := TRIM(L.le_2_name_suffix);
    SELF.le_2_orig_name := TRIM(L.le_2_orig_name);
    SELF.le_2_orig_sex := TRIM(L.le_2_orig_sex);
    SELF.le_2_did := TRIM(L.le_2_did);
    SELF.le_2_driver_license_number := TRIM(L.le_2_driver_license_number);
    SELF.le_2_dob := TRIM(L.le_2_dob);
    SELF.le_2_ssn := TRIM(L.le_2_ssn);
    SELF.le_2_company_name := TRIM(L.le_2_company_name);
    SELF.le_2_bdid := TRIM(L.le_2_bdid);
    SELF.le_2_fein := TRIM(L.le_2_fein);
    SELF.le_2_addr1 := TRIM(L.le_2_addr1);
    SELF.le_2_addr2 := TRIM(L.le_2_addr2);
    SELF.le_2_v_city_name := TRIM(L.le_2_v_city_name);
    SELF.le_2_city := TRIM(L.le_2_city);
    SELF.le_2_state := TRIM(L.le_2_state);
    SELF.le_2_zip := TRIM(L.le_2_zip);
    SELF.le_2_county := TRIM(L.le_2_county);
    SELF.lo_2_title := TRIM(L.lo_2_title);
    SELF.lo_2_fname := TRIM(L.lo_2_fname);
    SELF.lo_2_mname := TRIM(L.lo_2_mname);
    SELF.lo_2_lname := TRIM(L.lo_2_lname);
    SELF.lo_2_name_suffix := TRIM(L.lo_2_name_suffix);
    SELF.lo_2_orig_name := TRIM(L.lo_2_orig_name);
    SELF.lo_2_orig_sex := TRIM(L.lo_2_orig_sex);
    SELF.lo_2_did := TRIM(L.lo_2_did);
    SELF.lo_2_driver_license_number := TRIM(L.lo_2_driver_license_number);
    SELF.lo_2_dob := TRIM(L.lo_2_dob);
    SELF.lo_2_ssn := TRIM(L.lo_2_ssn);
    SELF.lo_2_company_name := TRIM(L.lo_2_company_name);
    SELF.lo_2_bdid := TRIM(L.lo_2_bdid);
    SELF.lo_2_fein := TRIM(L.lo_2_fein);
    SELF.lo_2_addr1 := TRIM(L.lo_2_addr1);
    SELF.lo_2_addr2 := TRIM(L.lo_2_addr2);
    SELF.lo_2_v_city_name := TRIM(L.lo_2_v_city_name);
    SELF.lo_2_city := TRIM(L.lo_2_city);
    SELF.lo_2_state := TRIM(L.lo_2_state);
    SELF.lo_2_zip := TRIM(L.lo_2_zip);
    SELF.lo_2_county := TRIM(L.lo_2_county);
    SELF.own_3_title := TRIM(L.own_3_title);
    SELF.own_3_fname := TRIM(L.own_3_fname);
    SELF.own_3_mname := TRIM(L.own_3_mname);
    SELF.own_3_lname := TRIM(L.own_3_lname);
    SELF.own_3_name_suffix := TRIM(L.own_3_name_suffix);
    SELF.own_3_orig_name := TRIM(L.own_3_orig_name);
    SELF.own_3_orig_sex := TRIM(L.own_3_orig_sex);
    SELF.own_3_did := TRIM(L.own_3_did);
    SELF.own_3_driver_license_number := TRIM(L.own_3_driver_license_number);
    SELF.own_3_dob := TRIM(L.own_3_dob);
    SELF.own_3_ssn := TRIM(L.own_3_ssn);
    SELF.own_3_company_name := TRIM(L.own_3_company_name);
    SELF.own_3_bdid := TRIM(L.own_3_bdid);
    SELF.own_3_fein := TRIM(L.own_3_fein);
    SELF.own_3_addr1 := TRIM(L.own_3_addr1);
    SELF.own_3_addr2 := TRIM(L.own_3_addr2);
    SELF.own_3_v_city_name := TRIM(L.own_3_v_city_name);
    SELF.own_3_city := TRIM(L.own_3_city);
    SELF.own_3_state := TRIM(L.own_3_state);
    SELF.own_3_zip := TRIM(L.own_3_zip);
    SELF.own_3_county := TRIM(L.own_3_county);
    SELF.own_3_src_first_date := TRIM(L.own_3_src_first_date);
    SELF.own_3_src_last_date := TRIM(L.own_3_src_last_date);
    SELF.reg_3_title := TRIM(L.reg_3_title);
    SELF.reg_3_fname := TRIM(L.reg_3_fname);
    SELF.reg_3_mname := TRIM(L.reg_3_mname);
    SELF.reg_3_lname := TRIM(L.reg_3_lname);
    SELF.reg_3_name_suffix := TRIM(L.reg_3_name_suffix);
    SELF.reg_3_orig_name := TRIM(L.reg_3_orig_name);
    SELF.reg_3_orig_sex := TRIM(L.reg_3_orig_sex);
    SELF.reg_3_did := TRIM(L.reg_3_did);
    SELF.reg_3_driver_license_number := TRIM(L.reg_3_driver_license_number);
    SELF.reg_3_dob := TRIM(L.reg_3_dob);
    SELF.reg_3_ssn := TRIM(L.reg_3_ssn);
    SELF.reg_3_company_name := TRIM(L.reg_3_company_name);
    SELF.reg_3_bdid := TRIM(L.reg_3_bdid);
    SELF.reg_3_fein := TRIM(L.reg_3_fein);
    SELF.reg_3_addr1 := TRIM(L.reg_3_addr1);
    SELF.reg_3_addr2 := TRIM(L.reg_3_addr2);
    SELF.reg_3_v_city_name := TRIM(L.reg_3_v_city_name);
    SELF.reg_3_city := TRIM(L.reg_3_city);
    SELF.reg_3_state := TRIM(L.reg_3_state);
    SELF.reg_3_zip := TRIM(L.reg_3_zip);
    SELF.reg_3_county := TRIM(L.reg_3_county);
    SELF.lh_3_title := TRIM(L.lh_3_title);
    SELF.lh_3_fname := TRIM(L.lh_3_fname);
    SELF.lh_3_mname := TRIM(L.lh_3_mname);
    SELF.lh_3_lname := TRIM(L.lh_3_lname);
    SELF.lh_3_name_suffix := TRIM(L.lh_3_name_suffix);
    SELF.lh_3_lien_date := TRIM(L.lh_3_lien_date);
    SELF.lh_3_orig_name := TRIM(L.lh_3_orig_name);
    SELF.lh_3_orig_sex := TRIM(L.lh_3_orig_sex);
    SELF.lh_3_did := TRIM(L.lh_3_did);
    SELF.lh_3_driver_license_number := TRIM(L.lh_3_driver_license_number);
    SELF.lh_3_dob := TRIM(L.lh_3_dob);
    SELF.lh_3_ssn := TRIM(L.lh_3_ssn);
    SELF.lh_3_company_name := TRIM(L.lh_3_company_name);
    SELF.lh_3_bdid := TRIM(L.lh_3_bdid);
    SELF.lh_3_fein := TRIM(L.lh_3_fein);
    SELF.lh_3_addr1 := TRIM(L.lh_3_addr1);
    SELF.lh_3_addr2 := TRIM(L.lh_3_addr2);
    SELF.lh_3_v_city_name := TRIM(L.lh_3_v_city_name);
    SELF.lh_3_city := TRIM(L.lh_3_city);
    SELF.lh_3_state := TRIM(L.lh_3_state);
    SELF.lh_3_zip := TRIM(L.lh_3_zip);
    SELF.lh_3_county := TRIM(L.lh_3_county);
    SELF.le_3_title := TRIM(L.le_3_title);
    SELF.le_3_fname := TRIM(L.le_3_fname);
    SELF.le_3_mname := TRIM(L.le_3_mname);
    SELF.le_3_lname := TRIM(L.le_3_lname);
    SELF.le_3_name_suffix := TRIM(L.le_3_name_suffix);
    SELF.le_3_orig_name := TRIM(L.le_3_orig_name);
    SELF.le_3_orig_sex := TRIM(L.le_3_orig_sex);
    SELF.le_3_did := TRIM(L.le_3_did);
    SELF.le_3_driver_license_number := TRIM(L.le_3_driver_license_number);
    SELF.le_3_dob := TRIM(L.le_3_dob);
    SELF.le_3_ssn := TRIM(L.le_3_ssn);
    SELF.le_3_company_name := TRIM(L.le_3_company_name);
    SELF.le_3_bdid := TRIM(L.le_3_bdid);
    SELF.le_3_fein := TRIM(L.le_3_fein);
    SELF.le_3_addr1 := TRIM(L.le_3_addr1);
    SELF.le_3_addr2 := TRIM(L.le_3_addr2);
    SELF.le_3_v_city_name := TRIM(L.le_3_v_city_name);
    SELF.le_3_city := TRIM(L.le_3_city);
    SELF.le_3_state := TRIM(L.le_3_state);
    SELF.le_3_zip := TRIM(L.le_3_zip);
    SELF.le_3_county := TRIM(L.le_3_county);
    SELF.lo_3_title := TRIM(L.lo_3_title);
    SELF.lo_3_fname := TRIM(L.lo_3_fname);
    SELF.lo_3_mname := TRIM(L.lo_3_mname);
    SELF.lo_3_lname := TRIM(L.lo_3_lname);
    SELF.lo_3_name_suffix := TRIM(L.lo_3_name_suffix);
    SELF.lo_3_orig_name := TRIM(L.lo_3_orig_name);
    SELF.lo_3_orig_sex := TRIM(L.lo_3_orig_sex);
    SELF.lo_3_did := TRIM(L.lo_3_did);
    SELF.lo_3_driver_license_number := TRIM(L.lo_3_driver_license_number);
    SELF.lo_3_dob := TRIM(L.lo_3_dob);
    SELF.lo_3_ssn := TRIM(L.lo_3_ssn);
    SELF.lo_3_company_name := TRIM(L.lo_3_company_name);
    SELF.lo_3_bdid := TRIM(L.lo_3_bdid);
    SELF.lo_3_fein := TRIM(L.lo_3_fein);
    SELF.lo_3_addr1 := TRIM(L.lo_3_addr1);
    SELF.lo_3_addr2 := TRIM(L.lo_3_addr2);
    SELF.lo_3_v_city_name := TRIM(L.lo_3_v_city_name);
    SELF.lo_3_city := TRIM(L.lo_3_city);
    SELF.lo_3_state := TRIM(L.lo_3_state);
    SELF.lo_3_zip := TRIM(L.lo_3_zip);
    SELF.lo_3_county := TRIM(L.lo_3_county);
    SELF.penalt := L.penalt;
    SELF.is_current := L.is_current;
    SELF.documenttypecode := TRIM(L.documenttypecode);
    SELF.safety_type := TRIM(L.safety_type);
    SELF.airbags := TRIM(L.airbags);
    SELF.tod_flag := TRIM(L.tod_flag);
    SELF.min_door_count := TRIM(L.min_door_count);
    SELF.airbag_driver := TRIM(L.airbag_driver);
    SELF.airbag_front_driver_side := TRIM(L.airbag_front_driver_side);
    SELF.airbag_front_head_curtain := TRIM(L.airbag_front_head_curtain);
    SELF.airbag_front_pass := TRIM(L.airbag_front_pass);
    SELF.airbag_front_pass_side := TRIM(L.airbag_front_pass_side);
    SELF.brand_code_1 := TRIM(L.brand_code_1);
    SELF.brand_type_1 := TRIM(L.brand_type_1);
    SELF.brand_state_1 := TRIM(L.brand_state_1);
    SELF.brand_date_1 := TRIM(L.brand_date_1);
    SELF.brand_code_2 := TRIM(L.brand_code_2);
    SELF.brand_type_2 := TRIM(L.brand_type_2);
    SELF.brand_state_2 := TRIM(L.brand_state_2);
    SELF.brand_date_2 := TRIM(L.brand_date_2);
    SELF.brand_code_3 := TRIM(L.brand_code_3);
    SELF.brand_type_3 := TRIM(L.brand_type_3);
    SELF.brand_state_3 := TRIM(L.brand_state_3);
    SELF.brand_date_3 := TRIM(L.brand_date_3);
    SELF.brand_code_4 := TRIM(L.brand_code_4);
    SELF.brand_type_4 := TRIM(L.brand_type_4);
    SELF.brand_state_4 := TRIM(L.brand_state_4);
    SELF.brand_date_4 := TRIM(L.brand_date_4);
    SELF.brand_code_5 := TRIM(L.brand_code_5);
    SELF.brand_type_5 := TRIM(L.brand_type_5);
    SELF.brand_state_5 := TRIM(L.brand_state_5);
    SELF.brand_date_5 := TRIM(L.brand_date_5);
    SELF := L;
  END;
    
  // Main
  BOOLEAN return_current_only := in_param.ReturnCurrent;
  BOOLEAN return_fullname_only := in_param.FullNameMatch;
  UNSIGNED2 rsltsPerInput := AutoStandardI.InterfaceTranslator.MaxResults_val.val(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.InterfaceTranslator.MaxResults_val.params));

  cfgs := MODULE(BatchServices.Interfaces.i_AK_Config)
    EXPORT useAllLookups := TRUE;
    EXPORT skip_set := Consts.autokey_skip_set;
  END;

  // Search via AutoKey
  input_c := PROJECT(data_in, cleanInput(LEFT));
  fids := UNGROUP(Autokey_batch.get_fids(input_c, Consts.str_autokeyname, cfgs));
  pl_rec := DATASET([], VehicleV2_Services.assorted_layouts.layout_common);
  AutokeyB2.mac_get_payload(fids, Consts.str_autokeyname, pl_rec, with_pl, append_did, append_bdid);
  with_pl_x := PROJECT(with_pl, TRANSFORM(AcctRec, SELF.did := LEFT.append_did, SELF := LEFT, SELF := []));

  fromAK := DEDUP(SORT(with_pl_x, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                  acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  // Search via DID lookup
  notFoundAccts := JOIN(input_c, fromAK, LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
  dDidsAcctno := BatchServices.Functions.fn_find_dids_and_append_to_acctno(notFoundAccts);
  dWithDIDs := JOIN(notFoundAccts, dDidsAcctno,
    LEFT.acctno = RIGHT.acctno,
    TRANSFORM(AcctRec,
      SELF.did := RIGHT.did,
      SELF := LEFT,
      SELF.vehicle_key := '',
      SELF.iteration_key:= ''),
    LEFT OUTER);
  fromDIDLkup := JOIN(dWithDIDs, keyVDID,
    KEYED(LEFT.did = RIGHT.Append_DID),
    fromKeyVDID(LEFT, RIGHT),
    LIMIT(VehicleV2_Services.Constant.VEHICLE_BATCH_LIMIT));

  // Search via BIP Linkids
  ds_linkIds := PROJECT(data_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
  ds_from_linkids := PROJECT(VehicleV2.Key_Vehicle_linkids.kFetch(ds_linkIds,,in_param.BIPFetchLevel),
    TRANSFORM(AcctRec,
      SELF := LEFT,
      SELF.vin := '',
      SELF.acctno := ''));

  // Add back acctno
  fromLinkids := JOIN(ds_from_linkids,data_in,
    LEFT.UltID = RIGHT.UltID AND
    (LEFT.OrgID = RIGHT.OrgID OR in_param.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_OrgID) AND
    (LEFT.SeleID = RIGHT.SeleID OR in_param.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_SELEID) AND
    (LEFT.ProxID = RIGHT.ProxID OR in_param.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_ProxID) AND
    (LEFT.PowID = RIGHT.PowID OR in_param.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_PowID) AND
    (LEFT.EmpID = RIGHT.EmpID OR in_param.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_EmpID) AND
    (LEFT.DotID = RIGHT.ProxID OR in_param.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_DotID),
    TRANSFORM(AcctRec,
      SELF.acctno := RIGHT.acctno,
      SELF := LEFT));
  
  
  // Merge/Sort/Dedup
  m_s_d := DEDUP(SORT(fromAK + fromDIDLkup +fromLinkids, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                 acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  // Make a choice
  did_acctno := IF(cfgs.RunDeepDive AND EXISTS(notFoundAccts), m_s_d, fromAK + fromLinkids);

  // Search by VIN
  input_vin := input_c(trimBoth(vin) <> BLNK);
  withVINInput := JOIN(input_vin, keyVVIN,
    KEYED(trimBoth(LEFT.vin) = RIGHT.vin),
    TRANSFORM(AcctRec, SELF := RIGHT, SELF := LEFT),
    LIMIT(VehicleV2_Services.Constant.VEHICLE_BATCH_LIMIT));

  withVINInput_pk_pre := JOIN(withVINInput, keyVPK,
    KEYED(LEFT.Vehicle_Key = RIGHT.Vehicle_Key AND
          LEFT.Iteration_Key = RIGHT.Iteration_Key),
    fromKeyVPK(LEFT, RIGHT),
    LIMIT(VehicleV2_Services.Constant.VEHICLE_BATCH_LIMIT));

  withVINInput_pk := suppress.MAC_SuppressSource(withVINInput_pk_pre,mod_access);
  vin_acctno := DEDUP(SORT(PROJECT(withVINInput_pk,AcctRec), acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                      acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  acctNos := DEDUP(SORT(did_acctno + vin_acctno, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                   acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  acctNos_i := JOIN(acctNos, input_c,
    LEFT.acctno = RIGHT.acctno,
    TRANSFORM(VehicleV2_Services.Layout_VKeysWithInput, SELF := LEFT, SELF := RIGHT), KEEP(1));

  // Get matches
  matches_tmp := VehicleV2_Services.Batch_transforms.get_flatLayout(acctNos_i, return_current_only, in_param.penalize_by_party);

  matches_d := DEDUP(SORT(matches_tmp, acctno, vin, -vendor_date, vendor_first_reported_date, -is_current),
                     acctno, vin, vendor_date, vendor_first_reported_date, is_current);

  NameMatches(fname1, mname1, lname1, fname2, mname2, lname2) := MACRO
      DataLib.NameMatch(fname1, mname1, lname1, fname2, mname2, lname2) <= Constant.NAME_MATCH_MAX_VAL
  ENDMACRO;

  FullNamesMatch() := MACRO
      trimBoth(RIGHT.name_first) = BLNK
      OR
      (trimBoth(LEFT.own_1_fname) = BLNK
        AND trimBoth(LEFT.own_2_fname) = BLNK
        AND trimBoth(LEFT.reg_1_fname) = BLNK
        AND trimBoth(LEFT.reg_2_fname) = BLNK)
      OR
      NameMatches(LEFT.own_1_fname, LEFT.own_1_mname, LEFT.own_1_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
      OR
      NameMatches(LEFT.own_2_fname, LEFT.own_2_mname, LEFT.own_2_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
      OR
      NameMatches(LEFT.reg_1_fname, LEFT.reg_1_mname, LEFT.reg_1_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
      OR
      NameMatches(LEFT.reg_2_fname, LEFT.reg_2_mname, LEFT.reg_2_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
  ENDMACRO;

  matches_xlt := JOIN(matches_d, input_c, LEFT.acctno = RIGHT.acctno AND (~return_fullname_only OR FullNamesMatch()), toOutput(LEFT, RIGHT));
  
  // To make MaxResults work, uncomment the following line.
  // rslt := TOPN(GROUP(matches_xlt, acctno), rsltsPerInput, acctno, -is_current, penalt, -vendor_date);
  rslt := SORT(matches_xlt, acctno, -is_current, penalt, -reg_latest_effective_date, -reg_latest_expiration_date, -vendor_date);
  // Bug # 72972
  
  RETURN PROJECT(rslt,trimSpaces(LEFT));
END;
