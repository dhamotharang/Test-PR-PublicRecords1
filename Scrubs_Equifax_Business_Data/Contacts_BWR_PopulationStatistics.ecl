//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Equifax_Business_Data.Contacts_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Equifax_Business_Data,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Equifax_Business_Data.Contacts_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* EFX_id_field */,/* EFX_CONTCT_field */,/* EFX_TITLECD_field */,/* EFX_TITLEDESC_field */,/* EFX_LASTNAM_field */,/* EFX_FSTNAM_field */,/* EFX_EMAIL_field */,/* EFX_DATE_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
