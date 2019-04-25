EXPORT Proddata_Layout := module;

import risk_indicators,riskwise, BankruptcyV2;

EXPORT bankruptcyv3_search_join := 'left.caseid = right.caseid and left.defendantid	 = right.defendantid and left.recid = right.recid and left.tmsid = right.tmsid and left.seq_number	 = right.seq_number and left.case_number = right.case_number and left.discharged = right.discharged and left.statusdate = right.statusdate and left.Name_type = right.Name_type and left.orig_name = right.orig_name and left.did = right.did and left.app_ssn	 = right.app_ssn and left.disptypedesc	 = right.disptypedesc and left.srcdesc	 = right.srcdesc and left.srcmtchdesc	 = right.srcmtchdesc and left.screendesc	 = right.screendesc and left.dcodedesc	 = right.dcodedesc and left.record_type	 = right.record_type';
export bankruptcyv3_main_join := 'left.tmsid = right.tmsid and left.process_date = right.process_date and left.source = right.source and left.id = right.id and left.seq_number	 = right.seq_number and left.case_number = right.case_number';
export Header_Massive_join := 'left.did=right.did'+
					' and left.rid < right.rid'+
					' and	left.src        =right.src'+
				' and	left.fname      =right.fname'+
				'	and	left.lname      =right.lname'+
				'	and	left.prim_range =right.prim_range'+
				'	and	left.prim_name  =right.prim_name'+
				'	and	left.sec_range  =right.sec_range'+
				'	and	left.city_name  =right.city_name'+
				'	and	left.st         =right.st'+
				'	and	('+
								' (left.ssn          =right.ssn'+
					'		and	left.dob         =right.dob'+
						'	and	left.phone       =right.phone'+
						'	and	left.mname       =right.mname'+
						'	and	left.name_suffix =right.name_suffix'+
						'	and	left.zip         =right.zip'+
						'	and	left.county      =right.county)'+
						'		or (('+
								' left.ssn=\'\' '+
								' or left.ssn=right.ssn '+
											'		or ('+
														'			ut.nneq(left.ssn, right.ssn)'+
														'		and	('+
														'				(left.dt_first_seen>0 and	left.dt_last_seen>0'+
														'		and right.dt_first_seen>0 and right.dt_last_seen>0'+
														'		and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0'+
														'		and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0)'+
													'			or '+
														'			(left.dt_first_seen=0 and	left.dt_last_seen=0'+
														'		and right.dt_first_seen=0 and right.dt_last_seen=0'+
													'			and	left.dt_vendor_first_reported=0 and	left.dt_vendor_last_reported=0'+
													'			and right.dt_vendor_first_reported=0 and right.dt_vendor_last_reported=0)'+
													'			)'+
													'		and (left.dt_first_seen between right.dt_first_seen and right.dt_last_seen'+
													'				or left.dt_last_seen between right.dt_first_seen and right.dt_last_seen'+
													'		    or right.dt_first_seen between left.dt_first_seen and left.dt_last_seen'+
														'			or right.dt_last_seen between left.dt_first_seen and left.dt_last_seen)'+
													'		and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
														'			or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
														'	    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported'+
													'				or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)'+
												'			)'+
											'		or ('+
												'				ut.nneq(left.ssn, right.ssn)'+
												'			and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)'+
											'				and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0'+
												'			and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0'+
															
											'				and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
												'				or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
											'				    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported'+
													'				or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)'+
												'			)'+
										'			or ('+
													'			ut.nneq(left.ssn, right.ssn)'+
													'		and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)'+
													'		and	(left.dt_vendor_first_reported=0 or right.dt_vendor_first_reported=0 or left.dt_vendor_last_reported=0 or right.dt_vendor_last_reported=0)'+
												'			)'+
									'		)'+
							'		and	('+
														'	left.dob=0'+
											'		or left.dob=right.dob '+
										'			or ('+
															'		ut.NNEQ_Date(left.dob, right.dob)'+
																' and	('+
																'		(left.dt_first_seen>0 and	left.dt_last_seen>0'+
																' and right.dt_first_seen>0 and right.dt_last_seen>0'+
																' and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0'+
															'	and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0)'+
															'	or'+
															'		(left.dt_first_seen=0 and	left.dt_last_seen=0'+
															'	and right.dt_first_seen=0 and right.dt_last_seen=0'+
															'	and	left.dt_vendor_first_reported=0 and	left.dt_vendor_last_reported=0'+
															'	and right.dt_vendor_first_reported=0 and right.dt_vendor_last_reported=0)'+
														'		)'+
														'	and (left.dt_first_seen between right.dt_first_seen and right.dt_last_seen'+
															'		or left.dt_last_seen between right.dt_first_seen and right.dt_last_seen'+
															'    or right.dt_first_seen between left.dt_first_seen and left.dt_last_seen'+
															'		or right.dt_last_seen between left.dt_first_seen and left.dt_last_seen)'+
														'	and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
															'		or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
															 '   or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported'+
															'		or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)'+
														'	)'+
												'	or ('+
															'	ut.NNEQ_Date(left.dob, right.dob)'+
														'	and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)'+
														'	and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0'+
														'	and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0'+
															
														'	and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
														'			or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported'+
														'	    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported'+
														'			or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)'+
													'		)'+
												'	or ('+
														'		ut.NNEQ_Date(left.dob, right.dob)'+
														'	and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)'+
														'	and	(left.dt_vendor_first_reported=0 or right.dt_vendor_first_reported=0 or left.dt_vendor_last_reported=0 or right.dt_vendor_last_reported=0)'+
														'	)'+
							'			)'+
						'	and	ut.nneq(left.phone       ,right.phone)'+
						'	and	('+
							'		ut.nneq(left.mname       ,right.mname)'+
						'		or (if(left.mname[1]=right.mname[1] and (length(trim(left.mname))=1 or length(trim(right.mname))=1),true,false))'+
							'	)'+
						'	and	ut.nneq(left.name_suffix ,right.name_suffix)'+
						'	and	ut.nneq(left.zip         ,right.zip)'+
						'	and	ut.nneq(left.county      ,right.county)'+

						'	and	(left.dt_first_seen=right.dt_first_seen or left.dt_first_seen=0 or right.dt_first_seen=0)'+
						'	)'+
						')';


EXPORT input_rec := record
	risk_indicators.Layouts.layout_input_plus_overrides;
	unsigned glb;
	unsigned dppa;
	string apn;
	unsigned bdid;
	string fein;
end;
//header

EXPORT HeaderRecsLayout := RECORD
	string s_did;
	string did;
  string rid;
  string pflag1;
  string pflag2;
  string pflag3;
  string src;
  integer dt_first_seen;
  integer dt_last_seen;
  integer dt_vendor_last_reported;
  integer dt_vendor_first_reported;
  integer dt_nonglb_last_seen;
  string rec_type;
  string vendor_id;
  string phone;
  string ssn;
  integer dob;
  string title;
  string fname;
  string mname;
  string lname;
  string name_suffix;
  string prim_range;
  string predir;
  string prim_name;
  string suffix;
  string postdir;
  string unit_desig;
  string sec_range;
  string city_name;
  string st;
  string zip;
  string zip4;
  string county;
  string geo_blk;
  string cbsa;
  string tnt;
  string valid_ssn;
  string jflag1;
  string jflag2;
  string jflag3;
  string rawaid;
  string persistent_record_id;
	string valid_dob	;
  string hhid;
  string county_name	;
  string listed_name	;
  string listed_phone	;
  string dod;
  string death_code;
  string lookup_did;
end;
//best data


EXPORT BestDataLayout := RECORD
	STRING did ;
	STRING score ;
	STRING hhid ;
	STRING seq ;
	STRING best_ssn;
	STRING best_title ;
	STRING best_fname ;
	STRING best_mname ;
	STRING best_lname;
	STRING best_addr1 ;
	STRING best_city ;
	STRING best_state ;
	STRING best_zip  ;
	STRING best_zip4 ;
	STRING best_addr_date ;
	STRING best_dob ;
	STRING verify_best_phone  ;
	STRING verify_best_ssn ;
	STRING verify_best_address  ;
	STRING verify_best_name ;
	STRING verify_best_dob ;
	STRING score_any_ssn ;
	STRING score_any_addr ;
	STRING any_addr_date  ;
	STRING score_any_dob ;
	STRING score_any_phn  ;
	STRING score_any_fzzy ;
	STRING known ;
	STRING name_match ;
	STRING number_with_same_name;
	STRING first_seen ;
	STRING relative_count;
	STRING veh_cnt;
	STRING dl_cnt ;
	STRING head_cnt ;
	STRING crim_cnt;
	STRING sex_cnt;
	STRING ccw_cnt ;
	STRING rel_count ;
	STRING fire_count;
	STRING faa_count;
	STRING prof_count  ;
	STRING vess_count ;
	STRING bus_count;
	STRING prop_count ;
	STRING house_size ;
	STRING sg_within_7 ;
	STRING dg_within_7 ;
	STRING ug_within_7 ;
	STRING sg_y_8_15 ;
	STRING dg_y_8_15;
	STRING ug_y_8_15;
	STRING sg_y_16_30;
	STRING dg_y_16_30 ;
	STRING ug_y_16_30 ;
	STRING sg_o_8_15;
	STRING dg_o_8_15 ;
	STRING ug_o_8_15 ;
	STRING sg_o_16_30  ;
	STRING dg_o_16_30  ;
	STRING ug_o_16_30  ;
	STRING sg_o_30;
	STRING dg_o_30 ;
	STRING ug_o_30 ;
	STRING sg_y_30 ;
	STRING dg_y_30 ;
	STRING ug_y_30 ;
	STRING sg ;
	STRING dg ;
	STRING ug  ;
	STRING kids  ;
	STRING parents ;
