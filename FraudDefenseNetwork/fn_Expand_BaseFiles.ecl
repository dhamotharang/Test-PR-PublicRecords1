import tools, FraudDefenseNetwork, data_services, lib_fileservices, _control;
export fn_expand_BaseFiles(STRING run_date) := function 
Location := IF(_control.ThisEnvironment.Name = 'Prod_Thor', '~', Data_Services.Foreign_Prod);

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

layout_clean182_fips := RECORD
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
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

layout_clean_phones := RECORD
   string10 phone_number;
   string10 cell_phone;
   string10 work_phone;
  END;

layout_clean_name_erie := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string64 lname;
   string5 name_suffix;
   string3 name_score;
  END;

Old_Erie_Layout := RECORD
  string12 claimnumber;
  string100 insuredlastname;
  string20 insuredfirstname;
  string20 insuredmiddlename;
  string5 insuredsuffixname;
  string3 typeofloss;
  string1 filestatus;
  string10 initsource;
  string10 refsuperv;
  string4 investigator;
  string3 claimoffice;
  string3 issoffice;
  string2 state;
  string8 dateofloss;
  string8 dateofreferral;
  string8 datelogged;
  string8 dateio;
  string8 dateclosed;
  string8 datereopen;
  string1 findings;
  string1 responsibleparty;
  string1 parttot;
  string8 datecalc;
  string1 savingstype;
  string11 compsavings;
  string11 deniedsavings;
  string11 withdrawnsavings;
  string11 recdsavings;
  string11 initialamountowed;
  string1 underwriting;
  string1 lawenf;
  string1 nicb;
  string1 attorney;
  string1 lawref;
  string1 quality;
  string12 policynumber;
  integer4 score;
  string25 validstart;
  string25 validend;
  unsigned8 ffid;
  string30 source_cp;
  string12 claimnumber_cp;
  string64 name_last;
  string64 name_middle;
  string64 name_first;
  string5 name_suffix;
  string480 o_address;
  string240 o_city;
  string2 o_state;
  string9 o_zip;
  string9 ssn;
  string9 tin;
  string15 telephone_number;
  string10 fax_number;
  string100 email;
  string8 dob;
  string25 validstart_cp;
  string25 validend_cp;
  string25 vin;
  string20 party_type;
  unsigned6 idl;
  unsigned6 adl;
  unsigned6 derived_adl;
  unsigned8 master_party_id;
  unsigned8 party_id;
  string200 loss_state;
  string180 loss_desc;
  string1020 loss_location;
  unsigned8 source_rec_id;
  string20 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  string9 fein;
  string100 business_name;
  string100 clean_business_name;
  string100 clean_business_name_cp;
  layout_clean_name_erie cleaned_name;
  layout_clean_name_erie cleaned_name_cp;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  string100 address_1;
  string50 address_2;
  unsigned8 nid;
  unsigned2 name_ind;
  string10 entity;
  string25 typeofmapping;
  unsigned6 bdid;
  unsigned1 bdid_score;
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
  unsigned6 did;
  unsigned1 did_score;
 END;

Old_ErieWatchlist_Layout := RECORD
  string watchlistid;
  string entityid;
  string firstname;
  string lastname;
  string nameonly;
  string businessnameonly;
  string tin;
  string ssn;
  string dln;
  string dlstate;
  string dob;
  string comment_ds;
  string policy;
  string addressline1;
  string addressline2;
  string city;
  string state;
  string phone1;
  string phone2;
  string zip;
  string country;
  string alertnumber;
  string actioncodes;
  string vin;
  string plate;
  string platestate;
  string checkhist;
  string requester;
  string userid;
  string createuserid;
  string createdate;
  string validstart;
  string validend;
  string clientid;
  string category;
  string alias;
  string email;
  string search_data;
  string8 validstartdate;
  string8 validenddate;
  string20 validstartts;
  string12 phone;
  unsigned8 ffid;
  string20 middlename;
  string5 suffixname;
  unsigned8 source_rec_id;
  string100 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  string9 fein;
  string100 business_name;
  string100 clean_business_name;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  string100 address_1;
  string50 address_2;
  unsigned8 nid;
  unsigned2 name_ind;
  string10 entity;
  unsigned6 bdid;
  unsigned1 bdid_score;
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
  unsigned6 did;
  unsigned1 did_score;
 END;
 
