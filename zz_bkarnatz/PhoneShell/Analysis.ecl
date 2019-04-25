﻿EXPORT Analysis := 'todo';




// #workunit('name','PhoneShell 10 Toggle Analysis');
// #workunit('name','PhoneShell 41 Analysis 1 vs 2');
#workunit('name','PhoneShell toggle 1 Analysis 2 vs 3');

import ashirey, scoring_project_pip;

eyeball := 10;

layout_phone_shell_input_echo := RECORD
   unsigned4 seq;
   unsigned6 lexid;
   string50 acctno;
   string20 in_fname;
   string20 in_mname;
   string20 in_lname;
   string5 in_sname;
   string120 in_streetaddress;
   string25 in_city;
   string2 in_state;
   string9 in_zipcode;
   string8 in_dob;
   string9 in_ssn;
   string10 in_phone10;
   string10 in_wphone10;
   boolean in_expgw_enabled;
   boolean in_targusgw_enabled;
   boolean in_tugw_enabled;
   boolean in_insgw_enabled;
   string8 in_processing_date;
   boolean in_burea_enabled;
  END;

layout_subject_level := RECORD
   integer1 subject_ssn_mismatch;
   unsigned1 experian_num_duplicate;
   unsigned1 experian_num_insufficient_score;
  END;

layout_sources := RECORD
   string200 source_list;
   string200 source_owner_did;
   string200 source_owner_name_prefix;
   string200 source_owner_name_first;
   string200 source_owner_name_middle;
   string200 source_owner_name_last;
   string200 source_owner_name_suffix;
   string200 source_list_last_seen;
   string200 source_list_first_seen;
  END;

layout_raw_phone_characteristics := RECORD
   unsigned1 phone_subject_level;
   string1 phone_switch_type;
   unsigned1 phone_high_risk;
   boolean phone_debt_settlement;
   boolean phone_disconnected;
   unsigned1 phone_zip_match;
   unsigned1 phone_timezone_match;
   string4 phone_timezone;
   string4 address_zipcode_timezone;
   string30 phone_match_code;
   unsigned2 phone_business_count;
   string35 phone_subject_title;
  END;

layout_phonesplus_characteristics := RECORD
   string1 phonesplus_type;
   string10 phonesplus_source;
   string20 phonesplus_carrier;
   string25 phonesplus_city;
   string2 phonesplus_state;
   string1 phonesplus_rp_type;
   string10 phonesplus_rp_source;
   string20 phonesplus_rp_carrier;
   string25 phonesplus_rp_city;
   string2 phonesplus_rp_state;
   unsigned1 phonesplus_confidence;
   string64 phonesplus_rules;
   unsigned8 phonesplus_did;
   unsigned1 phonesplus_did_score;
   string50 phonesplus_listing_name;
   string8 phonesplus_datefirstseen;
   string8 phonesplus_datelastseen;
   string8 phonesplus_datevendorfirstseen;
   string8 phonesplus_datevendorlastseen;
   string8 phonesplus_date_nonglb_lastseen;
   string1 phonesplus_glb_dppa_flag;
   string50 phonesplus_glb_dppa_all;
   string2 phonesplus_src;
   string64 phonesplus_src_all;
   unsigned1 phonesplus_src_cnt;
   string64 phonesplus_src_rule;
   decimal4_2 phonesplus_avg_source_conf;
   unsigned1 phonesplus_max_source_conf;
   unsigned1 phonesplus_min_source_conf;
   unsigned2 phonesplus_total_source_conf;
   string8 phonesplus_orig_lastseen;
   string10 phonesplus_did_type;
   string20 phonesplus_origname;
   string120 phonesplus_address1;
   string120 phonesplus_address2;
   string120 phonesplus_address3;
   string25 phonesplus_origcity;
   string2 phonesplus_origstate;
   string9 phonesplus_origzip;
   string10 phonesplus_origphone;
   string8 phonesplus_dob;
   string3 phonesplus_agegroup;
   string1 phonesplus_gender;
   string50 phonesplus_email;
   string25 phonesplus_origlistingtype;
   string25 phonesplus_listingtype;
   string1 phonesplus_origpublishcode;
   string1 phonesplus_origphonetype;
   string1 phonesplus_origphoneusage;
   string100 phonesplus_company;
   string8 phonesplus_origphoneregdate;
   string20 phonesplus_origcarriercode;
   string20 phonesplus_origcarriername;
   unsigned1 phonesplus_origconfscore;
   unsigned1 phonesplus_origrectype;
   unsigned8 phonesplus_bdid;
   unsigned2 phonesplus_bdid_score;
   string8 phonesplus_append_npa_effective_dt;
   string8 phonesplus_append_npa_last_change_dt;
   unsigned1 phonesplus_append_dialable_ind;
   string50 phonesplus_append_place_name;
   unsigned1 phonesplus_append_portability_indicator;
   string100 phonesplus_append_prior_area_code;
   string64 phonesplus_append_nonpublished_match;
   string20 phonesplus_append_ocn;
   string1 phonesplus_append_time_zone;
   string3 phonesplus_append_nxx_type;
   string5 phonesplus_append_coctype;
   string1 phonesplus_append_scc;
   string30 phonesplus_append_phone_type;
   unsigned1 phonesplus_append_company_type;
   string1 phonesplus_append_phone_use;
   string500 phonesplus_agreg_listing_type;
   unsigned1 phonesplus_max_orig_conf_score;
   unsigned1 phonesplus_min_orig_conf_score;
   unsigned1 phonesplus_curr_orig_conf_score;
   string64 phonesplus_eda_match;
   string8 phonesplus_eda_phone_dt;
   string8 phonesplus_eda_did_dt;
   string8 phonesplus_eda_nm_addr_dt;
   string64 phonesplus_eda_hist_match;
   string8 phonesplus_eda_hist_phone_dt;
   string8 phonesplus_eda_hist_did_dt;
   string8 phonesplus_eda_hist_nm_addr_dt;
   unsigned1 phonesplus_append_feedback_phone;
   string8 phonesplus_append_feedback_phone_dt;
   unsigned1 phonesplus_append_feedback_phone7_did;
   string8 phonesplus_append_feedback_phone7_did_dt;
   unsigned1 phonesplus_append_feedback_phone7_nm_addr;
   string8 phonesplus_append_feedback_phone7_nm_addr_dt;
   string64 phonesplus_append_ported_match;
   boolean phonesplus_append_seen_once_ind;
   unsigned2 phonesplus_append_indiv_phone_cnt;
   boolean phonesplus_append_indiv_has_active_eda_phone_flag;
   boolean phonesplus_append_latest_phone_owner_flag;
   unsigned8 phonesplus_hhid;
   unsigned2 phonesplus_hhid_score;
   boolean phonesplus_append_best_addr_match_flag;
   boolean phonesplus_append_best_nm_match_flag;
   unsigned8 phonesplus_rawaid;
   unsigned8 phonesplus_cleanaid;
   boolean phonesplus_current_rec;
   string8 phonesplus_first_build_date;
   string8 phonesplus_last_build_date;
  END;

layout_phone_feedback := RECORD
   string8 phone_feedback_date;
   unsigned1 phone_feedback_result;
   string20 phone_feedback_first;
   string20 phone_feedback_middle;
   string20 phone_feedback_last;
   string8 phone_feedback_last_rpc_date;
   string8 phone_feedback_rp_date;
   unsigned1 phone_feedback_rp_result;
   string20 phone_feedback_rp_first;
   string20 phone_feedback_rp_middle;
   string20 phone_feedback_rp_last;
   string8 phone_feedback_rp_last_rpc_date;
  END;

layout_inquiries := RECORD
   string8 inq_num;
   string8 inq_num_06;
   string8 inq_num_addresses;
   string8 inq_num_addresses_06;
   string8 inq_num_adls;
   string8 inq_num_adls_06;
   string8 inq_firstseen;
   string8 inq_lastseen;
   string8 inq_adl_firstseen;
   string8 inq_adl_lastseen;
   string200 inq_adl_phone_industry_list_12;
  END;

layout_internal_corroboration := RECORD
   boolean internal_verification;
   string8 internal_verification_first_seen;
   string8 internal_verification_last_seen;
   string15 internal_verification_match_types;
  END;

layout_experian_file_one_verification := RECORD
   boolean experian_verified;
   string1 experian_type;
   string1 experian_source;
   string8 experian_last_update;
   string3 experian_phone_score_v1;
  END;

layout_eda_characteristics := RECORD
   string1 eda_omit_locality;
   unsigned8 eda_did;
   unsigned8 eda_hhid;
   unsigned8 eda_bdid;
   string100 eda_listing_name;
   unsigned3 eda_did_count;
   string8 eda_dt_first_seen;
   string8 eda_dt_last_seen;
   boolean eda_current_record_flag;
   string8 eda_deletion_date;
   unsigned2 eda_disc_cnt6;
   unsigned2 eda_disc_cnt12;
   unsigned2 eda_disc_cnt18;
   string2 eda_pfrd_address_ind;
   unsigned4 eda_days_in_service;
   unsigned2 eda_num_phone_owners_hist;
   unsigned2 eda_num_phone_owners_cur;
   unsigned2 eda_num_phones_indiv;
   unsigned2 eda_num_phones_connected_indiv;
   unsigned2 eda_num_phones_discon_indiv;
   unsigned4 eda_avg_days_connected_indiv;
   unsigned4 eda_min_days_connected_indiv;
   unsigned4 eda_max_days_connected_indiv;
   unsigned4 eda_days_indiv_first_seen;
   unsigned4 eda_days_indiv_first_seen_with_phone;
   unsigned4 eda_days_phone_first_seen;
   boolean eda_address_match_best;
   unsigned3 eda_months_addr_last_seen;
   unsigned4 eda_num_phones_connected_addr;
   unsigned4 eda_num_phones_discon_addr;
   unsigned4 eda_num_phones_connected_hhid;
   unsigned4 eda_num_phones_discon_hhid;
   boolean eda_is_discon_15_days;
   boolean eda_is_discon_30_days;
   boolean eda_is_discon_60_days;
   boolean eda_is_discon_90_days;
   boolean eda_is_discon_180_days;
   boolean eda_is_discon_360_days;
   boolean eda_is_current_in_hist;
   unsigned2 eda_num_interrupts_cur;
   unsigned4 eda_avg_days_interrupt;
   unsigned4 eda_min_days_interrupt;
   unsigned4 eda_max_days_interrupt;
   boolean eda_has_cur_discon_15_days;
   boolean eda_has_cur_discon_30_days;
   boolean eda_has_cur_discon_60_days;
   boolean eda_has_cur_discon_90_days;
   boolean eda_has_cur_discon_180_days;
   boolean eda_has_cur_discon_360_days;
  END;

layout_royalties := RECORD
   unsigned1 metronet_royalty;
   unsigned1 targuscomprehensive_royalty;
   unsigned1 qsentcis_royalty;
   unsigned1 lastresortphones_royalty;
   unsigned1 efxdatamart_royalty;
  END;

layout_bureau := RECORD
   boolean bureau_verified;
   string8 bureau_last_update;
  END;

layout_phone_shell_plus := RECORD
  unsigned8 unique_record_sequence;
  unsigned8 did;
  layout_phone_shell_input_echo input_echo;
  layout_subject_level subject_level;
  string10 gathered_phone;
  string3 phone_model_score;
  layout_sources sources;
  layout_raw_phone_characteristics raw_phone_characteristics;
  layout_phonesplus_characteristics phonesplus_characteristics;
  layout_phone_feedback phone_feedback;
  layout_inquiries inquiries;
  layout_internal_corroboration internal_corroboration;
  layout_experian_file_one_verification experian_file_one_verification;
  layout_eda_characteristics eda_characteristics;
  layout_royalties royalties;
  layout_bureau bureau;
 END;

layout_input := RECORD
   unsigned4 seq;
   unsigned6 did;
   unsigned2 score;
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 suffix;
   string120 in_streetaddress;
   string25 in_city;
   string2 in_state;
   string5 in_zipcode;
   string25 in_country;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string2 st;
   string5 z5;
   string4 zip4;
   string10 lat;
   string11 long;
   string3 county;
   string7 geo_blk;
   string1 addr_type;
   string4 addr_status;
   string25 country;
   string9 ssn;
   string8 dob;
   string3 age;
   string20 dl_number;
   string2 dl_state;
   string50 email_address;
   string45 ip_address;
   string10 phone10;
   string10 wphone10;
   string100 employer_name;
   string20 lname_prev;
  END;

layout_addr_flags := RECORD
    string1 dwelltype;
    string1 valid;
    string1 prisonaddr;
    string1 highrisk;
    string1 corpmil;
    string1 donotdeliver;
    string1 deliverystatus;
    string1 addresstype;
    string1 dropindicator;
   END;

