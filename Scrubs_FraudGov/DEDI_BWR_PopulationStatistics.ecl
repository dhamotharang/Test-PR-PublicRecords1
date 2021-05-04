//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.DEDI_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_FraudGov,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FraudGov.DEDI_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* domain_field */,/* dispsblemail_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
