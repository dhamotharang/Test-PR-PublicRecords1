IMPORT ut, BIPV2, BIPV2_Company_Names, AID, _Control, Suppress;

EXPORT Layouts := MODULE

	Export Rec_Dot_change:=RECORD
					unsigned6 rcid;
					unsigned6 dotid_before;
					unsigned6 dotid_after;
					unsigned6 proxid_before;
					unsigned6 proxid_after;
					unsigned6 lgid3_before;
					unsigned6 lgid3_after;
					unsigned6 orgid_before;
					unsigned6 orgid_after;
					unsigned6 ultid_before;
					unsigned6 ultid_after;
					unsigned4 change_date;
				 END;
 
 
Export Source_Rec:=Record
  unsigned6 rcid;  
	string2 source;
  unsigned6 dotid;  
	unsigned6 proxid;
  unsigned6 seleid;  
	unsigned6 lgid3;
  boolean is_sele_level;  
	unsigned6 parent_proxid;
  unsigned6 sele_proxid;  
	unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;  
	unsigned3 nodes_below;
  unsigned3 nodes_total;  
	string1 iscontact;
  string5 title;  
	string20 fname;
  string20 mname;  
	string20 lname;
  string5 name_suffix;  
	string120 company_name;
  string50 company_name_type_derived;
  string250 cnp_name;  
	string30 cnp_number;
  string10 cnp_btype;  
	string10 prim_range;
  string10 prim_range_derived;  
	string28 prim_name;
  string28 prim_name_derived;  
	string8 sec_range;
  string25 v_city_name;  
	string2 st;
  string5 zip;  
	string9 active_duns_number;
  string9 hist_duns_number;  
	string9 deleted_key;
  string9 deleted_fein;  
	string9 active_enterprise_number;
  string9 hist_enterprise_number;  
	string9 ebr_file_number;
  string30 active_domestic_corp_key;  
	string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  string9 company_fein;
  string10 company_phone;
  string2 company_inc_state;
  string32 company_charter_number;
  string34 vl_id;
  string9 contact_ssn;
 END;
 
 Export Dot_Link_Rec:=RECORD
  unsigned6 rcid;
  unsigned6 dotid;
  unsigned6 proxid;
  string1 iscontact; 
  string5 title; 
  string20 fname; 
  string20 mname; 
  string20 lname; 
  string5 name_suffix; 
  string120 company_name; 
  string250 cnp_name;   
  string30 cnp_number; 
  string10 cnp_btype; 
  string10 prim_range; 
  string28 prim_name; 
  string8 sec_range; 
  string25 v_city_name; 
  string2 st; 
  string5 zip; 
  string250 corp_legal_name; 
  string9 active_duns_number; 
  string9 active_enterprise_number; 
  string30 active_domestic_corp_key; 
  unsigned4 dt_first_seen; 
  unsigned4 dt_last_seen;  
  string9 company_fein; 
  string2 company_inc_state; 
  string32 company_charter_number; 
  string9 contact_ssn; 
 END;
 
 Dot_match_sample_debug_rec:=RECORD //key::bipv2_dotid::dotid::debug::match_sample_debug 
  integer2 conf;										//or directly use BIPV2_DotID.Keys(BIPV2_DOTID.In_DOT).MatchSample
  unsigned6 dotid1;
  unsigned6 dotid2;
  unsigned2 rule;
  integer2 dateoverlap;
  integer2 conf_prop;
  unsigned6 rcid1;
  unsigned6 rcid2;
  integer2 attribute_conf;
  string matching_attributes;
  string30 left_cnp_number;
  integer1 cnp_number_match_code;
  integer2 cnp_number_score;
  boolean cnp_number_skipped;
  string30 right_cnp_number;
  string10 left_prim_range;
  integer1 prim_range_match_code;
  integer2 prim_range_score;
  boolean prim_range_skipped;
  string10 right_prim_range;
  string28 left_prim_name;
  integer1 prim_name_match_code;
  integer2 prim_name_score;
  boolean prim_name_skipped;
  string28 right_prim_name;
  string2 left_st;
  integer1 st_match_code;
  integer2 st_score;
  boolean st_skipped;
  string2 right_st;
  string1 left_iscontact;
  integer1 iscontact_match_code;
  integer2 iscontact_score;
  boolean iscontact_skipped;
  string1 right_iscontact;
  string9 left_contact_ssn;
  integer1 contact_ssn_match_code;
  integer2 contact_ssn_score;
  string9 right_contact_ssn;
  string9 left_company_fein;
  integer1 company_fein_match_code;
  integer2 company_fein_score;
  boolean company_fein_skipped;
  string9 right_company_fein;
  string9 left_active_enterprise_number;
  integer1 active_enterprise_number_match_code;
  integer2 active_enterprise_number_score;
  boolean active_enterprise_number_skipped;
  string9 right_active_enterprise_number;
  string30 left_active_domestic_corp_key;
  integer1 active_domestic_corp_key_match_code;
  integer2 active_domestic_corp_key_score;
  boolean active_domestic_corp_key_skipped;
  string30 right_active_domestic_corp_key;
  string250 left_cnp_name;
  integer1 cnp_name_match_code;
  integer2 cnp_name_score;
  boolean cnp_name_skipped;
  string250 right_cnp_name;
  string500 left_corp_legal_name;
  integer1 corp_legal_name_match_code;
  integer2 corp_legal_name_score;
  boolean corp_legal_name_skipped;
  string500 right_corp_legal_name;
  unsigned4 left_address;
  integer1 address_match_code;
  integer2 address_score;
  boolean address_skipped;
  unsigned4 right_address;
  string9 left_active_duns_number;
  integer1 active_duns_number_match_code;
  integer2 active_duns_number_score;
  string9 right_active_duns_number;
  unsigned4 left_addr1;
  integer1 addr1_match_code;
  integer2 addr1_score;
  unsigned4 right_addr1;
  string5 left_zip;
  integer1 zip_match_code;
  integer2 zip_score;
  string5 right_zip;
  unsigned4 left_csz;
  integer1 csz_match_code;
  integer2 csz_score;
  boolean csz_skipped;
  unsigned4 right_csz;
  string8 left_sec_range;
  integer1 sec_range_match_code;
  integer2 sec_range_score;
  boolean sec_range_skipped;
  string8 right_sec_range;
  string25 left_v_city_name;
  integer1 v_city_name_match_code;
  integer2 v_city_name_score;
  string25 right_v_city_name;
  string20 left_lname;
  integer1 lname_match_code;
  integer2 lname_score;
  boolean lname_skipped;
  string20 right_lname;
  string20 left_mname;
  integer1 mname_match_code;
  integer2 mname_score;
  boolean mname_skipped;
  string20 right_mname;
  string20 left_fname;
  integer1 fname_match_code;
  integer2 fname_score;
  boolean fname_skipped;
  string20 right_fname;
  string5 left_name_suffix;
  integer1 name_suffix_match_code;
  integer2 name_suffix_score;
  boolean name_suffix_skipped;
  string5 right_name_suffix;
  string10 left_cnp_btype;
  integer1 cnp_btype_match_code;
  integer2 cnp_btype_score;
  string10 right_cnp_btype;
  string20 left_cnp_lowv;
  string20 right_cnp_lowv;
  boolean left_cnp_translated;
  boolean right_cnp_translated;
  integer4 left_cnp_classid;
  integer4 right_cnp_classid;
  unsigned6 left_company_bdid;
  unsigned6 right_company_bdid;
  string10 left_company_phone;
  string10 right_company_phone;
  string120 left_company_name;
  string120 right_company_name;
  string5 left_title;
  string5 right_title;
  string10 left_contact_phone;
  string10 right_contact_phone;
  string60 left_contact_email;
  string60 right_contact_email;
  string50 left_contact_job_title_raw;
  string50 right_contact_job_title_raw;
  string35 left_company_department;
  string35 right_company_department;
  unsigned4 left_dt_first_seen;
  unsigned4 right_dt_first_seen;
  unsigned4 left_dt_last_seen;
  unsigned4 right_dt_last_seen;
 END;

