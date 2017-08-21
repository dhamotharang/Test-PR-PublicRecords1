IMPORT ut, address;

LZ := Environment.LandingZone;
subj := Constants.T_SUBJECT;
hpn  := Constants.T_PHONES;

EXPORT Client_NCO := MODULE

  shared current_date := ut.GetDate;

  // defines the number of "new found" objects to return
  EXPORT unsigned1 MAXNUM_PHONE := 10;
  EXPORT unsigned1 MAXNUM_ADDRESS := 6;

  // NEW FEATURE (09 Feb. 2008): only few errors are fatal, otherwise all records are added to monitor
  EXPORT boolean IsFatalError (unsigned1 err) := 
    (err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID) OR 
    (err & Constants.ERR_CODE.REQUEST = Constants.ERR_CODE.REQUEST) OR 
    (err & Constants.ERR_CODE.ACCOUNT = Constants.ERR_CODE.ACCOUNT) OR
    (err & Constants.ERR_CODE.RECORD_NOT_FOUND = Constants.ERR_CODE.RECORD_NOT_FOUND); // for "delete" transactions only

  EXPORT string GetID (string old_id) := FUNCTION
    unsigned dash := stringlib.StringFind (old_id, '-', 1);
    return IF (dash > 0, old_id [dash+1 ..], old_id);
  END;
 
  // ====================================================================
  // ====================== INPUT VERIFICATION ==========================
  // ====================================================================

  EXPORT VerifyBatch (DATASET (layouts_NCO.batch_raw) batch_in, DATASET (layouts_NCO.batch_raw) raw_monitor) := FUNCTION

    distr := DISTRIBUTE (batch_in, HASH(customer_id, record_id));
    srt := SORT (distr, customer_id, record_id, wuid, LOCAL);
 
    // PRIMARY: check every record individually (name+ssn or name+address should be specified, etc.); 
    // NB: "delete" records are not checked for ssn/name/address validity
    layouts_NCO.verification CheckConstraints (layouts_NCO.batch_raw L, integer C) := TRANSFORM
      Self.seq := C; // need sequencing, to keep records in the order they were sorted

      boolean IsNamed := trim (L.last_name) != '';
      boolean IsSSNed := (length (trim (L.ssn)) = 9) and (length (StringLib.StringFilterOut (L.ssn, '0123456789')) = 0);
      boolean IsAddressed := ((trim(L.city)!='') and (trim(L.state)!='')) OR (trim(L.zip)!='');

      boolean validCode := L.request_code IN ['A', 'U', 'D', 'R'];
      boolean validAcc  := L.record_id != ''; // NCO id is taken from file and CANNOT be invalid here
      boolean validPersonal := (IsNamed and IsSSNed) or (IsNamed and IsAddressed) or (IsSSNed and IsAddressed) or
                               (L.request_code = 'D'); //delete" transactions are not checked for person's validity;

      boolean validNCO := ((length (trim (L.nco_server)) = 3) AND (length (trim (L.work_source_id)) = 3)) OR
                          ((L.nco_server = '') and (L.work_source_id = ''));

      SELF.err := IF (validPersonal, Constants.ERR_CODE.NOERR, Constants.ERR_CODE.PERSON) +
                  // fatal errors: 
                  IF (validNCO,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.CLIENT_ID) +
                  IF (validCode,     Constants.ERR_CODE.NOERR, Constants.ERR_CODE.REQUEST) +
                  IF (validAcc,      Constants.ERR_CODE.NOERR, Constants.ERR_CODE.ACCOUNT);
      SELF := L;
    END; 
    ds_namecheck_seq := PROJECT (srt, CheckConstraints (Left, COUNT));

    // check if record exists in Monitor DB:
    layouts_NCO.verification CheckNewRecods (layouts_NCO.verification L, layouts_NCO.batch_raw R) := TRANSFORM
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
    layouts_NCO.verification SetRequestProperties (layouts_NCO.verification L, layouts_NCO.verification R) := TRANSFORM
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

    layouts_NCO.verification SetExecutable (layouts_NCO.verification L, layouts_NCO.verification R) := TRANSFORM
      boolean IsSame := L.seq = R.seq;
      SELF.executed := IsSame;
      // fatal errors status overwrites warnings (on the LEFT side only)
      SELF.status := IF (IsSame, 
                         R.status,
                         IF (IsFatalError (L.err), // choose one (any, since string length is limited
                             MAP (L.err & Constants.ERR_CODE.CLIENT_ID = Constants.ERR_CODE.CLIENT_ID => 'INVALID NCO server/source',
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
  EXPORT layouts.m_settings GetMonitorSettings (string1 pr_code, string3 nco_score) := FUNCTION
    unsigned1 code := (unsigned1) pr_code;
    unsigned2 score := (unsigned2) nco_score;

    unsigned1 DEFAULT_CODE := 0;
    unsigned1 DEFAULT_SCORE := 0;

    all_phones := hpn.PHONE_TA + hpn.PHONE_TB + hpn.PHONE_TD + hpn.PHONE_TG;
    all_phones_but_g := hpn.PHONE_TA + hpn.PHONE_TB + hpn.PHONE_TD;

    unsigned2 sub_phone := 
        MAP ((code = DEFAULT_CODE) and (score between   1 and 400) => all_phones_but_g,
             (code = DEFAULT_CODE) and (score between 401 and 549) => all_phones_but_g,
             (code = DEFAULT_CODE) and (score between 550 and 649) => all_phones,
             (code = DEFAULT_CODE) and (score between 650 and 899) => all_phones,
             (code = DEFAULT_CODE) and (score = 920) => all_phones_but_g,
             (code = DEFAULT_CODE) and (score = 921) => all_phones_but_g,
             (code = DEFAULT_CODE) and (score between 922 and 939) => all_phones_but_g,
             (code = DEFAULT_CODE) and (score between 940 and 959) => all_phones_but_g,
             (code = DEFAULT_CODE) and (score between 960 and 979) => all_phones,
             (code = DEFAULT_CODE) and (score between 980 and 999) => all_phones,
             (code = DEFAULT_CODE) and (score = DEFAULT_SCORE) => all_phones,
             subj.NONE);
/*
    // DELAYS: generally, means when to deliver updates for this subject first time
    string1 delay_type := 
        MAP ((code = DEFAULT_CODE) and (score between 1 and 400) => Constants.T_FREQUENCY.MONTH,
             (code = DEFAULT_CODE) and (score between 401 and 549) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score between 550 and 649) => Constants.T_FREQUENCY.NONE,
             (code = DEFAULT_CODE) and (score between 650 and 899) => Constants.T_FREQUENCY.NONE,
             (code = DEFAULT_CODE) and (score = 920) => Constants.T_FREQUENCY.MONTH,
             (code = DEFAULT_CODE) and (score = 921) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score between 922 and 939) => Constants.T_FREQUENCY.MONTH,
             (code = DEFAULT_CODE) and (score between 940 and 959) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score between 960 and 979) => Constants.T_FREQUENCY.NONE,
             (code = DEFAULT_CODE) and (score between 980 and 999) => Constants.T_FREQUENCY.NONE,
             (code = DEFAULT_CODE) and (score = DEFAULT_SCORE) => Constants.T_FREQUENCY.DAY,
             Constants.T_FREQUENCY.NONE);

    unsigned2 delay_time := 
        MAP ((code = DEFAULT_CODE) and (score between 1   and 400) => 1,
             (code = DEFAULT_CODE) and (score between 401 and 549) => 15,
             (code = DEFAULT_CODE) and (score between 550 and 649) => 1,
             (code = DEFAULT_CODE) and (score between 650 and 899) => 1,
             (code = DEFAULT_CODE) and (score = 920) => 1,
             (code = DEFAULT_CODE) and (score = 921) => 15,
             (code = DEFAULT_CODE) and (score between 922 and 939) => 1,
             (code = DEFAULT_CODE) and (score between 940 and 959) => 15, //check G-phone
             (code = DEFAULT_CODE) and (score between 960 and 979) => 1,
             (code = DEFAULT_CODE) and (score between 980 and 999) => 1,
             (code = DEFAULT_CODE) and (score = DEFAULT_SCORE) => 10,
              0);
*/
    // frequency updates for this subject are delivered with (after optional delay)
    string1 frequency_type := 
        MAP ((code = DEFAULT_CODE) and (score between 1 and 400) => Constants.T_FREQUENCY.MONTH,
             (code = DEFAULT_CODE) and (score between 401 and 549) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score between 550 and 649) => Constants.T_FREQUENCY.WEEK,
             (code = DEFAULT_CODE) and (score between 650 and 899) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score = 920) => Constants.T_FREQUENCY.MONTH,
             (code = DEFAULT_CODE) and (score = 921) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score between 922 and 939) => Constants.T_FREQUENCY.MONTH,
             (code = DEFAULT_CODE) and (score between 940 and 959) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score between 960 and 979) => Constants.T_FREQUENCY.WEEK,
             (code = DEFAULT_CODE) and (score between 980 and 999) => Constants.T_FREQUENCY.DAY,
             (code = DEFAULT_CODE) and (score = DEFAULT_SCORE) => Constants.T_FREQUENCY.DAY,
             Constants.T_FREQUENCY.NONE);

    unsigned2 frequency_time :=
        MAP ((code = DEFAULT_CODE) and (score between 1 and 400) => 1,  //month
             (code = DEFAULT_CODE) and (score between 401 and 549) => 15, // 2 weeks
             (code = DEFAULT_CODE) and (score between 550 and 649) => 1, // 1 week
             (code = DEFAULT_CODE) and (score between 650 and 899) => 1,
             (code = DEFAULT_CODE) and (score = 920) => 1,
             (code = DEFAULT_CODE) and (score = 921) => 15,
             (code = DEFAULT_CODE) and (score between 922 and 939) => 1,
             (code = DEFAULT_CODE) and (score between 940 and 959) => 15,
             (code = DEFAULT_CODE) and (score between 960 and 979) => 1,
             (code = DEFAULT_CODE) and (score between 980 and 999) => 1,
             (code = DEFAULT_CODE) and (score = DEFAULT_SCORE) => 10,
             0);

    res := dataset ([
      {subj.ADDRESS, 0,         Constants.T_FREQUENCY.DAY,  30, frequency_type, frequency_time, MAXNUM_ADDRESS, false, ''},
      {subj.PHONE,   sub_phone, Constants.T_FREQUENCY.NONE, 0,  frequency_type, frequency_time, MAXNUM_PHONE,   false, ''}
    ], layouts.m_settings);
    return res;
  END;


  // 1. Normalize by address (normalization by phone is easier and is done separately);
  // 2. Address-normed file will be used for address short-term history (slimmed down) and for updating monitor DB.
  // 3. Monitor DB needs only addresses from client (NCO) input -- upto 3 records, some monitor specific fields
  //    are calculated for these 3 records only;

  EXPORT layouts.address_norm NormalizeToBase (layouts_NCO.verification L, unsigned C) := FUNCTION
    //  ------------  clean address  ------------
    // (LN-output addresses were already cleaned once, but not passed to monitor, thus we need to "clean" them again, unfortunately.)
    // Possible optimization here: for example, skip those w/o zip, etc.
    string address_line_1 := CHOOSE (C, 
        // 3 NCO-owned batch-input addresses (string30 + string30)
        L.address1 + L.address2, L.former_address1 + L.former_address2, L.former_address1_2 + L.former_address2_2, 
        // 6 LN batch-output addresses (string50)
        L.subj_address_1, L.subj_address_2, L.subj_address_3, L.subj_address_4, L.subj_address_5, L.subj_address_6, '');

    string address_line_2 := CHOOSE (C, 
        // 3 NCO-owned input addresses (string30 + string2 + string9)
        L.city + ' ' + L.state + ' ' + L.zip, L.former_city + ' ' + L.former_state + ' ' + L.former_zip, L.former_city_2 + ' ' + L.former_state_2 + ' ' + L.former_zip_2,
        // 6 LN batch-output addresses (string28 + string2 + string10)
        L.subj_city_1 + ' ' + L.subj_state_1 + ' ' + L.subj_zipcode_1, L.subj_city_2 + ' ' + L.subj_state_2 + ' ' + L.subj_zipcode_2,
        L.subj_city_3 + ' ' + L.subj_state_3 + ' ' + L.subj_zipcode_3, L.subj_city_4 + ' ' + L.subj_state_4 + ' ' + L.subj_zipcode_4,
        L.subj_city_5 + ' ' + L.subj_state_5 + ' ' + L.subj_zipcode_5, L.subj_city_6 + ' ' + L.subj_state_6 + ' ' + L.subj_zipcode_6, '');

    boolean hasValidAddress := (trim (address_line_1) != '') and (trim (address_line_2) != '');

    address_cleaned := IF (hasValidAddress, address.CleanAddress182 (address_line_1, address_line_2), '');

    layouts.address_norm myTransform := TRANSFORM, SKIP(c <> 1 and not hasValidAddress) 
      SELF.seq := C;         // "importance" of this address for this account record
      SELF.IsBatchOutput := (C > 3);   // specifies if this address comes from batch portion

      SELF.customer_id := L.customer_id;
      SELF.record_id   := L.record_id;

      SELF.prim_range  := address_cleaned [1..10];
      SELF.predir      := address_cleaned [11..12];
      SELF.prim_name   := address_cleaned [13..40];
      SELF.addr_suffix := address_cleaned [41..44];
      SELF.postdir     := address_cleaned [45..46];
      SELF.unit_desig  := address_cleaned [47..56];
      SELF.sec_range   := address_cleaned [57..64];
      SELF.p_city_name := address_cleaned [65..89];
      SELF.v_city_name := address_cleaned [90..114];
      SELF.st          := address_cleaned [115..116]; //if ('', ziplib.ZipToState2, ...)
      SELF.zip5        := address_cleaned [117..121];
      SELF.zip4        := address_cleaned [122..125];
      SELF.addr_rec_type := address_cleaned [139..140];
      SELF.err_stat    := address_cleaned [179..182];

      SELF.addr_dt_last_seen := CHOOSE (C, '', '', '', 
        L.addr1_last_seen_date, L.addr2_last_seen_date, L.addr3_last_seen_date,
        L.addr4_last_seen_date, L.addr5_last_seen_date, L.addr6_last_seen_date, '');

       // take name from NCO portion (no name_suffix)
      SELF.name_first := L.first_name; 
      SELF.name_middle := L.middle; 
      SELF.name_last := L.last_name;

      Self.matrix := GetMonitorSettings (L.priority_code, L.nco_internal_score);
      SELF := L;  //wuid, executed
      SELF := []; // name_suffix, dob, phoneno, glb_purpose, dppa_purpose, market_restriction, 
                  // addr_version_number, phone_version_number, transaction_type, addr_dt_first_seen,  
                  // src, best_address_count, phone_level_other1,2,3
    END;
    return myTransform;
  END;


  EXPORT layouts.phone_history_ext NormalizeToPhoneHist (layouts_NCO.verification L, unsigned C) := FUNCTION
    phone := CHOOSE (C, 
      // 12 NCO-owned batch-input phones
      L.phone1, L.phone2, L.phone3, L.phone4, L.phone5, L.phone6, L.phone7, L.phone8, L.phone9, L.phone10, L.phone11, L.phone12,
      // 10 LN batch-output phones
      L.subj_phone1, L.subj_phone2, L.subj_phone3, L.subj_phone4, L.subj_phone5, L.subj_phone6, L.subj_phone7, L.subj_phone8, L.subj_phone9, L.subj_phone10, '');
    boolean hasValidPhone := (phone != '') AND ((unsigned8) phone != 0);

    layouts.phone_history_ext myTransform := TRANSFORM, SKIP (not hasValidPhone) 
      SELF.seq := C;         // "importance" of this phone for this account record
      SELF.IsBatchOutput := (C > 12);   // specifies if this phone comes from batch portion

      SELF.customer_id := L.customer_id;
      SELF.record_id   := L.record_id;

      SELF.phone10 := phone;

      SELF.phone_type := IF (C <= 12, '',
        CHOOSE (C - 12, L.subj_phone_type_1, L.subj_phone_type_2, L.subj_phone_type_3, L.subj_phone_type_4, L.subj_phone_type_5, 
                L.subj_phone_type_6, L.subj_phone_type_7, L.subj_phone_type_8, L.subj_phone_type_9, L.subj_phone_type_10, ''));

      // take name from NCO portion
	    SELF.name_first := L.first_name; 
	    SELF.name_middle := L.middle; 
      SELF.name_last := L.last_name;
   
      SELF.wuid := L.wuid;
      SELF := []; // SELF.name_suffix, phone_dt_last_seen, phone_dt_first_seen, dual_name_flag, 
                  // listing_type, publish_code, carrier_name, carrier_city, carrier_state, phone_version_number, best_phone_number
    END;
    return myTransform;
  END;
  

  shared string GetWarehouseHitsFileName (string6 nco_id) := FUNCTION
    string wuid := thorlib.wuid ();  // for ex.: W20071113-170048
    return 'WH' + nco_id + '_' + wuid [2..9] + '_0600_THOR.CSV';
  END;


  //IMPORTANT: 0-byte are sent for all files for which no real results were produced
  EXPORT JoinAndDespray (DATASET (layouts_NCO.monitor_update) new_data, 
                         string6 nco_id,
                         string target_ip, string target_path) := FUNCTION
    ds_server_ws := new_data (customer_id = 'NCO_' + nco_id);
    ds_raw := Files.NCO.ClientRaw (nco_id); // current raw file
  
    // join and project results to the original batch input
    layouts_NCO.monitor_result SetOutputFormat (layouts_NCO.batch_raw L, layouts_NCO.monitor_update R) := TRANSFORM
      SELF := R; // takes new addresses/phones (in "wide batch" layout also would blank other LN fields)
      SELF := L; 
      SELF := []; // blanks "subj_" fields
    END;
 
    ds_linkback := JOIN (ds_raw, ds_server_ws,
                         Left.record_id = Right.record_id,
                         SetOutputFormat (Left, Right),
                         ATMOST (1));

    ds_res := SORT (ds_linkback, nco_server, work_source_id, account_identifier);                  

    // save to csv file
    fname_csv := GetWarehouseHitsFileName (nco_id);
    fname_res := Files.Names.RESULT_DIR + 'nco::' + fname_csv;

    saveCSV := OUTPUT (ds_res, , fname_res, CSV (separator('|'), quote('"'), terminator('\n')));
    despray := FileServices.Despray (fname_res, target_ip, target_path + fname_csv, , , , TRUE);

    return if (exists (new_data), SEQUENTIAL (saveCSV, IF (nco_id NOT IN Files.FirstRunSet, despray)));
  END;



  shared string8 GetNCOValidDate (string date_in) := function
    date_tr := trim (date_in, left, right);
    strlen := length (date_tr);
    date_compl := MAP (strlen=4 => date_tr + '0101',
                       strlen=6 => date_tr + '01',
                       date_tr);

    year  := (unsigned) date_compl[1..4];
    month := (unsigned) date_compl[5..6];
    day   := (unsigned) date_compl[7..8];
    boolean IsValidDate := (year between 1900 and ((integer) current_date[1..4])) and (month between 1 and 12) and (day between 1 and 31);

    return IF ((strlen < 4) or (strlen=5) or (strlen = 7), '', IF (IsValidDate, date_compl, ''));
  end;


  EXPORT SendMonitorResults ( 
    DATASET (Monitoring.layout_address_update) addr_new,
    DATASET (Monitoring.layout_phone_out) phone_new,
    DATASET (Monitoring.Layout_Address_History) addr_hist,
    string target_ip = LZ.ip,
    string target_path = LZ.resultPath):= FUNCTION

    // take only those, which belong to NCO jobs
    addr_new_nco := addr_new (customer_id[1..4] = 'NCO_');
    phone_new_nco := phone_new (customer_id[1..4] = 'NCO_');

    dod_hist_nco := addr_hist (customer_id[1..4] = 'NCO_', prim_name[1..3]='DOD');

    // (lazy to write down 2 transform functions...)
    ds_both := PROJECT (addr_new_nco, transform (layouts.id, Self := Left)) + 
               PROJECT (phone_new_nco, transform (layouts.id, Self := Left));
    ids_raw := DEDUP (SORT (ds_both, customer_id, record_id), customer_id, record_id);
    
    ids := join (ids_raw, dod_hist_nco, 
                 left.customer_id = right.customer_id and 
                 left.record_id = right.record_id, 
                 transform(layouts.id, Self := Left),left only);
    
    ids_wide := PROJECT (ids, transform (layouts_NCO.monitor_update, SELF := Left; SELF := []));

    layouts_NCO.monitor_update DenormAddress (layouts_NCO.monitor_update L, Monitoring.layout_address_update R, unsigned C) := TRANSFORM
      SELF.customer_id := L.customer_id;
      SELF.record_id := L.record_id;

      // take address parts from the Right side
      rpredir := trim (R.predir);
      rpname := trim (R.prim_name);
      rsuffix := trim (R.suffix);
      rpostdir := trim (R.postdir);
      runit := trim (R.unit_desig);
      rsec := trim (R.sec_range);
      addr_line_t := trim (R.prim_range) + IF (rpredir != '', ' ' + rpredir, '') + IF (rpname   !='', ' ' + rpname,   '') +
                                           IF (rsuffix != '', ' ' + rsuffix, '') + IF (rpostdir !='', ' ' + rpostdir, '') + 
                                           IF (runit   != '', ' ' + runit,   '') + IF (rsec     !='', ' ' + rsec,     '');
      addr_line_1 := trim (addr_line_t, left);
      boolean IsCASSValid := R.z4 != '';
      addr_zip_10 := R.z5 + IF (R.z4 != '', '-' + R.z4, '');

      SELF.subj_address_1 := IF (C = 1, addr_line_1, L.subj_address_1);
      SELF.subj_city_1    := IF (C = 1, R.p_city_name, L.subj_city_1);
      SELF.subj_state_1   := IF (C = 1, R.st, L.subj_state_1);
      SELF.subj_zipcode_1 := IF (C = 1, addr_zip_10, L.subj_zipcode_1);
      SELF.addr1_last_seen_date := IF (C = 1, GetNCOValidDate (R.addr_dt_last_seen), L.addr1_last_seen_date);
      SELF.cass_or_dvp_flag_1 := IF ((C = 1) and IsCASSValid, 'C', L.cass_or_dvp_flag_1);

      SELF.subj_address_2 := IF (C = 2, addr_line_1, L.subj_address_2);
      SELF.subj_city_2    := IF (C = 2, R.p_city_name, L.subj_city_2);
      SELF.subj_state_2   := IF (C = 2, R.st, L.subj_state_2);
      SELF.subj_zipcode_2 := IF (C = 2, addr_zip_10, L.subj_zipcode_2);
      SELF.addr2_last_seen_date := IF (C = 2, GetNCOValidDate (R.addr_dt_last_seen), L.addr2_last_seen_date);
      SELF.cass_or_dvp_flag_2 := IF ((C = 2) and IsCASSValid, 'C', L.cass_or_dvp_flag_2);

      SELF.subj_address_3 := IF (C = 3, addr_line_1, L.subj_address_3);
      SELF.subj_city_3    := IF (C = 3, R.p_city_name, L.subj_city_3);
      SELF.subj_state_3   := IF (C = 3, R.st, L.subj_state_3);
      SELF.subj_zipcode_3 := IF (C = 3, addr_zip_10, L.subj_zipcode_3);
      SELF.addr3_last_seen_date := IF (C = 3, GetNCOValidDate (R.addr_dt_last_seen), L.addr3_last_seen_date);
      SELF.cass_or_dvp_flag_3 := IF ((C = 3) and IsCASSValid, 'C', L.cass_or_dvp_flag_3);

      SELF.subj_address_4 := IF (C = 4, addr_line_1, L.subj_address_4);
      SELF.subj_city_4    := IF (C = 4, R.p_city_name, L.subj_city_4);
      SELF.subj_state_4   := IF (C = 4, R.st, L.subj_state_4);
      SELF.subj_zipcode_4 := IF (C = 4, addr_zip_10, L.subj_zipcode_4);
      SELF.addr4_last_seen_date := IF (C = 4, GetNCOValidDate (R.addr_dt_last_seen), L.addr4_last_seen_date);
      SELF.cass_or_dvp_flag_4 := IF ((C = 4) and IsCASSValid, 'C', L.cass_or_dvp_flag_4);

      SELF.subj_address_5 := IF (C = 5, addr_line_1, L.subj_address_5);
      SELF.subj_city_5    := IF (C = 5, R.p_city_name, L.subj_city_5);
      SELF.subj_state_5   := IF (C = 5, R.st, L.subj_state_5);
      SELF.subj_zipcode_5 := IF (C = 5, addr_zip_10, L.subj_zipcode_5);
      SELF.addr5_last_seen_date := IF (C = 5, GetNCOValidDate (R.addr_dt_last_seen), L.addr5_last_seen_date);
      SELF.cass_or_dvp_flag_5 := IF ((C = 5) and IsCASSValid, 'C', L.cass_or_dvp_flag_5);

      SELF.subj_address_6 := IF (C = 6, addr_line_1, L.subj_address_6);
      SELF.subj_city_6    := IF (C = 6, R.p_city_name, L.subj_city_6);
      SELF.subj_state_6   := IF (C = 6, R.st, L.subj_state_6);
      SELF.subj_zipcode_6 := IF (C = 6, addr_zip_10, L.subj_zipcode_6);
      SELF.addr6_last_seen_date := IF (C = 6, GetNCOValidDate (R.addr_dt_last_seen), L.addr6_last_seen_date);
      SELF.cass_or_dvp_flag_6 := IF ((C = 6) and IsCASSValid, 'C', L.cass_or_dvp_flag_6);

