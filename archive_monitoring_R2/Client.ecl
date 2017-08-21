IMPORT address, Monitoring_Other;

LZ := Environment.LandingZone;
string wuid := thorlib.wuid ();

EXPORT Client (string CID) := MODULE

  EXPORT string GetID (string id_1, string id_2, string id_3) := function
    string id_1_trim := trim (id_1); // cannot be blank!
    string id_2_trim := trim (id_2);
    string id_3_trim := trim (id_3);
    id := id_1_trim + if (id_2_trim != '', '_' + id_2_trim, '') + if (id_3_trim != '', '_' + id_3_trim, ''); 
    return id;
  END;

  export MAC_AssignAddress () := MACRO
    Self.prim_range  := address_cleaned [1..10];
    Self.predir      := address_cleaned [11..12];
    Self.prim_name   := address_cleaned [13..40];
    Self.addr_suffix := address_cleaned [41..44];
    Self.postdir     := address_cleaned [45..46];
    Self.unit_desig  := address_cleaned [47..56];
    Self.sec_range   := address_cleaned [57..64];
    Self.p_city_name := address_cleaned [65..89];
    Self.v_city_name := address_cleaned [90..114];
    Self.st          := address_cleaned [115..116];
    Self.zip5        := address_cleaned [117..121];
    Self.zip4        := address_cleaned [122..125];
    Self.addr_rec_type := address_cleaned [139..140];
    Self.err_stat    := address_cleaned [179..182];
  endmacro;
  
  export MAC_CleanAddress (line_1, line_2) := MACRO
    string182 address_cleaned := address.CleanAddress182 (line_1, line_2);
    Self.prim_range  := address_cleaned [1..10];
    Self.predir      := address_cleaned [11..12];
    Self.prim_name   := address_cleaned [13..40];
    Self.addr_suffix := address_cleaned [41..44];
    Self.postdir     := address_cleaned [45..46];
    Self.unit_desig  := address_cleaned [47..56];
    Self.sec_range   := address_cleaned [57..64];
    Self.p_city_name := address_cleaned [65..89];
    Self.v_city_name := address_cleaned [90..114];
    Self.st          := address_cleaned [115..116];
    Self.zip5        := address_cleaned [117..121];
    Self.zip4        := address_cleaned [122..125];
    Self.addr_rec_type := address_cleaned [139..140];
    Self.err_stat    := address_cleaned [179..182];
  endmacro;


  // Transforming batch-input history data into monitoring internal layouts
  // some things are formal here (NCO legacy): seq = 1; IsBatch=true, etc.
  //TODO: checking for validity here will be redundant, if batch won't send blank addresses...
  EXPORT layouts.address_history_ext FormatBatchAddress (layouts.batch_in_address L, string16 WUID) := FUNCTION
    
    string city_state_zip := L.city + ' ' + L.state + ' ' + L.zip;
    boolean is_valid := (trim (L.address) != '') and (trim (city_state_zip) != '');
    layouts.address_history_ext myTransform := transform, SKIP (not is_valid)
      Self.seq := 1;
      Self.IsBatchOutput := TRUE;
      Self.wuid := WUID;
      Self.customer_id := CID;
      Self.record_id   := GetID (L.rec.UniqueID_1, L.rec.UniqueID_2, L.rec.UniqueID_3);

      // clean address:
      MAC_CleanAddress (L.address, city_state_zip);
      Self.addr_dt_last_seen  := L.date_last[1..6];
      Self.addr_dt_first_seen := L.date_first[1..6]; 

      Self := L; //name_first, name_middle, name_last, name_suffix
      Self := []; //src, best_address_count, addr_version_count
    end;
    return myTransform;

  END;

  // NB: listing name is ignored
  EXPORT layouts.phone_history_ext FormatBatchPhone (layouts.batch_in_phone L, string16 WUID) := FUNCTION

    string tphone := trim (L.phone);
    boolean is_valid := (tphone != '') and (length (tphone) >= 7);
    layouts.phone_history_ext myTransform := transform, SKIP (not is_valid)
      Self.seq := 1;         // "importance" of this address for this account record
      Self.IsBatchOutput := TRUE;   // specifies if this address comes from batch portion

      Self.wuid := WUID;
      Self.customer_id := CID;
      Self.record_id   := GetID (L.rec.UniqueID_1, L.rec.UniqueID_2, L.rec.UniqueID_3);

      Self.phone10 := tphone;
      Self.phone_dt_last_seen  := L.date_last [1..6];
      Self.phone_dt_first_seen := L.date_first [1..6];
      Self.phone_type := L.phone_type;

      Self := []; //name_first, name_middle, name_last, name_suffix, dual_name_flag, listing_type, publish_code, 
                  // carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
    end;
    return myTransform;

  END;

