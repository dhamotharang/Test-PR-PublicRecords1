IMPORT $, Suppress;

EXPORT EmailIdentityAppendSearch(DATASET($.Layouts.batch_in_rec) batch_in,
                                 $.IParams.EmailParams in_mod
) := FUNCTION

  // clean input email first
  marked_input_Email_recs := PROJECT(batch_in, $.Transforms.cleanEmailAddress(LEFT));

  clnd_input_email := PROJECT(marked_input_Email_recs(~is_rejected_rec),$.Layouts.batch_in_rec);
  ds_rejected_input_email := PROJECT(marked_input_Email_recs(is_rejected_rec),
                                  TRANSFORM($.Layouts.email_final_rec,
                                            SELF := LEFT,
                                            SELF := []));

  // get data from payload, apply filtering and rollup
  email_ddpd_recs := $.Functions.getEmailData(clnd_input_email,in_mod, $.Constants.SearchBy.ByEmail);

  // calculate num_did_per_email and num_email_per_did
  email_with_num_did_recs := $.Functions.CalculateLexIdsPerEmail(email_ddpd_recs,in_mod);
  email_with_num_recs := $.Functions.CalculateEmailsPerLexid(email_with_num_did_recs,in_mod);

  // add best info
  email_with_best_recs := $.Functions.AddBestInfo(email_with_num_recs,in_mod);

  // add email status
  email_recs_with_hist_status := $.GatewayData.AddStatusFromHistory(email_with_best_recs, in_mod, clnd_input_email); // per EMAIL-158 reqs. we now add status info using BV history for basic search as well
  email_recs_valdtd := $.GatewayData.VerifyDeliveryStatus(email_recs_with_hist_status, in_mod); // validate status using external GW calls
  email_recs_with_status := IF(in_mod.CheckEmailDeliverable, email_recs_valdtd.Records, email_recs_with_hist_status);
  //filter out records with no internal identity info AND BV status = unknown (so we aren’t charging for a hit without any valuable insight) - req.2.4 of EMAIL-158
  email_recs_ready := email_recs_with_status(~$.Constants.isUnknown(email_status) OR email_id>0);

  //use TMX ERA policy
  email_with_tmx_recs := IF(in_mod.UseTMXRules, $.GatewayData.getTMXInsights(email_recs_ready, in_mod), email_recs_ready);

  // sort results to push up best emails before applying maxresults
  email_recs_srtd := $.Functions.SortResults(email_with_tmx_recs, in_mod);

  // keep max results requested
  ds_results_chsn := UNGROUP(TOPN(GROUP(email_recs_srtd, acctno), in_mod.MaxResultsPerAcct, acctno));


  // masking
  ssn_mask_use := IF(in_mod.isDirectMarketing(), Suppress.Constants.SSN_MASK_TYPE.ALL, in_mod.ssn_mask);
  Suppress.Mac_mask(ds_results_chsn, ds_results_best_ssnmasked, bestinfo.ssn, null, TRUE, FALSE, maskVal:=ssn_mask_use);
  Suppress.Mac_mask(ds_results_best_ssnmasked, ds_results_clean_ssnmasked,cleaned.clean_ssn, null, TRUE, FALSE, maskVal:=ssn_mask_use);
  Suppress.Mac_mask(ds_results_clean_ssnmasked, ds_results_ssnmasked,original.ssn, null, TRUE, FALSE, maskVal:=ssn_mask_use);

  dob_mask_use := IF(in_mod.isDirectMarketing(), Suppress.Constants.datemask.ALL, in_mod.dob_mask);
  ds_results_ssndob_masked := PROJECT(ds_results_ssnmasked, $.Transforms.ApplyDobMask(LEFT,dob_mask_use));

  // combine results and rejected input
  ds_results_ready := ds_results_ssndob_masked + ds_rejected_input_email;


  //OUTPUT(email_ddpd_recs, NAMED('email_ddpd_recs'));
  //OUTPUT(email_recs_srtd, NAMED('email_recs_srtd'));
  //OUTPUT(ds_results_chsn, NAMED('ds_results_chsn'));

  email_gw_royalties := IF(in_mod.CheckEmailDeliverable, email_recs_valdtd.Royalties);
  result_row := ROW({ds_results_ready, email_gw_royalties}, $.Layouts.email_combined_rec);

  RETURN result_row;
END;
