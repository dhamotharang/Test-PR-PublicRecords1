Import hygenics_crim, corrections, address, Criminal_Records, ut, doxie,PRTE2_crim_offense_cat, aid_build ;
EXPORT Layouts := module

 export rFinal := RECORD
    AID_BUILD.layouts.rFinal;
  end;

Export combined_desc_lookup_layout := record
string2 data_type;
string75 off_desc;
unsigned8 offense_category;
end;


EXPORT layout_offender := hygenics_crim.layout_offender;
EXPORT layout_offender_plus := hygenics_crim.layout_offender or {unsigned8 aceaid, unsigned8 rawaid, string100 cust_name, string20 bug_num,	string8 link_dob,	string9	link_ssn};
EXPORT layout_offenses_base_plus := corrections.layout_offense_common or {string100 cust_name, string20 bug_num};

Export layout_offenses_base_plus_2:=Record
layout_offenses_base_plus;
string Category;
end;

EXPORT layout_offense_common := corrections.layout_offense_common;
EXPORT Layout_CrimPunishment := corrections.Layout_CrimPunishment;
EXPORT layout_punishment_plus := Layout_CrimPunishment or {string100 cust_name, string20 bug_num};
EXPORT layout_activity := hygenics_crim.layout_activity;
EXPORT Layout_Base_CourtOffenses := corrections.layout_courtoffenses;
EXPORT layout_court_offenses_base_plus := Layout_Base_CourtOffenses or {string100 cust_name, string20 bug_num};

Export layout_court_offenses_base_plus_2:=Record
layout_court_offenses_base_plus;
string Category;
end;



EXPORT layout_corrections_keys := RECORD(layout_offender)
	unsigned6 i_did;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('CRIM'))| ut.bit_set(0,0);
END;

EXPORT layout_date := RECORD
	unsigned4 date;
	string60	offender_key;
	string35  case_num; 
	string1		fcra_conviction_flag;
	string1		fcra_traffic_flag;
	string2		offense_score;
END;

EXPORT slimrec_offenders := RECORD
	unsigned6	did;
	DATASET(layout_date) criminal_count {MAXCOUNT(100)};
END;

EXPORT layout_rollup_offenders := record 
	slimrec_offenders;
	string35    offender_key; 
END;

EXPORT Layout_Base_Offenses_with_OffenseCategory := hygenics_crim.Layout_Base_Offenses_with_OffenseCategory;
export layout_offense_fcra := record
	string60	offender_key;
	string35  case_number;
	string	  fcra_date;
	string1		fcra_conviction_flag;
	string1		fcra_traffic_flag;
	string2		offense_score;
end;
EXPORT casenumber_key_layout := RECORD
		string35 case_num;
		string60 offender_key;
		string1 file_indicator;
END;

Export Autokey_layout := Criminal_Records.Layouts.Autokey_layout;
EXPORT offense_fields := RECORD
   string8 process_date;
   string60 offender_key;
   string8 off_date;
   string8 arr_date;
   string8 arr_disp_date;
   string8 court_disp_date;
   string8 sent_date;
   string8 appeal_date;
   string5 court_off_lev;
   string20 court_off_code;
   string20 court_statute;
   string70 court_statute_desc;
   string75 court_off_desc_1;
   string40 court_disp_desc_1;
   string40 court_disp_desc_2;
   string1 off_typ;
   string5 off_lev;
  END;