Old_Glb5_Layout := RECORD
  string source_file;
  string source_input;
  string person_orig_ip_address1;
  string orig_ip_address2;
  string orig_company_name1;
  string1 cnametype;
  string clean_cname1;
  string orig_company_name2;
  string clean_cname2;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string orig_full_name1;
  string1 nametype;
  string orig_full_name2;
  string orig_fname;
  string orig_mname;
  string orig_lname;
  string orig_namesuffix;
  string clean_name;
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
  string orig_addr1;
  string orig_lastline1;
  string orig_city1;
  string orig_state1;
  string orig_zip1;
  string clean_addr1;
  string orig_addr2;
  string orig_lastline2;
  string orig_city2;
  string orig_state2;
  string orig_zip2;
  string clean_addr2;
  string personal_phone;
  string work_phone;
  string company_phone;
  string email_address;
  string ssn;
  string dob;
  string dl;
  string dl_state;
  string domain_name;
  string ein;
  string charter_number;
  string ucc_number;
  string linkid;
  unsigned6 appendadl;
  unsigned6 appendbdid;
  string appendtaxid;
  string appendssn;
  string orig_company_id;
  string orig_global_company_id;
  string billing_id;
  string pid;
  string company_id;
  string global_company_id;
  string primary_market_code;
  string secondary_market_code;
  string industry_1_code;
  string industry_2_code;
  string sub_market;
  string vertical;
  string use;
  string industry;
  string glb_purpose;
  string dppa_purpose;
  string fcra_purpose;
  unsigned8 allowflags;
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
  string orig_function_name;
  string description;
  string repflag;
  string job_id;
  string50 orig_reference_code;
  string orig_transaction_code;
  string orig_source_code;
  string3 fraudpoint_score;
  string sybase_company_id;
  string sybase_app_type;
  string sybase_market;
  string sybase_sub_market;
  string sybase_vertical;
  string sybase_main_country_code;
  string sybase_bill_country_code;
  string industry_segment;
  unsigned8 source_rec_id;
  string4 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  string100 address_1;
  string50 address_2;
  string12 phone_number;
  unsigned8 nid;
  unsigned2 name_ind;
  unsigned6 did;
  unsigned1 did_score;
 END;
  
Old_OIG_Layout := RECORD
  string20 lastname;
  string15 firstname;
  string15 midname;
  string30 busname;
  string20 general;
  string20 specialty;
  string6 upin1;
  string10 npi;
  string8 dob;
  string30 address1;
  string20 city;
  string2 state;
  string5 zip5;
  string9 sanctype;
  string8 sancdate;
  string8 reindate;
  string8 waiverdate;
  string2 wvrstate;
  string100 append_prep_address1;
  string50 append_prep_addresslast;
  unsigned8 append_rawaid;
  unsigned8 ace_aid;
  string2 addr_type;
  string250 sancdesc;
  string9 ssn;
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
  unsigned8 lnpid;
  string5 suffix_name;
  unsigned8 source_rec_id;
  string20 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  string9 fein;
  string100 business_name;
  string100 clean_business_name;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  string100 address_1;
  string50 address_2;
  unsigned8 nid;
  unsigned2 name_ind;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
END;

Old_SuspectIP_Layout := RECORD
  string orig_date;
  string orig_ip;
  string orig_country;
  string orig_state;
  string orig_city;
  string orig_isp;
  string8 reported_date;
  string10 reported_time;
  unsigned8 source_rec_id;
  string20 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  layout_clean_name cleaned_name;
  unsigned8 nid;
  unsigned2 name_ind;
  string100 address_1;
  string50 address_2;
 END;

