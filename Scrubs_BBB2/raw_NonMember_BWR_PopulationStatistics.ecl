//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BBB2.raw_NonMember_BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT Scrubs_BBB2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_BBB2.raw_NonMember_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* bbb_id_field */,/* company_name_field */,/* address_field */,/* country_field */,/* phone_field */,/* phone_type_field */,/* listing_month_field */,/* listing_day_field */,/* listing_year_field */,/* http_link_field */,/* non_member_title_field */,/* non_member_category_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