layout_instantid_results := RECORD
   integer1 nas_summary;
   integer1 nap_summary;
   string1 nap_type;
   string1 nap_status;
   integer1 cvi;
   string2 reason1;
   string2 reason2;
   string2 reason3;
   string2 reason4;
   string2 reason5;
   string2 reason6;
   unsigned1 didcount;
   unsigned6 did2;
   unsigned6 did3;
   string50 did2_sources;
   string50 did2_fnamesources;
   string50 did2_lnamesources;
   string50 did2_addrsources;
   string50 did2_socssources;
   unsigned3 did2_creditfirstseen;
   unsigned3 did2_creditlastseen;
   unsigned3 did2_headerfirstseen;
   unsigned3 did2_headerlastseen;
   unsigned1 did2_criminal_count;
   unsigned1 did2_felony_count;
   unsigned1 did2_liens_recent_unreleased_count;
   unsigned1 did2_liens_historical_unreleased_count;
   unsigned1 did2_liens_recent_released_count;
   unsigned1 did2_liens_historical_released_count;
   string50 did3_sources;
   string50 did3_fnamesources;
   string50 did3_lnamesources;
   string50 did3_addrsources;
   string50 did3_socssources;
   unsigned3 did3_creditfirstseen;
   unsigned3 did3_creditlastseen;
   unsigned3 did3_headerfirstseen;
   unsigned3 did3_headerlastseen;
   unsigned1 did3_criminal_count;
   unsigned1 did3_felony_count;
   unsigned1 did3_liens_recent_unreleased_count;
   unsigned1 did3_liens_historical_unreleased_count;
   unsigned1 did3_liens_recent_released_count;
   unsigned1 did3_liens_historical_released_count;
   boolean non_us_ssn;
   string1 hriskphoneflag;
   string1 hphonetypeflag;
   string1 wphonetypeflag;
   string1 phonevalflag;
   string1 hphonevalflag;
   string1 wphonevalflag;
   string1 phonezipflag;
   string1 pwphonezipflag;
   boolean phonedissflag;
   boolean wphonedissflag;
   unsigned1 phoneverlevel;
   string1 phonever_type;
   string1 hriskaddrflag;
   string1 pullidflag;
   string1 decsflag;
   string1 socsdobflag;
   string1 pwsocsdobflag;
   string1 socsvalflag;
   string1 pwsocsvalflag;
   string1 socsrcisflag;
   string8 socllowissue;
   string8 soclhighissue;
   string2 soclstate;
   unsigned1 socsverlevel;
   string1 areacodesplitflag;
   string8 areacodesplitdate;
   string3 altareacode;
   string1 reverse_areacodesplitflag;
   string1 addrvalflag;
   string1 dwelltype;
   string1 bansflag;
   string50 sources;
   unsigned2 firstcount;
   unsigned2 lastcount;
   unsigned2 addrcount;
   unsigned2 wphonecount;
   unsigned2 socscount;
   unsigned2 numelever;
   unsigned2 phonefirstcount;
   unsigned2 phonelastcount;
   unsigned2 phoneaddrcount;
   unsigned2 phonephonecount;
   unsigned2 phoneaddr_firstcount;
   unsigned2 phoneaddr_lastcount;
   unsigned2 phoneaddr_addrcount;
   unsigned2 phoneaddr_phonecount;
   unsigned2 utiliaddr_lastcount;
   unsigned2 utiliaddr_addrcount;
   unsigned2 utiliaddr_phonecount;
   string15 verfirst;
   string20 verlast;
   boolean socsmiskeyflag;
   boolean hphonemiskeyflag;
   boolean addrmiskeyflag;
   string1 addrcommflag;
   string6 hrisksic;
   string6 hrisksicphone;
   string30 hriskcmpy;
   string30 hriskcmpyphone;
   unsigned3 disthphoneaddr;
   unsigned3 disthphonewphone;
   unsigned3 distwphoneaddr;
   string8 correctdob;
   string9 correctssn;
   string10 correcthphone;
   string20 correctlast;
   string15 dirsfirst;
   string20 dirslast;
   string10 dirs_prim_range;
   string2 dirs_predir;
   string28 dirs_prim_name;
   string4 dirs_suffix;
   string2 dirs_postdir;
   string10 dirs_unit_desig;
   string8 dirs_sec_range;
   string30 dirscity;
   string2 dirsstate;
   string9 dirszip;
   string50 dirscmpy;
   string10 dirsaddr_phone;
   unsigned1 dirsaddr_lastscore;
   string10 utiliphone;
   string1 phonetype;
   string1 ziptypeflag;
   string1 zipclass;
   string2 drlcvalflag;
   string1 drlcsoundx;
   string1 drlcfirst;
   string1 drlclast;
   string1 drlcmiddle;
   string1 drlcsocs;
   string1 drlcdob;
   string1 drlcgender;
   string1 statezipflag;
   string1 cityzipflag;
   string10 chronoprim_range;
   string2 chronopredir;
   string28 chronoprim_name;
   string4 chronosuffix;
   string2 chronopostdir;
   string10 chronounit_desig;
   string8 chronosec_range;
   string30 chronocity;
   string2 chronostate;
   string9 chronozip;
   string10 chronophone;
   unsigned5 chronoactivephone;
   unsigned1 chronomatchlevel;
   string50 chrono_sources;
   layout_addr_flags chrono_addr_flags;
   string10 chronoprim_range2;
   string2 chronopredir2;
   string28 chronoprim_name2;
   string4 chronosuffix2;
   string2 chronopostdir2;
   string10 chronounit_desig2;
   string8 chronosec_range2;
   string30 chronocity2;
   string2 chronostate2;
   string9 chronozip2;
   string10 chronophone2;
   unsigned5 chronoactivephone2;
   unsigned1 chronomatchlevel2;
   string50 chrono_sources2;
   layout_addr_flags chrono_addr_flags2;
   string10 chronoprim_range3;
   string2 chronopredir3;
   string28 chronoprim_name3;
   string4 chronosuffix3;
   string2 chronopostdir3;
   string10 chronounit_desig3;
   string8 chronosec_range3;
   string30 chronocity3;
   string2 chronostate3;
   string9 chronozip3;
   string10 chronophone3;
   unsigned5 chronoactivephone3;
   unsigned1 chronomatchlevel3;
   string50 chrono_sources3;
   layout_addr_flags chrono_addr_flags3;
   unsigned3 chronodate_first;
   unsigned3 chronodate_first2;
   unsigned3 chronodate_first3;
   string20 altlast;
   string20 altlast2;
   boolean altlastpop;
   boolean altlast2pop;
   boolean lastssnmatch;
   boolean lastssnmatch2;
   boolean firstssnmatch;
   boolean ssnexists;
   string15 combo_first;
   string20 combo_last;
   string10 combo_prim_range;
   string2 combo_predir;
   string28 combo_prim_name;
   string4 combo_suffix;
   string2 combo_postdir;
   string10 combo_unit_desig;
   string8 combo_sec_range;
   string30 combo_city;
   string2 combo_state;
   string9 combo_zip;
   string10 combo_hphone;
   string9 combo_ssn;
   string8 combo_dob;
   string50 combo_cmpy;
   unsigned1 combo_firstscore;
   unsigned1 combo_lastscore;
   unsigned1 combo_addrscore;
   unsigned1 combo_sec_rangescore;
   unsigned1 combo_hphonescore;
   unsigned1 combo_ssnscore;
   unsigned1 combo_dobscore;
   unsigned1 combo_cmpyscore;
   unsigned1 combo_firstcount;
   unsigned1 combo_lastcount;
   unsigned1 combo_addrcount;
   unsigned1 combo_hphonecount;
   unsigned1 combo_ssncount;
   unsigned1 combo_dobcount;
   unsigned1 combo_cmpycount;
   string60 watchlist_table;
   string10 watchlist_record_number;
   string20 watchlist_fname;
   string20 watchlist_lname;
   string50 watchlist_address;
   string30 watchlist_city;
   string2 watchlist_state;
   string9 watchlist_zip;
   boolean watchlisthit;
   string50 watchlist_entity_name;
   string30 wphonename;
   string50 wphoneaddr;
   string30 wphonecity;
   string2 wphonestate;
   string9 wphonezip;
   string10 name_addr_phone;
   boolean inputaddrnotmostrecent;
   string1 publish_code;
   string9 bestssn;
   unsigned8 iid_flags;
   boolean dl_searched;
   boolean any_dl_found;
   boolean dl_exists;
   unsigned1 dl_score;
   string20 verified_dl;
   string50 verified_dl_sources;
   boolean isshiptobilltodifferent;
   boolean everassocitin;
   boolean everassocim;
   boolean diddeceased;
   unsigned4 diddeceaseddate;
   unsigned4 diddeceaseddob;
   string15 diddeceasedfirst;
   string20 diddeceasedlast;
   boolean targusgatewayused;
   string2 targustype;
   integer8 swappednames;
  END;

layout_source_verification := RECORD
   unsigned2 eq_count;
   unsigned2 en_count;
   unsigned2 tu_count;
   unsigned2 dl_count;
   unsigned2 pr_count;
   unsigned2 v_count;
   unsigned2 em_count;
   unsigned2 vo_count;
   unsigned2 w_count;
   unsigned2 em_only_count;
   unsigned3 adl_eqfs_first_seen;
   unsigned3 adl_en_first_seen;
   unsigned3 adl_tu_first_seen;
   unsigned3 adl_dl_first_seen;
   unsigned3 adl_pr_first_seen;
   unsigned3 adl_v_first_seen;
   unsigned3 adl_em_first_seen;
   unsigned3 adl_vo_first_seen;
   unsigned3 adl_em_only_first_seen;
   unsigned3 adl_w_first_seen;
   unsigned3 adl_eqfs_last_seen;
   unsigned3 adl_en_last_seen;
   unsigned3 adl_tu_last_seen;
   unsigned3 adl_dl_last_seen;
   unsigned3 adl_pr_last_seen;
   unsigned3 adl_v_last_seen;
   unsigned3 adl_em_last_seen;
   unsigned3 adl_vo_last_seen;
   unsigned3 adl_em_only_last_seen;
   unsigned3 adl_w_last_seen;
   string50 firstnamesources;
   string50 lastnamesources;
   string50 addrsources;
   string50 socssources;
   string50 em_only_sources;
   unsigned1 num_nonderogs;
   unsigned1 num_nonderogs30;
   unsigned1 num_nonderogs90;
   unsigned1 num_nonderogs180;
   unsigned1 num_nonderogs12;
   unsigned1 num_nonderogs24;
   unsigned1 num_nonderogs36;
   unsigned1 num_nonderogs60;
  END;

layout_available_sources := RECORD
   boolean dl;
   boolean voter;
  END;

layout_input_validation := RECORD
   boolean firstname;
   boolean lastname;
   boolean address;
   boolean ssn;
   string1 ssn_length;
   integer1 ssnlookupflag;
   boolean dateofbirth;
   boolean email;
   boolean ipaddress;
   boolean homephone;
   boolean workphone;
  END;

layout_address_validation := RECORD
   boolean usps_deliverable;
   string10 dwelling_type;
   string10 zip_type;
   boolean hr_address;
   string100 hr_company;
   string4 error_codes;
   boolean corrections;
  END;

layout_name_verification := RECORD
   unsigned1 adl_score;
   unsigned1 fname_score;
   unsigned1 lname_score;
   unsigned3 lname_change_date;
   unsigned3 lname_prev_change_date;
   unsigned1 source_count;
   boolean fname_credit_sourced;
   boolean lname_credit_sourced;
   boolean fname_tu_sourced;
   boolean lname_tu_sourced;
   boolean fname_eda_sourced;
   string2 fname_eda_sourced_type;
   boolean lname_eda_sourced;
   string2 lname_eda_sourced_type;
   boolean fname_dl_sourced;
   boolean lname_dl_sourced;
   boolean fname_voter_sourced;
   boolean lname_voter_sourced;
   boolean fname_utility_sourced;
   boolean lname_utility_sourced;
   unsigned1 age;
   unsigned1 dob_score;
   string20 newest_lname;
   unsigned3 newest_lname_dt_first_seen;
  END;

layout_utility := RECORD
   qstring50 utili_adl_type;
   qstring150 utili_adl_dt_first_seen;
   unsigned1 utili_adl_count;
   string8 utili_adl_earliest_dt_first_seen;
   unsigned1 utili_adl_nap;
   qstring50 utili_addr1_type;
   qstring150 utili_addr1_dt_first_seen;
   unsigned1 utili_addr1_nap;
   qstring50 utili_addr2_type;
   qstring150 utili_addr2_dt_first_seen;
   unsigned1 utili_addr2_nap;
  END;

layout_address_informationv3 := RECORD
    unsigned3 address_score;
    boolean house_number_match;
    boolean isbestmatch;
    unsigned4 unit_count;
    decimal5_2 geo12_fc_index;
    decimal5_2 geo11_fc_index;
    decimal5_2 fips_fc_index;
    unsigned1 source_count;
    string50 sources;
    boolean credit_sourced;
    boolean eda_sourced;
    boolean dl_sourced;
    boolean voter_sourced;
    boolean utility_sourced;
    boolean applicant_owned;
    boolean occupant_owned;
    boolean family_owned;
    boolean family_sold;
    boolean applicant_sold;
    boolean family_sale_found;
    boolean family_buy_found;
    boolean applicant_sale_found;
    boolean applicant_buy_found;
    unsigned1 naprop;
    unsigned4 purchase_date;
    unsigned4 built_date;
    unsigned4 purchase_amount;
    unsigned4 mortgage_amount;
    unsigned4 mortgage_date;
    string5 mortgage_type;
    string4 type_financing;
    string8 first_td_due_date;
    unsigned4 assessed_amount;
    unsigned4 assessed_total_value;
    unsigned4 date_first_seen;
    unsigned4 date_last_seen;
    string4 standardized_land_use_code;
    unsigned8 building_area;
    unsigned8 no_of_buildings;
    unsigned8 no_of_stories;
    unsigned8 no_of_rooms;
    unsigned8 no_of_bedrooms;
    unsigned8 no_of_baths;
    unsigned8 no_of_partial_baths;
    string3 garage_type_code;
    unsigned8 parking_no_of_cars;
    string5 style_code;
    string4 assessed_value_year;
    boolean hr_address;
    string100 hr_company;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 city_name;
    string2 st;
    string5 zip5;
    string3 county;
    string7 geo_blk;
    string10 lat;
    string11 long;
    string5 census_age;
    string9 census_income;
    string9 census_home_value;
    string5 census_education;
    boolean full_match;
   END;

