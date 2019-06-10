IMPORT $, STD, Gateway, Phones, ThreatMetrix, Autokey_batch, BatchShare;

EXPORT GetPRIs( DATASET($.Layouts.PhoneFinder.Final)     dSearchResults,
                DATASET($.Layouts.BatchInAppendDID)      dInBestInfo,
                PhoneFinder_Services.iParam.SearchParams inMod,
                DATASET(Gateway.Layouts.Config) dGateways,
                DATASET(Autokey_batch.Layouts.rec_inBatchMaster) dProcessInput
                ) :=
FUNCTION   
  // Identities
  dIdentitiesInfo   := PhoneFinder_Services.GetIdentitiesFinal(dSearchResults, dInBestInfo, inMod);

  // Primary phone
  dSearchResultsPrimaryPhone := IF(~inMod.IsPrimarySearchPII,
                                    dSearchResults,
                                    dSearchResults(isPrimaryPhone AND phone_source in [PhoneFinder_Services.Constants.PhoneSource.Waterfall,
                                                                                      PhoneFinder_Services.Constants.PhoneSource.QSentGateway]));

  dPrimaryPhoneInfo_pre := PhoneFinder_Services.GetPhonesFinal(dSearchResultsPrimaryPhone, inMod, TRUE);
	
	// ThreatMetrix                  
  dDupThreatMetrixIn := PROJECT(DEDUP(SORT(dPrimaryPhoneInfo_pre, phone), phone), Phones.Layouts.PhoneAcctno);
  
  dPrimaryThreatMetrixRecs := Phones.GetThreatMetrixRecords(dDupThreatMetrixIn, inMod.UseThreatMetrixRules, dGateways);
                                
  PhoneFinder_Services.Layouts.PhoneFinder.PhoneSlim getThreatMetrix(PhoneFinder_Services.Layouts.PhoneFinder.PhoneSlim l, ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEX r) := TRANSFORM  
   SELF.ReasonCodes := r.response.Summary.ReasonCodes;
   SELF.TmxVariables := r.response._data.TmxVariables;
   SELF := l;
  END;
 
  dPrepPrimaryThreatMetrix	:= JOIN(dPrimaryPhoneInfo_pre,
                                    dPrimaryThreatMetrixRecs,
                                    LEFT.phone = RIGHT.response._Data.AccountTelephone.Content_,
                                    getThreatMetrix(LEFT, RIGHT), LEFT OUTER, LIMIT(0), KEEP(1));
                         
                         
  dPrimaryPhoneInfo := IF(inMod.UseThreatMetrixRules, dPrepPrimaryThreatMetrix, dPrimaryPhoneInfo_pre);
  
  // Other phones
  dSearchResultsOtherPhones := IF(inMod.isPrimarySearchPII, dSearchResults(~isPrimaryPhone));
  
  dOtherPhoneInfo := PhoneFinder_Services.GetPhonesFinal(dSearchResultsOtherPhones, inMod, FALSE);

  // Prep for Risk indicator calculation
  // Format identities to Final layout
  dIdentitiesFormat2Final := PROJECT(dIdentitiesInfo,
                                      TRANSFORM($.Layouts.PhoneFinder.Final,
                                                SELF.isPrimaryIdentity := FALSE,
                                                SELF.isPrimaryPhone    := FALSE,
                                                SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                                SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                                SELF.is_verified       := LEFT.is_identity_verified OR LEFT.is_phone_verified,
                                                SELF := LEFT, SELF := []));
  
  // Identify Primary identity and pass only the top identity record for RI calculation
	// Input did should be on top of identities
  dIdentityInfoGrp := SORT(GROUP(SORT(dIdentitiesFormat2Final, acctno), acctno), IF(did != 0, 0, 1),
                           IF(InputDID !=0, did != InputDID, FALSE), IF(PhoneOwnershipIndicator, 0, 1), penalt, -dt_last_seen, IF(dt_first_seen != '', dt_first_seen, '99999999'), phone_source, RECORD);
  
  dPrepIdentityForRI := UNGROUP(ITERATE(dIdentityInfoGrp,
                                        TRANSFORM($.Layouts.PhoneFinder.Final,
                                                  SELF.isPrimaryIdentity := (COUNTER = 1),
                                                  SELF                   := RIGHT)));

  dPrepPrimaryForRIs := JOIN( dPrepIdentityForRI(isPrimaryIdentity),
                              dPrimaryPhoneInfo,
                              LEFT.acctno = RIGHT.acctno,
                              TRANSFORM($.Layouts.PhoneFinder.Final,
                                        SELF.phone             := RIGHT.phone,
                                        SELF.isPrimaryPhone    := TRUE,
                                        // Need this mapping as SELF := RIGHT happens first before SELF := LEFT mapping
                                        SELF.dt_first_seen     := IF(LEFT.dt_first_seen != '', LEFT.dt_first_seen, (STRING)RIGHT.dt_first_seen),
                                        SELF.dt_last_seen      := IF(LEFT.dt_last_seen != '', LEFT.dt_last_seen, (STRING)RIGHT.dt_last_seen),
                                        SELF.fname             := LEFT.fname,
                                        SELF.lname             := LEFT.lname,
                                        SELF.prim_range        := LEFT.prim_range,
                                        SELF.predir            := LEFT.predir,
                                        SELF.prim_name         := LEFT.prim_name,
                                        SELF.suffix            := LEFT.suffix,
                                        SELF.postdir           := LEFT.postdir,
                                        SELF.unit_desig        := LEFT.unit_desig,
                                        SELF.sec_range         := LEFT.sec_range,
                                        SELF.city_name         := LEFT.city_name,
                                        SELF.st                := LEFT.st,
                                        SELF.zip               := LEFT.zip,
                                        SELF.zip4              := LEFT.zip4,
                                        SELF.county_code       := LEFT.county_code,
                                        SELF.county_name       := LEFT.county_name,
                                        SELF.listed_name       := IF(RIGHT.ListingName != '', RIGHT.ListingName, LEFT.listed_name),
                                        SELF.phoneState        := RIGHT.phone_state,
                                        SELF.listing_type_res  := IF(STD.Str.Find(RIGHT.ListingType, 'RESIDENTIAL') > 0, 'R', ''),
                                        SELF.listing_type_bus  := IF(STD.Str.Find(RIGHT.ListingType, 'BUSINESS') > 0, 'B', ''),
                                        SELF.listing_type_gov  := IF(STD.Str.Find(RIGHT.ListingType, 'GOVERNMENT') > 0, 'G', ''),
                                        SELF.RealTimePhone_Ext := RIGHT,
                                        SELF := RIGHT, SELF := LEFT),
                              LEFT OUTER,
                              LIMIT(0), KEEP(1));
  
  dPrepPrimaryPhoneOnlyForRIs := JOIN(dPrepPrimaryForRIs,
                                      dPrimaryPhoneInfo,
                                      LEFT.acctno = RIGHT.acctno,
                                      TRANSFORM($.Layouts.PhoneFinder.Final,
                                                SELF.isPrimaryPhone    := TRUE;
                                                SELF.phone             := RIGHT.phone,
                                                SELF.dt_first_seen     := (STRING)RIGHT.dt_first_seen,
                                                SELF.dt_last_seen      := (STRING)RIGHT.dt_last_seen,
                                                SELF.listed_name       := RIGHT.ListingName,
                                                SELF.phoneState        := RIGHT.phone_state,
                                                SELF.listing_type_res  := IF(STD.Str.Find(RIGHT.ListingType, 'RESIDENTIAL') > 0, 'R', ''),
                                                SELF.listing_type_bus  := IF(STD.Str.Find(RIGHT.ListingType, 'BUSINESS') > 0, 'B', ''),
                                                SELF.listing_type_gov  := IF(STD.Str.Find(RIGHT.ListingType, 'GOVERNMENT') > 0, 'G', ''),
                                                SELF.RealTimePhone_Ext := RIGHT,
                                                SELF := RIGHT, SELF := []),
                                      RIGHT ONLY);
  
  // Combine primary identity and phone
  dPrimaryForRIs := dPrepPrimaryForRIs + dPrepPrimaryPhoneOnlyForRIs;

  // Other identities
  dOtherIdentities := dPrepIdentityForRI(~isPrimaryIdentity);

  // Other phones
  // Other phones would only exist for a PII search. Hence, we can blindly assign the deceased indicator just using the acctno
  dPrepOtherPhonesForRIs := JOIN( dOtherPhoneInfo,
                                  dPrimaryForRIs,
                                  LEFT.acctno = RIGHT.acctno,
                                  TRANSFORM($.Layouts.PhoneFinder.Final,
                                            SELF.isPrimaryPhone    := FALSE,
                                            SELF.deceased          := RIGHT.deceased,
                                            SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                            SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                            SELF.listed_name       := LEFT.ListingName,
                                            SELF.phoneState        := LEFT.phone_state,
                                            SELF.listing_type_res  := IF(STD.Str.Find(LEFT.ListingType, 'RESIDENTIAL') > 0, 'R', ''),
                                            SELF.listing_type_bus  := IF(STD.Str.Find(LEFT.ListingType, 'BUSINESS') > 0, 'B', ''),
                                            SELF.listing_type_gov  := IF(STD.Str.Find(LEFT.ListingType, 'GOVERNMENT') > 0, 'G', ''),
                                            SELF.RealTimePhone_Ext := LEFT,
                                            SELF := LEFT, SELF := []),
                                    LIMIT(0), KEEP(1));
  
  // Send primary and other phones for RI calculation
