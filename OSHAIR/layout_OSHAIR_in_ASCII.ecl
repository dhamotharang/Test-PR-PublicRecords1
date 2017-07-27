EXPORT layout_OSHAIR_in_ASCII := MODULE

    // Programs sub-record
	EXPORT OSHAIR_program_rec := RECORD,maxLength(75000)
	   string1  program_type;
	   string25 program_value;
	END;

    // Related Activity sub-record
	EXPORT OSHAIR_related_activity_rec := RECORD,maxLength(75000)
	   string2                      rel_activity_item_number;
	   string1                      rel_activity_type;
	   big_endian unsigned integer4 rel_activity_number;
	   string1                      rel_activity_safety_flag;
	   string1                      rel_activity_health_flag;
	END;

    // Optional Information sub-record
	EXPORT OSHAIR_optional_info_rec := RECORD,maxLength(75000)
	   string1  opt_type;
	   string2  opt_id;
	   string12 opt_value;
	END;

    // Penalty/FTA or Miscellaneous Debt sub-record
	EXPORT OSHAIR_debt_rec := RECORD,maxLength(75000)
	   EBCDIC string1 debt_type;
	   EBCDIC string71 debt_payload;
	END;

    // Violation sub-record
	EXPORT OSHAIR_violations_rec := RECORD,maxLength(75000)
	   string1                      delete_flag;
	   big_endian unsigned integer4 issuance_date;
	   string2                      citation_number;
	   string3                      item_number;
	   string2                      item_group;
	   string1                      emphasis;
	   string2                      gravity;
	   decimal9_2                   current_penalty;
	   decimal9_2                   initial_penalty;
	   string1                      violation_type;
	   string1                      initial_violation_type;
	   string22                     fed_state_standard;
	   big_endian unsigned integer4 abatement_date;
	   decimal5                     number_instances;
	   string1                      related_event_code;
	   decimal5                     number_exposed;
	   string1                      abatement_complete;
	   big_endian unsigned integer4 earliest_contest_date;
	   string1                      violation_contest;
	   string1                      penalty_contest;
	   string1                      abatement_employer_contest;
	   string1                      abatement_employee_contest;
	   big_endian unsigned integer4 final_order_date;
	   string1                      pet_to_modify_abatement;
	   string1                      citation_amended;
	   string1                      informal_settlement_aggreement;
	   string1                      disposition_event;
	   big_endian unsigned integer4 fta_inspection_number;
	   decimal9_2                   fta_penalty;
	   big_endian unsigned integer4 fta_issuance_date;
	   big_endian unsigned integer4 fta_contest_date;
	   string1                      fta_ammended;
	   string1                      fta_isa;
	   string1                      fta_disposition_event;
	   big_endian unsigned integer4 fta_final_order_date;
	   string10                     hazard_category;
	   big_endian unsigned integer4 abatement_verify_date;
	END;

    // Penalty or FTA Event sub-record
	EXPORT OSHAIR_penalty_fta_event_rec := RECORD,maxLength(75000)
	   EBCDIC string1 history_type;
	   EBCDIC string7 history_cit_id;
	   EBCDIC string16 event_payload;
	END;

    // Hazardous Substance sub-record
	EXPORT OSHAIR_hazardous_substance_rec := RECORD,maxLength(75000)
	   string2 citation_number;
	   string3 item_number;
	   string2 item_group;
	   string4 hazardous_substance_1;
	   string4 hazardous_substance_2;
	   string4 hazardous_substance_3;
	   string4 hazardous_substance_4;
	   string4 hazardous_substance_5;
	END;

    // Accident sub-record
	EXPORT OSHAIR_Accident_rec := RECORD,maxLength(75000)
	   string20                     Name;
	   big_endian unsigned integer4 Related_Inspection_Number;
	   string1                      Sex;
	   string2                      Age;
	   string1                      Degree_of_Injury;
	   string2                      Nature_of_Injury;
	   string2                      Part_of_Body;
	   string2                      Source_of_Injury;
	   string2                      Event_Type;
	   string2                      Environmental_Factor;
	   string2                      Human_Factor;
	   string1                      Task_Assigned;
	   string5                      Hazardous_Substance;
	   string3                      Occupation_Code;
	END;

    // Administrative or Payment sub-record
	EXPORT OSHAIR_administrative_payment_rec := RECORD,maxLength(75000)
	   EBCDIC string1  admin_pay_type;
	   EBCDIC string20 admin_pay_payload;
	END;

    // Inspection record
	EXPORT inspection_rec := RECORD,maxLength(75000)
	  string1                      continuation_flag;
	  string1                      history_flag;
	  big_endian unsigned integer4 last_activity_date;
	  string1                      fed_state_flag;
	  string1                      previous_activity_type;
	  big_endian unsigned integer4 previous_activity_number;
	  big_endian unsigned integer4 activity_number;
	  string2                      region_code;
	  string3                      area_code;
	  string2                      office_code;
	  string5                      compliance_officer_id;
	  string1                      compliance_officer_job_title;
	  string4                      hist_area;
	  string5                      hist_report_number;
	  string30                     inspected_site_name;
	  string30                     inspected_site_street;
	  string2                      inspected_site_state;
	  decimal5                     inspected_site_zip;
	  big_endian unsigned integer2 inspected_site_city_code;
	  decimal3                     inspected_site_county_code;
	  big_endian unsigned integer4 duns_number;
	  string17                     host_establishment_key;
	  string1                      owner_type;
	  big_endian unsigned integer2 owner_code;
	  string1                      advance_notice_flag;
	  big_endian unsigned integer4 inspection_opening_date;
	  big_endian unsigned integer4 inspection_close_date;
	  string1                      safety_health_flag;
	  big_endian unsigned integer2 SIC_Code;
	  big_endian unsigned integer2 sic_guide;
	  big_endian unsigned integer2 sic_inspected;
	  string6                      naics_code;
	  string6                      naics_secondary_code;
	  string6                      naic_inspected;
	  string1                      inspection_type;
	  string1                      inspection_scope;
	  decimal5                     number_in_establishment;
	  decimal5                     number_covered;
	  decimal7                     number_total_employees;
	  string1                      walk_around_flag;
	  string1                      employees_interviewed_flag;
	  string1                      union_flag;
	  string1                      closed_case_flag;
	  string1                      why_no_inspection_code;
	  big_endian unsigned integer4 close_case_date;
	  string1                      safety_pg_manufacturing_insp_flag;
	  string1                      safety_pg_construction_insp_flag;
	  string1                      safety_pg_maritime_insp_flag;
	  string1                      health_pg_manufacturing_insp_flag;
	  string1                      health_pg_construction_insp_flag;
	  string1                      health_pg_maritime_insp_flag;
	  string1                      migrant_farm_insp_flag;
	  string1                      antic_served;
	  big_endian unsigned integer4 first_denial_date;
	  big_endian unsigned integer4 last_reenter_date;
	  decimal5_2                   bls_loss_workday_injury_rate;
	  string1                      informal_sh_program_init_flag;
	  string1                      informal_data_required;
	  big_endian unsigned integer4 penalties_due_date;
	  big_endian unsigned integer4 fta_due_date;
	  string1                      due_date_type;
	  big_endian unsigned integer2 pa_prep_time;
	  big_endian unsigned integer2 pa_travel_time;
	  big_endian unsigned integer2 pa_on_site_time;
	  big_endian unsigned integer2 pa_tech_supp_time;
	  big_endian unsigned integer2 pa_report_prep_time;
	  big_endian unsigned integer2 pa_other_conf_time;
	  big_endian unsigned integer2 pa_litigation_time;
	  big_endian unsigned integer2 pa_denial_time;
	  big_endian unsigned integer4 pa_sum_hours;
	  big_endian unsigned integer4 earliest_contest_date;
	  decimal11_2                  remitted_penalty_amount;
	  decimal11_2                  remitted_fta_amount;
	  decimal11_2                  total_penalties;
	  decimal11_2                  total_fta;
	  decimal5                     total_violations;
	  decimal5                     total_serious_violations;
	  unsigned integer2            number_program;
	  unsigned integer2            number_rel_activity;
	  unsigned integer2            number_optional_info;
	  unsigned integer2            number_debt;
	  unsigned integer2            number_violations;
	  unsigned integer2            number_event;
	  unsigned integer2            number_hazardous_substance;
	  unsigned integer2            number_accident;
	  unsigned integer2            number_admin_pay;
	  DATASET(OSHAIR_program_rec
	         ,count((big_endian unsigned integer2) SELF.number_program)) programs;
	  DATASET(OSHAIR_related_activity_rec
	         ,count((big_endian unsigned integer2) SELF.number_rel_activity)) related_activties;
	  DATASET(OSHAIR_optional_info_rec
	         , count((big_endian unsigned integer2) SELF.number_optional_info)) optional_information;
	  DATASET(OSHAIR_debt_rec
	         , count((big_endian unsigned integer2) SELF.number_debt)) debts;
	  DATASET(OSHAIR_violations_rec
	         , count((big_endian unsigned integer2) SELF.number_violations)) violations;
	  DATASET(OSHAIR_penalty_fta_event_rec
	         , count((big_endian unsigned integer2) SELF.number_event)) events;
	  DATASET(OSHAIR_hazardous_substance_rec
	         , count((big_endian unsigned integer2) SELF.number_hazardous_substance)) hazardous_substances;
	  DATASET(OSHAIR_Accident_rec
	         , count((big_endian unsigned integer2) SELF.number_accident)) accidents;
	  DATASET(OSHAIR_administrative_payment_rec
	         , count((big_endian unsigned integer2) SELF.number_admin_pay)) admin_payment;
 END;
END;