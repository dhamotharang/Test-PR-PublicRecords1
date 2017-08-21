//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_bk_search.BWR_PopulationStatistics - Population Statistics - SALT V3.3.2');
IMPORT Scrubs_bk_search,SALT33;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_bk_search.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*sourcecode Field*/,/* process_date_field */,/* caseid_field */,/* defendantid_field */,/* recid_field */,/* tmsid_field */,/* seq_number_field */,/* court_code_field */,/* case_number_field */,/* orig_case_number_field */,/* chapter_field */,/* filing_type_field */,/* business_flag_field */,/* corp_flag_field */,/* discharged_field */,/* disposition_field */,/* pro_se_ind_field */,/* converted_date_field */,/* orig_county_field */,/* debtor_type_field */,/* debtor_seq_field */,/* ssn_field */,/* ssnsrc_field */,/* ssnmatch_field */,/* ssnmsrc_field */,/* screen_field */,/* dcode_field */,/* disptype_field */,/* dispreason_field */,/* statusdate_field */,/* holdcase_field */,/* datevacated_field */,/* datetransferred_field */,/* activityreceipt_field */,/* tax_id_field */,/* name_type_field */,/* orig_name_field */,/* orig_fname_field */,/* orig_mname_field */,/* orig_lname_field */,/* orig_name_suffix_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* name_score_field */,/* cname_field */,/* orig_company_field */,/* orig_addr1_field */,/* orig_addr2_field */,/* orig_city_field */,/* orig_st_field */,/* orig_zip5_field */,/* orig_zip4_field */,/* orig_email_field */,/* orig_fax_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dbpc_field */,/* chk_digit_field */,/* rec_type_field */,/* county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* phone_field */,/* did_field */,/* bdid_field */,/* app_ssn_field */,/* app_tax_id_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* date_vendor_first_reported_field */,/* date_vendor_last_reported_field */,/* disptypedesc_field */,/* srcdesc_field */,/* srcmtchdesc_field */,/* screendesc_field */,/* dcodedesc_field */,/* date_filed_field */,/* record_type_field */,/* delete_flag_field */,/* dotid_field */,/* dotscore_field */,/* dotweight_field */,/* empid_field */,/* empscore_field */,/* empweight_field */,/* powid_field */,/* powscore_field */,/* powweight_field */,/* proxid_field */,/* proxscore_field */,/* proxweight_field */,/* seleid_field */,/* selescore_field */,/* seleweight_field */,/* orgid_field */,/* orgscore_field */,/* orgweight_field */,/* ultid_field */,/* ultscore_field */,/* ultweight_field */,/* source_rec_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
