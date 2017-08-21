IMPORT ut, address, Monitoring_Other;

subj := Constants.T_SUBJECT;
phn  := Constants.T_PHONES;
LZ := Environment.LandingZone;

EXPORT Client_PRA := MODULE

  shared string8 current_date := ut.GetDate;
  shared string wuid := thorlib.wuid ();

  // defines the number of "new found" objects to return
  EXPORT unsigned1 MAXNUM_ADDRESS  := 8;
  EXPORT unsigned1 MAXNUM_PHONE    := 10;
  EXPORT unsigned1 MAXNUM_PROPERTY := 3;
  EXPORT unsigned1 MAXNUM_PAW      := 3;

  EXPORT boolean IsFatalError (unsigned1 err) := 
    (err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID) OR 
    (err & Constants.ERR_CODE.REQUEST = Constants.ERR_CODE.REQUEST) OR 
    (err & Constants.ERR_CODE.ACCOUNT = Constants.ERR_CODE.ACCOUNT) OR
    // this is fatal for "delete" transactions only:
    (err & Constants.ERR_CODE.RECORD_NOT_FOUND = Constants.ERR_CODE.RECORD_NOT_FOUND);

  EXPORT string GetID (string24 acc_number, string2 relpos) := trim (acc_number) + '_' + relpos;


  // ====================================================================
  // ====================== INPUT VERIFICATION ==========================
  // ====================================================================
  EXPORT layouts_PRA.verification VerifyBatch (DATASET (layouts_PRA.batch_raw) batch_in, DATASET (layouts_PRA.batch_raw) raw_monitor) := FUNCTION

    // TODO: remove customer_id (it's the same for PRA)
    distr := DISTRIBUTE (batch_in, HASH(customer_id, record_id));
    srt := SORT (distr, customer_id, record_id, wuid, LOCAL);
 
    // PRIMARY: check every record individually (name+ssn or name+address should be specified, etc.); 
    // NB: "delete" records are not checked for ssn/name/address validity
    layouts_PRA.verification CheckConstraints (layouts_PRA.batch_raw L, integer C) := TRANSFORM
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
      boolean validPRA := (L.account != '');// rel_pos?

      SELF.err := IF (validPersonal, Constants.ERR_CODE.NOERR, Constants.ERR_CODE.PERSON) +
                  // fatal errors: 
                  IF (validPRA,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.CLIENT_ID) +
                  IF (validCode,     Constants.ERR_CODE.NOERR, Constants.ERR_CODE.REQUEST) +
                  IF (validAcc,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.ACCOUNT);
      SELF := L;
    END; 
    ds_namecheck_seq := PROJECT (srt, CheckConstraints (Left, COUNT));

    // check if record exists in Monitor DB:
    layouts_PRA.verification CheckNewRecods (layouts_PRA.verification L, layouts_PRA.batch_raw R) := TRANSFORM
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
    layouts_PRA.verification SetRequestProperties (layouts_PRA.verification L, layouts_PRA.verification R) := TRANSFORM
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

    layouts_PRA.verification SetExecutable (layouts_PRA.verification L, layouts_PRA.verification R) := TRANSFORM
      boolean IsSame := L.seq = R.seq;
      SELF.executed := IsSame;
      // fatal errors status overwrites warnings (on the LEFT side only)
      SELF.status := IF (IsSame, 
                         R.status,
                         IF (IsFatalError (L.err), // choose one (any, since string length is limited
                             MAP (L.err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID => 'INVALID PRA ID',
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
    unsigned sub_phone := phn.PHONE_TA + phn.PHONE_TB;

    res := dataset ([
      {subj.ADDRESS,  0,         Constants.T_FREQUENCY.DAY, 45, Constants.T_FREQUENCY.DAY, 1, MAXNUM_ADDRESS,  false, ''},
      {subj.PHONE,    sub_phone, Constants.T_FREQUENCY.DAY, 45, Constants.T_FREQUENCY.DAY, 1, MAXNUM_PHONE,    false, ''},
      {subj.PROPERTY, 0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAXNUM_PROPERTY, false, ''},
      {subj.PAW,      0,         Constants.T_FREQUENCY.NONE, 0, Constants.T_FREQUENCY.DAY, 1, MAXNUM_PAW,      false, ''}
    ], layouts.m_settings);
    return res;
  END; 


  // ====================================================================
  // ==================== ADDRESS/PHONE HISTORY =========================
  // ====================================================================
  EXPORT layouts.address_norm NormalizeToBase (layouts_PRA.verification L) := FUNCTION
    //  ------------  clean address  ------------
    // cannot SKIP even if invalid address (only 1 address per record, not many as with NCO)
    layouts.address_norm myTransform := TRANSFORM
      SELF.seq := 1;         // "importance" of this address for this account record
      SELF.IsBatchOutput := FALSE;   // specifies if this address comes from batch portion
      
      string city_state_zip := L.city + ' ' + L.state + ' ' + L.zip;
      Client (Constants.ClientID.PRA).MAC_CleanAddress (L.address, city_state_zip);

      SELF.addr_dt_last_seen := ''; // TODO?

      SELF.name_first := L.first_name; 
      SELF.name_middle := ''; 
      SELF.name_last := L.last_name;

      Self.matrix := GetMonitorSettings ();
      SELF := L;  //layouts.wid, executed, err
      SELF := []; // SELF.addr_dt_first_seen, name_suffix, dob, phoneno, glb_purpose, dppa_purpose, market_restriction, 
                  // addr_version_number, phone_version_number, SELF.transaction_type, phone_level_other1 (2,3), 
                  // src, best_address_count 
    END;
    return myTransform;
  END;

  //TODO: check if we need to test batch addresses for validity
  EXPORT layouts.address_history_ext FormatAddressHistory (layouts_PRA.batch_address L, string WUID) := TRANSFORM
    SELF.seq := 1;         // "importance" of this address for this account record
    SELF.IsBatchOutput := TRUE;   // specifies if this address comes from batch portion

    SELF.wuid := WUID;
    SELF.customer_id := Constants.ClientID.PRA;
    SELF.record_id   := GetID (L.account, L.rel_pos);

    // clean address:
    string city_state_zip := L.city + ' ' + L.state + ' ' + L.zip;
    Client (Constants.ClientID.PRA).MAC_CleanAddress (L.address, city_state_zip);
    SELF.addr_dt_last_seen  := L.date_last[1..6];
    SELF.addr_dt_first_seen := L.date_first[1..6]; 

    Self := L; //standard.Name_Slim
    Self := []; //src, best_address_count, addr_version_number
  END;

  EXPORT layouts.phone_history_ext NormalizeToPhoneHist (layouts_PRA.verification L, unsigned C) := FUNCTION
    // Up to 8 PRA-owned phones
    phone := CHOOSE (C, L.home_phone, L.work_phone, L.other_phone, L.phone_4, L.phone_5, L.phone_6, L.phone_7, L.phone_8, '');
    //clean it to strip '-', etc. (ut.CleanPhone returns either '' or string10):
    phone_clean := ut.CleanPhone (phone);
 
    boolean hasValidPhone := (phone != '') AND (phone != 'NULL') AND (phone_clean != '') AND 
                             ((unsigned8) phone_clean != 0) AND
    //"Lexis Nexis will delete anything with 7 zero's, or where the 7 digit number starts with a zero"
                             (phone_clean[4] != '0');

    layouts.phone_history_ext myTransform := TRANSFORM, SKIP (not hasValidPhone) 
      SELF.seq := C;         // "importance" of this phone for this account record
      SELF.IsBatchOutput := FALSE; // specifies if this phone comes from batch portion

      SELF.phone10 := phone_clean;
      SELF.phone_type := '';

      // take name from NCO portion
	    SELF.name_first := L.first_name; 
	    SELF.name_middle := ''; 
      SELF.name_last := L.last_name;

      SELF := L;  // layouts.wid
      SELF := []; // SELF.name_suffix, phone_dt_last_seen, phone_dt_first_seen, dual_name_flag, 
                  // listing_type, publish_code, carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
    END;
    return myTransform;
  END;

  EXPORT layouts.phone_history_ext FormatPhoneHistory (layouts_PRA.batch_phone L, string WUID) := TRANSFORM
    SELF.seq := 1;         // "importance" of this address for this account record
    SELF.IsBatchOutput := TRUE;   // specifies if this address comes from batch portion

    SELF.wuid := WUID;
    SELF.customer_id := Constants.ClientID.PRA;
    SELF.record_id   := GetID (L.account, L.rel_pos);

    SELF.phone10 := L.phone;

    SELF.phone_dt_last_seen  := L.date_last [1..6];
    SELF.phone_dt_first_seen := L.date_first [1..6];
    SELF.phone_type := L.subj_phone_type;

    Self := L; //standard.Name_Slim
    Self := []; // dual_name_flag, listing_type, 
                // publish_code, carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
  END;

  EXPORT layouts.property_history_ext FormatPropHistory (layouts_PRA.batch_property L, string WUID) := TRANSFORM
    SELF.seq := 1;         // "importance" of this address for this account record
    SELF.IsBatchOutput := TRUE;   // specifies if this address comes from batch portion

    SELF.wuid := WUID;
    SELF.customer_id := Constants.ClientID.PRA;
    SELF.record_id   := GetID (L.account, L.rel_pos);

    // clean address:
    string city_state_zip := L.prop_city + ' ' + L.prop_state + ' ' + L.prop_zipcode;
    Client (Constants.ClientID.PRA).MAC_CleanAddress (L.address, city_state_zip);

    SELF := L; //parcel_number, name_owner_1, name_owner_2
  END;


  EXPORT layouts.paw_history_ext FormatPawHistory (layouts_PRA.batch_paw L, string WUID) := TRANSFORM
    SELF.seq := 1;         // "importance" of this address for this account record
    SELF.IsBatchOutput := TRUE;   // specifies if this address comes from batch portion

    SELF.wuid := WUID;
    SELF.customer_id := Constants.ClientID.PRA;
    SELF.record_id   := GetID (L.account, L.rel_pos);

    SELF.phone10 := L.phone;

    // clean address:
    string city_state_zip := L.city + ' ' + L.state + ' ' + L.zip5;
    Client (Constants.ClientID.PRA).MAC_CleanAddress (L.address, city_state_zip);

    SELF := L; //parcel_number, name_owner_1, name_owner_2
  END;


  EXPORT SendReport (string target_ip = LZ.ip, string target_path = LZ.reportPath) := FUNCTION

    layout_report := record
      layouts_PRA.pra_id;
      layouts_PRA.batch_raw.first_name;
      layouts_PRA.batch_raw.last_name;
      layouts_PRA.batch_raw.SSN;
      string8 process_date; // from WUID
    end;

    ds_report := project (Monitoring.Files.PRA.Raw, transform (layout_report, 
                                                               Self.process_date := Left.wuid[2..9]; Self := Left));
    // save csv file in THOR
    fname_thor := Files.Names.PRA_ROOT + 'RECONCILIATION';
    saveCSV_thor := OUTPUT (ds_report, , fname_thor, CSV (separator('|'), terminator('\n'), QUOTE('"'), maxlength (128)), OVERWRITE);

    // despray the file
    string fname_dest := target_path + 'PRA/' + wuid[2..] + '_RECONCILIATION.CSV';
    despray  := FileServices.Despray (fname_thor, target_ip, fname_dest, , , , TRUE);

    return sequential (saveCSV_thor, despray);
  END;
END;