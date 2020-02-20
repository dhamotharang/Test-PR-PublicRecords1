IMPORT $, AutoKeyI, Suppress;

EXPORT EmailAddressAppendSearch(DATASET($.Layouts.batch_in_rec) batch_in,
                                 $.IParams.EmailParams in_mod,
                                 BOOLEAN require_full_address_check = FALSE
) := FUNCTION

  marked_input_recs := PROJECT(batch_in, $.Transforms.checkIdentityInput(LEFT, require_full_address_check));

  clnd_input_pii := PROJECT(marked_input_recs(~is_rejected_rec),$.Layouts.batch_in_rec);

  // attach resolved LexId as subject_lexId
  clnd_input_with_lexids := $.Functions.AppendSubjectLexid(clnd_input_pii, in_mod.DIDScoreThreshold);

  ds_rejected_input := PROJECT(marked_input_recs(is_rejected_rec),
                                  TRANSFORM($.Layouts.email_final_rec,
                                            SELF := LEFT,
                                            SELF := []));

  ds_rejected_nolexid := IF(in_mod.RequireLexidMatch,
                            PROJECT(clnd_input_with_lexids(subject_lexid=0),
                                   TRANSFORM($.Layouts.email_final_rec,
                                            SELF.record_err_msg  := AutoKeyI.errorcodes._msgs(AutoKeyI.errorcodes._codes.LEXID_FAIL);
                                            SELF.record_err_code := AutoKeyI.errorcodes._codes.LEXID_FAIL;
                                            SELF.is_rejected_rec := TRUE;
                                            SELF := LEFT,
                                            SELF := [])));

  // in case if RequireLexidMatch is requested we will use input/resolved lexid to pull email data (no deep dive or Autokeys)
  in_by_subject_lexid := PROJECT(clnd_input_with_lexids(subject_lexid>0), TRANSFORM($.Layouts.batch_in_rec, SELF.DID := LEFT.subject_lexid, SELF:=LEFT));

  // get data from payload, apply filtering and rollup
  email_ddpd_recs := IF(in_mod.RequireLexidMatch,
                        $.Functions.getEmailData(in_by_subject_lexid, in_mod, $.Constants.SearchBy.ByLexId),
                        $.Functions.getEmailData(clnd_input_with_lexids, in_mod, $.Constants.SearchBy.ByPII));

  // calculate num_did_per_email and num_email_per_did
  email_with_num_did_recs := $.Functions.CalculateLexIdsPerEmail(email_ddpd_recs,in_mod);
  email_with_num_recs := $.Functions.CalculateEmailsPerLexid(email_with_num_did_recs,in_mod);

  // add best info
  email_with_best_recs := $.Functions.AddBestInfo(email_with_num_recs,in_mod);
  // checking if additional info like best and num_ calculations needed, if not projecting to final rec
  email_with_additional_info := IF(in_mod.IncludeAdditionalInfo,
                                  email_with_best_recs,
                                  PROJECT(email_ddpd_recs,
                                          TRANSFORM($.Layouts.email_final_rec,
                                                    SELF:=LEFT,
                                                    SELF:=[])));

  // add email status
  email_recs_with_hist_status := $.GatewayData.AddStatusFromHistory(email_with_additional_info, in_mod); // per EMAIL-158 reqs. we now add status info using BV history for basic search as well
  email_recs_valdtd := $.GatewayData.VerifyDeliveryStatus(email_recs_with_hist_status, in_mod);  // validate status using external GW calls
  email_recs_with_BV := IF(in_mod.CheckEmailDeliverable, email_recs_valdtd.Records, email_recs_with_hist_status);

    // now we filter undeliverable emails if requested
    //Per req.#6 of EMAIL-123:
    // In all cases, email addresses deemed invalid based on flags within the email base file,
    // or based on "invalid domain" status from the Domain Lookup,
    // will be treated the same as if BV returned an invalid status;
    // they will be removed from Email Address Append results if the option to remove invalid email addresses is turned on.

  filter_undeliverable := ~in_mod.KeepUndeliverableEmail;
  email_recs_ready := IF(filter_undeliverable,
                             email_recs_with_BV(~$.Constants.isUndeliverableEmail(email_status)
                             AND (email_quality_mask & BNOT($.Constants.EmailQualityRulesForBVCall) = 0)),  // filtering  email addresses deemed invalid based on flags within the email base file
                             email_recs_with_BV);

  //use TMX ERA policy
  email_with_tmx_recs := IF(in_mod.UseTMXRules, $.GatewayData.getTMXInsights(email_recs_ready, in_mod), email_recs_ready);

  // sort results to push up best emails before applying maxresults
  email_recs_srtd := $.Functions.SortResults(email_with_tmx_recs, in_mod);


  // keep max results requested
  ds_results_chsn := UNGROUP(TOPN(GROUP(email_recs_srtd, acctno), in_mod.MaxResultsPerAcct, acctno));
  // to support email source docs we need to keep all raw data
  ds_results_unmasked := IF(~in_mod.KeepRawData, ds_results_chsn, email_recs_srtd);

  // masking
  ssn_mask_use := IF(in_mod.isDirectMarketing(), Suppress.Constants.SSN_MASK_TYPE.ALL, in_mod.ssn_mask);
  Suppress.Mac_mask(ds_results_unmasked, ds_results_best_ssnmasked, bestinfo.ssn, null, TRUE, FALSE, maskVal:=ssn_mask_use);
  Suppress.Mac_mask(ds_results_best_ssnmasked, ds_results_clean_ssnmasked,cleaned.clean_ssn, null, TRUE, FALSE, maskVal:=ssn_mask_use);
  Suppress.Mac_mask(ds_results_clean_ssnmasked, ds_results_ssnmasked,original.ssn, null, TRUE, FALSE, maskVal:=ssn_mask_use);

  dob_mask_use := IF(in_mod.isDirectMarketing(), Suppress.Constants.datemask.ALL, in_mod.dob_mask);
  ds_results_ssndob_masked := PROJECT(ds_results_ssnmasked, $.Transforms.ApplyDobMask(LEFT,dob_mask_use));

  // combine results and rejected input
  ds_results_ready := ds_results_ssndob_masked + ds_rejected_input + ds_rejected_nolexid;

  //OUTPUT(email_ddpd_recs, NAMED('email_ddpd_recs'));
  //OUTPUT(email_recs_srtd, NAMED('email_recs_srtd'));
  //OUTPUT(ds_results_chsn, NAMED('ds_results_chsn'));

  email_gw_royalties := IF(in_mod.CheckEmailDeliverable, email_recs_valdtd.Royalties);

  result_row := ROW({ds_results_ready, email_gw_royalties}, $.Layouts.email_combined_rec);

  RETURN result_row;
END;
