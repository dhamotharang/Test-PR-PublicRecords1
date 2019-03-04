IMPORT $, DidVille, doxie, dx_BestRecords, Codes, Royalty, Suppress, STD,EmailService;

EXPORT Functions := MODULE

  FilterEmailData(DATASET($.Layouts.email_raw_rec) batch_in,
                         $.IParams.EmailParams in_mod
  ) := FUNCTION
  
    // filter out historic records if requested
    fltrd_historic_recs := batch_in(in_mod.IncludeHistoricData OR is_current);  
    
    // filter by source, make sure data restrictions are enforced
    // currently there is no restrictions of direct to consumer email sources
    restrict_DataMarketing := in_mod.isDirectMarketing() OR $.Constants.RestrictedUseCase.isDirectMarketing(in_mod.RestrictedUseCase);
    
    restrict_reseller := in_mod.isConsumer() OR  // data restriction indicators for reseller still needs to be clarified
                         $.Constants.RestrictedUseCase.isReseller(in_mod.RestrictedUseCase);
    fltrd_reseller_recs := IF(restrict_reseller,
                             JOIN(fltrd_historic_recs,Codes.Key_Codes_V3,KEYED(RIGHT.file_name = $.Constants.EMAIL_SOURCES) AND 
                                                          KEYED(RIGHT.field_name = $.Constants.RestrictedUseCase.Reseller) AND
                                                          RIGHT.code = LEFT.email_src,
                                                          TRANSFORM($.Layouts.email_raw_rec, SELF := LEFT),
                                 KEEP(1), LIMIT(0)), 
                             fltrd_historic_recs);
                                 
      
    with_fltrd_sources := IF(restrict_DataMarketing,  
                             JOIN(fltrd_reseller_recs, Codes.Key_Codes_V3,KEYED(RIGHT.file_name = $.Constants.EMAIL_SOURCES) AND 
                                                          KEYED(RIGHT.field_name = $.Constants.RestrictedUseCase.DirectMarketing) AND
                                                          RIGHT.code = LEFT.email_src,
                                                          TRANSFORM($.Layouts.email_raw_rec, SELF := LEFT),
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
                                 TRANSFORM($.Layouts.email_internal_rec, 
                                           SELF.isRoyaltySource := RIGHT.code != '',
                                           SELF.email_quality_mask := LEFT.rules,
                                           SELF := LEFT,
                                           SELF := []),
                                 LEFT OUTER, KEEP(1), LIMIT(0));

  RETURN all_fltrd_email_recs;
  END;
 
  ApplyFuzzyMatching(DATASET($.Layouts.email_internal_rec) ds_batch_raw,
                            DATASET($.Layouts.batch_in_rec) batch_input,
                            $.IParams.EmailParams in_mod                         
  ) := FUNCTION
  
  ds_with_penalties := JOIN(ds_batch_raw, batch_input,
                           LEFT.acctno = RIGHT.acctno,
                           $.Transforms.AddPenalties(LEFT,RIGHT),
                           KEEP(1),LIMIT(0));
                           
  // now we need to match by subject Lexid or do fuzzy matching - filtering results based on penalty
  // per reqs - in the absence of a LexID match (best case) we should still see at least fuzzy matching on multiple identity elements such as first name, last name, address, ssn, and/or dob.
  
  ds_matching := ds_with_penalties((DID > 0 AND DID=subject_lexid) OR penalt <= in_mod.PenaltThreshold);

  //OUTPUT(ds_with_penalties, NAMED('ds_with_penalties'));
  
  RETURN ds_matching;
  
  END;
  
  RollupEmailData(DATASET($.Layouts.email_internal_rec) ds_batch_raw,
                         $.IParams.EmailParams in_mod,
                         STRING5 search_by
  ) := FUNCTION
 
    ds_with_lexid := ds_batch_raw(DID > 0);
    ds_no_lexid := ds_batch_raw(DID = 0);


    ds_results_grouped_by_lexid := GROUP(SORT(ds_with_lexid, acctno, seq, did, isRoyaltySource, -did_score, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record)
                                   , acctno, seq, did);  

    ds_results_grouped_by_name_address := GROUP(SORT(ds_no_lexid, acctno, seq,
                                             cleaned.Name.fname, cleaned.Name.mname,cleaned.Name.lname,cleaned.Name.name_suffix, 
                                             cleaned.Address.PreDir,cleaned.Address.prim_range, cleaned.Address.prim_name,cleaned.Address.postdir,cleaned.Address.addr_suffix,cleaned.Address.zip,cleaned.Address.sec_range, 
                                             isRoyaltySource, -did_score, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record),
                                       acctno, seq,
                                       cleaned.Name.fname, cleaned.Name.mname,cleaned.Name.lname,cleaned.Name.name_suffix, 
                                       cleaned.Address.PreDir,cleaned.Address.prim_range, cleaned.Address.prim_name,cleaned.Address.postdir,cleaned.Address.addr_suffix,cleaned.Address.zip,cleaned.Address.sec_range 
                                   );  

    ds_results_grouped_by_email := GROUP(SORT(ds_batch_raw, acctno, seq, cleaned.clean_email, -did_score,IF(did>0,0,1), penalt, isRoyaltySource, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record), acctno, seq, cleaned.clean_email);  

    ds_results_groupped := IF(search_by = $.Constants.SearchBy.ByEmail, 
                               ds_results_grouped_by_lexid + ds_results_grouped_by_name_address,   // list of identiies pulled by input email need to be groupped to keep unique identities
                               ds_results_grouped_by_email  // list of emails pulled by input PII need to be groupped to keep unique email addresses in the results
                              );
    
    $.Layouts.email_internal_rec doRollup($.Layouts.email_internal_rec ll, DATASET($.Layouts.email_internal_rec) allRows) := TRANSFORM
      _latest_orig_login_date := MAX(allRows, original.login_date);
      SELF.latest_orig_login_date := IF((UNSIGNED)_latest_orig_login_date>0, _latest_orig_login_date, '');
      SELF.num_sources := COUNT(DEDUP(SORT(allRows, email_src), email_src));
      SELF := ll;
    END;
    
    ds_results_rolled := ROLLUP(ds_results_groupped, GROUP, doRollup(LEFT,ROWS(LEFT)));
    
    RETURN UNGROUP(ds_results_rolled);
  END;

  EXPORT GetEmailData(DATASET($.Layouts.batch_in_rec) batch_in,
                      $.IParams.EmailParams in_mod,
                      STRING5 search_by
  ) := FUNCTION
                        
    email_raw_recs := $.Raw.getEmailRawData(batch_in,in_mod,search_by);
    email_fltrd_recs := FilterEmailData(email_raw_recs,in_mod);
    
    // in case of search by PII we need to apply penalties for fuzzy matching
    email_matching_recs := IF(search_by = $.Constants.SearchBy.ByPII, 
                                 ApplyFuzzyMatching(email_fltrd_recs, batch_in, in_mod), 
                                 email_fltrd_recs);
    
    email_rolled_recs := RollupEmailData(email_matching_recs,in_mod,search_by);

    RETURN email_rolled_recs;
  END;
   
  EXPORT SortResults(DATASET($.Layouts.email_final_rec) ds_batch_in,
                     $.IParams.EmailParams in_mod
  ) := FUNCTION
  
    ds_srtd_identity := SORT(ds_batch_in, acctno, -did_score, isRoyaltySource,-date_last_seen, date_first_seen, -num_sources, -latest_orig_login_date, -process_date, num_email_per_did, email_quality_mask, record);
    ds_srtd_email := SORT(ds_batch_in, acctno, -num_sources, -date_last_seen, date_first_seen, -latest_orig_login_date, -did_score, isRoyaltySource, num_did_per_email, penalt,-process_date, email_quality_mask, record);
   
    ds_srtd := IF($.Constants.SearchType.isEIA(in_mod.SearchType),ds_srtd_identity, ds_srtd_email);

    RETURN ds_srtd;
  END;
 
  EXPORT AddBestInfo(DATASET($.Layouts.email_internal_rec) ds_batch_in,
                             $.IParams.EmailParams in_mod
  ) := FUNCTION
    
    perm_type := dx_BestRecords.Functions.get_perm_type_idata(PROJECT(in_mod,doxie.IDataAccess),
                       useMarketing := in_mod.isDirectMarketing() OR $.Constants.RestrictedUseCase.isDirectMarketing(in_mod.RestrictedUseCase)); 
    
    email_with_best_recs := PROJECT(dx_BestRecords.append(ds_batch_in,did,perm_type), 
                                    TRANSFORM($.Layouts.email_final_rec,
                                              SELF.bestinfo := LEFT._best,
                                              SELF:=LEFT,
                                              SELF:=[]));
                                              
    Suppress.MAC_Suppress(email_with_best_recs,email_with_best_ready,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,bestinfo.ssn);

    RETURN email_with_best_ready;
  END;   
  
  EXPORT CalculateLexIdsPerEmail(DATASET($.Layouts.email_internal_rec) ds_batch_in,
                                 $.IParams.EmailParams in_mod
  ) := FUNCTION
  
     // for EAA search - we need to make additional call to pull/filter/dedup data by emails we have in ds_batch_raw
    ds_batch_in_seq := PROJECT(ds_batch_in, TRANSFORM($.Layouts.email_internal_rec,
                                                        SELF.seq := COUNTER, SELF := LEFT));
                            
    email_batch := PROJECT(ds_batch_in_seq, TRANSFORM($.Layouts.batch_in_rec,
                            SELF.email_username := TRIM(LEFT.email_username, ALL),
                            SELF.email_domain := TRIM(LEFT.email_domain, ALL),
                            SELF.acctno := LEFT.acctno,
                            SELF.seq := LEFT.seq,  // since same acctno will have multiple emails we need to use seq field to distinguish results
                            SELF := []));

    ds_with_lexids_by_email_for_calc := GetEmailData(email_batch, in_mod, $.Constants.SearchBy.ByEmail );
     
    $.Layouts.email_internal_rec addLexIdcount($.Layouts.email_internal_rec ll, DATASET($.Layouts.email_internal_rec) allRows) := TRANSFORM
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
    
    ds_res := IF($.Constants.SearchType.isEAA(in_mod.SearchType), ds_combined_res, ds_Lexid_count_by_email);

    RETURN UNGROUP(ds_res);
  END;
  
  
  EXPORT CalculateEmailsPerLexid(DATASET($.Layouts.email_internal_rec) ds_batch_in,
                                 $.IParams.EmailParams in_mod
  ) := FUNCTION
  
    ds_batch_in_seq := PROJECT(ds_batch_in, TRANSFORM($.Layouts.email_internal_rec,
                                                        SELF.seq := COUNTER, SELF := LEFT));
                            
     // for EIA and EIC search - we need to make additional call to pull/filter/dedup data by Lexid we have in ds_batch_raw
    lexids_batch := PROJECT(ds_batch_in_seq, TRANSFORM($.Layouts.batch_in_rec,
                            SELF.DID    := LEFT.DID,
                            SELF.acctno := LEFT.acctno,
                            SELF.seq    := LEFT.seq,  // since same acctno will have multiple identities we need to use seq field to distinguish results
                            SELF := []));

    ds_with_emails_by_lexids_for_calc := GetEmailData(lexids_batch, in_mod, $.Constants.SearchBy.ByLexid);
     
    $.Layouts.email_internal_rec addEmailCount($.Layouts.email_internal_rec ll, DATASET($.Layouts.email_internal_rec) allRows) := TRANSFORM
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
    
    ds_res := IF($.Constants.SearchType.isEAA(in_mod.SearchType), ds_email_count_by_Lexid, ds_combined_res);

    RETURN UNGROUP(ds_res);
  END;
  
  
  EXPORT AppendSubjectLexid(DATASET($.Layouts.batch_in_rec) ds_batch_in) := FUNCTION
  
    ds_for_dids_in := PROJECT(ds_batch_in(did=0), $.Transforms.toMacDidAppend(LEFT));
    BOOLEAN useonlybestdid := TRUE;
    
    DidVille.MAC_DidAppend(ds_for_dids_in, ds_dids_out, useonlybestdid, ''); 
    
    ds_batch_with_lexid := JOIN(ds_batch_in, ds_dids_out,
                              LEFT.acctno = (STRING) RIGHT.seq,
                              TRANSFORM($.Layouts.batch_in_rec, 
                                        SELF.subject_lexid := IF (RIGHT.score >= $.Constants.Defaults.DID_SCORE_THRESHOLD,RIGHT.did,LEFT.did),
                                        SELF := LEFT),
                              LEFT OUTER,  KEEP(1), LIMIT(0));

    //OUTPUT(ds_dids_out, NAMED('ds_dids_out_didvile'),EXTEND);
 
    RETURN ds_batch_with_lexid;
  END;

  EXPORT AddIdentityRelationship(DATASET($.Layouts.email_final_rec) in_email_recs,
                                 DATASET($.Layouts.batch_in_rec) batch_input,
                                 $.IParams.EmailParams in_mod
 ) := FUNCTION 
  
    inrecs_for_fuzzy_rels := in_email_recs(DID=0 OR subject_LexId=0);
    inrecs_for_lexid_rels := in_email_recs(DID>0 AND subject_LexId>0);    

    rel_pairs_by_lexid := PROJECT(inrecs_for_lexid_rels, 
                                  TRANSFORM(EmailService.Assorted_Layouts.layout_relationship,
                                            SELF.identity_lexID := LEFT.DID, 
                                            SELF.subject_lexId := LEFT.subject_LexId,
                                            SELF.relationship := LEFT.relationship));



    rels_by_lexid := IF(EXISTS(inrecs_for_lexid_rels), EmailService.Functions.GetRelationshipBySubjectLexId(rel_pairs_by_lexid, include_2ndDegree_relatives:=TRUE));
    
    recs_with_rels_by_lexid := JOIN(inrecs_for_lexid_rels, rels_by_lexid, 
                                 LEFT.did = RIGHT.identity_LexID AND 
                                 LEFT.subject_LexId = RIGHT.subject_LexId,
                                 TRANSFORM($.Layouts.email_final_rec,
                                   SELF.relationship := MAP( 
                                                           LEFT.did>0 AND LEFT.did=LEFT.subject_LexId => $.Constants.Relationship.PossibleSubject,
                                                           RIGHT.relationship<>''=> RIGHT.relationship,
                                                           LEFT.relationship),
                                   SELF := LEFT
                                 ),
                                 LEFT OUTER, KEEP(1), LIMIT(0));
    
    
    // for cases where we cannot use lexid to identify relationship we will attempt to use fuzzy matching
    recs_with_fuzzy_rels := JOIN(inrecs_for_fuzzy_rels, batch_input,
                           LEFT.acctno = RIGHT.acctno,
                           $.Transforms.AddFuzzyRelationship(LEFT, RIGHT, in_mod.PenaltThreshold),
                           KEEP(1),LIMIT(0));
    
    // now combine all results 
    all_email_rels := recs_with_rels_by_lexid + recs_with_fuzzy_rels;

    email_rels_ready := PROJECT(all_email_rels, 
                                TRANSFORM($.Layouts.email_final_rec, 
                                  SELF.relationship := IF(LEFT.relationship='',$.Constants.Relationship.NotFound, LEFT.relationship),
                                  SELF := LEFT));

    RETURN email_rels_ready;
  END;

END;