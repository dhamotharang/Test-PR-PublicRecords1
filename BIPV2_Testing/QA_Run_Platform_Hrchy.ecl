﻿
//Run this in a Build window before plateform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need t go to QA_PlatFormComparisonSummary as WU_Hrchy_Before and WU_Hrchy_After.

//eg: W20150728-165010 (B) ; W20150728-193219 (A)
/* #workunit('priority','high');
   #OPTION('multiplePersistInstances',FALSE);
   string pversion:=BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate;
   hrchy :='~thor_data400::bipv2_hrchy::base::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::data';
   Infile:=dataset('~thor::cemtemp::HrchyInput_CA',Bipv2_proxid.layout_DOT_Base, THOR, OPT);
   SEQUENTIAL(
   STD.File.StartSuperFileTransaction(),
   STD.File.RemoveSuperFile('~thor_data400::bipv2_hrchy::base::built::data',hrchy),
   STD.File.FinishSuperFileTransaction(), 
   BIPV2_Build.build_hrchy(pversion,Infile,,,,false  ).runIter
   );
*/
import BIPV2,DCAV2,STD, BIPV2_Hrchy_PlatForm;
#workunit('priority','high');
#OPTION('multiplePersistInstances',FALSE);
#workunit('name','QA Platform Hrchy');
//string pversion:='20150618';//I have to hardcode it because the data is available in dataland2. //BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate;
//hrchy :='~thor_data400::bipv2_hrchy::base::20150618::data';

string pversion:=BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate;
hrchy :='~thor_data400::bipv2_hrchy::base::' + BIPV2.KeySuffix_mod2.constant_ThisBuild_versionDate + '::data';

Hrchy_Input_Rec:=RECORD
  unsigned6 rcid;
  string2 source;
  string9 ingest_status;
  unsigned6 dotid;
  unsigned6 empid;
  unsigned6 powid;
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 lgid3;
  unsigned6 orgid;
  unsigned6 ultid;
  unsigned6 vanity_owner_did;
  unsigned8 cnt_rcid_per_dotid;
  unsigned8 cnt_dot_per_proxid;
  unsigned8 cnt_prox_per_lgid3;
  unsigned8 cnt_prox_per_powid;
  unsigned8 cnt_dot_per_empid;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_below;
  unsigned3 nodes_total;
  string1 sele_gold;
  string1 ult_seg;
  string1 org_seg;
  string1 sele_seg;
  string1 prox_seg;
  string1 pow_seg;
  string1 ult_prob;
  string1 org_prob;
  string1 sele_prob;
  string1 prox_prob;
  string1 pow_prob;
  string1 iscontact;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string1 iscorp;
  string120 company_name;
  string50 company_name_type_raw;
  string50 company_name_type_derived;
  string1 cnp_hasnumber;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
  string10 prim_range;
  string10 prim_range_derived;
  string2 predir;
  string28 prim_name;
  string28 prim_name_derived;
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
  string250 corp_legal_name;
  string250 dba_name;
  string9 active_duns_number;
  string9 hist_duns_number;
  string9 active_enterprise_number;
  string9 hist_enterprise_number;
  string9 ebr_file_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string50 company_address_type_raw;
  string9 company_fein;
  string1 best_fein_indicator;
  string10 company_phone;
  string1 phone_type;
  string60 company_org_structure_raw;
  unsigned4 company_incorporation_date;
  string8 company_sic_code1;
  string8 company_sic_code2;
  string8 company_sic_code3;
  string8 company_sic_code4;
  string8 company_sic_code5;
  string6 company_naics_code1;
  string6 company_naics_code2;
  string6 company_naics_code3;
  string6 company_naics_code4;
  string6 company_naics_code5;
  string6 company_ticker;
  string6 company_ticker_exchange;
  string1 company_foreign_domestic;
  string80 company_url;
  string2 company_inc_state;
  string32 company_charter_number;
  unsigned4 company_filing_date;
  unsigned4 company_status_date;
  unsigned4 company_foreign_date;
  unsigned4 event_filing_date;
  string50 company_name_status_raw;
  string50 company_status_raw;
  unsigned4 dt_first_seen_company_name;
  unsigned4 dt_last_seen_company_name;
  unsigned4 dt_first_seen_company_address;
  unsigned4 dt_last_seen_company_address;
  string34 vl_id;
  boolean current;
  unsigned8 source_record_id;
  unsigned2 phone_score;
  string9 duns_number;
  string100 source_docid;
  unsigned4 dt_first_seen_contact;
  unsigned4 dt_last_seen_contact;
  unsigned6 contact_did;
  string50 contact_type_raw;
  string50 contact_job_title_raw;
  string9 contact_ssn;
  unsigned4 contact_dob;
  string30 contact_status_raw;
  string60 contact_email;
  string30 contact_email_username;
  string30 contact_email_domain;
  string10 contact_phone;
  string1 from_hdr;
  string35 company_department;
  string50 company_address_type_derived;
  string60 company_org_structure_derived;
  string50 company_name_status_derived;
  string50 company_status_derived;
  string50 contact_type_derived;
  string50 contact_job_title_derived;
  string30 contact_status_derived;
  string1 address_type_derived;
  boolean is_vanity_name_derived;
 END;

