IMPORT $, Doxie, Gateway, Royalty, STD, ThreatMetrix;

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
                                         inactive_domain := RIGHT.domain_status=$.Constants.DomainInactive;
                                         accept_all_domain := RIGHT.accept_all;
                                         _email_status     := MAP(invalid_domain OR inactive_domain => $.Constants.StatusInvalid,
                                                                  accept_all_domain => $.Constants.DomainAcceptAll,
                                                                   '');
                                         SELF.email_status := _email_status,
                                         SELF.email_status_reason := MAP(
                                                    invalid_domain =>
                                                     $.Constants.GatewayValues.get_error_desc($.Constants.GatewayValues.EMAIL_DOMAIN_INVALID),
                                                    inactive_domain =>
                                                     $.Constants.GatewayValues.get_error_desc($.Constants.GatewayValues.DOMAIN_INACTIVE),
                                                    ''),
                                         SELF.date_last_verified := IF(_email_status<>'', RIGHT.date_last_verified,''),
                                         SELF:=LEFT),
                               LEFT OUTER, KEEP(1), LIMIT(0));

    RETURN with_domain_status;
  END;

  GetBVDeltabase(DATASET($.Layouts.Gateway_Data.batch_in_gw_rec) in_emails,
                            DATASET(Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway,
                            UNSIGNED1 gw_timeout = $.Constants.GatewayValues.requestTimeout,
                            UNSIGNED1 gw_retries = $.Constants.GatewayValues.requestRetries):= FUNCTION

    earliest_date := STD.Date.AdjustDate(STD.Date.Today(), -1,0,0);

    prepared_select_prefix := 'SELECT ' +
                     'date_added, email_address, source, status, disposable,role_address,' +
                     'ifnull(error_code,\'NA\') as error_code,ifnull(error,\'\') as error,account,domain ' +
                     'FROM delta_phonefinder.delta_email_gateway ' +
                     'WHERE email_address IN ( ';

    prepared_select_suffix := ' ) AND Date_Added >= \'' + earliest_date +
                           '\' AND source =\'' + $.Constants.GatewayValues.SourceBriteVerifyEmail + '\' ' +
                     'ORDER BY Date_Added DESC ' +
                     'LIMIT ' + $.Constants.GatewayValues.SQLSelectLimit;

    Gateway.Layouts.DeltabaseSQL.input_rec xfSelect(DATASET($.Layouts.Gateway_Data.batch_in_gw_rec) emls) := TRANSFORM
      prepared_select_criteria := STD.Str.RemoveSuffix(STD.Str.Repeat( '?,', COUNT(emls)), ',');

      SELF.Select := prepared_select_prefix + prepared_select_criteria + prepared_select_suffix;
      SELF.Parameters := PROJECT(emls, TRANSFORM(Gateway.Layouts.DeltabaseSQL.value_rec, SELF.value := STD.Str.ToLowerCase(LEFT.email)));
    END;

    in_emails_grpd := GROUP(SORT(in_emails(email != ''), group_no, rec_no), group_no);
    select_stmnts := ROLLUP(in_emails_grpd, GROUP, xfSelect(ROWS(LEFT)));  // rolling to single sql statement per group of 10 email addresses to check

    db_url := TRIM(gateways(Gateway.Configuration.IsPhoneMetadata(ServiceName))[1].URL, LEFT, RIGHT);

    gw_deltabase_res := Gateway.SoapCall_DeltabaseSQL(select_stmnts, db_url, gw_timeout, gw_retries, $.Layouts.Gateway_Data.bv_history_response_rec);

    gw_history_recs := PROJECT(DEDUP(SORT(gw_deltabase_res.Records, email_address, -date_added), email_address),
                               $.Transforms.xfBVDeltabaseResp(LEFT));

    //OUTPUT(select_stmnts, NAMED('select_stmnts'), EXTEND);
    //OUTPUT(gw_deltabase_res, NAMED('gw_deltabase_res'), EXTEND);

    RETURN gw_history_recs;
  END;

  GetBVhistory(DATASET($.Layouts.email_final_rec) in_emails, $.IParams.EmailParams in_mod) := FUNCTION

    today := STD.Date.Today();
    prior_year_date := (STRING8) STD.Date.AdjustDate(today, -1,0,0);
    isPremiumSearch := in_mod.CheckEmailDeliverable;
    oldest_date := IF(isPremiumSearch, prior_year_date, '');  // for premium we will be using BV gw, and we re-check statuses older than 1year
    prior_month_date := (STRING8) STD.Date.AdjustDate(today, 0,-1,0);
    prior_3month_date := (STRING8) STD.Date.AdjustDate(today, 0,0,-90);

    emails_for_hist := DEDUP(PROJECT(in_emails(cleaned.clean_email!='' AND (email_status='' OR (date_last_verified < prior_3month_date AND $.Constants.isUnverifiableEmail(email_status)))),
                                    TRANSFORM($.Layouts.Gateway_Data.batch_in_gw_rec,
                                              SELF.email := TRIM(LEFT.cleaned.clean_email,ALL))
                                      ), ALL);

    all_events := $.Raw.GetEventHistory(emails_for_hist, $.Constants.GatewayValues.SourceBV, oldest_date); //we keep emails without history in results here

    srtd_events := GROUP(SORT(all_events(email_status<>''), email, -date_added, email_status_reason, -email_status), email);
    // we only need 1 latest status for each email address
    top_events := TOPN(srtd_events, 1, -date_added);

    // separate latest from older which we attempt to recheck
    // we are not re-validating invalid emails or emails with status=accept_all verified within past 90 days
    //latest_events := top_events(date_added >= prior_month_date OR (~$.Constants.isValid(email_status) AND ~$.Constants.isUnknown(email_status)));
    latest_events := top_events(date_added >= prior_month_date OR $.Constants.isUndeliverableEmail(email_status)
                      OR (date_added >= prior_3month_date AND $.Constants.isUnverifiableEmail(email_status)));
    // BV data older than 1 month need to be re-checked unless email address is invalid or status of domain accepts all incoming emails was checked more than 90 days back
    recheck_events := UNGROUP(top_events(date_added < prior_month_date AND ($.Constants.isValid(email_status) OR $.Constants.isUnknown(email_status))
                              OR (date_added < prior_3month_date AND $.Constants.isUnverifiableEmail(email_status))  // per req. EMAIL-234 we now re-check accept_all older than 90 days
                              ));

    db_check_emails := PROJECT(recheck_events + all_events(email_status=''), // the email addresses are already deduped
                           TRANSFORM($.Layouts.Gateway_Data.batch_in_gw_rec,
                                     SELF.email := TRIM(LEFT.email,ALL),
                                     SELF.rec_no := COUNTER,
                                     SELF.group_no := COUNTER DIV $.Constants.GatewayValues.MaxSQLBindVariables  // separating on groups of 10
                                     ));

    // then we check against historical records in deltabase
    deltabase_recs := IF(EXISTS(db_check_emails), GetBVDeltabase(db_check_emails, in_mod.gateways)(email_status<>''));

    //now we combine db recs with older recs where we have status and pick the latest per email address
    srtd_db_hist_events := GROUP(SORT(deltabase_recs+recheck_events, email, -date_added, email_status_reason, -email_status), email);
    // we only need 1 latest status for each email address
    all_latest_events := latest_events + TOPN(srtd_db_hist_events, 1, -date_added);

    email_events := JOIN(in_emails,UNGROUP(all_latest_events),
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
                              SELF.email_status := MAP(RIGHT.email_status<>''=> RIGHT.email_status,
                                                           LEFT.email_status<>'' => LEFT.email_status,
                                                           $.Constants.StatusUnknown),
                              SELF.date_last_verified := IF(RIGHT.date_added<>'', RIGHT.date_added, LEFT.date_last_verified),
                              SELF := LEFT),
                              LEFT OUTER,
                              KEEP(1), LIMIT(0));

    //OUTPUT(top_events, NAMED('bv_hist_recs'), EXTEND);
    //OUTPUT(recheck_events, NAMED('events_to_recheck'), EXTEND);
    //OUTPUT(db_check_emails, NAMED('plus_unknown_to_recheck'), EXTEND);
    //OUTPUT(deltabase_recs, NAMED('gw_deltabase_recs'), EXTEND);
    //OUTPUT(all_latest_events, NAMED('combined_latest_events'), EXTEND);
    RETURN email_events;
  END;

  EXPORT AddStatusFromHistory(DATASET($.Layouts.email_final_rec) ds_batch_in,
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

    ds_email_in := ds_batch_in + IF($.Constants.SearchType.isEIA(in_mod.SearchType), input_only_emails);  // for EIC if we didn't findPII based on email address, we cannot check identity

    // we need to check in domain lookup first to identify invalid domains and populate status for those:
    ds_email_with_domain := CheckDomainStatus(ds_email_in);

    // check against historical records in keys and DeltaBase
    // we use all email recs where status is not identified by domain for this check
    ds_email_all := IF(is_BV_allowed, GetBVHistory(ds_email_with_domain, in_mod), ds_email_with_domain);

    //OUTPUT(ds_email_with_domain, NAMED('ds_email_with_domains'), EXTEND);
    RETURN ds_email_all;
  END;

  SHARED GetBVGatewayData(DATASET($.Layouts.Gateway_Data.batch_in_gw_rec) in_emails,
                          $.IParams.EmailParams in_mod,
                          UNSIGNED1 gw_timeout = $.Constants.GatewayValues.requestTimeout,
                          UNSIGNED1 gw_retries = $.Constants.GatewayValues.requestRetries):= FUNCTION

    ds_bw_gw_request := PROJECT(in_emails, $.Transforms.xfBVSoapRequest(LEFT, in_mod.BVAPIkey));
    ds_bw_gw_response := Gateway.Soapcall_BriteVerify(ds_bw_gw_request, in_mod.gateways,
                                      in_mod.CheckEmailDeliverable AND in_mod.BVAPIkey != '',
                                      num_threads := $.Constants.Defaults.MaxEmailsToCheckDeliverable);  // -numthreads to be used with Parallel option in Soapcall

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

  SHARED GetEAGatewayData(DATASET($.Layouts.Gateway_Data.batch_in_gw_rec) in_emails,
                   $.IParams.EmailParams in_mod,
                   UNSIGNED1 gw_timeout = $.Constants.GatewayValues.EA_GW_TIMEOUT,
                   UNSIGNED1 gw_retries = $.Constants.GatewayValues.requestRetries,
                   UNSIGNED1 gw_threads = $.Constants.Defaults.MaxEmailsToCheckDeliverable) := FUNCTION

    gateway_cfg := in_mod.gateways(Gateway.Configuration.IsEmailRisk(servicename))[1];
    make_gw_call := in_mod.CheckEmailDeliverable AND $.Constants.isEmailageValidation(in_mod.EmailValidationType);
    version := CASE(in_mod.EmailValidationType,
      $.Constants.EmailValidationType.EmailageBasic => $.Constants.Basic,
      $.Constants.EmailValidationType.EmailagePremium => $.Constants.Premium,
      ''
    );

    ds_ea_gw_request := PROJECT(in_emails, $.Transforms.xfEASoapRequest(LEFT, version));

    ds_ea_gw_response := IF(make_gw_call, Gateway.SoapCall_EmailRisk(ds_ea_gw_request, gateway_cfg, make_gw_call, gw_timeout, gw_retries, gw_threads));
    ds_ea_gw_recs := PROJECT(ds_ea_gw_response, $.Transforms.xfEASoapResults(LEFT));

    ds_ea_royalties := Royalty.RoyaltyEmailRisk.GetRoyalties(ds_ea_gw_response(_header.status = Gateway.Constants.defaults.STATUS_SUCCESS AND
      EmailRiskResponseData.Results[1].Status <> $.Constants.GatewayValues.EA_ERROR)); // EA may return an error as part of a successful soap response

    combined_rec := RECORD
      DATASET($.Layouts.Gateway_Data.ea_result_rec) EARecords;
      DATASET(Royalty.Layouts.Royalty) EARoyalties;
    END;

    ds_ea_gw_res := ROW({ds_ea_gw_recs, ds_ea_royalties}, combined_rec);

    RETURN ds_ea_gw_res;

  END;

  SHARED VerifyDeliveryStatusBV(DATASET($.Layouts.email_final_rec) ds_email_in,
                              $.IParams.EmailParams in_mod) := FUNCTION

    is_BV_allowed := ~Doxie.Compliance.isBriteVerifyRestricted(in_mod.DataRestrictionMask);
    today := STD.Date.Today();
    prior_month_date := (STRING8) STD.Date.AdjustDate(today, 0,-1,0);
    prior_3month_date := (STRING8) STD.Date.AdjustDate(today, 0,0,-90);

    // for Premium search  (checkEmailDelivery=True) we attempt to make BV GW call and need to pick data for that
    // we filter out emails with invalid status or domains accepting all incoming emails as these emails won't be sent for BV verification GW calls
    with_domain_fltrd := IF(in_mod.CheckEmailDeliverable, ds_email_in(~$.Constants.isUndeliverableEmail(email_status)
                                       AND (~$.Constants.isUnverifiableEmail(email_status) OR date_last_verified < prior_3month_date)
                                       ));

    // we only need to send unique, cleaned, and properly formatted email addresses for delivery status validation
    ds_batch_clnd := IF($.Constants.SearchType.isEAA(in_mod.SearchType),
                        with_domain_fltrd(email_quality_mask & BNOT($.Constants.EmailQualityRulesForBVCall) = 0),
                        with_domain_fltrd);  // for email searches initiated by input email address cleaning/formatting is already checked

    // if CheckEmailDelivery=True  - we use BV GW to update status
    // BV data older than 1 month need to be re-checked
    // we keep emails for delivery check where we have no status from domain/events lookup
    ds_email_to_check := ds_batch_clnd(date_last_verified < prior_month_date OR email_status=''
                                       OR ($.Constants.isUnknown(email_status) AND date_last_verified='')
                                       OR ($.Constants.isUnverifiableEmail(email_status) AND date_last_verified < prior_3month_date) // per req. EMAIL-234 we now re-check accept_all status older than 90 days
                                       );

    // we need to sort results to pick the best for GW delivery check
    ds_email_srtd := $.Functions.SortResults(ds_email_to_check, in_mod);
    ds_email_chsn := UNGROUP(TOPN(GROUP(ds_email_srtd, acctno), in_mod.MaxEmailsForDeliveryCheck, acctno));

    ds_bw_gw_to_call := DEDUP(PROJECT(ds_email_chsn,
                           TRANSFORM($.Layouts.Gateway_Data.batch_in_gw_rec,
                                     SELF.email := TRIM(LEFT.cleaned.clean_email,ALL))
                                      ), ALL);


    // then we make external gateway call for remaining email recs and count royalties for them
    gw_soapcal_recs := IF(is_BV_allowed AND EXISTS(ds_bw_gw_to_call), GetBVGatewayData(ds_bw_gw_to_call, in_mod));

    // combine all BV results back with ds_email_in  appending delivery status
    all_gw_recs := gw_soapcal_recs.BVRecords;

    ds_email_res := JOIN(ds_email_in, all_gw_recs,
                        LEFT.cleaned.clean_email = RIGHT.email,
                        TRANSFORM($.Layouts.email_final_rec,
                                  SELF.email_status := MAP(RIGHT.email_status<>''=> RIGHT.email_status,
                                                           LEFT.email_status<>'' => LEFT.email_status,
                                                           $.Constants.StatusUnknown),
                                  SELF.additional_status_info := IF(RIGHT.additional_status_info<>'',RIGHT.additional_status_info,LEFT.additional_status_info),
                                  SELF.email_status_reason := IF(RIGHT.email_status_reason<>'',RIGHT.email_status_reason,LEFT.email_status_reason),
                                  SELF.date_last_verified := IF(RIGHT.email_status<>'', (STRING8) today, LEFT.date_last_verified),
                                  SELF := LEFT),
                         KEEP(1), LIMIT(0),
                         LEFT OUTER);


    // return results plus BV royalties
    gw_royalties := Royalty.GetBatchRoyalties(PROJECT(gw_soapcal_recs.BVRoyalties, TRANSFORM(Royalty.Layouts.RoyaltyForBatch, SELF:=LEFT, SELF:=[])));

    combined_resp := ROW({ds_email_res, gw_royalties}, $.Layouts.email_combined_rec);

    //OUTPUT(ds_batch_clnd, NAMED('ds_batch_cleaned'), EXTEND);
    //OUTPUT(ds_bw_gw_to_call, NAMED('ds_batch_selected'), EXTEND);
    //OUTPUT(gw_soapcal_recs.BVRecords, NAMED('gw_soapcal_recs'), EXTEND);
    RETURN combined_resp;
  END;

  SHARED VerifyDeliveryStatusEA(DATASET($.Layouts.email_final_rec) ds_email_in, $.IParams.EmailParams in_mod) := FUNCTION

    is_EA_allowed := ~in_mod.isDirectMarketing();
    ds_email_fltr := ds_email_in(~$.Constants.isUndeliverableEmail(email_status)); // exclude non-deliverable emails based on email_status
    ds_email_srtd := $.Functions.SortResults(ds_email_fltr, in_mod);
    ds_email_chsn := UNGROUP(TOPN(GROUP(ds_email_srtd, acctno), in_mod.MaxEmailsForDeliveryCheck, acctno));

    ds_email_gw := PROJECT(ds_email_chsn, TRANSFORM($.Layouts.Gateway_Data.batch_in_gw_rec, SELF.email := TRIM(LEFT.cleaned.clean_email, ALL)));
    ds_gw_data := IF(is_EA_allowed AND EXISTS(ds_email_gw), GetEAGatewayData(DEDUP(ds_email_gw, ALL), in_mod));

    ds_email_res := JOIN(ds_email_in, ds_gw_data.EARecords,
                         LEFT.cleaned.clean_email = RIGHT.email,
                         TRANSFORM($.Layouts.email_final_rec,
                           // In case of general error from ea, overwrite email_status, email_status_reason to unknown, '' respectively
                           isGeneralError := STD.Str.ToUpperCase(RIGHT.email_status) = $.Constants.GatewayValues.EA_ERROR;
                           ea_email_exist := RIGHT.email_exists;
                           ea_email_status := RIGHT.email_status;
                           mapped_email_status := $.Constants.GatewayValues.get_ea_email_status(ea_email_exist, ea_email_status);
                           mapped_email_status_reason := $.Constants.GatewayValues.get_ea_email_status_reason(ea_email_status);
                           SELF.ea_email_exist := ea_email_exist,
                           SELF.ea_email_status := ea_email_status,
                           // email_exists from emailage is translated to email_status if available
                           SELF.email_status := MAP(isGeneralError => $.Constants.StatusUnknown,
                                                    ea_email_exist <> '' AND mapped_email_status <> '' => mapped_email_status,
                                                    LEFT.email_status <> '' => LEFT.email_status,
                                                    $.Constants.StatusUnknown),
                           // email_status from emailage is translated to email_status_reason if available
                           SELF.email_status_reason := MAP(isGeneralError => '',
                                                           ea_email_status <> '' => mapped_email_status_reason,
                                                           LEFT.email_status_reason),
                           SELF.date_last_verified := IF(ea_email_exist <> '', (STRING8) STD.Date.Today(), LEFT.date_last_verified),
                           SELF := LEFT),
                         KEEP(1), LIMIT(0),
                         LEFT OUTER);
    
    gw_royalties := Royalty.GetBatchRoyalties(PROJECT(ds_gw_data.EARoyalties, TRANSFORM(Royalty.Layouts.RoyaltyForBatch, SELF := LEFT, SELF := [])));

    combined_resp := ROW({ds_email_res, gw_royalties}, $.Layouts.email_combined_rec);

    RETURN combined_resp;

  END;

  EXPORT VerifyDeliveryStatus(DATASET($.Layouts.email_final_rec) ds_email_in, $.IParams.EmailParams in_mod) := FUNCTION
    
    ds_bv_validated := VerifyDeliveryStatusBV(ds_email_in, in_mod);
    ds_ea_validated := VerifyDeliveryStatusEA(ds_email_in, in_mod);

    ds_validated := MAP(
      $.Constants.isBriteVerifyValidation(in_mod.EmailValidationType) => ds_bv_validated,
      $.Constants.isEmailageValidation(in_mod.EmailValidationType) AND in_mod.isDirectMarketing() => ds_bv_validated,
      $.Constants.isEmailageValidation(in_mod.EmailValidationType) => ds_ea_validated,
      ROW([], $.Layouts.email_combined_rec)
    );
    
    RETURN ds_validated;

  END;

  EXPORT getTMXInsights (DATASET($.Layouts.email_final_rec) ds_batch_in,
                         $.IParams.EmailParams in_mod,
                         BOOLEAN NoPIIPersistence = TRUE) := FUNCTION

    gateway_cfg  := in_mod.gateways(Gateway.Configuration.IsThreatMetrix(servicename))[1];

    indata := UNGROUP(TOPN(GROUP($.Functions.SortResults(ds_batch_in(~$.Constants.isUndeliverableEmail(email_status)),in_mod), // emails identified by BV as invalid are not processed through TMX
                                 acctno),in_mod.MaxEmailsForTMXCheck, acctno));

    // dedup email addresses
    indata_ddpd := DEDUP(SORT(indata, Cleaned.clean_email), Cleaned.clean_email);
    makeGatewayCall := in_mod.UseTMXRules AND in_mod.MaxEmailsForTMXCheck>0 AND gateway_cfg.url!='' AND COUNT(indata_ddpd)>0;

    ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest xform_TMX_request($.Layouts.email_final_rec le) := TRANSFORM
      SELF.User.QueryId := (STRING)le.seq;
      SELF.Options.TrustDefenderUserAccount.OrgId := $.Constants.GatewayValues.TMXOrgId;
      SELF.Options.TrustDefenderUserAccount.ApiKey := $.Constants.GatewayValues.TMXApiKey;
      SELF.Options.Policy := $.Constants.GatewayValues.TMXPolicy;
      SELF.Options.ServiceType := $.Constants.GatewayValues.TMXServiceType;
      SELF.Options.ApiType := $.Constants.GatewayValues.TMXApiType;
      SELF.Options.NoPIIPersistence := NoPIIPersistence;

      self.searchby.Identity.TrustDefenderAccount.AccountEmail := TRIM(le.Cleaned.clean_email, ALL);
      self := [];
    END;

    tmx_requests_in := PROJECT(indata_ddpd, xform_TMX_request(LEFT));

    tm_gw_results := IF(makeGatewayCall,
                       // the SoapCall_ThreatMetrix() is actualy calling TrustDefender ESP method, not to be confused with ThreatMetrix ESP method
                       Gateway.SoapCall_ThreatMetrix(tmx_requests_in, gateway_cfg, makeGatewayCall,
                                                     $.Constants.Defaults.MaxEmailsForTMXcheck)); // -numthreads to be used with Parallel option in Soapcall


    $.Layouts.email_final_rec xform_TMX_result($.Layouts.email_final_rec le, ThreatMetrix.gateway_trustdefender.t_TrustDefenderDetailedResponse ri) := TRANSFORM
      SELF.TMX_insights.account_email_first_seen := ri.AccountEmailFirstSeen;
      SELF.TMX_insights.account_email_last_event := ri.AccountEmailLastEvent;
      SELF.TMX_insights.account_email_last_update := ri.AccountEmailLastUpdate;
      SELF.TMX_insights.account_email_result := ri.AccountEmailResult;
      SELF.TMX_insights.account_email_score := ri.AccountEmailScore;
      SELF.TMX_insights.account_email_worst_score := ri.AccountEmailWorstScore;

      SELF.TMX_insights.digital_id := ri.DigitalId;
      SELF.TMX_insights.digital_id_confidence := ri.DigitalIdConfidence;

      SELF.TMX_insights.digital_id_first_seen := ri.DigitalIdFirstSeen;
      SELF.TMX_insights.digital_id_last_event := ri.DigitalIdLastEvent;
      SELF.TMX_insights.digital_id_last_update := ri.DigitalIdLastUpdate;
      SELF.TMX_insights.digital_id_result := ri.DigitalIdResult;

      SELF.TMX_insights.policy_score := ri.PolicyScore;
      SELF.TMX_insights.request_result := ri.RequestResult;
      SELF.TMX_insights.review_status := STD.Str.ToLowerCase(ri.ReviewStatus);
      SELF.TMX_insights.risk_rating := ri.RiskRating;
      SELF := le;
    END;

    tmx_results := JOIN(ds_batch_in, tm_gw_results,
                        TRIM(LEFT.Cleaned.clean_email) = STD.Str.ToUpperCase(TRIM(RIGHT.response._Data.AccountEmail.Content_)),
                        xform_TMX_result(LEFT, RIGHT.response._Data),
                        LEFT OUTER,
                        KEEP(1), LIMIT(0)
                       );

    // check if filtering of review_status = 'reject' is  requested and suppress as needed
    //tmx_fltrd_results := IF(in_mod.SuppressTMXRejectedEmail,tmx_results(~$.Constants.isRejectedEmail(TMX_insights.review_status)),tmx_results);
    tmx_fltrd_results := IF(in_mod.SuppressTMXRejectedEmail,tmx_results(~$.Constants.isRejectedEmail(TMX_insights.review_status)),tmx_results);

    //OUTPUT(indata, NAMED('indata'), EXTEND);
    //OUTPUT(tmx_requests_in, NAMED('tmx_requests_in'), EXTEND);
    //OUTPUT(tm_gw_results, NAMED('tm_gw_results'), EXTEND);
    //OUTPUT(tmx_results, NAMED('tmx_results'), EXTEND);

    RETURN tmx_fltrd_results;
  END;

END;
