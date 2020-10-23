//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SAM.Input_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_SAM,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_SAM.Input_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* classification_field */,/* name_field */,/* prefix_field */,/* firstname_field */,/* middlename_field */,/* lastname_field */,/* suffix_field */,/* address_1_field */,/* address_2_field */,/* address_3_field */,/* address_4_field */,/* city_field */,/* state_field */,/* country_field */,/* zipcode_field */,/* duns_field */,/* exclusionprogram_field */,/* excludingagency_field */,/* ctcode_field */,/* exclusiontype_field */,/* additionalcomments_field */,/* activedate_field */,/* terminationdate_field */,/* recordstatus_field */,/* crossreference_field */,/* samnumber_field */,/* cage_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
