IMPORT Address, Autokey_batch, BatchServices, Didville, FraudGovPlatform, FraudShared, FraudShared_Services, IDLExternalLinking,
 iesp, RiskIntelligenceNetwork_Analytics, RiskIntelligenceNetwork_Services, ut;

EXPORT SearchRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_search_in,
                     RiskIntelligenceNetwork_Services.IParam.Params search_params) := FUNCTION

 _Layout :=  RiskIntelligenceNetwork_Services.Layouts;
 _Constant := RiskIntelligenceNetwork_Services.Constants;
 _RIN_Function := RiskIntelligenceNetwork_Services.Functions;

 AddressAlonePIISearch := ds_search_in[1].did = 0 AND
                          (ds_search_in[1].name_last = '' OR  ds_search_in[1].name_first = '') AND
                          (ds_search_in[1].ssn = '') AND
                          ((ds_search_in[1].Addr <> '' OR ds_search_in[1].prim_range <> '' OR ds_search_in[1].prim_name <> '') AND
                          ((ds_search_in[1].p_city_name <> '' AND ds_search_in[1].st <> '') OR ds_search_in[1].z5 <> ''));

 // Validate Input DID by checking if it exists in Public Records.
 InputDidFoundInPR := ds_search_in[1].did <> 0 AND
                      EXISTS(IDLExternalLinking.did_getAllRecs(ds_search_in[1].did)(s_did > 0));

 // Validate if Input DID is actually a RINID.
 IsInputDidRINID := ~InputDidFoundInPR AND
                     ds_search_in[1].did > _Constant.RIN_ID_START_VALUE AND //This is the number RIN ID sequence starts in index.
                     EXISTS(FraudShared.Key_Did(_Constant.FRAUD_PLATFORM)(KEYED(did = ds_search_in[1].did)));

 // **************************************************************************************
 // FIND Public Records DID for Input PII
 // **************************************************************************************
 input_pii := PROJECT(ds_search_in,
               TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
                 SELF.did := 0,
                 SELF.homephone := LEFT.phoneno,
                 SELF := LEFT,
                 SELF := []));

 ds_pr_did := BatchServices.Functions.fn_find_dids_and_append_to_acctno(input_pii);

 ds_pr_did_final := JOIN(ds_search_in, ds_pr_did,
                      LEFT.acctno = RIGHT.acctno,
                      TRANSFORM(_Layout.dids_recs,
                       SELF.Seq := (UNSIGNED)LEFT.acctno,
                       SELF.did := MAP(InputDidFoundInPR OR IsInputDidRINID => LEFT.DID,
                                       ~IsInputDidRINID AND ~AddressAlonePIISearch => RIGHT.DID,
                                       0);
                       SELF.RecordSource := _Constant.RECORD_SOURCE.REALTIME,
                       SELF := []),
                      LEFT OUTER);

 // **************************************************************************************
 // Getting the payload records from RIN Payload key.
 // **************************************************************************************
 ds_allPayloadRecs := RiskIntelligenceNetwork_Services.fn_GetRawContributedRecs(ds_search_in, search_params);
 ds_allPayloadRecs_w_did := ds_allPayloadRecs(did > 0);
 ds_contributory_dids := PROJECT(ds_allPayloadRecs_w_did,
                          TRANSFORM(_Layout.dids_recs,
                            SELF.Seq := COUNTER,
                            SELF.RecordSource := _Constant.RECORD_SOURCE.CONTRIBUTED,
                            SELF.did := LEFT.did,
                            SELF := []));

 ds_dids_combined := sort(ds_contributory_dids + ds_pr_did_final, did, RecordSource);

 _Layout.dids_recs roll_trans(_Layout.dids_recs L, _Layout.dids_recs R) := TRANSFORM
   SELF.RecordSource := L.RecordSource,
   SELF := L
 END;

 ds_dids_combined_dedup := ROLLUP(ds_dids_combined, left.did = right.did, roll_trans(LEFT, RIGHT))(did > 0);

 //adding additional elements lexid's to ds_search_in.
 ds_dids_to_use := PROJECT(ds_dids_combined_dedup,
                     TRANSFORM(FraudShared_Services.Layouts.BatchInExtended_rec,
                      SELF.acctno := '1', //since search request is always batch of 1 record, acctno can safely be hardcoded to 1, as assigned in service layer attribute.
                      SELF.Seq := LEFT.Seq,
                      SELF.did := LEFT.did,
                      SELF := []));

 ds_combinedfrag_recs := ds_search_in + ds_dids_to_use;

 ds_fragment_recs_w_value := _RIN_Function.GetFragmentRecs(ds_combinedfrag_recs, ds_allPayloadRecs);

 _Layout.fragment_w_value_recs do_Rollup(_Layout.fragment_w_value_recs L, dataset(_Layout.fragment_w_value_recs) R) := TRANSFORM
   SELF := L;
 END;

 ds_fragment_recs_sorted := SORT(ds_fragment_recs_w_value, fragment_value, fragment);
 ds_fragment_recs_grouped := GROUP(ds_fragment_recs_sorted, fragment_value, fragment);
 ds_fragment_recs_rolled := ROLLUP(ds_fragment_recs_grouped, GROUP, do_Rollup(LEFT, ROWS(LEFT)));

 ds_entityNameUID := _RIN_Function.GetAnalyticsUID(ds_fragment_recs_rolled);

 iesp.identitysearch.t_RINIdentitySearchProfileInformation createProfileInformation (RECORDOF(FraudGovPlatform.Key_entityprofile) pInfo) := TRANSFORM
  SELF.UniqueId := (string) pInfo.t_personuidecho,
  fname := pInfo.t_inpclnfirstnmecho;
  lname := pInfo.t_inpclnlastnmecho;
  mname := pInfo.nvp(name = 't_inpclnmiddlenmecho')[1].value;
  SELF.Name := iesp.ECL2ESP.SetName(fname,
                                    mname,
                                    lname,
                                    '',
                                    '',
                                    ut.fn_FormatFullName(lname, fname, mname)),
  SELF.SSN := pInfo.t_inpclnssnecho,
  SELF.DOB := iesp.ECL2ESP.toDate(pInfo.t_inpclndobecho),
  st_addr1 := Address.Addr1FromComponents(pInfo.t_inpclnaddrprimrangeecho,pInfo.t_inpclnaddrpredirecho,
                                          pInfo.t_inpclnaddrprimnmecho,pInfo.t_inpclnaddrsuffixecho,pInfo.t_inpclnaddrpostdirecho,
                                          pInfo.t_inpclnaddrunitdesigecho,pInfo.t_inpclnaddrsecrangeecho);
  st_addr2 := Address.Addr2FromComponents(pInfo.t_inpclnaddrcityecho, pInfo.t_inpclnaddrstecho, pInfo.t_inpclnaddrzip5echo);  
  SELF.Address := iesp.ECL2ESP.SetAddress(pInfo.t_inpclnaddrprimnmecho,
                                          pInfo.t_inpclnaddrprimrangeecho,
                                          pInfo.t_inpclnaddrpredirecho,
                                          pInfo.t_inpclnaddrpostdirecho,
                                          pInfo.t_inpclnaddrsuffixecho,
                                          pInfo.t_inpclnaddrunitdesigecho,
                                          pInfo.t_inpclnaddrsecrangeecho,
                                          pInfo.t_inpclnaddrcityecho,
                                          pInfo.t_inpclnaddrstecho,
                                          pInfo.t_inpclnaddrzip5echo,
                                          '',
                                          '',
                                          '',
                                          st_addr1,
                                          st_addr2),
  SELF.IpAddress := pInfo.t_inpclnipaddrecho,
  SELF.ISPName := pInfo.t18_ipaddrispnm,
  SELF.Country := pInfo.t18_ipaddrcountry,
  SELF.Phone10 := pInfo.t_inpclnphnecho,
  SELF.EmailAddress := pInfo.t_inpclnemailecho,
  SELF.DeviceId := pInfo.deviceid,
  SELF.DriverLicense.DriverLicenseState := pInfo.t_inpclndlstecho,
  SELF.DriverLicense.DriverLicenseNumber := pInfo.t_inpclndlecho,
  SELF.BankInformation.BankRoutingNumber := pInfo.t_inpclnbnkacctrtgecho,
  SELF.BankInformation.BankAccountNumber := pInfo.t_inpclnbnkacctecho,
  SELF.BankInformation.BankName := pInfo.t19_bnkacctbnknm,
  SELF.NVPs := CHOOSEN(PROJECT(pInfo.nvp,
                        TRANSFORM(iesp.share.t_NameValuePair,
                          SELF.Name := LEFT.name,
                          SELF.Value := LEFT.value)), iesp.Constants.RIN.MAX_COUNT_NVP),
  SELF := []
 END;

 ds_contributed_recs := JOIN(ds_entityNameUID, FraudGovPlatform.Key_entityprofile,
                            KEYED(RIGHT.customerid = search_params.GlobalCompanyId AND
                                  RIGHT.industrytype = search_params.IndustryType AND
                                  RIGHT.entitycontextuid = LEFT.entity_context_uid) AND
                            RIGHT.aotcurrprofflag = _Constant.CURR_PROFILE_FLAG,
                            TRANSFORM(iesp.identitysearch.t_RINIdentitySearchRecord,
                                SELF.RecordSource := _Constant.RECORD_SOURCE.CONTRIBUTED,
                                SELF.RecordType   := IF(RIGHT.entitytype = _Constant.EntityType.LEXID, _Constant.RECORD_TYPE.IDENTITY, _Constant.RECORD_TYPE.ELEMENT),
                                SELF.ElementType  := LEFT.fragment,
                                SELF.ElementValue := MAP(LEFT.fragment = _Constant.Fragment_Types.PHYSICAL_ADDRESS_FRAGMENT
                                                          => _RIN_Function.GetCleanAddressFragmentValue(LEFT.fragment_value),
                                                         LEFT.fragment = _Constant.Fragment_Types.BANK_ACCOUNT_NUMBER_FRAGMENT
                                                          => _RIN_Function.GetCleanFragmentValue(LEFT.fragment_value, 2),
                                                         LEFT.fragment = _Constant.Fragment_Types.DRIVERS_LICENSE_NUMBER_FRAGMENT
                                                          => _RIN_Function.GetCleanFragmentValue(LEFT.fragment_value, 1),
                                                         LEFT.fragment_value);
                                SELF.ProfileInformation := ROW(createProfileInformation(RIGHT)),
                                SELF.AnalyticsRecordId := LEFT.entity_context_uid,
                                SELF.RiskLevel := (string) RIGHT.riskindx,
                                SELF.RecentActivityDate := iesp.ECL2ESP.toDate(RIGHT.eventdate),
                                SELF.CaseId := RIGHT.caseid,
                                SELF.NoOfIdentities := RIGHT.personeventcount,
                                SELF.NoOfActivitiesLast30Days := RIGHT.event30count,
                                SELF.TotalNoOfActivities := RIGHT.eventcount,
                                SELF.IsKnownRisk := RIGHT.aotkractflagev,
                                SELF.NVPs := []),
                            LIMIT(_Constant.MAX_JOIN_LIMIT));

 //Getting the public records best to get identity profile details
 ds_pr_best_in := PROJECT(ds_dids_combined_dedup(RecordSource = _Constant.RECORD_SOURCE.REALTIME),
                    TRANSFORM(DidVille.Layout_Did_OutBatch,
                    SELF := LEFT));

 ds_pr_best := _RIN_Function.getGovernmentBest(ds_pr_best_in, search_params);

 ds_realtime_profile := PROJECT(ds_pr_best,
                         TRANSFORM(iesp.identitysearch.t_RINIdentitySearchProfileInformation,
                          dob_ := iesp.ECL2ESP.toDate((integer) LEFT.best_dob);

                          SELF.UniqueId := (string) LEFT.did,
                          SELF.Name     := iesp.ECL2ESP.SetName(LEFT.best_fname,
                                                                LEFT.best_mname,
                                                                LEFT.best_lname,
                                                                LEFT.best_name_suffix,
                                                                LEFT.best_title,
                                                                ut.fn_FormatFullName(LEFT.best_lname, LEFT.best_fname, LEFT.best_mname)),
                          SELF.SSN     := (string) LEFT.best_ssn,
                          SELF.DOB     := iesp.ECL2ESP.ApplyDateMask(dob_, search_params.dob_mask),
                          st_addr2     := Address.Addr2FromComponents(LEFT.best_city, LEFT.best_state, LEFT.best_zip);
                          SELF.Address := iesp.ECL2ESP.SetAddress(primname := '',
                                                                  primrange := '',
                                                                  predir := '',
                                                                  postdir := '',
                                                                  suffix := '',
                                                                  unitdesig := '',
                                                                  secrange := '',
                                                                  cityname := LEFT.best_city,
                                                                  st := LEFT.best_state,
                                                                  zip := LEFT.best_zip,
                                                                  zip4 := LEFT.best_zip4,
                                                                  countyname := '',
                                                                  postalcode := '',
                                                                  addr1 := LEFT.best_addr1,
                                                                  addr2 := st_addr2),
                          SELF.Phone10 := LEFT.best_phone,
                          SELF := []));

 // Public records appends for realtimetime identities. inorder to get risk scores from KEL analytics.
 ds_pr_appends := _RIN_Function.getRealtimePRAppends(ungroup(ds_pr_best), search_params);
 ds_realtime_attribute := RiskIntelligenceNetwork_Analytics.Functions.GetRealtimeAssessment(ds_pr_appends, search_params);

 // ****Ends here ****

 ds_realtime_recs := PROJECT(ds_realtime_profile,
                       TRANSFORM(iesp.identitysearch.t_RINIdentitySearchRecord,
                        SELF.RecordSource := _Constant.RECORD_SOURCE.REALTIME,
                        SELF.RecordType   := _Constant.RECORD_TYPE.IDENTITY,
                        SELF.ElementType  := _Constant.Fragment_Types.PERSON_FRAGMENT,
                        SELF.ElementValue := (string) ds_pr_best[1].did,
                        SELF.RiskLevel    := (string) ds_realtime_attribute[1].P1_IDRiskIndx,
                        SELF.ProfileInformation := ROW(LEFT, iesp.identitysearch.t_RINIdentitySearchProfileInformation),
                        SELF := []
                       ));

 ds_combined_recs := ds_realtime_recs + ds_contributed_recs;

 ds_identity_recs_sorted := SORT(ds_combined_recs(RecordType = _Constant.RECORD_TYPE.IDENTITY),
                                 -RecordSource, -RecentActivityDate.year, -RecentActivityDate.Month, -RecentActivityDate.day,
                                 RiskLevel, ProfileInformation.Name.First, ProfileInformation.Name.Middle, ProfileInformation.Name.Last,
                                 record);

 ds_element_recs_sorted := SORT(ds_combined_recs(RecordType = _Constant.RECORD_TYPE.ELEMENT),
                                ElementType, -RecentActivityDate.year, -RecentActivityDate.Month, -RecentActivityDate.day,
                                RiskLevel, record);

 ds_results := ds_identity_recs_sorted & ds_element_recs_sorted;

 // OUTPUT(ds_search_in, NAMED('ds_search_in'));
 // OUTPUT(AddressAlonePIISearch, NAMED('AddressAlonePIISearch'));
 // OUTPUT(InputDidFoundInPR, NAMED('InputDidFoundInPR'));
 // OUTPUT(IsInputDidRINID, NAMED('IsInputDidRINID'));
 // OUTPUT(input_pii, NAMED('input_pii'));
 // OUTPUT(ds_pr_did, NAMED('ds_pr_did'));
 // OUTPUT(ds_pr_did_final, NAMED('ds_pr_did_final'));
 // OUTPUT(ds_allPayloadRecs, NAMED('ds_allPayloadRecs'));
 // OUTPUT(ds_contributory_dids, NAMED('ds_contributory_dids'));
 // OUTPUT(ds_dids_combined, NAMED('ds_dids_combined'));
 // OUTPUT(ds_dids_combined_dedup, NAMED('ds_dids_combined_dedup'));
 // OUTPUT(ds_dids_to_use, NAMED('ds_dids_to_use'));
 // OUTPUT(ds_combinedfrag_recs, NAMED('ds_combinedfrag_recs'));
 // OUTPUT(ds_fragment_recs_w_value, NAMED('ds_fragment_recs_w_value'));
 // OUTPUT(ds_fragment_recs_rolled, NAMED('ds_fragment_recs_rolled'));
 // OUTPUT(ds_entityNameUID, NAMED('ds_entityNameUID'));
 // OUTPUT(ds_pr_best_in, NAMED('ds_pr_best_in'));
 // OUTPUT(ds_pr_best, NAMED('ds_pr_best'));
 // OUTPUT(ds_realtime_profile, NAMED('ds_realtime_profile'));
 // OUTPUT(ds_pr_appends, NAMED('ds_pr_appends'));
 // OUTPUT(ds_realtime_recs, NAMED('ds_realtime_recs'));
 // OUTPUT(ds_contributed_recs, NAMED('ds_contributed_recs'));
 // OUTPUT(ds_identity_recs_sorted, NAMED('ds_identity_recs_sorted'));
 // OUTPUT(ds_element_recs_sorted, NAMED('ds_element_recs_sorted'));
 // OUTPUT(ds_results, named('ds_results'));

 return ds_results;
END;