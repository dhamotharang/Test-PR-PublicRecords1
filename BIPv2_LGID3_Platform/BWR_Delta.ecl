//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_LGID3_PlatForm.BWR_Delta - Finding the Delta of Two Files - SALT V3.0 Gold');
IMPORT BIPV2_LGID3_PlatForm,SALT30;
d := BIPV2_LGID3_PlatForm.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
