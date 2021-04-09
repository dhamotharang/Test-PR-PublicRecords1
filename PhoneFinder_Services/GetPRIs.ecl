IMPORT $, STD, Gateway, Phones, ThreatMetrix, Autokey_batch;

EXPORT GetPRIs( DATASET($.Layouts.PhoneFinder.Final)             dSearchResults,
                DATASET($.Layouts.BatchInAppendDID)              dInBestInfo,
                $.iParam.SearchParams                            inMod,
                DATASET(Gateway.Layouts.Config)                  dGateways,
                DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dProcessInput
                ) :=
FUNCTION
  // Calculate the identity counts - count the number of identities for each phone to calculate RI
  dCntPhoneIdentities := $.GetIdentitiesCount(dSearchResults);

  dRemoveOtherPhoneHistory := dCntPhoneIdentities(isPrimaryIdentity OR isPrimaryPhone);

  // Remove phone history records for other phones
  dSearchResultsWCnt := IF(inMod.isPrimarySearchPII, dRemoveOtherPhoneHistory, dCntPhoneIdentities);

  // Identities
  dIdentitiesInfo := $.GetIdentitiesFinal(dSearchResultsWCnt, dInBestInfo, inMod);

  // Primary phone
  //TOPN here to pick the best (Qsent gateway with metadata(PVSD)/InHouse) record associated with primary identity.
  dPrimaryPhonePII := TOPN(GROUP(SORT(dSearchResultsWCnt(isPrimaryPhone), acctno, IF(typeflag = Phones.Constants.TypeFlag.DataSource_PV, 0, 1), ~isPrimaryIdentity, phone_source), acctno),
                           1,acctno, IF(typeflag = Phones.Constants.TypeFlag.DataSource_PV, 0, 1), ~isPrimaryIdentity, phone_source);

  dSearchResultsPrimaryPhone := IF(~inMod.IsPrimarySearchPII,
                                    dSearchResultsWCnt, UNGROUP(dPrimaryPhonePII));

  dPrimaryPhoneInfo := $.GetPhonesFinal(dSearchResultsPrimaryPhone, inMod, TRUE);

  // Other phones
  dSearchResultsOtherPhones := IF(inMod.isPrimarySearchPII, dSearchResultsWCnt(~isPrimaryPhone));

  dOtherPhoneInfo := $.GetPhonesFinal(dSearchResultsOtherPhones, inMod, FALSE);

  // Prep for Risk indicator calculation
  // Format identities to Final layout
  dIdentitiesFormat2Final := PROJECT(dIdentitiesInfo,
                                      TRANSFORM($.Layouts.PhoneFinder.Final,
                                                SELF.isPrimaryPhone    := FALSE,
                                                SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                                SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                                SELF.is_verified       := LEFT.is_identity_verified OR LEFT.is_phone_verified,
                                                SELF := LEFT, SELF := []));

  // Identify Primary identity and pass only the top identity record for RI calculation
  dIdentityInfoGrp := SORT(GROUP(SORT(dIdentitiesFormat2Final, acctno), acctno), IF(isPrimaryIdentity, 0, 1), IF(PhoneOwnershipIndicator, 0, 1),
                            IF(InputDID != 0 AND did = InputDID, 0, 1), IF(inMod.isPrimarySearchPII, 0, penalt), IF(did != 0, 0, 1), -dt_last_seen,
                            IF(dt_first_seen != '', dt_first_seen, '99999999'), phone_source, RECORD);

  dPrepIdentityForRI := UNGROUP(ITERATE(dIdentityInfoGrp,
                                        TRANSFORM($.Layouts.PhoneFinder.Final,
                                                  SELF.isPrimaryIdentity := (COUNTER = 1),
                                                  SELF                   := RIGHT)));

  dPrepPrimaryForRIs := JOIN( dPrepIdentityForRI(isPrimaryIdentity),
                              dPrimaryPhoneInfo,
                              LEFT.acctno = RIGHT.acctno,
                              TRANSFORM($.Layouts.PhoneFinder.Final,
                                        SELF.phone                   := RIGHT.phone,
                                        SELF.isPrimaryIdentity       := TRUE,
                                        SELF.isPrimaryPhone          := TRUE,
                                        // Need this mapping as SELF := RIGHT happens first before SELF := LEFT mapping
                                        SELF.dt_first_seen           := IF(LEFT.dt_first_seen != '', LEFT.dt_first_seen, (STRING)RIGHT.dt_first_seen),
                                        SELF.dt_last_seen            := IF(LEFT.dt_last_seen != '', LEFT.dt_last_seen, (STRING)RIGHT.dt_last_seen),
                                        SELF.fname                   := LEFT.fname,
                                        SELF.lname                   := LEFT.lname,
                                        SELF.prim_range              := LEFT.prim_range,
                                        SELF.predir                  := LEFT.predir,
                                        SELF.prim_name               := LEFT.prim_name,
                                        SELF.suffix                  := LEFT.suffix,
                                        SELF.postdir                 := LEFT.postdir,
                                        SELF.unit_desig              := LEFT.unit_desig,
                                        SELF.sec_range               := LEFT.sec_range,
                                        SELF.city_name               := LEFT.city_name,
                                        SELF.st                      := LEFT.st,
                                        SELF.zip                     := LEFT.zip,
                                        SELF.zip4                    := LEFT.zip4,
                                        SELF.county_code             := LEFT.county_code,
                                        SELF.county_name             := LEFT.county_name,
                                        SELF.PhoneOwnershipIndicator := LEFT.PhoneOwnershipIndicator,
                                        SELF.listed_name             := IF(RIGHT.ListingName != '', RIGHT.ListingName, LEFT.listed_name),
                                        SELF.phoneState              := RIGHT.phone_state,
                                        SELF.listing_type_res        := IF(STD.Str.Find(RIGHT.ListingType, 'RESIDENTIAL') > 0, 'R', ''),
                                        SELF.listing_type_bus        := IF(STD.Str.Find(RIGHT.ListingType, 'BUSINESS') > 0, 'B', ''),
                                        SELF.listing_type_gov        := IF(STD.Str.Find(RIGHT.ListingType, 'GOVERNMENT') > 0, 'G', ''),
                                        SELF.RealTimePhone_Ext       := RIGHT,
                                        SELF.isLNameMatch            := STD.Str.findword(TRIM(IF(RIGHT.ListingName != '', RIGHT.ListingName, LEFT.listed_name)),TRIM(LEFT.lname), TRUE),
                                        SELF.phn_src_all             := LEFT.phn_src_all;
                                        SELF := RIGHT, SELF := LEFT),
                              FULL OUTER,
                              LIMIT(1, SKIP));

  // Other identities
  dOtherIdentities := PROJECT(dPrepIdentityForRI(~isPrimaryIdentity), TRANSFORM($.Layouts.PhoneFinder.Final, SELF.isPrimaryPhone := TRUE, SELF := LEFT));

  // Other phones
  // Other phones would only exist for a PII search. Hence, we can blindly assign the deceased indicator just using the acctno
  dPrepOtherPhonesForRIs := JOIN( dOtherPhoneInfo,
                                  dPrepPrimaryForRIs,
                                  LEFT.acctno = RIGHT.acctno,
                                  TRANSFORM($.Layouts.PhoneFinder.Final,
                                            SELF.isPrimaryPhone    := FALSE,
                                            SELF.isPrimaryIdentity := FALSE,
                                            SELF.deceased          := RIGHT.deceased,
                                            SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                            SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                            SELF.listed_name       := LEFT.ListingName,
                                            SELF.phoneState        := LEFT.phone_state,
                                            SELF.listing_type_res  := IF(STD.Str.Find(LEFT.ListingType, 'RESIDENTIAL') > 0, 'R', ''),
                                            SELF.listing_type_bus  := IF(STD.Str.Find(LEFT.ListingType, 'BUSINESS') > 0, 'B', ''),
                                            SELF.listing_type_gov  := IF(STD.Str.Find(LEFT.ListingType, 'GOVERNMENT') > 0, 'G', ''),
                                            SELF.RealTimePhone_Ext := LEFT,
                                            SELF.isLNameMatch      := STD.Str.findword(TRIM(LEFT.ListingName),TRIM(RIGHT.lname), TRUE),
                                            SELF := LEFT, SELF := []),
                                    LIMIT(0), KEEP(1));

  // Send primary and other phones for RI calculation
  dPrepForRIs_pre_info := dPrepPrimaryForRIs & IF(inMod.IncludeOtherPhoneRiskIndicators, dPrepOtherPhonesForRIs);

  //Calculte the count of phones in response
  dPhonesIn := PROJECT(dPrepForRIs_pre_info, TRANSFORM({$.Layouts.PhoneFinder.Final.phone}, SELF.phone := LEFT.phone));

  Threshold_PhoneTransactionCount := inMod.RiskIndicators(RiskId = $.Constants.RiskRules.PhoneTransactionCount)[1].Threshold;

  dPhoneTransactionsCount := IF(inMod.hasActivePhoneTransactionCountRule, $.GetPhoneTransactionCount(dPhonesIn(phone != ''), Threshold_PhoneTransactionCount));

  dPrepForRIs_pre := JOIN(dPrepForRIs_pre_info, dPhoneTransactionsCount,
                          LEFT.phone = RIGHT.phone,
                          TRANSFORM($.Layouts.PhoneFinder.Final, SELF.phone_inresponse_count := RIGHT.phonecount, SELF:= LEFT),
                          LEFT OUTER, LIMIT(0), KEEP(1));

  // Need this if we didn't find any results for phone or PII search to trigger No Identity or No phone RIs
  dPrepForRIs := JOIN(dProcessInput,
                      dPrepForRIs_pre,
                      LEFT.acctno = RIGHT.acctno,
                      TRANSFORM($.Layouts.PhoneFinder.Final,
                                BOOLEAN isResExists    := RIGHT.acctno != '';
                                SELF.acctno            := LEFT.acctno,
                                SELF.phone             := IF(isResExists, RIGHT.phone, LEFT.homephone),
                                SELF.fname             := IF(isResExists, RIGHT.fname, LEFT.name_first),
                                SELF.lname             := IF(isResExists, RIGHT.lname, LEFT.name_last),
                                SELF.isPrimaryPhone    := IF(isResExists, RIGHT.isPrimaryPhone, TRUE), // This will process the RiskIndicators for "no identity and no phone"
                                SELF.isPrimaryIdentity := IF(isResExists, RIGHT.isPrimaryIdentity, TRUE), // This will process the RiskIndicators for "no identity and no phone"
                                SELF.phonestatus       := IF(RIGHT.PhoneOwnershipIndicator, $.Constants.PhoneStatus.Active, RIGHT.phonestatus); // PHPR- 483 If Phone verified by zumigo then update phonestatus to be ACTIVE;
                                SELF                   := RIGHT,
                                SELF                   := []),
                      LEFT OUTER,
                      LIMIT(100, SKIP));

 // ThreatMetrix
  dDupThreatMetrixIn := PROJECT(DEDUP(SORT(dPrepForRIs, phone), phone), Phones.Layouts.PhoneAcctno);

  dThreatMetrixRecs := Phones.GetThreatMetrixRecords(dDupThreatMetrixIn, inMod.UseThreatMetrixRules, dGateways);

  $.Layouts.PhoneFinder.Final getThreatMetrix($.Layouts.PhoneFinder.Final l, ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEX r) := TRANSFORM
   SELF.ReasonCodes := r.response.Summary.ReasonCodes;
   SELF.TmxVariables := r.response._data.TmxVariables;
   SELF := l;
  END;

  dPrepThreatMetrix	:= JOIN(dPrepForRIs, dThreatMetrixRecs,
                            LEFT.phone = RIGHT.response._Data.AccountTelephone.Content_,
                            getThreatMetrix(LEFT, RIGHT), LEFT OUTER, LIMIT(0), KEEP(1));

  dPrepAllRIs := IF(inMod.UseThreatMetrixRules, dPrepThreatMetrix, dPrepForRIs);

  dRIs := $.CalculatePRIs(dPrepAllRIs, inMod);

  dFinal := MAP(inMod.IncludeRiskIndicators AND inMod.IncludeOtherPhoneRiskIndicators => dRIs + dOtherIdentities,
                inMod.IncludeRiskIndicators                                           => dRIs + dPrepOtherPhonesForRIs + dOtherIdentities,
                dPrepPrimaryForRIs + dPrepOtherPhonesForRIs + dOtherIdentities);

  #IF($.Constants.Debug.Main)
    OUTPUT(dCntPhoneIdentities, NAMED('dCntPhoneIdentities'), EXTEND);
    OUTPUT(dRemoveOtherPhoneHistory, NAMED('dRemoveOtherPhoneHistory'), EXTEND);
    OUTPUT(dPrimaryPhonePII, NAMED('dPrimaryPhonePII'), EXTEND);
    OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo_PRI'), EXTEND);
    OUTPUT(dSearchResultsPrimaryPhone, NAMED('dSearchResultsPrimaryPhone_PRI'), EXTEND);
    IF(inMod.isPrimarySearchPII, OUTPUT(dSearchResultsOtherPhones, NAMED('dSearchResultsOtherPhones_PRI'), EXTEND));
    IF(inMod.isPrimarySearchPII, OUTPUT(dOtherPhoneInfo, NAMED('dOtherPhoneInfo_PRI'), EXTEND));
    OUTPUT(dIdentitiesFormat2Final, NAMED('dIdentitiesFormat2Final_PRI'), EXTEND);
    OUTPUT(dPrepIdentityForRI, NAMED('dPrepIdentityForRI_PRI'), EXTEND);
    OUTPUT(dPrepPrimaryForRIs, NAMED('dPrepPrimaryForRIs_PRI'), EXTEND);
    OUTPUT(dOtherIdentities, NAMED('dOtherIdentities_PRI'), EXTEND);
    IF(inMod.isPrimarySearchPII, OUTPUT(dPrepOtherPhonesForRIs, NAMED('dPrepOtherPhonesForRIs_PRI'), EXTEND));
    IF(inMod.IncludeRiskIndicators, OUTPUT(dPrepForRIs_pre_info, NAMED('dPrepForRIs_pre_info_PRI'), EXTEND));
    IF(inMod.IncludeRiskIndicators, OUTPUT(dPrepForRIs_pre, NAMED('dPrepForRIs_pre_PRI'), EXTEND));
    IF(inMod.IncludeRiskIndicators, OUTPUT(dPrepForRIs, NAMED('dPrepForRIs_PRI'), EXTEND));
    IF(inMod.IncludeRiskIndicators, OUTPUT(dRIs, NAMED('dRIs_PRI'), EXTEND));
  #END

  RETURN dFinal;
END;