EXPORT old_layout_offender := record
		string8		process_date;
		string8		file_date:='';
		string60	offender_key;
		string5		vendor;
		string20	source_file;
		string2		record_type := '';
		string25	orig_state;
		string15	id_num:='';
		string56	pty_nm:='';
		string1		pty_nm_fmt:='';
		string20  orig_lname:= '';				
		string20  orig_fname:= '';				
		string20  orig_mname:= '';				
		string10  orig_name_suffix:= '';			
		string20	lname:='';		
		string20	fname:='';	
		string20	mname:='';
		string6		name_suffix:='';
		string1		pty_typ:='';
		string1		nitro_flag:='';
		string9		ssn:='';
		string35	case_num := '';
		string40  case_court	:= '';    			
		string8		case_date := '';
		string5   case_type := '';
		string25	case_type_desc;
		string30	county_of_origin := '';
		string10	dle_num:='';
		string9		fbi_num:='';
		string10	doc_num:='';
		string10	ins_num:='';
		string25  dl_num := '';					
		string2   dl_state := '';					
		string2		citizenship:='';
		string8		dob:='';
		string8		dob_alias:='';
		string13	county_of_birth;
		string25	place_of_birth:='';
		string25	street_address_1:='';
		string25	street_address_2:='';
		string25	street_address_3:='';
		string10	street_address_4:='';
		string10	street_address_5:='';
		string13	current_residence_county;
		string13	legal_residence_county;
		string3		race:='';
		string30	race_desc:='';
		string7		sex:='';
		string3		hair_color:='';
		string15	hair_color_desc:='';
		string3		eye_color:='';
		string15	eye_color_desc:='';
		string3		skin_color:='';
		string15	skin_color_desc:='';
		string10	scars_marks_tattoos_1:='';
		string10	scars_marks_tattoos_2:='';
		string10	scars_marks_tattoos_3:='';
		string10	scars_marks_tattoos_4:='';
		string10	scars_marks_tattoos_5:='';
		string3		height:='';
		string3		weight:='';
		string5		party_status:='';
		string60	party_status_desc:='';
		string10	_3g_offender:='';
		string10	violent_offender:='';
		string10	sex_offender:='';
		string10	vop_offender:='';
		string1		data_type;
		string26	record_setup_date;
		string45	datasource;
		address.Layout_Address_Clean_Return;
		string18	county_name;
		string12	did;
		string3		score;
		string9		ssn_appended;
		string1		curr_incar_flag := '';
		string1		curr_parole_flag := '';
		string1		curr_probation_flag := '';
		string8  	src_upload_date := '';			
		string3   Age := '';						
		string150 image_link := '';				
	end;

EXPORT layout_offenders_risk_temp := record
	old_layout_offender;
	offense_fields offense;
	string8 earliest_offense_date;
end;
EXPORT layout_offenders_risk := record
	string1 traffic_flag;
	string1 conviction_flag;
	string1 offense_score;
	string1 criminal_offender_level;  // 1 = traffic, not-convicted
									  // 2 = traffic, convicted
									  // 3 = non-traffic, not-convicted
									  // 4 = non-traffic, convicted
	layout_offenders_risk_temp;
end;
EXPORT crim_slimrec := RECORD
	unsigned6	did;
	UNSIGNED1 criminal_count;
	UNSIGNED1 criminal_count30;
	UNSIGNED1 criminal_count90;
	UNSIGNED1 criminal_count180;
	UNSIGNED1 criminal_count12;
	UNSIGNED1 criminal_count24;
	UNSIGNED1 criminal_count36;
	UNSIGNED1 criminal_count60;
	unsigned4 last_criminal_date;
	string35 crim_case_num;
	unsigned1 arrests_count;
	unsigned4 date_last_arrest;
	unsigned1 arrests_count30;
	unsigned1 arrests_count90;
	unsigned1 arrests_count180;
	unsigned1 arrests_count12;
	unsigned1 arrests_count24;
	unsigned1 arrests_count36;
	unsigned1 arrests_count60;
END;

EXPORT crim_slimrec2 := RECORD
	unsigned6	did;
	UNSIGNED1 criminal_count;
	unsigned4 last_criminal_date;
	UNSIGNED1 felony_count;
	unsigned4 last_felony_date;
	UNSIGNED1 criminal_count30;
	UNSIGNED1 criminal_count90;
	UNSIGNED1 criminal_count180;
	UNSIGNED1 criminal_count12;
	UNSIGNED1 criminal_count24;
	UNSIGNED1 criminal_count36;
	UNSIGNED1 criminal_count60;
	
	string35 crim_case_num;
	unsigned1 arrests_count;
	unsigned4 date_last_arrest;
	unsigned1 arrests_count30;
	unsigned1 arrests_count90;
	unsigned1 arrests_count180;
	unsigned1 arrests_count12;
	unsigned1 arrests_count24;
	unsigned1 arrests_count36;
	unsigned1 arrests_count60;
