//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Debt_Settlement.CC_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_Debt_Settlement,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Debt_Settlement.CC_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* idnum_field */,/* businessname_field */,/* dba_field */,/* orgid_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zip_field */,/* zip4_field */,/* phone_field */,/* fax_field */,/* email_field */,/* url_field */,/* status_field */,/* licensedatefrom_field */,/* licensedateto_field */,/* orgtype_field */,/* source_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