END;

//ibehavior

EXPORT IBehaviorLayout := RECORD
	STRING did;
	STRING persistent_record_id;
	STRING ib_individual_id;
	STRING ib_household_id;
	STRING fname;
	STRING mname;
	STRING lname;
	STRING prim_range;
	STRING prim_name;
	STRING addr_suffix;
	STRING p_city_name;
	STRING st;
	STRING zip5;
	STRING zip4;
	STRING cart;
	STRING county;
	STRING geo_lat;
	STRING geo_long;
	STRING geo_blk;
	STRING err_stat;
	STRING phone_1;
	STRING date_first_seen;
	STRING date_last_seen;
	STRING __internal_fpos__;
END;

export IBehaviorLayout2 := RECORD
  string ib_individual_id;
  string persistent_record_id;
  string first_order_date;
  string last_order_date;
  string first_online_order_date;
  string last_online_order_date;
  string first_offline_order_date;
  string last_offline_order_date;
  string first_retail_order_date;
  string last_retail_order_date;
  string number_of_sources;
  string total_number_of_orders;
  string total_dollars;
  string online_orders;
  string online_dollars;
  string offline_orders;
  string offline_dollars;
  string retail_orders;
  string retail_dollars;
  string average_days_between_orders;
  string average_days_between_online_orders;
  string average_days_between_offline_orders;
  string average_days_between_retail_orders;
  string average_amount_per_order;
  string online_average_amount_per_order;
  string offline_average_amount_per_order;
  string retail_average_amount_per_order;
  string online_orders_under_50_range;
  string online_orders_50_to_99_dot_99_range;
  string online_orders_100_to_249_dot_99_range;
  string online_orders_250_to_499_dot_99_range;
  string online_orders_500_to_999_dot_99_range;
  string online_orders_1000_plus_range;
  string offline_orders_under_50_range;
  string offline_orders_50_to_99_dot_99_range;
  string offline_orders_100_to_249_dot_99_range;
  string offline_orders_250_to_499_dot_99_range;
  string offline_orders_500_to_999_dot_99_range;
  string offline_orders_1000_plus_range;
  string retail_orders_under_50_range;
  string retail_orders_50_to_99_dot_99_range;
  string retail_orders_100_to_249_dot_99_range;
  string retail_orders_250_to_499_dot_99_range;
  string retail_orders_500_to_999_dot_99_range;
  string retail_orders_1000_plus_range;
  string date_first_seen;
  string date_last_seen;
  unsigned __internal_fpos__;
 END;
//inquiryFullTableKey Layout;

export mbslayout := RECORD
   string company_id;
   string global_company_id;
  END;

export allowlayout := RECORD
   unsigned8 allowflags;
  END;

export businfolayout := RECORD
   string primary_market_code;
   string secondary_market_code;
   string industry_1_code;
   string industry_2_code;
   string sub_market;
   string vertical;
   string use;
   string industry;
  END;

export persondatalayout := RECORD
   string full_name;
   string first_name;
   string middle_name;
   string last_name;
   string address;
   string city;
   string state;
   string zip;
   string personal_phone;
   string work_phone;
   string dob;
   string dl;
   string dl_st;
   string email_address;
   string ssn;
   string linkid;
   string ipaddr;
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
   string appended_ssn;
   unsigned6 appended_adl;
  END;

export permissablelayout := RECORD
   string glb_purpose;
   string dppa_purpose;
   string fcra_purpose;
  END;

export searchlayout := RECORD
   string datetime;
   string start_monitor;
   string stop_monitor;
   string login_history_id;
   string transaction_id;
   string sequence_number;
   string method;
   string product_code;
   string transaction_type;
   string function_description;
   string ipaddr;
  END;

EXPORT InquiryTableFullLayout :=RECORD
  unsigned6 s_did;
  mbslayout mbs;
  allowlayout allow_flags;
  businfolayout bus_intel;
  persondatalayout person_q;
  permissablelayout permissions;
  searchlayout search_info;
  string3 fraudpoint_score;
  unsigned8 __internal_fpos__;
 END;
 

//Crim Layout

offense_fields := RECORD
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

EXPORT Crim_Layout := RECORD
  unsigned6 sdid;
  string1 traffic_flag;
  string1 conviction_flag;
  string1 offense_score;
  string1 criminal_offender_level;
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
  string8 dob;
  string8 dob_alias;
  string13 county_of_birth;
  string25 place_of_birth;
  string25 street_address_1;
  string25 street_address_2;
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
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  string2 st;
  qstring5 zip5;
  qstring4 zip4;
  unsigned1 clean_errors;
  string18 county_name;
  string12 did;
  string3 score;
  string9 ssn_appended;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
  string8 src_upload_date;
  string3 age;
  string150 image_link;
  offense_fields offense;
  string8 earliest_offense_date;
  unsigned8 __internal_fpos__;
 END;


//Prof lic

export Prof_Lic_Layout := RECORD
  unsigned6 did;
  unsigned6 prolic_seq_id;
  string50 prolic_key;
  string8 date_first_seen;
  string8 date_last_seen;
  string60 profession_or_board;
  string60 license_type;
  string45 status;
  string20 orig_license_number;
  string20 license_number;
  string20 previous_license_number;
  string60 previous_license_type;
  string100 company_name;
  string80 orig_name;
  string3 name_order;
  string80 orig_former_name;
  string3 former_name_order;
  string80 orig_addr_1;
  string80 orig_addr_2;
  string80 orig_addr_3;
  string80 orig_addr_4;
  string40 orig_city;
  string2 orig_st;
  string9 orig_zip;
  string25 county_str;
  string35 country_str;
  string1 business_flag;
  string10 phone;
  string8 sex;
  string8 dob;
  string8 issue_date;
  string8 expiration_date;
  string8 last_renewal_date;
  string50 license_obtained_by;
  string1 board_action_indicator;
  string2 source_st;
  string60 vendor;
  string8 action_record_type;
  string50 action_complaint_violation_cds;
  string200 action_complaint_violation_desc;
  string8 action_complaint_violation_dt;
  string50 action_case_number;
  string8 action_effective_dt;
  string20 action_cds;
  string200 action_desc;
  string30 action_final_order_no;
  string30 action_status;
  string8 action_posting_status_dt;
  string100 action_original_filename_or_url;
  string15 additional_name_addr_type;
  string80 additional_orig_name;
  string3 additional_name_order;
  string80 additional_orig_additional_1;
  string80 additional_orig_additional_2;
  string80 additional_orig_additional_3;
  string80 additional_orig_additional_4;
  string40 additional_orig_city;
  string2 additional_orig_st;
  string9 additional_orig_zip;
  string10 additional_phone;
  string50 misc_occupation;
  string20 misc_practice_hours;
  string50 misc_practice_type;
  string50 misc_email;
  string10 misc_fax;
  string50 misc_web_site;
  string50 misc_other_id;
  string10 misc_other_id_type;
  string75 education_continuing_education;
  string30 education_1_school_attended;
  string15 education_1_dates_attended;
  string25 education_1_curriculum;
  string15 education_1_degree;
  string30 education_2_school_attended;
  string15 education_2_dates_attended;
  string25 education_2_curriculum;
  string15 education_2_degree;
  string30 education_3_school_attended;
  string15 education_3_dates_attended;
  string25 education_3_curriculum;
  string15 education_3_degree;
  string75 additional_licensing_specifics;
  string5 personal_pob_cd;
  string25 personal_pob_desc;
  string5 personal_race_cd;
  string25 personal_race_desc;
  string10 status_status_cds;
  string8 status_effective_dt;
  string8 status_renewal_desc;
  string20 status_other_agency;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 pl_score_in;
  string18 county_name;
  string3 score;
  string9 best_ssn;
  string12 bdid;
  unsigned8 __internal_fpos__;
 END;

export watercraft_layout := RECORD
  unsigned6 l_did;
  string2 state_origin;
  string30 watercraft_key;
  string30 sequence_key;
  unsigned8 __internal_fpos__;
 END;
//fares_search_layout
export fares_search_layout := RECORD
  string12 ln_fares_id;
  string1 which_orig;
  string1 source_code_2;
  string1 source_code_1;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string1 vendor_source_flag;
  string8 process_date;
  string2 source_code;
  string1 conjunctive_name_seq;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string80 cname;
  string80 nameasis;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string10 phone_number;
  unsigned6 did;
  unsigned6 bdid;
  string9 app_ssn;
  string9 app_tax_id;
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  string2 ln_party_status;
  string6 ln_percentage_ownership;
  string2 ln_entity_type;
  string8 ln_estate_trust_date;
  string1 ln_goverment_type;
  integer2 xadl2_weight;
  string2 addr_ind;
  string1 best_addr_ind;
  unsigned6 addr_tx_id;
  string1 best_addr_tx_id;
  unsigned8 location_id;
  string1 best_locid;
  unsigned8 __internal_fpos__;
 END;