END;





EXPORT layout_corrections_activity_public := RECORD
  string8 process_date;
  string60 offender_key;
  string5 vendor;
  string2 state_origin;
  string20 source_file;
  string4 off_comp;
  string35 case_number;
  string2 event_type;
  string9 event_sort_key;
  string8 event_date;
  string10 event_location_code;
  string50 event_location_desc;
  string8 event_desc_code;
  string50 event_desc_1;
  string50 event_desc_2;
  string8 conviction_override_date;
  string1 conviction_override_date_type;
  unsigned8 activity_persistent_id;
 END;
 
EXPORT layout_activity_base_plus := layout_corrections_activity_public or {string100 cust_name, string20 bug_num};

EXPORT prte__DOCKeysOffenses__base := RECORD
string60 ok;
string8 process_date;
string60 offender_key;
string5 vendor;
string30 county_of_origin;
string20 source_file;
string1 data_type;
string2 record_type;
string25 orig_state;
string50 offense_key;
string8 off_date;
string8 arr_date;
string35 case_num;
string3 total_num_of_offenses;
string3 num_of_counts;
string20 off_code;
string31 chg;
string1 chg_typ_flg;
string4 off_of_record;
string75 off_desc_1;
string50 off_desc_2;
string2 add_off_cd;
string30 add_off_desc;
string1 off_typ;
string5 off_lev;
string8 arr_disp_date;
string3 arr_disp_cd;
string30 arr_disp_desc_1;
string30 arr_disp_desc_2;
string50 arr_disp_desc_3;
string10 court_cd;
string40 court_desc;
string40 ct_dist;
string1 ct_fnl_plea_cd;
string30 ct_fnl_plea;
string8 ct_off_code;
string17 ct_chg;
string1 ct_chg_typ_flg;
string50 ct_off_desc_1;
string50 ct_off_desc_2;
string1 ct_addl_desc_cd;
string2 ct_off_lev;
string8 ct_disp_dt;
string4 ct_disp_cd;
string50 ct_disp_desc_1;
string50 ct_disp_desc_2;
string2 cty_conv_cd;
string30 cty_conv;
string1 adj_wthd;
string8 stc_dt;
string3 stc_cd;
string3 stc_comp;
string50 stc_desc_1;
string50 stc_desc_2;
string50 stc_desc_3;
string50 stc_desc_4;
string15 stc_lgth;
string50 stc_lgth_desc;
string8 inc_adm_dt;
string10 min_term;
string35 min_term_desc;
string10 max_term;
string35 max_term_desc;
string20 parole;
string50 probation;
string40 offensetown;
string8 convict_dt;
string40 court_county;
string60 fcra_offense_key;
string1 fcra_conviction_flag;
string1 fcra_traffic_flag;
string8 fcra_date;
string1 fcra_date_type;
string8 conviction_override_date;
string1 conviction_override_date_type;
string2 offense_score;
unsigned8 offense_persistent_id;
string100 cust_name;
string20 bug_num;
string link_dob;
string link_ssn;
END;





