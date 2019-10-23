//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_bank_routing.BWR_Delta - Finding the Delta of Two Files - SALT V3.8.1');
IMPORT scrubs_bank_routing,SALT38;
d := scrubs_bank_routing.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
