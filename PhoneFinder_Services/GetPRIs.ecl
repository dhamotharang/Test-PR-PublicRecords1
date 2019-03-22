IMPORT $;

EXPORT GetPRIs( DATASET($.Layouts.PhoneFinder.Final)     dSearchResults,
                DATASET($.Layouts.BatchInAppendDID)      dInBestInfo,
                PhoneFinder_Services.iParam.ReportParams inMod) :=
FUNCTION
  // Identities
  dIdentitiesInfo   := PhoneFinder_Services.GetIdentitiesFinal(dSearchResults, dInBestInfo, inMod, ~inMod.IsPrimarySearchPII);

  // Primary phone
  dSearchResultsPrimaryPhone := IF(~inMod.IsPrimarySearchPII,
                                    dSearchResults,
                                    dSearchResults(isPrimaryPhone AND phone_source in [PhoneFinder_Services.Constants.PhoneSource.Waterfall,
                                                                                      PhoneFinder_Services.Constants.PhoneSource.QSentGateway]));

  dPrimaryPhoneInfo := PhoneFinder_Services.GetPhonesFinal(dSearchResultsPrimaryPhone, inMod, TRUE);
  
  // Other phones
  dSearchResultsOtherPhones := dSearchResults(~isPrimaryPhone);
  
  dOtherPhoneInfo := PhoneFinder_Services.GetPhonesFinal(dSearchResultsOtherPhones, inMod, FALSE);

  // Prep for Risk indicator calculation
  // Pass only the top identity record for RI calculation
  dIdentityInfoSort := SORT(dIdentitiesInfo, acctno, IF(did != 0, 0, 1), IF(PhoneOwnershipIndicator, 0, 1), penalt, -dt_last_seen, IF(dt_first_seen != 0, dt_first_seen, 0), phone_source, RECORD);
  
  dPrepIdentityForRI := DATASET(dIdentityInfoSort[1]);

  dPrepPrimaryForRIs := JOIN( dPrepIdentityForRI,
                              dPrimaryPhoneInfo,
                              LEFT.acctno = RIGHT.acctno,
                              TRANSFORM($.Layouts.PhoneFinder.Final,
                                        SELF.isPrimaryPhone    := TRUE;
                                        SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                        SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                        SELF.is_verified       := LEFT.is_identity_verified OR LEFT.is_phone_verified,
                                        SELF.listed_name       := RIGHT.ListingName,
                                        SELF.RealTimePhone_Ext := RIGHT,
                                        SELF := LEFT, SELF := RIGHT, SELF := []),
                              LEFT OUTER,
                              LIMIT(0), KEEP(1));

  dPrepOtherPhonesForRIs := PROJECT(dOtherPhoneInfo,
                                    TRANSFORM($.Layouts.PhoneFinder.Final,
                                              SELF.isPrimaryPhone    := FALSE,
                                              SELF.dt_first_seen     := (STRING)LEFT.dt_first_seen,
                                              SELF.dt_last_seen      := (STRING)LEFT.dt_last_seen,
                                              SELF.listed_name       := LEFT.ListingName,
                                              SELF.RealTimePhone_Ext := LEFT,
                                              SELF := LEFT, SELF := []));

  // Send primary and other phones for RI calculation
  dPrepForRIs := dPrepPrimaryForRIs & IF(inMod.IncludeOtherPhoneRiskIndicators, dPrepOtherPhonesForRIs);

  dRIs := PhoneFinder_Services.CalculatePRIs(dPrepForRIs, inMod) +
          IF(~inMod.IncludeOtherPhoneRiskIndicators, dPrepOtherPhonesForRIs) +
          PROJECT(dIdentityInfoSort[2..],
                  TRANSFORM($.Layouts.PhoneFinder.Final,
                  SELF.isPrimaryPhone := FALSE,
                  SELF.dt_first_seen  := (STRING)LEFT.dt_first_seen,
                  SELF.dt_last_seen   := (STRING)LEFT.dt_last_seen,
                  SELF.is_verified    := LEFT.is_identity_verified OR LEFT.is_phone_verified,
                  SELF := LEFT, SELF := []));

  #IF($.Constants.Debug.Intermediate)
    OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo'));
    OUTPUT(dSearchResultsPrimaryPhone, NAMED('dSearchResultsPrimaryPhone'));
    OUTPUT(dSearchResultsOtherPhones, NAMED('dSearchResultsOtherPhones'));
    OUTPUT(dOtherPhoneInfo, NAMED('dOtherPhoneInfo'));
    OUTPUT(dIdentityInfoSort, NAMED('dIdentityInfoSort'));
    OUTPUT(dPrepPrimaryForRIs, NAMED('dPrepPrimaryForRIs'));
    OUTPUT(dPrepOtherPhonesForRIs, NAMED('dPrepOtherPhonesForRIs'));
    OUTPUT(dPrepForRIs, NAMED('dPrepForRIs'));
  #END

  RETURN dRIs;
END;