//assessments_layout
export assessments_layout := RECORD
  string12 ln_fares_id;
  unsigned6 proc_date;
  string8 process_date;
  string1 vendor_source_flag;
  string1 current_record;
  string5 fips_code;
  string2 state_code;
  string30 county_name;
  string31 old_apn;
  string45 apna_or_pin_number;
  string45 fares_unformatted_apn;
  string2 duplicate_apn_multiple_address_id;
  string80 assessee_name;
  string60 second_assessee_name;
  string3 assessee_ownership_rights_code;
  string2 assessee_relationship_code;
  string10 assessee_phone_number;
  string30 tax_account_number;
  string45 contract_owner;
  string1 assessee_name_type_code;
  string1 second_assessee_name_type_code;
  string1 mail_care_of_name_type_code;
  string60 mailing_care_of_name;
  string80 mailing_full_street_address;
  string6 mailing_unit_number;
  string51 mailing_city_state_zip;
  string60 property_full_street_address;
  string6 property_unit_number;
  string51 property_city_state_zip;
  string3 property_country_code;
  string1 property_address_code;
  string2 legal_lot_code;
  string7 legal_lot_number;
  string10 legal_land_lot;
  string7 legal_block;
  string7 legal_section;
  string12 legal_district;
  string6 legal_unit;
  string30 legal_city_municipality_township;
  string40 legal_subdivision_name;
  string7 legal_phase_number;
  string10 legal_tract_number;
  string30 legal_sec_twn_rng_mer;
  string250 legal_brief_description;
  string15 legal_assessor_map_ref;
  string10 census_tract;
  string2 record_type_code;
  string2 ownership_type_code;
  string2 new_record_type_code;
  string10 state_land_use_code;
  string10 county_land_use_code;
  string45 county_land_use_description;
  string4 standardized_land_use_code;
  string1 timeshare_code;
  string25 zoning;
  string1 owner_occupied;
  string20 recorder_document_number;
  string10 recorder_book_number;
  string10 recorder_page_number;
  string8 transfer_date;
  string8 recording_date;
  string8 sale_date;
  string25 document_type;
  string11 sales_price;
  string1 sales_price_code;
  string11 mortgage_loan_amount;
  string5 mortgage_loan_type_code;
  string60 mortgage_lender_name;
  string1 mortgage_lender_type_code;
  string8 prior_transfer_date;
  string8 prior_recording_date;
  string11 prior_sales_price;
  string1 prior_sales_price_code;
  string11 assessed_land_value;
  string11 assessed_improvement_value;
  string11 assessed_total_value;
  string4 assessed_value_year;
  string11 market_land_value;
  string11 market_improvement_value;
  string11 market_total_value;
  string4 market_value_year;
  string1 homestead_homeowner_exemption;
  string1 tax_exemption1_code;
  string1 tax_exemption2_code;
  string1 tax_exemption3_code;
  string1 tax_exemption4_code;
  string18 tax_rate_code_area;
  string13 tax_amount;
  string4 tax_year;
  string4 tax_delinquent_year;
  string15 school_tax_district1;
  string1 school_tax_district1_indicator;
  string15 school_tax_district2;
  string1 school_tax_district2_indicator;
  string15 school_tax_district3;
  string1 school_tax_district3_indicator;
  string20 lot_size;
  string10 lot_size_acres;
  string10 lot_size_frontage_feet;
  string10 lot_size_depth_feet;
  string30 land_acres;
  string30 land_square_footage;
  string30 land_dimensions;
  string9 building_area;
  string1 building_area_indicator;
  string8 building_area1;
  string2 building_area1_indicator;
  string8 building_area2;
  string2 building_area2_indicator;
  string8 building_area3;
  string2 building_area3_indicator;
  string8 building_area4;
  string2 building_area4_indicator;
  string8 building_area5;
  string2 building_area5_indicator;
  string8 building_area6;
  string2 building_area6_indicator;
  string8 building_area7;
  string2 building_area7_indicator;
  string4 year_built;
  string4 effective_year_built;
  string3 no_of_buildings;
  string5 no_of_stories;
  string5 no_of_units;
  string5 no_of_rooms;
  string5 no_of_bedrooms;
  string8 no_of_baths;
  string2 no_of_partial_baths;
  string3 no_of_plumbing_fixtures;
  string3 garage_type_code;
  string5 parking_no_of_cars;
  string3 pool_code;
  string5 style_code;
  string3 type_construction_code;
  string3 foundation_code;
  string3 building_quality_code;
  string3 building_condition_code;
  string3 exterior_walls_code;
  string1 interior_walls_code;
  string3 roof_cover_code;
  string5 roof_type_code;
  string3 floor_cover_code;
  string3 water_code;
  string3 sewer_code;
  string3 heating_code;
  string3 heating_fuel_type_code;
  string3 air_conditioning_code;
  string1 air_conditioning_type_code;
  string1 elevator;
  string1 fireplace_indicator;
  string3 fireplace_number;
  string3 basement_code;
  string3 building_class_code;
  string3 site_influence1_code;
  string1 site_influence2_code;
  string1 site_influence3_code;
  string1 site_influence4_code;
  string1 site_influence5_code;
  string1 amenities1_code;
  string1 amenities2_code;
  string1 amenities3_code;
  string1 amenities4_code;
  string1 amenities5_code;
  string1 amenities2_code1;
  string1 amenities2_code2;
  string1 amenities2_code3;
  string1 amenities2_code4;
  string1 amenities2_code5;
  string9 extra_features1_area;
  string2 extra_features1_indicator;
  string9 extra_features2_area;
  string2 extra_features2_indicator;
  string9 extra_features3_area;
  string2 extra_features3_indicator;
  string9 extra_features4_area;
  string2 extra_features4_indicator;
  string3 other_buildings1_code;
  string1 other_buildings2_code;
  string1 other_buildings3_code;
  string1 other_buildings4_code;
  string1 other_buildings5_code;
  string2 other_impr_building1_indicator;
  string2 other_impr_building2_indicator;
  string2 other_impr_building3_indicator;
  string2 other_impr_building4_indicator;
  string2 other_impr_building5_indicator;
  string9 other_impr_building_area1;
  string9 other_impr_building_area2;
  string9 other_impr_building_area3;
  string9 other_impr_building_area4;
  string9 other_impr_building_area5;
  string1 topograpy_code;
  string9 neighborhood_code;
  string20 condo_project_or_building_name;
  string1 assessee_name_indicator;
  string1 second_assessee_name_indicator;
  string5 other_rooms_indicator;
  string1 mail_care_of_name_indicator;
  string120 comments;
  string6 tape_cut_date;
  string8 certification_date;
  string2 edition_number;
  string1 prop_addr_propagated_ind;
  string3 ln_ownership_rights;
  string2 ln_relationship_type;
  string3 ln_mailing_country_code;
  string50 ln_property_name;
  string1 ln_property_name_type;
  string1 ln_land_use_category;
  string20 ln_lot;
  string20 ln_block;
  string6 ln_unit;
  string1 ln_subfloor;
  string3 ln_floor_cover;
  string1 ln_mobile_home_indicator;
  string1 ln_condo_indicator;
  string1 ln_property_tax_exemption;
  string1 ln_veteran_status;
  string1 ln_old_apn_indicator;
  unsigned8 __internal_fpos__;
 END;



//deeds layout
export deeds_layout := RECORD
  string12 ln_fares_id;
  unsigned6 proc_date;
  string8 process_date;
  string1 vendor_source_flag;
  string1 current_record;
  string1 from_file;
  string5 fips_code;
  string2 state;
  string18 county_name;
  string1 record_type;
  string45 apnt_or_pin_number;
  string45 fares_unformatted_apn;
  string4 multi_apn_flag;
  string39 tax_id_number;
  string10 excise_tax_number;
  string1 buyer_or_borrower_ind;
  string80 name1;
  string2 name1_id_code;
  string80 name2;
  string2 name2_id_code;
  string2 vesting_code;
  string1 addendum_flag;
  string10 phone_number;
  string40 mailing_care_of;
  string70 mailing_street;
  string6 mailing_unit_number;
  string51 mailing_csz;
  string1 mailing_address_cd;
  string80 seller1;
  string2 seller1_id_code;
  string80 seller2;
  string2 seller2_id_code;
  string1 seller_addendum_flag;
  string70 seller_mailing_full_street_address;
  string6 seller_mailing_address_unit_number;
  string51 seller_mailing_address_citystatezip;
  string70 property_full_street_address;
  string6 property_address_unit_number;
  string51 property_address_citystatezip;
  string1 property_address_code;
  string2 legal_lot_code;
  string10 legal_lot_number;
  string7 legal_block;
  string7 legal_section;
  string7 legal_district;
  string7 legal_land_lot;
  string6 legal_unit;
  string30 legal_city_municipality_township;
  string50 legal_subdivision_name;
  string7 legal_phase_number;
  string10 legal_tract_number;
  string30 legal_sec_twn_rng_mer;
  string100 legal_brief_description;
  string20 recorder_map_reference;
  string1 complete_legal_description_code;
  string8 contract_date;
  string8 recording_date;
  string8 arm_reset_date;
  string20 document_number;
  string3 document_type_code;
  string20 loan_number;
  string10 recorder_book_number;
  string10 recorder_page_number;
  string19 concurrent_mortgage_book_page_document_number;
  string11 sales_price;
  string1 sales_price_code;
  string8 city_transfer_tax;
  string8 county_transfer_tax;
  string8 total_transfer_tax;
  string11 first_td_loan_amount;
  string11 second_td_loan_amount;
  string1 first_td_lender_type_code;
  string5 second_td_lender_type_code;
  string5 first_td_loan_type_code;
  string4 type_financing;
  string5 first_td_interest_rate;
  string8 first_td_due_date;
  string60 title_company_name;
  string3 partial_interest_transferred;
  string5 loan_term_months;
  string5 loan_term_years;
  string40 lender_name;
  string6 lender_name_id;
  string40 lender_dba_aka_name;
  string60 lender_full_street_address;
  string6 lender_address_unit_number;
  string41 lender_address_citystatezip;
  string4 assessment_match_land_use_code;
  string3 property_use_code;
  string1 condo_code;
  string1 timeshare_flag;
  string10 land_lot_size;
  string6 hawaii_tct;
  string4 hawaii_condo_cpr_code;
  string30 hawaii_condo_name;
  string1 filler_except_hawaii;
  string1 rate_change_frequency;
  string4 change_index;
  string15 adjustable_rate_index;
  string1 adjustable_rate_rider;
  string1 graduated_payment_rider;
  string1 balloon_rider;
  string1 fixed_step_rate_rider;
  string1 condominium_rider;
  string1 planned_unit_development_rider;
  string1 rate_improvement_rider;
  string1 assumability_rider;
  string1 prepayment_rider;
  string1 one_four_family_rider;
  string1 biweekly_payment_rider;
  string1 second_home_rider;
  string3 data_source_code;
  string1 main_record_id_code;
  string1 addl_name_flag;
  string1 prop_addr_propagated_ind;
  string3 ln_ownership_rights;
  string2 ln_relationship_type;
  string3 ln_buyer_mailing_country_code;
  string3 ln_seller_mailing_country_code;
  unsigned8 __internal_fpos__;
 END;


