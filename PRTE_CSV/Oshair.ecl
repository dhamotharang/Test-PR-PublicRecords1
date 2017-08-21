EXPORT Oshair := 

MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	'20091214';
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

  SHARED Base := 
	RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 fips_state;
   string3 fips_county;
   string2 addr_rec_type;
  END;

SHARED name :=
RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

EXPORT rthor_data400__key__oshair_accident	:=
RECORD
  big_endian unsigned integer4 activity_number;
  string20 name;
  big_endian unsigned integer4 related_inspection_number;
  string1 sex;
  unsigned1 age;
  string1 degree_of_injury;
  string2 nature_of_injury;
  string2 part_of_body;
  string2 source_of_injury;
  string2 event_type;
  string2 environmental_factor;
  string2 human_factor;
  string1 task_assigned;
  string5 hazardous_substance;
  string3 occupation_code;
  name victim;
  string22 deg_of_injury_desc;
  string20 nat_of_inj_desc;
  string10 part_of_body_desc;
  string20 src_of_inj_desc;
  string20 event_desc;
  string30 env_factor_desc;
  string33 human_factor_desc;
  string39 task_assigned_desc;
  string50 hazardous_sub_desc;
  string50 occupation_desc;
  unsigned8 __internal_fpos__;
 END;
 
EXPORT rthor_data400__key__oshair_inspection := 
RECORD
    big_endian unsigned integer4 activity_number;
    string1 continuation_flag;
    string1 history_flag;
    string20 history_desc;
    big_endian unsigned integer4 last_activity_date;
    string1 fed_state_flag;
    string1 previous_activity_type;
    string31 prev_activity_type_desc;
    big_endian unsigned integer4 previous_activity_number;
    string2 region_code;
    string3 area_code;
    string2 office_code;
    string5 compliance_officer_id;
    string1 compliance_officer_job_title;
    string20 compl_officer_job_title_desc;
    string4 hist_area;
    string5 hist_report_number;
    string30 inspected_site_name;
    string30 inspected_site_street;
    string2 inspected_site_state;
    decimal5 inspected_site_zip;
    big_endian unsigned integer2 inspected_site_city_code;
    string30 inspected_site_city_name;
    decimal3 inspected_site_county_code;
    big_endian unsigned integer4 duns_number;
    string17 host_establishment_key;
    string1 owner_type;
    string18 own_type_desc;
    big_endian unsigned integer2 owner_code;
    string1 advance_notice_flag;
    big_endian unsigned integer4 inspection_opening_date;
    big_endian unsigned integer4 inspection_close_date;
    string1 safety_health_flag;
    big_endian unsigned integer2 sic_code;
    big_endian unsigned integer2 sic_guide;
    big_endian unsigned integer2 sic_inspected;
    string6 naics_code;
    string6 naics_secondary_code;
    string6 naic_inspected;
    string1 inspection_type;
    string27 insp_type_desc;
    string1 inspection_scope;
    string13 insp_scope_desc;
    decimal5 number_in_establishment;
    decimal5 number_covered;
    decimal7 number_total_employees;
    string1 walk_around_flag;
    string1 employees_interviewed_flag;
    string1 union_flag;
    string1 closed_case_flag;
    string1 why_no_inspection_code;
    big_endian unsigned integer4 close_case_date;
    string1 safety_pg_manufacturing_insp_flag;
    string1 safety_pg_construction_insp_flag;
    string1 safety_pg_maritime_insp_flag;
    string1 health_pg_manufacturing_insp_flag;
    string1 health_pg_construction_insp_flag;
    string1 health_pg_maritime_insp_flag;
    string1 migrant_farm_insp_flag;
    string1 antic_served;
    big_endian unsigned integer4 first_denial_date;
    big_endian unsigned integer4 last_reenter_date;
    decimal5_2 bls_loss_workday_injury_rate;
    string1 informal_sh_program_init_flag;
    string1 informal_data_required;
    big_endian unsigned integer4 penalties_due_date;
    big_endian unsigned integer4 fta_due_date;
    string1 due_date_type;
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
    decimal11_2 remitted_penalty_amount;
    decimal11_2 remitted_fta_amount;
    decimal11_2 total_penalties;
    decimal11_2 total_fta;
    decimal5 total_violations;
    decimal5 total_serious_violations;
    unsigned2 number_program;
    unsigned2 number_rel_activity;
    unsigned2 number_optional_info;
    unsigned2 number_debt;
    unsigned2 number_violations;
    unsigned2 number_event;
    unsigned2 number_hazardous_substance;
    unsigned2 number_accident;
    unsigned2 number_admin_pay;
    string30 cname;
    unsigned6 bdid;
    unsigned2 bdid_score;
    string9 fein_append;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2 st;
    string5 zip5;
    string4 zip4;
    string2 fips_state;
    string3 fips_county;
    string2 addr_rec_type;
    string10 geo_lat;
    string11 geo_long;
    string4 cbsa;
    string7 geo_blk;
    string1 geo_match;
    string4 cart;
    string1 cr_sort_sz;
    string4 lot;
    string1 lot_order;
    string2 dpbc;
    string1 chk_digit;
    string4 err_stat;
    unsigned8 __internal_fpos__;
