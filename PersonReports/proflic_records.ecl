IMPORT iesp, doxie, prof_LicenseV2_Services;
IMPORT $;

iesp.proflicense.t_PL2Action SetAction (
  string _type, string violation_description, string8 violation_date, string8 effective_date,
  string description, string status, string8 posting_date) := FUNCTION

  iesp.proflicense.t_PL2Action xform () := transform
    Self._Type := _type;
    Self.ViolationDescription := violation_description;
    Self.ViolationDate := iesp.ECL2ESP.toDatestring8 (violation_date);
    Self.EffectiveDate := iesp.ECL2ESP.toDatestring8 (effective_date);
    Self.Description := description;
    Self.Status := status;
    Self.PostingDate := iesp.ECL2ESP.toDatestring8 (posting_date);
    Self := [];
  end;
  return Row (xform ());
END;

iesp.proflicense.t_PL2Education SetEducation (string school, string degree, string curriculum, string dates) := FUNCTION
  iesp.proflicense.t_PL2Education xform () := transform
    Self.School := school;
    Self.Degree := degree;
    Self.Curriculum := curriculum;
    Self.DatesAttended := dates;
  end;
  return Row (xform ());
END;

EXPORT proflic_records (
  dataset (doxie.layout_references) dids,
  $.IParam.proflic in_params,
  boolean IsFCRA = false
) := MODULE

  mod_access := PROJECT (in_params, doxie.IDataAccess);

  ds_raw := prof_LicenseV2_Services.Prof_Lic_Raw.source_view.by_did(dids, , mod_access, isFCRA);

  iesp.proflicense.t_ProfessionalLicenseRecord FormatReport (prof_LicenseV2_Services.Assorted_Layouts.Layout_report L) := transform
    self.LicenseType := L.license_type;
    self.LicenseNumber := L.license_number; //? Orig_License_Number
    self.ProviderNumber := L.ProviderId;
    self.SanctionNumber := L.sanc_id;
    self.SSN := L.best_ssn;
    self.DateLastSeen := iesp.ECL2ESP.toDate ((integer4) L.date_last_seen);
    self.ProfessionOrBoard := L.profession_or_board;
    self.Status := L.Status;
    self.StatusEffectiveDate := iesp.ECL2ESP.toDate ((integer4) L.status_effective_dt);
    self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    self.OriginalName := iesp.ECL2ESP.SetName ('', '', '', '', '',L.Orig_name);
    self.AdditionalOrigName := iesp.ECL2ESP.SetName ('', '', '', '','',L.Additional_Orig_name);

    self.CompanyName := L.company_name;
    self.Address := iesp.ECL2ESP.SetAddress (
      L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, L.sec_range,
      L.v_city_name, L.st, l.zip, l.zip4, l.county_name);
    self.OriginalAddress := [];
    self.AdditionalOrigAddress := [];

    self.Phone := L.phone;
    self.TimeZone := '';
    self.AdditionalPhone := L.additional_phone;
    self.Gender := L.sex;
    self.DOB := iesp.ECL2ESP.toDate ((integer4) L.dob);
    self.IssuedDate := iesp.ECL2ESP.toDate ((integer4) L.issue_date);
    self.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.expiration_date);
    self.LastRenewalDate := iesp.ECL2ESP.toDate ((integer4) L.last_renewal_date);
    self.LicenseObtainedBy := L.license_obtained_by;

    self.BoardActionIndicator := L.board_action_indicator;

    self.SourceState := L.source_st; //? source_st_decoded
    self.Occupation := L.misc_occupation;
    self.PracticeHours := (integer) L.misc_practice_hours;
    self.PracticeType := L.misc_practice_type;
    self.Email := L.misc_email;
    self.Fax := L.misc_fax;

    self.Action := SetAction (
      L.action_record_type, L.Action_complaint_violation_desc, L.Action_complaint_violation_dt,
      L.Action_effective_dt, L.Action_desc, L.action_status, L.Action_Posting_Status_dt);

        // Prof_License.Layout_proLic_in.Action_case_number;
    self.ContinueEducation := L.education_continuing_education;
    self.Education1 := SetEducation (L.education_1_school_attended, L.education_1_degree, L.education_1_curriculum, L.education_1_dates_attended);
    self.Education2 := SetEducation (L.education_2_school_attended, L.education_2_degree, L.education_2_curriculum, L.education_2_dates_attended);
    self.Education3 := SetEducation (L.education_3_school_attended, L.education_3_degree, L.education_3_curriculum, L.education_3_dates_attended);

    self.AdditionalLicensingSpecs := L.additional_licensing_specifics;
    self.PlaceOfBirth := L.personal_pob_desc;
    self.Race := L.personal_race_desc;
    self := [];
  end;

  EXPORT proflicenses_v2 := if (~IsFCRA, PROJECT (ds_raw, FormatReport (Left)));

  EXPORT proflicenses := dataset ([], iesp.proflicense.t_PLRecord);

END;