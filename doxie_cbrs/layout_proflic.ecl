IMPORT Prof_LicenseV2;
EXPORT layout_proflic := MODULE

  EXPORT out_rec := RECORD
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base - [global_sid, record_sid];
  END;

  EXPORT slim_rec := RECORD
    out_rec.bdid;
    out_rec.did;
    out_rec.profession_or_board;
    out_rec.license_type;
    out_rec.company_name;
    out_rec.orig_name;
    out_rec.license_obtained_by;
    out_rec.board_action_indicator;
    out_rec.status;
    out_rec.source_st;
    out_rec.license_number;
    out_rec.orig_license_number;
    out_rec.orig_addr_1;
    out_rec.orig_addr_2;
    out_rec.orig_addr_3;
    out_rec.orig_addr_4;
    out_rec.orig_city;
    out_rec.orig_st;
    out_rec.orig_zip;
    // Added fields are below.
    out_rec.best_ssn;
    out_rec.date_last_seen;
    out_rec.status_effective_dt;
    out_rec.fname;
    out_rec.mname;
    out_rec.lname;
    out_rec.name_suffix;
    out_rec.title;
    out_rec.prim_name;
    out_rec.prim_range;
    out_rec.predir;
    out_rec.postdir;
    out_rec.suffix;
    out_rec.unit_desig;
    out_rec.sec_range;
    out_rec.st;
    out_rec.v_city_name;
    out_rec.zip;
    out_rec.zip4;
    out_rec.county_name;
    out_rec.phone;
    out_rec.additional_phone;
    out_rec.sex;
    out_rec.dob;
    out_rec.issue_date;
    out_rec.expiration_date;
    out_rec.last_renewal_date;
    out_rec.misc_occupation;
    out_rec.misc_practice_hours;
    out_rec.misc_practice_type;
    out_rec.misc_email;
    out_rec.misc_fax;
    out_rec.Action_complaint_violation_dt;
    out_rec.Action_effective_dt;
    out_rec.Action_Posting_Status_dt;
    out_rec.action_record_type;
    out_rec.Action_complaint_violation_desc;
    out_rec.Action_desc;
    out_rec.action_status;
    out_rec.education_continuing_education;
    out_rec.education_1_school_attended;
    out_rec.education_1_degree;
    out_rec.education_1_curriculum;
    out_rec.education_1_dates_attended;
    out_rec.education_2_school_attended;
    out_rec.education_2_degree;
    out_rec.education_2_curriculum;
    out_rec.education_2_dates_attended;
    out_rec.education_3_school_attended;
    out_rec.education_3_degree;
    out_rec.education_3_curriculum;
    out_rec.education_3_dates_attended;
    out_rec.additional_licensing_specifics;
    out_rec.personal_pob_desc;
    out_rec.personal_race_desc;
  END;

END;