/*
  EXPORT layouts.property_history_ext FormatBatchProp (layouts.batch_in_property L, string WUID) := FUNCTION
  END;

  EXPORT layouts.paw_history_ext FormatBatchPaw (layouts.batch_in_paw L, string WUID) := FUNCTION
  END;
*/


  // =================================================================================
  // ---------------------------------------------------------------------------------
  // -------------------- S E N D I N G   R E S U L T S   B A C K --------------------
  // ---------------------------------------------------------------------------------
  // =================================================================================

  //IMPORTANT!!! addDay is a tempo fix for property and p@w only!
  // works correctly when "send" happens on less than 28th of every month
  shared string GetWarehouseHitsFileName (string data_type, boolean addDay = false) := FUNCTION
    string8 current_date := wuid [2..9];
    string8 adjusted_date := if (addDay,
                                 wuid [2..8] + ((unsigned1) wuid[9] + 1), current_date);
    return CID + '_' + adjusted_date + '_' + data_type + '.TXT';
  END;

  EXPORT JoinAndDesprayAddress (DATASET (layouts.out_address) new_addr,
                                string target_ip, string target_path) := FUNCTION
    fname_addr    := GetWarehouseHitsFileName ('ADDRESS');// contract: uppercase (save on function call)
    fname_res_thor := Files.Names.RESULT_DIR + CID + '::' + fname_addr;

    // save csv file in THOR
    saveCSV_thor  := OUTPUT (new_addr, , fname_res_thor, CSV (separator(','), terminator('\n'), QUOTE('"'), maxlength (8192)));
    despray  := FileServices.Despray (fname_res_thor, target_ip, target_path + CID + '/' + fname_addr, , , , TRUE);
    return IF (CID in Files.FirstRunSet, saveCSV_thor, SEQUENTIAL (saveCSV_thor, despray));
  END;

  EXPORT JoinAndDesprayPhone (DATASET (layouts.out_phone) new_phone,
                              string target_ip, string target_path) := FUNCTION
    fname_phone    := GetWarehouseHitsFileName ('PHONES');
    fname_res_thor := Files.Names.RESULT_DIR + CID + '::' + fname_phone;

    // save csv file in THOR
    saveCSV_thor  := OUTPUT (new_phone, , fname_res_thor, CSV (separator(','), terminator('\n'), QUOTE('"'), maxlength (8192)));
    despray := FileServices.Despray (fname_res_thor, target_ip, target_path + CID + '/' + fname_phone, , , , TRUE);
    return IF (CID in Files.FirstRunSet, saveCSV_thor, SEQUENTIAL (saveCSV_thor, despray));
  END;

  EXPORT JoinAndDesprayProperty (DATASET (layouts.out_property) new_prop,
                                string target_ip, string target_path) := FUNCTION
    fname := GetWarehouseHitsFileName ('PROPERTY', true);// contract: uppercase (save on function call)
    fname_thor := Files.Names.RESULT_DIR + CID + '::' + fname;

    // save csv file in THOR
    saveCSV_thor  := OUTPUT (new_prop, , fname_thor, CSV (separator(','), terminator('\n'), QUOTE('"'), maxlength (8192)));
    despray  := FileServices.Despray (fname_thor, target_ip, target_path + CID + '/' + fname, , , , TRUE);
    return IF (CID in Files.FirstRunSet, saveCSV_thor, SEQUENTIAL (saveCSV_thor, despray));
  END;

  EXPORT JoinAndDesprayPaw (DATASET (layouts.out_paw) new_paw,
                            string target_ip, string target_path) := FUNCTION
    fname := GetWarehouseHitsFileName ('PAW', true);// contract: uppercase (save on function call)
    fname_thor := Files.Names.RESULT_DIR + CID + '::' + fname;

    // save csv file in THOR
    saveCSV_thor  := OUTPUT (new_paw, , fname_thor, CSV (separator(','), terminator('\n'), QUOTE('"'), maxlength (8192)));
    despray  := FileServices.Despray (fname_thor, target_ip, target_path + CID + '/' + fname, , , , TRUE);
    return IF (CID in Files.FirstRunSet, saveCSV_thor, SEQUENTIAL (saveCSV_thor, despray));
  END;



  shared MAC_RESTORE_CLIENT_ID (ln_internal_id) := MACRO
    ln_id := trim (ln_internal_id);
    // save LN internal id, so that batch could link separate result files together
    SELF.record_id := ln_id;

    // correct ID is assumed here: cannot be empty, cannot start with underscore
    // format: <id1>[_id2][_id3]
    unsigned underscore_1 := stringlib.StringFind (ln_id, '_', 1);
    unsigned underscore_2 := stringlib.StringFind (ln_id, '_', 2);
    
    id_1 := IF (underscore_1 > 0, ln_id [1..underscore_1-1], ln_id);
    id_2 := MAP (underscore_2 > 0 => ln_id [underscore_1+1..underscore_2-1],
                 underscore_1 > 0 => ln_id [underscore_1+1..], '');
    id_3 := IF (underscore_2 > 0, ln_id [underscore_2+1..], '');

    //PRA is a special case: they can have '_' in the id_1 field.
    unsigned1 len := length (ln_id);
    id_1_pra := IF (len > 2 and ln_id [len-1] = '_', ln_id [1..len-2], ln_id); //PRA: account
    id_2_pra := IF (len > 2 and ln_id [len-1] = '_', ln_id [len], '');         //PRA: rel_pos

    SELF.UniqueID_1 := trim (if (CID = Constants.ClientID.PRA, id_1_pra, id_1));
    SELF.UniqueID_2 := trim (if (CID = Constants.ClientID.PRA, id_2_pra, id_2));
    SELF.UniqueID_3 := trim (if (CID = Constants.ClientID.PRA, '', id_3));
  ENDMACRO;


  EXPORT SendAddress ( 
    DATASET (Monitoring.layout_address_update) addr_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath):= FUNCTION

    // take only those, which belong to this client
    addr_new_client  := addr_new  (customer_id = CID);
    dod_new_client   := addr_hist (customer_id = CID, prim_name[1..3]='DOD');

    // take non-deceased:
    addr_real := JOIN (addr_new_client, dod_new_client, 
                       (Left.customer_id = Right.customer_id) AND (Left.record_id = Right.record_id),
                       transform (Monitoring.layout_address_update, Self := Left),
                       Left Only);

     // format results    
    layouts.out_address FormatAddressRes (layout_address_update L) := TRANSFORM
      MAC_RESTORE_CLIENT_ID (L.record_id); // restore client ID
      // name
      SELF.name_first  := L.name_first;
      SELF.name_middle := L.name_middle;
      SELF.name_last   := L.name_last;
      SELF.name_suffix := L.name_suffix;

      // take address parts from the Right side
      rpredir := trim (L.predir);
      rpname := trim (L.prim_name);
      rsuffix := trim (L.suffix);
      rpostdir := trim (L.postdir);
      runit := trim (L.unit_desig);
      rsec := trim (L.sec_range);
      addr_line_1 := trim (L.prim_range) + IF (rpredir != '', ' ' + rpredir, '') + IF (rpname   !='', ' ' + rpname,   '') +
                                           IF (rsuffix != '', ' ' + rsuffix, '') + IF (rpostdir !='', ' ' + rpostdir, '') + 
                                           IF (runit   != '', ' ' + runit,   '') + IF (rsec     !='', ' ' + rsec,     '');

      SELF.address := trim (addr_line_1, left);
      SELF.city    := L.p_city_name;
      SELF.state   := L.st;
      SELF.zip     := L.z5 + if (trim (L.z4) != '', '-' + trim (L.z4), '');


      SELF.date_first := L.addr_dt_first_seen + '01';
      SELF.date_last  := L.addr_dt_last_seen + '01';
      SELF.address_type := ''; //TODO: 
    END;
    res_addr := SORT (PROJECT (addr_real, FormatAddressRes (Left)), record_id);

    // join back to raw (if required) and spray
    return JoinAndDesprayAddress (res_addr, target_ip, target_path);
  END;

  EXPORT SendPhone ( 
    DATASET (Monitoring.layout_phone_out) phone_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath):= FUNCTION

    // take only those, which belong to this client
    phone_new_client := phone_new (customer_id = CID);
    dod_hist_client  := addr_hist (customer_id = CID, prim_name[1..3]='DOD');

    // take non-deceased:
    phone_real := JOIN (phone_new_client, dod_hist_client, 
                        (Left.customer_id = Right.customer_id) AND (Left.record_id = Right.record_id),
                        transform (Monitoring.layout_phone_out, Self := Left),
                        Left Only);

    // format result
    layouts.out_phone FormatPhoneRes (Monitoring.layout_phone_out L) := TRANSFORM
      MAC_RESTORE_CLIENT_ID (L.record_id); // restore client ID

      SELF.listing_name  := trim (L.name_first) + 
                            if (L.name_middle != '', ' ' + trim (L.name_middle), '') + 
                            if (L.name_last != '', ' ' + trim (L.name_last), '');
      SELF.phone := L.phone10;
      SELF.phone_type  := L.phone_type;
      SELF.switch_type := L.switch_type;
      SELF.date_first := L.phone_dt_first_seen + '01';
      SELF.date_last  := L.phone_dt_last_seen + '01';
      Self := L; //standard.Name_Slim
    END;
    res_phone := SORT (PROJECT (phone_real, FormatPhoneRes (Left)), record_id);

    // join back to raw (if required) and spray
    return JoinAndDesprayPhone (res_phone, target_ip, target_path);
  END;

  EXPORT SendProperty (
    DATASET (Monitoring_Other.layout_prp_out) prop_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath):= FUNCTION

    // take only those, which belong to this client
    prop_new_client := prop_new (customer_id = CID);
    dod_hist_client := addr_hist (customer_id = CID, prim_name[1..3]='DOD');

    // take non-deceased:
    prop_real := JOIN (prop_new_client, dod_hist_client, 
                       (Left.customer_id = Right.customer_id) AND (Left.record_id = Right.record_id),
                       transform (Monitoring_Other.layout_prp_out, Self := Left),
                       Left Only);

    // format result
    layouts.out_property FormatPropRes (Monitoring_Other.layout_prp_out L) := TRANSFORM
      MAC_RESTORE_CLIENT_ID (L.record_id); // restore client ID
      SELF.parcel_number := L.parcel_number_1;
      SELF.name_owner_1 := L.name_owner_1_1;
      SELF.name_owner_2 := L.name_owner_2_1;
