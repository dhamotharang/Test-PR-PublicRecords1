//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Seleid_Relative.BWR_Delta - Finding the Delta of Two Files - SALT V3.1.3');
IMPORT BIPV2_Seleid_Relative,SALT31;
d := BIPV2_Seleid_Relative.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));