EXPORT prte__DOCKeysPunishment_base := RECORD
string60 ok;
string1 pt;
string8 process_date;
string60 offender_key;
string8 event_dt;
string5 vendor;
string20 source_file;
string2 record_type;
string25 orig_state;
string50 offense_key;
string1 punishment_type;
string8 sent_date;
string15 sent_length;
string60 sent_length_desc;
string8 cur_stat_inm;
string50 cur_stat_inm_desc;
string8 cur_loc_inm_cd;
string60 cur_loc_inm;
string8 inm_com_cty_cd;
string25 inm_com_cty;
string8 cur_sec_class_dt;
string25 cur_loc_sec;
string3 gain_time;
string8 gain_time_eff_dt;
string8 latest_adm_dt;
string8 sch_rel_dt;
string8 act_rel_dt;
string8 ctl_rel_dt;
string8 presump_par_rel_dt;
string8 mutl_part_pgm_dt;
string4 release_type;
string2 office_region;
string8 par_cur_stat;
string50 par_cur_stat_desc;
string8 par_status_dt;
string8 par_st_dt;
string8 par_sch_end_dt;
string8 par_act_end_dt;
string8 par_cty_cd;
string50 par_cty;
string30 supv_office;
string30 supv_officer;
string14 office_phone;
string2 tdcjid_unit_type;
string15 tdcjid_unit_assigned;
string1 tdcjid_admit_date;
string1 prison_status;
string2 recv_dept_code;
string10 recv_dept_date;
string1 parole_active_flag;
string10 casepull_date;
string8 conviction_override_date;
string1 conviction_override_date_type;
unsigned8 punishment_persistent_id;
string100 cust_name;
string20 bug_num;
string link_dob;
string link_ssn;
END;





EXPORT prte__DOCKeysOffenders__base := RECORD
string8 process_date;
string8 file_date;
string60 offender_key;
string5 vendor;
string20 source_file;
string2 record_type;
string25 orig_state;
string15 id_num;
string56 pty_nm;
string1 pty_nm_fmt;
string20 orig_lname;
string20 orig_fname;
string20 orig_mname;
string10 orig_name_suffix;
string20 lname;
string20 fname;
string20 mname;
string6 name_suffix;
string1 pty_typ;
unsigned8 nid;
string1 ntype;
unsigned2 nindicator;
string1 nitro_flag;
string9 ssn;
string35 case_num;
string40 case_court;
string8 case_date;
string5 case_type;
string25 case_type_desc;
string30 county_of_origin;
string10 dle_num;
string9 fbi_num;
string10 doc_num;
string10 ins_num;
string25 dl_num;
string2 dl_state;
string2 citizenship;
integer4 dob;
string8 dob_alias;
string13 county_of_birth;
string25 place_of_birth;
string100 street_address_1;
string100 street_address_2;
string25 street_address_3;
string10 street_address_4;
string10 street_address_5;
string13 current_residence_county;
string13 legal_residence_county;
string3 race;
string30 race_desc;
string7 sex;
string3 hair_color;
string15 hair_color_desc;
string3 eye_color;
string15 eye_color_desc;
string3 skin_color;
string15 skin_color_desc;
string10 scars_marks_tattoos_1;
string10 scars_marks_tattoos_2;
string10 scars_marks_tattoos_3;
string10 scars_marks_tattoos_4;
string10 scars_marks_tattoos_5;
string3 height;
string3 weight;
string5 party_status;
string60 party_status_desc;
string10 _3g_offender;
string10 violent_offender;
string10 sex_offender;
string10 vop_offender;
string1 data_type;
string26 record_setup_date;
string45 datasource;
string10 prim_range;
string2 predir;
string28 prim_name;
qstring4 addr_suffix;
string2 postdir;
qstring10 unit_desig;
string8 sec_range;
qstring25 p_city_name;
qstring25 v_city_name;
string2 st;
qstring5 zip5;
qstring4 zip4;
string4 cart;
string1 cr_sort_sz;
string4 lot;
string1 lot_order;
string2 dpbc;
string1 chk_digit;
string2 rec_type;
string2 ace_fips_st;
string3 ace_fips_county;
string10 geo_lat;
string11 geo_long;
string4 msa;
string7 geo_blk;
string1 geo_match;
string4 err_stat;
unsigned1 clean_errors;
string18 county_name;
unsigned6 did;
string3 score;
string9 ssn_appended;
string1 curr_incar_flag;
string1 curr_parole_flag;
string1 curr_probation_flag;
string8 src_upload_date;
string3 age;
string150 image_link;
string1 fcra_conviction_flag;
string1 fcra_traffic_flag;
string8 fcra_date;
string1 fcra_date_type;
string8 conviction_override_date;
string1 conviction_override_date_type;
string2 offense_score;
unsigned8 offender_persistent_id;
string100 cust_name;
string20 bug_num;
string8		link_dob;	
string9	link_ssn;
END;





