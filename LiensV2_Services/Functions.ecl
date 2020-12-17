IMPORT BatchServices, AutoStandardI, D2C, FCRA, FFD, NID, STD;

EXPORT Functions := MODULE
  
  SHARED tmp_penalt_layout := RECORD
    UNSIGNED2 penalt;
  END;
  
  SHARED tmp_int_layout := RECORD
    UNSIGNED2 val := 0;
  END;
  
  SHARED default_penalty := 20;
  
  EXPORT isRestricted(BOOLEAN is_cnsmr, STRING tmsid) := is_cnsmr AND D2C.Constants.LiensRestrictedSources(tmsid);

  penalt_addr(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l,
              DATASET(liensv2_services.layout_lien_party_address) r) := FUNCTION
 
    ds_out_addr_penalt := PROJECT(r, TRANSFORM(tmp_penalt_layout,
                addresses_to_compare :=
      MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
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
        EXPORT allow_wildcard := FALSE;
        EXPORT city_field := LEFT.v_city_name;
        EXPORT city2_field := '';
        EXPORT pname_field := LEFT.prim_name;
        EXPORT postdir_field := LEFT.postdir;
        EXPORT prange_field := LEFT.prim_range;
        EXPORT predir_field := LEFT.predir;
        EXPORT state_field := LEFT.st;
        EXPORT suffix_field := LEFT.addr_suffix;
        EXPORT zip_field := LEFT.zip;
        EXPORT sec_range_field := LEFT.sec_range;
        EXPORT useGlobalScope := FALSE;
      END;
      highPenalt := IF (LEFT.v_city_name = '' AND LEFT.st= '' AND LEFT.zip='', default_penalty, 0);
      // NOTE : this is calling a new penalization routine
      // in so much as the input values (left side i.e. non
      // candidate records) are not being obtained via
      // interface translator (IT) They are being obtained directly
      // from the passed in input values. This was done
      // as a fix for bug RR 103650 to fix batch timeouts
      // specifically and only for Judgements and liens batch service.
      // the main reason is that by by passing the IT calls
      // the address cleaner is called less thus causing
      // larger return sets for particular inputs of batch
      // to process successfully instead of timing out.
      SELF.penalt := MAX(AutoStandardI.LIBCALL_PenaltyI_AddrNEW.val(addresses_to_compare), highPenalt);
      ));
    RETURN MIN(ds_out_addr_penalt, penalt);
  END;
        
  penalt_ind_name(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l,
                  DATASET(liensv2_services.layout_lien_party_parsed) r) := FUNCTION
                                  // project necessary cause of multiple layers in addresses and
                                  // parsed parties.
    ds_out_indname_penalt := PROJECT(r, TRANSFORM(tmp_penalt_layout,
      tempindvmod :=
        MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
          EXPORT lastname := l.name_last; // the 'input' last name
          EXPORT middlename := l.name_middle; // the 'input' middle name
          EXPORT firstname := l.name_first; // the 'input' first name
          EXPORT allow_wildcard := FALSE;
          EXPORT lname_field := LEFT.lname; // matching RECORD.
          EXPORT mname_field := LEFT.mname;
          EXPORT fname_field := LEFT.fname;
          EXPORT useGlobalScope := FALSE;
        END;
      high_ind_penalt := IF (LEFT.lname = '' AND LEFT.fname ='', default_penalty, 0); // to catch blank fields IN rec going against
                                                       // so it doesn't skew the min for that particular row.
      SELF.penalt := MAX(AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod), high_ind_penalt);
      ));
    RETURN MIN(ds_out_indname_penalt, penalt);
  END;
  
  penalt_buz_cname(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l,
                   DATASET(liensv2_services.layout_lien_party_parsed) r) := FUNCTION
    ds_out_buzname_penalt := PROJECT(r, TRANSFORM(tmp_penalt_layout,
      tempbizmod :=
        MODULE(PROJECT(AutoStandardI.GlobalModule(),
          AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,OPT))
            EXPORT allow_wildcard := FALSE;
            EXPORT useGlobalScope := FALSE;
            EXPORT companyname := l.comp_name; // the 'input' company name
            EXPORT cname_field := LEFT.cname; // matching RECORD.
          END;
          // so it doesn't skew the min for that particular row so set to a high value.
        high_biz_penalt := IF (LEFT.cname = '', default_penalty, 0);
        
        SELF.penalt := MAX(AutoStandardI.LIBCALL_PenaltyI_Biz_name.val(tempBizMod), high_biz_penalt);
        ));
     RETURN MIN(ds_out_buzname_penalt, penalt);
  END;
  
  EXPORT tmp_penalt_layout penalt_func_calculate(LiensV2_Services.Batch_Layouts.autokey_batch_tmsid l,
                                                 DATASET(liensv2_services.layout_lien_party) r ) := FUNCTION
    out_ds := PROJECT(r, TRANSFORM(tmp_penalt_layout,
      tmp_addr := IF (EXISTS(LEFT.addresses), penalt_addr(l, LEFT.addresses), default_penalty);
      tmp_ind_name := IF (EXISTS(LEFT.parsed_parties), penalt_ind_name(l, LEFT.parsed_parties), default_penalty);
      tmp_buz_cname := IF (EXISTS(LEFT.parsed_parties), penalt_buz_cname(l, LEFT.parsed_parties), default_penalty);
      SELF.penalt := (UNSIGNED2) MIN( tmp_buz_cname,tmp_ind_name) + tmp_addr;
    ));
    RETURN out_ds;
    // represents just one row penalty.
  END;
  
  //name
  BOOLEAN fn_match_name( DATASET (liensv2_services.layout_lien_party) LE,
                         LiensV2_Services.Batch_Layouts.batch_in R) := FUNCTION
                                  
    tmp_int_layout x_name( liensv2_services.layout_lien_party_parsed ind_party,
                           LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF (((ind_party.fname = R.name_first AND ind_party.fname <> '') OR (NID.mod_PFirstTools.PFLeqPFR(ind_party.fname, R.name_first) AND ind_party.fname <> '')) AND
                                     (ind_party.lname = R.name_last AND ind_party.lname <> ''), 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.parsed_parties, x_name(LEFT,R)), val) = 1;
    RETURN (ret_val);
  END;
  
  // ssn
  BOOLEAN fn_match_ssn( DATASET (liensv2_services.layout_lien_party) LE,
                        LiensV2_Services.Batch_Layouts.batch_in R) := FUNCTION
                                  
    tmp_int_layout x_ssn( liensv2_services.layout_lien_party_parsed L,
                          LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF ((L.ssn = STD.STR.FilterOut(R.ssn, '-') AND L.ssn <> ''), 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.parsed_parties, x_ssn(LEFT,R)), val) = 1;
    RETURN (ret_val);
  END;
  
  // DID
  BOOLEAN fn_match_did( DATASET (liensv2_services.layout_lien_party) LE,
                        LiensV2_Services.Batch_Layouts.batch_in RI) := FUNCTION
                                  
    tmp_int_layout loop_did( liensv2_services.layout_lien_party_parsed L,
                             LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF ((UNSIGNED6) L.did = R.did AND L.did <> '', 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.parsed_parties, loop_did(LEFT,RI)), val) = 1;
    RETURN (ret_val);
  END;
  
  // street address
  BOOLEAN fn_match_streetAddress ( DATASET (liensv2_services.layout_lien_party) LE,
                                   LiensV2_Services.Batch_Layouts.batch_in RI) := FUNCTION
    tmp_int_layout xform_streetAddr(liensv2_services.layout_lien_party_address L,
                                    LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF (L.prim_name = R.prim_name AND L.prim_range = R.prim_range AND
                      L.predir = R.predir AND L.postdir = R.postdir AND
                      L.addr_suffix = R.addr_suffix AND (l.prim_name <> '' AND L.prim_range <> '')
                      , 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.addresses, xform_streetAddr(LEFT,RI)), val) = 1;
    RETURN (ret_val);
  END;

  // city
  BOOLEAN fn_match_city( DATASET (liensv2_services.layout_lien_party) LE,
                         LiensV2_Services.Batch_Layouts.batch_in RI) := FUNCTION
                                
    tmp_int_layout loop_city( liensv2_services.layout_lien_party_address L,
                              LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF (L.p_city_name = R.p_city_name AND L.p_city_name <> '', 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.addresses, loop_city(LEFT,RI)), val) = 1;
    RETURN (ret_val);
  END;
  
  // state
  BOOLEAN fn_match_state( DATASET (liensv2_services.layout_lien_party) LE,
                          LiensV2_Services.Batch_Layouts.batch_in RI) := FUNCTION
                              
    tmp_int_layout loop_state( liensv2_services.layout_lien_party_address L,
                               LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF ( L.st = R.st AND L.st <> '', 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.addresses, loop_state(LEFT,RI)), val) = 1;
    RETURN (ret_val);
  END;
  
  // zip5
  BOOLEAN fn_match_zip( DATASET (liensv2_services.layout_lien_party) LE,
                         LiensV2_Services.Batch_Layouts.batch_in RI) := FUNCTION
                                
    tmp_int_layout loop_zip( liensv2_services.layout_lien_party_address L,
                            LiensV2_Services.Batch_Layouts.batch_in R) := TRANSFORM
      SELF.val := IF ( L.zip = R.z5 AND L.zip <> '', 1, 2);
    END;
    BOOLEAN ret_val := MIN(PROJECT(LE.addresses, loop_zip(LEFT,RI)), val) = 1;
    RETURN (ret_val);
  END;
  
  //Add matchcodes
  EXPORT fn_addMatchcodes(DATASET(liensv2_services.layout_lien_rollup) in_rec,
                          DATASET(LiensV2_Services.Batch_Layouts.batch_in) batch_in,
                          LiensV2_Services.IParam.batch_params configData) := FUNCTION

    match_debtor := 'D' IN configData.party_types;
    match_creditor := 'C' IN configData.party_types;
    match_attorney := 'A' IN configData.party_types;

    LiensV2_Services.Batch_Layouts.int_layout_match_bool add_matchcodeValues(in_rec L,
                                                                             batch_in R) := TRANSFORM
      // fn_match* are called in order to match anything deeper in possible child datasets.
      tmp_match_nameD := IF (match_debtor, fn_match_name(L.debtors, R), FALSE);
      tmp_match_nameC := IF (match_creditor, fn_match_name(L.creditors, R), FALSE);
      tmp_match_nameA := IF (match_attorney, fn_match_name(L.attorneys, R), FALSE);
      tmp_match_name := tmp_match_nameD OR tmp_match_nameC OR tmp_match_nameA;
      SELF.match_name := tmp_match_name;

      tmp_match_street_addressD := IF (match_debtor, fn_match_streetaddress(L.debtors, R), FALSE);
      tmp_match_street_addressC := IF (match_creditor, fn_match_streetaddress(L.creditors, R), FALSE);
      tmp_match_street_addressA := IF (match_attorney, fn_match_streetaddress(L.attorneys, R), FALSE);
      tmp_match_street_address := tmp_match_street_addressD OR tmp_match_street_addressC OR tmp_match_street_addressA;
      SELF.match_street_address := tmp_match_street_address;

      tmp_match_cityD := IF (match_debtor, fn_match_city(L.debtors, R), FALSE);
      tmp_match_cityC := IF (match_creditor, fn_match_city(L.creditors, R), FALSE);
      tmp_match_cityA := IF (match_attorney, fn_match_city(L.attorneys, R), FALSE);
      tmp_match_city := tmp_match_cityD OR tmp_match_cityC OR tmp_match_cityA;
      SELF.match_city := tmp_match_city;

      tmp_match_stateD := IF (match_debtor, fn_match_state(L.debtors, R), FALSE);
      tmp_match_stateC := IF (match_creditor, fn_match_state(L.creditors, R), FALSE);
      tmp_match_stateA := IF (match_attorney, fn_match_state(L.attorneys, R), FALSE);
      tmp_match_state := tmp_match_stateD OR tmp_match_stateC OR tmp_match_stateA;
      SELF.match_state := tmp_match_state;

      tmp_match_zipD := IF (match_debtor, fn_match_zip(L.debtors, R), FALSE);
      tmp_match_zipC := IF (match_creditor, fn_match_zip(L.creditors, R), FALSE);
      tmp_match_zipA := IF (match_attorney, fn_match_zip(L.attorneys, R), FALSE);
      tmp_match_zip := tmp_match_zipD OR tmp_match_zipC OR tmp_match_zipA;
      SELF.match_zip := tmp_match_zip;

      tmp_match_ssnD := IF (match_debtor, fn_match_ssn(L.debtors, R), FALSE);
      tmp_match_ssnC := IF (match_creditor, fn_match_ssn(L.creditors, R), FALSE);
      tmp_match_ssnA := IF (match_attorney, fn_match_ssn(L.attorneys, R), FALSE);
      tmp_match_ssn := tmp_match_ssnD OR tmp_match_ssnC OR tmp_match_ssnA;
      SELF.match_ssn := tmp_match_ssn;

      //adding DID match
      // tmp_match_didD := if ('D' in configData.party_types, fn_match_did(L.debtors, R), true);
      // tmp_match_didC := if ('C' in configData.party_types, fn_match_did(L.creditors, R), true);
      // tmp_match_didA := if ('A' in configData.party_types, fn_match_did(L.attorneys, R), true);
      // tmp_match_did := tmp_match_didD OR tmp_match_didC OR tmp_match_didA;
      // SELF.match_did := tmp_match_did;

      SELF.match_dob := TRUE; // SET here cause no DOB data IN J & L OUTPUT.

      SELF.acctno := L.acctno; // sets acctno
      nameV := ((~(configData.MatchName)) OR (tmp_match_name));
      streetV := ((~(configData.MatchStrAddr)) OR (tmp_match_street_address));
      cityV := ((~(configData.MatchCity)) OR (tmp_match_city));
      stateV := ((~(configData.MatchState)) OR (tmp_match_state));
      zipV := ((~(configData.MatchZip)) OR (tmp_match_zip));
      ssnV := ((~(configData.MatchSSN)) OR (tmp_match_ssn));

      SELF.matches := nameV AND streetV AND cityV AND StateV AND zipV AND ssnV;
      SELF.matchcodes := BatchServices.Functions.match_code_result(tmp_match_name, tmp_match_street_address,
                                                                   tmp_match_city, tmp_match_state,tmp_match_zip,
                                                                   // tmp_match_ssn, FALSE,tmp_match_did);
                                                                   tmp_match_ssn, FALSE,FALSE);
      SELF := L;

      SELF := [];
    END;

    out_rec := JOIN(in_rec, batch_in,
                    LEFT.acctno = RIGHT.acctno,
                    add_matchcodeValues(LEFT, RIGHT));
    RETURN out_rec;
  END;
  
  EXPORT fn_applyBatchFcraOverrides(DATASET(LiensV2_Services.layout_lien_rollup) raw_rec,
                                    DATASET(LiensV2_Services.Batch_Layouts.layout_batchids) batch_in,
                                    DATASET(fcra.Layout_override_flag) flagfile,
                                    STRING in_ssn_mask_value = '',
                                    DATASET(FFD.Layouts.PersonContextBatchSlim) dsSlimPC = DATASET([],FFD.Layouts.PersonContextBatchSlim),
                                    INTEGER8 inFFDOptionsMask = 0) := FUNCTION
    
    // Get overrides records:
    ds_flags := flagfile(file_id = FCRA.FILE_ID.LIEN);
    liens_correct_tmsid_record_id := SET (ds_flags, record_id[1..50]); //there is no rmsid
    liens_correct_record_id := SET (ds_flags, record_id);

    // Get only "good" records (filtered out by both main- and party- override ids:
    LiensV2_Services.layout_lien_rollup xformCleanRecs(LiensV2_Services.Batch_Layouts.layout_batchids L, LiensV2_Services.layout_lien_rollup R)
      := TRANSFORM,
         SKIP(R.tmsid IN SET(ds_flags((UNSIGNED6)did = L.did), record_id[1..50]) // old way of filtering records prior to 11/13/2012
              OR (STRING)R.persistent_record_id IN SET(ds_flags((UNSIGNED6)did = L.did), record_id)
              OR EXISTS(R.debtors((STRING)persistent_record_id IN SET(ds_flags((UNSIGNED6)did = L.did), record_id)))
              OR EXISTS(R.creditors((STRING)persistent_record_id IN SET(ds_flags((UNSIGNED6)did = L.did), record_id)))
              OR EXISTS(R.attorneys((STRING)persistent_record_id IN SET(ds_flags((UNSIGNED6)did = L.did), record_id)))
              OR EXISTS(R.thds((STRING)persistent_record_id IN SET(ds_flags((UNSIGNED6)did = L.did), record_id)))
              OR EXISTS(R.filings((STRING)persistent_record_id IN SET(ds_flags((UNSIGNED6)did = L.did), record_id)))) // new way, using the persistent_record_id
      SELF := R;
    END;
    ds_clean := JOIN(batch_in, raw_rec,
                     LEFT.acctno = RIGHT.acctno
                     AND LEFT.tmsid = RIGHT.tmsid,
                     xformCleanRecs(LEFT, RIGHT));
                          
    //get corrections (both for main- and search- files)
    ds_party_overrides := JOIN(ds_flags, FCRA.key_Override_liensv2_party_ffid,
                              KEYED(LEFT.flag_file_id = RIGHT.flag_file_id),
                              TRANSFORM(liensv2_services.layout_lien_party_raw,SELF:=RIGHT,SELF:=[]),
                              KEEP(1));
    ds_party_corrections := GROUP (SORT (ds_party_overrides, acctno), acctno);
                            
    ds_main_overrides := JOIN(ds_flags, FCRA.key_Override_liensv2_main_ffid,
                              KEYED(LEFT.flag_file_id = RIGHT.flag_file_id),
                              TRANSFORM(RIGHT),
                              KEEP(1));
                            
    liensv2_services.layout_liens_case_extended GetCase (ds_main_overrides r) := TRANSFORM
      SELF.filing_status := CHOOSEN(r.filing_status,10);
      SELF.filing_jurisdiction_name := LiensV2_Services.fn_get_filing_jurisdiction_name(r.filing_jurisdiction);
      SELF := r;
      SELF := [];
    END;
    ds_case_corrections := PROJECT (ds_main_overrides, GetCase (LEFT));

    liensv2_services.layout_liens_history_extended GetHistory (ds_main_overrides r) := TRANSFORM
      SELF.filings := DATASET ([{r.filing_number, r.filing_type_desc, r.orig_filing_date, r.filing_date, r.filing_time,
                                 r.filing_book, r.filing_page, r.agency, r.agency_state, r.agency_city,
                                 r.agency_county, r.persistent_record_id, DATASET([], FFD.Layouts.StatementIdRec), FALSE, r.bcbflag}],
                               liensv2_services.layout_lien_history_w_bcb);
      SELF.tmsid := r.tmsid;
      SELF.acctno := '';
    END;
    ds_history_corrections_pre := PROJECT (ds_main_overrides, GetHistory (LEFT));
    ds_history_corrections := JOIN(ds_history_corrections_pre,batch_in,
                                    LEFT.tmsid = RIGHT.tmsid ,
                                    TRANSFORM(liensv2_services.layout_liens_history_extended,
                                              SELF.acctno := RIGHT.acctno, SELF := LEFT),
                                    LEFT OUTER);
    

    // Run through amelioration process (fcra-neutral)
    ds_correct := LiensV2_Services.GetCRSOutput (ds_party_corrections, ds_case_corrections,
                                                 ds_history_corrections, in_ssn_mask_value, TRUE,
                                                  '',FALSE,FALSE,dsSlimPC,inFFDOptionsMask);
    //join to get acctno for ds_correct
    ds_correct_plus_acctno := JOIN(ds_correct, batch_in,
                                   LEFT.tmsid = RIGHT.tmsid,
                                   TRANSFORM(LiensV2_Services.layout_lien_rollup,
                                             SELF.acctno := RIGHT.acctno,
                                             SELF := LEFT));
    
    // add user's (override) records
    ds_correct_final := JOIN(ds_correct_plus_acctno, ds_clean,
                             LEFT.acctno = RIGHT.acctno AND
                             LEFT.tmsid = RIGHT.tmsid,
                             TRANSFORM(LEFT),
                             LEFT only); //to make sure that IF there are two records that share a tmsid only the ones that has overrides based on the DID gets the override records
    ds_final := ds_clean + ds_correct_final;

  RETURN ds_final (FCRA.lien_is_ok ((STRING)STD.Date.Today(), orig_filing_date)); //filter by fcra-date criteria
    
  END;
  EXPORT STRING fn_DisplayAddress1( DATASET(liensv2_services.layout_lien_party_address) address) :=
  FUNCTION
    RETURN TRIM(address[1].prim_range) + ' '
         + TRIM(address[1].predir) + ' '
         + TRIM(address[1].prim_name) + ' '
         + TRIM(address[1].addr_suffix) + ' '
         + TRIM(address[1].postdir);
  END;

EXPORT STRING fn_DisplayAddress2( DATASET(liensv2_services.layout_lien_party_address) address) :=
  FUNCTION
    RETURN TRIM(address[1].unit_desig) + ' ' + TRIM(address[1].sec_range);
  END;
  
EXPORT STRING fn_FormatSSN(STRING9 ssn) :=
  FUNCTION
    unformattedSSN := IF( LENGTH(TRIM(ssn)) = 4,
                          '00000' + ssn,
                          ssn
                        );
    formattedSSN := unformattedSSN[1..3] + '-' + unformattedSSN[4..5] + '-' + unformattedSSN[6..9];
    
    RETURN IF( LENGTH(TRIM(ssn)) = 0, '', formattedSSN );
  END;
  
END;