//gong layout
export gong_layout := RECORD
  unsigned6 l_did;
  boolean current_flag;
  boolean business_flag;
  string2 src;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
  string3 prior_area_code;
  string10 phone10;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 v_predir;
  string28 v_prim_name;
  string4 v_suffix;
  string2 v_postdir;
  string25 v_city_name;
  string2 st;
  string5 z5;
  string4 z4;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string32 designation;
  string5 name_prefix;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
  string5 name_suffix;
  string120 listed_name;
  string254 caption_text;
  string1 omit_address;
  string1 omit_phone;
  string1 omit_locality;
  string64 see_also_text;
  unsigned6 did;
  unsigned6 hhid;
  unsigned6 bdid;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string1 current_record_flag;
  string8 deletion_date;
  unsigned2 disc_cnt6;
  unsigned2 disc_cnt12;
  unsigned2 disc_cnt18;
  unsigned8 persistent_record_id;
 END;


export dirs_addr_lay := record
recordof(riskwise.getDirsByAddr);
end;
export dirs_phone_lay := record
recordof(riskwise.getDirsByPhone);
end;



//liens layout
export liens_by_did_lay := RECORD
  unsigned6 did;
  string50 tmsid;
  string50 rmsid;
  unsigned8 __internal_fpos__;
 END;

export layout_filing_status := RECORD,maxlength(10000)
   string filing_status;
   string filing_status_desc;
  END;

export liens_main_lay := RECORD,maxlength(32766)
  string50 tmsid;
  string50 rmsid;
  string process_date;
  string record_code;
  string date_vendor_removed;
  string filing_jurisdiction;
  string filing_state;
  string20 orig_filing_number;
  string orig_filing_type;
  string orig_filing_date;
  string orig_filing_time;
  string case_number;
  string20 filing_number;
  string filing_type_desc;
  string filing_date;
  string filing_time;
  string vendor_entry_date;
  string judge;
  string case_title;
  string filing_book;
  string filing_page;
  string release_date;
  string amount;
  string eviction;
  string satisifaction_type;
  string judg_satisfied_date;
  string judg_vacated_date;
  string tax_code;
  string irs_serial_number;
  string effective_date;
  string lapse_date;
  string accident_date;
  string sherrif_indc;
  string expiration_date;
  string agency;
  string agency_city;
  string agency_state;
  string agency_county;
  string legal_lot;
  string legal_block;
  string legal_borough;
  string certificate_number;
  unsigned8 persistent_record_id;
  DATASET(layout_filing_status) filing_status;
  unsigned8 __internal_fpos__;
 END;

export liens_party_lay := RECORD
  string50 tmsid;
  string50 rmsid;
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
 END;
 
 export bkruptv3_by_did_lay := record
 string did;
 string tmsid;
 string court_code;
 string case_number;
 string internal_fpos;
 end;
 
export bankruptcyv3_search_lay := Record 
string process_date;
string caseid;
string defendantid;
string recid;
string tmsid;
string seq_number;
string court_code;
string case_number;
string orig_case_number;
string chapter;
string filing_type;
string business_flag;
string corp_flag;
string discharged;
string disposition;
string pro_se_ind;
string converted_date;
string orig_county;
string debtor_type;
string debtor_seq;
string ssn;
string ssnsrc;
string ssnmatch;
string ssnmsrc;
string screen;
string dcode;
string disptype;
string dispreason;
string statusdate;
string holdcase;
string datevacated;
string datetransferred;
string activityreceipt;
string tax_id;
string name_type;
string orig_name;
string orig_fname;
string orig_mname;
string orig_lname;
string orig_name_suffix;
string title;
string fname;
string mname;
string lname;
string name_suffix;
string name_score;
string cname;
string orig_company;
string orig_addr1;
string orig_addr2;
string orig_city;
string orig_st;
string orig_zip5;
string orig_zip4;
string orig_email;
string orig_fax;
string prim_range;
string predir;
string prim_name;
string addr_suffix;
string postdir;
string unit_desig;
string sec_range;
string p_city_name;
string v_city_name;
string st;
string zip;
string zip4;
string cart;
string cr_sort_sz;
string lot;
string lot_order;
string dbpc;
string chk_digit;
string rec_type;
string county;
string geo_lat;
string geo_long;
string msa;
string geo_blk;
string geo_match;
string err_stat;
string phone;
string did;
string bdid;
string app_ssn;
string app_tax_id;
string date_first_seen;
string date_last_seen;
string date_vendor_first_reported;
string date_vendor_last_reported;
string disptypedesc;
string srcdesc;
string srcmtchdesc;
string screendesc;
string dcodedesc;
string date_filed;
string record_type;
end; 
  
export bankruptcyv3_main_lay := record
BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing
 end;
 
export alloy_student_lay := record
  string did;
  string school_act_code;
  string tuition_code;
  string public_private_code;
  string school_size_code;
  string student_last_name;
  string student_first_name;
  string gender_code;
  string competitive_code;
  string intl_exchange_student_code;
  string address_sequence_code;
  string school_name;
  string school_address_2_secondary;
  string filler_1;
  string school_address_1_primary;
  string filler_2;
  string school_city;
  string school_state;
  string school_zip5;
  string school_zip4;
  string school_phone_number;
  string school_housing_code;
  string filler_3;
  string home_address_1_secondary;
  string filler_4;
  string home_address_2_primary;
  string filler_5;
  string home_city;
  string home_state;
  string home_zip5;
  string home_zip4;
  string home_phone_number;
  string home_housing_code;
  string class_rank;
  string major_code;
  string school_info_time_zone;
  string filler_6;
  string filler_7;
  string home_info_time_zone;
  string filler_8;
  string filler_9;
  string address_type;
  string address_info_code;
  string sequence_number;
  string filler_10;
  string filler_11;
  string key_code;
  string carriage_return;
  string line_feed;
  string file_type;
  string ln_college_name;
  string tier;
  string did_score;
  string clean_title;
  string clean_fname;
  string clean_mname;
  string clean_lname;
  string clean_name_suffix;
  string clean_name_score;
  string clean_addr_code;
  string rawaid;
  string append_prep_address;
  string append_prep_address_last;
  string clean_phone_number;
  string clean_prim_range;
  string clean_predir;
  string clean_prim_name;
  string clean_addr_suffix;
  string clean_postdir;
  string clean_unit_desig;
  string clean_sec_range;
  string clean_p_city_name;
  string clean_v_city_name;
  string clean_st;
  string clean_zip5;
  string clean_zip4;
  string clean_cart;
  string clean_cr_sort_sz;
  string clean_lot;
  string clean_lot_order;
  string clean_dbpc;
  string clean_chk_digit;
  string clean_rec_type;
  string clean_county;
  string clean_ace_fips_st;
  string clean_fips_county;
  string clean_geo_lat;
  string clean_geo_long;
  string clean_msa;
  string clean_geo_blk;
  string clean_geo_match;
  string clean_err_stat;
  string process_date;
  string date_first_seen;
  string date_last_seen;
  string date_vendor_first_reported;
  string date_vendor_last_reported;
  string tier2;
  string source;
  string __internal_fpos__;
 END;

