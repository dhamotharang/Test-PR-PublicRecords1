IMPORT $, STD, NID, MDR, iesp, ut, Address;

// Function only invoked during a PHONE search
EXPORT GetVerifiedRecs(DATASET($.Layouts.PhoneFinder.IdentitySlim) dIn,
                       DATASET($.Layouts.BatchIn) dInWithBestDIDs,
                       $.IParam.PhoneVerificationParams vmod) :=
FUNCTION
 
  // Match on DID
  matchDid ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R) :=
  (R.did > 0 AND L.did = R.did);

  //match last name
  matchLastName (STRING lname, STRING name_last) :=
  (
      name_last != '' AND (lname = STD.STR.ToUpperCase(name_last))
      OR
      (vmod.phoneticMatch AND metaphonelib.DMetaPhone1(lname) = metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(name_last)))
  );
  
  // Match on name, DID
  VerifyLastName ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R) := FUNCTION

  CleanName := Address.GetCleanNameAddress.CleanPersonName(L.listed_name, false);
  
  nameLastMatch := IF(L.fname= '' AND L.lname = '', (matchLastName(CleanName.lname, R.name_last)),
                      (matchLastName(L.lname, R.name_last))
                     );

  return nameLastMatch;
  END;
  
  matchFirstname (STRING fname, STRING name_first) :=
  (
  name_first != '' AND NID.mod_PFirstTools.PFLeqPFR(fname, STD.STR.ToUpperCase(name_first))
  );

  // Match on name, DID
  matchName ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R) := FUNCTION

  CleanName := Address.GetCleanNameAddress.CleanPersonName(L.listed_name, false);
  
  nameMatch := IF(L.fname= '' AND L.lname = '', (matchFirstname(CleanName.fname, R.name_first) AND matchLastName(CleanName.lname, R.name_last)),
                 (matchFirstname(L.fname, R.name_first) AND matchLastName(L.lname, R.name_last))
                 );

  return matchDid(L, R) OR nameMatch;
  END;

  // Match name or DID and address
  matchNameAddress ($.Layouts.PhoneFinder.IdentitySlim L, $.Layouts.BatchIn R)  :=
    (matchDid(L, R) OR
    ((matchName(L, R) AND
    (
    (
      (L.vendor_id = MDR.sourceTools.src_Targus_Gateway AND L.prim_range = '' AND L.prim_name = '' ) OR
      (R.prim_range != '' AND L.prim_range = R.prim_range AND R.prim_name != '' AND L.prim_name = STD.STR.ToUpperCase(R.prim_name))
    ) AND
   (
     (R.p_city_name != '' AND L.city_name = STD.STR.ToUpperCase(R.p_city_name) AND R.st != '' AND L.st = STD.STR.ToUpperCase(R.st))
     OR
     (R.z5 != '' AND L.zip = R.z5)
  )
  )
  )));

  // Phone active
  matchPhoneActive($.Layouts.PhoneFinder.IdentitySlim L) :=
  FUNCTION
    today := STD.Date.Today();

    timeWithPrimaryPhone   := IF(L.dt_first_seen != 0 AND L.dt_last_seen != 0, STD.Date.DaysBetween(L.dt_first_seen, L.dt_last_seen), 0);
    dateLastSeenFromToday  := IF(L.dt_last_seen != 0, STD.Date.DaysBetween(L.dt_last_seen, today), 0);
    dateFirstSeenFromToday := IF(L.dt_first_seen != 0, STD.Date.DaysBetween(L.dt_first_seen, today), 0);

    dateFirstSeenOk := ~vmod.useDateFirstSeenVerify OR dateFirstSeenFromToday > vmod.dateFirstSeenThreshold;
    dateLastSeenOk  := ~vmod.useDateLastSeenVerify OR dateLastSeenFromToday > vmod.dateLastSeenThreshold;
    lengthOfTimeOk  := ~vmod.useLengthOfTimeVerify OR timeWithPrimaryPhone > vmod.lengthOfTimeThreshold;

    isPhoneActive := (vmod.useDateFirstSeenVerify OR vmod.useDateLastSeenVerify OR vmod.useLengthOfTimeVerify) AND dateLastSeenOk AND dateFirstSeenOk AND lengthOfTimeOk;

    RETURN isPhoneActive;
  END;


  // Verify identity
  dVerifyIdentity := JOIN(dIn, dInWithBestDIDs,
                          LEFT.acctno = RIGHT.acctno,
                          TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                    BOOLEAN isNameAddrVerified := vmod.VerifyPhoneNameAddress AND matchNameAddress(LEFT, RIGHT);
                                    BOOLEAN isNameVerified     := vmod.VerifyPhoneName AND matchName(LEFT, RIGHT);
                                    BOOLEAN isLastNameVerified := vmod.VerifyPhoneLastName AND VerifyLastName(LEFT, RIGHT);
                                    BOOLEAN isIdentityMatch    := isNameAddrVerified OR isNameVerified OR isLastNameVerified;
                                    SELF.acctno               := IF(isIdentityMatch OR (~vmod.VerifyPhoneNameAddress AND ~vmod.VerifyPhoneName AND ~vmod.VerifyPhoneLastName), LEFT.acctno, SKIP),
                                    SELF.is_identity_verified := isIdentityMatch,
                                    SELF                      := LEFT),
                          LIMIT(0), KEEP(1));

  // Non verified identities
  dNonVerifiedIdentities := JOIN(dIn, dVerifyIdentity(is_identity_verified),
                                  LEFT.acctno = RIGHT.acctno,
                                  TRANSFORM(LEFT),
                                  LEFT ONLY);

  dIdentitiesAll := dVerifyIdentity(is_identity_verified) + dNonVerifiedIdentities;

  // Phone verification
  // Since verification happens only for a Phone search, you can pick any record
  dInPrimaryPhones := TOPN(GROUP(SORT(dIn, acctno), acctno), 1, acctno, -dt_last_seen, dt_first_seen);

  dPhoneVerify := PROJECT(dInPrimaryPhones,
                          TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                    SELF.is_phone_verified := vMod.VerifyPhoneIsActive AND matchPhoneActive(LEFT),
                                    SELF                   := LEFT));

  // Populate identity and phone verification flags
  //Only one verification check is allowed at a time, also, currently only Report service has these checks
  dVerify := JOIN(dIdentitiesAll,
                  dPhoneVerify,
                  LEFT.acctno = RIGHT.acctno,
                  TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                            SELF.verification_desc := MAP(RIGHT.phone = ''   => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotEntered,
                                                          vMod.VerifyPhoneNameAddress AND LEFT.is_identity_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesNameAddress,
                                                          vMod.VerifyPhoneName AND LEFT.is_identity_verified     => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesName,
                                                          vmod.VerifyPhoneLastName AND LEFT.is_identity_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesLastName,
                                                          (vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneLastName) AND ~LEFT.is_identity_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneCannotBeVerified,
                                                          vmod.VerifyPhoneIsActive AND RIGHT.is_phone_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneIsActive,
                                                          vmod.VerifyPhoneIsActive AND ~RIGHT.is_phone_verified => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotActive,

                                                          ''),
                            SELF.is_phone_verified := RIGHT.is_phone_verified, SELF := LEFT),
                  LIMIT(0), KEEP(1));

  #IF($.Constants.Debug.Main)
    IF(vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneIsActive, OUTPUT(dVerifyIdentity, NAMED('dVerifyIdentity')));
    IF(vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneIsActive, OUTPUT(dNonVerifiedIdentities, NAMED('dNonVerifiedIdentities')));
    IF(vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneIsActive, OUTPUT(dIdentitiesAll, NAMED('dIdentitiesAll')));
    IF(vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneIsActive, OUTPUT(dInPrimaryPhones, NAMED('dInPrimaryPhones')));
    IF(vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneIsActive, OUTPUT(dPhoneVerify, NAMED('dPhoneVerify')));
    IF(vmod.VerifyPhoneNameAddress OR vmod.VerifyPhoneName OR vmod.VerifyPhoneIsActive, OUTPUT(dVerify, NAMED('dVerify')));
  #END

  RETURN dVerify;
END;
