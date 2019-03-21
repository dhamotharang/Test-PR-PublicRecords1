IMPORT $, STD, NID, MDR, iesp, ut;

// Function only invoked during a PHONE search
EXPORT GetVerifiedRecs($.IParam.PhoneVerificationParams vmod) := MODULE
   
  SHARED matchDid ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R) :=
  (R.did > 0 AND L.did = R.did);

  SHARED matchName ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R) :=
  (matchDid(L, R) OR
  ( 
    NID.mod_PFirstTools.PFLeqPFR(L.fname, STD.STR.ToUpperCase(R.name_first)) AND                            
    (
      (L.lname = STD.STR.ToUpperCase(R.name_last)) 
      OR
      (vmod.phoneticMatch AND metaphonelib.DMetaPhone1(L.lname) = metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(R.name_last)))
    )
  ));
  
  SHARED matchNameAddress ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R)  :=
    (matchDid(L, R) OR
    ((matchName(L, R) AND 
    (
      (L.vendor_id = MDR.sourceTools.src_Targus_Gateway AND L.prim_range = '' AND L.prim_name = '') 
      OR      
      (
        (L.prim_range = R.prim_range AND L.prim_name = STD.STR.ToUpperCase(R.prim_name)) AND 
        (
          (L.city_name = STD.STR.ToUpperCase(R.p_city_name) AND L.st = STD.STR.ToUpperCase(R.st))
          OR
          (L.zip = R.z5)
        )
      )
    ))));

  SHARED matchPhoneActive($.Layouts.PhoneFinder.IdentitySlim L) := 
  FUNCTION
      
    today := (STRING) STD.Date.Today();   

    sDateFirstSeen := (STRING)L.dt_first_seen;
    sDateLastSeen  := (STRING)L.dt_last_seen;
      
    timeWithPrimaryPhone := (STRING) ut.DaysApart(sDateFirstSeen, sDateLastSeen);
    dateLastSeenFromToday := (STRING) ut.DaysApart(today, sDateLastSeen);
    dateFirstSeenFromToday := (STRING) ut.DaysApart(today, sDateFirstSeen);
                          
    dateFirstSeenOk := ~vmod.useDateFirstSeenVerify OR (INTEGER) dateFirstSeenFromToday > vmod.dateFirstSeenThreshold;                      
    dateLastSeenOk := ~vmod.useDateLastSeenVerify OR (INTEGER) dateLastSeenFromToday > vmod.dateLastSeenThreshold;        
    lengthOfTimeOk := ~vmod.useLengthOfTimeVerify OR (INTEGER) timeWithPrimaryPhone > vmod.lengthOfTimeThreshold; 
                          
    isPhoneActive := dateLastSeenOk AND dateFirstSeenOk AND lengthOfTimeOk;

    RETURN isPhoneActive;   
        
  END;

  SHARED matchDidBatch ($.Layouts.PhoneFinder.IdentityIesp L, $.Layouts.BatchIn R) :=
  (R.did>0 AND (UNSIGNED) L.UniqueId = R.did);

  SHARED matchNameBatch ($.Layouts.PhoneFinder.IdentityIesp L, $.Layouts.BatchIn R) :=
  (matchDidBatch(L, R) OR
  ( 
    NID.mod_PFirstTools.PFLeqPFR(L.Name.First, STD.STR.ToUpperCase(R.name_first)) AND                            
    (
      (L.Name.Last = STD.STR.ToUpperCase(R.name_last)) 
      OR
      (vmod.phoneticMatch AND metaphonelib.DMetaPhone1(L.Name.Last) = metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(R.name_last)))
    )
  ));

  SHARED matchNameAddressBatch ($.Layouts.PhoneFinder.IdentityIesp L, $.Layouts.BatchIn R)  :=
    (matchDidBatch(L, R) OR
    ((matchNameBatch(L, R) AND 
    (
      (L.vendor_id = MDR.sourceTools.src_Targus_Gateway AND L.RecentAddress.StreetNumber = '' AND L.RecentAddress.StreetName = '') 
      OR      
      (
        (L.RecentAddress.StreetNumber = R.prim_range AND L.RecentAddress.StreetName = STD.STR.ToUpperCase(R.prim_name)) AND 
        (
          (L.RecentAddress.City = STD.STR.ToUpperCase(R.p_city_name) AND L.RecentAddress.State = STD.STR.ToUpperCase(R.st))
          OR
          (L.RecentAddress.Zip5 = R.z5)
        )
      )
    ))));

  SHARED matchPhoneActiveBatch($.Layouts.PhoneFinder.IdentityIesp L) := 
  FUNCTION
      
    today := (STRING) STD.Date.Today();   

    sDateFirstSeen := iesp.ECL2ESP.DateToString(L.FirstSeenWithPrimaryPhone);
    sDateLastSeen := iesp.ECL2ESP.DateToString(L.LastSeenWithPrimaryPhone);
      
    timeWithPrimaryPhone := (STRING) ut.DaysApart(sDateFirstSeen, sDateLastSeen);
    dateLastSeenFromToday := (STRING) ut.DaysApart(today, sDateLastSeen);
    dateFirstSeenFromToday := (STRING) ut.DaysApart(today, sDateFirstSeen);
                          
    dateFirstSeenOk := ~vmod.useDateFirstSeenVerify OR (INTEGER) dateFirstSeenFromToday > vmod.dateFirstSeenThreshold;                      
    dateLastSeenOk := ~vmod.useDateLastSeenVerify OR (INTEGER) dateLastSeenFromToday > vmod.dateLastSeenThreshold;        
    lengthOfTimeOk := ~vmod.useLengthOfTimeVerify OR (INTEGER) timeWithPrimaryPhone > vmod.lengthOfTimeThreshold; 
                          
    isPhoneActive := dateLastSeenOk AND dateFirstSeenOk AND lengthOfTimeOk;

    RETURN isPhoneActive;   
        
  END;

  EXPORT verify(DATASET($.Layouts.PhoneFinder.IdentitySlim) dIn, DATASET($.Layouts.BatchIn) dInWithBestDIDs) := 
  FUNCTION
    dVerifyIdentity := JOIN(dIn, dInWithBestDIDs, 
                            LEFT.acctno = RIGHT.acctno,
                            TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                      BOOLEAN isNameAddrVerified := vmod.VerifyPhoneNameAddress AND matchNameAddress(LEFT, RIGHT);
                                      BOOLEAN isNameVerified     := vmod.VerifyPhoneName AND matchName(LEFT, RIGHT);

                                      SELF.acctno               := IF(isNameAddrVerified OR isNameVerified OR (~vmod.VerifyPhoneNameAddress AND ~vmod.VerifyPhoneName), LEFT.acctno, SKIP),
                                      SELF.is_identity_verified := isNameAddrVerified OR isNameVerified,
                                      SELF                      := LEFT),
                            LIMIT(0), KEEP(1));
    
    // Non verified identities
    dNonVerifiedIdentities := JOIN(dIn, dVerifyIdentity(is_identity_verified),
                                    LEFT.acctno = RIGHT.acctno,
                                    TRANSFORM(LEFT),
                                    LEFT ONLY);
    
    dIdentitiesAll := dVerifyIdentity(is_identity_verified) + dNonVerifiedIdentities;
    
    // Phone verification
    dInPrimaryPhones := TOPN(GROUP(SORT(dIn, acctno), acctno), 1, acctno, -dt_last_seen, dt_first_seen);

    dPhoneVerify := PROJECT(dInPrimaryPhones,
                            TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                      SELF.is_phone_verified := vMod.VerifyPhoneIsActive AND matchPhoneActive(LEFT),
                                      SELF                   := LEFT));
    
    // Populate identity and phone verification flags
    dVerify := JOIN(dIdentitiesAll,
                    dPhoneVerify,
                    LEFT.acctno = RIGHT.acctno,
                    TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                              SELF.verification_desc := MAP(RIGHT.phone = ''   => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotEntered,
                                                            vMod.VerifyPhoneNameAddress AND LEFT.is_identity_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesNameAddress,
                                                            vMod.VerifyPhoneName AND LEFT.is_identity_verified     => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesName,
                                                            (vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName) AND ~LEFT.is_identity_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneCannotBeVerified,
                                                            vmod.VerifyPhoneIsActive AND RIGHT.is_phone_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneIsActive,
                                                            vmod.VerifyPhoneIsActive AND ~RIGHT.is_phone_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotActive,
                                                            ''),
                              SELF.is_phone_verified := RIGHT.is_phone_verified, SELF := LEFT),
                    LIMIT(0), KEEP(1));
  
    #IF($.Constants.Debug.Intermediate)
      OUTPUT(dVerifyIdentity, NAMED('dVerifyIdentity'));
      OUTPUT(dNonVerifiedIdentities, NAMED('dNonVerifiedIdentities'));
      OUTPUT(dIdentitiesAll, NAMED('dIdentitiesAll'));
      OUTPUT(dInPrimaryPhones, NAMED('dInPrimaryPhones'));
      OUTPUT(dPhoneVerify, NAMED('dPhoneVerify'));
      OUTPUT(dVerify, NAMED('dVerify'));
    #END

    RETURN dVerify;
  END;

  EXPORT verifyBatch(DATASET($.Layouts.PhoneFinder.IdentityIesp) dIdentitiesInfo, DATASET($.Layouts.BatchIn) dInWithBestDIDs) := 
  FUNCTION

    vmatchNameOnly := ~vmod.VerifyPhoneNameAddress and vmod.VerifyPhoneName;

    vrecs := JOIN(dIdentitiesInfo, dInWithBestDIDs, 
      left.acctno = right.acctno AND
      (
        (vmod.VerifyPhoneNameAddress AND matchNameAddressBatch(LEFT, RIGHT)) OR 
        (vmatchNameOnly AND matchNameBatch(LEFT, RIGHT))
      ),
      TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    RETURN vrecs;      
  END;
  
END;
