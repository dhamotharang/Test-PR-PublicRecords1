﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Ingest.BWR_PopulationStatistics - Population Statistics - SALT V3.5.3');
IMPORT BIPV2_Ingest,SALT35;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_Ingest.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* source_field */,/* source_record_id_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* dt_first_seen_company_name_field */,/* dt_last_seen_company_name_field */,/* dt_first_seen_company_address_field */,/* dt_last_seen_company_address_field */,/* dt_first_seen_contact_field */,/* dt_last_seen_contact_field */,/* isContact_field */,/* iscorp_field */,/* cnp_hasnumber_field */,/* cnp_name_field */,/* cnp_number_field */,/* cnp_btype_field */,/* cnp_lowv_field */,/* cnp_translated_field */,/* cnp_classid_field */,/* company_aceaid_field */,/* corp_legal_name_field */,/* dba_name_field */,/* active_duns_number_field */,/* hist_duns_number_field */,/* active_enterprise_number_field */,/* hist_enterprise_number_field */,/* ebr_file_number_field */,/* active_domestic_corp_key_field */,/* hist_domestic_corp_key_field */,/* foreign_corp_key_field */,/* unk_corp_key_field */,/* global_sid_field */,/* record_sid_field */,/* source_docid_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* name_score_field */,/* company_name_field */,/* company_name_type_raw_field */,/* company_name_type_derived_field */,/* company_rawaid_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dbpc_field */,/* chk_digit_field */,/* rec_type_field */,/* fips_state_field */,/* fips_county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* company_bdid_field */,/* company_address_type_raw_field */,/* company_fein_field */,/* best_fein_indicator_field */,/* company_phone_field */,/* phone_type_field */,/* phone_score_field */,/* company_org_structure_raw_field */,/* company_incorporation_date_field */,/* company_sic_code1_field */,/* company_sic_code2_field */,/* company_sic_code3_field */,/* company_sic_code4_field */,/* company_sic_code5_field */,/* company_naics_code1_field */,/* company_naics_code2_field */,/* company_naics_code3_field */,/* company_naics_code4_field */,/* company_naics_code5_field */,/* company_ticker_field */,/* company_ticker_exchange_field */,/* company_foreign_domestic_field */,/* company_url_field */,/* company_inc_state_field */,/* company_charter_number_field */,/* company_filing_date_field */,/* company_status_date_field */,/* company_foreign_date_field */,/* event_filing_date_field */,/* company_name_status_raw_field */,/* company_status_raw_field */,/* vl_id_field */,/* current_field */,/* contact_did_field */,/* contact_type_raw_field */,/* contact_job_title_raw_field */,/* contact_ssn_field */,/* contact_dob_field */,/* contact_status_raw_field */,/* contact_email_field */,/* contact_email_username_field */,/* contact_email_domain_field */,/* contact_phone_field */,/* from_hdr_field */,/* company_department_field */,/* company_address_type_derived_field */,/* company_org_structure_derived_field */,/* company_name_status_derived_field */,/* company_status_derived_field */,/* contact_type_derived_field */,/* contact_job_title_derived_field */,/* contact_status_derived_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