export american_student2_lay := record
string l_did;
string key;
string ssn;
string did;
string process_date;
string date_first_seen;
string date_last_seen;
string date_vendor_first_reported;
string date_vendor_last_reported;
string historical_flag;
string full_name;
string first_name;
string last_name;
string address_1;
string address_2;
string city;
string state;
string zip;
string zip_4;
string crrt_code;
string delivery_point_barcode;
string zip4_check_digit;
string address_type_code;
string address_type;
string county_number;
string county_name;
string gender_code;
string gender;
string age;
string birth_date;
string dob_formatted;
string telephone;
string class;
string college_class;
string college_name;
string ln_college_name;
string college_major;
string new_college_major;
string college_code;
string college_code_exploded;
string college_type;
string college_type_exploded;
string head_of_household_first_name;
string head_of_household_gender_code;
string head_of_household_gender;
string income_level_code;
string income_level;
string new_income_level_code;
string new_income_level;
string file_type;
string tier;
string school_size_code;
string competitive_code;
string tuition_code;
string title;
string fname;
string mname;
string lname;
string name_suffix;
string name_score;
string rawaid;
string prim_range;
string predir;
string prim_name;
string addr_suffix;
string postdir;
string unit_desig;
string sec_range;
string p_city_name;
string v_city_name;
string st;
string z5;
string zip4;
string cart;
string cr_sort_sz;
string lot;
string lot_order;
string dpbc;
string chk_digit;
string rec_type;
string county;
string ace_fips_st;
string fips_county;
string geo_lat;
string geo_long;
string msa;
string geo_blk;
string geo_match;
string err_stat;
string tier2;
string source;
string internal_fpos;
end;
 
 
peopleatwork_lay := record
 string contact_id;
string did;
string bdid;
string ssn;
string score;
string company_name;
string company_prim_range;
string company_predir;
string company_prim_name;
string company_addr_suffix;
string company_postdir;
string company_unit_desig;
string company_sec_range;
string company_city;
string company_state;
string company_zip;
string company_zip4;
string company_title;
string company_department;
string company_phone;
string company_fein;
string title;
string fname;
string mname;
string lname;
string name_suffix;
string prim_range;
string predir;
string prim_name;
string addr_suffix;
string postdir;
string unit_desig;
string sec_range;
string city;
string state;
string zip;
string zip4;
string county;
string msa;
string geo_lat;
string geo_long;
string phone;
string email_address;
string dt_first_seen;
string dt_last_seen;
string record_type;
string active_phone_flag;
string glb;
string source;
string dppa_state;
string old_score;
string source_count;
string dead_flag;
string company_status;
string dotid;
string dotscore;
string dotweight;
string empid;
string empscore;
string empweight;
string powid;
string powscore;
string powweight;
string proxid;
string proxscore;
string proxweight;
string seleid;
string selescore;
string seleweight;
string orgid;
string orgscore;
string orgweight;
string ultid;
string ultscore;
string ultweight;
end;
 
advo_lay := record
string zip;
string prim_range;
string prim_name;
string addr_suffix;
string predir;
string postdir;
string sec_range;
string zip_5;
string route_num;
string zip_4;
string walk_sequence;
string street_num;
string street_pre_directional;
string street_name;
string street_post_directional;
string street_suffix;
string secondary_unit_designator;
string secondary_unit_number;
string address_vacancy_indicator;
string throw_back_indicator;
string seasonal_delivery_indicator;
string seasonal_start_suppression_date;
string seasonal_end_suppression_date;
string dnd_indicator;
string college_indicator;
string college_start_suppression_date;
string college_end_suppression_date;
string address_style_flag;
string simplify_address_count;
string drop_indicator;
string residential_or_business_ind;
string dpbc_digit;
string dpbc_check_digit;
string update_date;
string file_release_date;
string override_file_release_date;
string county_num;
string county_name;
string city_name;
string state_code;
string state_num;
string congressional_district_number;
string owgm_indicator;
string record_type_code;
string advo_key;
string address_type;
string mixed_address_usage;
string date_first_seen;
string date_last_seen;
string date_vendor_first_reported;
string date_vendor_last_reported;
string vac_begdt;
string vac_enddt;
string months_vac_curr;
string months_vac_max;
string vac_count;
string unit_desig;
string p_city_name;
string v_city_name;
string st;
string zip4;
string cart;
string cr_sort_sz;
string lot;
string lot_order;
string dbpc;
string chk_digit;
string rec_type;
string fips_county;
string county;
string geo_lat;
string geo_long;
string msa;
string geo_blk;
string geo_match;
string err_stat;
string src;
string internal_fpos;
end; 



utility_lay := record
string prim_name;
string st;
string zip;
string prim_range;
string sec_range;
string id;
string exchange_serial_number;
string date_added_to_exchange;
string connect_date;
string date_first_seen;
string record_date;
string util_type;
string orig_lname;
string orig_fname;
string orig_mname;
string orig_name_suffix;
string addr_type;
string addr_dual;
string address_street;
string address_street_name;
string address_street_type;
string address_street_direction;
string address_apartment;
string address_city;
string address_state;
string address_zip;
string ssn;
string work_phone;
string phone;
string dob;
string drivers_license_state_code;
string drivers_license;
string predir;
string addr_suffix;
string postdir;
string unit_desig;
string p_city_name;
string v_city_name;
string zip4;
string cart;
string cr_sort_sz;
string lot;
string lot_order;
string dbpc;
string chk_digit;
string rec_type;
string county;
string geo_lat;
string geo_long;
string msa;
string geo_blk;
string geo_match;
string err_stat;
string did;
string title;
string fname;
string mname;
string lname;
string name_suffix;
string name_score;
string internal_fpos;
end;

//emaildata nested layout
layout_clean_name := RECORD
   string title;
   string fname;
   string mname;
   string lname;
   string name_suffix;
   string name_score;
  END;

layout_clean182 := RECORD
   string prim_range;
   string predir;
   string prim_name;
   string addr_suffix;
   string postdir;
   string unit_desig;
   string sec_range;
   string p_city_name;
   string v_city_name;
   string st;
   string zip;
   string zip4;
   string cart;
   string cr_sort_sz;
   string lot;
   string lot_order;
   string dbpc;
   string chk_digit;
   string rec_type;
   string county;
   string geo_lat;
   string geo_long;
   string msa;
   string geo_blk;
   string geo_match;
   string err_stat;
  END;


emaildata_lay := RECORD
  string did;
  string clean_email;
  string append_email_username;
  string append_domain;
  string append_domain_type;
  string append_domain_root;
  string append_domain_ext;
  string append_is_tld_state;
  string append_is_tld_generic;
  string append_is_tld_country;
  string append_is_valid_domain_ext;
  string email_rec_key;
  string email_src;
  string rec_src_all;
  string email_src_all;
  string email_src_num;
  string num_email_per_did;
  string num_did_per_email;
  string orig_pmghousehold_id;
  string orig_pmgindividual_id;
  string orig_first_name;
  string orig_last_name;
  string orig_address;
  string orig_city;
  string orig_state;
  string orig_zip;
  string orig_zip4;
  string orig_email;
  string orig_ip;
  string orig_login_date;
  string orig_site;
  string orig_e360_id;
  string orig_teramedia_id;
  string did_score;
  string did_type;
  string is_did_prop;
  string hhid;
  layout_clean_name clean_name;
  layout_clean182 clean_address;
  string append_rawaid;
  string best_ssn;
  string best_dob;
  string process_date;
  string activecode;
  string date_first_seen;
  string date_last_seen;
  string date_vendor_first_reported;
  string date_vendor_last_reported;
  string current_rec;
  string __internal_fpos__;
 END;
 
 Relatives_lay := record
 string did1;
string type;
string confidence;
string did2;
string cohabit_score;
string cohabit_cnt;
string coapt_score;
string coapt_cnt;
string copobox_score;
string copobox_cnt;
string cossn_score;
string cossn_cnt;
string copolicy_score;
string copolicy_cnt;
string coclaim_score;
string coclaim_cnt;
string coproperty_score;
string coproperty_cnt;
string bcoproperty_score;
string bcoproperty_cnt;
string coforeclosure_score;
string coforeclosure_cnt;
string bcoforeclosure_score;
string bcoforeclosure_cnt;
string colien_score;
string colien_cnt;
string bcolien_score;
string bcolien_cnt;
string cobankruptcy_score;
string cobankruptcy_cnt;
string bcobankruptcy_score;
string bcobankruptcy_cnt;
string covehicle_score;
string covehicle_cnt;
string coexperian_score;
string coexperian_cnt;
string cotransunion_score;
string cotransunion_cnt;
string coenclarity_score;
string coenclarity_cnt;
string coecrash_score;
string coecrash_cnt;
string bcoecrash_score;
string bcoecrash_cnt;
string cowatercraft_score;
string cowatercraft_cnt;
string coaircraft_score;
string coaircraft_cnt;
string comarriagedivorce_score;
string comarriagedivorce_cnt;
string coucc_score;
string coucc_cnt;
string lname_score;
string phone_score;
string dl_nbr_score;
string total_cnt;
string total_score;
string cluster;
string generation;
string gender;
string lname_cnt;
string rel_dt_first_seen;
string rel_dt_last_seen;
string overlap_months;
string hdr_dt_first_seen;
string hdr_dt_last_seen;
string age_first_seen;
string isanylnamematch;
string isanyphonematch;
string isearlylnamematch;
string iscurrlnamematch;
string ismixedlnamematch;
string ssn1;
string ssn2;
string dob1;
string dob2;
string current_lname1;
string current_lname2;
string early_lname1;
string early_lname2;
string addr_ind1;
string addr_ind2;
string r2rdid;
string r2cnt;
string personal;
string business;
string other;
string title;
string title_type;
string source_type;
string isrelative;
string isassociate;
string isbusiness;
end;
 
 History := record
 string history_date;
