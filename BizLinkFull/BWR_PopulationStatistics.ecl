﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_PopulationStatistics - Population Statistics - SALT V3.3.1');
IMPORT BizLinkFull,SALT33;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BizLinkFull.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* parent_proxid_field */,/* sele_proxid_field */,/* org_proxid_field */,/* ultimate_proxid_field */,/* has_lgid_field */,/* empid_field */,/* source_field */,/* source_record_id_field */,/* source_docid_field */,/* company_name_field */,/* company_name_prefix_field */,/* cnp_name_field */,/* cnp_number_field */,/* cnp_btype_field */,/* cnp_lowv_field */,/* company_phone_field */,/* company_phone_3_field */,/* company_phone_3_ex_field */,/* company_phone_7_field */,/* company_fein_field */,/* company_sic_code1_field */,/* active_duns_number_field */,/* prim_range_field */,/* prim_name_field */,/* sec_range_field */,/* city_field */,/* city_clean_field */,/* st_field */,/* zip_field */,/* company_url_field */,/* isContact_field */,/* contact_did_field */,/* title_field */,/* fname_field */,/* fname_preferred_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* contact_ssn_field */,/* contact_email_field */,/* sele_flag_field */,/* org_flag_field */,/* ult_flag_field */,/* fallback_value_field */,/* CONTACTNAME_field */,/* STREETADDRESS_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));