Old_TextMinedCrim_Layout :=RECORD
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
  string150 off_desc;
  string75 off_desc_1;
  string50 off_desc_2;
  string8 off_date;
  string8 convict_dt;
  string8 ct_disp_dt;
  string8 stc_dt;
  string8 inc_adm_dt;
  string8 st_start_dt;
  string8 event_date;
  string150 charge;
  string50 fraud_type;
  unsigned8 source_rec_id;
  string4 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  unsigned8 nid;
  unsigned2 name_ind;
  string100 address_1;
  string50 address_2;
  unsigned6 did;
  unsigned1 did_score;
 END;

Old_AInspection_Layout := RECORD
  string8 dt_first_reported;
  string8 dt_last_reported;
  string address;
  string suffix;
  string city;
  string state;
  string zip_code;
  string comments;
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
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned8 source_rec_id;
  string4 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  unsigned8 nid;
  unsigned2 name_ind;
  string100 address_1;
  string50 address_2;
 END;

Old_CFNA_Layout := RECORD
  string customer_id;
  string vendor_id;
  unsigned6 appended_lexid;
  string date_fraud_reported_ln;
  string first_name;
  string middle_name;
  string last_name;
  string suffix;
  string street_address;
  string city;
  string state;
  string zip_code;
  string10 phone_number;
  string9 ssn;
  string8 dob;
  string driver_license_number;
  string driver_license_state;
  string50 ip_address;
  string50 email_address;
  string device_identification;
  string device_identification_provider;
  string origination_channel;
  string income;
  string own_or_rent;
  string location_identifier;
  string other_application_identifier;
  string other_application_identifier2;
  string other_application_identifier3;
  string date_application;
  string time_application;
  string application_id;
  string fraudpoint_score;
  string date_fraud_detected;
  string financial_loss;
  string gross_fraud_dollar_loss;
  string application_fraud;
  string primary_fraud_code;
  string secondary_fraud_code;
  string source_identifier;
  string ln_product_id;
  string ln_sub_product_id;
  string industry;
  string fraud_index_type;
  unsigned8 source_rec_id;
  string4 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  unsigned8 nid;
  unsigned2 name_ind;
  string100 address_1;
  string50 address_2;
  unsigned6 did;
  unsigned1 did_score;
 END;

Old_Tiger_Layout := RECORD
  string app_number;
  string loan_number;
  string primary_fraud_code;
  string location_identifier;
  string first_name;
  string mid_name;
  string last_name;
  string home_phone;
  string cell_phone;
  string ssn;
  string email;
  string own_rent_other;
  string cust_id_type;
  string cust_id_num;
  string cust_id_source;
  string dob;
  string app_source;
  string app_date;
  string ip_address;
  string address1;
  string city;
  string state;
  string zipcode;
  string net_income;
  string fp1_score;
  string fp2_score;
  string5 namesuffix;
  unsigned8 source_rec_id;
  string4 source;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_vendor_first_reported;
  string current;
  unsigned8 unique_id;
  layout_clean_name cleaned_name;
  layout_clean182_fips clean_address;
  layout_clean_phones clean_phones;
  unsigned8 nid;
  unsigned2 name_ind;
  string100 address_1;
  string50 address_2;
  unsigned6 did;
  unsigned1 did_score;
 END;

////Erie
Erie_old  := dataset(Location + 'thor_data400::base::fdn::qa::Erie', Old_Erie_Layout, thor);

Erie_old2New := project(Erie_old, transform(FraudDefenseNetwork.Layouts.Base.Erie,        
                       self := left;
                       self := [];));
                          
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.Erie.New, Erie_old2New, NewErieBase); 
 							 
               
//Erie Watchlist
Erie_Watchlist_old := dataset(Location + 'thor_data400::base::fdn::qa::eriewatchlist', Old_ErieWatchlist_Layout, thor);