layout_property_value := RECORD
    unsigned2 property_total;
    unsigned5 property_owned_purchase_total;
    unsigned2 property_owned_purchase_count;
    unsigned5 property_owned_assessed_total;
    unsigned2 property_owned_assessed_count;
   END;

layout_business_property_value := RECORD
    integer8 property_total;
    integer8 property_owned_assessed_total;
    integer8 property_owned_assessed_count;
   END;

layout_recent_property_sales := RECORD
    unsigned8 sale_price1;
    unsigned8 sale_date1;
    unsigned8 prev_purch_price1;
    unsigned8 prev_purch_date1;
    unsigned8 sale_price2;
    unsigned8 sale_date2;
    unsigned8 prev_purch_price2;
    unsigned8 prev_purch_date2;
   END;

layout_address_verification := RECORD
   layout_address_informationv3 input_address_information;
   layout_property_value owned;
   layout_property_value sold;
   layout_property_value ambiguous;
   layout_business_property_value bus_owned;
   layout_business_property_value bus_sold;
   layout_recent_property_sales recent_property_sales;
   integer8 distance_in_2_h1;
   integer8 distance_in_2_h2;
   integer8 distance_h1_2_h2;
   unsigned1 addr1addr2score;
   unsigned1 addr1addr3score;
   unsigned1 addr2addr3score;
   string1 addr_type2;
   string1 addr_type3;
   unsigned1 edamatchlevel;
   unsigned5 activephone;
   unsigned1 edamatchlevel2;
   unsigned5 activephone2;
   unsigned1 edamatchlevel3;
   unsigned5 activephone3;
   layout_address_informationv3 address_history_1;
   layout_address_informationv3 address_history_2;
   layout_addr_flags addr_flags_1;
   layout_addr_flags addr_flags_2;
   boolean inputaddr_dirty;
   boolean inputaddr_not_verified;
   boolean inputaddr_owned_not_occupied;
   integer1 inputaddr_non_relative_did_count;
   integer1 inputaddr_occupancy_index;
   integer1 curraddr_occupancy_index;
   integer1 unverified_addr_count;
   integer8 bus_addr_only_curr;
   integer8 bus_addr_only;
  END;

layout_other_address_fields := RECORD
   unsigned2 max_lres;
   unsigned2 avg_lres;
   unsigned1 addrs_last_5years;
   unsigned1 addrs_last_10years;
   unsigned1 addrs_last_15years;
   boolean isprison;
   unsigned4 prisonfsdate;
   boolean hist1_isprison;
   boolean hist2_isprison;
   unsigned1 addrs_last30;
   unsigned1 addrs_last90;
   unsigned1 addrs_last12;
   unsigned1 addrs_last24;
   unsigned1 addrs_last36;
   unsigned4 date_first_purchase;
   unsigned4 date_most_recent_purchase;
   unsigned1 num_purchase30;
   unsigned1 num_purchase90;
   unsigned1 num_purchase180;
   unsigned1 num_purchase12;
   unsigned1 num_purchase24;
   unsigned1 num_purchase36;
   unsigned1 num_purchase60;
   unsigned4 date_first_sale;
   unsigned4 date_most_recent_sale;
   unsigned1 num_sold30;
   unsigned1 num_sold90;
   unsigned1 num_sold180;
   unsigned1 num_sold12;
   unsigned1 num_sold24;
   unsigned1 num_sold36;
   unsigned1 num_sold60;
   integer1 unverified_addr_count;
  END;

layout_gong_did := RECORD
    string8 gong_adl_dt_first_seen_full;
    string8 gong_adl_dt_last_seen_full;
    unsigned2 gong_did_phone_ct;
    unsigned2 gong_did_addr_ct;
    unsigned2 gong_did_first_ct;
    unsigned2 gong_did_last_ct;
   END;

layout_phone_verification := RECORD
   unsigned1 phone_score;
   string10 telcordia_type;
   boolean phone_zip_mismatch;
   integer8 distance;
   boolean disconnected;
   unsigned1 recent_disconnects;
   boolean hr_phone;
   boolean corrections;
   layout_gong_did gong_did;
   string50 phone_sources;
  END;

layout_ssn_validation := RECORD
    boolean deceased;
    unsigned4 deceaseddate;
    boolean valid;
    boolean issued;
    unsigned4 high_issue_date;
    unsigned4 low_issue_date;
    string2 issue_state;
    unsigned1 dob_mismatch;
    string1 inputsocscharflag;
    string3 inputsocscode;
   END;

layout_ssn_information := RECORD
   unsigned1 ssn_score;
   unsigned2 nameperssn_count;
   unsigned2 adlperssn_count;
   boolean credit_sourced;
   unsigned3 credit_first_seen;
   unsigned3 credit_last_seen;
   unsigned1 header_count;
   unsigned3 header_first_seen;
   unsigned3 header_last_seen;
   boolean tu_sourced;
   boolean voter_sourced;
   boolean utility_sourced;
   boolean bk_sourced;
   boolean other_sourced;
   layout_ssn_validation validation;
  END;

layout_velocity_information := RECORD
   unsigned1 ssns_per_adl;
   unsigned1 addrs_per_adl;
   unsigned1 phones_per_adl;
   unsigned1 dobs_per_adl;
   unsigned1 ssns_per_adl_created_6months;
   unsigned1 addrs_per_adl_created_6months;
   unsigned1 phones_per_adl_created_6months;
   unsigned1 dobs_per_adl_created_6months;
   unsigned1 ssns_per_adl_seen_18months;
   unsigned1 ssns_per_adl_multiple_use;
   unsigned1 ssns_per_adl_multiple_use_non_relative;
   unsigned1 lnames_per_adl;
   unsigned1 lnames_per_adl30;
   unsigned1 lnames_per_adl90;
   unsigned1 lnames_per_adl180;
   unsigned1 lnames_per_adl12;
   unsigned1 lnames_per_adl24;
   unsigned1 lnames_per_adl36;
   unsigned1 lnames_per_adl60;
   unsigned1 invalid_ssns_per_adl;
   unsigned1 invalid_phones_per_adl;
   unsigned1 invalid_addrs_per_adl;
   unsigned1 invalid_ssns_per_adl_created_6months;
   unsigned1 invalid_phones_per_adl_created_6months;
   unsigned1 invalid_addrs_per_adl_created_6months;
   unsigned1 dl_addrs_per_adl;
   unsigned1 vo_addrs_per_adl;
   unsigned1 pl_addrs_per_adl;
   unsigned1 addrs_per_ssn;
   unsigned1 adls_per_ssn_created_6months;
   unsigned1 addrs_per_ssn_created_6months;
   unsigned1 adls_per_ssn_seen_18months;
   unsigned1 lnames_per_ssn;
   unsigned1 lnames_per_ssn_created_6months;
   unsigned1 addrs_per_ssn_multiple_use;
   unsigned1 adls_per_ssn_multiple_use;
   unsigned1 adls_per_ssn_multiple_use_non_relative;
   unsigned1 adls_per_addr;
   unsigned1 ssns_per_addr;
   unsigned1 phones_per_addr;
   unsigned1 adls_per_addr_current;
   unsigned1 ssns_per_addr_current;
   unsigned1 phones_per_addr_current;
   unsigned1 adls_per_addr_created_6months;
   unsigned1 ssns_per_addr_created_6months;
   unsigned1 phones_per_addr_created_6months;
   unsigned1 adls_per_addr_multiple_use;
   unsigned1 ssns_per_addr_multiple_use;
   unsigned1 phones_per_addr_multiple_use;
   unsigned1 suspicious_adls_per_addr_created_6months;
   unsigned1 adls_per_phone;
   unsigned1 adls_per_phone_current;
   unsigned1 adls_per_phone_created_6months;
   unsigned1 adls_per_phone_multiple_use;
   unsigned1 addrs_per_phone;
   unsigned1 addrs_per_phone_created_6months;
  END;

layout_infutor := RECORD
   unsigned4 infutor_date_first_seen;
   unsigned4 infutor_date_last_seen;
   unsigned1 infutor_nap;
  END;

layout_impulse := RECORD
   unsigned2 count;
   unsigned4 first_seen_date;
   unsigned4 last_seen_date;
   string50 siteid;
   unsigned2 count30;
   unsigned2 count90;
   unsigned2 count180;
   unsigned2 count12;
   unsigned2 count24;
   unsigned2 count36;
   unsigned2 count60;
   unsigned5 annual_income;
   integer8 count12_6mos;
   integer8 count12_12mos;
   integer8 count12_24mos;
  END;

layout_derogs := RECORD
   boolean bankrupt;
   unsigned4 date_last_seen;
   string1 filing_type;
   string35 disposition;
   unsigned1 filing_count;
   unsigned1 filing_count120;
   unsigned1 bk_recent_count;
   unsigned1 bk_dismissed_recent_count;
   unsigned1 bk_dismissed_historical_count;
   unsigned1 bk_dismissed_historical_cnt120;
   unsigned1 bk_disposed_recent_count;
   unsigned1 bk_disposed_historical_count;
   unsigned1 bk_disposed_historical_cnt120;
   unsigned1 bk_count30;
   unsigned1 bk_count90;
   unsigned1 bk_count180;
   unsigned1 bk_count12;
   unsigned1 bk_count24;
   unsigned1 bk_count36;
   unsigned1 bk_count60;
   string3 bk_chapter;
   integer8 bk_count12_6mos;
   integer8 bk_count12_12mos;
   integer8 bk_count12_24mos;
   unsigned1 liens_recent_unreleased_count;
   unsigned1 liens_historical_unreleased_count;
   unsigned1 liens_unreleased_count30;
   unsigned1 liens_unreleased_count90;
   unsigned1 liens_unreleased_count180;
   unsigned1 liens_unreleased_count12;
   unsigned1 liens_unreleased_count24;
   unsigned1 liens_unreleased_count36;
   unsigned1 liens_unreleased_count60;
   unsigned1 liens_unreleased_count84;
   string8 last_liens_unreleased_date;
   string8 liens_last_unrel_date84;
   integer8 liens_unreleased_count12_6mos;
   integer8 liens_unreleased_count12_12mos;
   integer8 liens_unreleased_count12_24mos;
   unsigned1 liens_recent_released_count;
   unsigned1 liens_historical_released_count;
   unsigned1 liens_released_count30;
   unsigned1 liens_released_count90;
   unsigned1 liens_released_count180;
   unsigned1 liens_released_count12;
   unsigned1 liens_released_count24;
   unsigned1 liens_released_count36;
   unsigned1 liens_released_count60;
   unsigned1 liens_released_count84;
   unsigned4 last_liens_released_date;
   unsigned4 liens_last_rel_date84;
   unsigned1 criminal_count;
   unsigned1 criminal_count30;
   unsigned1 criminal_count90;
   unsigned1 criminal_count180;
   unsigned1 criminal_count12;
   unsigned1 criminal_count24;
   unsigned1 criminal_count36;
   unsigned1 criminal_count60;
   unsigned4 last_criminal_date;
   unsigned1 felony_count;
   unsigned4 last_felony_date;
   unsigned1 nonfelony_criminal_count12;
   unsigned4 last_nonfelony_criminal_date;
   integer8 criminal_count12_6mos;
   integer8 criminal_count12_12mos;
   integer8 criminal_count12_24mos;
   unsigned1 eviction_recent_unreleased_count;
   unsigned1 eviction_historical_unreleased_count;
   unsigned1 eviction_recent_released_count;
   unsigned1 eviction_historical_released_count;
   unsigned1 eviction_count;
   unsigned1 eviction_count30;
   unsigned1 eviction_count90;
   unsigned1 eviction_count180;
   unsigned1 eviction_count12;
   unsigned1 eviction_count24;
   unsigned1 eviction_count36;
   unsigned1 eviction_count60;
   unsigned1 eviction_count84;
   unsigned4 last_eviction_date;
   integer8 eviction_count12_6mos;
   integer8 eviction_count12_12mos;
   integer8 eviction_count12_24mos;
   unsigned1 arrests_count;
   unsigned1 arrests_count30;
   unsigned1 arrests_count90;
   unsigned1 arrests_count180;
   unsigned1 arrests_count12;
   unsigned1 arrests_count24;
   unsigned1 arrests_count36;
   unsigned1 arrests_count60;
   unsigned4 date_last_arrest;
   boolean foreclosure_flag;
   string8 last_foreclosure_date;
  END;

layout_relatives_property_value := RECORD
    unsigned2 relatives_property_count;
    unsigned2 relatives_property_total;
    unsigned5 relatives_property_owned_purchase_total;
    unsigned2 relatives_property_owned_purchase_count;
    unsigned5 relatives_property_owned_assessed_total;
    unsigned2 relatives_property_owned_assessed_count;
   END;

