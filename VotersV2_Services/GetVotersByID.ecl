// ========================================================
// Returns voter's info from the source file; no history.
// Result is:
// penalized;
// masked in relation to SSN mask;
// pulled by did, ssn, vtid
// ========================================================

IMPORT VotersV2, ut, doxie, suppress, census_data, doxie, codes, STD;

out_rec := VotersV2_Services.layouts.ReportSearchShared;
 
EXPORT out_rec GetVotersByID (
  GROUPED DATASET (VotersV2_Services.layout_vtid) in_vtids,
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE //reserved for possible future needs
) := FUNCTION

  doxie.MAC_Header_Field_Declare (); // unfortunately: only to get input city name! Should be gone after interfaces are done

  GetBestCity (STRING25 vcity, STRING25 pcity) := MAP (
    vcity = '' => pcity,
    pcity = '' => vcity,
    ut.StringSimilar (vcity, city_value) <= ut.StringSimilar (pcity, city_value) => vcity, pcity
  );

  out_rec GetCommonInfo (VotersV2_Services.layout_vtid L, VotersV2.Key_Voters_VTID R) := TRANSFORM
    SELF.did := INTFORMAT (R.did, 12, 1);
    // address penalty portion is calculated as minimum of resid. & mail addresses penalty;
    // note that county is not in the input, so it is ignored;
    mail_penalt := doxie.FN_Tra_Penalty_Addr (R.mail_predir, R.mail_prim_range, R.mail_prim_name, R.mail_addr_suffix,
                                              R.mail_postdir, R.mail_sec_range,
                                              GetBestCity (R.mail_v_city_name, R.mail_p_city_name),
                                              R.mail_st, R.mail_ace_zip);
                                              // + doxie.FN_Tra_Penalty_County (R.mail_county);

    res_penalt := doxie.FN_Tra_Penalty_Addr (R.predir, R.prim_range, R.prim_name, R.addr_suffix,
                                              R.postdir, R.sec_range, GetBestCity (R.v_city_name, R.p_city_name),
                                              R.st, R.zip);
                                              // + doxie.FN_Tra_Penalty_County (R.county);

    SELF.penalt := doxie.FN_Tra_Penalty_Name (R.fname, R.mname, R.lname) +
                   doxie.FN_Tra_Penalty_SSN (R.ssn) +
                   doxie.FN_Tra_Penalty_DOB (R.dob) +
                   doxie.FN_Tra_Penalty_DID ((STRING) R.did) +
                   IF (res_penalt <= mail_penalt, res_penalt, mail_penalt) +
                   doxie.Fn_Tra_Penalty_Phone (R.phone);

    SELF.Res.prim_range := R.prim_range;
    SELF.Res.predir := R.predir;
    SELF.Res.prim_name := R.prim_name;
    SELF.Res.addr_suffix := R.addr_suffix;
    SELF.Res.postdir := R.postdir;
    SELF.Res.unit_desig := R.unit_desig;
    SELF.Res.sec_range := R.sec_range;
    SELF.Res.p_city_name := R.p_city_name;
    SELF.Res.v_city_name := R.v_city_name;
    SELF.Res.st := R.st;
    SELF.Res.zip5 := R.zip;
    SELF.Res.zip4 := R.zip4;
    SELF.Res.fips_state := R.ace_fips_st;
    SELF.Res.fips_county := R.fips_county;
    SELF.Res.addr_rec_type := R.rec_type;
    SELF.Res.county := '';

    SELF.Mail.prim_range := R.mail_prim_range;
    SELF.Mail.predir := R.mail_predir;
    SELF.Mail.prim_name := R.mail_prim_name;
    SELF.Mail.addr_suffix := R.mail_addr_suffix;
    SELF.Mail.postdir := R.mail_postdir;
    SELF.Mail.unit_desig := R.mail_unit_desig;
    SELF.Mail.sec_range := R.mail_sec_range;
    SELF.Mail.p_city_name := R.mail_p_city_name;
    SELF.Mail.v_city_name := R.mail_v_city_name;
    SELF.Mail.st := R.mail_st;
    SELF.Mail.zip5 := R.mail_ace_zip;
    SELF.Mail.zip4 := R.mail_zip4;
    SELF.Mail.fips_state := R.mail_ace_fips_st;
    SELF.Mail.fips_county := R.mail_fips_county;
    SELF.Mail.addr_rec_type := R.mail_rec_type;
    SELF.Mail.county := '';

    SELF.gender_exp := codes.GENERAL.gender (STD.STR.ToUpperCase(R.gender)[1]);
    SELF.source_state_exp := codes.general.state_long (R.source_state);
    SELF.name.title := R.title;
    SELF.name.lname := R.lname;
    SELF.name.fname := R.fname;
    SELF.name.mname := R.mname;
    SELF.name.name_suffix := R.name_suffix;
    SELF.name.name_score := R.name_score;

    SELF := R;
  END;

  fetched := JOIN (in_vtids, VotersV2.Key_Voters_VTID,
                   KEYED (LEFT.vtid = RIGHT.vtid),
                   GetCommonInfo (LEFT, RIGHT),
                   //there can be more records per vtid than by did, but this constant is set to a safe threshhold
                   LIMIT (ut.limits.VOTERS_PER_DID, SKIP));


  // mask ssn, pull IDs

  Suppress.MAC_Suppress(fetched,ds_pull_1,application_type_value,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(ds_pull_1,ds_pull_2,application_type_value,Suppress.Constants.LinkTypes.SSN,ssn);

  Suppress.MAC_Mask(ds_pull_2, ds_mskd, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);

  census_data.MAC_Fips2County_Keyed (ds_mskd, Res.st, Res.fips_county, Res.county, ds_cnty_1);
  census_data.MAC_Fips2County_Keyed (ds_cnty_1, Mail.st, Mail.fips_county, Mail.county, ds_cnty_2);

  res := ds_cnty_2;
  RETURN res;
END;