<<<<<<< HEAD
  dPrepForRIs_pre := dPrimaryForRIs & IF(inMod.IncludeOtherPhoneRiskIndicators, dPrepOtherPhonesForRIs);
  	
  dPrepForRIs := IF(EXISTS(dPrepForRIs_pre),
                    dPrepForRIs_pre,
                    PROJECT(dProcessInput, TRANSFORM($.Layouts.PhoneFinder.Final, 
                                                      SELF.phone          := LEFT.homephone,
                                                      SELF.fname          := LEFT.name_first,
                                                      SELF.lname          := LEFT.name_last,
                                                      SELF.prim_name      := LEFT.prim_name, 
                                                      SELF.isPrimaryPhone := TRUE, // This will process the RiskIndicators for "no identity and no phone"
                                                      SELF                := [])));
    
=======
  dPrepForRIs_pre_info := dPrimaryForRIs & IF(inMod.IncludeOtherPhoneRiskIndicators, dPrepOtherPhonesForRIs);

  //Calculte the count of phones in response
  dPhonesIn := PROJECT(dPrepForRIs_pre_info, TRANSFORM({$.Layouts.PhoneFinder.Final.phone}, SELF.phone := LEFT.phone));
  
  ThresholdA_PhoneTransactionCount := inMod.RiskIndicators(RiskId = $.Constants.RiskRules.PhoneTransactionCount)[1].ThresholdA;

  dPhoneTransactionsCount := IF(inMod.hasActivePhoneTransactionCountRule, 
                  $.GetPhoneTransactionCount(dPhonesIn(phone != ''), ThresholdA_PhoneTransactionCount)); 

  dPrepForRIs_pre := JOIN(dPrepForRIs_pre_info, dPhoneTransactionsCount,
                        LEFT.phone = RIGHT.phone,
                        TRANSFORM($.Layouts.PhoneFinder.Final, SELF.phone_inresponse_count := RIGHT.phonecount, SELF:= LEFT),
                        LEFT OUTER);

  dPrepForRIs := IF(EXISTS(dPrepForRIs_pre), dPrepForRIs_pre, PROJECT(dProcessInput, TRANSFORM($.Layouts.PhoneFinder.Final, 
                                                                                     SELF.phone := LEFT.homephone, SELF.fname :=LEFT.name_first,
                                                                                     SELF.lname := LEFT.name_last, SELF.prim_name := LEFT.prim_name, 
                                                                                     SELF.isPrimaryPhone := TRUE, // This will process the RiskIndicators for "no identity and no phone"
                                                                                     SELF := [])));