layout_relatives := RECORD
   unsigned1 relative_count;
   unsigned1 relative_bankrupt_count;
   unsigned1 relative_criminal_count;
   unsigned1 relative_criminal_total;
   unsigned1 relative_felony_count;
   unsigned1 relative_felony_total;
   unsigned1 criminal_relative_within25miles;
   unsigned1 criminal_relative_within100miles;
   unsigned1 criminal_relative_within500miles;
   unsigned1 criminal_relative_withinother;
   layout_relatives_property_value owned;
   layout_relatives_property_value sold;
   layout_relatives_property_value ambiguous;
   unsigned1 relative_within25miles_count;
   unsigned1 relative_within100miles_count;
   unsigned1 relative_within500miles_count;
   unsigned1 relative_withinother_count;
   unsigned1 relative_incomeunder25_count;
   unsigned1 relative_incomeunder50_count;
   unsigned1 relative_incomeunder75_count;
   unsigned1 relative_incomeunder100_count;
   unsigned1 relative_incomeover100_count;
   unsigned1 relative_homeunder50_count;
   unsigned1 relative_homeunder100_count;
   unsigned1 relative_homeunder150_count;
   unsigned1 relative_homeunder200_count;
   unsigned1 relative_homeunder300_count;
   unsigned1 relative_homeunder500_count;
   unsigned1 relative_homeover500_count;
   unsigned1 relative_educationunder8_count;
   unsigned1 relative_educationunder12_count;
   unsigned1 relative_educationover12_count;
   unsigned1 relative_ageunder20_count;
   unsigned1 relative_ageunder30_count;
   unsigned1 relative_ageunder40_count;
   unsigned1 relative_ageunder50_count;
   unsigned1 relative_ageunder60_count;
   unsigned1 relative_ageunder70_count;
   unsigned1 relative_ageover70_count;
   unsigned1 relative_vehicle_owned_count;
   unsigned1 relatives_at_input_address;
   unsigned1 relative_suspicious_identities_count;
   unsigned1 relative_bureau_only_count;
   unsigned1 relative_bureau_only_count_created_1month;
   unsigned1 relative_bureau_only_count_created_6months;
  END;

vehicle_information := RECORD
    unsigned2 year_make;
    string10 make;
    string10 model;
    boolean title;
    string25 vin;
   END;

vehicle_set := RECORD
   unsigned1 current_count;
   unsigned1 historical_count;
   vehicle_information vehicle1;
   vehicle_information vehicle2;
   vehicle_information vehicle3;
  END;

layout_watercraft := RECORD
   unsigned1 watercraft_count;
   unsigned1 watercraft_count30;
   unsigned1 watercraft_count90;
   unsigned1 watercraft_count180;
   unsigned1 watercraft_count12;
   unsigned1 watercraft_count24;
   unsigned1 watercraft_count36;
   unsigned1 watercraft_count60;
  END;

layout_accident := RECORD
    unsigned1 num_accidents;
    unsigned8 dmgamtaccidents;
    unsigned8 datelastaccident;
    unsigned8 dmgamtlastaccident;
    unsigned1 numaccidents30;
    unsigned1 numaccidents90;
    unsigned1 numaccidents180;
    unsigned1 numaccidents12;
    unsigned1 numaccidents24;
    unsigned1 numaccidents36;
    unsigned1 numaccidents60;
   END;

layout_accident_data := RECORD
   layout_accident acc;
   layout_accident atfault;
   layout_accident atfaultda;
  END;

layout_aircraft := RECORD
   unsigned1 aircraft_count;
   unsigned1 aircraft_count30;
   unsigned1 aircraft_count90;
   unsigned1 aircraft_count180;
   unsigned1 aircraft_count12;
   unsigned1 aircraft_count24;
   unsigned1 aircraft_count36;
   unsigned1 aircraft_count60;
   string8 n_number;
   string8 date_first_seen;
  END;

layout_american_student := RECORD
   string8 date_first_seen;
   string8 date_last_seen;
   string4 crrt_code;
   string1 address_type_code;
   string2 age;
   string8 dob_formatted;
   string3 class;
   string25 college_name;
   string1 college_code;
   string1 college_type;
   string1 income_level_code;
   string1 file_type;
   string1 file_type2;
   string2 rec_type;
   string1 college_tier;
   string3 college_major;
   string1 competitive_code;
   string1 school_size_code;
   string1 tuition_code;
  END;

layout_professional_license := RECORD
   boolean professional_license_flag;
   string60 license_type;
   string100 jobcategory;
   string1 plcategory;
   unsigned1 proflic_count;
   unsigned8 date_most_recent;
   unsigned8 expiration_date;
   unsigned1 proflic_count30;
   unsigned1 proflic_count90;
   unsigned1 proflic_count180;
   unsigned1 proflic_count12;
   unsigned1 proflic_count24;
   unsigned1 proflic_count36;
   unsigned1 proflic_count60;
   unsigned1 expire_count30;
   unsigned1 expire_count90;
   unsigned1 expire_count180;
   unsigned1 expire_count12;
   unsigned1 expire_count24;
   unsigned1 expire_count36;
   unsigned1 expire_count60;
   string2 proflic_source;
   unsigned2 sanctions_count;
   unsigned4 sanctions_date_first_seen;
   unsigned4 sanctions_date_last_seen;
   string50 most_recent_sanction_type;
  END;

layout_address_avm := RECORD
    string1 avm_land_use_code;
    string8 avm_recording_date;
    string4 avm_assessed_value_year;
    string11 avm_sales_price;
    string11 avm_assessed_total_value;
    string11 avm_market_total_value;
    unsigned8 avm_tax_assessment_valuation;
    unsigned8 avm_price_index_valuation;
    unsigned8 avm_hedonic_valuation;
    unsigned8 avm_automated_valuation;
    unsigned8 avm_automated_valuation2;
    unsigned8 avm_automated_valuation3;
    unsigned8 avm_automated_valuation4;
    unsigned8 avm_automated_valuation5;
    unsigned8 avm_automated_valuation6;
    unsigned8 avm_confidence_score;
    unsigned8 avm_median_fips_level;
    unsigned8 avm_median_geo11_level;
    unsigned8 avm_median_geo12_level;
   END;

layout_avm := RECORD
   layout_address_avm input_address_information;
   layout_address_avm address_history_1;
   layout_address_avm address_history_2;
  END;

layout_liens_info := RECORD
    unsigned1 count;
    unsigned4 earliest_filing_date;
    unsigned4 most_recent_filing_date;
    unsigned8 total_amount;
   END;

layout_liens := RECORD
   layout_liens_info liens_unreleased_civil_judgment;
   layout_liens_info liens_released_civil_judgment;
   layout_liens_info liens_unreleased_federal_tax;
   layout_liens_info liens_released_federal_tax;
   layout_liens_info liens_unreleased_foreclosure;
   layout_liens_info liens_released_foreclosure;
   layout_liens_info liens_unreleased_landlord_tenant;
   layout_liens_info liens_released_landlord_tenant;
   layout_liens_info liens_unreleased_lispendens;
   layout_liens_info liens_released_lispendens;
   layout_liens_info liens_unreleased_other_lj;
   layout_liens_info liens_released_other_lj;
   layout_liens_info liens_unreleased_other_tax;
   layout_liens_info liens_released_other_tax;
   layout_liens_info liens_unreleased_small_claims;
   layout_liens_info liens_released_small_claims;
   layout_liens_info liens_unreleased_suits;
   layout_liens_info liens_released_suits;
   unsigned8 liens_unrel_total_amount84;
   unsigned8 liens_unrel_total_amount;
   unsigned8 liens_rel_total_amount84;
   unsigned8 liens_rel_total_amount;
  END;

layout_rv_scores := RECORD
   string3 bankcard;
   string3 retail;
   string3 auto;
   string3 telecom;
   string2 reason1;
   string2 reason2;
   string2 reason3;
   string2 reason4;
   string3 bankcardv2;
   string3 retailv2;
   string3 autov2;
   string3 telecomv2;
   string3 msbv2;
   string3 prescreenv2;
   string2 reason1v2;
   string2 reason2v2;
   string2 reason3v2;
   string2 reason4v2;
   string3 bankcardv3;
   string2 reason1bv3;
   string2 reason2bv3;
   string2 reason3bv3;
   string2 reason4bv3;
   string3 retailv3;
   string2 reason1rv3;
   string2 reason2rv3;
   string2 reason3rv3;
   string2 reason4rv3;
   string3 autov3;
   string2 reason1av3;
   string2 reason2av3;
   string2 reason3av3;
   string2 reason4av3;
   string3 telecomv3;
   string2 reason1tv3;
   string2 reason2tv3;
   string2 reason3tv3;
   string2 reason4tv3;
   string3 msbv3;
   string2 reason1mv3;
   string2 reason2mv3;
   string2 reason3mv3;
   string2 reason4mv3;
   string3 prescreenv3;
   string3 bankcardv4;
   string2 reason1bv4;
   string2 reason2bv4;
   string2 reason3bv4;
   string2 reason4bv4;
   string2 reason5bv4;
   string3 retailv4;
   string2 reason1rv4;
   string2 reason2rv4;
   string2 reason3rv4;
   string2 reason4rv4;
   string2 reason5rv4;
   string3 autov4;
   string2 reason1av4;
   string2 reason2av4;
   string2 reason3av4;
   string2 reason4av4;
   string2 reason5av4;
   string3 telecomv4;
   string2 reason1tv4;
   string2 reason2tv4;
   string2 reason3tv4;
   string2 reason4tv4;
   string2 reason5tv4;
   string3 msbv4;
   string2 reason1mv4;
   string2 reason2mv4;
   string2 reason3mv4;
   string2 reason4mv4;
   string2 reason5mv4;
   string3 prescreenv4;
   string3 bankcardv5;
   string3 reason1bv5;
   string3 reason2bv5;
   string3 reason3bv5;
   string3 reason4bv5;
   string3 autov5;
   string3 reason1av5;
   string3 reason2av5;
   string3 reason3av5;
   string3 reason4av5;
   string3 reason5av5;
   string3 telecomv5;
   string3 reason1tv5;
   string3 reason2tv5;
   string3 reason3tv5;
   string3 reason4tv5;
   string3 reason5tv5;
   string3 msbv5;
   string3 reason1mv5;
   string3 reason2mv5;
   string3 reason3mv5;
   string3 reason4mv5;
   string3 reason5mv5;
   string3 crossindv5;
   string3 reason1cv5;
   string3 reason2cv5;
   string3 reason3cv5;
   string3 reason4cv5;
   string3 reason5cv5;
  END;

layout_fd_scores := RECORD
   string3 fd3;
   string3 fd6;
   string2 reason1;
   string2 reason2;
   string2 reason3;
   string2 reason4;
   string3 fraudpoint;
   string2 reason1fp;
   string2 reason2fp;
   string2 reason3fp;
   string2 reason4fp;
   string2 reason5fp;
   string2 reason6fp;
   string3 fraudpointv2;
   string1 stolenidentityindex;
   string1 syntheticidentityindex;
   string1 manipulatedidentityindex;
   string1 vulnerablevictimindex;
   string1 friendlyfraudindex;
   string1 suspiciousactivityindex;
   string2 reason1fpv2;
   string2 reason2fpv2;
   string2 reason3fpv2;
   string2 reason4fpv2;
   string2 reason5fpv2;
   string2 reason6fpv2;
   string3 fraudpoint_v3;
   string1 stolenidentityindex_v3;
   string1 syntheticidentityindex_v3;
   string1 manipulatedidentityindex_v3;
   string1 vulnerablevictimindex_v3;
   string1 friendlyfraudindex_v3;
   string1 suspiciousactivityindex_v3;
   string3 reason1fp_v3;
   string3 reason2fp_v3;
   string3 reason3fp_v3;
   string3 reason4fp_v3;
   string3 reason5fp_v3;
   string3 reason6fp_v3;
   string3 fraudpoint_v3_fdn;
   string1 stolenidentityindex_v3_fdn;
   string1 syntheticidentityindex_v3_fdn;
   string1 manipulatedidentityindex_v3_fdn;
   string1 vulnerablevictimindex_v3_fdn;
   string1 friendlyfraudindex_v3_fdn;
   string1 suspiciousactivityindex_v3_fdn;
   string3 reason1fp_v3_fdn;
   string3 reason2fp_v3_fdn;
   string3 reason3fp_v3_fdn;
   string3 reason4fp_v3_fdn;
   string3 reason5fp_v3_fdn;
   string3 reason6fp_v3_fdn;
  END;

layout_consumerflags := RECORD
   boolean corrected_flag;
   boolean consumer_statement_flag;
   boolean dispute_flag;
   boolean security_freeze;
   boolean security_alert;
   boolean negative_alert;
   boolean id_theft_flag;
   boolean legal_hold_alert;
  END;

adl_based_modeling_flags := RECORD
   integer1 in_addrpop;
   integer1 in_hphnpop;
   integer1 in_ssnpop;
   integer1 in_dobpop;
   integer1 adl_addr;
   integer1 adl_hphn;
   integer1 adl_ssn;
   integer1 adl_dob;
   integer1 in_addrpop_found;
   integer1 in_hphnpop_found;
  END;

