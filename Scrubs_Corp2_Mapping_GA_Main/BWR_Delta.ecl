//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_GA_Main.BWR_Delta - Finding the Delta of Two Files - SALT V3.4.3');
IMPORT Scrubs_Corp2_Mapping_GA_Main,SALT34;
d := Scrubs_Corp2_Mapping_GA_Main.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
+++Line:325:RIDField is now compulsory for full adl matching!!!
+++Line:325:The field specificities must be copied back to the SPC file before linking code can be generated
