IMPORT VotersV2, suppress, doxie, ut, census_data, codes, STD;
//NB: this is not fcra-compliant function; IsFCRA is just a placeholder now

out_rec := VotersV2_Services.layouts.SourceOutput;

EXPORT out_rec GetVotersSourceByID (
  GROUPED DATASET (VotersV2_Services.layout_vtid) in_vtids, //by acctno
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE,
  STRING32 appType) := FUNCTION

  out_rec GetCommonInfo (VotersV2_Services.layout_vtid L, VotersV2.Key_Voters_VTID R) := TRANSFORM
    SELF.did := INTFORMAT (R.did, 12, 1);

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

    SELF.name.title := R.title;
    SELF.name.lname := R.lname;
    SELF.name.fname := R.fname;
    SELF.name.mname := R.mname;
    SELF.name.name_suffix := R.name_suffix;
    SELF.name.name_score := R.name_score;

    SELF.gender_exp := codes.GENERAL.gender (STD.STR.ToUpperCase(R.gender)[1]);
    SELF.source_state_exp := codes.general.state_long (R.source_state);

    active_stat := TRIM (R.active_status, LEFT, RIGHT);
    SELF.active_status_exp := MAP (active_stat = 'A' => 'ACTIVE',
                                   active_stat = 'I' => 'INACTIVE', '');

    SELF.History := [];
    SELF := R;
  END;

  // Get general info
  fetched := JOIN (in_vtids, VotersV2.Key_Voters_VTID,
    KEYED (LEFT.vtid = RIGHT.vtid),
    GetCommonInfo (LEFT, RIGHT),
    //there can be more records per vtid than by did, but this constant is set to a safe threshhold
    LIMIT (ut.limits.VOTERS_PER_DID, SKIP));

  // Mask SSNs, pull by did, SSN
  Suppress.MAC_Suppress(fetched,ds_pull_1,appType,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(ds_pull_1,ds_pull_2,appType,Suppress.Constants.LinkTypes.SSN,ssn);
  Suppress.MAC_Mask(ds_pull_1, ds_mskd, ssn, null, TRUE, FALSE, maskVal:=in_ssn_mask_type);

  census_data.MAC_Fips2County_Keyed (ds_mskd, Res.st, Res.fips_county, Res.county, ds_cnty_1);
  census_data.MAC_Fips2County_Keyed (ds_cnty_1, Mail.st, Mail.fips_county, Mail.county, ds_voters);

  //Append history (child datasets)
  out_rec AddHistory (out_rec L) := TRANSFORM
    //NB: there are should be absolutely no duplicates in history
    hist := LIMIT (VotersV2.Key_Voters_History_VTID (KEYED (vtid = L.vtid)),
                   // "KEYED" can be used, but it produces dupes by some reason
                   ut.limits.VOTERS_HISTORY_MAX, /*KEYED,*/ SKIP);
    SELF.History := SORT (PROJECT (hist, layouts.HistoryByYear), -voted_year, -vote_date);
    SELF := L;
  END;

  res := PROJECT (ds_voters, AddHistory (LEFT));

  RETURN res;
END;
