//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID_mj6.BWR_Delta - Finding the Delta of Two Files - SALT V3.0 Beta 2');
IMPORT BIPV2_ProxID_mj6,SALT30;
d := BIPV2_ProxID_mj6.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