EXPORT prte__DOCKeysCourtOffenses_base := RECORD
string8 process_date;
string60 offender_key;
string5 vendor;
string2 state_origin;
string20 source_file;
string1 data_type;
string4 off_comp;
string1 off_delete_flag;
string8 off_date;
string8 arr_date;
string3 num_of_counts;
string10 le_agency_cd;
string50 le_agency_desc;
string35 le_agency_case_number;
string35 traffic_ticket_number;
string25 traffic_dl_no;
string2 traffic_dl_st;
string20 arr_off_code;
string75 arr_off_desc_1;
string50 arr_off_desc_2;
string5 arr_off_type_cd;
string30 arr_off_type_desc;
string5 arr_off_lev;
string20 arr_statute;
string70 arr_statute_desc;
string8 arr_disp_date;
string5 arr_disp_code;
string30 arr_disp_desc_1;
string30 arr_disp_desc_2;
string10 pros_refer_cd;
string50 pros_refer;
string10 pros_assgn_cd;
string50 pros_assgn;
string1 pros_chg_rej;
string20 pros_off_code;
string75 pros_off_desc_1;
string50 pros_off_desc_2;
string5 pros_off_type_cd;
string30 pros_off_type_desc;
string5 pros_off_lev;
string30 pros_act_filed;
string35 court_case_number;
string10 court_cd;
string40 court_desc;
string1 court_appeal_flag;
string30 court_final_plea;
string20 court_off_code;
string75 court_off_desc_1;
string50 court_off_desc_2;
string5 court_off_type_cd;
string30 court_off_type_desc;
string5 court_off_lev;
string20 court_statute;
string50 court_additional_statutes;
string70 court_statute_desc;
string8 court_disp_date;
string5 court_disp_code;
string40 court_disp_desc_1;
string40 court_disp_desc_2;
string8 sent_date;
string50 sent_jail;
string50 sent_susp_time;
string8 sent_court_cost;
string9 sent_court_fine;
string9 sent_susp_court_fine;
string50 sent_probation;
string5 sent_addl_prov_code;
string40 sent_addl_prov_desc_1;
string40 sent_addl_prov_desc_2;
string2 sent_consec;
string10 sent_agency_rec_cust_ori;
string50 sent_agency_rec_cust;
string8 appeal_date;
string40 appeal_off_disp;
string40 appeal_final_decision;
string8 convict_dt;
string30 offense_town;
string30 cty_conv;
string12 restitution;
string30 community_service;
string20 parole;
string30 addl_sent_dates;
string60 probation_desc2;
string8 court_dt;
string40 court_county;
string35 arr_off_lev_mapped;
string35 court_off_lev_mapped;
string60 fcra_offense_key;
string1 fcra_conviction_flag;
string1 fcra_traffic_flag;
string8 fcra_date;
string1 fcra_date_type;
string8 conviction_override_date;
string1 conviction_override_date_type;
string2 offense_score;
unsigned8 offense_persistent_id;
unsigned8 offense_category;
string100 cust_name;
string20 bug_num;
string link_dob;
string link_ssn;

END;
EXPORT prte__DOCKeysActivity__base := RECORD
string60 ok;
string8 process_date;
string60 offender_key;
string5 vendor;
string2 state_origin;
string20 source_file;
string4 off_comp;
string35 case_number;
string2 event_type;
string9 event_sort_key;
string8 event_date;
string10 event_location_code;
string50 event_location_desc;
string8 event_desc_code;
string50 event_desc_1;
string50 event_desc_2;
string8 conviction_override_date;
string1 conviction_override_date_type;
unsigned8 activity_persistent_id;
string100 cust_name;
string20 bug_num;
string link_dob;
string link_ssn;
END;


EXPORT autokey_layout_w_extra_city_field:=record
	autokey_layout;
	qstring25 p_city_name;
end;
END;