//This is the code to execute in a builder window
#workunit('name','BIPV2_POWID_Down.BWR_Delta - Finding the Delta of Two Files - SALT V2.7 Gold');
IMPORT BIPV2_POWID_Down,SALT27;
d := BIPV2_POWID_Down.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
