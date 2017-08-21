IMPORT ut, address, Monitoring_Other;

subj := Constants.T_SUBJECT;
phn  := Constants.T_PHONES;

EXPORT Client_BWH := MODULE

  shared string8 current_date := ut.GetDate;
  shared string wuid := thorlib.wuid ();

  // defines the number of "new found" objects to return
  EXPORT unsigned1 MAXNUM_ADDRESS  := 1;
  EXPORT unsigned1 MAXNUM_PHONE    := 10;

  EXPORT boolean IsFatalError (unsigned1 err) := 
    (err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID) OR 
    (err & Constants.ERR_CODE.REQUEST = Constants.ERR_CODE.REQUEST) OR 
    (err & Constants.ERR_CODE.ACCOUNT = Constants.ERR_CODE.ACCOUNT) OR
    // this is fatal for "delete" transactions only:
    (err & Constants.ERR_CODE.RECORD_NOT_FOUND = Constants.ERR_CODE.RECORD_NOT_FOUND);

  EXPORT string GetID (string25 acc_number) := trim (acc_number);


  // ====================================================================
  // ====================== INPUT VERIFICATION ==========================
  // ====================================================================
  EXPORT layouts_BWH.verification VerifyBatch (DATASET (layouts_BWH.batch_raw) batch_in, DATASET (layouts_BWH.batch_raw) raw_monitor) := FUNCTION

    // TODO: remove customer_id (it's the same for BWH)
    distr := DISTRIBUTE (batch_in, HASH(customer_id, record_id));
    srt := SORT (distr, customer_id, record_id, wuid, LOCAL);
 
    // PRIMARY: check every record individually (name+ssn or name+address should be specified, etc.); 
    // NB: "delete" records are not checked for ssn/name/address validity
    layouts_BWH.verification CheckConstraints (layouts_BWH.batch_raw L, integer C) := TRANSFORM
      Self.seq := C; // need sequencing, to keep records in the order they were sorted

      // personal info: any 2 of three are allowed for identification
      boolean IsNamed := trim (L.last_name) != '';
      boolean IsSSNed := (length (trim (L.ssn)) = 9) and (length (StringLib.StringFilterOut (L.ssn, '0123456789')) = 0);
      trim_city  := stringlib.StringToUpperCase (trim (L.city));
      trim_state := stringlib.StringToUpperCase (trim (L.state));
      boolean IsAddressed := (trim_city  != '' and trim_city  != 'NULL' and trim_state != '' and trim_state != 'NULL') OR 
                             ((unsigned8) trim(L.zip) != 0);
      boolean validPersonal := (IsNamed and IsSSNed) or (IsNamed and IsAddressed) or (IsSSNed and IsAddressed) or
                               (L.request_code = 'D'); //delete" transactions are not checked for person's validity;

      boolean validCode := L.request_code IN ['A', 'U', 'D', 'R'];
      boolean validAcc  := (L.record_id != '') AND (L.record_id[1] != '_'); // just rel_pos is invalid 
      boolean validBWH := (L.account != '');// rel_pos?

      SELF.err := IF (validPersonal, Constants.ERR_CODE.NOERR, Constants.ERR_CODE.PERSON) +
                  // fatal errors: 
                  IF (validBWH,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.CLIENT_ID) +
                  IF (validCode,     Constants.ERR_CODE.NOERR, Constants.ERR_CODE.REQUEST) +
                  IF (validAcc,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.ACCOUNT);
      SELF := L;
    END; 
    ds_namecheck_seq := PROJECT (srt, CheckConstraints (Left, COUNT));

    // check if record exists in Monitor DB:
    layouts_BWH.verification CheckNewRecods (layouts_BWH.verification L, layouts_BWH.batch_raw R) := TRANSFORM
      boolean existing := (L.customer_id = R.customer_id) AND (L.record_id = R.record_id);
      SELF.new_id := ~existing;
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
    layouts_BWH.verification SetRequestProperties (layouts_BWH.verification L, layouts_BWH.verification R) := TRANSFORM
      boolean IsFirstRec := L.seq = 0;

      //error: to check only prev. record: D-tr can't be fatal errors before this transform
      err_D := (IsFirstRec AND R.new_id) OR (~IsFirstRec AND (L.request_code = 'D'));
      // only for status message:
      err_U := err_D;//(IsFirstRec AND  R.new_id) OR (~IsFirstRec AND (L.request_code = 'D'));
      err_A := (IsFirstRec AND ~R.new_id) OR (~IsFirstRec AND (L.request_code != 'D'));  

      SELF.new_id := IF (IsFirstRec, R.new_id, L.request_code = 'D'); // means "now it is new record"
      SELF.err := R.err + IF (err_D AND (R.request_code = 'D'), Constants.ERR_CODE.RECORD_NOT_FOUND, 0);

      // set warning status; in case of fatal errors, it will be overwritten later
      SELF.status := IF (R.err & Constants.ERR_CODE.PERSON = Constants.ERR_CODE.PERSON, 'incomplete personal; ', '') +
                     MAP ((R.request_code = 'A') and err_A => ' record exists, updated', 
                          (R.request_code = 'U') and err_U => ' record doesn\'t exist, added',
                          (R.request_code = 'R') => ' recon', '');
      SELF := R; 
    END;
    ds_iter := ITERATE (ds_prim, SetRequestProperties (Left, Right));

    // Only non-fatal transaction can be executable, and only the latest one is actually being;
    exec_transactions := DEDUP (SORT (ds_iter (~IsFatalError (err)), record_id, -seq), record_id);

    layouts_BWH.verification SetExecutable (layouts_BWH.verification L, layouts_BWH.verification R) := TRANSFORM
      boolean IsSame := L.seq = R.seq;
      SELF.executed := IsSame;
      // fatal errors status overwrites warnings (on the LEFT side only)
      SELF.status := IF (IsSame, 
                         R.status,
                         IF (IsFatalError (L.err), // choose one (any, since string length is limited
                             MAP (L.err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID => 'INVALID BWH ID',
                                  L.err & Constants.ERR_CODE.REQUEST = Constants.ERR_CODE.REQUEST => 'INVALID request code',
                                  L.err & Constants.ERR_CODE.ACCOUNT = Constants.ERR_CODE.ACCOUNT => 'INVALID record account',
                                  L.err & Constants.ERR_CODE.RECORD_NOT_FOUND = Constants.ERR_CODE.RECORD_NOT_FOUND => 'RECORD NOT FOUND',
                                  'unknown'),
                             L.status));

      SELF := IF (IsSame, R, L);
    END;
    verified := JOIN (ds_iter + ds_join (IsFatalError (err)), exec_transactions,
                      Left.seq = Right.seq,
                      SetExecutable (Left, Right),
                      LEFT OUTER, LIMIT (1), LOCAL);  
    return verified;
  END;


  // ====================== MONITOR SETTINGS ============================
  EXPORT layouts.m_settings GetMonitorSettings () := FUNCTION
    unsigned sub_phone := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC + phn.PHONE_TG;
    res := dataset ([
      {subj.ADDRESS,  0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAXNUM_ADDRESS,  false, ''},
      {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAXNUM_PHONE,    false, ''}
    ], layouts.m_settings);
    return res;
  END; 


  // ====================================================================
  // ==================== ADDRESS/PHONE HISTORY =========================
  // ====================================================================
  // this differs from NCO: only BWH data
  EXPORT layouts.address_norm NormalizeToBase (layouts_BWH.verification L, unsigned C) := FUNCTION
    //  ------------  clean address  ------------
    // up tp 6 BWH-owned batch-input addresses
    string address_line_1 := CHOOSE (C, L.address, L.address_2, L.address_3, L.address_4, L.address_5, L.address_6, '');
    string address_line_2 := CHOOSE (C, 
      L.city +   ' ' + L.state + ' '   + L.zip,   L.City_2 + ' ' + L.State_2 + ' ' + L.Zip_2, 
      L.City_3 + ' ' + L.State_3 + ' ' + L.Zip_3, L.City_4 + ' ' + L.State_4 + ' ' + L.Zip_4, 
      L.City_5 + ' ' + L.State_5 + ' ' + L.Zip_5, L.City_6 + ' ' + L.State_6 + ' ' + L.Zip_6, ''); 

    boolean hasValidAddress := (trim (address_line_1) != '') and (trim (address_line_2) != '');

    address_cleaned := IF (hasValidAddress, address.CleanAddress182 (address_line_1, address_line_2), '');

    layouts.address_norm myTransform := TRANSFORM, SKIP(c <> 1 and not hasValidAddress) 
      SELF.seq := C;         // "importance" of this address for this account record
      SELF.IsBatchOutput := false;   // specifies this address doesn't ever comes from batch portion

      SELF.customer_id := L.customer_id;
      SELF.record_id   := L.record_id;

      Client (Constants.ClientID.BWH).MAC_AssignAddress ();

      SELF.addr_dt_last_seen := '';

      SELF.name_first  := L.first_name; 
      SELF.name_middle := L.middle_name; 
      SELF.name_last   := L.last_name;
      SELF.name_suffix := L.suffix;

      Self.dppa_purpose := (unsigned1) L.DPPA;
      Self.glb_purpose := (unsigned1) L.GLBA;

      Self.matrix := GetMonitorSettings ();
      SELF := L;  //wuid, executed
      SELF := []; // name_suffix, dob, phoneno, market_restriction, addr_version_number, phone_version_number,
                     // transaction_type, addr_dt_first_seen, phone_level_other2 - 3, 
                     // src, best_address_count 
    END;
    return myTransform;
  END;


  // only BWH data
  EXPORT layouts.phone_history_ext NormalizeToPhoneHist (layouts_BWH.verification L, unsigned C) := FUNCTION
    // 10 BWH-owned phones
    phone := CHOOSE (C, L.phone, L.phone_2, L.phone_3, L.phone_4, L.phone_5, 
                        L.phone_6, L.phone_7, L.phone_8, L.phone_9, L.phone_10, '');
    boolean hasValidPhone := (phone != '') AND ((unsigned8) phone != 0);

    layouts.phone_history_ext myTransform := TRANSFORM, SKIP (not hasValidPhone) 
      SELF.seq := C;         // "importance" of this phone for this account record
      SELF.IsBatchOutput := false;   // specifies if this phone comes from batch portion

      SELF.customer_id := L.customer_id;
      SELF.record_id   := L.record_id;
      SELF.phone10 := phone;
      SELF.phone_type := '';

      SELF.name_first  := L.first_name; 
      SELF.name_middle := L.middle_name; 
      SELF.name_last   := L.last_name;
      SELF.name_suffix := L.suffix;
   
      SELF.wuid := L.wuid;
      SELF := []; // phone_dt_last_seen, phone_dt_first_seen, dual_name_flag, listing_type, publish_code,
                  // carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
    END;
    return myTransform;
  END;





  //TODO: check if we need to test batch addresses for validity
  EXPORT layouts.address_history_ext GetBatchAddresses (layouts_BWH.batch_thor_input L, unsigned C, string WUID) := FUNCTION
    //  ------------  clean address  ------------
    // up tp 6 batch-input addresses
    string address_line_1 := CHOOSE (C, L.New_Address_1, L.New_Address_2, L.New_Address_3,
                                        L.New_Address_4, L.New_Address_5, L.New_Address_6, '');
    string address_line_2 := CHOOSE (C, 
      L.New_City_1 + ' ' + L.New_State_1 + ' ' + L.New_Zip_1, L.New_City_2 + ' ' + L.New_State_2 + ' ' + L.New_Zip_2, 
      L.New_City_3 + ' ' + L.New_State_3 + ' ' + L.New_Zip_3, L.New_City_4 + ' ' + L.New_State_4 + ' ' + L.New_Zip_4, 
      L.New_City_5 + ' ' + L.New_State_5 + ' ' + L.New_Zip_5, L.New_City_6 + ' ' + L.New_State_6 + ' ' + L.New_Zip_6, ''); 
    boolean hasValidAddress := (trim (address_line_1) != '') and (trim (address_line_2) != '');

    address_cleaned := IF (hasValidAddress, address.CleanAddress182 (address_line_1, address_line_2), '');

    layouts.address_history_ext myTransform := TRANSFORM, SKIP(c <> 1 and not hasValidAddress) 
      SELF.seq := C;         // "importance" of this address for this account record
      SELF.IsBatchOutput := false;   // specifies this address doesn't ever comes from batch portion
      Self.wuid := WUID;
      SELF.customer_id := Constants.ClientID.BWH;
      SELF.record_id   := GetID (L.account);

      Client (Constants.ClientID.BWH).MAC_AssignAddress ();

      SELF.name_first  := L.first_name; 
      SELF.name_middle := L.middle_name; 
      SELF.name_last   := L.last_name;
      SELF.name_suffix := L.suffix;

      SELF := []; // SELF.addr_dt_first_seen, SELF.addr_dt_last_seen, 
                  // src, best_address_count, addr_version_number
    END;
    return myTransform;
  END;

