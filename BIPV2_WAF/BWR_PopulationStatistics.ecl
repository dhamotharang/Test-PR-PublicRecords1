//This is the code to execute in a builder window
#workunit('name','BIPV2_WAF.BWR_PopulationStatistics - Population Statistics - SALT V2.9 Beta 3');
IMPORT BIPV2_WAF,SALT29;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_WAF.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* parent_proxid_field */,/* ultimate_proxid_field */,/* has_lgid_field */,/* empid_field */,/* powid_field */,/* source_field */,/* source_record_id_field */,/* cnp_number_field */,/* cnp_btype_field */,/* cnp_lowv_field */,/* cnp_name_field */,/* company_phone_field */,/* company_fein_field */,/* company_sic_code1_field */,/* prim_range_field */,/* prim_name_field */,/* sec_range_field */,/* p_city_name_field */,/* st_field */,/* zip_field */,/* company_url_field */,/* isContact_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* contact_email_field */,/* CONTACTNAME_field */,/* STREETADDRESS_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
