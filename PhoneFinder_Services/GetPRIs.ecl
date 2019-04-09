IMPORT $, STD;

EXPORT GetPRIs( DATASET($.Layouts.PhoneFinder.Final)     dSearchResults,
                DATASET($.Layouts.BatchInAppendDID)      dInBestInfo,
                PhoneFinder_Services.iParam.ReportParams inMod) :=
FUNCTION
  // Identities
  dIdentitiesInfo   := PhoneFinder_Services.GetIdentitiesFinal(dSearchResults, dInBestInfo, inMod);

  // Primary phone
  dSearchResultsPrimaryPhone := IF(~inMod.IsPrimarySearchPII,
                                    dSearchResults,
                                    dSearchResults(isPrimaryPhone AND phone_source in [PhoneFinder_Services.Constants.PhoneSource.Waterfall,
                                                                                      PhoneFinder_Services.Constants.PhoneSource.QSentGateway]));

  dPrimaryPhoneInfo := PhoneFinder_Services.GetPhonesFinal(dSearchResultsPrimaryPhone, inMod, TRUE);
  
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
  dIdentityInfoGrp := SORT(GROUP(SORT(dIdentitiesFormat2Final, acctno), acctno),
                            IF(did != 0, 0, 1), IF(PhoneOwnershipIndicator, 0, 1), penalt, -dt_last_seen, IF(dt_first_seen != '', dt_first_seen, '99999999'), phone_source, RECORD);
  
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
                                        SELF.listed_name       := RIGHT.ListingName,
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
  dPrepOtherPhonesForRIs := PROJECT(dOtherPhoneInfo,
                                    TRANSFORM($.Layouts.PhoneFinder.Final,
                                              SELF.isPrimaryPhone    := FALSE,
                                              SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                              SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                              SELF.listed_name       := LEFT.ListingName,
                                              SELF.phoneState        := LEFT.phone_state,
                                              SELF.listing_type_res  := IF(STD.Str.Find(LEFT.ListingType, 'RESIDENTIAL') > 0, 'R', ''),
                                              SELF.listing_type_bus  := IF(STD.Str.Find(LEFT.ListingType, 'BUSINESS') > 0, 'B', ''),
                                              SELF.listing_type_gov  := IF(STD.Str.Find(LEFT.ListingType, 'GOVERNMENT') > 0, 'G', ''),
                                              SELF.RealTimePhone_Ext := LEFT,
                                              SELF := LEFT, SELF := []));

  // Send primary and other phones for RI calculation
  dPrepForRIs := dPrimaryForRIs & IF(inMod.IncludeOtherPhoneRiskIndicators, dPrepOtherPhonesForRIs);
  
  dRIs := IF(inMod.IncludeRiskIndicators, PhoneFinder_Services.CalculatePRIs(dPrepForRIs, inMod));
  
  dFinal := MAP(inMod.IncludeRiskIndicators AND inMod.IncludeOtherPhoneRiskIndicators => dRIs + dOtherIdentities,
                inMod.IncludeRiskIndicators                                           => dRIs + dPrepOtherPhonesForRIs + dOtherIdentities,
                dPrimaryForRIs + dPrepOtherPhonesForRIs);

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