//Infile:=dataset('~thor::cemtemp::HrchyInput_CA',Hrchy_Input_Rec, THOR, OPT);
Infile:=dataset('~thor::cemtemp::HrchyInput_CAnew',BIPV2_Testing.Test_Layout, THOR, OPT);
lncad:=dataset('~thor::cemtemp::base::dcav2::20160506::companies', DCAV2.Layouts.Base.companies,thor,opt);

sprayedsignflat := RECORD
   string9 duns_number;
   string90 business_name;
   string30 trade_style;
   string25 street;
   string20 city;
   string2 state;
   string9 zip_code;
   string17 mail_address;
   string14 mail_city;
   string2 mail_state;
   string5 mail_zip_code;
   string10 telephone_number;
   string21 county_name;
   string4 msa_code;
   string40 msa_name;
   string128 line_of_business_description;
   string8 sic1;
   string60 sic1desc;
   string8 sic1a;
   string60 sic1adesc;
   string8 sic1b;
   string60 sic1bdesc;
   string8 sic1c;
   string60 sic1cdesc;
   string8 sic1d;
   string60 sic1ddesc;
   string8 sic2;
   string60 sic2desc;
   string8 sic2a;
   string60 sic2adesc;
   string8 sic2b;
   string60 sic2bdesc;
   string8 sic2c;
   string60 sic2cdesc;
   string8 sic2d;
   string60 sic2ddesc;
   string8 sic3;
   string60 sic3desc;
   string8 sic3a;
   string60 sic3adesc;
   string8 sic3b;
   string60 sic3bdesc;
   string8 sic3c;
   string60 sic3cdesc;
   string8 sic3d;
   string60 sic3ddesc;
   string8 sic4;
   string60 sic4desc;
   string8 sic4a;
   string60 sic4adesc;
   string8 sic4b;
   string60 sic4bdesc;
   string8 sic4c;
   string60 sic4cdesc;
   string8 sic4d;
   string60 sic4ddesc;
   string8 sic5;
   string60 sic5desc;
   string8 sic5a;
   string60 sic5adesc;
   string8 sic5b;
   string60 sic5bdesc;
   string8 sic5c;
   string60 sic5cdesc;
   string8 sic5d;
   string60 sic5ddesc;
   string8 sic6;
   string60 sic6desc;
   string8 sic6a;
   string60 sic6adesc;
   string8 sic6b;
   string60 sic6bdesc;
   string8 sic6c;
   string60 sic6cdesc;
   string8 sic6d;
   string60 sic6ddesc;
   string1 industry_group;
   string4 year_started;
   string8 date_of_incorporation;
   string2 state_of_incorporation_abbr;
   string1 annual_sales_volume_sign;
   string15 annual_sales_volume;
   string1 annual_sales_code;
   string1 employees_here_sign;
   string10 employees_here;
   string1 employees_total_sign;
   string10 employees_total;
   string1 employees_here_code;
   string1 internal_use;
   string8 annual_sales_revision_date;
   string1 net_worth_sign;
   string12 net_worth;
   string1 trend_sales_sign;
   string15 trend_sales;
   string1 trend_employment_total_sign;
   string10 trend_employment_total;
   string1 base_sales_sign;
   string15 base_sales;
   string1 base_employment_total_sign;
   string10 base_employment_total;
   string1 percentage_sales_growth_sign;
   string4 percentage_sales_growth;
   string1 percentage_employment_growth_sign;
   string4 percentage_employment_growth;
   string9 square_footage;
   string1 sals_territory;
   string1 owns_rents;
   string9 number_of_accounts;
   string9 bank_duns_number;
   string30 bank_name;
   string30 accounting_firm_name;
   string1 small_business_indicator;
   string1 minority_owned;
   string1 cottage_indicator;
   string1 foreign_owned;
   string1 manufacturing_here_indicator;
   string1 public_indicator;
   string1 importer_exporter_indicator;
   string1 structure_type;
   string1 type_of_establishment;
   string9 parent_duns_number;
   string9 ultimate_duns_number;
   string9 headquarters_duns_number;
   string30 parent_company_name;
   string30 ultimate_company_name;
   string9 dias_code;
   string3 hierarchy_code;
   string1 ultimate_indicator;
   string30 internal_use1;
   string10 internal_use2;
   string1 internal_use3;
   string1 hot_list_new_indicator;
   string1 hot_list_ownership_change_indicator;
   string1 hot_list_ceo_change_indicator;
   string1 hot_list_company_name_change_ind;
   string1 hot_list_address_change_indicator;
   string1 hot_list_telephone_change_indicator;
   string6 hot_list_new_change_date;
   string6 hot_list_ownership_change_date;
   string6 hot_list_ceo_change_date;
   string6 hot_list_company_name_chg_date;
   string6 hot_list_address_change_date;
   string6 hot_list_telephone_change_date;
   string8 report_date;
   string1 delete_record_indicator;
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