header_verification_summary := RECORD
   qstring100 ver_sources;
   qstring100 ver_sources_nas;
   qstring200 ver_sources_first_seen_date;
   qstring200 ver_sources_max_first_seen_date;
   qstring200 ver_sources_last_seen_date;
   qstring100 ver_sources_recordcount;
   qstring100 ver_fname_sources;
   qstring200 ver_fname_sources_first_seen_date;
   qstring100 ver_fname_sources_recordcount;
   qstring100 ver_lname_sources;
   qstring200 ver_lname_sources_first_seen_date;
   qstring100 ver_lname_sources_recordcount;
   qstring100 ver_addr_sources;
   qstring200 ver_addr_sources_first_seen_date;
   qstring100 ver_addr_sources_recordcount;
   qstring100 ver_ssn_sources;
   qstring200 ver_ssn_sources_first_seen_date;
   qstring100 ver_ssn_sources_recordcount;
   qstring100 ver_dob_sources;
   qstring200 ver_dob_sources_first_seen_date;
   qstring100 ver_dob_sources_recordcount;
   qstring100 ssns_on_file;
   qstring100 dobs_on_file;
   qstring1200 streets_on_file;
   qstring120 phones_on_file;
   qstring100 ssns_on_file_created12months;
   qstring100 dobs_on_file_created12months;
   qstring1200 streets_on_file_created12months;
   qstring120 phones_on_file_created12months;
   unsigned2 ssn_name_source_count;
   unsigned2 ssn_addr_source_count;
   unsigned2 addr_name_source_count;
   unsigned2 phone_addr_source_count;
   unsigned2 phone_lname_source_count;
   qstring1200 lnames_on_file;
   string50 corrssnname_sources;
   qstring200 corrssnname_firstseen;
   qstring200 corrssnname_lastseen;
   string100 corrssnname_source_cnt;
   string50 corrssnaddr_sources;
   qstring200 corrssnaddr_firstseen;
   qstring200 corrssnaddr_lastseen;
   string100 corrssnaddr_source_cnt;
   string50 corraddrname_sources;
   qstring200 corraddrname_firstseen;
   qstring200 corraddrname_lastseen;
   string100 corraddrname_source_cnt;
   string50 corraddrphone_sources;
   qstring200 corraddrphone_firstseen;
   qstring200 corraddrphone_lastseen;
   string100 corraddrphone_source_cnt;
   string50 corrphonelastname_sources;
   qstring200 corrphonelastname_firstseen;
   qstring200 corrphonelastname_lastseen;
   string100 corrphonelastname_source_cnt;
   string50 corrnamedob_sources;
   qstring200 corrnamedob_firstseen;
   qstring200 corrnamedob_lastseen;
   string100 corrnamedob_source_cnt;
   string50 corraddrdob_sources;
   qstring200 corraddrdob_firstseen;
   qstring200 corraddrdob_lastseen;
   string100 corraddrdob_source_cnt;
   string50 corrssndob_sources;
   qstring200 corrssndob_firstseen;
   qstring200 corrssndob_lastseen;
   string100 corrssndob_source_cnt;
   string50 corrssnphone_sources;
   qstring200 corrssnphone_firstseen;
   qstring200 corrssnphone_lastseen;
   string100 corrssnphone_source_cnt;
   string50 corrdobphone_sources;
   qstring200 corrdobphone_firstseen;
   qstring200 corrdobphone_lastseen;
   string100 corrdobphone_source_cnt;
   boolean eq_did_nlr;
   boolean en_did_nlr;
   boolean tn_did_nlr;
   boolean eq_ssn_nlr;
   boolean en_ssn_nlr;
   boolean tn_ssn_nlr;
   unsigned3 header_build_date;
  END;

advo_fields := RECORD
   string1 address_vacancy_indicator;
   string1 throw_back_indicator;
   string1 seasonal_delivery_indicator;
   string1 dnd_indicator;
   string1 college_indicator;
   string1 drop_indicator;
   string1 residential_or_business_ind;
   string1 mixed_address_usage;
  END;

layout_employment := RECORD
   qstring100 company_title;
   unsigned4 first_seen_date;
   unsigned2 business_ct;
   unsigned2 dead_business_ct;
   unsigned2 business_active_phone_ct;
   unsigned2 source_ct;
  END;

layout_business_header_summary := RECORD
   integer8 bus_addr_match_cnt;
   qstring100 bus_sources;
   qstring100 bus_sources_record_cnt;
   qstring200 bus_sources_first_seen_dates;
   integer8 bus_name_match;
   integer8 bus_ssn_match;
   integer8 bus_phone_match;
  END;

layout_reverse_email := RECORD
    string2 verification_level;
    integer8 adls_per_email;
    qstring100 ver_sources;
    qstring200 ver_sources_first_seen_date;
    qstring200 ver_sources_last_seen_date;
    qstring100 ver_sources_recordcount;
   END;

layout_email_50 := RECORD
   integer8 email_ct;
   integer8 email_domain_free_ct;
   integer8 email_domain_isp_ct;
   integer8 email_domain_edu_ct;
   integer8 email_domain_corp_ct;
   qstring50 email_source_list;
   qstring50 email_source_ct;
   qstring100 email_source_first_seen;
   string2 identity_email_verification_level;
   layout_reverse_email reverse_email;
  END;

layout_address_history_summary := RECORD
   boolean address_history_advo_college_hit;
   integer2 unique_addr_cnt;
   integer2 avg_mo_per_addr;
   integer2 addr_count2;
   integer2 addr_count3;
   integer2 addr_count6;
   integer2 addr_count10;
   integer2 lres_2mo_count;
   integer2 lres_6mo_count;
   integer2 lres_12mo_count;
   integer2 hist_addr_match;
   unsigned3 input_addr_first_seen;
   unsigned3 input_addr_last_seen;
   boolean address_history_college_evidence;
  END;

layout_address_risk := RECORD
   unsigned2 occupants_1yr;
   unsigned2 turnover_1yr_in;
   unsigned2 turnover_1yr_out;
   unsigned2 n_vacant_properties;
   unsigned2 n_business_count;
   unsigned2 n_sfd_count;
   unsigned2 n_mfd_count;
   unsigned4 n_ave_building_age;
   unsigned4 n_ave_purchase_amount;
   unsigned4 n_ave_mortgage_amount;
   unsigned4 n_ave_assessed_amount;
   unsigned8 n_ave_building_area;
   unsigned8 n_ave_price_per_sf;
   unsigned8 n_ave_no_of_stories_count;
   unsigned8 n_ave_no_of_rooms_count;
   unsigned8 n_ave_no_of_bedrooms_count;
   unsigned8 n_ave_no_of_baths_count;
  END;

layout_ibehavior := RECORD
   string8 cnsmr_date_first_seen;
   string8 cnsmr_date_last_seen;
   string8 first_order_date;
   string8 last_order_date;
   string3 number_of_sources;
   string4 average_days_between_orders;
   string9 average_amount_per_order;
   string9 total_dollars;
   string4 total_number_of_orders;
   string9 offline_average_amount_per_order;
   string9 offline_dollars;
   string4 offline_orders;
   string9 online_average_amount_per_order;
   string9 online_dollars;
   string4 online_orders;
   string9 retail_average_amount_per_order;
   string9 retail_dollars;
   string4 retail_orders;
  END;

layout_fd_attributesv2 := RECORD
   string2 identityrisklevel;
   string2 idverrisklevel;
   string2 idveraddressnotcurrent;
   string2 sourcerisklevel;
   string2 variationrisklevel;
   string3 variationmsourcesssncount;
   string3 variationmsourcesssnunrelcount;
   string3 variationdobcount;
   string3 variationdobcountnew;
   string2 searchvelocityrisklevel;
   string3 searchcountweek;
   string3 searchcountday;
   string3 searchunverifiedssncountyear;
   string3 searchunverifiedaddrcountyear;
   string3 searchunverifieddobcountyear;
   string3 searchunverifiedphonecountyear;
   string3 searchfraudsearchcount;
   string3 searchfraudsearchcountyear;
   string3 searchfraudsearchcountmonth;
   string3 searchfraudsearchcountweek;
   string3 searchfraudsearchcountday;
   string3 searchlocatesearchcountweek;
   string3 searchlocatesearchcountday;
   string2 assocrisklevel;
   string3 assocsuspicousidentitiescount;
   string3 assoccreditbureauonlycount;
   string3 assoccreditbureauonlycountnew;
   string3 assoccreditbureauonlycountmonth;
   string2 validationrisklevel;
   string2 correlationrisklevel;
   string3 correlationssnnamecount;
   string3 correlationssnaddrcount;
   string3 correlationaddrnamecount;
   string3 correlationaddrphonecount;
   string3 correlationphonelastnamecount;
   string2 divrisklevel;
   string3 divssnidentitymsourceurelcount;
   string3 divaddrsuspidentitycountnew;
   string3 divsearchaddrsuspidentitycount;
   string2 searchcomponentrisklevel;
   string3 searchssnsearchcount;
   string3 searchssnsearchcountmonth;
   string3 searchssnsearchcountweek;
   string3 searchssnsearchcountday;
   string3 searchaddrsearchcount;
   string3 searchaddrsearchcountmonth;
   string3 searchaddrsearchcountweek;
   string3 searchaddrsearchcountday;
   string3 searchphonesearchcount;
   string3 searchphonesearchcountmonth;
   string3 searchphonesearchcountweek;
   string3 searchphonesearchcountday;
   string2 componentcharrisklevel;
   string2 inputaddractivephonelist;
   string11 addrchangeincomediff;
   string11 addrchangevaluediff;
   string4 addrchangecrimediff;
   string2 addrchangeecontrajectory;
   string2 addrchangeecontrajectoryindex;
   string2 curraddractivephonelist;
   string10 curraddrmedianincome;
   string10 curraddrmedianvalue;
   string3 curraddrmurderindex;
   string3 curraddrcartheftindex;
   string3 curraddrburglaryindex;
   string3 curraddrcrimeindex;
   string3 prevaddrageoldest;
   string3 prevaddrlenofres;
   string2 prevaddrdwelltype;
   string2 prevaddrstatus;
   string2 prevaddroccupantowned;
   string10 prevaddrmedianincome;
   string10 prevaddrmedianvalue;
   string3 prevaddrmurderindex;
   string3 prevaddrcartheftindex;
   string3 prevaddrburglaryindex;
   string3 prevaddrcrimeindex;
  END;

layoutamlattributesv1 := RECORD
   string2 indcitizenshipindex;
   string2 indmobilityindex;
   string2 indlegaleventsindex;
   string2 indaccesstofundsindex;
   string2 indbusinessassocationindex;
   string2 indhighvalueassetindex;
   string2 indgeographicindex;
   string2 indassociatesindex;
   string2 indagerange;
   string3 indamlnegativenews90;
   string3 indamlnegativenews24;
   string2 busvalidityindex;
   string2 busstabilityindex;
   string2 buslegaleventsindex;
   string2 busaccesstofundsindex;
   string2 busgeographicindex;
   string2 busassociatesindex;
   string2 busindustryriskindex;
   string3 busamlnegativenews90;
   string3 busamlnegativenews24;
  END;

layout_hhid_summary := RECORD
   unsigned6 hhid;
   unsigned1 hh_members_ct;
   unsigned1 hh_property_owners_ct;
   unsigned1 hh_age_65_plus;
   unsigned1 hh_age_31_to_65;
   unsigned1 hh_age_18_to_30;
   unsigned1 hh_age_lt18;
   unsigned1 hh_collections_ct;
   unsigned1 hh_workers_paw;
   unsigned1 hh_payday_loan_users;
   unsigned1 hh_members_w_derog;
   unsigned1 hh_tot_derog;
   unsigned1 hh_bankruptcies;
   unsigned1 hh_lienholders;
   unsigned1 hh_prof_license_holders;
   unsigned1 hh_criminals;
   unsigned1 hh_college_attendees;
  END;

layout_insurance_phones_verification := RECORD
   string2 insurance_phone_verification;
   boolean insurance_phones_phone_hit;
   boolean insurance_phones_phonesearch_didmatch;
   boolean insurance_phones_did_hit;
   boolean insurance_phones_didsearch_phonematch;
  END;

layout_address_sources_summary := RECORD
   string100 input_addr_sources;
   string200 input_addr_sources_first_seen_date;
   string100 input_addr_sources_recordcount;
   string100 current_addr_sources;
   string200 current_addr_sources_first_seen_date;
   string100 current_addr_sources_recordcount;
   string100 previous_addr_sources;
   string200 previous_addr_sources_first_seen_date;
   string100 previous_addr_sources_recordcount;
  END;

layout_virtual_fraud := RECORD
   integer1 hi_risk_ct;
   integer1 lo_risk_ct;
   integer1 lexid_phone_hi_risk_ct;
   integer1 lexid_phone_lo_risk_ct;
   integer1 altlexid_phone_hi_risk_ct;
   integer1 altlexid_phone_lo_risk_ct;
   integer1 lexid_addr_hi_risk_ct;
   integer1 lexid_addr_lo_risk_ct;
   integer1 altlexid_addr_hi_risk_ct;
   integer1 altlexid_addr_lo_risk_ct;
   integer1 lexid_ssn_hi_risk_ct;
   integer1 lexid_ssn_lo_risk_ct;
   integer1 altlexid_ssn_hi_risk_ct;
   integer1 altlexid_ssn_lo_risk_ct;
  END;

layout_test_fraud := RECORD
   unsigned3 tf_lexid_count;
   unsigned3 tf_ssn_count;
   unsigned3 tf_phone_count;
   unsigned3 tf_addr_count;
   unsigned3 tf_lexid_billgroup_count;
   unsigned3 tf_ssn_billgroup_count;
   unsigned3 tf_phone_billgroup_count;
   unsigned3 tf_addr_billgroup_count;
  END;

layout_contributory_fraud := RECORD
   unsigned3 cf_lexid_count;
   unsigned3 cf_ssn_count;
   unsigned3 cf_phone_count;
   unsigned3 cf_addr_count;
   unsigned3 cf_lexid_billgroup_count;
   unsigned3 cf_ssn_billgroup_count;
   unsigned3 cf_phone_billgroup_count;
   unsigned3 cf_addr_billgroup_count;
  END;