//    string65 New_Listing_Name_1;

  EXPORT layouts.phone_history_ext GetBatchPhones (layouts_BWH.batch_thor_input L, unsigned C, string WUID) := FUNCTION
    // 10 BWH-owned phones
    phone := CHOOSE (C, L.New_Phone_1, L.New_Phone_2, L.New_Phone_3, L.New_Phone_4, L.New_Phone_5, 
                        L.New_Phone_6, L.New_Phone_7, L.New_Phone_8, L.New_Phone_9, L.New_Phone_10, '');
    boolean hasValidPhone := (phone != '') AND ((unsigned8) phone != 0);

    layouts.phone_history_ext myTransform := TRANSFORM, SKIP (not hasValidPhone) 
      SELF.seq := C;         // "importance" of this phone for this account record
      SELF.IsBatchOutput := false;   // specifies if this phone comes from batch portion
      Self.wuid := WUID;
      SELF.customer_id := Constants.ClientID.BWH;
      SELF.record_id   := GetID (L.account);

      SELF.phone10 := phone;
      SELF.phone_type := CHOOSE (C, L.New_Phone_Type_1, L.New_Phone_Type_2, L.New_Phone_Type_3, L.New_Phone_Type_4, L.New_Phone_Type_5, 
                                    L.New_Phone_Type_6, L.New_Phone_Type_7, L.New_Phone_Type_8, L.New_Phone_Type_9, L.New_Phone_Type_10, '');

      SELF.name_first  := L.first_name; 
      SELF.name_middle := L.middle_name; 
      SELF.name_last   := L.last_name;
      SELF.name_suffix := L.suffix;
   
      SELF := []; // phone_dt_last_seen, phone_dt_first_seen, dual_name_flag, listing_type, publish_code,
                  // carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
    END;
    return myTransform;
  END;
END;