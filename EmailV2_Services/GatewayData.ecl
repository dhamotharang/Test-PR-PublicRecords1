IMPORT $, Doxie, Gateway, Royalty, STD;

EXPORT GatewayData := MODULE

  CheckDomainStatus(DATASET($.Layouts.email_final_rec) in_emails) := FUNCTION 

    ds_domains := PROJECT(in_emails, 
                          TRANSFORM($.Layouts.domain_rec,
                                    SELF.email_domain := LEFT.email_domain,
                                    SELF:=[]));
    domain_statuses := $.Raw.GetDomainStatus(ds_domains);

    // TODO: we might need to consider expire/last check dates?
    with_domain_status := JOIN(in_emails, domain_statuses, 
                               LEFT.email_domain=RIGHT.email_domain,
                               TRANSFORM($.Layouts.email_final_rec, 
                                         // we populate status only if domain is invalid
                                         invalid_domain := $.Constants.isUndeliverableEmail(RIGHT.domain_status); 
                                         accept_all_domain := RIGHT.accept_all; 
                                         SELF.email_status := MAP(invalid_domain => RIGHT.domain_status,
                                                                  accept_all_domain => $.Constants.DomainAcceptAll,
                                                                   ''), 
                                         SELF.email_status_reason := IF(invalid_domain,$.Constants.GatewayValues.get_error_desc($.Constants.GatewayValues.EMAIL_DOMAIN_INVALID), ''), 
                                         SELF:=LEFT),
                               LEFT OUTER, KEEP(1), LIMIT(0));

    RETURN with_domain_status;
  END;

  GetBVhistory(DATASET($.Layouts.email_final_rec) in_emails) := FUNCTION 

    prior_month_date := (STRING8) STD.Date.AdjustDate(STD.Date.Today(), 0,-1,0);
    emails_for_hist := DEDUP(PROJECT(in_emails(cleaned.clean_email!='', email_status=''), TRANSFORM($.Layouts.Gateway_Data.batch_in_bv_rec,
                                                        SELF.email := TRIM(LEFT.cleaned.clean_email,ALL))
                                      ), ALL);
    all_events := $.Raw.GetEventHistory(emails_for_hist,$.Constants.GatewayValues.SourceBV); 

    // for email addresses found in events key we keep only up to 1 month old data for addresses previously known to be valid
    // BV data older than 1 month need to be re-checked unless email address is invalid or domain accepts all incoming emails
    latest_events := all_events(date_added >= prior_month_date OR (~$.Constants.isValid(email_status) AND ~$.Constants.isUnknown(email_status)));
 
    srtd_events := GROUP(SORT(latest_events, email, -date_added, email_status_reason, -email_status), email);
    // we only need 1 latest status for each email address
    top_events := TOPN(srtd_events, 1, -date_added);
    email_events := JOIN(in_emails,UNGROUP(top_events), 
                        LEFT.cleaned.clean_email=RIGHT.email,
                        TRANSFORM($.Layouts.email_final_rec,
                              error_desc := $.Constants.GatewayValues.get_error_desc(RIGHT.error_code);
                              SELF.email_status_reason := MAP(error_desc<>''=> error_desc, 
                                                              RIGHT.email_status_reason<>'' => RIGHT.email_status_reason,
                                                              LEFT.email_status_reason),
                              SELF.additional_status_info := MAP(RIGHT.is_disposable_address AND RIGHT.is_role_address => $.Constants.GatewayValues.RoleAddress+' / '+$.Constants.GatewayValues.DisposableAddress,
                                                                 RIGHT.is_role_address => $.Constants.GatewayValues.RoleAddress,
                                                                 RIGHT.is_disposable_address => $.Constants.GatewayValues.DisposableAddress,
                                                                 LEFT.additional_status_info),
                              SELF.email_status := IF(RIGHT.email_status<>'', RIGHT.email_status, LEFT.email_status),
                              SELF := LEFT),
                              LEFT OUTER,
                              KEEP(1), LIMIT(0));

    RETURN email_events;
  END;

  GetBVDeltabase(DATASET($.Layouts.Gateway_Data.batch_in_bv_rec) in_emails,
                            DATASET(Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway, 
                            UNSIGNED1 gw_timeout = $.Constants.GatewayValues.requestTimeout, 
                            UNSIGNED1 gw_retries = $.Constants.GatewayValues.requestRetries):= FUNCTION

    earliest_date := STD.Date.AdjustDate(STD.Date.Today(), -1,0,0);
    
    Gateway.Layouts.DeltabaseSQL.input_rec xfSelect($.Layouts.Gateway_Data.batch_in_bv_rec l) := TRANSFORM            
      prepared_select := 'SELECT ' +
                     'date_added, email_address, source, status, disposable,role_address,' + 
                     'ifnull(error_code,\'NA\') as error_code,ifnull(error,\'\') as error,account,domain ' +
                     'FROM delta_phonefinder.delta_email_gateway ' +
                     'WHERE email_address = ? AND Date_Added >= \'' + earliest_date +
                           '\' AND source =\'' + $.Constants.GatewayValues.SourceBriteVerifyEmail + '\' ' +
                     'ORDER BY Date_Added DESC ' +                   
                     'LIMIT ' + $.Constants.GatewayValues.SQLSelectLimit; 
                     
     bind_variable := STD.Str.ToLowerCase(l.email); 
     SELF.Select := prepared_select;
     SELF.Parameters := DATASET([{bind_variable}], Gateway.Layouts.DeltabaseSQL.value_rec);
    END;
    
    select_stmnts := PROJECT(in_emails(email != ''), xfSelect(LEFT));
    
    db_url := TRIM(gateways(Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

    gw_deltabase_res := Gateway.SoapCall_DeltabaseSQL(select_stmnts, db_url, gw_timeout, gw_retries, $.Layouts.Gateway_Data.bv_history_response_rec);
      
    gw_history_recs := PROJECT(DEDUP(SORT(gw_deltabase_res.Records, email_address, -date_added), email_address),
                               $.Transforms.xfBVDeltabaseResp(LEFT));

    //OUTPUT(select_stmnts, NAMED('select_stmnts'), EXTEND);
    //OUTPUT(gw_deltabase_res, NAMED('gw_deltabase_res'), EXTEND);
    
    RETURN gw_history_recs;
  END;
  
  GetBVGatewayData(DATASET($.Layouts.Gateway_Data.batch_in_bv_rec) in_emails,
                          $.IParams.EmailParams in_mod,
                          UNSIGNED1 gw_timeout = $.Constants.GatewayValues.requestTimeout, 
                          UNSIGNED1 gw_retries = $.Constants.GatewayValues.requestRetries):= FUNCTION
                          
    ds_bw_gw_request := PROJECT(in_emails, $.Transforms.xfBVSoapRequest(LEFT, in_mod.BVAPIkey));                      
    ds_bw_gw_response := Gateway.Soapcall_BriteVerify(ds_bw_gw_request, in_mod.gateways, in_mod.CheckEmailDeliverable AND in_mod.BVAPIkey != '');    
    
    // now process/transform results and count Royalties
    ds_bv_royalties := Royalty.RoyaltyBriteverify.GetRoyalties(ds_bw_gw_response);
    
    ds_bw_gw_recs := PROJECT(ds_bw_gw_response(_header.status=Gateway.Constants.defaults.STATUS_SUCCESS), 
                             $.Transforms.xfBVSoapResp(LEFT));

    combined_rec := RECORD
      DATASET($.Layouts.Gateway_Data.bv_history_rec) BVRecords;
      DATASET(Royalty.Layouts.Royalty)  BVRoyalties;
    END;
    
    ds_bw_gw_res := ROW({ds_bw_gw_recs, ds_bv_royalties}, combined_rec);    
    
    //OUTPUT(ds_bw_gw_response, NAMED('ds_bw_gw_response'), EXTEND);
    
    RETURN ds_bw_gw_res;
  END;                        

  EXPORT VerifyDeliveryStatus(DATASET($.Layouts.email_final_rec) ds_batch_in,
                              $.IParams.EmailParams in_mod,
                              DATASET($.Layouts.batch_in_rec) in_emails = DATASET([],$.Layouts.batch_in_rec)) := FUNCTION
  
    is_BV_allowed := ~Doxie.Compliance.isBriteVerifyRestricted(in_mod.DataRestrictionMask);

    // For EAA search type the best email candidates are taken from ds_batch_in results based on sorting, 
    // we limit the number of emails we check per account based on input MaxEmailsForDeliveryCheck.
    // For EIA/EIC we check all cleaned emails coming from input (one per account), even if we didn't find results for it

    // For EIA/EIC we will have in_emails dataset to identify emails which are not found in the results
    input_only_emails := JOIN(in_emails, ds_batch_in, LEFT.acctno=RIGHT.acctno, 
                                 TRANSFORM($.Layouts.email_final_rec, 
                                            SELF.cleaned.clean_email:=LEFT.email_username+'@'+LEFT.email_domain,
                                            SELF:=LEFT,
                                            SELF:=[]),
                                 LEFT ONLY);
                                 
    ds_email_in := ds_batch_in + input_only_emails;

    // we need to check in domain lookup first to identify invalid domains and populate status for those:
    ds_email_with_domain := CheckDomainStatus(ds_email_in);

    // check against historical records in keys
    // we use all email recs where status is not identified by domain for this check
    ds_email_all := IF(is_BV_allowed, GetBVHistory(ds_email_with_domain), ds_email_with_domain); 
    
    // now we filter out emails with invalid status or domains accepting all incoming emails as these emails won't be sent for BV verification GW calls
    with_domain_fltrd := ds_email_all(~$.Constants.isUndeliverableEmail(email_status)
                                       ANd ~$.Constants.isUnverifiableEmail(email_status));

    // we only need to send unique, cleaned, and properly formatted email addresses for delivery status validation
    ds_batch_clnd := IF($.Constants.SearchType.isEAA(in_mod.SearchType), 
                        with_domain_fltrd(email_quality_mask & BNOT($.Constants.EmailQualityRulesForBVCall) = 0),
                        with_domain_fltrd);  // for email searches initiated by input email address cleaning/formatting is already checked

    // we need to sort results to pick the best for delivery check
    ds_email_srtd := $.Functions.SortResults(ds_batch_clnd, in_mod);
    ds_email_chsn := UNGROUP(TOPN(GROUP(ds_email_srtd, acctno), in_mod.MaxEmailsForDeliveryCheck, acctno));
    
    // we keep emails for delivery check where we have no status from domain/events lookup
    ds_batch_ddpd := DEDUP(PROJECT(ds_email_chsn(email_status=''), 
                           TRANSFORM($.Layouts.Gateway_Data.batch_in_bv_rec,
                                     SELF.email := TRIM(LEFT.cleaned.clean_email,ALL))
                                      ), ALL);
                                                        
    // then we check against historical records in deltabase
    gw_deltabase_recs := IF(is_BV_allowed, GetBVDeltabase(ds_batch_ddpd, in_mod.gateways)); 
    
    ds_bw_gw_to_call := JOIN(ds_batch_ddpd, gw_deltabase_recs, LEFT.email=RIGHT.email, TRANSFORM(LEFT), LEFT ONLY);
    
    // then we make external gateway call for remaining email recs and count royalties for them  
    gw_soapcal_recs := IF(is_BV_allowed AND EXISTS(ds_bw_gw_to_call), GetBVGatewayData(ds_bw_gw_to_call, in_mod)); 
       
    // combine all BV results back with ds_email_all  appending delivery status
    all_gw_recs := gw_deltabase_recs + gw_soapcal_recs.BVRecords;
    
    ds_email_res := JOIN(ds_email_all, all_gw_recs, LEFT.cleaned.clean_email = RIGHT.email, 
                        TRANSFORM($.Layouts.email_final_rec,
                                  SELF.email_status := MAP(RIGHT.email_status<>''=> RIGHT.email_status, 
                                                           LEFT.email_status<>'' => LEFT.email_status,
                                                           $.Constants.StatusUnknown), 
                                  SELF.additional_status_info := IF(RIGHT.additional_status_info<>'',RIGHT.additional_status_info,LEFT.additional_status_info), 
                                  SELF.email_status_reason := IF(RIGHT.email_status_reason<>'',RIGHT.email_status_reason,LEFT.email_status_reason),
                                  SELF := LEFT), 
                         KEEP(1), LIMIT(0),
                         LEFT OUTER);
    
    // now we filter undeliverable emails if requested
    //Per req.#6 of EMAIL-123: 
    // In all cases, email addresses deemed invalid based on flags within the email base file, 
    // or based on "invalid domain" status from the Domain Lookup, 
    //will be treated the same as if BV returned an invalid status; 
    // they will be removed from Email Address Append results if the option to remove invalid email addresses is turned on.

    filter_undeliverable := ~in_mod.KeepUndeliverableEmail AND $.Constants.SearchType.isEAA(in_mod.SearchType);
    ds_email_fltrd_res := IF(filter_undeliverable, 
                             ds_email_res(~$.Constants.isUndeliverableEmail(email_status)
                             AND (email_quality_mask & BNOT($.Constants.EmailQualityRulesForBVCall) = 0)),  // filtering  email addresses deemed invalid based on flags within the email base file
                             ds_email_res);
    
    // return results plus BV royalties
    gw_royalties := Royalty.GetBatchRoyalties(PROJECT(gw_soapcal_recs.BVRoyalties, TRANSFORM(Royalty.Layouts.RoyaltyForBatch, SELF:=LEFT, SELF:=[]))); 
 
    combined_resp := ROW({ds_email_fltrd_res, gw_royalties}, $.Layouts.email_combined_rec);
    
    //OUTPUT(ds_email_all, NAMED('ds_email_with_domains'), EXTEND);
    //OUTPUT(ds_batch_ddpd, NAMED('ds_batch_selected'), EXTEND);
    //OUTPUT(bv_hist_recs, NAMED('bv_hist_recs'), EXTEND);
    //OUTPUT(gw_deltabase_recs, NAMED('gw_deltabase_recs'), EXTEND);
    //OUTPUT(gw_soapcal_recs.BVRecords, NAMED('gw_soapcal_recs'), EXTEND);
    RETURN combined_resp;
  END;


END;
