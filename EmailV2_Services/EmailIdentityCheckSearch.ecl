IMPORT $, email_data, Suppress;

EXPORT EmailIdentityCheckSearch(DATASET($.Layouts.batch_in_rec) batch_in,
                                 $.IParams.EmailParams in_mod
) := FUNCTION
                      
  // clean input email first
  marked_input_Email_recs := PROJECT(batch_in, $.Transforms.cleanEmailAddress(LEFT));  
                                    
  clnd_input_email := PROJECT(marked_input_Email_recs(~is_rejected_rec),$.Layouts.batch_in_rec);
  
  // now check PII input  
  marked_input_recs := PROJECT(clnd_input_email, $.Transforms.checkIdentityInput(LEFT));  
                                    
  clnd_input_pii := PROJECT(marked_input_recs(~is_rejected_rec),$.Layouts.batch_in_rec);
  
  ds_rejected_input_email := PROJECT(marked_input_Email_recs(is_rejected_rec) + marked_input_recs(is_rejected_rec), 
                                  TRANSFORM($.Layouts.email_final_rec, 
                                            SELF := LEFT,
                                            SELF := []));

  // attach resolved LexId as subject_lexId
  clnd_input_with_lexids := $.Functions.AppendSubjectLexid(clnd_input_pii);
  
  // get data from payload, apply filtering and rollup
  email_ddpd_recs := $.Functions.getEmailData(clnd_input_with_lexids, in_mod, $.Constants.SearchBy.ByEmail);
  
  // calculate num_did_per_email and num_email_per_did
  email_with_num_did_recs := $.Functions.CalculateLexIdsPerEmail(email_ddpd_recs,in_mod);
  email_with_num_recs := $.Functions.CalculateEmailsPerLexid(email_with_num_did_recs,in_mod);

  // add best info
  email_with_best_recs := $.Functions.AddBestInfo(email_with_num_recs,in_mod);
  
  // check email delivery status
  email_recs_valdtd := $.EmailGatewayData.VerifyDeliveryStatus(email_with_best_recs, in_mod, clnd_input_email);
  email_recs_ready := IF(in_mod.CheckEmailDeliverable, email_recs_valdtd.Records,
                          email_with_best_recs);

  // sort results to push up best emails before applying maxresults
  email_recs_srtd := $.Functions.SortResults(email_recs_ready, in_mod);
  
  // keep max results requested
  ds_results_chsn := UNGROUP(TOPN(GROUP(email_recs_srtd, acctno), in_mod.MaxResultsPerAcct, acctno));
 
  // add relationship info
  ds_results_with_relations := $.Functions.AddIdentityRelationship(ds_results_chsn, clnd_input_with_lexids, in_mod);

  // masking
  Suppress.Mac_mask(ds_results_with_relations, ds_results_best_ssnmasked, bestinfo.ssn, null, TRUE, FALSE, maskVal:=in_mod.ssn_mask);
  Suppress.Mac_mask(ds_results_best_ssnmasked, ds_results_clean_ssnmasked,cleaned.clean_ssn, null, TRUE, FALSE, maskVal:=in_mod.ssn_mask);
  Suppress.Mac_mask(ds_results_clean_ssnmasked, ds_results_ssnmasked,original.ssn, null, TRUE, FALSE, maskVal:=in_mod.ssn_mask);


  // combine results and rejected input 
  // final sorting for output
  ds_results_ready := $.Functions.SortResults(ds_results_ssnmasked + ds_rejected_input_email, in_mod);
  

  //OUTPUT(email_ddpd_recs, NAMED('email_ddpd_recs'));
  //OUTPUT(email_recs_srtd, NAMED('email_recs_srtd'));
  //OUTPUT(ds_results_chsn, NAMED('ds_results_chsn'));

  email_gw_royalties := IF(in_mod.CheckEmailDeliverable, email_recs_valdtd.Royalties);
  result_row := ROW({ds_results_ready, email_gw_royalties}, $.Layouts.email_combined_rec);

  RETURN result_row;
END;
