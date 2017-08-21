import Oshair;
EXPORT Layouts := module

export layout_autokeys:=OSHAIR.layout_autokeys;

Export Substance :=Record
big_endian unsigned4 Activity_Number;
OSHAIR.layout_OSHAIR_clean.OSHAIR_hazardous_substance_rec;
string10 cust_name;
string10 bug_num;
End;

Export Violations :=Record
big_endian unsigned4 Activity_Number;
OSHAIR.layout_OSHAIR_clean.OSHAIR_violations_rec;
string10 cust_name;
string10 bug_num;
End;

Export Program :=Record
big_endian unsigned4 Activity_Number;
OSHAIR.layout_OSHAIR_clean.oshair_program_rec;
string9 FEIN;
string8 INC_DATE;
string10 cust_name;
string10 bug_num;
End;

Export layout_OSHAIR_program_clean:= OSHAIR.layout_OSHAIR_program_clean;

Export layout_OSHAIR_accident_clean:= OSHAIR.layout_OSHAIR_accident_clean;

Export layout_OSHAIR_inspection_clean_BIP := OSHAIR.layout_OSHAIR_inspection_clean_BIP;

Export layout_OSHAIR_inspection_clean_BIP_Ext :=Record
OSHAIR.layout_OSHAIR_inspection_clean_BIP;
string10 cust_name;
String10 bug_num;
End;

Export layout_OSHAIR_inspection_clean := OSHAIR.layout_OSHAIR_inspection_clean;

Export Inspection  :=Record
big_endian unsigned integer4 activity_number;
string1 Program_Type;
string25 Program_Value;
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
string9 FEIN;
string8 INC_DATE;
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
string10 cust_name;
string10 bug_num;
End;



Export Accident  :=Record
big_endian unsigned integer4 activity_number;
string20 Name;
string8  dob;
string9  ssn;
big_endian unsigned4 Related_Inspection_Number;
string1              Sex;
unsigned1            Age;
string1              Degree_of_Injury;
string2              Nature_of_Injury;    
string2              Part_of_Body;        
string2              Source_of_Injury;    
string2              Event_Type;          
string2              Environmental_Factor; 
string2              Human_Factor;        
string1              Task_Assigned; 
string5              Hazardous_Substance; 
string3              Occupation_Code;     
string22          Deg_of_Injury_Desc ;
string20          Nat_of_Inj_Desc ;
string10             Part_of_Body_Desc;
string20             Src_of_Inj_Desc;
string20             Event_Desc;
string30             Env_Factor_Desc;
string33             Human_Factor_Desc;  
string39             Task_Assigned_Desc;
string50             Hazardous_Sub_Desc;
string50             Occupation_Desc;
string10             Cust_name;
string10             Bug_num;
End;
End;