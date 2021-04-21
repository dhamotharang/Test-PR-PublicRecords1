IMPORT $, Advo, DID_Add, iesp, Phones, STD, ut, SSNBest_Services, Address;

EXPORT GetIdentitiesFinal(DATASET($.Layouts.PhoneFinder.Final) dSearchResults,
                          DATASET($.Layouts.BatchInAppendDID)  dInBestInfo,
                          $.iParam.SearchParams                inMod) :=
FUNCTION
  today := (STRING)Std.Date.Today();

  dIdentitySlim := PROJECT(dSearchResults,
                            TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                      SELF.dt_first_seen := MAP(LENGTH(TRIM(LEFT.dt_first_seen)) = 8 => (INTEGER)LEFT.dt_first_seen,
                                                                LENGTH(TRIM(LEFT.dt_first_seen)) = 6 => (INTEGER)(LEFT.dt_first_seen + '01'),
                                                                0),
                                      SELF.dt_last_seen  := MAP(LENGTH(TRIM(LEFT.dt_last_seen)) = 8 => (INTEGER)LEFT.dt_last_seen,
                                                                LENGTH(TRIM(LEFT.dt_last_seen)) = 6 => (INTEGER)(LEFT.dt_last_seen + '01'),
                                                                0),
                                      SELF               := LEFT,
                                      SELF               := []));

  // Hack for Zumigo date- Need a better fix - Typeflag P record having PO indicator
  dIdentitySlimPropagatePO := ITERATE(GROUP(SORT(dIdentitySlim, acctno, IF(isPrimaryIdentity, 0, 1), IF(PhoneOwnershipIndicator, 0, 1)), acctno),
                                      TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                                SELF.PhoneOwnershipIndicator := RIGHT.isPrimaryIdentity AND (COUNTER = 1 OR LEFT.phone = RIGHT.phone) AND (LEFT.PhoneOwnershipIndicator OR RIGHT.PhoneOwnershipIndicator),
                                                SELF.dt_last_seen            := IF(SELF.PhoneOwnershipIndicator, STD.Date.Today(), RIGHT.dt_last_seen),
                                                SELF                         := RIGHT));

  dIdentitySlimWithPO := IF(inMod.IsPrimarySearchPII, UNGROUP(dIdentitySlimPropagatePO), dIdentitySlim);

  dIdentitySlimFiltered := dIdentitySlimWithPO((lname != '' OR listed_name != '' OR Full_name != '') AND typeflag != Phones.Constants.TypeFlag.DataSource_PV);

  // Rollup
  $.Layouts.PhoneFinder.IdentitySlim tIdentityRollup($.Layouts.PhoneFinder.IdentitySlim le, $.Layouts.PhoneFinder.IdentitySlim ri) :=
  TRANSFORM
    BOOLEAN isAddrMissing := le.prim_range = '' AND le.prim_name = '';

    SELF.dt_first_seen           := ut.Min2(le.dt_first_seen, ri.dt_first_seen);
    // Hack for Zumigo - Need a better fix
    SELF.dt_last_seen            := IF(le.dt_last_seen <= (INTEGER)today AND le.dt_last_seen >= ri.dt_last_seen, le.dt_last_seen, ri.dt_last_seen);
    SELF.PhoneOwnershipIndicator := le.PhoneOwnershipIndicator OR ri.PhoneOwnershipIndicator;
    SELF.isPrimaryIdentity       := le.isPrimaryIdentity OR ri.isPrimaryIdentity;
    SELF.TNT                     := IF(le.TNT != '', le.TNT, ri.TNT);
    SELF.prim_range              := IF(isAddrMissing, ri.prim_range, le.prim_range);
    SELF.prim_name               := IF(isAddrMissing, ri.prim_name, le.prim_name);
    SELF.predir                  := IF(isAddrMissing, ri.predir, le.predir);
    SELF.suffix                  := IF(isAddrMissing, ri.suffix, le.suffix);
    SELF.postdir                 := IF(isAddrMissing, ri.postdir, le.postdir);
    SELF.unit_desig              := IF(isAddrMissing, ri.unit_desig, le.unit_desig);
    SELF.sec_range               := IF(isAddrMissing, ri.sec_range, le.sec_range);
    SELF.city_name               := IF(isAddrMissing, ri.city_name, le.city_name);
    SELF.st                      := IF(isAddrMissing, ri.st, le.st);
    SELF.zip                     := IF(isAddrMissing, ri.zip, le.zip);
    SELF.zip4                    := IF(isAddrMissing, ri.zip4, le.zip4);
    SELF.phn_src_all             := le.phn_src_all + ri.phn_src_all;
    SELF.imei_Tenure_MinDays     := IF(le.imei_Tenure_MinDays != 0, le.imei_Tenure_MinDays, ri.imei_Tenure_MinDays);
    SELF.imei_Tenure_MaxDays     := IF(le.imei_Tenure_MaxDays != 0, le.imei_Tenure_MaxDays, ri.imei_Tenure_MaxDays);
    SELF.sim_Tenure_MinDays      := IF(le.sim_Tenure_MinDays != 0, le.sim_Tenure_MinDays, ri.sim_Tenure_MinDays);
    SELF.sim_Tenure_MaxDays      := IF(le.sim_Tenure_MaxDays != 0, le.sim_Tenure_MaxDays, ri.sim_Tenure_MaxDays);
    SELF                         := le;
  END;

  dDIDSort   := SORT(dIdentitySlimFiltered(did != 0),
                      acctno, did, IF(isPrimaryIdentity, 0, 1), IF(PhoneOwnershipIndicator, 0, 1), IF(inMod.IsPrimarySearchPII, 0, penalt),
                      -dt_last_seen, IF(prim_name != '', 0, 1), IF(zip != '', 0, 1), dt_first_seen, RECORD);

  dDIDRollUp := ROLLUP(dDIDSort, tIdentityRollup(LEFT, RIGHT), acctno, did);

  dNoDIDSort   := SORT(dIdentitySlimFiltered(did = 0),
                        acctno, IF(isPrimaryIdentity, 0, 1), IF(PhoneOwnershipIndicator, 0, 1), IF(inMod.IsPrimarySearchPII, 0, penalt),
                        -dt_last_seen, IF(prim_name != '', 0, 1), IF(zip != '', 0, 1), dt_first_seen, RECORD);

  dNoDIDRollup := ROLLUP(dNoDIDSort, tIdentityRollup(LEFT, RIGHT), EXCEPT phone, phone_source, penalt, vendor_id, src, typeflag, dt_first_seen, dt_last_seen);

  // Combine and dedup the data
  dIdentities := dDIDRollUp & dNoDIDRollup;

  // Depending on the type of search, restrict the number of records to the max counts
  vMaxCount := IF(~inMod.IsPrimarySearchPII, iesp.Constants.Phone_Finder.MaxIdentities, iesp.Constants.Phone_Finder.MaxPhoneHistory);

  dIdentityTopn := DEDUP(SORT(dIdentities, acctno, IF(isPrimaryIdentity, 0, 1), IF(PhoneOwnershipIndicator, 0, 1),
                              IF(inMod.IsPrimarySearchPII, 0, penalt), IF(did != 0, 0, 1), penalt, -dt_last_seen, dt_first_seen, phone_source),
                              acctno, KEEP(vMaxCount));

  // Verification logic - ONLY for Phone search
  vmod := PROJECT(inMod, $.IParam.PhoneVerificationParams, OPT);

  // Need this for calculation of phone verification if no identities present
  doVerify := ~(inMod.IsPrimarySearchPII) AND (inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress OR inMod.VerifyPhoneLastName);

  dOtherRecs := JOIN( dIdentitySlim,
                      dIdentityTopn,
                      LEFT.acctno = RIGHT.acctno,
                      TRANSFORM(LEFT),
                      LEFT ONLY);

  dIdentityRecs := IF(doVerify, dIdentityTopn + dOtherRecs, dIdentityTopn);

  // Input criteria
  $.Layouts.BatchIn input2Match($.Layouts.BatchInAppendDID pInput) := TRANSFORM
    SELF.z4    := pInput.zip4;
    SELF.phone := '';
    SELF       := pInput;
  END;

  dFormat2BatchIn := PROJECT(dInBestInfo, input2Match(LEFT));

  dVerifiedIdentity := $.GetVerifiedRecs(dIdentityRecs, dFormat2BatchIn, vmod);

  dIdentitiesInfo := IF(doVerify, dVerifiedIdentity, dIdentityTopn);

  // Show the best name/address/DOD for the identities - Only for PII search
  $.Layouts.PhoneFinder.IdentitySlim tBestInfo($.Layouts.PhoneFinder.IdentitySlim le, $.Layouts.BatchInAppendDID ri) :=
  TRANSFORM
    BOOLEAN isInputDID := inMod.IsPrimarySearchPII AND ri.did != 0;
    UNSIGNED addressMatchScore := DID_Add.Address_Match_Score(le.prim_range, le.prim_name, le.sec_range, le.zip, ri.prim_range, ri.prim_name, ri.sec_range, ri.z5);
    BOOLEAN  isInputAddress := (ri.prim_range != ''and ri.prim_name != '' and ri.z5 != '');
    SELF.did         := le.did;
    SELF.InputDID    := ri.did;
    // Need to double check mapping - doesn't make any sense, but trying to match production
    tnt_value := MAP((UNSIGNED)le.did = 0 => '',
                      ri.did != 0 OR (addressMatchScore BETWEEN 76 AND 254 AND le.prim_range = ri.prim_range) => Phones.Constants.TNT.Current,
                      Phones.Constants.TNT.History);
    SELF.TNT         := IF(~inMod.IsPrimarySearchPII and ~isInputAddress, '', tnt_value); //In a phone search show TNT value only when input address exists.
    SELF.fname       := IF(isInputDID, ri.name_first, le.fname);
    SELF.mname       := IF(isInputDID, ri.name_middle, le.mname);
    SELF.lname       := IF(isInputDID, ri.name_last, le.lname);
    SELF.full_name   := IF(isInputDID, Address.NameFromComponents(ri.name_first, ri.name_middle, ri.name_last, ri.name_suffix), le.full_name),
    SELF.name_suffix := IF(isInputDID, ri.name_suffix, le.name_suffix);
    SELF.prim_range  := IF(isInputDID, ri.prim_range, le.prim_range);
    SELF.predir      := IF(isInputDID, ri.predir, le.predir);
    SELF.prim_name   := IF(isInputDID, ri.prim_name, le.prim_name);
    SELF.suffix      := IF(isInputDID, ri.addr_suffix, le.suffix);
    SELF.postdir     := IF(isInputDID, ri.postdir, le.postdir);
    SELF.unit_desig  := IF(isInputDID, ri.unit_desig, le.unit_desig);
    SELF.sec_range   := IF(isInputDID, ri.sec_range, le.sec_range);
    SELF.city_name   := IF(isInputDID, ri.p_city_name, le.city_name);
    SELF.st          := IF(isInputDID, ri.st, le.st);
    SELF.zip         := IF(isInputDID, ri.z5, le.zip);
    SELF.zip4        := IF(isInputDID, ri.zip4, le.zip4);
    SELF.dob         := IF(isInputDID, (INTEGER)ri.dob, le.dob);
    SELF.county_code := IF(isInputDID, '', le.county_code);
    SELF.county_name := IF(isInputDID, '', le.county_name);
    SELF.Deceased    := IF(isInputDID, IF((INTEGER)ri.dod != 0, 'Y', 'N'), le.Deceased);
    SELF             := le;
  END;

  dIdentitiesFinal := JOIN(dIdentitiesInfo,
                            dInBestInfo,
                            LEFT.acctno        = RIGHT.acctno AND
                            ((UNSIGNED)LEFT.did = RIGHT.did OR (~inMod.IsPrimarySearchPII and RIGHT.did = 0 AND RIGHT.z5 != '')),
                            tBestInfo(LEFT, RIGHT),
                            LEFT OUTER,
                            LIMIT(0), KEEP(1));

  // Primary Address flag: Look up data by address (using zip)
  dPrimaryAddressByZip := JOIN(dIdentitiesFinal, Advo.Key_Addr1,
                                KEYED(LEFT.zip != '' AND LEFT.zip = RIGHT.zip) AND
                                KEYED(LEFT.prim_range != '' AND LEFT.prim_range = RIGHT.prim_range) AND
                                KEYED(LEFT.prim_name != '' AND LEFT.prim_name = RIGHT.prim_name) AND
                                KEYED(LEFT.suffix = '' OR LEFT.suffix = RIGHT.addr_suffix) AND
                                KEYED(LEFT.predir = '' OR LEFT.predir = RIGHT.predir) AND
                                KEYED(LEFT.postdir = '' OR LEFT.postdir = RIGHT.postdir),
                                TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                          SELF.primary_address_type := Advo.Lookup_Descriptions.fn_resbus_mixed(RIGHT.Residential_Or_Business_Ind),
                                          SELF := LEFT),
                                LEFT OUTER,
                                LIMIT(0), KEEP(1));

  // Look up data by address (using City/State)
  dPrimaryAddressByCitySt := JOIN(dPrimaryAddressByZip(primary_address_type = ''), Advo.Key_Addr2,
                                  KEYED(LEFT.st != '' AND LEFT.st = RIGHT.st) AND
                                  KEYED(LEFT.city_name != '' AND LEFT.city_name = RIGHT.v_city_name) AND
                                  KEYED(LEFT.prim_range != '' AND LEFT.prim_range = RIGHT.prim_range) AND
                                  KEYED(LEFT.prim_name != '' AND LEFT.prim_name = RIGHT.prim_name),
                                  TRANSFORM($.Layouts.PhoneFinder.IdentitySlim,
                                            SELF.primary_address_type := Advo.Lookup_Descriptions.fn_resbus_mixed(RIGHT.Residential_Or_Business_Ind),
                                            SELF                      := LEFT),
                                  LEFT OUTER,
                                  LIMIT(0), KEEP(1));

  dSearchRecswAddrType := dPrimaryAddressByZip(primary_address_type <> '') + dPrimaryAddressByCitySt;

  //Append gov best SSN, SSN (Gov best) is returned only for Gov searches. If any other verticals need SSN we need to start using'getSSNBest' flag
  ssnBestParams := MODULE (PROJECT (inmod, SSNBest_Services.IParams.BatchParams, OPT))
  END;

  withGovBestSSN := SSNBest_Services.Functions.fetchSSNs_generic(dSearchRecswAddrType, ssnBestParams, ssn, did, false);

  dIdentitiesWssn := IF(inmod.IsGovsearch, withGovBestSSN, dSearchRecswAddrType);

  #IF($.Constants.Debug.Main)
    OUTPUT(dIdentitySlim, NAMED('dIdentitySlim'), EXTEND);
    IF(inMod.IsPrimarySearchPII, OUTPUT(dIdentitySlimPropagatePO, NAMED('dIdentitySlimPropagatePO'), EXTEND));
    OUTPUT(dIdentitySlimFiltered, NAMED('dIdentitySlimFiltered'), EXTEND);
    OUTPUT(dDIDRollUp, NAMED('dIdentityDIDRollUp'), EXTEND);
    OUTPUT(dNoDIDRollUp, NAMED('dIdentityNoDIDRollUp'), EXTEND);
    OUTPUT(dIdentityTopn, NAMED('dIdentityTopn'), EXTEND);
    IF(doVerify, OUTPUT(dOtherRecs, NAMED('dOtherRecs'), EXTEND));
    OUTPUT(dIdentityRecs, NAMED('dIdentityRecs'), EXTEND);
    IF(doVerify, OUTPUT(dFormat2BatchIn, NAMED('dFormat2BatchIn_Verify'), EXTEND));
    OUTPUT(dIdentitiesInfo, NAMED('dIdentitiesInfo'), EXTEND);
    OUTPUT(dIdentitiesFinal, NAMED('dIdentitiesFinal'), EXTEND);
    OUTPUT(dPrimaryAddressByZip, NAMED('dPrimaryAddressByZip'), EXTEND);
    OUTPUT(dPrimaryAddressByCitySt, NAMED('dPrimaryAddressByCitySt'), EXTEND);
  #END

  RETURN dIdentitiesWssn;
END;
