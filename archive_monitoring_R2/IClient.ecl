IMPORT address, Monitoring_Other;

LZ := Environment.LandingZone;
subj := Constants.T_SUBJECT;
phn  := Constants.T_PHONES;

EXPORT IClient := INTERFACE
  export string customer_id; //NCO, PCA2, WAM, etc.

  export unsigned1 MAX_INPUT_ADDRESSES := 1;
  export unsigned1 MAX_INPUT_PHONES := 1;

  export unsigned1 MAX_OUTPUT_ADDRESS := 0;
  export unsigned1 MAX_OUTPUT_PHONE := 0;
  export unsigned1 MAX_OUTPUT_PROP := 0;
  export unsigned1 MAX_OUTPUT_PAW := 0;

  export boolean SetRequestTypeError := false;

  EXPORT boolean IsFatalError (unsigned1 err) := 
    (err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID) OR 
    (err & Constants.ERR_CODE.REQUEST = Constants.ERR_CODE.REQUEST) OR 
    (err & Constants.ERR_CODE.ACCOUNT = Constants.ERR_CODE.ACCOUNT) OR
    // this is fatal for "delete" transactions only:
    (err & Constants.ERR_CODE.RECORD_NOT_FOUND = Constants.ERR_CODE.RECORD_NOT_FOUND);



  // ====================================================================
  // ====================== INPUT VERIFICATION ==========================
  // ====================================================================
  EXPORT layouts.verification VerifyBatch (DATASET (layouts.batch_raw) batch_in, DATASET (layouts.batch_raw) raw_monitor) := FUNCTION

    // TODO: remove customer_id (it's the same)
    distr := DISTRIBUTE (batch_in, HASH(customer_id, record_id));
    srt := SORT (distr, customer_id, record_id, wuid, LOCAL);
 
    // PRIMARY: check every record individually (name+ssn or name+address should be specified, etc.); 
    // NB: "delete" records are not checked for ssn/name/address validity
    layouts.verification CheckConstraints (layouts.batch_raw L, integer C) := TRANSFORM
      Self.seq := C; // need sequencing, to keep records in the order they were sorted

      // personal info: any 2 of three are allowed for identification
      boolean IsNamed := trim (L.name_last) != '';
      boolean IsSSNed := (length (trim (L.ssn)) = 9) and (length (StringLib.StringFilterOut (L.ssn, '0123456789')) = 0);
      trim_city  := stringlib.StringToUpperCase (trim (L.addr_1.city));
      trim_state := stringlib.StringToUpperCase (trim (L.addr_1.state));
      boolean IsAddressed := (trim_city  != '' and trim_city  != 'NULL' and trim_state != '' and trim_state != 'NULL') OR 
                             ((unsigned8) trim(L.addr_1.zip) != 0);
      boolean validPersonal := (IsNamed and IsSSNed) or (IsNamed and IsAddressed) or
                               (L.request_code = 'D'); //delete" transactions are not checked for person's validity;

      boolean validClient := L.customer_id != '';
      boolean validCode := L.request_code IN ['A', 'U', 'D', 'R'];
      string invalid_types := StringLib.StringFilterOut (stringlib.StringToUpperCase (L.request_code), Constants.ValidDataTypes);
      boolean validType := ~SetRequestTypeError  or 
                            ((L.request_type != '') and (invalid_types = '')); //want to be conservative...
      boolean validAcc  := (L.record_id != '') AND (L.record_id[1] != '_'); // just rel_pos is invalid 

      Self.err := IF (validPersonal, Constants.ERR_CODE.NOERR, Constants.ERR_CODE.PERSON) +
                  IF (validType,     Constants.ERR_CODE.NOERR, Constants.ERR_CODE.REQUEST_TYPE) +
                  // fatal errors: 
                  IF (validClient,   Constants.ERR_CODE.NOERR, Constants.ERR_CODE.CLIENT_ID) +
                  IF (validCode,     Constants.ERR_CODE.NOERR, Constants.ERR_CODE.REQUEST) +
                  IF (validAcc,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.ACCOUNT);
      SELF := L;
    END; 
    ds_namecheck_seq := PROJECT (srt, CheckConstraints (Left, COUNT));

    // check if record exists in Monitor DB:
    layouts.verification CheckNewRecods (layouts.verification L, layouts.batch_raw R) := TRANSFORM
      boolean existing := (L.customer_id = R.customer_id) AND (L.record_id = R.record_id);
      Self.new_id := ~existing;
      SELF := L;
    END;
    ds_join := JOIN (ds_namecheck_seq, DISTRIBUTE (raw_monitor, HASH(customer_id, record_id)),
                     (Left.customer_id = Right.customer_id) AND
                     (Left.record_id = Right.record_id),
                     CheckNewRecods (Left, Right),
                     LEFT OUTER, LIMIT (1), LOCAL); // must be m : 1, want to fail if not

    // SECONDARY: check records in relation to each other
    ds_prim := GROUP (SORT (ds_join (~IsFatalError (err)), customer_id, record_id, seq, LOCAL), customer_id, record_id, LOCAL);
    // Only errors for D-transactions can be set here: two in a raw, or deleting non-existing rec.
    // Records with errors set earlier are not going through this transform.
    layouts.verification SetRequestProperties (layouts.verification L, layouts.verification R) := TRANSFORM
      boolean IsFirstRec := L.seq = 0;

      //error: to check only prev. record: D-tr can't be fatal errors before this transform
      err_D := (IsFirstRec AND R.new_id) OR (~IsFirstRec AND (L.request_code = 'D'));
      // only for status message:
      err_U := err_D;//(IsFirstRec AND  R.new_id) OR (~IsFirstRec AND (L.request_code = 'D'));
      err_A := (IsFirstRec AND ~R.new_id) OR (~IsFirstRec AND (L.request_code != 'D'));  

      Self.new_id := IF (IsFirstRec, R.new_id, L.request_code = 'D'); // means "now it is new record"
      Self.err := R.err + IF (err_D AND (R.request_code = 'D'), Constants.ERR_CODE.RECORD_NOT_FOUND, 0);

      // set warning status; in case of fatal errors, it will be overwritten later
      Self.status := IF (R.err & Constants.ERR_CODE.PERSON = Constants.ERR_CODE.PERSON, 'incomplete personal; ', '') +
                     MAP ((R.request_code = 'A') and err_A => ' record exists, updated', 
                          (R.request_code = 'U') and err_U => ' record doesn\'t exist, added',
                          (R.request_code = 'R') => ' recon', '');
      SELF := R; 
    END;
    ds_iter := ITERATE (ds_prim, SetRequestProperties (Left, Right));

    // Only non-fatal transaction can be executable, and only the latest one is actually being;
    exec_transactions := DEDUP (SORT (ds_iter (~IsFatalError (err)), record_id, -seq), record_id);

    layouts.verification SetExecutable (layouts.verification L, layouts.verification R) := TRANSFORM
      boolean IsSame := L.seq = R.seq;
      Self.executed := IsSame;
      // fatal errors status overwrites warnings (on the LEFT side only)
      Self.status := IF (IsSame, 
                         R.status,
                         IF (IsFatalError (L.err), // choose one (any, since string length is limited
                             MAP (L.err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID => 'INVALID CLIENT ID',
                                  L.err & Constants.ERR_CODE.REQUEST = Constants.ERR_CODE.REQUEST => 'INVALID request code',
                                  L.err & Constants.ERR_CODE.ACCOUNT = Constants.ERR_CODE.ACCOUNT => 'INVALID record account',
                                  L.err & Constants.ERR_CODE.RECORD_NOT_FOUND = Constants.ERR_CODE.RECORD_NOT_FOUND => 'RECORD NOT FOUND',
                                  L.err & Constants.ERR_CODE.REQUEST_TYPE = Constants.ERR_CODE.REQUEST_TYPE => 'INVALID request type',
                                  'unknown'),
                             L.status));

      self := IF (IsSame, R, L);
    END;
    verified := JOIN (ds_iter + ds_join (IsFatalError (err)), exec_transactions,
                      Left.seq = Right.seq,
                      SetExecutable (Left, Right),
                      left outer, limit (1), local);  
    return verified;
  END;


  EXPORT GetMonitorSettings (string20 request_type, unsigned2 score) := FUNCTION
    // this code demonstrates (?) that a customer should be represented by an object anyway...
    // choose objects to monitor, delays, frequencies according to the score
    sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC + phn.PHONE_TD + phn.PHONE_TG;
    res := dataset ([
      {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_ADDRESS,  false, ''},
      {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PHONE,    false, ''}
      // {subj.PROPERTY, 0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PROPERTY, false, ''},
      // {subj.PAW,      0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAX_OUTPUT_PAW,      false, ''}
    ], layouts.m_settings);
    return res;
  END; 


  // Normalize by address (normalization by phone is done separately).
  EXPORT layouts.address_norm NormalizeByAddress (layouts.verification L, unsigned1 C) := FUNCTION
    //  ------------  clean address  ------------
    //choose(...) won't work
    addr := MAP (C=1 => L.addr_1, C=2 => L.addr_2, C=3 => L.addr_3, C=4 => L.addr_4, C=5 => L.addr_5, 
                 C=6 => L.addr_6, C=7 => L.addr_7, C=8 => L.addr_8, C=9 => L.addr_9, C=10 => L.addr_10,
                 C=11 => L.addr_11, C=12 => L.addr_12, L.addr_1);
    string address_line_1 := addr.line_1 + ' ' + addr.line_2;
    string address_line_2 := addr.city + ' ' + addr.state + ' ' + addr.zip;
    boolean hasValidAddress := (trim (address_line_1) != '') and (trim (address_line_2) != '');

    address_cleaned := IF (hasValidAddress, address.CleanAddress182 (address_line_1, address_line_2), '');

    // IMPORTANT ASSUMPTION: if not all addresses are blank, then necessarily FIRST is not blank.
    // Condition C <> 1 is to keep at least one record even all addresses are blank,
    // since object can be identified by other than addresses.
    layouts.address_norm myTransform := TRANSFORM, SKIP (C <> 1 and not hasValidAddress) 
      Self.seq := C;         // "importance" of this address for this account record

      Self.customer_id := L.customer_id;
      Self.record_id   := L.record_id;
      // MAC_AssignAddress ();  
      Monitoring.Client (customer_id).MAC_AssignAddress ();
      //TODO: WHAT TO DO WITH string60 full_name;

      Self.matrix := GetMonitorSettings (L.request_type, L.score);
      SELF := L;  //wuid, executed
      SELF := []; // standard.Name_Slim, phoneno, glb_purpose, dppa_purpose, market_restriction, 
                  // addr_version_number, phone_version_number, Self.transaction_type, phone_level_other1 (2,3), 
                  // src, best_address_count 
    END;
    return myTransform;
  END;


  // This we will need only for a send history
  EXPORT layouts.phone_history_ext NormalizeByPhone (layouts.verification L, unsigned C) := FUNCTION
    phone := MAP (C=1 => L.phone_1, C=2 => L.phone_2, C=3 => L.phone_3, C=4 => L.phone_4, C=5 => L.phone_5, 
                  C=6 => L.phone_6, C=7 => L.phone_7, C=8 => L.phone_8, C=9 => L.phone_9, C=10 => L.phone_10,
                  C=11 => L.phone_11, C=12 => L.phone_12, C=13 => L.phone_13, C=14 => L.phone_14, C=15 => L.phone_15,
                  C=16 => L.phone_16, C=17 => L.phone_17, C=18 => L.phone_18, C=19 => L.phone_19, C=20 => L.phone_20,
                  L.phone_1);
    boolean hasValidPhone := (phone != '') AND ((unsigned8) phone != 0);

    layouts.phone_history_ext myTransform := TRANSFORM, SKIP (not hasValidPhone) 
      Self.seq := C;         // "importance" of this phone for this account record
      Self.IsBatchOutput := false;   // specifies if this phone comes from batch portion

      Self.customer_id := L.customer_id;
      Self.record_id   := L.record_id;

      Self.phone10 := phone;
      Self := L;   
      SELF := []; // phone_dt_last_seen, phone_dt_first_seen, phone_type, dual_name_flag, listing_type, 
                  // publish_code, carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
    END;
    return myTransform;
  END;


  EXPORT string GetID (string id_1, string id_2, string id_3) := function
    string id_1_trim := trim (id_1); // cannot be blank!
    string id_2_trim := trim (id_2);
    string id_3_trim := trim (id_3);
    id := id_1_trim + if (id_2_trim != '', '_' + id_2_trim, '') + if (id_3_trim != '', '_' + id_3_trim, ''); 
    return id;
  END;

  // Transforming batch-input history data into monitoring internal layouts
  // some things are formal here (NCO legacy): seq = 1; IsBatch=true, etc.
  //TODO: checking for validity here will be redundant, if batch won't send blank addresses...
  EXPORT layouts.address_history_ext FormatBatchAddress (layouts.batch_in_address L, string16 WUID) := FUNCTION
    string city_state_zip := L.city + ' ' + L.state + ' ' + L.zip;
    boolean is_valid := (trim (L.address) != '') and (trim (city_state_zip) != '');
    layouts.address_history_ext myTransform := transform, SKIP (not is_valid)
      Self.seq := 1;               // importance (pseudo) of this address for this account record
      Self.IsBatchOutput := TRUE;  // specifies if this address comes from batch portion
      Self.wuid := WUID;
      Self.customer_id := customer_id;
      Self.record_id   := GetID (L.rec.UniqueID_1, L.rec.UniqueID_2, L.rec.UniqueID_3);

      // clean address:
      Monitoring.Client (customer_id).MAC_CleanAddress (L.address, city_state_zip);

      Self.addr_dt_last_seen  := L.date_last[1..6];
      Self.addr_dt_first_seen := L.date_first[1..6]; 

      Self := L; //standard.Name_Slim
      Self := []; //src, best_address_count, addr_version_count
    end;
    return myTransform;
  END;

  // NB: listing name is ignored
  EXPORT layouts.phone_history_ext FormatBatchPhone (layouts.batch_in_phone L, string16 WUID) := FUNCTION

    string tphone := trim (L.phone);
    boolean is_valid := (tphone != '') and (length (tphone) >= 7);
    layouts.phone_history_ext myTransform := transform, SKIP (not is_valid)
      Self.seq := 1;
      Self.IsBatchOutput := TRUE;

      Self.wuid := WUID;
      Self.customer_id := customer_id;
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

  EXPORT layouts.property_history_ext FormatBatchProperty (layouts.batch_in_property L, string WUID) := TRANSFORM
    Self.seq := 1;         
    Self.IsBatchOutput := TRUE; 

    Self.wuid := WUID;
    Self.customer_id := customer_id;
    Self.record_id   := GetID (L.rec.UniqueID_1, L.rec.UniqueID_2, L.rec.UniqueID_3);

    // clean address:
    string city_state_zip := L.prop_city + ' ' + L.prop_state + ' ' + L.prop_zipcode;
    Monitoring.Client (customer_id).MAC_CleanAddress (L.address, city_state_zip);

    SELF := L; //parcel_number, name_owner_1, name_owner_2
  END;


  EXPORT layouts.paw_history_ext FormatBatchPaw (layouts.batch_in_paw L, string WUID) := TRANSFORM
    Self.seq := 1;
    Self.IsBatchOutput := TRUE;

    Self.wuid := WUID;
    Self.customer_id := customer_id;
    Self.record_id   := GetID (L.rec.UniqueID_1, L.rec.UniqueID_2, L.rec.UniqueID_3);
    Self.phone10 := L.phone;

    // clean address:
    string city_state_zip := L.city + ' ' + L.state + ' ' + L.zip5;
    Monitoring.Client (customer_id).MAC_CleanAddress (L.address, city_state_zip);

    SELF := L; //parcel_number, names, name_owner_1, name_owner_2
  END;


  EXPORT SendAddress ( 
    DATASET (Monitoring.layout_address_update) addr_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath) :=
  Monitoring.Client (customer_id).SendAddress (addr_new, addr_hist, target_ip, target_path);

  EXPORT SendPhone ( 
    DATASET (Monitoring.layout_phone_out) phone_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath) := 
  Monitoring.Client (customer_id).SendPhone (phone_new, addr_hist, target_ip, target_path);

  EXPORT SendProperty (
    DATASET (Monitoring_Other.layout_prp_out) prop_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath) := 
  Monitoring.Client (customer_id).SendProperty (prop_new, addr_hist, target_ip, target_path);

  EXPORT SendPaw (
    DATASET (Monitoring_Other.layout_paw_out) paw_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath) := 
  Monitoring.Client (customer_id).SendPaw (paw_new, addr_hist, target_ip, target_path);
  
END;