inquiryverification := RECORD
   unsigned1 inquirynapfirstcount;
   unsigned1 inquirynaplastcount;
   unsigned1 inquirynapaddrcount;
   unsigned1 inquirynapphonecount;
   unsigned1 inquirynapssncount;
   unsigned1 inquirynapdobcount;
   string10 inquirynapprim_range;
   string2 inquirynappredir;
   string28 inquirynapprim_name;
   string4 inquirynapsuffix;
   string2 inquirynappostdir;
   string10 inquirynapunit_desig;
   string8 inquirynapsec_range;
   string25 inquirynapcity;
   string2 inquirynapst;
   string5 inquirynapz5;
   string30 inquirynapfname;
   string30 inquirynaplname;
   string9 inquirynapssn;
   string8 inquirynapdob;
   string10 inquirynapphone;
   unsigned1 inquirynapaddrscore;
   unsigned1 inquirynapfnamescore;
   unsigned1 inquirynaplnamescore;
   unsigned1 inquirynapssnscore;
   unsigned1 inquirynapdobscore;
   unsigned1 inquirynapphonescore;
  END;

layout_fp201_attributes := RECORD
   string2 idveraddressmatchescurrent;
   string2 idveraddressvoter;
   string2 idveraddressvehicleregistration;
   string2 idveraddressdriverslicense;
   string2 idverdriverslicensetype;
   string2 idverssndriverslicense;
   string2 sourcevehicleregistration;
   string2 sourcedriverslicense;
  END;

layout_pii_stability := RECORD
   unsigned1 link_candidate_cnt;
   unsigned1 link_wgt_dob_npos_cnt;
   unsigned1 link_wgt_fname_npos_cnt;
   unsigned1 link_wgt_lname_npos_cnt;
   unsigned1 link_wgt_phone_npos_cnt;
   unsigned1 link_wgt_prim_name_npos_cnt;
   unsigned1 link_wgt_prim_range_npos_cnt;
   unsigned1 link_wgt_ssn4_npos_cnt;
   unsigned1 link_wgt_ssn5_npos_cnt;
   unsigned1 link_wgt_dob_nneg_cnt;
   unsigned1 link_wgt_fname_nneg_cnt;
   unsigned1 link_wgt_lname_nneg_cnt;
   unsigned1 link_wgt_phone_nneg_cnt;
   unsigned1 link_wgt_prim_name_nneg_cnt;
   unsigned1 link_wgt_prim_range_nneg_cnt;
   unsigned1 link_wgt_ssn4_nneg_cnt;
   unsigned1 link_wgt_ssn5_nneg_cnt;
   unsigned1 link_wgt_dob_nzero_cnt;
   unsigned1 link_wgt_fname_nzero_cnt;
   unsigned1 link_wgt_lname_nzero_cnt;
   unsigned1 link_wgt_phone_nzero_cnt;
   unsigned1 link_wgt_prim_name_nzero_cnt;
   unsigned1 link_wgt_prim_range_nzero_cnt;
   unsigned1 link_wgt_ssn4_nzero_cnt;
   unsigned1 link_wgt_ssn5_nzero_cnt;
   string15 link_max_weight_element;
   string15 link_min_weight_element;
  END;

layout_counts := RECORD
    unsigned2 counttotal;
    unsigned2 countday;
    unsigned2 countweek;
    unsigned2 count01;
    unsigned2 count03;
    unsigned2 count06;
    unsigned2 count12;
    unsigned2 count24;
    unsigned2 cbdcounttotal;
    unsigned2 cbdcount01;
   END;

layout_counts53 := RECORD
    unsigned2 counttotal;
    unsigned2 countday;
    unsigned2 countweek;
    unsigned2 count01;
    unsigned2 count03;
    unsigned2 count06;
    unsigned2 count12;
    unsigned2 count24;
    unsigned2 cbdcounttotal;
    unsigned2 cbdcount01;
    integer8 count12_6mos;
    integer8 count12_12mos;
    integer8 count12_24mos;
   END;

layout_counts___1 := RECORD
    unsigned2 counttotal;
    unsigned2 countday;
    unsigned2 countweek;
    unsigned2 count01;
    unsigned2 count03;
    unsigned2 count06;
    unsigned2 count12;
    unsigned2 count24;
   END;

layout_inquiries_53 := RECORD
   string8 first_log_date;
   string8 last_log_date;
   integer2 inquiry_addr_ver_ct;
   integer2 inquiry_fname_ver_ct;
   integer2 inquiry_lname_ver_ct;
   integer2 inquiry_ssn_ver_ct;
   integer2 inquiry_dob_ver_ct;
   integer2 inquiry_phone_ver_ct;
   integer2 inquiry_email_ver_ct;
   layout_counts inquiries;
   layout_counts53 collection;
   layout_counts auto;
   layout_counts banking;
   layout_counts mortgage;
   layout_counts53 highriskcredit;
   layout_counts retail;
   layout_counts communications;
   layout_counts___1 fraudsearches;
   layout_counts other;
   layout_counts prepaidcards;
   layout_counts quizprovider;
   layout_counts retailpayments;
   layout_counts studentloans;
   layout_counts utilities;
   unsigned2 inq_billgroup_count;
   unsigned2 inq_billgroup_count01;
   unsigned2 inq_billgroup_count03;
   unsigned2 inq_billgroup_count06;
   unsigned2 inq_billgroup_count12;
   unsigned2 inq_billgroup_count24;
   unsigned2 inquiryperadl;
   unsigned2 inquiryssnsperadl;
   unsigned2 inquiryaddrsperadl;
   unsigned2 inquirylnamesperadl;
   unsigned2 inquiryfnamesperadl;
   unsigned2 inquiryphonesperadl;
   unsigned2 inquirydobsperadl;
   unsigned2 unverifiedssnsperadl;
   unsigned2 unverifiedaddrsperadl;
   unsigned2 unverifiedphonesperadl;
   unsigned2 unverifieddobsperadl;
   unsigned2 inquiryemailsperadl;
   unsigned2 inquiryperssn;
   unsigned2 inquiryadlsperssn;
   unsigned2 inquirylnamesperssn;
   unsigned2 inquiryaddrsperssn;
   unsigned2 inquirydobsperssn;
   unsigned2 fraudsearchinquiryperssn;
   unsigned2 fraudsearchinquiryperssnyear;
   unsigned2 fraudsearchinquiryperssnmonth;
   unsigned2 fraudsearchinquiryperssnweek;
   unsigned2 fraudsearchinquiryperssnday;
   unsigned2 inquiryperaddr;
   unsigned2 inquiryadlsperaddr;
   unsigned2 inquirylnamesperaddr;
   unsigned2 inquiryssnsperaddr;
   unsigned2 fraudsearchinquiryperaddr;
   unsigned2 fraudsearchinquiryperaddryear;
   unsigned2 fraudsearchinquiryperaddrmonth;
   unsigned2 fraudsearchinquiryperaddrweek;
   unsigned2 fraudsearchinquiryperaddrday;
   unsigned2 inquirysuspciousadlsperaddr;
   unsigned2 inquiryperphone;
   unsigned2 inquiryadlsperphone;
   unsigned2 fraudsearchinquiryperphone;
   unsigned2 fraudsearchinquiryperphoneyear;
   unsigned2 fraudsearchinquiryperphonemonth;
   unsigned2 fraudsearchinquiryperphoneweek;
   unsigned2 fraudsearchinquiryperphoneday;
   unsigned2 inquiryadlsperemail;
   string8 am_first_seen_date;
   string8 am_last_seen_date;
   string8 cm_first_seen_date;
   string8 cm_last_seen_date;
   string8 om_first_seen_date;
   string8 om_last_seen_date;
   string8 noncbd_first_log_date;
   string8 noncbd_last_log_date;
   string8 cbd_first_log_date;
   string8 cbd_last_log_date;
   unsigned2 cbd_inquiryaddrsperadl;
   unsigned2 cbd_inquiryadlsperaddr;
   unsigned2 cbd_inquiryphonesperadl;
   unsigned2 inq_peradl_count_day;
   unsigned2 inq_peradl_count_week;
   unsigned2 inq_peradl_count01;
   unsigned2 inq_peradl_count03;
   unsigned2 inq_peradl_count06;
   unsigned2 inq_ssnsperadl_count_day;
   unsigned2 inq_ssnsperadl_count_week;
   unsigned2 inq_ssnsperadl_count01;
   unsigned2 inq_ssnsperadl_count03;
   unsigned2 inq_ssnsperadl_count06;
   unsigned2 inq_addrsperadl_count_day;
   unsigned2 inq_addrsperadl_count_week;
   unsigned2 inq_addrsperadl_count01;
   unsigned2 inq_addrsperadl_count03;
   unsigned2 inq_addrsperadl_count06;
   unsigned2 inq_lnamesperadl_count_day;
   unsigned2 inq_lnamesperadl_count_week;
   unsigned2 inq_lnamesperadl_count01;
   unsigned2 inq_lnamesperadl_count03;
   unsigned2 inq_lnamesperadl_count06;
   unsigned2 inq_fnamesperadl_count_day;
   unsigned2 inq_fnamesperadl_count_week;
   unsigned2 inq_fnamesperadl_count01;
   unsigned2 inq_fnamesperadl_count03;
   unsigned2 inq_fnamesperadl_count06;
   unsigned2 inq_phonesperadl_count_day;
   unsigned2 inq_phonesperadl_count_week;
   unsigned2 inq_phonesperadl_count01;
   unsigned2 inq_phonesperadl_count03;
   unsigned2 inq_phonesperadl_count06;
   unsigned2 inq_dobsperadl_count_day;
   unsigned2 inq_dobsperadl_count_week;
   unsigned2 inq_dobsperadl_count01;
   unsigned2 inq_dobsperadl_count03;
   unsigned2 inq_dobsperadl_count06;
   unsigned2 inq_perssn_count_day;
   unsigned2 inq_perssn_count_week;
   unsigned2 inq_perssn_count01;
   unsigned2 inq_perssn_count03;
   unsigned2 inq_perssn_count06;
   unsigned2 inq_adlsperssn_count_day;
   unsigned2 inq_adlsperssn_count_week;
   unsigned2 inq_adlsperssn_count01;
   unsigned2 inq_adlsperssn_count03;
   unsigned2 inq_adlsperssn_count06;
   unsigned2 inq_lnamesperssn_count_day;
   unsigned2 inq_lnamesperssn_count_week;
   unsigned2 inq_lnamesperssn_count01;
   unsigned2 inq_lnamesperssn_count03;
   unsigned2 inq_lnamesperssn_count06;
   unsigned2 inq_addrsperssn_count_day;
   unsigned2 inq_addrsperssn_count_week;
   unsigned2 inq_addrsperssn_count01;
   unsigned2 inq_addrsperssn_count03;
   unsigned2 inq_addrsperssn_count06;
   unsigned2 inq_dobsperssn_count_day;
   unsigned2 inq_dobsperssn_count_week;
   unsigned2 inq_dobsperssn_count01;
   unsigned2 inq_dobsperssn_count03;
   unsigned2 inq_dobsperssn_count06;
   unsigned2 inq_peraddr_count_day;
   unsigned2 inq_peraddr_count_week;
   unsigned2 inq_peraddr_count01;
   unsigned2 inq_peraddr_count03;
   unsigned2 inq_peraddr_count06;
   unsigned2 inq_adlsperaddr_count_day;
   unsigned2 inq_adlsperaddr_count_week;
   unsigned2 inq_adlsperaddr_count01;
   unsigned2 inq_adlsperaddr_count03;
   unsigned2 inq_adlsperaddr_count06;
   unsigned2 inq_lnamesperaddr_count_day;
   unsigned2 inq_lnamesperaddr_count_week;
   unsigned2 inq_lnamesperaddr_count01;
   unsigned2 inq_lnamesperaddr_count03;
   unsigned2 inq_lnamesperaddr_count06;
   unsigned2 inq_ssnsperaddr_count_day;
   unsigned2 inq_ssnsperaddr_count_week;
   unsigned2 inq_ssnsperaddr_count01;
   unsigned2 inq_ssnsperaddr_count03;
   unsigned2 inq_ssnsperaddr_count06;
   unsigned2 inq_perphone_count_day;
   unsigned2 inq_perphone_count_week;
   unsigned2 inq_perphone_count01;
   unsigned2 inq_perphone_count03;
   unsigned2 inq_perphone_count06;
   unsigned2 inq_adlsperphone_count_day;
   unsigned2 inq_adlsperphone_count_week;
   unsigned2 inq_adlsperphone_count01;
   unsigned2 inq_adlsperphone_count03;
   unsigned2 inq_adlsperphone_count06;
   unsigned2 inq_emailsperadl_count_day;
   unsigned2 inq_emailsperadl_count_week;
   unsigned2 inq_emailsperadl_count01;
   unsigned2 inq_emailsperadl_count03;
   unsigned2 inq_emailsperadl_count06;
   unsigned2 inq_adlsperemail_count_day;
   unsigned2 inq_adlsperemail_count_week;
   unsigned2 inq_adlsperemail_count01;
   unsigned2 inq_adlsperemail_count03;
   unsigned2 inq_adlsperemail_count06;
   integer8 inq_corrnameaddr;
   integer8 inq_corrnameaddr_adl;
   integer8 inq_corrnamessn;
   integer8 inq_corrnamessn_adl;
   integer8 inq_corrnamephone;
   integer8 inq_corrnamephone_adl;
   integer8 inq_corraddrssn;
   integer8 inq_corraddrssn_adl;
   integer8 inq_corrdobaddr;
   integer8 inq_corrdobaddr_adl;
   integer8 inq_corraddrphone;
   integer8 inq_corraddrphone_adl;
   integer8 inq_corrdobssn;
   integer8 inq_corrdobssn_adl;
   integer8 inq_corrphonessn;
   integer8 inq_corrphonessn_adl;
   integer8 inq_corrdobphone;
   integer8 inq_corrdobphone_adl;
   integer8 inq_corrnameaddrssn;
   integer8 inq_corrnameaddrssn_adl;
   integer8 inq_corrnamephonessn;
   integer8 inq_corrnamephonessn_adl;
   integer8 inq_corrnameaddrphnssn;
   integer8 inq_corrnameaddrphnssn_adl;
   integer8 inq_ssnsperadl_1subs;
   integer8 inq_phnsperadl_1subs;
   integer8 inq_primrangesperadl_1subs;
   integer8 inq_dobsperadl_1subs;
   integer8 inq_fnamesperadl_1subs;
   integer8 inq_lnamesperadl_1subs;
   integer8 inq_dobsperadl_daysubs;
   integer8 inq_dobsperadl_mosubs;
   integer8 inq_dobsperadl_yrsubs;
   integer8 inq_ssnsperadl_1dig;
   integer8 inq_phnsperadl_1dig;
   integer8 inq_primrangesperadl_1dig;
   integer8 inq_dobsperadl_1dig;
   integer8 inq_primrangesperssn_1dig;
   integer8 inq_dobsperssn_1dig;
   integer8 inq_ssnsperaddr_1dig;
  END;