string land_use;
string recording_date;
string assessed_value_year;
string sales_price;
string assessed_total_value;
string market_total_value;
string tax_assessment_valuation;
string price_index_valuation;
string hedonic_valuation;
string automated_valuation;
string confidence_score;
end;

avm_addr_lay := record
string prim_name;
string st;
string zip;
string prim_range;
string sec_range;
string history_date;
string ln_fares_id_ta;
string ln_fares_id_pi;
string unformatted_apn;
string predir;
string suffix;
string postdir;
string unit_desig;
string p_city_name;
string zip4;
string lat;
string long;
string geo_blk;
string fips_code;
string land_use;
string recording_date;
string assessed_value_year;
string sales_price;
string assessed_total_value;
string market_total_value;
string tax_assessment_valuation;
string price_index_valuation;
string hedonic_valuation;
string automated_valuation;
string confidence_score;
string comp1;
string comp2;
string comp3;
string comp4;
string comp5;
string nearby1;
string nearby2;
string nearby3;
string nearby4;
string nearby5;
history History;
string internal_fpos;
 end;
 
 
select_avm_lay:= record
string history_date;
string ln_fares_id_ta;
string ln_fares_id_pi;
string unformatted_apn;
string prim_range;
string predir;
string prim_name;
string suffix;
string postdir;
string unit_desig;
string sec_range;
string p_city_name;
string st;
string zip;
string zip4;
string lat;
string long;
string geo_blk;
string fips_code;
string land_use;
string recording_date;
string assessed_value_year;
string sales_price;
string assessed_total_value;
string market_total_value;
string tax_assessment_valuation;
string price_index_valuation;
string hedonic_valuation;
string automated_valuation;
string confidence_score;
string comp1;
string comp2;
string comp3;
string comp4;
string comp5;
string nearby1;
string nearby2;
string nearby3;
string nearby4;
string nearby5;
string automated_valuation2;
string automated_valuation3;
string automated_valuation4;
string automated_valuation5;
string automated_valuation6;
end;

aircraft_lay := record
string d_score;
string best_ssn;
string did_out;
string bdid_out;
string date_first_seen;
string date_last_seen;
string current_flag;
string n_number;
string serial_number;
string mfr_mdl_code;
string eng_mfr_mdl;
string year_mfr;
string type_registrant;
string name;
string street;
string street2;
string city;
string state;
string zip_code;
string region;
string orig_county;
string country;
string last_action_date;
string cert_issue_date;
string certification;
string type_aircraft;
string type_engine;
string status_code;
string mode_s_code;
string fract_owner;
string aircraft_mfr_name;
string model_name;
string prim_range;
string predir;
string prim_name;
string addr_suffix;
string postdir;
string unit_desig;
string sec_range;
string p_city_name;
string v_city_name;
string st;
string zip;
string z4;
string cart;
string cr_sort_sz;
string lot;
string lot_order;
string dpbc;
string chk_digit;
string rec_type;
string ace_fips_st;
string county;
string geo_lat;
string geo_long;
string msa;
string geo_blk;
string geo_match;
string err_stat;
string title;
string fname;
string mname;
string lname;
string name_suffix;
string compname;
string persistent_record_id;
end;

business_best_lay := record 
string bdid;
string dt_last_seen;
string company_name;
string prim_range;
string predir;
string prim_name;
string addr_suffix;
string postdir;
string unit_desig;
string sec_range;
string city;
string state;
string zip;
string zip4;
string phone;
string fein;
string best_flags;
string source;
string dppa_state;
string internal_fpos;
end;

business_header_lay := record
string bdid;
string source;
string source_group;
string dt_first_seen;
string dt_last_seen;
string dt_vendor_first_reported;
string dt_vendor_last_reported;
string company_name;
string prim_range;
string predir;
string prim_name;
string addr_suffix;
string postdir;
string unit_desig;
string sec_range;
string city;
string state;
string zip;
string zip4;
string county;
string msa;
string geo_lat;
string geo_long;
string phone;
string phone_score;
string fein;
string current;
string dppa;
string vendor_st;
string internal_fpos;
end;

bdid_table_lay := record
string bdid;
string zip;
string prim_name;
string prim_range;
string bdid_per_addr;
string apts;
string ppl;
string r_phone_per_addr;
string b_phone_per_addr;
string dnb_emps;
string irs5500_emps;
string domainss;
string sources;
string company_name_score;
string combined_score;
string gong_yp_cnt;
string current_corp_cnt;
string dt_first_seen_min;
string dt_last_seen_max;
string dt_vendor_first_reported_min;
string dt_first_seen_y;
string dt_last_seen_y;
string dt_first_seen_g;
string dt_last_seen_g;
string dt_first_seen_c;
string dt_last_seen_c;
string dt_first_seen_br;
string dt_last_seen_br;
string dt_first_seen_ucc;
string dt_last_seen_ucc;
string dt_first_seen_d;
string dt_last_seen_d;
string dt_first_seen_i;
string dt_last_seen_i;
string dt_first_seen_st;
string dt_last_seen_st;
string dt_last_seen_b;
string dt_last_seen_lj;
string dt_first_seen_bm;
string dt_last_seen_bm;
string dt_first_seen_bn;
string dt_last_seen_bn;
string dt_first_seen_ia;
string dt_last_seen_ia;
string dt_first_seen_dc;
string dt_last_seen_dc;
string dt_first_seen_eb;
string dt_last_seen_eb;
string gong_current_record_flag;
string gong_deletion_date;
string gong_disc_cnt6;
string gong_disc_cnt12;
string gong_disc_cnt18;
string cnt_base;
string cnt_ae;
string cnt_af;
string cnt_at;
string cnt_aw;
string cnt_b;
string cnt_bm;
string cnt_bn;
string cnt_br;
string cnt_c;
string cnt_cu;
string cnt_d;
string cnt_dc;
string cnt_de;
string cnt_e;
string cnt_eb;
string cnt_ed;
string cnt_f;
string cnt_fa;
string cnt_fc;
string cnt_fd;
string cnt_ff;
string cnt_fn;
string cnt_gb;
string cnt_gg;
string cnt_i;
string cnt_ia;
string cnt_id;
string cnt_if;
string cnt_ii;
string cnt_in;
string cnt_lj;
string cnt_lb;
string cnt_lp;
string cnt_md;
string cnt_mv;
string cnt_pl;
string cnt_pr;
string cnt_sb;
string cnt_sk;
string cnt_st;
string cnt_u;
string cnt_v;
string cnt_w;
string cnt_wc;
string cnt_wt;
string cnt_y;
end;

bdid_risk_table_lay := record
string bdid;
string prscore;
string prscore_date;
string best_companyname;
string best_addr1;
string best_addr2;
string best_phone;
string best_fein;
string busreg_flag;
string corp_flag;
string dnb_flag;
string irs5500_flag;
string st_flag;
string ucc_flag;
string yp_flag;
string tier1srcs;
string t1scr5;
string currphn;
string currcorp;
string currbr;
string currdnb;
string currucc;
string curry;
string currt1cnt;
string currt1src4;
string year_lj;
string lj;
string ustic;
string t1x;
string ofac_cnt;
string cnt_b;
end;


 EXPORT layout_Soap_output := Record
	DATASET(HeaderRecsLayout) header_records_by_did {XPATH('Dataset[@name=\'header_records_by_did\']/Row')};
	DATASET(BestDataLayout) best_data {XPATH('Dataset[@name=\'best_data\']/Row')};
	DATASET(IBehaviorLayout) ibehavior_consumer {XPATH('Dataset[@name=\'ibehavior_consumer\']/Row')};
	DATASET(IBehaviorLayout2) ibehavior_purchase {XPATH('Dataset[@name=\'ibehavior_purchase\']/Row')};
	DATASET(InquiryTableFullLayout) inquiries_nonfcra {XPATH('Dataset[@name=\'inquiries_nonfcra\']/Row')};
	DATASET(InquiryTableFullLayout) inquiries_update_nonfcra {XPATH('Dataset[@name=\'inquiries_update_nonfcra\']/Row')};
	dataset(Crim_Layout) criminal_Offenders_Risk {XPATH('Dataset[@name=\'criminal_Offenders_Risk\']/Row')};
	dataset(Prof_Lic_Layout) prof_license_records {XPATH('Dataset[@name=\'prof_license_records\']/Row')};
	dataset(watercraft_layout) watercraft_records {XPATH('Dataset[@name=\'watercraft_records\']/Row')};
	dataset(fares_search_layout) fares_search {XPATH('Dataset[@name=\'fares_search\']/Row')};
	dataset(assessments_layout) assessments {XPATH('Dataset[@name=\'assessments\']/Row')};
	dataset(deeds_layout) deeds {XPATH('Dataset[@name=\'deeds\']/Row')};
	dataset(gong_layout) gong_by_did {XPATH('Dataset[@name=\'gong_by_did\']/Row')};
	dataset(dirs_addr_lay) dirs_addr_recs {XPATH('Dataset[@name=\'dirs_addr_recs\']/Row')};
	dataset(dirs_phone_lay) dirs_phone_recs {XPATH('Dataset[@name=\'dirs_phone_recs\']/Row')};
	dataset(liens_by_did_lay) liens_by_did {XPATH('Dataset[@name=\'liens_by_did\']/Row')};
	dataset(liens_main_lay) liens_main {XPATH('Dataset[@name=\'liens_main\']/Row')};
	dataset(liens_party_lay) liens_party {XPATH('Dataset[@name=\'liens_party\']/Row')};
	dataset(bkruptv3_by_did_lay) bkruptv3_by_did {XPATH('Dataset[@name=\'bkruptv3_by_did\']/Row')};
	dataset(bankruptcyv3_search_lay) bankruptcyv3_search {XPATH('Dataset[@name=\'bankruptcyv3_search\']/Row')};
	dataset(bankruptcyv3_main_lay) bankruptcyv3_main {XPATH('Dataset[@name=\'bankruptcyv3_main\']/Row')};
	dataset(american_student2_lay) american_student2 {XPATH('Dataset[@name=\'american_student2\']/Row')};
	dataset(alloy_student_lay) alloy_student {XPATH('Dataset[@name=\'alloy_student\']/Row')};
	dataset(peopleatwork_lay) peopleatwork {XPATH('Dataset[@name=\'peopleatwork\']/Row')};
	dataset(advo_lay) advo_addr {XPATH('Dataset[@name=\'advo_addr\']/Row')};
	dataset(utility_lay) utiliRecsByAddr {XPATH('Dataset[@name=\'utiliRecsByAddr\']/Row')};
	dataset(emaildata_lay) email_data_nonfcra {XPATH('Dataset[@name=\'email_data_nonfcra\']/Row')};
	dataset(Relatives_lay) Relatives {XPATH('Dataset[@name=\'Relatives\']/Row')};
	dataset(avm_addr_lay) avm_addr {XPATH('Dataset[@name=\'avm_addr\']/Row')};
	dataset(select_avm_lay) selected_AVM {XPATH('Dataset[@name=\'selected_AVM\']/Row')};
	dataset(aircraft_lay) aircraftRecs {XPATH('Dataset[@name=\'aircraftRecs\']/Row')};
	dataset(business_best_lay) business_best {XPATH('Dataset[@name=\'business_best\']/Row')};
	dataset(business_header_lay) business_header {XPATH('Dataset[@name=\'business_header\']/Row')};
	dataset(bdid_table_lay) bdid_table {XPATH('Dataset[@name=\'bdid_table\']/Row')};
	dataset(bdid_risk_table_lay) bdid_risk_table {XPATH('Dataset[@name=\'bdid_risk_table\']/Row')};
