//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EmpID_Down.BWR_Delta - Finding the Delta of Two Files - SALT V3.2.0');
IMPORT BIPV2_EmpID_Down,SALT32;
d := BIPV2_EmpID_Down.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