FF:=RECORD
  unsigned6 rid;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned4 date_first_seen;
  unsigned4 date_last_seen;
  unsigned4 date_vendor_first_reported;
  unsigned4 date_vendor_last_reported;
  sprayedsignflat rawfields;
  layout_clean182_fips clean_mail_address;
  layout_clean182_fips clean_address;
  unsigned1 record_type;
  string1 active_duns_number;
  unsigned8 mail_rawaid;
  unsigned8 mail_aceaid;
  unsigned8 rawaid;
  unsigned8 aceaid;
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

dunsd:=dataset('~thor_data400::base::dnb_dmi::20140918a::companies',FF,thor,opt);

gg:=RECORD
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
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 did;
  unsigned1 did_score;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  string franchisee_id;
  string brand_name;
  string fruns;
  string company_name;
  string exec_full_name;
  string address1;
  string address2;
  string city;
  string state;
  string zip_code;
  string zip_code4;
  string phone;
  string phone_extension;
  string secondary_phone;
  string unit_flag;
  string relationship_code;
  string f_units;
  string website_url;
  string email;
  string industry;
  string sector;
  string industry_type;
  string sic_code;
  string frn_start_date;
  string record_id;
  string20 unit_flag_exp;
  string20 relationship_code_exp;
  string10 clean_phone;
  string10 clean_secondary_phone;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
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
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  string100 prep_addr_line1;
  string50 prep_addr_line_last;
  unsigned8 source_rec_id;
 END;

frandx:=dataset('~thor_data400::base::frandx::20120810g::data', gg,thor,opt);
SEQUENTIAL(
STD.File.StartSuperFileTransaction(),
STD.File.RemoveSuperFile('~thor_data400::bipv2_hrchy::base::built::data',hrchy),
STD.File.FinishSuperFileTransaction(),
//BIPV2_Build.build_hrchy(pversion,BIPV2_Files.files_proxid().DS_PROXID_BUILT(st='CA'),,,,false  ).runIter 
//BIPV2_Build.build_hrchy(pversion,Infile,,,,false  ).runIter

//note, the dunsd adn frandx still can be omitted because they are very old and may be removed by somebody.
//In this case, we can use default : BIPV2_Build.build_hrchy(pversion,Infile,lncad,,,false).runIter
BIPV2_Hrchy_PlatForm.build_hrchy_PlatForm(pversion,Infile,lncad,dunsd,frandx,false).runIter
);