layout_riskview_alerts := RECORD
   string4 alert1;
   string4 alert2;
   string4 alert3;
   string4 alert4;
   string4 alert5;
   string4 alert6;
   string4 alert7;
   string4 alert8;
   string4 alert9;
   string4 alert10;
  END;

layout_best_info := RECORD
   string20 fname;
   string20 lname;
   string10 phone;
   string9 ssn;
   string2 input_fname_isbestmatch;
   string2 input_lname_isbestmatch;
   string2 input_phone_isbestmatch;
   string2 input_ssn_isbestmatch;
   string1 best_phone_phonetype;
   string1 best_phone_phoneval;
   string1 best_phone_phonezip;
   string1 curraddr_hriskaddrflag;
   string8 best_ssn_dod;
   string1 best_ssn_decsflag;
   string1 best_ssn_ssndobflag;
   string1 best_ssn_valid;
   unsigned2 adls_per_bestssn;
   unsigned2 addrs_per_bestssn;
   unsigned2 adls_per_curraddr_curr;
   unsigned2 ssns_per_curraddr_curr;
   unsigned2 phones_per_curraddr_curr;
   unsigned2 adls_per_bestphone_curr;
   unsigned2 adls_per_bestssn_c6;
   unsigned2 addrs_per_bestssn_c6;
   unsigned2 adls_per_curraddr_c6;
   unsigned2 ssns_per_curraddr_c6;
   unsigned2 phones_per_curraddr_c6;
   unsigned2 adls_per_bestphone_c6;
   unsigned2 inq_perbestssn;
   unsigned2 inq_adlsperbestssn;
   unsigned2 inq_lnamesperbestssn;
   unsigned2 inq_addrsperbestssn;
   unsigned2 inq_dobsperbestssn;
   unsigned2 inq_percurraddr;
   unsigned2 inq_adlspercurraddr;
   unsigned2 inq_lnamespercurraddr;
   unsigned2 inq_ssnspercurraddr;
   unsigned2 inq_perbestphone;
   unsigned2 inq_adlsperbestphone;
   unsigned2 inq_curraddr_ver_count;
   unsigned2 inq_bestfname_ver_count;
   unsigned2 inq_bestlname_ver_count;
   unsigned2 inq_bestssn_ver_count;
   unsigned2 inq_bestdob_ver_count;
   unsigned2 inq_bestphone_ver_count;
  END;

lj_attributes := RECORD
   integer8 lnj_recent_unreleased_count;
   integer8 lnj_historical_unreleased_count;
   integer8 lnj_unreleased_count12;
   integer8 lnj_recent_released_count;
   integer8 lnj_historical_released_count;
   integer8 lnj_released_count12;
   string8 lnj_last_unreleased_date;
   integer8 lnj_last_released_date;
   integer8 lnj_eviction_count;
   integer8 lnj_eviction_count12;
   integer8 lnj_last_eviction_date;
   integer8 lnj_eviction_recent_unreleased_count;
   integer8 lnj_eviction_historical_unreleased_count;
   integer8 lnj_eviction_recent_released_count;
   integer8 lnj_eviction_historical_released_count;
   integer8 lnj_unreleased_civil_judgment_cnt;
   integer8 lnj_unreleased_civil_judgment_amt;
   integer8 lnj_released_civil_judgment_cnt;
   integer8 lnj_released_civil_judgment_amt;
   integer8 lnj_unreleased_federal_tax_cnt;
   integer8 lnj_unreleased_federal_tax_amt;
   integer8 lnj_released_federal_tax_cnt;
   integer8 lnj_released_federal_tax_amt;
   integer8 lnj_unreleased_foreclosure_cnt;
   integer8 lnj_unreleased_foreclosure_amt;
   integer8 lnj_released_foreclosure_cnt;
   integer8 lnj_released_foreclosure_amt;
   integer8 lnj_unreleased_landlord_tenant_cnt;
   integer8 lnj_unreleased_landlord_tenant_amt;
   integer8 lnj_released_landlord_tenant_cnt;
   integer8 lnj_released_landlord_tenant_amt;
   integer8 lnj_unreleased_lispendens_cnt;
   integer8 lnj_released_lispendens_cnt;
   integer8 lnj_unreleased_other_lj_cnt;
   integer8 lnj_unreleased_other_lj_amt;
   integer8 lnj_released_other_lj_cnt;
   integer8 lnj_released_other_lj_amt;
   integer8 lnj_unreleased_other_tax_cnt;
   integer8 lnj_unreleased_other_tax_amt;
   integer8 lnj_released_other_tax_cnt;
   integer8 lnj_released_other_tax_amt;
   integer8 lnj_unreleased_small_claims_cnt;
   integer8 lnj_unreleased_small_claims_amt;
   integer8 lnj_released_small_claims_cnt;
   integer8 lnj_released_small_claims_amt;
   integer8 lnj_lien_cnt;
   integer8 lnj_lien_total;
   string8 lnj_last_lien_unreleased_date;
   integer8 lnj_last_lien_released_date;
   integer8 lnj_liens_unreleased_all_tax_cnt;
   integer8 lnj_liens_unreleased_all_tax_amt;
   integer8 lnj_liens_released_all_tax_cnt;
   integer8 lnj_liens_released_all_tax_amt;
   string8 lnj_last_alltax_unreleased_date;
   integer8 lnj_last_alltax_released_date;
   integer8 lnj_liens_unreleased_state_tax_cnt;
   integer8 lnj_liens_unreleased_state_tax_amt;
   integer8 lnj_liens_released_state_tax_cnt;
   integer8 lnj_liens_released_state_tax_amt;
   string8 lnj_last_state_unreleased_date;
   integer8 lnj_last_state_released_date;
   integer8 lnj_liens_unreleased_federal_tax_cnt;
   integer8 lnj_liens_unreleased_federal_tax_amt;
   integer8 lnj_liens_released_federal_tax_cnt;
   integer8 lnj_liens_released_federal_tax_amt;
   string8 lnj_last_federal_unreleased_date;
   integer8 lnj_last_federal_released_date;
   integer8 lnj_jgmt_cnt;
   string8 lnj_last_jgmt_unreleased_date;
   integer8 lnj_last_jgmt_released_date;
   integer8 lnj_jgmt_total;
  END;

layout_vooattributesv1 := RECORD
   string2 addressreportingsourceindex;
   string2 addressreportinghistoryindex;
   string2 addresssearchhistoryindex;
   string2 addressutilityhistoryindex;
   string2 addressownershiphistoryindex;
   string2 addresspropertytypeindex;
   string2 addressvalidityindex;
   string2 relativesconfirmingaddressindex;
   string2 addressownermailingaddressindex;
   string2 prioraddressmoveindex;
   string2 priorresidentmoveindex;
   string6 addressdatefirstseen;
   string6 addressdatelastseen;
   string2 occupancyoverride;
   string2 inferredownershiptypeindex;
   string5 otherownedpropertyproximity;
   string2 verificationofoccupancyscore;
  END;

layout_bip_header_info := RECORD
   integer8 bus_seleids_peradl;
   integer8 bus_gold_seleids_peradl;
   integer8 bus_active_seleids_peradl;
   integer8 bus_inactive_seleids_peradl;
   integer8 bus_defunct_seleids_peradl;
   integer8 bus_gold_seleid_first_seen;
   integer8 bus_header_first_seen;
   integer8 bus_header_last_seen;
   integer8 bus_header_build_date;
   integer8 bus_sos_filings_peradl;
   integer8 bus_active_sos_filings_peradl;
  END;

layout_equifax_fraudflags := RECORD
   integer8 factact_curr_active_duty;
   integer8 factact_curr_active_duty_fseen;
   integer8 factact_curr_fraud_alert;
   integer8 factact_curr_fraud_alert_fseen;
   string2 factact_curr_alert_code;
   integer8 factact_hist_fraud_alert_ct;
   integer8 factact_hist_fraud_alert_lseen;
  END;

layout_bip_header_info_54 := RECORD
   integer8 bus_ver_sources_total;
   qstring100 bus_ver_sources;
   qstring200 bus_ver_sources_first_seen;
   qstring200 bus_ver_sources_last_seen;
   integer8 bus_fname_ver_sources_total;
   qstring100 bus_fname_ver_sources;
   qstring200 bus_fname_ver_sources_first_seen;
   qstring200 bus_fname_ver_sources_last_seen;
   integer8 bus_lname_ver_sources_total;
   qstring100 bus_lname_ver_sources;
   qstring200 bus_lname_ver_sources_first_seen;
   qstring200 bus_lname_ver_sources_last_seen;
   integer8 bus_addr_ver_sources_total;
   qstring100 bus_addr_ver_sources;
   qstring200 bus_addr_ver_sources_first_seen;
   qstring200 bus_addr_ver_sources_last_seen;
   integer8 bus_ssn_ver_sources_total;
   qstring100 bus_ssn_ver_sources;
   qstring200 bus_ssn_ver_sources_first_seen;
   qstring200 bus_ssn_ver_sources_last_seen;
   integer8 bus_phone_ver_sources_total;
   qstring100 bus_phone_ver_sources;
   qstring200 bus_phone_ver_sources_first_seen;
   qstring200 bus_phone_ver_sources_last_seen;
   integer3 bus_sos_filings_not_instate;
   integer3 bus_ucc_count;
   integer3 bus_ucc_active_count;
   integer3 bus_inq_count12;
   integer3 bus_inq_credit_count12;
   integer3 bus_inq_highriskcredit_count12;
   integer3 bus_inq_other_count12;
   boolean bus_seleid_match;
  END;

layout_boca_shell := RECORD
  unsigned4 seq;
  unsigned6 did;
  boolean truedid;
  string15 adlcategory;
  layout_input shell_input;
  layout_instantid_results iid;
  layout_source_verification source_verification;
  layout_available_sources available_sources;
  layout_input_validation input_validation;
  layout_address_validation address_validation;
  layout_name_verification name_verification;
  layout_utility utility;
  layout_address_verification address_verification;
  layout_other_address_fields other_address_info;
  layout_phone_verification phone_verification;
  layout_ssn_information ssn_verification;
  layout_velocity_information velocity_counters;
  layout_infutor infutor;
  layout_infutor infutor_phone;
  layout_impulse impulse;
  layout_derogs bjl;
  layout_relatives relatives;
  vehicle_set vehicles;
  layout_watercraft watercraft;
  layout_accident_data accident_data;
  layout_aircraft aircraft;
  layout_american_student student;
  layout_professional_license professional_license;
  layout_avm avm;
  layout_liens liens;
  layout_rv_scores rv_scores;
  layout_fd_scores fd_scores;
  string1 wealth_indicator;
  unsigned4 reported_dob;
  string1 dobmatchlevel;
  integer8 inferred_age;
  string1 mobility_indicator;
  unsigned2 lres;
  unsigned2 lres2;
  unsigned2 lres3;
  boolean addrpop;
  boolean addrpop2;
  boolean addrpop3;
  unsigned3 historydate;
  string4 addrhist1zip4;
  string4 addrhist2zip4;
  string8 gong_adl_dt_first_seen;
  string8 gong_adl_dt_last_seen;
  unsigned1 total_number_derogs;
  unsigned4 date_last_derog;
  unsigned3 estimated_income;
  layout_consumerflags consumerflags;
  adl_based_modeling_flags adl_shell_flags;
  string1 addr_stability;
  header_verification_summary header_summary;
  advo_fields advo_input_addr;
  advo_fields advo_addr_hist1;
  advo_fields advo_addr_hist2;
  layout_employment employment;
  layout_business_header_summary business_header_address_summary;
  layout_email_50 email_summary;
  layout_address_history_summary address_history_summary;
  layout_address_risk addr_risk_summary;
  layout_address_risk addr_risk_summary2;
  layout_address_risk addr_risk_summary3;
  boolean uspis_hotlist;
  layout_ibehavior ibehavior;
  layout_fd_attributesv2 fdattributesv2;
  boolean rhode_island_insufficient_verification;
  layoutamlattributesv1 amlattributes;
  layout_hhid_summary hhid_summary;
  layout_insurance_phones_verification insurance_phones_summary;
  string2 experian_phone_verification;
  boolean attended_college;
  decimal4_1 source_profile;
  integer8 source_profile_index;
  integer8 economic_trajectory;
  integer8 economic_trajectory_index;
  boolean addrsmilitaryever;
  layout_address_sources_summary address_sources_summary;
  layout_virtual_fraud virtual_fraud;
  layout_test_fraud test_fraud;
  layout_contributory_fraud contributory_fraud;
  string20 historydatetimestamp;
  inquiryverification inquiryverification;
  string8 aircraft_build_date;
  string8 watercraft_build_date;
  string8 crim_build_date;
  string8 proflic_build_date;
  string8 property_build_date;
  layout_fp201_attributes fpattributes201;
  layout_pii_stability pii_stability;
  layout_inquiries_53 acc_logs;
  layout_riskview_alerts riskview_alerts;
  layout_best_info best_flags;
  lj_attributes lnj_attributes;
  layout_vooattributesv1 voo_attributes;
  string120 errmsg;
  string8 archive_date_6mo;
  string8 archive_date_12mo;
  string8 archive_date_24mo;
  layout_bip_header_info bip_header;
  layout_equifax_fraudflags eqfx_fraudflags;
  layout_bip_header_info_54 bip_header54;
  string2 phone_ver_bureau;
 END;