END;

//trans for liens party

export party1 := RECORD
  string50 tmsid;
  string50 rmsid;
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
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
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
end;


export date1 := record
  string8 date_last_seen;
end;	
	
export party2 := record
  string8 date_vendor_first_reported;
end;

export date2 := record
  string8 date_vendor_last_reported;
end;

export party3 := record
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
 END;
 
export liens_party2 := record
 party1 party1;
 date1	date1;
 party2 party2;
 date2	date2;
 party3 party3;
End;


export liens_party2 new_lien_party(liens_party_lay l) := transform 
  self.party1.tmsid := l.tmsid;
  self.party1.rmsid := l.rmsid;
  self.party1.orig_full_debtorname := l.orig_full_debtorname;
  self.party1.orig_name := l.orig_name;
  self.party1.orig_lname := l.orig_lname;
  self.party1.orig_fname := l.orig_fname;
  self.party1.orig_mname := l.orig_mname;
  self.party1.orig_suffix := l.orig_suffix;
  self.party1.tax_id := l.tax_id;
  self.party1.ssn := l.ssn;
  self.party1.title := l.title;
  self.party1.fname := l.fname;
  self.party1.mname := l.mname;
  self.party1.lname := l.lname;
  self.party1.name_suffix := l.name_suffix;
  self.party1.name_score := l.name_score;
  self.party1.cname := l.cname;
  self.party1.orig_address1 := l.orig_address1;
  self.party1.orig_address2 := l.orig_address2;
  self.party1.orig_city := l.orig_city;
  self.party1.orig_state := l.orig_state;
  self.party1.orig_zip5 := l.orig_zip5;
  self.party1.orig_zip4 := l.orig_zip4;
  self.party1.orig_county := l.orig_county;
  self.party1.orig_country := l.orig_country;
  self.party1.prim_range := l.prim_range;
  self.party1.predir := l.predir;
  self.party1.prim_name := l.prim_name;
  self.party1.addr_suffix := l.addr_suffix;
  self.party1.postdir := l.postdir;
  self.party1.unit_desig := l.unit_desig;
  self.party1.sec_range := l.sec_range;
  self.party1.p_city_name := l.p_city_name;
  self.party1.v_city_name := l.v_city_name;
  self.party1.st := l.st;
  self.party1.zip := l.zip;
  self.party1.zip4 := l.zip4;
  self.party1.cart := l.cart;
  self.party1.cr_sort_sz := l.cr_sort_sz;
  self.party1.lot := l.lot;
  self.party1.lot_order := l.lot_order;
  self.party1.dbpc := l.dbpc;
  self.party1.chk_digit := l.chk_digit;
  self.party1.rec_type := l.rec_type;
  self.party1.county := l.county;
  self.party1.geo_lat := l.geo_lat;
  self.party1.geo_long := l.geo_long;
  self.party1.msa := l.msa;
  self.party1.geo_blk := l.geo_blk;
  self.party1.geo_match := l.geo_match;
  self.party1.err_stat := l.err_stat;
  self.party1.phone := l.phone;
  self.party1.name_type := l.name_type;
  self.party1.did := l.did;
  self.party1.bdid := l.bdid;
  self.party1.date_first_seen := l.date_first_seen;
  self.date1.date_last_seen := l.date_last_seen;
  self.party2.date_vendor_first_reported := l.date_vendor_first_reported;
  self.date2.date_vendor_last_reported := l.date_vendor_last_reported;
  self.party3.persistent_record_id := l.persistent_record_id;
  self.party3.dotid := l.dotid;
  self.party3.dotscore := l.dotscore;
  self.party3.dotweight := l.dotweight;
  self.party3.empid := l.empid;
  self.party3.empscore := l.empscore;
  self.party3.empweight := l.empweight;
  self.party3.powid := l.powid;
  self.party3.powscore := l.powscore;
  self.party3.powweight := l.powweight;
  self.party3.proxid := l.proxid;
  self.party3.proxscore := l.proxscore;
  self.party3.proxweight := l.proxweight;
  self.party3.seleid := l.seleid;
  self.party3.selescore := l.selescore;
  self.party3.seleweight := l.seleweight;
  self.party3.orgid := l.orgid;
  self.party3.orgscore := l.orgscore;
  self.party3.orgweight := l.orgweight;
  self.party3.ultid := l.ultid;
  self.party3.ultscore := l.ultscore;
  self.party3.ultweight := l.ultweight;

end;	
	
//tranform for crim

export offense_fields := RECORD
   // string8 process_date;
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

crim := record
 unsigned6 sdid;
  string1 traffic_flag;
  string1 conviction_flag;
  string1 offense_score;
  string1 criminal_offender_level;
end;

main_lay := record
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
  string8 dob;
  string8 dob_alias;
  string13 county_of_birth;
  string25 place_of_birth;
  string25 street_address_1;
  string25 street_address_2;
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
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  string2 st;
  qstring5 zip5;
  qstring4 zip4;
  unsigned1 clean_errors;
  string18 county_name;
  string12 did;
  string3 score;
  string9 ssn_appended;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
end;	

age := record
  string3 age;
  string150 image_link;
end;

offense_date := record
 string8 earliest_offense_date;
  unsigned8 __internal_fpos__;
end;

export Crim_Layout2 := RECORD
	crim crim;  
  string8 process_date;
	main_lay lay;
	string8 src_upload_date;
	age		age;  
	string8 process_date2;
  offense_fields offense;
	offense_date	offense_date;
 END;
 

 
