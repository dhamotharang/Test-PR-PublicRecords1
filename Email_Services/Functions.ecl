IMPORT doxie, dx_BestRecords, Codes, Email_Services, Suppress, Royalty;

EXPORT Functions := MODULE

  EXPORT FilterEmailData(DATASET(Email_Services.Layouts.email_raw_rec) batch_in,
                         Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
  
    // filter out historic records if requested
    fltrd_historic_recs := batch_in(in_mod.IncludeHistoricData OR is_current);  
    
    // filter by source, make sure data restrictions are enforced
    // currently there is no restrictions of direct to consumer email sources
    restrict_DataMarketing := in_mod.isUtility() OR Email_Services.Constants.IntendedPurpose.isDirectMarketing(in_mod.IntendedPurpose);
    
    restrict_reseller := // in_mod.isConsumer() OR  // data restriction indicators for reseller still needs to be clarified
                         Email_Services.Constants.IntendedPurpose.isReseller(in_mod.IntendedPurpose);
    fltrd_reseller_recs := IF(restrict_reseller,
                             JOIN(fltrd_historic_recs,Codes.Key_Codes_V3,KEYED(RIGHT.file_name = Email_Services.Constants.EMAIL_SOURCES) AND 
                                                          KEYED(RIGHT.field_name = Email_Services.Constants.IntendedPurpose.Reseller) AND
                                                          RIGHT.code = LEFT.email_src,
                                                          TRANSFORM(Email_Services.Layouts.email_raw_rec, SELF := LEFT),
                                 KEEP(1), LIMIT(0)), 
                             fltrd_historic_recs);
                                 
      
    with_fltrd_sources := IF(restrict_DataMarketing,  
                             JOIN(fltrd_reseller_recs, Codes.Key_Codes_V3,KEYED(RIGHT.file_name = Email_Services.Constants.EMAIL_SOURCES) AND 
                                                          KEYED(RIGHT.field_name = Email_Services.Constants.IntendedPurpose.DirectMarketing) AND
                                                          RIGHT.code = LEFT.email_src,
                                                          TRANSFORM(Email_Services.Layouts.email_raw_rec, SELF := LEFT),
                                 KEEP(1), LIMIT(0)), 
                             fltrd_reseller_recs);
     
    // filter suspicious emails
    EmailRulesExclusionMask := BNOT(in_mod.EmailQualityRulesMask);
    fltrd_email_recs := IF(EmailRulesExclusionMask > 0, with_fltrd_sources(rules & EmailRulesExclusionMask = 0), with_fltrd_sources);

    // apply suppressions
    Suppress.MAC_Suppress(fltrd_email_recs,ds_raw_pulled_did,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did);
    Suppress.MAC_Suppress(ds_raw_pulled_did,ds_raw_pulled_ssn,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,cleaned.clean_ssn);
 
    // add royalty indicator
    royal_codes := Royalty.Constants.EMAIL_ROYALTY_TABLE();
    all_fltrd_email_recs := JOIN(ds_raw_pulled_ssn, royal_codes, LEFT.email_src = RIGHT.code, 
                                 TRANSFORM(Email_Services.Layouts.email_internal_rec, 
                                           SELF.isRoyaltySource := RIGHT.code != '',
                                           SELF.email_quality_mask := LEFT.rules,
                                           SELF := LEFT,
                                           SELF := []),
                                 LEFT OUTER, KEEP(1), LIMIT(0));

  RETURN all_fltrd_email_recs;
  END;
 
  EXPORT RollupEmailData(DATASET(Email_Services.Layouts.email_internal_rec) ds_batch_raw,
                         Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
 
    ds_with_lexid := ds_batch_raw(DID > 0);
    ds_no_lexid := ds_batch_raw(DID = 0);


    ds_grouped_by_lexid := GROUP(SORT(ds_with_lexid, acctno, seq, did, isRoyaltySource, -did_score, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record)
                                   , acctno, seq, did);  

    ds_grouped_by_name_address := GROUP(SORT(ds_no_lexid, acctno, seq,
                                             cleaned.Name.fname, cleaned.Name.mname,cleaned.Name.lname,cleaned.Name.name_suffix, 
                                             cleaned.Address.PreDir,cleaned.Address.prim_range, cleaned.Address.prim_name,cleaned.Address.postdir,cleaned.Address.addr_suffix,cleaned.Address.zip,cleaned.Address.sec_range, 
                                             isRoyaltySource, -did_score, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record),
                                       acctno, seq,
                                       cleaned.Name.fname, cleaned.Name.mname,cleaned.Name.lname,cleaned.Name.name_suffix, 
                                       cleaned.Address.PreDir,cleaned.Address.prim_range, cleaned.Address.prim_name,cleaned.Address.postdir,cleaned.Address.addr_suffix,cleaned.Address.zip,cleaned.Address.sec_range 
                                   );  

    ds_grouped_by_email := GROUP(SORT(ds_batch_raw, acctno, seq, cleaned.clean_email, -did_score,IF(did>0,0,1), penalt, isRoyaltySource, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record), acctno, seq, cleaned.clean_email);  

    ds_results_groupped := IF(Email_Services.Constants.SearchType.isEAA(in_mod.SearchType), ds_grouped_by_email, ds_grouped_by_lexid + ds_grouped_by_name_address);
    
    Email_Services.Layouts.email_internal_rec doRollup(Email_Services.Layouts.email_internal_rec ll, DATASET(Email_Services.Layouts.email_internal_rec) allRows) := TRANSFORM
      SELF.latest_orig_login_date := MAX(allRows, original.login_date);
      SELF.num_sources := COUNT(DEDUP(SORT(allRows, email_src), email_src));
      SELF := ll;
    END;
    
    ds_results_rolled := ROLLUP(ds_results_groupped, GROUP, doRollup(LEFT,ROWS(LEFT)));
    
    RETURN UNGROUP(ds_results_rolled);
  END;

  EXPORT GetEmailData(DATASET(Email_Services.Layouts.batch_in_rec) batch_in,
                      Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
                        

    email_raw_recs := Email_Services.Raw.getEmailRawData(batch_in,in_mod);
    email_fltrd_recs := FilterEmailData(email_raw_recs,in_mod);
    email_rolled_recs := RollupEmailData(email_fltrd_recs,in_mod);

    RETURN email_rolled_recs;
  END;
   
  EXPORT SortResults(DATASET(Email_Services.Layouts.email_final_rec) ds_batch_in,
                     Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
  
    ds_srtd_identity := SORT(ds_batch_in, acctno, -did_score, isRoyaltySource,-date_last_seen, date_first_seen, -num_sources, -latest_orig_login_date, -process_date, num_email_per_did, email_quality_mask, record);
    ds_srtd_email := SORT(ds_batch_in, acctno, -num_sources, -date_last_seen, date_first_seen, -latest_orig_login_date, -did_score, isRoyaltySource, num_did_per_email, penalt,-process_date, email_quality_mask, record);
   
    ds_srtd := IF(Email_Services.Constants.SearchType.isEIA(in_mod.SearchType),ds_srtd_identity, ds_srtd_email);

    RETURN ds_srtd;
  END;
 
  EXPORT AddBestInfo(DATASET(Email_Services.Layouts.email_internal_rec) ds_batch_in,
                             Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
    
    perm_type := dx_BestRecords.Functions.get_perm_type_idata(PROJECT(in_mod,doxie.IDataAccess),
                       useMarketing := Email_Services.Constants.IntendedPurpose.isDirectMarketing(in_mod.IntendedPurpose)); 
    
    email_with_best_recs := PROJECT(dx_BestRecords.append(ds_batch_in,did,perm_type), 
                                    TRANSFORM(Email_Services.Layouts.email_final_rec,
                                              SELF.bestinfo := LEFT._best,
                                              SELF:=LEFT,
                                              SELF:=[]));
                                              
    Suppress.MAC_Suppress(email_with_best_recs,email_with_best_ready,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,bestinfo.ssn);

    RETURN email_with_best_ready;
  END;   
  
  EXPORT CalculateLexIdsPerEmail(DATASET(Email_Services.Layouts.email_internal_rec) ds_batch_in,
                                 Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
  
     // for EAA search - we need to make additional call to pull/filter/dedup data by emails we have in ds_batch_raw
    uptd_mod := MODULE(PROJECT(in_mod, Email_Services.IParams.EmailParams))
      EXPORT SearchType := Email_Services.Constants.SearchType.EIA;
    END;
    
    ds_batch_in_seq := PROJECT(ds_batch_in, TRANSFORM(Email_Services.Layouts.email_internal_rec,
                                                        SELF.seq := COUNTER, SELF := LEFT));
                            
    email_batch := PROJECT(ds_batch_in_seq, TRANSFORM(Email_Services.Layouts.batch_in_rec,
                            SELF.email_username := LEFT.email_username,
                            SELF.email_domain := LEFT.email_domain,
                            SELF.acctno := LEFT.acctno,
                            SELF.seq := LEFT.seq,  // since same acctno will have multiple emails we need to use seq field to distinguish results
                            SELF := []));

    ds_with_lexids_by_email_for_calc := GetEmailData(email_batch, uptd_mod);
     
    Email_Services.Layouts.email_internal_rec addLexIdcount(Email_Services.Layouts.email_internal_rec ll, DATASET(Email_Services.Layouts.email_internal_rec) allRows) := TRANSFORM
      SELF.num_did_per_email := COUNT(allRows(did > 0));  
      SELF := ll;
      SELF := [];
    END;
 
    ds_combined_res := DENORMALIZE(ds_batch_in_seq, ds_with_lexids_by_email_for_calc, 
                                   LEFT.acctno=RIGHT.acctno AND LEFT.seq=RIGHT.seq, 
                                   GROUP, addLexIdcount(LEFT, ROWS(RIGHT))); 

    // in case of EIA and EIC search we only need to count LexIds in the ds_batch_in - the LexId uniqueness is taken care by RollupEmailData()  
    ds_Lexid_count_by_email := DENORMALIZE(ds_batch_in_seq, ds_batch_in, 
                                   LEFT.acctno=RIGHT.acctno AND LEFT.cleaned.clean_email=RIGHT.cleaned.clean_email, 
                                   GROUP, addLexIdcount(LEFT, ROWS(RIGHT))); 
    
    ds_res := IF(Email_Services.Constants.SearchType.isEAA(in_mod.SearchType), ds_combined_res, ds_Lexid_count_by_email);

    RETURN UNGROUP(ds_res);
  END;
  
  
  EXPORT CalculateEmailsPerLexid(DATASET(Email_Services.Layouts.email_internal_rec) ds_batch_in,
                                 Email_Services.IParams.EmailParams in_mod
  ) := FUNCTION
  
     // for EIA and EIC search - we need to make additional call to pull/filter/dedup data by Lexid we have in ds_batch_raw
    uptd_mod := MODULE(PROJECT(in_mod, Email_Services.IParams.EmailParams))
      EXPORT SearchType := Email_Services.Constants.SearchType.EAA;
      EXPORT BOOLEAN RequireLexidMatch := TRUE; 
    END;
    
    ds_batch_in_seq := PROJECT(ds_batch_in, TRANSFORM(Email_Services.Layouts.email_internal_rec,
                                                        SELF.seq := COUNTER, SELF := LEFT));
                            
    lexids_batch := PROJECT(ds_batch_in_seq, TRANSFORM(Email_Services.Layouts.batch_in_rec,
                            SELF.DID := LEFT.DID,
                            SELF.acctno := LEFT.acctno,
                            SELF.seq := LEFT.seq,  // since same acctno will have multiple identities we need to use seq field to distinguish results
                            SELF := []));

    ds_with_emails_by_lexids_for_calc := GetEmailData(lexids_batch, uptd_mod);
     
    Email_Services.Layouts.email_internal_rec addEmailCount(Email_Services.Layouts.email_internal_rec ll, DATASET(Email_Services.Layouts.email_internal_rec) allRows) := TRANSFORM
      SELF.num_email_per_did := COUNT(allRows);  //the email uniqueness is taken care by RollupEmailData() -> GetEmailData
      SELF := ll;
      SELF := [];
    END;
 
    ds_combined_res := DENORMALIZE(ds_batch_in_seq, ds_with_emails_by_lexids_for_calc, 
                                   LEFT.acctno=RIGHT.acctno AND LEFT.seq=RIGHT.seq, 
                                   GROUP, addEmailCount(LEFT, ROWS(RIGHT))); 

    // in case of EAA search we only need to count LexIds in the ds_batch_in - the email uniqueness is taken care by RollupEmailData()  
    ds_email_count_by_Lexid := DENORMALIZE(ds_batch_in_seq, ds_batch_in, 
                                   LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did, 
                                   GROUP, addEmailCount(LEFT, ROWS(RIGHT))); 
    
    ds_res := IF(Email_Services.Constants.SearchType.isEAA(in_mod.SearchType), ds_email_count_by_Lexid, ds_combined_res);

    RETURN UNGROUP(ds_res);
  END;
  
END;