Erie_Watchlist_old2New := project(Erie_Watchlist_old, transform(FraudDefenseNetwork.Layouts.Base.ErieWatchList,        
                                  self := left;
                                  self := [];));

tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.ErieWatchlist.New, Erie_Watchlist_old2New, NewErieWatchlistBase); 	


////Glb5
Glb5_old := dataset(Location + 'thor_data400::base::fdn::qa::glb5', Old_Glb5_Layout, thor);

Glb5_old2New := project(Glb5_old, transform(FraudDefenseNetwork.Layouts.Base.Glb5,        
                        self := left;
                        self := [];));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.Glb5.New, Glb5_old2New, NewGlb5Base);							 

               
//OIG
OIG_old  := dataset(Location + 'thor_data400::base::fdn::qa::OIG', Old_OIG_Layout, thor);


OIG_old2New := project(OIG_old, transform(FraudDefenseNetwork.Layouts.Base.OIG,        
                       self := left;
                       self := [];));
                          
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.OIG.New, OIG_old2New, NewOIGBase);  							 

           
////SuspectIP
SuspectIP_old  := dataset(Location + 'thor_data400::base::fdn::qa::suspectip', Old_SuspectIP_Layout, thor);

SuspectIP_old2New := project(SuspectIP_old, transform(FraudDefenseNetwork.Layouts.Base.SuspectIP,        
                             self := left;
                             self := [];));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.SuspectIP.New, SuspectIP_old2New, NewSuspectIPBase);							 

               
////TextMinedCrim
TextMinedCrim_old := dataset(Location + 'thor_data400::base::fdn::qa::textminedcrim', Old_TextMinedCrim_Layout, thor);

TextMinedCrim_old2New := project(TextMinedCrim_old, transform(FraudDefenseNetwork.Layouts.Base.TextMinedCrim,        
                                 self := left;
                                 self := [];));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.TextMinedCrim.New, TextMinedCrim_old2New, NewTextMinedCrimBase);							 

               
////AInspection
AInspection_old := dataset(Location + 'thor_data400::base::fdn::qa::ainspection', Old_AInspection_Layout, thor);

AInspection_old2New := project(AInspection_old, transform(FraudDefenseNetwork.Layouts.Base.AInspection,        
                               self := left;
                               self := [];));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.AInspection.New, AInspection_old2New, NewAInspectionBase);								 

               
////CFNA
CFNA_old := dataset(Location + 'thor_data400::base::fdn::qa::cfna', Old_CFNA_Layout, thor);

CFNA_old2New := project(CFNA_old, transform(FraudDefenseNetwork.Layouts.Base.CFNA,        
                        self := left;
                        self := [];));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.CFNA.New, CFNA_old2New, NewCFNABase);							 

               
////Tiger
Tiger_old := dataset(Location + 'thor_data400::base::fdn::qa::tiger', Old_Tiger_Layout, thor);

Tiger_old2New := project(Tiger_old, transform(FraudDefenseNetwork.Layouts.Base.tiger,        
                         self := left;
                         self := [];));

tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.Tiger.New, Tiger_old2New, NewTigerBase);	                           

Expand_All_BaseFiles := Sequential(
                                    NewErieBase, 
                                    NewErieWatchlistBase, 
                                    NewGlb5Base, 
                                    NewOIGBase, 
                                    NewSuspectIPBase, 
                                    NewTextMinedCrimBase, 
                                    NewAInspectionBase, 
                                    NewCFNABase, 
                                    NewTigerBase,
                                    FraudDefenseNetwork.Promote(run_date,,true,,,FraudDefenseNetwork.Filenames().base.dAll_filenames).buildfiles.New2Built,
                                    FraudDefenseNetwork.Promote(run_date,,true,,,FraudDefenseNetwork.Filenames().base.dAll_filenames).buildfiles.built2qa,
                                    FraudDefenseNetwork.Promote(run_date,,true,,,FraudDefenseNetwork.Filenames().base.dAll_filenames).buildfiles.cleanup
                                  );                   
return Expand_All_BaseFiles;

END;