IMPORT Autokey_batch, AutokeyB2, BatchServices, Criminal_Records, doxie_files, doxie, FCRA;

EXPORT batchIds := MODULE

  EXPORT PII_Ids(CriminalRecords_BatchService.IParam.batch_params configData) := MODULE
    SHARED acct_pii_rec := CriminalRecords_BatchService.Layouts.lookup_id_pii;

    SHARED trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);
    strEql(STRING str1, STRING str2, BOOLEAN noBlnk = TRUE) := IF(noBlnk, str1 = str2 AND LENGTH(str1) > 0,
                                                                          IF(LENGTH(str1) = 0, TRUE, str1 = str2));
    SHARED strEqlTrim(STRING str1, STRING str2, BOOLEAN noBlnk = TRUE) := strEql(trimBoth(str1), trimBoth(str2), noBlnk);
    SHARED getMatchVal(BOOLEAN isMatch, UNSIGNED1 matchVal) := IF(isMatch, matchVal, 0);
    SHARED internalMatchVal := Constants.V_MATCH_INTERNAL;
    SHARED nameMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_NAME);
    SHARED addrMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_ADDR);
    SHARED cityMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_CITY);
    SHARED stateMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_STATE);
    SHARED zipMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_ZIP);
    SHARED ssnMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_SSN);
    SHARED dobMatchVal(BOOLEAN isMatch) := getMatchVal(isMatch, Constants.V_MATCH_DOB);
    
    SHARED UNSIGNED1 thresholdVal := Constants.V_MATCH_INTERNAL +
                                      IF(configData.MatchName, Constants.V_MATCH_NAME, 0) +
                                      IF(configData.MatchStrAddr, Constants.V_MATCH_ADDR, 0) +
                                      IF(configData.MatchCity, Constants.V_MATCH_CITY, 0) +
                                      IF(configData.MatchState, Constants.V_MATCH_STATE, 0) +
                                      IF(configData.MatchZip, Constants.V_MATCH_ZIP, 0) +
                                      IF(configData.MatchSSN, Constants.V_MATCH_SSN, 0) +
                                      IF(configData.MatchDOB, Constants.V_MATCH_DOB, 0);
    EXPORT AutoKeyIds(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) := FUNCTION
      
      // 1. Define values for obtaining autokeys and payloads.
      ak_keyname := Criminal_Records.Constants('').ak_QAname;
      ak_dataset := Criminal_Records.Constants('').ak_dataset;
      ak_typestr := Criminal_Records.Constants('').ak_typeStr;
      
      // 2. Configure the autokey search
      ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
        EXPORT skip_set := auto_skip + Criminal_Records.Constants('').skip_set;
        EXPORT useAllLookups := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
      END;
    
      // 3. Get autokey 'fake' ids (fids) based on batch input.
      ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
      
      // 4. Get seisint_primary_key via autokey payload (outpl).
      AutokeyB2.mac_get_payload( ds_fids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr );
          
      // 5. Slim the autokey payload (outpl) to just what's needed for matching.
      acct_pii_rec fromBatchInputAndPayload(ds_batch_in l, outpl r) := TRANSFORM
        BOOLEAN nameMatch := strEqlTrim(l.name_last, r.lname) AND strEqlTrim(l.name_first, r.fname);
        BOOLEAN addrMatch := strEqlTrim(l.prim_name, r.prim_name) AND strEqlTrim(l.prim_range, r.prim_range) AND strEqlTrim(l.sec_range, r.sec_range, FALSE);
        BOOLEAN cityMatch := strEqlTrim(l.p_city_name, r.v_city_name);
        BOOLEAN stateMatch := strEqlTrim(l.st, r.state);
        BOOLEAN zipMatch := strEqlTrim(l.z5, r.zip5);
        BOOLEAN ssnMatch := strEqlTrim(l.ssn, r.ssn);
        BOOLEAN dobMatch := strEqlTrim(l.dob, r.dob);
        SELF.matchResult := nameMatchVal(nameMatch) + addrMatchVal(addrMatch) + cityMatchVal(cityMatch) + stateMatchVal(stateMatch) +
                            zipMatchVal(zipMatch) + ssnMatchVal(ssnMatch) + dobMatchVal(dobMatch) + internalMatchVal;
        SELF := r;
      END;
      ds_outpl_slim := JOIN(ds_batch_in, outpl, LEFT.acctno = RIGHT.acctno, fromBatchInputAndPayload(LEFT, RIGHT));
      ds_outpl_filt := ds_outpl_slim((matchResult & thresholdVal) = thresholdVal);
        
      // ... Then sort and dedup.
      ds_ids_by_ak := DEDUP(SORT(ds_outpl_filt,acctno,did, offender_key),
                            acctno,did, offender_key);
      RETURN ds_ids_by_ak;
    END;
  
    EXPORT IdsPIIByDID(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
                       BOOLEAN isFCRA = FALSE,
                       DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := FUNCTION
      ds_flags := flagfile(file_id = FCRA.FILE_ID.OFFENDERS);
      correct_ofk := SET (ds_flags, record_id);
      // Key
      key_offenders := doxie_files.Key_Offenders(isFCRA);
      key_header := doxie.Key_Header;
    
      //Deep dive if necessary
      ds_did_acctno := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in);
      deep_dids := JOIN(ds_batch_in, ds_did_acctno,
        LEFT.acctno = RIGHT.acctno,
        TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
          SELF.did := RIGHT.did,
          SELF := LEFT),
        LEFT OUTER);
      
      acct_pii_rec fromPLAndHeader(ds_batch_in l, key_header r) := TRANSFORM
        BOOLEAN nameMatch := strEqlTrim(l.name_last, r.lname) AND strEqlTrim(l.name_first, r.fname);
        BOOLEAN addrMatch := strEqlTrim(l.prim_name, r.prim_name) AND strEqlTrim(l.prim_range, r.prim_range) AND strEqlTrim(l.sec_range, r.sec_range, FALSE);
        BOOLEAN cityMatch := strEqlTrim(l.p_city_name, r.city_name);
        BOOLEAN stateMatch := strEqlTrim(l.st, r.st);
        BOOLEAN zipMatch := strEqlTrim(l.z5, r.zip);
        BOOLEAN ssnMatch := r.valid_SSN = 'G' AND strEqlTrim(l.ssn, r.ssn);
        BOOLEAN dobMatch := r.jflag1 = 'C' AND strEqlTrim(l.dob, (STRING8)IF(r.dob > 0, INTFORMAT(r.dob, 8, 1), Constants.BLNK));
        SELF.matchResult := nameMatchVal(nameMatch) + addrMatchVal(addrMatch) + cityMatchVal(cityMatch) + stateMatchVal(stateMatch) +
                               zipMatchVal(zipMatch) + ssnMatchVal(ssnMatch) + dobMatchVal(dobMatch) + internalMatchVal;
        SELF := l;
        SELF.offender_key := '';
      END;
      deep_didscheck := JOIN(deep_dids, key_header,
                          KEYED(LEFT.did = RIGHT.s_did) AND
                          ~Doxie.DataRestriction.isHeaderSourceRestricted(RIGHT.src),
                        fromPLAndHeader(LEFT, RIGHT));
      deep_dids_final := ROLLUP(SORT(deep_didscheck, acctno, did),
                          LEFT.acctno = RIGHT.acctno AND LEFT.did = RIGHT.did,
                          TRANSFORM(acct_pii_rec,
                                    SELF.matchResult := LEFT.matchResult | RIGHT.matchResult, SELF := RIGHT))
                          ((matchResult & thresholdVal) = thresholdVal);

      accts_wDID := PROJECT(ds_batch_in(did <> 0), TRANSFORM(acct_pii_rec, SELF := LEFT, SELF := [])); //matchResult, offender_key
      
      withDID_nonFCRA := accts_wDID + deep_dids_final(did <> 0); //default behavior is running deep dive
      withDID_FCRA := accts_wDID;
      
      ds_acctnos_and_dids := IF(isFCRA, withDID_fcra, withDID_nonFCRA);
      
      // .. go look for ids via dids.
      ds_ids_by_did := JOIN(ds_acctnos_and_dids, key_offenders,
                            KEYED(LEFT.did = (UNSIGNED)RIGHT.sdid)AND
                            (~isFCRA OR
                            (STRING)RIGHT.offender_key NOT IN correct_ofk),
                            TRANSFORM(acct_pii_rec,
                                      SELF.offender_key := RIGHT.offender_key,
                                      SELF := LEFT),
                            KEEP(CriminalRecords_BatchService.Constants.MAX_OFFENDER_RECS_PER_DID), ATMOST(CriminalRecords_BatchService.Constants.MAX_OFFENDER_RECS_PER_DID_ATMOST));
      
      //overrides
      ds_ids_over := JOIN(ds_flags, fcra.key_override_crim.offenders,
                          KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
                          TRANSFORM(RIGHT),
                          KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
      ds_ids_over_final := JOIN(ds_ids_over, withDID_FCRA,
                                (UNSIGNED)LEFT.did = RIGHT.did,
                                TRANSFORM(acct_pii_rec,
                                          SELF.acctno := RIGHT.acctno,
                                          SELF.offender_key := LEFT.offender_key,
                                          SELF.did := RIGHT.did,
                                          SELF.matchResult := 0),
                                KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to KEEP the overrides that were IN the original search records
                                
      ds_ids_by_did_fcra := (ds_ids_by_did + ds_ids_over_final);
      
      RETURN IF(isFCRA, ds_ids_by_did_fcra, ds_ids_by_did);
    END;
  END;
  
  EXPORT Ids := MODULE
    SHARED acct_rec := CriminalRecords_BatchService.Layouts.lookup_id;

    EXPORT AutokeyIds(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) := FUNCTION
      // 1. Define values for obtaining autokeys and payloads.
      ak_keyname := Criminal_Records.Constants('').ak_QAname;
      ak_dataset := Criminal_Records.Constants('').ak_dataset;
      ak_typestr := Criminal_Records.Constants('').ak_typeStr;
      
      // 2. Configure the autokey search
      ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
        EXPORT skip_set := auto_skip + Criminal_Records.Constants('').skip_set;
        EXPORT useAllLookups := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
      END;
    
      // 3. Get autokey 'fake' ids (fids) based on batch input.
      ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
      
      // 4. Get seisint_primary_key via autokey payload (outpl).
      AutokeyB2.mac_get_payload( ds_fids, ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr );
      
      // 5. Slim the autokey payload (outpl) to just what's needed for matching.
      acct_rec xfm_payload(outpl l) := TRANSFORM
        SELF.acctno := l.acctno;
        SELF.match_type := MAP(l.matchcode IN ['N','S'] => '1',
                               l.matchcode IN ['NT','NL','NZ','Z','T','L'] => '2',
                               /* ELSE................................. */ '');
        SELF.did := l.did;
        SELF.offender_key := l.offender_key;
        SELF.too_many_code := '0';
        SELF.too_many_flag := '';
      END;
      
      ds_outpl_slim := PROJECT(outpl, xfm_Payload(LEFT));
      
      ak_nr := PROJECT(CriminalRecords_BatchService.Functions.get_ak_nr(ds_fids), TRANSFORM(acct_rec, SELF := LEFT));
      // ... Then sort and dedup.
      ds_ids_by_ak := DEDUP(SORT(ds_outpl_slim + ak_nr,acctno,did, offender_key),
                            acctno,did, offender_key);
      RETURN ds_ids_by_ak;
    END;
  
    EXPORT IdsByDID (DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
                     BOOLEAN isFCRA = FALSE,
                     DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := FUNCTION
      ds_flags := flagfile(file_id = FCRA.FILE_ID.OFFENDERS);
      correct_ofk := SET (ds_flags, record_id);
      // Key
      key_offenders := doxie_files.Key_Offenders(isFCRA);
    
      //Deep dive if necessary
      deep_dids := PROJECT(BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0)),
                    TRANSFORM(acct_rec,
                      SELF.acctno := LEFT.acctno,
                      SELF.did := LEFT.did,
                      SELF.match_type := '',
                      SELF.offender_key := ''));
      
      acct_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := TRANSFORM
        SELF.acctno := L.acctno;
        SELF.did := L.did;
        SELF.match_type := '';
        SELF.offender_key := '';
      END;
      accts_wDID := PROJECT(ds_batch_in(did <> 0), xformToAcctRec(LEFT));
      
      withDID_nonFCRA := accts_wDID + deep_dids(did <> 0); //default behavior is running deep dive
      withDID_FCRA := accts_wDID;
      
      ds_acctnos_and_dids := IF(isFCRA, withDID_fcra, withDID_nonFCRA);
      
      // .. go look for ids via dids.
      ds_ids_by_did := JOIN(ds_acctnos_and_dids, key_offenders,
                        KEYED((UNSIGNED)LEFT.did = (UNSIGNED)RIGHT.sdid)AND
                        (~isFCRA OR
                        (STRING)RIGHT.offender_key NOT IN correct_ofk),
                        TRANSFORM(acct_rec,
                          SELF.acctno := LEFT.acctno,
                          SELF.offender_key := RIGHT.offender_key,
                          SELF.did := LEFT.did,
                          SELF.match_type := ''),
                        KEEP(CriminalRecords_BatchService.Constants.MAX_OFFENDER_RECS_PER_DID), ATMOST(CriminalRecords_BatchService.Constants.MAX_OFFENDER_RECS_PER_DID_ATMOST));
      //overrides
      ds_ids_over := JOIN(ds_flags, fcra.key_override_crim.offenders,
                      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
                      TRANSFORM(RIGHT),
                      KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
      ds_ids_over_final := JOIN(ds_ids_over, withDID_FCRA,
                            (UNSIGNED)LEFT.did = RIGHT.did,
                            TRANSFORM(acct_rec,
                              SELF.acctno := RIGHT.acctno,
                              SELF.offender_key := LEFT.offender_key,
                              SELF.did := RIGHT.did,
                              SELF.match_type := ''),
                            KEEP(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to KEEP the overrides that were IN the original search records
                                
      ds_ids_by_did_fcra := (ds_ids_by_did + ds_ids_over_final);
      
      RETURN IF(isFCRA, ds_ids_by_did_fcra, ds_ids_by_did);
    END;
    
    EXPORT IdsByDocNum (DATASET(CriminalRecords_BatchService.Layouts.batch_in) ds_batch_in) := FUNCTION
      // Key
      key_docnum := doxie_files.key_offenders_docnum();
      
      // Fetch by docnum ids and mark no hit acctnos
      doc_ids := JOIN(ds_batch_in(docnum <> ''), key_docnum,
                  KEYED(LEFT.docnum = RIGHT.docnum) AND
                  (LEFT.st = '' OR LEFT.st = RIGHT.state),
                  TRANSFORM(acct_rec,
                    SELF.acctno := LEFT.acctno,
                    SELF.did := (INTEGER)RIGHT.did,
                    SELF.offender_key := RIGHT.offender_key,
                    SELF.match_type := '',
                    SELF.too_many_code := IF(RIGHT.offender_key = '', '98', '0'),
                    SELF.too_many_flag := IF(RIGHT.offender_key = '', 'N', '')),
                  KEEP(CriminalRecords_BatchService.Constants.MAX_RECS_PER_DOCNUM), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_PER_DOCNUM_ATMOST),
                  LEFT OUTER);

      RETURN doc_ids;
    END;
  END;

END;