//    out_standard_address;
      SELF.address := L.prop_address_1;
      SELF.city := L.p_city_name_d;
      SELF.state := L.st_d;
      SELF.zip := L.zip_d;

      SELF.sale_date := L.sale_date_1;
      SELF.sale_price := L.sale_price_1;
      SELF.name_seller := StringLib.StringFindReplace (L.name_seller_1, '"', '""');
    // standard.Name_Slim seller;

      // trying to figure out "total value"
      fares_value := (integer) L.fares_calculated_total_value;
      // t_value := if (fares_value != 0, fares_value, ut.Min2 ((integer) L.assessed_total_value_1, (integer) L.market_total_value_1));
      // SELF.total_value := (string11) t_value;
      SELF.total_value := IF (fares_value = 0, '', (string11) fares_value);
      SELF.mortgage_amount := L.mortgage_amount_1;             //first_td_loan_amount_1, second_td_loan_amount_1
      SELF.assessed_value     := L.assessed_total_value_1;     //assessed_land_value_1, assessed_improvement_value_1
      SELF.total_market_value := L.market_total_value_1;       //market_land_value_1, market_improvement_value_1

      SELF.legal_description := StringLib.StringFindReplace (FileUtils.trim_u20 (L.legal_description_1), '"', '""'); //250?
    END;
    res_prop := SORT (PROJECT (prop_real, FormatPropRes (Left)), record_id);

    // join back to raw (if required) and spray
    return JoinAndDesprayProperty (res_prop, target_ip, target_path);
  END;


  EXPORT SendPaw (
    DATASET (Monitoring_Other.layout_paw_out) paw_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath):= FUNCTION

    // take only those, which belong to this client
    paw_new_client := paw_new (customer_id = CID);
    dod_hist_client := addr_hist (customer_id = CID, prim_name[1..3]='DOD');

    // take non-deceased:
    paw_real := JOIN (paw_new_client, dod_hist_client, 
                       (Left.customer_id = Right.customer_id) AND (Left.record_id = Right.record_id),
                       transform (Monitoring_Other.layout_paw_out, Self := Left),
                       Left Only);

    // format result
    layouts.out_paw FormatPawRes (Monitoring_Other.layout_paw_out L) := TRANSFORM
      MAC_RESTORE_CLIENT_ID (L.record_id); // restore client ID
      self.name_first  := L.pawk_first_1;
      self.name_middle := L.pawk_middle_1;
      self.name_last   := L.pawk_last_1;
      self.name_suffix := L.pawk_suffix_1;

      self.ssn := L.pawk_ssn_1;
      self.title := L.pawk_title_1;
      self.company := L.pawk_name_company_1;
      self.department := L.pawk_department_1;
      self.fein := L.pawk_fein_1;
//    out_standard_address;
      self.address := L.pawk_address_1;
      self.city := L.pawk_city_1;
      self.state := L.pawk_state_1;
      self.zip := L.pawk_zip_1;
      self.zip4 := L.pawk_zip4_1;
      self.phone10 := L.pawk_phone10_1;
      self.verified := L.pawk_verified_1;
      self.email := L.pawk_email_1;
      self.date_first := L.pawk_first_seen_1; //First Reported Date
      self.date_last := L.pawk_last_seen_1;  //Last Reported Date
      self.confidence_level := L.pawk_confidence_level_1;
    END;
    res_paw := SORT (PROJECT (paw_real, FormatPawRes (Left)), record_id);

    // join back to raw (if required) and spray
    return JoinAndDesprayPaw (res_paw, target_ip, target_path);
  END;

END;