// Crim_Layout2  new_crim_lay (zz_bbraaten2.Proddata_Layout.layout_Soap_output.criminal_Offenders_Risk l) := transform
export Crim_Layout2  new_crim_lay (recordof(layout_Soap_output.criminal_Offenders_Risk) l) := transform
	self.crim.sdid := l.sdid;
  self.crim.traffic_flag := l.traffic_flag;
  self.crim.conviction_flag := l.conviction_flag;
  self.crim.offense_score := l.offense_score;
  self.crim.criminal_offender_level := l.criminal_offender_level;
	
	self.process_date := l.process_date;

	self.lay.file_date := l.file_date;
  self.lay.offender_key := l.offender_key;
  self.lay.vendor := l.vendor;
  self.lay.source_file := l.source_file;
  self.lay.record_type := l.record_type;
  self.lay.orig_state := l.orig_state;
  self.lay.id_num := l.id_num;
  self.lay.pty_nm := l.pty_nm;
  self.lay.pty_nm_fmt := l.pty_nm_fmt;
  self.lay.orig_lname := l.orig_lname;
  self.lay.orig_fname := l.orig_fname;
  self.lay.orig_mname := l.orig_mname;
  self.lay.orig_name_suffix := l.orig_name_suffix;
  self.lay.lname := l.lname;
  self.lay.fname := l.fname;
  self.lay.mname := l.mname;
  self.lay.name_suffix := l.name_suffix;
  self.lay.pty_typ := l.pty_typ;
  self.lay.nitro_flag := l.nitro_flag;
	self.lay.ssn := l.ssn;
  self.lay.case_num := l.case_num;
  self.lay.case_court := l.case_court;
  self.lay.case_date := l.case_date;
  self.lay.case_type := l.case_type;
  self.lay.case_type_desc := l.case_type_desc;
  self.lay.county_of_origin := l.county_of_origin;
  self.lay.dle_num := l.dle_num;
  self.lay.fbi_num := l.fbi_num;
  self.lay.doc_num := l.doc_num;
  self.lay.ins_num := l.ins_num;
  self.lay.dl_num := l.dl_num;
  self.lay.dl_state := l.dl_state;
  self.lay.citizenship := l.citizenship;
  self.lay.dob := l.dob;
  self.lay.dob_alias := l.dob_alias;
  self.lay.county_of_birth := l.county_of_birth;
  self.lay.place_of_birth := l.place_of_birth;
  self.lay.street_address_1 := l.street_address_1;
  self.lay.street_address_2 := l.street_address_2;
  self.lay.street_address_3 := l.street_address_3;
  self.lay.street_address_4 := l.street_address_4;
  self.lay.street_address_5 := l.street_address_5;
  self.lay.current_residence_county := l.current_residence_county;
  self.lay.legal_residence_county := l.legal_residence_county;
  self.lay.race := l.race;
  self.lay.race_desc := l.race_desc;
  self.lay.sex := l.sex;
  self.lay.hair_color := l.hair_color;
  self.lay.hair_color_desc := l.hair_color_desc;
  self.lay.eye_color := l.eye_color;
  self.lay.eye_color_desc := l.eye_color_desc;
  self.lay.skin_color := l.skin_color;
  self.lay.skin_color_desc := l.skin_color_desc;
  self.lay.scars_marks_tattoos_1 := l.scars_marks_tattoos_1;
  self.lay.scars_marks_tattoos_2 := l.scars_marks_tattoos_2;
  self.lay.scars_marks_tattoos_3 := l.scars_marks_tattoos_3;
  self.lay.scars_marks_tattoos_4 := l.scars_marks_tattoos_4;
  self.lay.scars_marks_tattoos_5 := l.scars_marks_tattoos_5;
  self.lay.height := l.height;
  self.lay.weight := l.weight;
  self.lay.party_status := l.party_status;
  self.lay.party_status_desc := l.party_status_desc;
  self.lay._3g_offender := l._3g_offender;
  self.lay.violent_offender := l.violent_offender;
  self.lay.sex_offender := l.sex_offender;
  self.lay.vop_offender := l.vop_offender;
  self.lay.data_type := l.data_type;
  self.lay.record_setup_date := l.record_setup_date;
	self.lay.datasource := l.datasource;
  self.lay.prim_range := l.prim_range;
  self.lay.predir := l.predir;
  self.lay.prim_name := l.prim_name;
  self.lay.addr_suffix := l.addr_suffix;
  self.lay.postdir := l.postdir;
  self.lay.unit_desig := l.unit_desig;
  self.lay.sec_range := l.sec_range;
  self.lay.p_city_name := l.p_city_name;
  self.lay.v_city_name := l.v_city_name;
  self.lay.st := l.st;
  self.lay.zip5 := l.zip5;
  self.lay.zip4 := l.zip4;
  self.lay.clean_errors := l.clean_errors;
  self.lay.county_name := l.county_name;
  self.lay.did := l.did;
	self.lay.score := l.score;
  self.lay.ssn_appended := l.ssn_appended;
  self.lay.curr_incar_flag := l.curr_incar_flag;
  self.lay.curr_parole_flag := l.curr_parole_flag;
  self.lay.curr_probation_flag := l.curr_probation_flag;

	self.src_upload_date := l.src_upload_date;
  self.age.age := l.age;
  self.age.image_link := l.image_link;
	 self.process_date2 := l.offense.process_date;

    self.offense.offender_key := l.offense.offender_key;
   self.offense.off_date := l.offense.off_date;
   self.offense.arr_date := l.offense.arr_date;
   self.offense.arr_disp_date := l.offense.arr_disp_date;
   self.offense.court_disp_date := l.offense.court_disp_date;
   self.offense.sent_date := l.offense.sent_date;
   self.offense.appeal_date := l.offense.appeal_date;
   self.offense.court_off_lev := l.offense.court_off_lev;
   self.offense.court_off_code := l.offense.court_off_code;
   self.offense.court_statute := l.offense.court_statute;
   self.offense.court_statute_desc := l.offense.court_statute_desc;
   self.offense.court_off_desc_1 := l.offense.court_off_desc_1;
   self.offense.court_disp_desc_1 := l.offense.court_disp_desc_1;
   self.offense.court_disp_desc_2 := l.offense.court_disp_desc_2;
   self.offense.off_typ := l.offense.off_typ;
   self.offense.off_lev := l.offense.off_lev;
 
 self.offense_date.earliest_offense_date := l.earliest_offense_date;
  self.offense_date.__internal_fpos__ := l.__internal_fpos__;
 end;
//transform for header

// export header1 := record
	// string s_did;
	// string did;
  // end;

// export header2 := record 
// string rid;
// end;

// export header3 := record
  // string pflag1;
  // string pflag2;
  // string pflag3;
  // string src;
  // string dt_first_seen;
// end;

// export dates2 := record
		// string dt_vendor_first_reported;
// end;


// export header4 := record
  
	// string dt_nonglb_last_seen;
  // string rec_type;
  // string vendor_id;
  // string phone;
  // string ssn;
  // string dob;
  // string title;
  // string fname;
  // string mname;
  // string lname;
  // string name_suffix;
  // string prim_range;
  // string predir;
  // string prim_name;
  // string suffix;
  // string postdir;
  // string unit_desig;
  // string sec_range;
  // string city_name;
  // string st;
  // string zip;
  // string zip4;
  // string county;
  // string geo_blk;
  // string cbsa;
  // string tnt;
  // string valid_ssn;
  // string jflag1;
  // string jflag2;
  // string jflag3;
  // string rawaid;
  // string persistent_record_id;
	// string valid_dob	;

// end;

// export hid := record
  // string hhid;
// end;

// export header5 := record
  // string county_name	;
  // string listed_name	;
  // string listed_phone	;
  // string dod;
  // string death_code;
  // string lookup_did;
// end;

// export dates := record
  // string dt_last_seen;
  // string dt_vendor_last_reported;
// end;
// export HeaderRecsLayout2 := record
	// header1 header1;
	// header2 header2;
	// header3 header3;
	// dates  dates;
	// dates2  dates2;
  // header4 header4;
	// hid			hid;
  // header5 header5;
	// end;
	 
// export HeaderRecsLayout2  newheader (recordof(layout_Soap_output.header_records_by_did) l) := transform
// export HeaderRecsLayout2  newheader (HeaderRecsLayout l) := transform
// self.header1.s_did := l.s_did;
// self.header1.did := l.did;
// self.header2.rid := l.rid;
  // self.header3.pflag1 := l.pflag1;
  // self.header3.pflag2 := l.pflag2;
  // self.header3.pflag3 := l.pflag3;
  // self.header3.src := l.src;
  // self.header3.dt_first_seen := l.dt_first_seen;
	// self.dates.dt_last_seen := l.dt_last_seen;
	// self.dates.dt_vendor_last_reported := l.dt_vendor_last_reported;
  // self.dates2.dt_vendor_first_reported := l.dt_vendor_first_reported;
	// self.header4.dt_nonglb_last_seen := l.dt_nonglb_last_seen;
  // self.header4.rec_type := l.rec_type;
  // self.header4.vendor_id := l.vendor_id;
  // self.header4.phone := l.phone;
  // self.header4.ssn := l.ssn;
  // self.header4.dob := l.dob;
  // self.header4.title := l.title;
  // self.header4.fname := l.fname;
  // self.header4.mname := l.mname;
  // self.header4.lname := l.lname;
   // self.header4.name_suffix := l.name_suffix;
   // self.header4.prim_range := l.prim_range;
   // self.header4.predir := l.predir;
   // self.header4.prim_name := l.prim_name;
   // self.header4.suffix := l.suffix;
   // self.header4.postdir := l.postdir;
   // self.header4.unit_desig := l.unit_desig;
   // self.header4.sec_range := l.sec_range;
   // self.header4.city_name := l.city_name;
   // self.header4.st := l.st;
   // self.header4.zip := l.zip;
   // self.header4.zip4 := l.zip4;
   // self.header4.county := l.county;
   // self.header4.geo_blk := l.geo_blk;
   // self.header4.cbsa := l.cbsa;
   // self.header4.tnt := l.tnt;
   // self.header4.valid_ssn := l.valid_ssn;
   // self.header4.jflag1 := l.jflag1;
   // self.header4.jflag2 := l.jflag2;
   // self.header4.jflag3 := l.jflag3;
   // self.header4.rawaid := l.rawaid;
   // self.header4.persistent_record_id := l.persistent_record_id;
	 // self.header4.valid_dob	 := l.valid_dob;
   // self.hid.hhid := l.hhid;
   // self.header5.county_name	 := l.county_name;
   // self.header5.listed_name	 := l.listed_name;
   // self.header5.listed_phone	 := l.listed_phone;
   // self.header5.dod := l.dod;
   // self.header5.death_code := l.death_code;
   // self.header5.lookup_did := l.lookup_did;
	// end;
	

	
	
end;