Layout := Record
	layout_phone_shell_plus phone_shell;
	layout_boca_shell boca_shell;
END;


// basefilename := '~scoringqa::out::phone_shell_collectionscore_v3_production_phone_shell_20181002_2';            //Bocashell Version 41 in Production     
// testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_10_20181002_2';             //PhoneShell version 10
// testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_20_20181002_2';             //PhoneShell Version 20

// basefilename := '~scoringqa::out::phone_shell_collectionscore_v3_production_phone_shell_20181018';            //Bocashell Version 41 in Production     
// testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_10_20181018';             //PhoneShell version 10
// testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_20_20181018';             //PhoneShell Version 20


// basefilename := '~scoringqa::out::phone_shell_collectionscore_v3_production_phone_shell_20181024_1';            //PhoneShell using BS 41 in Production run 1   
// testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_production_phone_shell_20181024_2';            //PhoneShell using BS 41 in Production run 2   
// testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_production_phone_shell_20181024_3';           //PhoneShell using BS 41 in Production run 3   

// basefilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_10_20181024_1';            //PhoneShell using BS 41 from toggle run 1   
basefilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_10_20181024_2';            //PhoneShell using BS 41 from toggle run 2   
testfilename := '~scoringqa::out::phone_shell_collectionscore_v3_version_10_20181024_3';           //PhoneShell using BS 41 from toggle run 3   


ds_baseline := dataset(basefilename,Layout, Thor);
ds_new := dataset(testfilename,Layout, Thor);


// output(COUNT(ds_baseline), NAMED('baseline_count'));
// output(choosen(ds_baseline, eyeball), NAMED('baseline'));
// output(COUNT(ds_new), NAMED('test_count'));
// output(choosen(ds_new, eyeball), NAMED('test'));


NewLayout := Record
string acctnoRecSeq;
Layout;
END;


NewLayout NewTransBase(ds_baseline L):= Transform
	self.acctnoRecSeq := (string)L.Phone_Shell.input_echo.acctno + (string)L.Phone_Shell.unique_record_sequence;
	Self := L;
End;

TransBase := Project(ds_baseline, NewTransBase(left));
	

// output(COUNT(TransBase), NAMED('TransBase_count'));
// output(choosen(TransBase, 5), NAMED('TransBase'));

NewLayout NewTransSecond(ds_new L):= Transform
	self.acctnoRecSeq := (string)L.Phone_Shell.input_echo.acctno + (string)L.Phone_Shell.unique_record_sequence;
	Self := L;
End;


TransSecond := Project(ds_new, NewTransSecond(left));
	

// output(COUNT(TransSecond), NAMED('TransSecond_count'));
// output(choosen(TransSecond, 5), NAMED('TransSecond'));


// Output(Count(ds_baseline((integer)avm.input_address_information.avm_sales_price &gt;= 999999)), Named('Equals_99999900_Count'));    
//Output(choosen(ds_baseline((integer)avm.input_address_information.avm_sales_price = 99999900), eyeball), Named('Equals_99999900'));    
   
 cmpr := record, maxlength(50000)
		 dataset(Layout) res;
	 end;
 // blank := DATASET(1, TRANSFORM(Layout, SELF.AccountNumber := '-', SELF := []));


base1 := join(TransBase, TransSecond, left.Phone_Shell.input_echo.acctno = right.Phone_Shell.input_echo.acctno
	AND left.Phone_Shell.unique_record_sequence = right.Phone_Shell.unique_record_sequence
	AND left.Phone_Shell.sources.source_owner_name_middle = right.Phone_Shell.sources.source_owner_name_middle,
transform(NewLayout, self := left));

// base1 := join(TransBase, TransSecond, left.Phone_Shell.input_echo.acctno = right.Phone_Shell.input_echo.acctno
	// AND left.Phone_Shell.unique_record_sequence = right.Phone_Shell.unique_record_sequence
	// AND left.Phone_Shell.sources.source_owner_name_middle = right.Phone_Shell.sources.source_owner_name_middle
	// AND left.Phone_Shell.sources.source_owner_name_first = right.Phone_Shell.sources.source_owner_name_first
	// AND left.Phone_Shell.gathered_phone = right.Phone_Shell.gathered_phone,
// transform(NewLayout, self := left));

base2 := join(TransBase, TransSecond, left.Phone_Shell.input_echo.acctno = right.Phone_Shell.input_echo.acctno
	AND left.Phone_Shell.unique_record_sequence = right.Phone_Shell.unique_record_sequence
	AND left.Phone_Shell.sources.source_owner_name_middle <> right.Phone_Shell.sources.source_owner_name_middle,
transform(NewLayout, self := left));


j1 := join(ds_baseline, ds_new, left.Phone_Shell.input_echo.acctno = right.Phone_Shell.input_echo.acctno
				AND left.Phone_Shell.unique_record_sequence = right.Phone_Shell.unique_record_sequence
				AND left.Phone_Shell.sources.source_owner_name_middle <> right.Phone_Shell.sources.source_owner_name_middle,
				// AND left.Phone_Shell.phone_model_score <> right.Phone_Shell.phone_model_score,
				// AND left.student.income_level_code = right.student.income_level_code
				// AND right.student.income_level_code <> '',
				// AND (LEFT.shell_input.in_state = 'MO' OR Left.shell_input.in_state = 'GA'),				
				// AND left.adlcategory <> right.adlcategory
				// AND RIGHT.adlcategory = '6 AMBIG ',
			// AND left.avm.input_address_information.avm_sales_price <> right.avm.input_address_information.avm_sales_price
			// AND left.shell_input.county = 'tangipahoa',
			// AND left.source_verification.num_nonderogs30 <> right.source_verification.num_nonderogs30,
			// AND (LEFT.shell_input.in_state = 'MO' OR Left.shell_input.in_state = 'GA'),
			// AND (integer) left.avm.input_address_information.avm_sales_price - (integer) right.avm.input_address_information.avm_sales_price &gt; 250000, 
			// AND (integer)left.address_verification.recent_property_sales.sale_price1 - (integer)right.address_verification.recent_property_sales.sale_price1 &gt; 250000,
			// AND (integer)left.address_verification.input_address_information.assessed_amount - (integer)right.address_verification.input_address_information.assessed_amount &gt; 250000,
			transform(cmpr, self.res := left + right));

// j2 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
				// AND left.iid.watchlist_table = ''
				// AND right.iid.watchlist_table <> '',
				// AND left.source_verification.num_nonderogs30 &lt; right.source_verification.num_nonderogs30,
			//AND left.avm.input_address_information.avm_sales_price <> right.avm.input_address_information.avm_sales_price
			//AND left.shell_input.county = 'tangipahoa',
			//AND (integer) left.avm.input_address_information.avm_sales_price - (integer) right.avm.input_address_information.avm_sales_price &gt; 250000, 
			//AND (integer)left.address_verification.recent_property_sales.sale_price1 - (integer)right.address_verification.recent_property_sales.sale_price1 &gt; 250000,
		//	AND (integer)left.address_verification.input_address_information.assessed_amount - (integer)right.address_verification.input_address_information.assessed_amount &gt; 250000,
			// transform(cmpr, self.res := left + right + blank));

// j3 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
				// AND left.iid.watchlist_table <> ''
				// AND right.iid.watchlist_table = '',
				// AND left.source_verification.num_nonderogs30 &gt; right.source_verification.num_nonderogs30
				// AND left.source_verification.eq_count &lt; 2
				// AND left.source_verification.en_count &lt; 2,
			//AND left.avm.input_address_information.avm_sales_price <> right.avm.input_address_information.avm_sales_price
			//AND left.shell_input.county = 'tangipahoa',
			//AND (integer) left.avm.input_address_information.avm_sales_price - (integer) right.avm.input_address_information.avm_sales_price &gt; 250000, 
			//AND (integer)left.address_verification.recent_property_sales.sale_price1 - (integer)right.address_verification.recent_property_sales.sale_price1 &gt; 250000,
		//	AND (integer)left.address_verification.input_address_information.assessed_amount - (integer)right.address_verification.input_address_information.assessed_amount &gt; 250000,
			// transform(cmpr, self.res := left + right + blank));


// OUTPUT(COUNT(j1), named('Diff_midName_source_count'));
// OUTPUT(COUNT(j2), named('Increase_num_nonderogs30_Count'));
// OUTPUT(COUNT(j3), named('Decrease_num_nonderogs30_Count'));

// OUTPUT(choosen(j1, 30), NAMED('Diff_midName_source'));
// OUTPUT(CHOOSEN(j2, eyeball), NAMED('Increase_num_nonderogs30'));
// OUTPUT(CHOOSEN(j3, eyeball), NAMED('Decrease_num_nonderogs30'));


// output(COUNT(acct_join), NAMED('acct_join_count'));
// output(CHOOSEN(acct_join, eyeball), NAMED('acct_join'));
// output(COUNT(ds_baseline(IID.DIDdeceased = true)), NAMED('baseline_deceased_count'));
// output(COUNT(ds_baseline(IID.DIDdeceased = false)), NAMED('baseline_deceased_count'));
// output(CHOOSEN(ds_baseline(IID.DIDdeceased = true), eyeball), NAMED('baseline_deceased'));
// output(COUNT(ds_new(IID.DIDdeceased = true)), NAMED('new_deceased_count'));
// output(CHOOSEN(ds_new(IID.DIDdeceased = true), eyeball), NAMED('new_deceased'));
// OUTPUT(CHOOSEN(flatten_baseline, eyeball), NAMED('flat_baseline'));
// OUTPUT(CHOOSEN(flatten_second, eyeball), NAMED('flat_second'));


// output(COUNT(base1), NAMED('base1_count'));
// output(COUNT(base2), NAMED('base2_count'));


ashirey.flatten(TransBase, flatten_baseline);
// ashirey.flatten(base1, flatten_baseline);
ashirey.flatten(TransSecond, flatten_second);




jbase := join(flatten_baseline, flatten_second, left.Phone_Shell__input_echo__acctno = right.Phone_Shell__input_echo__acctno
				AND left.Phone_Shell__unique_record_sequence = right.Phone_Shell__unique_record_sequence
				AND left.Phone_Shell__sources__source_owner_name_middle = right.Phone_Shell__sources__source_owner_name_middle
				AND left.Phone_Shell__sources__source_owner_name_first = right.Phone_Shell__sources__source_owner_name_first
				AND left.Phone_Shell__sources__source_owner_name_suffix <> right.Phone_Shell__sources__source_owner_name_suffix);
				
jsecond := join(flatten_second, flatten_baseline, left.Phone_Shell__input_echo__acctno = right.Phone_Shell__input_echo__acctno
				AND left.Phone_Shell__unique_record_sequence = right.Phone_Shell__unique_record_sequence
				AND left.Phone_Shell__sources__source_owner_name_middle = right.Phone_Shell__sources__source_owner_name_middle
				AND left.Phone_Shell__sources__source_owner_name_first = right.Phone_Shell__sources__source_owner_name_first
				AND left.Phone_Shell__sources__source_owner_name_suffix <> right.Phone_Shell__sources__source_owner_name_suffix);

// OUTPUT(COUNT(jbase), named('Base_Diff_suffixName_source_count'));
// OUTPUT(choosen(jbase, 30), NAMED('Base_Diff_suffixName_source'));

// OUTPUT(COUNT(jsecond), named('Second_Diff_suffixName_source_count'));
// OUTPUT(choosen(jsecond, 30), NAMED('Second_Diff_suffixName_source'));

// output(COUNT(flatten_baseline), NAMED('flatten_baseline_count'));
// output(choosen(flatten_baseline, 5), NAMED('flatten_baseline'));
// output(COUNT(flatten_second), NAMED('flatten_second_count'));
// output(choosen(flatten_second, 5), NAMED('flatten_second'));

scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctnoRecSeq'], 0);