//      SELF.input_phone_types := ''; // so far, always blank
      // scores: take from first met (temporarily?)
      SELF.name_score := IF (C = 1, R.name_score, L.name_score);
      SELF.ssn_score := IF (C = 1, R.ssn_score, L.name_score);
      
      SELF := L;
    END;

    // create denormed address
    addr_denormed := DENORMALIZE (ids_wide, addr_new_nco, 
                                  (Left.customer_id = Right.customer_id) AND (Left.record_id = Right.record_id),
                                  DenormAddress (Left, Right, COUNTER));

    MAC_set_phones (num, f1, val_1, f2, val_2, f3, val_3, f4, val_4) := MACRO
      SELF.f1 := IF (C = num, val_1, L.f1);
      SELF.f2 := IF (C = num, val_2, L.f2);
      SELF.f3 := IF (C = num, val_3, L.f3);
      SELF.f4 := IF (C = num, val_4, L.f4);
    ENDMACRO;

    layouts_NCO.monitor_update DenormPhones (layouts_NCO.monitor_update L, Monitoring.layout_phone_out R, unsigned C) := TRANSFORM
      // take phone parts from the Right side
      fname := trim (R.name_first, left, right);
      mname := trim (R.name_middle, left, right);
      lname := trim (R.name_last, left, right);
      name := trim (fname + IF (mname != '', ' ' + mname, '') + IF (lname != '', ' ' + lname, ''), left);
      MAC_set_phones (1, subj_phone1, R.phone10, subj_phone_name_1, name, 
                         subj_phone_type_1, R.phone_type, subj_phone_type1SwitchType, R.switch_type)
      MAC_set_phones (2, subj_phone2, R.phone10, subj_phone_name_2, name, 
                         subj_phone_type_2, R.phone_type, subj_phone_type2SwitchType, R.switch_type)
      MAC_set_phones (3, subj_phone3, R.phone10, subj_phone_name_3, name, 
                         subj_phone_type_3, R.phone_type, subj_phone_type3SwitchType, R.switch_type)
      MAC_set_phones (4, subj_phone4, R.phone10, subj_phone_name_4, name, 
                         subj_phone_type_4, R.phone_type, subj_phone_type4SwitchType, R.switch_type)
      MAC_set_phones (5, subj_phone5, R.phone10, subj_phone_name_5, name, 
                         subj_phone_type_5, R.phone_type, subj_phone_type5SwitchType, R.switch_type)
      MAC_set_phones (6, subj_phone6, R.phone10, subj_phone_name_6, name, 
                         subj_phone_type_6, R.phone_type, subj_phone_type6SwitchType, R.switch_type)
      MAC_set_phones (7, subj_phone7, R.phone10, subj_phone_name_7, name, 
                         subj_phone_type_7, R.phone_type, subj_phone_type7SwitchType, R.switch_type)
      MAC_set_phones (8, subj_phone8, R.phone10, subj_phone_name_8, name, 
                         subj_phone_type_8, R.phone_type, subj_phone_type8SwitchType, R.switch_type)
      MAC_set_phones (9, subj_phone9, R.phone10, subj_phone_name_9, name, 
                         subj_phone_type_9, R.phone_type, subj_phone_type9SwitchType, R.switch_type)
      MAC_set_phones (10, subj_phone10, R.phone10, subj_phone_name_10, name, 
                          subj_phone_type_10, R.phone_type, subj_phone_type10SwitchType, R.switch_type)
      SELF := L; // keeps addresses
    END;

    // pick up phones
    addr_phone_denormed := DENORMALIZE (addr_denormed, phone_new_nco, 
                                        (Left.customer_id = Right.customer_id) AND (Left.record_id = Right.record_id),
                                        DenormPhones (Left, Right, COUNTER)) : INDEPENDENT;

    target_dir := target_path + 'NCO/';
    // join back to raw (EITHER a) join, split and spray OR (inmlemented) b) split, join and spray)

    // action := NOTHOR (APPLY (NCO_sources, JoinAndDespray (addr_phone_denormed, target_ip, target_dir)));
    action := PARALLEL (
      JoinAndDespray (addr_phone_denormed, 'N01030', target_ip, target_dir), // N1
      JoinAndDespray (addr_phone_denormed, 'N01037', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N01059', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N01063', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'N02031', target_ip, target_dir), // N2
      JoinAndDespray (addr_phone_denormed, 'N02032', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N02034', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N02067', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N02068', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N020DE', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'N03033', target_ip, target_dir), // N3
      JoinAndDespray (addr_phone_denormed, 'N03040', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N03051', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'N04035', target_ip, target_dir), // N4

      JoinAndDespray (addr_phone_denormed, 'N06002', target_ip, target_dir), // N6
      JoinAndDespray (addr_phone_denormed, 'N06010', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N06099', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'N07003', target_ip, target_dir), // N7
      JoinAndDespray (addr_phone_denormed, 'N07016', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N07018', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N07019', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N07022', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N07064', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'N07066', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'N09023', target_ip, target_dir), // N9
      JoinAndDespray (addr_phone_denormed, 'N09061', target_ip, target_dir),

      //JoinAndDespray (addr_phone_denormed, 'P2B122', target_ip, target_dir), // OSC FACS (Ontario)
      //JoinAndDespray (addr_phone_denormed, 'P2B426', target_ip, target_dir),
      //JoinAndDespray (addr_phone_denormed, 'P2B707', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'P2B929', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'P2B969', target_ip, target_dir),
      //JoinAndDespray (addr_phone_denormed, 'P2B983', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'P3A330', target_ip, target_dir),
      //JoinAndDespray (addr_phone_denormed, 'P3A920', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'P3A923', target_ip, target_dir),
      //JoinAndDespray (addr_phone_denormed, 'P3A933', target_ip, target_dir),

      //JoinAndDespray (addr_phone_denormed, 'P3B365', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'P3B950', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'PL5938', target_ip, target_dir),

      //JoinAndDespray (addr_phone_denormed, 'RP1188', target_ip, target_dir),
      //JoinAndDespray (addr_phone_denormed, 'RP1912', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'RP1926', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'RP1980', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'U14046', target_ip, target_dir), // U14 
      JoinAndDespray (addr_phone_denormed, 'U14054', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U14055', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15007', target_ip, target_dir), // U15
      JoinAndDespray (addr_phone_denormed, 'U15009', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15011', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15015', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15027', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15072', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15080', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U15081', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'U21038', target_ip, target_dir), // U21
      JoinAndDespray (addr_phone_denormed, 'U21039', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U21041', target_ip, target_dir),

      //JoinAndDespray (addr_phone_denormed, 'U22050', target_ip, target_dir), // U22
      //JoinAndDespray (addr_phone_denormed, 'U22056', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U22700', target_ip, target_dir),

      JoinAndDespray (addr_phone_denormed, 'U40012', target_ip, target_dir), // U40
      JoinAndDespray (addr_phone_denormed, 'U40013', target_ip, target_dir),
      JoinAndDespray (addr_phone_denormed, 'U40017', target_ip, target_dir),

      OUTPUT ('done')
    ) : FAILURE (FileServices.sendemail ('vmyullyari@seisint.com', 'monitoring: despray failed: ' + thorlib.wuid (), failmessage));
    return action;
  END;
END;
