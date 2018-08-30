IMPORT $, STD, NID, MDR, iesp, ut;

EXPORT GetVerifiedRecs($.IParam.PhoneVerificationParams vmod) := MODULE
   
   SHARED matchDid ($.Layouts.PhoneFinder.IdentityIesp L, $.Layouts.BatchIn R) :=
    (R.did>0 AND (UNSIGNED) L.UniqueId = R.did);
  
   SHARED matchName ($.Layouts.PhoneFinder.IdentityIesp L, $.Layouts.BatchIn R) :=
    (matchDid(L, R) OR
    ( 
      NID.mod_PFirstTools.PFLeqPFR(L.Name.First, STD.STR.ToUpperCase(R.name_first)) AND                            
      (
        (L.Name.Last = STD.STR.ToUpperCase(R.name_last)) 
        OR
        (vmod.phoneticMatch AND metaphonelib.DMetaPhone1(L.Name.Last) = metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(R.name_last)))
      )
    ));      

  SHARED matchNameAddress ($.Layouts.PhoneFinder.IdentityIesp L, $.Layouts.BatchIn R)  :=
   (matchDid(L, R) OR
    ((matchName(L, R) AND 
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

  SHARED matchPhoneActive($.Layouts.PhoneFinder.IdentityIesp L) := 
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

  EXPORT verify(DATASET($.Layouts.PhoneFinder.IdentityIesp) dIdentitiesInfo, iesp.phonefinder.t_PhoneFinderSearchBy pSearchBy, string best_did) := 
  FUNCTION

    $.Layouts.BatchIn input2Match() := TRANSFORM
        self.acctno      := '';
        self.name_first  := pSearchBy.Name.first;
        self.name_middle := pSearchBy.Name.middle;
        self.name_last   := pSearchBy.Name.last;
        self.name_suffix := pSearchBy.Name.suffix;
        self.prim_range  := pSearchBy.Address.streetNumber;
        self.predir      := pSearchBy.Address.streetPreDirection;
        self.prim_name   := pSearchBy.Address.streetName;
        self.addr_suffix := pSearchBy.Address.streetSuffix;
        self.postdir     := pSearchBy.Address.streetPostDirection;
        self.unit_desig  := pSearchBy.Address.unitDesignation;
        self.sec_range   := pSearchBy.Address.unitNumber;
        self.p_city_name := pSearchBy.Address.city;
        self.st          := pSearchBy.Address.state;
        self.z5          := pSearchBy.Address.zip5;
        self.z4          := pSearchBy.Address.zip4;
        self.phone       := pSearchBy.PhoneNumber;
        self.did         := (UNSIGNED) best_did;
        self.ssn         := pSearchBy.ssn;
    END;
    R := ROW(input2Match()); // Raw input for verification with best did

    // If at least one address component was supplied, it is a name/address match.
    checkNameAddress := R.prim_range <> '' OR R.prim_name <> '' OR R.p_city_name <> '' OR R.st <> '' OR R.z5 <> '';
    checkName:= R.name_first <> '' OR R.name_last <> '';    
    
    vrecs_name_match := TOPN(PROJECT(dIdentitiesInfo, TRANSFORM($.Layouts.PhoneFinder.IdentityIesp,      
      SELF.UniqueId := IF(matchName(LEFT, R), LEFT.UniqueId, SKIP);
      SELF := LEFT;
      )), 1, -LastSeenWithPrimaryPhone);
    
    vrecs_name_addr_match := TOPN(PROJECT(dIdentitiesInfo, TRANSFORM($.Layouts.PhoneFinder.IdentityIesp,      
      SELF.UniqueId := IF(matchNameAddress(LEFT, R), LEFT.UniqueId, SKIP);
      SELF := LEFT;
      )), 1, -LastSeenWithPrimaryPhone);

    vrecs_phone := MAP(
      checkNameAddress => vrecs_name_addr_match, 
      checkName => vrecs_name_match,
      dIdentitiesInfo
    );  
    // I'm not seeing how vrecs_phone[1] below makes sense here. Keeping it to match code in production.
    vrecs_phone_active := IF(matchPhoneActive(vrecs_phone[1]), vrecs_phone);

    RETURN MAP(
      vmod.VerifyPhoneName => vrecs_name_match,
      vmod.VerifyPhoneNameAddress => vrecs_name_addr_match,
      vmod.VerifyPhoneIsActive => vrecs_phone_active,
      DATASET([], $.Layouts.PhoneFinder.IdentityIesp)
    );

  END;

  EXPORT verifyBatch(DATASET($.Layouts.PhoneFinder.IdentityIesp) dIdentitiesInfo, DATASET($.Layouts.BatchIn) dInWithBestDIDs) := 
  FUNCTION

    vmatchNameOnly := ~vmod.VerifyPhoneNameAddress and vmod.VerifyPhoneName;

    vrecs := JOIN(dIdentitiesInfo, dInWithBestDIDs, 
      left.acctno = right.acctno AND
      (
        (vmod.VerifyPhoneNameAddress AND matchNameAddress(LEFT, RIGHT)) OR 
        (vmatchNameOnly AND matchName(LEFT, RIGHT))
      ),
      TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    RETURN vrecs;      
  END;
  
END;
