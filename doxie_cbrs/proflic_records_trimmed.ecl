EXPORT proflic_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

pro_lics := doxie_cbrs.proflic_records_dayton(bdids)(Include_ProfessionalLicenses_val);

pro_lic_record := RECORD
  pro_lics.bdid;
  pro_lics.did;
  pro_lics.profession_or_board;
  pro_lics.license_type;
  pro_lics.company_name;
  pro_lics.orig_name;
  pro_lics.license_obtained_by;
  pro_lics.board_action_indicator;
  pro_lics.status;
  pro_lics.source_st;
  pro_lics.license_number;
  pro_lics.orig_license_number;
  pro_lics.orig_addr_1;
  pro_lics.orig_addr_2;
  pro_lics.orig_addr_3;
  pro_lics.orig_addr_4;
  pro_lics.orig_city;
  pro_lics.orig_st;
  pro_lics.orig_zip;
  // Added fields are below.
  pro_lics.best_ssn;
  pro_lics.date_last_seen;
  pro_lics.status_effective_dt;
  pro_lics.fname;
  pro_lics.mname;
  pro_lics.lname;
  pro_lics.name_suffix;
  pro_lics.title;
  pro_lics.prim_name;
  pro_lics.prim_range;
  pro_lics.predir;
  pro_lics.postdir;
  pro_lics.suffix;
  pro_lics.unit_desig;
  pro_lics.sec_range;
  pro_lics.st;
  pro_lics.v_city_name;
  pro_lics.zip;
  pro_lics.zip4;
  pro_lics.county_name;
  pro_lics.phone;
  pro_lics.additional_phone;
  pro_lics.sex;
  pro_lics.dob;
  pro_lics.issue_date;
  pro_lics.expiration_date;
  pro_lics.last_renewal_date;
  pro_lics.misc_occupation;
  pro_lics.misc_practice_hours;
  pro_lics.misc_practice_type;
  pro_lics.misc_email;
  pro_lics.misc_fax;
  pro_lics.Action_complaint_violation_dt;
  pro_lics.Action_effective_dt;
  pro_lics.Action_Posting_Status_dt;
  pro_lics.action_record_type;
  pro_lics.Action_complaint_violation_desc;
  pro_lics.Action_desc;
  pro_lics.action_status;
  pro_lics.education_continuing_education;
  pro_lics.education_1_school_attended;
  pro_lics.education_1_degree;
  pro_lics.education_1_curriculum;
  pro_lics.education_1_dates_attended;
  pro_lics.education_2_school_attended;
  pro_lics.education_2_degree;
  pro_lics.education_2_curriculum;
  pro_lics.education_2_dates_attended;
  pro_lics.education_3_school_attended;
  pro_lics.education_3_degree;
  pro_lics.education_3_curriculum;
  pro_lics.education_3_dates_attended;
  pro_lics.additional_licensing_specifics;
  pro_lics.personal_pob_desc;
  pro_lics.personal_race_desc;
END;

pro_lic_record pro_lics_slimmed(pro_lics l) := TRANSFORM
  SELF := l;
END;

SHARED pl_slim := PROJECT(pro_lics,pro_lics_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(pl_slim, Max_ProfessionalLicenses_val);
EXPORT records_count := COUNT(pl_slim);

END;
