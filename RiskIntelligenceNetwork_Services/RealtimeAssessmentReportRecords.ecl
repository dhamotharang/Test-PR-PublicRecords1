IMPORT Address, DidVille, FraudGovPlatform, FraudShared_Services, iesp, RiskIntelligenceNetwork_Analytics, RiskIntelligenceNetwork_Services, ut;

EXPORT RealtimeAssessmentReportRecords(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_in,
                                       RiskIntelligenceNetwork_Services.IParam.Params report_params) := FUNCTION

 _Layouts := RiskIntelligenceNetwork_Services.Layouts;
 _Constants := RiskIntelligenceNetwork_Services.Constants;
 blank_dataset := dataset([], _Layouts.fragment_w_value_recs);

 ds_best_in := PROJECT(ds_in,
                TRANSFORM(didville.Layout_Did_OutBatch,
                  SELF.seq := (unsigned)LEFT.acctno,
                  SELF.did := LEFT.did,
                  SELF := []));

 ds_pr_best := RiskIntelligenceNetwork_Services.Functions.getGovernmentBest(ds_best_in, report_params);
 ds_pr_best_ungroup := UNGROUP(ds_pr_best);

 ds_ssn_element := IF(ds_pr_best[1].best_ssn <> '',
                    PROJECT(ds_pr_best_ungroup,
                      TRANSFORM(_Layouts.fragment_w_value_recs,
                        SELF.acctno := (string) LEFT.seq,
                        SELF.fragment := _Constants.Fragment_Types.SSN_FRAGMENT,
                        SELF.fragment_value := LEFT.best_ssn)),
                   blank_dataset);

 ds_Address_element := IF(ds_pr_best[1].best_addr1 <> '',
                        PROJECT(ds_pr_best_ungroup,
                          TRANSFORM(_Layouts.fragment_w_value_recs,
                           addr := stringlib.StringToUpperCase(trim(LEFT.best_addr1) + _Constants.FRAGMENT_SEPARATOR +
                               (trim(LEFT.best_city) + if( LEFT.best_city !='' and(LEFT.best_state != '' or LEFT.best_zip !=''), ', ', '') + trim(LEFT.best_state) +' '+ trim(LEFT.best_zip)));
                           SELF.acctno := (string) LEFT.seq,
                           SELF.fragment := _Constants.Fragment_Types.PHYSICAL_ADDRESS_FRAGMENT,
                           SELF.fragment_value := addr)),
                       blank_dataset);

 ds_Phone_element := IF(ds_pr_best[1].best_phone <> '',
                      PROJECT(ds_pr_best_ungroup,
                        TRANSFORM(_Layouts.fragment_w_value_recs,
                          SELF.acctno := (string) LEFT.seq,
                          SELF.fragment := _Constants.Fragment_Types.PHONE_FRAGMENT,
                          SELF.fragment_value := LEFT.best_phone)),
                     blank_dataset);

 _Layouts.fragment_w_value_recs do_Rollup(_Layouts.fragment_w_value_recs L, dataset(_Layouts.fragment_w_value_recs) R) := TRANSFORM
    SELF := L;
 END;

 ds_element_sorted := SORT(ds_ssn_element + ds_Address_element + ds_Phone_element, fragment_value, fragment);
 ds_element_recs_grouped := GROUP(ds_element_sorted, fragment_value, fragment);
 ds_element_recs_rolled := ROLLUP(ds_element_recs_grouped, GROUP, do_Rollup(LEFT, ROWS(LEFT)))(fragment_value <> '');

 ds_entityNameUID := RiskIntelligenceNetwork_Services.Functions.GetAnalyticsUID(ds_element_recs_rolled);

 ds_entity_w_risk := JOIN(ds_entityNameUID , FraudGovPlatform.Key_entityprofile,
                        KEYED(RIGHT.customerid = report_params.GlobalCompanyId AND
                              RIGHT.industrytype = report_params.IndustryType AND
                              LEFT.entity_context_uid = RIGHT.entitycontextuid) AND
                        RIGHT.aotcurrprofflag = _Constants.CURR_PROFILE_FLAG,
                        TRANSFORM(_Layouts.entity_uid_recs_w_risk,
                          SELF.hasKnownRisk := RIGHT.aotkractflagev,
                          SELF.RiskLevel := (string) RIGHT.riskindx,
                          SELF := LEFT));

 ds_realtime_profile := PROJECT(ds_pr_best,
                          TRANSFORM(iesp.identityreport.t_RINIdentityProfile,
                            dob_ := iesp.ECL2ESP.toDate((integer) LEFT.best_dob);
                            dod_ := iesp.ECL2ESP.toDate((integer) LEFT.best_dod);

                            SELF.UniqueId := (string) LEFT.did,
                            SELF.Name  := iesp.ECL2ESP.SetName(LEFT.best_fname,
                                                               LEFT.best_mname,
                                                               LEFT.best_lname,
                                                               LEFT.best_name_suffix,
                                                               LEFT.best_title,
                                                               ut.fn_FormatFullName(LEFT.best_lname, LEFT.best_fname, LEFT.best_mname)),
                            SELF.SSN := (string) LEFT.best_ssn,
                            SELF.SSNKnownRisk := PROJECT(ds_entity_w_risk(fragment = _Constants.Fragment_Types.SSN_FRAGMENT)[1],
                                                   TRANSFORM(iesp.identityreport.t_RINProfileElementKnownRisk,
                                                      SELF.AnalyticsRecordId := LEFT.entity_context_uid,
                                                      SELF.ElementType := LEFT.fragment,
                                                      SELF := LEFT)),
                            SELF.DOB := iesp.ECL2ESP.ApplyDateMask(dob_, report_params.dob_mask),
                            SELF.DOD := iesp.ECL2ESP.ApplyDateMask(dod_, report_params.dob_mask),
                            SELF.IsDeceased := LEFT.best_dod <> '';
                            st_addr2 := Address.Addr2FromComponents(LEFT.best_city, LEFT.best_state, LEFT.best_zip);
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
                            SELF.AddressKnownRisk := PROJECT(ds_entity_w_risk(fragment = _Constants.Fragment_Types.PHYSICAL_ADDRESS_FRAGMENT)[1],
                                                       TRANSFORM(iesp.identityreport.t_RINProfileElementKnownRisk,
                                                        SELF.AnalyticsRecordId := LEFT.entity_context_uid,
                                                        SELF.ElementType := LEFT.fragment,
                                                        SELF := LEFT)),
                            SELF.Phone := LEFT.best_phone,
                            SELF.PhoneKnownRisk := PROJECT(ds_entity_w_risk(fragment = _Constants.Fragment_Types.PHONE_FRAGMENT)[1],
                                                     TRANSFORM(iesp.identityreport.t_RINProfileElementKnownRisk,
                                                      SELF.AnalyticsRecordId := LEFT.entity_context_uid,
                                                      SELF.ElementType := LEFT.fragment,
                                                      SELF := LEFT)),
                            SELF := []));

 // Public records appends for realtimetime identities. inorder to get attributes and risk scores from KEL analytics.

 ds_pr_appends := RiskIntelligenceNetwork_Services.Functions.getRealtimePRAppends(ds_pr_best_ungroup, report_params);
 ds_RiskAssessment := RiskIntelligenceNetwork_Analytics.Functions.GetRealtimeAssessment(ds_pr_appends,report_params);  
 
 ds_RiskAttribute := PROJECT(ds_RiskAssessment[1].EntityStats, 
                       TRANSFORM(iesp.identityreport.t_RINRiskAttribute, 
                         SELF.ElementType := RiskIntelligenceNetwork_Services.Functions.GetElementType(LEFT.entitytype);
                         SELF.KnownRiskCode := LEFT.indicatortype,
                         SELF.KnownRiskDescription := LEFT.label,
                         SELF.RiskLevel := (string) LEFT.risklevel,
                         SELF.NVPs := []));
 
 ds_RulesMatched := PROJECT(ds_RiskAssessment[1].RulesFlagsMatched,
                      TRANSFORM(iesp.identityreport.t_RINRiskRulesMatched,
                         SELF.ElementType := RiskIntelligenceNetwork_Services.Functions.GetElementType(LEFT.entitytype);
                         SELF.RuleName := LEFT.rulename,
                         SELF.Description := LEFT.description,
                         SELF.RiskLevel := (string) LEFT.risklevel));

 iesp.identityreport.t_RINIdentityReportRecord trans_reportrecords() := TRANSFORM
  SELF.IdentityProfile := ROW(ds_realtime_profile[1], iesp.identityreport.t_RINIdentityProfile);
  SELF.RiskLevel := (string) ds_RiskAssessment[1].P1_IDRiskIndx;
  SELF.RiskAttributes := ds_RiskAttribute;
  SELF.RulesMatched := ds_RulesMatched;
  SELF := []
 END;

 ds_reportrecords := DATASET([trans_reportrecords()]);

 // OUTPUT(ds_in, named('ds_in'));
 // OUTPUT(ds_best_in, named('ds_best_in'));
 // OUTPUT(ds_pr_best, named('ds_pr_best'));
 // OUTPUT(ds_element_recs_rolled, named('ds_element_recs_rolled'));
 // OUTPUT(ds_entityNameUID, named('ds_entityNameUID'));
 // OUTPUT(ds_entity_w_risk, named('ds_entity_w_risk'));
 // OUTPUT(ds_realtime_profile, named('ds_realtime_profile'));
 // OUTPUT(ds_pr_appends, named('ds_pr_appends'));
 // OUTPUT(ds_RiskAssessment, named('ds_RiskAssessment'));
 // OUTPUT(ds_RiskAttribute, named('ds_RiskAttribute'));
 // OUTPUT(ds_reportrecords, named('ds_reportrecords'));

 return ds_reportrecords;

END;