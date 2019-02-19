IMPORT $, Doxie, Gateway, Royalty, STD;

EXPORT EmailGatewayData := MODULE

  GetBVhistoryDeltabase(DATASET($.Layouts.GatewayData.batch_in_bv_rec) in_emails,
                            DATASET(Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway, 
                            UNSIGNED1 gw_timeout = $.Constants.GatewayValues.requestTimeout, 
                            UNSIGNED1 gw_retries = $.Constants.GatewayValues.requestRetries):= FUNCTION

    earliest_date := STD.Date.AdjustDate(STD.Date.Today(), -1,0,0);
    
    Gateway.Layouts.DeltabaseSQL.input_rec xfSelect($.Layouts.GatewayData.batch_in_bv_rec l) := TRANSFORM            
      prepared_select := 'SELECT ' +
                     'date_added, email_address, source, status, disposable,role_address,error_code,error,account,domain ' +
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

    gw_deltabase_res := Gateway.SoapCall_DeltabaseSQL(select_stmnts, db_url, gw_timeout, gw_retries, $.Layouts.GatewayData.bv_history_response_rec);
      
    gw_history_recs := PROJECT(DEDUP(SORT(gw_deltabase_res.Records, email_address, -date_added), email_address),
                               $.Transforms.xfBVDeltabaseResp(LEFT));

    //OUTPUT(select_stmnts, NAMED('select_stmnts'), EXTEND);
    //OUTPUT(gw_deltabase_res, NAMED('gw_deltabase_res'), EXTEND);
    
    RETURN gw_history_recs;
  END;
  
  GetBVGatewayData(DATASET($.Layouts.GatewayData.batch_in_bv_rec) in_emails,
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
      DATASET($.Layouts.GatewayData.bv_history_rec) BVRecords;
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
                                 
    ds_email_all := ds_batch_in + input_only_emails;
    
    // we only need to send unique, cleaned, and properly formatted email addresses for delivery status validation
    ds_batch_clnd := ds_email_all(email_quality_mask & BNOT($.Constants.EmailQualityRulesForBVCall) = 0);

    // we need to sort results to pick the best for delivery check
    ds_email_srtd := $.Functions.SortResults(ds_batch_clnd, in_mod);
    ds_email_chsn := UNGROUP(TOPN(GROUP(ds_email_srtd, acctno), in_mod.MaxEmailsForDeliveryCheck, acctno));
    
    ds_batch_ddpd := DEDUP(PROJECT(ds_email_chsn, TRANSFORM($.Layouts.GatewayData.batch_in_bv_rec,
                                                        SELF.email := TRIM(LEFT.cleaned.clean_email,ALL))
                                      ), ALL);
                                                        
    // TO DO: check against historical records in keys
    // gw_hist_recs := 
    
    // then we check against historical records in deltabase
    gw_deltabase_recs := IF(is_BV_allowed, GetBVhistoryDeltabase(ds_batch_ddpd, in_mod.gateways)); 
    
    ds_bw_gw_to_call := JOIN(ds_batch_ddpd, gw_deltabase_recs, LEFT.email=RIGHT.email, TRANSFORM(LEFT), LEFT ONLY);
    
    // then we make external gateway call for remaining email recs and count royalties for them  
    gw_soapcal_recs := IF(is_BV_allowed AND EXISTS(ds_bw_gw_to_call), GetBVGatewayData(ds_bw_gw_to_call, in_mod)); 
       
    // combine all BV results back with ds_email_all  appending delivery status
    all_gw_recs := gw_deltabase_recs + gw_soapcal_recs.BVRecords;
    
    ds_email_res := JOIN(ds_email_all, all_gw_recs, LEFT.cleaned.clean_email = RIGHT.email, 
                        TRANSFORM($.Layouts.email_final_rec,
                                  SELF.email_status := RIGHT.email_status, 
                                  SELF.additional_status_info := RIGHT.additional_status_info, 
                                  SELF.email_status_reason := RIGHT.email_status_reason,
                                  SELF := LEFT), 
                         KEEP(1), LIMIT(0),
                         LEFT OUTER);
    
    // now we filter undeliverable emails if required
    filter_undeliverable := ~in_mod.KeepUndeliverableEmail AND $.Constants.SearchType.isEAA(in_mod.SearchType);
    ds_email_fltrd_res := IF(filter_undeliverable, 
                             ds_email_res(~$.Constants.GatewayValues.isUndeliverableEmail(email_status)),
                             ds_email_res);
    
    // return results plus BV royalties
    gw_royalties := Royalty.GetBatchRoyalties(PROJECT(gw_soapcal_recs.BVRoyalties, TRANSFORM(Royalty.Layouts.RoyaltyForBatch, SELF:=LEFT, SELF:=[]))); 
 
    combined_resp := ROW({ds_email_fltrd_res, gw_royalties}, $.Layouts.email_combined_rec);
    
    //OUTPUT(ds_batch_ddpd, NAMED('ds_batch_ddpd'), EXTEND);
    //OUTPUT(gw_deltabase_recs, NAMED('gw_deltabase_recs'), EXTEND);
    //OUTPUT(gw_soapcal_recs.BVRecords, NAMED('gw_soapcal_recs'), EXTEND);
    
    RETURN combined_resp;
  END;


END;