END;

EXPORT rthor_data400__key__oshair_addressb2 := 
RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

EXPORT rthor_data400__key__oshair_citystnameb2 := 
RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

EXPORT rthor_data400__key__oshair_fein2 := 
RECORD
  string1 f1;
  string1 f2;
  string1 f3;
  string1 f4;
  string1 f5;
  string1 f6;
  string1 f7;
  string1 f8;
  string1 f9;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

EXPORT rthor_data400__key__oshair_nameb2 := 
RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

EXPORT rthor_data400__key__oshair_namewords2 := 
RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
END;

EXPORT rthor_data400__key__oshair_payload	:=
RECORD
  unsigned6 fakeid;
  big_endian unsigned integer4 activity_number;
  big_endian unsigned integer4 last_activity_date;
  big_endian unsigned integer4 previous_activity_number;
  string30 cname;
  unsigned6 bdid;
  unsigned2 bdid_score;
  string9 fein_append;
  Base addr;
  unsigned1 zero;
  string1 blank;
  unsigned6 fdid;
END;

EXPORT rthor_data400__key__oshair_stnameb2 := 
RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

EXPORT rthor_data400__key__oshair_zipb2	:=
RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups
END;

EXPORT rthor_data400__key__oshair_bdid	:=
RECORD
  unsigned6 bdid; 
	big_endian unsigned integer4 activity_number; 
END;

EXPORT rthor_data400__key__oshair_hazardous_substance	:=
RECORD
  big_endian unsigned integer4 activity_number;
  string2 citation_number;
  string3 item_number;
  string2 item_group;
  string4 hazardous_substance_1;
  string4 hazardous_substance_2;
  string4 hazardous_substance_3;
  string4 hazardous_substance_4;
  string4 hazardous_substance_5;
  string50 hazardous_sub_desc_1;
  string50 hazardous_sub_desc_2;
  string50 hazardous_sub_desc_3;
  string50 hazardous_sub_desc_4;
  string50 hazardous_sub_desc_5;
  unsigned8 __internal_fpos__;
END;
 
EXPORT rthor_data400__key__oshair_program	:=
RECORD
  big_endian unsigned integer4 activity_number;
  string1 program_type;
  string25 program_value;
  unsigned8 __internal_fpos__;
END;

EXPORT rthor_data400__key__oshair_violations	:=
RECORD
  big_endian unsigned integer4 activity_number;
  string1 delete_flag;
  big_endian unsigned integer4 issuance_date;
  string2 citation_number;
  string3 item_number;
  string2 item_group;
  string1 emphasis;
  string2 gravity;
  decimal9_2 current_penalty;
  decimal9_2 initial_penalty;
  string1 violation_type;
  string1 initial_violation_type;
  string22 fed_state_standard;
  big_endian unsigned integer4 abatement_date;
  decimal5 number_instances;
  string1 related_event_code;
  decimal5 number_exposed;
  string1 abatement_complete;
  big_endian unsigned integer4 earliest_contest_date;
  string1 violation_contest;
  string1 penalty_contest;
  string1 abatement_employer_contest;
  string1 abatement_employee_contest;
  big_endian unsigned integer4 final_order_date;
  string1 pet_to_modify_abatement;
  string1 citation_amended;
  string1 informal_settlement_aggreement;
  string1 disposition_event;
  big_endian unsigned integer4 fta_inspection_number;
  decimal9_2 fta_penalty;
  big_endian unsigned integer4 fta_issuance_date;
  big_endian unsigned integer4 fta_contest_date;
  string1 fta_ammended;
  string1 fta_isa;
  string1 fta_disposition_event;
  big_endian unsigned integer4 fta_final_order_date;
  string10 hazard_category;
  big_endian unsigned integer4 abatement_verify_date;
  string15 violation_desc;
  string20 related_event_desc;
  string68 abatement_comp_desc;
  string33 disposition_event_desc;
  string40 fta_disposition_event_desc;
  unsigned8 __internal_fpos__;
END;

