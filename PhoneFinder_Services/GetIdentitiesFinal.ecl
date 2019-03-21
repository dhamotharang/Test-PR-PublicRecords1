IMPORT $, iesp, Phones, STD, ut;

EXPORT GetIdentitiesFinal(DATASET($.Layouts.PhoneFinder.Final) dSearchResults,
                          DATASET($.Layouts.BatchInAppendDID)  dInBestInfo,
                          $.iParam.ReportParams                inMod,
                          BOOLEAN                              isPhoneSearch) :=
FUNCTION
  today := (STRING)Std.Date.Today();

  dIdentitySlim := PROJECT(dSearchResults((lname != '' OR listed_name != '') AND typeflag != Phones.Constants.TypeFlag.DataSource_PV),
                            TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                      SELF.dt_first_seen := MAP(LENGTH(TRIM(LEFT.dt_first_seen)) = 8 => (INTEGER)LEFT.dt_first_seen,
                                                                LENGTH(TRIM(LEFT.dt_first_seen)) = 6 => (INTEGER)(LEFT.dt_first_seen + '00'),
                                                                LENGTH(TRIM(LEFT.dt_first_seen)) = 4 => (INTEGER)(LEFT.dt_first_seen + '0000'),
                                                                0),
                                      SELF.dt_last_seen  := MAP(LENGTH(TRIM(LEFT.dt_last_seen)) = 8 => (INTEGER)LEFT.dt_last_seen,
                                                                LENGTH(TRIM(LEFT.dt_last_seen)) = 6 => (INTEGER)(LEFT.dt_last_seen + '00'),
                                                                LENGTH(TRIM(LEFT.dt_last_seen)) = 4 => (INTEGER)(LEFT.dt_last_seen + '0000'),
                                                                0),
                                      SELF               := LEFT,
                                      SELF               := []));
  
  
  // Rollup
  $.Layouts.PhoneFinder.IdentitySlim tIdentityRollup($.Layouts.PhoneFinder.IdentitySlim le, $.Layouts.PhoneFinder.IdentitySlim ri) :=
  TRANSFORM
    SELF.dt_first_seen           := ut.Min2(le.dt_first_seen, ri.dt_first_seen);
    SELF.dt_last_seen            := IF(le.dt_last_seen <= (INTEGER)today AND le.dt_last_seen >= ri.dt_last_seen, le.dt_last_seen, ri.dt_last_seen);
    SELF.PhoneOwnershipIndicator := le.PhoneOwnershipIndicator OR ri.PhoneOwnershipIndicator;
    SELF                         := le;
  END;

  dDIDSort   := SORT(dIdentitySlim(did != 0), acctno, did, IF(PhoneOwnershipIndicator, 0, 1), -dt_last_seen, dt_first_seen);
  dDIDRollUp := ROLLUP(dDIDSort, tIdentityRollup(LEFT, RIGHT), acctno, did);
  
  dNoDIDSort   := SORT(dIdentitySlim(did = 0), acctno, IF(PhoneOwnershipIndicator, 0, 1), -dt_last_seen, dt_first_seen, RECORD);
  dNoDIDRollup := ROLLUP(dNoDIDSort, tIdentityRollup(LEFT, RIGHT), EXCEPT phone_source, penalt, dt_first_seen, dt_last_seen);
  
  // Combine and dedup the data
  dIdentities := dDIDRollUp & dNoDIDRollup;
  
  // Depending on the type of search, restrict the number of records to the max counts
  vMaxCount := IF(isPhoneSearch, iesp.Constants.Phone_Finder.MaxIdentities, iesp.Constants.Phone_Finder.MaxPhoneHistory);
  
  dIdentityTopn := DEDUP(SORT(dIdentities, acctno, IF(did != 0, 0, 1), penalt, IF(PhoneOwnershipIndicator, 0, 1), -dt_last_seen, dt_first_seen, phone_source), acctno, KEEP(vMaxCount));
  
  // Verification logic - ONLY for Phone search
  vmod := PROJECT(inMod, $.IParam.PhoneVerificationParams, OPT);

  $.Layouts.BatchIn input2Match($.Layouts.BatchInAppendDID pInput) := TRANSFORM
    SELF.z4    := pInput.zip4;
    SELF.phone := '';
    SELF       := pInput;
  END;

  dFormat2BatchIn := PROJECT(dInBestInfo, input2Match(LEFT));

	dVerifiedIdentity := $.GetVerifiedRecs(vmod).verify(dIdentityTopn, dFormat2BatchIn);
    
	doVerify := ~(inMod.IsPrimarySearchPII) AND (inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress);
  
  dIdentitiesInfo := IF(doVerify, dVerifiedIdentity, dIdentityTopn);	
	
  // Show the best name/address/DOD for the identities - Only for PII search
  $.Layouts.PhoneFinder.IdentitySlim tBestInfo($.Layouts.PhoneFinder.IdentitySlim le, $.Layouts.BatchInAppendDID ri) :=
  TRANSFORM
    SELF.did         := le.did;
    SELF.fname       := ri.name_first;
    SELF.mname       := ri.name_middle;
    SELF.lname       := ri.name_last;
    SELF.name_suffix := ri.name_suffix;
    SELF.prim_range  := ri.prim_range;
    SELF.predir      := ri.predir;  
    SELF.prim_name   := ri.prim_name;  
    SELF.suffix      := ri.addr_suffix;  
    SELF.postdir     := ri.prim_name;  
    SELF.unit_desig  := ri.unit_desig;  
    SELF.sec_range   := ri.sec_range;  
    SELF.city_name   := ri.p_city_name;  
    SELF.st          := ri.st;  
    SELF.zip         := ri.z5;  
    SELF.zip4        := ri.zip4;  
    SELF.county_code := '';  
    SELF.county_name := '';																																	
    SELF.Deceased    := IF((INTEGER)ri.dod != 0, 'Y', 'N');
    SELF             := le;
  END;
  
  dIdentityBestInfo := JOIN(dIdentitiesInfo,
                            dInBestInfo,
                            LEFT.acctno        = RIGHT.acctno AND
                            (UNSIGNED)LEFT.did = RIGHT.did,
                            tBestInfo(LEFT, RIGHT),
                            LEFT OUTER,
                            LIMIT(0), KEEP(1));

  dIdentitiesFinal := IF(isPhoneSearch, dIdentitiesInfo, dIdentityBestInfo);

  #IF($.Constants.Debug.Intermediate)
    OUTPUT(dIdentitySlim, NAMED('dIdentitySlim'), EXTEND);
    OUTPUT(dDIDRollUp, NAMED('dIdentityDIDRollUp'), EXTEND);
    OUTPUT(dNoDIDRollUp, NAMED('dIdentityNoDIDRollUp'), EXTEND);
    OUTPUT(dIdentityTopn, NAMED('dIdentityTopn'), EXTEND);
    OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo'), EXTEND);
  #END		
  
  RETURN dIdentitiesFinal;
END;