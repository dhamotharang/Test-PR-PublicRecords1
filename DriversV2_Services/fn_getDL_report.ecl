IMPORT DriversV2, doxie, Codes, Census_Data, Suppress, ut, AutoStandardI, InsuranceHeader_BestOfBest,
       DriversV2_Services, STD;

// handy abbreviations
k_seq := DriversV2.Key_DL_Seq;
KeyCodes := Codes.KeyCodes;
empty_in_seqs := DATASET([], layouts.seq);
empty_in_src := DATASET([], layouts.src);

EXPORT DATASET(DriversV2_Services.layouts.result_wide_tmp) fn_getDL_report(
  DATASET(DriversV2_Services.layouts.seq) in_seqs=empty_in_seqs,
  DATASET(DriversV2_Services.layouts.src) in_dl_src=empty_in_src,
  DriversV2_Services.GetDLParams.params gdlParams = DriversV2_Services.GetDLParams.getDefault(),
  BOOLEAN IsBatch = FALSE
) := FUNCTION
  
  use_NonDMVSources := DriversV2_Services.input.incNonDMV AND ~doxie.DataRestriction.CY;
  
  // join inputs to index to get raw data
  dl_raw_seq := JOIN(in_seqs, k_seq,
    KEYED(LEFT.dl_seq = RIGHT.dl_seq)
    AND (use_NonDMVSources OR (RIGHT.source_code NOT IN DriversV2.Constants.nonDMVSources)),
    LIMIT(0), KEEP (1) //M:1 join
  );

  dl_raw := IF(IsBatch, in_dl_src, dl_raw_seq + in_dl_src);

  penaltyAddr(STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
              STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
              STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = '') := FUNCTION
    tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
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

  penaltyDID(STRING didFld) := FUNCTION
    tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_DID.full, OPT))
      EXPORT did_field := didFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tm);
  END;

  penaltyDOB(STRING dobFld) := FUNCTION
    tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_DOB.full, OPT))
      EXPORT dob_field := dobFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_DOB.val(tm);
  END;

  penaltyName(STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := FUNCTION
    tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
      EXPORT fname_field := fnameFld;
      EXPORT mname_field := mnameFld;
      EXPORT lname_field := lnameFld;
      EXPORT allow_wildcard := allowWld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
  END;

  penaltySSN(STRING ssnFld) := FUNCTION
    tm := MODULE(PROJECT(gdlParams, AutoStandardI.LIBIN.PenaltyI_SSN.full, OPT))
      EXPORT ssn_field := ssnFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(tm);
  END;

  penaltyDLState(STRING2 dlState) := FUNCTION
    RETURN MAP(dlState = '' => 0,
               gdlParams.dlState = '' => 0,
               dlState = gdlParams.dlState => 0,
               10);
  END;

  // add computed fields
  DriversV2_Services.layouts.result_wide_tmp addValue(dl_raw L) := TRANSFORM
  
    // NOTE: It would be really nice to use doxie.FN_Tra_Penalty() here,
    // but that's tricky because we don't have a field for phone
    // in the input data. When we switch to the use of interfaces,
    // we should ensure that a consolidated penalty computation
    // routine allows us to effectively disable certain sections.
    tot_penalt :=
      penaltyAddr(
        L.predir, L.prim_range, L.prim_name, L.suffix, L.postdir, L.sec_range,
        L.v_city_name, L.st, L.zip5, , L.p_city_name) +
      penaltyDID( (STRING)L.did ) +
      penaltyDOB( (STRING)L.dob ) +
      penaltyName(L.fname, L.mname, L.lname) +
      penaltySSN(L.ssn) +
      penaltyDLState(L.orig_state);
    
    SELF.penalt := IF(input.randomize, 0, tot_penalt);
      
    SELF.nonDMVSource := IF(L.source_code in DriversV2.Constants.nonDMVSources, 'Y', 'N');
    
    SELF.age_today := ut.Age(L.dob);
    SELF.dead_age := IF((UNSIGNED4)L.dod=0,0,((UNSIGNED4)L.dod-L.dob) div 10000);
    SELF.county_name := ''; // we'll fill this in later
    
    SELF.race_name := MAP(
      L.race = 'W' => 'WHITE',
      L.race = 'B' => 'BLACK',
      L.race = 'H' => 'HISPANIC',
      L.race = 'A' => 'ASIAN',
      L.race = 'I' => 'NATIVE AMERICAN',
      L.race = 'O' => 'OTHER',
      L.race
    );
    
    SELF.sex_name := KeyCodes('GENERAL', 'GENDER', , L.sex_flag, TRUE);
    SELF.orig_state_name := KeyCodes('GENERAL', 'STATE_LONG', , L.orig_state, TRUE);
    
    SELF.history_name := KeyCodes('DRIVERS_LICENSE', 'HISTORY', , L.history, TRUE);
    SELF.eye_color_name := KeyCodes('DRIVERS_LICENSE', 'EYE_COLOR', L.orig_state, L.eye_color, TRUE);
    SELF.hair_color_name := KeyCodes('DRIVERS_LICENSE', 'HAIR_COLOR', L.orig_state, L.hair_color, TRUE);
    SELF.attention_name := KeyCodes('DRIVERS_LICENSE', 'ATTENTION_FLAG', L.orig_state, L.attention_flag, TRUE);
    
    SELF.license_type_name := KeyCodes('DRIVERS_LICENSE2', 'LICENSE_TYPE', L.orig_state, L.license_type, TRUE);
    SELF.license_class_name := KeyCodes('DRIVERS_LICENSE2', 'LICENSE_CLASS', L.orig_state, L.license_class, TRUE);
    SELF.status_name := KeyCodes('DRIVERS_LICENSE2', 'STATUS', L.orig_state, L.status, TRUE);
    SELF.cdl_status_name := KeyCodes('DRIVERS_LICENSE2', 'CDL_STATUS', L.orig_state, L.cdl_status, TRUE);
    
    STRING15 restrict_delim(UNSIGNED1 idx) := STRINGlib.STRINGextract(L.restrictions_delimited, idx);
    SELF.restriction1 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(1), TRUE);
    SELF.restriction2 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(2), TRUE);
    SELF.restriction3 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(3), TRUE);
    SELF.restriction4 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(4), TRUE);
    SELF.restriction5 := KeyCodes('DRIVERS_LICENSE', 'RESTRICTIONS', L.orig_state, restrict_delim(5), TRUE);
    
    STRING15 endorse_delim(UNSIGNED1 idx) := L.lic_endorsement[idx];
    SELF.endorsement1 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(1), TRUE);
    SELF.endorsement2 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(2), TRUE);
    SELF.endorsement3 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(3), TRUE);
    SELF.endorsement4 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(4), TRUE);
    SELF.endorsement5 := KeyCodes('DRIVERS_LICENSE', 'LIC_ENDORSEMENT', L.orig_state, endorse_delim(5), TRUE);
    
    // clobber 0's in height/weight
    SELF.height := IF( (UNSIGNED)L.height=0, '', L.height );
    SELF.weight := IF( (UNSIGNED)L.weight=0, '', L.weight );

    // inline DL-masking
    SELF.oos_previous_dl_number := IF (input.dl_mask AND L.oos_previous_dl_number != '', suppress.dl_mask (L.oos_previous_dl_number), L.oos_previous_dl_number);
    SELF.old_dl_number := IF (input.dl_mask AND L.old_dl_number != '', suppress.dl_mask (L.old_dl_number), L.old_dl_number);
    SELF := L;
  END;
  dl_val := PROJECT(dl_raw, addValue(LEFT));
  
  // sort & dedup
  dmv := dl_val(source_code NOT in DriversV2.Constants.nonDMVSources);
  non_dmv := dl_val(source_code in DriversV2.Constants.nonDMVSources);
  dl_sd := DEDUP( SORT( dmv, penalt, -lic_issue_date, -expiration_date, RECORD ) ) &
           SORT(non_dmv, penalt, -dt_last_seen, RECORD);
  
  //Get Insurance Header DL data if needed
  ins_dl_ok := AutoStandardI.DataPermissionI.val(gdlParams).use_InsuranceDLData;
  in_ins_dl := GROUP(SORT(DEDUP(SORT(PROJECT(dl_sd,
    TRANSFORM(InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input,
      SELF.Seq := COUNTER; //not used in search_Insurance_DL_by_DL
      SELF.DID := LEFT.did;
      SELF.FirstName := LEFT.fname;
      SELF.LastName := LEFT.lname;
      SELF.DateofBirth := (STRING)LEFT.dob;
      SELF.DL_Number := LEFT.dl_number;
      SELF.DL_St := LEFT.orig_state;
      SELF.DL_Data_Used := FALSE; //set in search_Insurance_DL_by_DL
    )),
    did, dl_number), did, dl_number), seq),seq);
  
  out_ins_dl := InsuranceHeader_BestOfBest.search_Insurance_DL_by_DL(in_ins_dl, DriversV2_Services.input.dppa_purpose, /*isFCRA := */FALSE, gdlParams.datapermissionmask);
  dup_ins_dl := DEDUP(SORT(out_ins_dl, did, -dt_last_seen), did)(ut.DaysApart((STRING)dt_last_seen, (STRING) STD.Date.Today()) <= DriversV2_Services.Constants.INS_MAX_DAYS_SINCE_DT_LAST_SEEN);
  ins_dl_ds := PROJECT(dup_ins_dl,
    TRANSFORM(DriversV2_Services.layouts.result_wide_tmp,
      SELF.did := LEFT.did,
      SELF.dl_number := LEFT.dl_nbr,
      SELF.orig_state := LEFT.dl_state,
      SELF.dt_first_seen := LEFT.dt_first_seen,
      SELF.dt_last_seen := LEFT.dt_last_seen,
      SELF.source_code := LEFT.src,
      SELF.title := LEFT.title,
      SELF.fname := LEFT.fname,
      SELF.mname := LEFT.mname,
      SELF.lname := LEFT.lname,
      SELF.name_suffix := LEFT.sname,
      SELF.dob := LEFT.dob,
      SELF := []));
  
  w_ins_dl := dl_sd & IF(ins_dl_ok AND gdlParams.IncludeInsuranceDrivers, ins_dl_ds);
    
  // fill in the county_name
  Census_Data.MAC_Fips2County_Keyed(w_ins_dl, st, county, county_name, dl_county);
  
  // suppress/mask sensitive data
  ssn_mask_value := IF (gdlParams.skipSSNMasking, '',DriversV2_Services.input.ssn_mask);
  dl_mask_value := IF (gdlParams.skipDLMasking, FALSE, DriversV2_Services.input.dl_mask);
  suppressinput := IF(IsBatch, dl_sd, dl_county);
  
  Suppress.MAC_Suppress(suppressinput,pull_tmp,gdlParams.applicationType,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(pull_tmp,dl_pulled,gdlParams.applicationType,Suppress.Constants.LinkTypes.SSN,ssn);
  
  dl_glb := dl_pulled(ut.PermissionTools.GLB.minorOK(age_today));
  dl_dppa := dl_glb(ut.PermissionTools.dppa.state_ok(orig_state,DriversV2_Services.input.dppa_purpose,,source_code));
  
  Suppress.MAC_Mask(dl_dppa, dl_masked, ssn, dl_number, TRUE, TRUE);

  RETURN dl_masked;
  
END;
