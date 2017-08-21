//EXPORT Layout_Risk_indicator_FCRA_ADL_Risk_Table := 'todo';

export Layout_Risk_indicator_FCRA_ADL_Risk_Table:=
record
  unsigned8 did;
  string15 adl_category;
  boolean college_address_in_history;
  unsigned1 phone_ct;
  unsigned1 phone_ct_c6;
  //common_adl_risk combo;
unsigned1   combo_addr_ct;
unsigned1   combo_addr_ct_last30days;
unsigned1   combo_addr_ct_last90days;
unsigned1   combo_addr_ct_c6;
unsigned1   combo_addr_ct_last1year;
unsigned1   combo_addr_ct_last2years;
unsigned1   combo_addr_ct_last3years;
unsigned1   combo_addr_ct_last5years;
unsigned1   combo_addr_ct_last10years;
unsigned1   combo_addr_ct_last15years;
unsigned1   combo_ssn_ct;
unsigned1   combo_ssn_ct_c6;
unsigned1   combo_ssn_ct_s18;
unsigned1   combo_lname_ct;
unsigned1   combo_lname_ct30;
unsigned1   combo_lname_ct90;
unsigned1   combo_lname_ct180;
unsigned1   combo_lname_ct12;
unsigned1   combo_lname_ct24;
unsigned1   combo_lname_ct36;
unsigned1   combo_lname_ct60;
string20   combo_newest_lname;
string20   combo_newest_lname2;
unsigned3   combo_newest_lname_dt_first_seen;
unsigned2   combo_dl_addrs_per_adl;
unsigned2   combo_vo_addrs_per_adl;
unsigned2   combo_pl_addrs_per_adl;
unsigned2   combo_invalid_ssns_per_adl;
unsigned2   combo_invalid_ssns_per_adl_created_6months;
unsigned2   combo_invalid_addrs_per_adl;
unsigned2   combo_invalid_addrs_per_adl_created_6months;
unsigned1   combo_stability;
unsigned4   combo_reported_dob;
string2   combo_reported_dob_src;
integer8   combo_inferred_age;
unsigned4   combo_reported_dob_no_dppa;
string2   combo_reported_dob_src_no_dppa;
integer8   combo_inferred_age_no_dppa;

//  common_adl_risk eq;
unsigned1   eq_addr_ct;
unsigned1   eq_addr_ct_last30days;
unsigned1   eq_addr_ct_last90days;
unsigned1   eq_addr_ct_c6;
unsigned1   eq_addr_ct_last1year;
unsigned1   eq_addr_ct_last2years;
unsigned1   eq_addr_ct_last3years;
unsigned1   eq_addr_ct_last5years;
unsigned1   eq_addr_ct_last10years;
unsigned1   eq_addr_ct_last15years;
unsigned1   eq_ssn_ct;
unsigned1   eq_ssn_ct_c6;
unsigned1   eq_ssn_ct_s18;
unsigned1   eq_lname_ct;
unsigned1   eq_lname_ct30;
unsigned1   eq_lname_ct90;
unsigned1   eq_lname_ct180;
unsigned1   eq_lname_ct12;
unsigned1   eq_lname_ct24;
unsigned1   eq_lname_ct36;
unsigned1   eq_lname_ct60;
string20   eq_newest_lname;
string20   eq_newest_lname2;
unsigned3   eq_newest_lname_dt_first_seen;
unsigned2   eq_dl_addrs_per_adl;
unsigned2   eq_vo_addrs_per_adl;
unsigned2   eq_pl_addrs_per_adl;
unsigned2   eq_invalid_ssns_per_adl;
unsigned2   eq_invalid_ssns_per_adl_created_6months;
unsigned2   eq_invalid_addrs_per_adl;
unsigned2   eq_invalid_addrs_per_adl_created_6months;
unsigned1   eq_stability;
unsigned4   eq_reported_dob;
string2   eq_reported_dob_src;
integer8   eq_inferred_age;
unsigned4   eq_reported_dob_no_dppa;
string2   eq_reported_dob_src_no_dppa;
integer8   eq_inferred_age_no_dppa;

  //common_adl_risk en;
