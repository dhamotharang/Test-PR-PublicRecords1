//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_Orbit.BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_Orbit,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  _Scrubs_VendorSrc_Orbit.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* item_id_field */,/* item_name_field */,/* item_description_field */,/* status_name_field */,/* item_source_code_field */,/* source_id_field */,/* source_name_field */,/* source_address1_field */,/* source_address2_field */,/* source_city_field */,/* source_state_field */,/* source_zip_field */,/* source_phone_field */,/* source_website_field */,/* unused_source_sourcecodes_field */,/* unused_fcra_field */,/* unused_fcra_comments_field */,/* market_restrict_flag_field */,/* unused_market_comments_field */,/* unused_contact_category_name_field */,/* unused_contact_name_field */,/* unused_contact_phone_field */,/* unused_contact_email_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