EXPORT rthor_data400__key__oshair_linkids	:=
RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned8 source_rec_id;
  string2 source;
  string1 continuation_flag;
  string1 history_flag;
  string20 history_desc;
  big_endian unsigned integer4 last_activity_date;
  string1 fed_state_flag;
  string1 previous_activity_type;
  string31 prev_activity_type_desc;
  big_endian unsigned integer4 previous_activity_number;
  big_endian unsigned integer4 activity_number;
  string2 region_code;
  string3 area_code;
  string2 office_code;
  string5 compliance_officer_id;
  string1 compliance_officer_job_title;
  string20 compl_officer_job_title_desc;
  string4 hist_area;
  string5 hist_report_number;
  string30 inspected_site_name;
  string30 inspected_site_street;
  string2 inspected_site_state;
  decimal5 inspected_site_zip;
  big_endian unsigned integer2 inspected_site_city_code;
  string30 inspected_site_city_name;
  decimal3 inspected_site_county_code;
  big_endian unsigned integer4 duns_number;
  string17 host_establishment_key;
  string1 owner_type;
  string18 own_type_desc;
  big_endian unsigned integer2 owner_code;
  string1 advance_notice_flag;
  big_endian unsigned integer4 inspection_opening_date;
  big_endian unsigned integer4 inspection_close_date;
  string1 safety_health_flag;
  big_endian unsigned integer2 sic_code;
  big_endian unsigned integer2 sic_guide;
  big_endian unsigned integer2 sic_inspected;
  string6 naics_code;
  string6 naics_secondary_code;
  string6 naic_inspected;
  string1 inspection_type;
  string27 insp_type_desc;
  string1 inspection_scope;
  string13 insp_scope_desc;
  decimal5 number_in_establishment;
  decimal5 number_covered;
  decimal7 number_total_employees;
  string1 walk_around_flag;
  string1 employees_interviewed_flag;
  string1 union_flag;
  string1 closed_case_flag;
  string1 why_no_inspection_code;
  big_endian unsigned integer4 close_case_date;
  string1 safety_pg_manufacturing_insp_flag;
  string1 safety_pg_construction_insp_flag;
  string1 safety_pg_maritime_insp_flag;
  string1 health_pg_manufacturing_insp_flag;
  string1 health_pg_construction_insp_flag;
  string1 health_pg_maritime_insp_flag;
  string1 migrant_farm_insp_flag;
  string1 antic_served;
  big_endian unsigned integer4 first_denial_date;
  big_endian unsigned integer4 last_reenter_date;
  decimal5_2 bls_loss_workday_injury_rate;
  string1 informal_sh_program_init_flag;
  string1 informal_data_required;
  big_endian unsigned integer4 penalties_due_date;
  big_endian unsigned integer4 fta_due_date;
  string1 due_date_type;
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
  decimal11_2 remitted_penalty_amount;
  decimal11_2 remitted_fta_amount;
  decimal11_2 total_penalties;
  decimal11_2 total_fta;
  decimal5 total_violations;
  decimal5 total_serious_violations;
  unsigned2 number_program;
  unsigned2 number_rel_activity;
  unsigned2 number_optional_info;
  unsigned2 number_debt;
  unsigned2 number_violations;
  unsigned2 number_event;
  unsigned2 number_hazardous_substance;
  unsigned2 number_accident;
  unsigned2 number_admin_pay;
  string30 cname;
  unsigned6 bdid;
  unsigned2 bdid_score;
  string9 fein_append;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 fips_state;
  string3 fips_county;
  string2 addr_rec_type;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string4 err_stat;
  integer1 fp;
END;

EXPORT dthor_data400__key__oshair__accident   	       := DATASET([], rthor_data400__key__oshair_accident);
EXPORT dthor_data400__key__oshair__inspection 	       := DATASET([], rthor_data400__key__oshair_inspection);
EXPORT dthor_data400__key__oshair__addressb2 	         := DATASET([], rthor_data400__key__oshair_addressb2);
EXPORT dthor_data400__key__oshair__citystnameb2        := DATASET([], rthor_data400__key__oshair_citystnameb2);
EXPORT dthor_data400__key__oshair__fein2 	             := DATASET([], rthor_data400__key__oshair_fein2);
EXPORT dthor_data400__key__oshair__nameb2 	           := DATASET([], rthor_data400__key__oshair_nameb2);
EXPORT dthor_data400__key__oshair__namewords2          := DATASET([], rthor_data400__key__oshair_namewords2);
EXPORT dthor_data400__key__oshair__payload             := DATASET([], rthor_data400__key__oshair_payload);
EXPORT dthor_data400__key__oshair__stnameb2            := DATASET([], rthor_data400__key__oshair_stnameb2);
EXPORT dthor_data400__key__oshair__zipb2               := DATASET([], rthor_data400__key__oshair_zipb2);
EXPORT dthor_data400__key__oshair__bdid 	             := DATASET([], rthor_data400__key__oshair_bdid);
EXPORT dthor_data400__key__oshair__hazardous_substance := DATASET([], rthor_data400__key__oshair_hazardous_substance);
EXPORT dthor_data400__key__oshair__program             := DATASET([], rthor_data400__key__oshair_program);
EXPORT dthor_data400__key__oshair__violations          := DATASET([], rthor_data400__key__oshair_violations);
EXPORT dthor_data400__key__oshair__linkids             := DATASET([], rthor_data400__key__oshair_linkids);


END;