IMPORT $, email_data,Suppress;

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
  
  // sort results to push up best emails before applying maxresults
  email_recs_srtd := $.Functions.SortResults(email_with_best_recs, in_mod);
  
  // keep max results requested
  ds_results_chsn := UNGROUP(TOPN(GROUP(email_recs_srtd, acctno), in_mod.MaxResultsPerAcct, acctno));
    

  // check email delivery status
  
    
  // masking
  Suppress.Mac_mask(ds_results_chsn, ds_results_best_ssnmasked, bestinfo.ssn, null, TRUE, FALSE, maskVal:=in_mod.ssn_mask);
  Suppress.Mac_mask(ds_results_best_ssnmasked, ds_results_clean_ssnmasked,cleaned.clean_ssn, null, TRUE, FALSE, maskVal:=in_mod.ssn_mask);
  Suppress.Mac_mask(ds_results_clean_ssnmasked, ds_results_ssnmasked,original.ssn, null, TRUE, FALSE, maskVal:=in_mod.ssn_mask);


  // combine results and rejected input 
  ds_results_ready := ds_results_ssnmasked + ds_rejected_input_email;
  
  // final sorting for output

  //OUTPUT(email_ddpd_recs, NAMED('email_ddpd_recs'));
  //OUTPUT(email_recs_srtd, NAMED('email_recs_srtd'));
  //OUTPUT(ds_results_chsn, NAMED('ds_results_chsn'));

  RETURN ds_results_ready;
END;
