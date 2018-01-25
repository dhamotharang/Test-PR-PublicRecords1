//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_GA_Event.BWR_Delta - Finding the Delta of Two Files - SALT V3.8.0');
IMPORT Scrubs_Corp2_Mapping_GA_Event,SALT38;
d := Scrubs_Corp2_Mapping_GA_Event.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