>>>>>>> 0f52f29534cf67a4f3465856552215003b2a6f02
  dRIs := IF(inMod.IncludeRiskIndicators, PhoneFinder_Services.CalculatePRIs(dPrepForRIs, inMod));
  
  dFinal := MAP(inMod.IncludeRiskIndicators AND inMod.IncludeOtherPhoneRiskIndicators => dRIs + dOtherIdentities,
                inMod.IncludeRiskIndicators                                           => dRIs + dPrepOtherPhonesForRIs + dOtherIdentities,
                dPrimaryForRIs + dPrepOtherPhonesForRIs + dOtherIdentities);

  #IF($.Constants.Debug.Main)
    OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo_PRI'));
    OUTPUT(dSearchResultsPrimaryPhone, NAMED('dSearchResultsPrimaryPhone_PRI'));
    IF(inMod.isPrimarySearchPII, OUTPUT(dSearchResultsOtherPhones, NAMED('dSearchResultsOtherPhones_PRI')));
    IF(inMod.isPrimarySearchPII, OUTPUT(dOtherPhoneInfo, NAMED('dOtherPhoneInfo_PRI')));
    OUTPUT(dIdentitiesFormat2Final, NAMED('dIdentitiesFormat2Final_PRI'));
    OUTPUT(dPrepIdentityForRI, NAMED('dPrepIdentityForRI_PRI'));
    OUTPUT(dPrepPrimaryForRIs, NAMED('dPrepPrimaryForRIs_PRI'));
    OUTPUT(dPrepPrimaryPhoneOnlyForRIs, NAMED('dPrepPrimaryPhoneOnlyForRIs_PRI'));
    OUTPUT(dPrimaryForRIs, NAMED('dPrimaryForRIs_PRI'));
    OUTPUT(dOtherIdentities, NAMED('dOtherIdentities_PRI'));
    IF(inMod.isPrimarySearchPII, OUTPUT(dPrepOtherPhonesForRIs, NAMED('dPrepOtherPhonesForRIs_PRI')));
    IF(inMod.IncludeRiskIndicators, OUTPUT(dPrepForRIs, NAMED('dPrepForRIs_PRI')));
    IF(inMod.IncludeRiskIndicators, OUTPUT(dRIs, NAMED('dRIs_PRI')));
  #END

  RETURN dFinal;
END;