export LGID3_LK_Det_Rec :=
  record
    integer2 conf;
    integer2 dateoverlap;
    integer2 conf_prop;
    unsigned6 rcid1;
    unsigned6 rcid2;
		unsigned6 proxid1;
		unsigned6 proxid2;
    string34 left_sbfe_id;
    integer2 sbfe_id_score;
    string34 right_sbfe_id;
    string9 left_active_duns_number;
    integer2 active_duns_number_score;
    string9 right_active_duns_number;
    string500 left_company_name;       //------
    integer2 company_name_score;
    string500 right_company_name;	//------
    string9 left_duns_number;
    integer2 duns_number_score;
    string9 right_duns_number;
    unsigned4 left_duns_number_concept;
    integer2 duns_number_concept_score;
    unsigned4 right_duns_number_concept;
    string9 left_company_fein;
    integer2 company_fein_score;
    string9 right_company_fein;
    string32 left_company_charter_number;
    integer2 company_charter_number_score;
    string32 right_company_charter_number;
    string30 left_cnp_number;
    integer2 cnp_number_score;
    boolean cnp_number_skipped;
    string30 right_cnp_number;
    string2 left_company_inc_state;
    integer2 company_inc_state_score;
    string2 right_company_inc_state;
    string10 left_cnp_btype;
    integer2 cnp_btype_score;
    string10 right_cnp_btype;
    string10 left_nodes_below_st;
    string10 right_nodes_below_st;
    
    string9 left_hist_duns_number;
    string9 right_hist_duns_number;
    string30 left_active_domestic_corp_key;
    string30 right_active_domestic_corp_key;
    string30 left_hist_domestic_corp_key;
    string30 right_hist_domestic_corp_key;
    string30 left_foreign_corp_key;
    string30 right_foreign_corp_key;
    string30 left_unk_corp_key;
    string30 right_unk_corp_key;
    string250 left_cnp_name;
    string250 right_cnp_name;
    string1 left_cnp_hasnumber;
    string1 right_cnp_hasnumber;
    
    string10 left_prim_range;
    string10 right_prim_range;
    string28 left_prim_name;
    string28 right_prim_name;
    string8 left_sec_range;
    string8 right_sec_range;
    string25 left_v_city_name;
    string25 right_v_city_name;
    string2 left_st;
    string2 right_st;
    string5 left_zip;
    string5 right_zip;
    
    unsigned3 left_nodes_total;
    unsigned3 right_nodes_total;

  end;

END;