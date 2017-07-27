IMPORT DriversV2_Services;

// values are taken mostly from DriversV2.Key_DL_Seq (DriversV2.File_DL_Search)
//TODO: it has a lot in common with iesp.transform_dl; discuss with ESP using shared layout(s) or at least field names.
EXPORT bps_share.t_BpsReportDriverLicense transform_dl_bps (DriversV2_Services.layouts.result_wide L) := TRANSFORM
  // it is not clear what mapping to use for "original"s vs. "regular". 
  Self.LicenseNumber := L.dl_number;
  Self.IssueDate := iesp.ECL2ESP.toDate ((integer) L.lic_issue_date);
  Self.OriginalIssueDate  := iesp.ECL2ESP.toDate ((integer) L.orig_issue_date);
  Self.IssueState := L.orig_state; //?
  Self.LicenseType := L.license_type_name;
  Self.LicenseClass := L.license_class_name;
  Self.Attention := L.attention_flag;
  Self.LicenseTypeCode := L.license_type; //?
  Self.RestrictionCodes := '';
  Self.EndorsementCodes := '';
  Self.ExpirationDate := iesp.ECL2ESP.toDate ((integer) L.expiration_date);

  // ESP actually exposes full name; DL 'name' comes from vendor,
  // so we need to "create" nicely formatted full name from cleaned name components
  string full_name := StringLib.StringCleanSpaces (L.fname + ' ' + L.mname + ' ' + L.lname);
	string city_name_2use := if (length(trim(L.v_city_name)) > 0, L.v_city_name, L.p_city_name);
  Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, full_name);
  Self.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, 
                    L.sec_range, city_name_2use, L.st, L.zip5, L.zip4, L.county_name, L.postal_code);

  Self.DOB := iesp.ECL2ESP.toDate ((integer) L.dob);
  Self.Age := (integer) L.age;
  Self.SSN := L.ssn;
  Self.Sex  := L.sex_name;
  Self.Race   := L.race_name;
  Self.Height := L.height;
  Self.Weight := L.weight;
  Self.HairColor := L.hair_color_name;
  Self.EyeColor := L.eye_color_name;
  Self.History := L.history;
  Self.StateName := L.orig_state_name; //?
  Self.Restrictions := DATASET ([
    {trim (L.restriction1)}, {trim (L.restriction2)}, {trim (L.restriction3)}, {trim (L.restriction4)}, {trim (L.restriction5)}
  ], share.t_StringArrayItem) (value != '');
  Self.Endorsements := DATASET ([
    {trim (L.endorsement1)}, {trim (L.endorsement2)}, {trim (L.endorsement3)}, {trim (L.endorsement4)}, {trim (L.endorsement5)}
  ], share.t_StringArrayItem) (value != '');
  self.src := L.source_code;
	self.nonDMVSource := L.nonDMVSource;
	self.DateFirstSeen := iesp.ECL2ESP.toDateYM ((integer) L.dt_first_seen);
	self.DateLastSeen := iesp.ECL2ESP.toDateYM ((integer) L.dt_last_seen);
END;
