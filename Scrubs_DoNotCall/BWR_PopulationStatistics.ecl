//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DoNotCall.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_DoNotCall,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DoNotCall.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* phonenumber_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
