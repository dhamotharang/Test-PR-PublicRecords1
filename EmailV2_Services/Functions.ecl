IMPORT $, Address_Rank, Codes, Data_Services, DidVille, doxie, dx_BestRecords, EmailService, Royalty, Suppress, ut;

EXPORT Functions := MODULE

  FilterEmailData(DATASET($.Layouts.email_raw_rec) batch_in,
                         $.IParams.EmailParams in_mod,
                         STRING5 search_by
  ) := FUNCTION

    // filter out historic records if requested
    fltrd_historic_recs := batch_in(in_mod.IncludeHistoricData OR is_current);

    // filter by source, make sure data restrictions are enforced
    restrict_DataMarketing := in_mod.isDirectMarketing();

    restrict_reseller := in_mod.isResellerAccount() OR in_mod.isConsumer() OR // direct to consumer is subset of re-sellers
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

    // filter suspicious emails if search was't intitiated by email address
    EmailRulesExclusionMask := BNOT(in_mod.EmailQualityRulesMask);
    fltrd_email_recs := IF(EmailRulesExclusionMask > 0 AND ~search_by = $.Constants.SearchBy.ByEmail,
                           with_fltrd_sources(rules & EmailRulesExclusionMask = 0), with_fltrd_sources);

    // apply suppressions
    Suppress.MAC_Suppress(fltrd_email_recs,ds_raw_pulled_did,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did);
    Suppress.MAC_Suppress(ds_raw_pulled_did,ds_raw_pulled_ssn,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,cleaned.clean_ssn);

    // add royalty indicator
    royal_codes := Royalty.Constants.EMAIL_ROYALTY_TABLE();
    ds_with_royalty_email_recs := JOIN(ds_raw_pulled_ssn, royal_codes, LEFT.email_src = RIGHT.code,
                                 TRANSFORM($.Layouts.email_internal_rec,
                                           SELF.isRoyaltySource := RIGHT.code != '',
                                           SELF.email_quality_mask := LEFT.rules,
                                           SELF := LEFT,
                                           SELF := []),
                                 LEFT OUTER, KEEP(1), LIMIT(0));

    all_fltrd_email_recs := IF($.Constants.RestrictedUseCase.skipRoyaltySources(in_mod.RestrictedUseCase),
                                ds_with_royalty_email_recs(~isRoyaltySource), ds_with_royalty_email_recs);

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
                                             isRoyaltySource, -date_last_seen, date_first_seen, -original.login_date, -process_date, email_quality_mask, record),
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

  CalculateLNDates(DATASET($.Layouts.email_raw_rec) ds_batch_raw,
                         STRING5 search_by
  ) := FUNCTION

    ds_with_lexid := ds_batch_raw(DID > 0);
    ds_no_lexid := ds_batch_raw(DID = 0);

    temp_raw_rec := RECORD($.Layouts.email_raw_rec)
      INTEGER hash_val := 0;
    END;

    ds_results_hashed_by_lexid := PROJECT(ds_with_lexid, TRANSFORM(temp_raw_rec,
                                          SELF.hash_val := HASH(LEFT.acctno, LEFT.seq, LEFT.did),
                                          SELF := LEFT));

    ds_results_hashed_by_name_address := PROJECT(ds_no_lexid, TRANSFORM(temp_raw_rec,
                                       SELF.hash_val := HASH(LEFT.acctno,LEFT.seq,
                                       LEFT.cleaned.Name.fname,LEFT.cleaned.Name.mname,
                                       LEFT.cleaned.Name.lname,LEFT.cleaned.Name.name_suffix,
                                       LEFT.cleaned.Address.PreDir,LEFT.cleaned.Address.prim_range,LEFT.cleaned.Address.prim_name,
                                       LEFT.cleaned.Address.postdir,LEFT.cleaned.Address.addr_suffix,
                                       LEFT.cleaned.Address.zip,LEFT.cleaned.Address.sec_range),
                                       SELF:=LEFT)
                                   );

    ds_results_hashed_by_email := PROJECT(ds_batch_raw, TRANSFORM(temp_raw_rec,
                                          SELF.hash_val := HASH(LEFT.acctno, LEFT.seq, LEFT.cleaned.clean_email),
                                          SELF := LEFT));

    ds_results_hashed := IF(search_by = $.Constants.SearchBy.ByEmail,
                               ds_results_hashed_by_lexid + ds_results_hashed_by_name_address,   // list of identiies pulled by input email
                               ds_results_hashed_by_email  // list of emails pulled by input PII
                              );

    temp_raw_rec doMinMax(temp_raw_rec ll, DATASET(temp_raw_rec) rr) := TRANSFORM
      SELF.ln_date_last := MAX(rr,ln_date_last);
      SELF.ln_date_first := MIN(rr(ln_date_first>0),ln_date_first);
      SELF := ll;
    END;

    ds_rolled_with_dates := ROLLUP(GROUP(SORT(ds_results_hashed, hash_val),hash_val), GROUP, doMinMax(LEFT,ROWS(LEFT)));

    ds_with_lndates := JOIN(ds_results_hashed, UNGROUP(ds_rolled_with_dates),
                            LEFT.hash_val=RiGHT.hash_val,
                            TRANSFORM($.Layouts.email_raw_rec,
                              SELF.ln_date_last := RIGHT.ln_date_last,
                              SELF.ln_date_first := RIGHT.ln_date_first,
                              SELF := LEFT),
                            LIMIT(0), KEEP(1));

    RETURN ds_with_lndates;
  END;

  EXPORT GetEmailData(DATASET($.Layouts.batch_in_rec) batch_in,
                      $.IParams.EmailParams in_mod,
                      STRING5 search_by,
                      UNSIGNED1 data_environment=Data_Services.data_env.iNonFCRA,
                      BOOLEAN SkipDatesCalculation = FALSE
  ) := FUNCTION     // this function currently doesn't apply FCRA overrides, if FCRA functionality is requested the overrides logic need to be added

    email_raw_recs := $.Raw.getEmailRawData(batch_in,in_mod,search_by,data_environment);
    // we calculate LN first/last seen dates based on all email data before filtering to restrict sources are applied
    email_raw_with_dates_recs := IF(SkipDatesCalculation OR in_mod.KeepRawData, email_raw_recs,
                                    CalculateLNDates(email_raw_recs,search_by));
    // now we filter to apply restrictions
    email_fltrd_recs := FilterEmailData(email_raw_with_dates_recs,in_mod,search_by);
    // in case of search by PII we need to apply penalties for fuzzy matching
    email_matching_recs := IF(search_by = $.Constants.SearchBy.ByPII,
                                 ApplyFuzzyMatching(email_fltrd_recs, batch_in, in_mod),
                                 email_fltrd_recs);

    email_rolled_recs := RollupEmailData(email_matching_recs,in_mod,search_by);

    //OUTPUT(email_raw_with_dates_recs, NAMED('email_raw_with_dates_recs'), EXTEND);
    //OUTPUT(email_fltrd_recs, NAMED('email_fltrd_recs'), EXTEND);

    RETURN IF(~in_mod.KeepRawData, email_rolled_recs, email_matching_recs);
  END;

  OrderByEmailStatus(STRING _status) := MAP($.Constants.isValid(_status) => 1,  // valid email adresses to the top
                                           $.Constants.isUnverifiableEmail(_status) => 2,  // valid domain accepts all emails
                                           $.Constants.isUnknown(_status) => 3,
                                           $.Constants.isUndeliverableEmail(_status) => 11,  // pushing invalid email addresses to the bottom
                                           10);

  EXPORT SortResults(DATASET($.Layouts.email_final_rec) ds_batch_in,
                     $.IParams.EmailParams in_mod
  ) := FUNCTION

    ds_srtd_identity := SORT(ds_batch_in, acctno, -did_score, isRoyaltySource,-ln_date_last, ln_date_first, -num_sources,
                                          -latest_orig_login_date, -date_last_seen, date_first_seen, -process_date, num_email_per_did, email_quality_mask, RECORD);

    ds_srtd_identity_relations := SORT(ds_batch_in, acctno, -$.Constants.Relationship.IsSubject(relationship), -did_score, isRoyaltySource,-ln_date_last, ln_date_first, -num_sources,
                                          -latest_orig_login_date, -date_last_seen, date_first_seen, -process_date, num_email_per_did, email_quality_mask, RECORD);

    ds_srtd_email := SORT(ds_batch_in, acctno, -$.Constants.isTMXVerifiedEmail(TMX_insights.review_status), OrderByEmailStatus(email_status), // pushing TMX pass and BV verified emails to the top
                                       -num_sources, -ln_date_last, ln_date_first, -latest_orig_login_date, -date_last_seen, date_first_seen, -did_score, isRoyaltySource, -date_last_verified,
                                        num_did_per_email, penalt,-process_date, email_quality_mask, RECORD);

    ds_srtd := MAP($.Constants.SearchType.isEAA(in_mod.SearchType) => ds_srtd_email,
                   $.Constants.SearchType.isEIC(in_mod.SearchType) => ds_srtd_identity_relations,
                   ds_srtd_identity); // -EIA search type

    RETURN ds_srtd;
  END;

  getBestAddress(DATASET(Address_Rank.Layouts.Batch_in) addr_rank_in
  ) := FUNCTION

    //get all addresses from header based on LexIds
    dids_for_header   := PROJECT(addr_rank_in, doxie.layout_references_hh);
    // implementation similar to Address_Rank\fn_getHdrRecByDid_wBestdates.ecl  except we need to set IncludeAllRecords=true to by-pass penalties based on PII (pulled from stored) and skip search for dailies
    hdr_recs := doxie.header_records_byDID(dids:=dids_for_header, include_dailies:=TRUE, IncludeAllRecords:=TRUE, DoSearch:=FALSE);

    doxie.Layout_presentation roll_dates(doxie.Layout_presentation l, doxie.Layout_presentation r) := TRANSFORM
      SELF.dt_first_seen := ut.min2(l.dt_first_seen, r.dt_first_seen);
      SELF := l;
      SELF := r;
      SELF := [];
    END;

    hdr_roll_recs	:= ROLLUP(SORT(hdr_recs, did, zip, prim_range, predir, prim_name, postdir, suffix, sec_range, -dt_last_seen),
                        LEFT.did 				= RIGHT.did 				AND
                        LEFT.zip 		 		= RIGHT.zip					AND
                        LEFT.prim_range = RIGHT.prim_range	AND
                        LEFT.predir			= RIGHT.predir			AND
                        LEFT.prim_name 	= RIGHT.prim_name		AND
                        LEFT.postdir	 	= RIGHT.postdir			AND
                        LEFT.suffix 		= RIGHT.suffix			AND
                        LEFT.sec_range 	= RIGHT.sec_range,
                        roll_dates(LEFT,RIGHT));

    Address_Rank.Layouts.Bestrec xform_addrbest(Address_Rank.Layouts.Batch_in l, doxie.Layout_presentation r):= TRANSFORM
                    SELF.acctno      := (STRING)l.acctno;
                    SELF.dob         := (STRING)r.dob;
                    SELF.name_first  := r.fname;
                    SELF.name_middle := r.mname;
                    SELF.name_last   := r.lname;
                    SELF.suffix      := r.suffix;
                    SELF.p_city_name := r.city_name;
                    SELF.z5          := r.zip;
                    SELF.addr_dt_first_seen := (STRING)r.dt_first_seen;
                    SELF.addr_dt_last_seen  := (STRING)r.dt_last_seen;
                    SELF.srcs := r.src;
                    SELF := r;
                    SELF := [];
    END;
    all_hdr_recs := JOIN(addr_rank_in, hdr_roll_recs,
              LEFT.did = RIGHT.did,
              xform_addrbest(LEFT, RIGHT),
              LIMIT(0), LEFT OUTER);

    //get address history from Address Rank Key and determine best address
    addr_ranked_recs	:= Address_Rank.fn_getAddressHistory(all_hdr_recs, MaxRecordsToReturn:=1);

    RETURN addr_ranked_recs;
  END;

  EXPORT AddBestInfo(DATASET($.Layouts.email_internal_rec) ds_batch_in,
                             $.IParams.EmailParams in_mod
  ) := FUNCTION

    perm_type := dx_BestRecords.Functions.get_perm_type_idata(PROJECT(in_mod,doxie.IDataAccess),
                       useMarketing := in_mod.isDirectMarketing() OR $.Constants.RestrictedUseCase.isDirectMarketing(in_mod.RestrictedUseCase));

    email_with_watchdog_recs := PROJECT(dx_BestRecords.append(ds_batch_in,did,perm_type),
                                    TRANSFORM($.Layouts.email_final_rec,
                                              SELF.bestinfo := LEFT._best,
                                              SELF:=LEFT,
                                              SELF:=[]));

    // for best address we will use address ranking - req. EMAIL-205
    addr_rank_in := PROJECT(DEDUP(SORT(ds_batch_in(did!=0),did),did),
                           TRANSFORM(Address_Rank.Layouts.Batch_in,
                                     SELF.acctno := (STRING) COUNTER,
                                     SELF.did    := LEFT.did,
                                     SELF := []));

    best_addr_ranked_recs := getBestAddress(addr_rank_in);
    // adding best address to the results
    email_with_best_recs :=
      JOIN(email_with_watchdog_recs, best_addr_ranked_recs,
           LEFT.did = RIGHT.did,
           TRANSFORM($.Layouts.email_final_rec,
                    SELF.bestinfo.prim_range := RIGHT.prim_range,
                    SELF.bestinfo.predir := RIGHT.predir,
                    SELF.bestinfo.prim_name := RIGHT.prim_name,
                    SELF.bestinfo.postdir := RIGHT.postdir,
                    SELF.bestinfo.suffix := RIGHT.suffix,
                    SELF.bestinfo.unit_desig := RIGHT.unit_desig,
                    SELF.bestinfo.sec_range := RIGHT.sec_range,
                    SELF.bestinfo.zip := RIGHT.z5,
                    SELF.bestinfo.zip4 := RIGHT.zip4,
                    SELF.bestinfo.st := RIGHT.st,
                    SELF.bestinfo.city_name := RIGHT.p_city_name,
                    SELF := LEFT
                  ),
           LEFT OUTER, KEEP(1), LIMIT(0));

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

    ds_with_lexids_by_email_for_calc := GetEmailData(email_batch, in_mod, $.Constants.SearchBy.ByEmail, SkipDatesCalculation:=TRUE);

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

    ds_with_emails_by_lexids_for_calc := GetEmailData(lexids_batch, in_mod, $.Constants.SearchBy.ByLexid, SkipDatesCalculation:=TRUE);

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


  EXPORT AppendSubjectLexid(DATASET($.Layouts.batch_in_rec) ds_batch_in,
                            UNSIGNED1 _score_threshold = $.Constants.Defaults.DID_SCORE_THRESHOLD) := FUNCTION

    ds_for_dids_in := PROJECT(ds_batch_in(did=0), $.Transforms.toMacDidAppend(LEFT));
    BOOLEAN useonlybestdid := TRUE;

    DidVille.MAC_DidAppend(ds_for_dids_in, ds_dids_out, useonlybestdid, '');

    ds_batch_with_lexid := JOIN(ds_batch_in, ds_dids_out,
                              LEFT.acctno = (STRING) RIGHT.seq,
                              TRANSFORM($.Layouts.batch_in_rec,
                                        SELF.subject_lexid := IF (RIGHT.score >= _score_threshold,RIGHT.did,LEFT.did),
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



    rels_by_lexid := IF(EXISTS(inrecs_for_lexid_rels),
                        EmailService.Functions.GetRelationshipBySubjectLexId(rel_pairs_by_lexid,
                                     PROJECT(in_mod, Doxie.IDataAccess),
                                     include_2ndDegree_relatives:=TRUE));

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

  EXPORT CalculateRoyalties($.Layouts.email_combined_rec row_in
  ) := FUNCTION

    ext_royalties:= PROJECT(row_in.Royalties, Royalty.Layouts.Royalty);  // royalties from input (like gateway royalties)

    inh_royalties := Royalty.RoyaltyEmail.GetRoyaltySet(row_in.Records(email_src <> ''), email_src);

    // Now combine results for output
    res_row := ROW({row_in.Records, inh_royalties + ext_royalties}, $.Layouts.email_royalty_combined_rec);

    RETURN res_row;
  END;

END;
