//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OPM.raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT Scrubs_OPM,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OPM.raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* employee_name_field */,/* duty_station_field */,/* country_field */,/* state_field */,/* city_field */,/* county_field */,/* agency_field */,/* agency_sub_element_field */,/* computation_date_field */,/* occupational_series_field */,/* file_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