unsigned1   en_addr_ct;
unsigned1   en_addr_ct_last30days;
unsigned1   en_addr_ct_last90days;
unsigned1   en_addr_ct_c6;
unsigned1   en_addr_ct_last1year;
unsigned1   en_addr_ct_last2years;
unsigned1   en_addr_ct_last3years;
unsigned1   en_addr_ct_last5years;
unsigned1   en_addr_ct_last10years;
unsigned1   en_addr_ct_last15years;
unsigned1   en_ssn_ct;
unsigned1   en_ssn_ct_c6;
unsigned1   en_ssn_ct_s18;
unsigned1   en_lname_ct;
unsigned1   en_lname_ct30;
unsigned1   en_lname_ct90;
unsigned1   en_lname_ct180;
unsigned1   en_lname_ct12;
unsigned1   en_lname_ct24;
unsigned1   en_lname_ct36;
unsigned1   en_lname_ct60;
string20   en_newest_lname;
string20   en_newest_lname2;
unsigned3   en_newest_lname_dt_first_seen;
unsigned2   en_dl_addrs_per_adl;
unsigned2   en_vo_addrs_per_adl;
unsigned2   en_pl_addrs_per_adl;
unsigned2   en_invalid_ssns_per_adl;
unsigned2   en_invalid_ssns_per_adl_created_6months;
unsigned2   en_invalid_addrs_per_adl;
unsigned2   en_invalid_addrs_per_adl_created_6months;
unsigned1   en_stability;
unsigned4   en_reported_dob;
string2   en_reported_dob_src;
integer8   en_inferred_age;
unsigned4   en_reported_dob_no_dppa;
string2   en_reported_dob_src_no_dppa;
integer8   en_inferred_age_no_dppa;

  //common_adl_risk tn;
unsigned1   tn_addr_ct;
unsigned1   tn_addr_ct_last30days;
unsigned1   tn_addr_ct_last90days;
unsigned1   tn_addr_ct_c6;
unsigned1   tn_addr_ct_last1year;
unsigned1   tn_addr_ct_last2years;
unsigned1   tn_addr_ct_last3years;
unsigned1   tn_addr_ct_last5years;
unsigned1   tn_addr_ct_last10years;
unsigned1   tn_addr_ct_last15years;
unsigned1   tn_ssn_ct;
unsigned1   tn_ssn_ct_c6;
unsigned1   tn_ssn_ct_s18;
unsigned1   tn_lname_ct;
unsigned1   tn_lname_ct30;
unsigned1   tn_lname_ct90;
unsigned1   tn_lname_ct180;
unsigned1   tn_lname_ct12;
unsigned1   tn_lname_ct24;
unsigned1   tn_lname_ct36;
unsigned1   tn_lname_ct60;
string20   tn_newest_lname;
string20   tn_newest_lname2;
unsigned3   tn_newest_lname_dt_first_seen;
unsigned2   tn_dl_addrs_per_adl;
unsigned2   tn_vo_addrs_per_adl;
unsigned2   tn_pl_addrs_per_adl;
unsigned2   tn_invalid_ssns_per_adl;
unsigned2   tn_invalid_ssns_per_adl_created_6months;
unsigned2   tn_invalid_addrs_per_adl;
unsigned2   tn_invalid_addrs_per_adl_created_6months;
unsigned1   tn_stability;
unsigned4   tn_reported_dob;
string2   tn_reported_dob_src;
integer8   tn_inferred_age;
unsigned4   tn_reported_dob_no_dppa;
string2   tn_reported_dob_src_no_dppa;
integer8   tn_inferred_age_no_dppa;

  //unsigned8 __internal_fpos__;
 END;
