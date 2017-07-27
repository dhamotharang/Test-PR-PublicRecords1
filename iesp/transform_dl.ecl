IMPORT DriversV2_Services;

out_rec := iesp.driverlicense2.t_DLEmbeddedReport2Record;
EXPORT out_rec transform_dl (dataset(DriversV2_Services.layouts.result_wide) dls) := FUNCTION

// values are taken mostly from DriversV2.Key_DL_Seq (DriversV2.File_DL_Search)
  out_rec toOut (DriversV2_Services.layouts.result_wide L) := transform
		Self.addr_no := l.addr_no;
    Self.DLSequenceId := (string) L.dl_seq;
    Self.UniqueId := intformat (L.did, 12, 1);

    // ESP actually exposes full name; DL 'name' comes from vendor,
    // so we need to "create" nicely formatted full name from cleaned name components
    string full_name := StringLib.StringCleanSpaces (L.fname + ' ' + L.mname + ' ' + L.lname);
		string city_name_2use := if (length(trim(L.v_city_name)) > 0, L.v_city_name, L.p_city_name);
    Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, full_name);
    _dob := iesp.ECL2ESP.toDate ((integer) L.dob);		
    Self.DOB := _dob;
    // TODO: this is tempo patch: need to implement real masking/converting
    Self.DOB2 := row ({(string)_dob.year, (string)_dob.month, (string)_dob.day}, iesp.share.t_MaskableDate);
    // it is not clear what mapping to use for "original"s vs. "regular". 
    Self.ExpirationDate := iesp.ECL2ESP.toDate ((integer) L.expiration_date);
    Self.IssueDate := iesp.ECL2ESP.toDate ((integer) L.lic_issue_date);
    Self.DriverLicense := L.dl_number;
    Self.SSN := L.ssn;
    Self.Height := L.height;
    Self.Weight := L.weight;
    Self.LicenseClassCode := L.license_class;
    Self.LicenseClass := L.license_class_name;
    Self.HairColor := L.hair_color_name;
    Self.EyeColor := L.eye_color_name;
    Self.LicenseType := L.license_type_name;
    Self.RecordType := L.rec_type;
    Self.Race   := L.race_name;
    Self.Sex    := L.sex_name;
    Self.Status := L.status_name;
    Self.CDLStatus := L.cdl_status;
    Self.History := L.history_name;
    Self.Attention := l.attention_name;
    Self.Restrictions := '';//L.restriction_cd; //?
    Self.Endorsements := L.lic_endorsement;
    Self.RestrictionsDetail := DATASET ([
      {trim (L.restriction1)}, {trim (L.restriction2)}, {trim (L.restriction3)}, {trim (L.restriction4)}, {trim (L.restriction5)}
    ], share.t_StringArrayItem) (value != '');
    Self.EndorsementsDetail := DATASET ([
      {trim (L.endorsement1)}, {trim (L.endorsement2)}, {trim (L.endorsement3)}, {trim (L.endorsement4)}, {trim (L.endorsement5)}
    ], share.t_StringArrayItem) (value != '');
    Self.MotorCycle := L.motorcycle_code;
    Self.Address := iesp.ECL2ESP.SetUniversalAddress (
                      L.prim_name, L.prim_range, L.predir, L.postdir,
                      L.suffix, L.unit_desig, L.sec_range, city_name_2use,
                      L.st, L.zip5, L.zip4, L.county_name,  
                      L.postal_code, , , , L.country, L.province, false);
    Self.DOD := iesp.ECL2ESP.toDate ((integer) L.dod);
    Self.OrigIssueDate := iesp.ECL2ESP.toDate ((integer) L.orig_issue_date);
    Self.OrigExpDate := iesp.ECL2ESP.toDate (L.orig_expiration_date);
    Self.ActiveDate := iesp.ECL2ESP.toDate (L.active_date);
    Self.InactiveDate := iesp.ECL2ESP.toDate (L.inactive_date);
    Self.NameChange := L.name_change;
    Self.AddressChange := L.address_change;
    Self.RestrictionsDelimited := L.restrictions_delimited;
    Self.OOSPrevDLNumber := L.oos_previous_dl_number;
    Self.OOSPrevState := L.oos_previous_st;
    Self.OldDLNumber := L.old_dl_number;
    Self.Issuance := L.issuance;
    Self.OriginState := L.orig_state;
    Self.OriginStateName  := L.orig_state_name;
    Self.Age := (integer) L.age;
    self.src := L.source_code;
		self.nonDMVSource := L.nonDMVSource;
		self.DateFirstSeen := iesp.ECL2ESP.toDateYM ((integer) L.dt_first_seen);
		self.DateLastSeen := iesp.ECL2ESP.toDateYM ((integer) L.dt_last_seen);
  end;

  RETURN project (dls, toOut (Left));

END;
