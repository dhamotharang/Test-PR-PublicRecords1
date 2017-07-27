//This is the code to execute in a builder window
#workunit('name','BIPV2_Best.BWR_Delta - Finding the Delta of Two Files - SALT V2.4 Gold');
IMPORT BIPV2_Best,SALT24;
d := BIPV2_Best.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
