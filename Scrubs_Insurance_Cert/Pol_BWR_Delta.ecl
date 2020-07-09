//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Insurance_Cert.Pol_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_Insurance_Cert,SALT311;
FilePrev := DATASET([], Scrubs_Insurance_Cert.Pol_Layout_Insurance_Cert);
FileNew := DATASET([], Scrubs_Insurance_Cert.Pol_Layout_Insurance_Cert);
d := Scrubs_Insurance_Cert.Pol_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
