//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull_HS.BWR_Delta - Finding the Delta of Two Files - SALT V3.3.1');
IMPORT BizLinkFull_HS,SALT33;
d := BizLinkFull_HS.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
