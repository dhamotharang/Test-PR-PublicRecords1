//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev2.BWR_Delta - Finding the Delta of Two Files - SALT V2.7 Alpha 5');
IMPORT BIPV2_ProxID_dev2,SALT27;
d := BIPV2_ProxID_dev2.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
