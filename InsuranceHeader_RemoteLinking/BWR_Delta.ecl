//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_RemoteLinking.BWR_Delta - Finding the Delta of Two Files - SALT V3.7.2');
IMPORT InsuranceHeader_RemoteLinking,SALT37;
d := InsuranceHeader_RemoteLinking.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
