//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Debt_Settlement.CC_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.8');
IMPORT Scrubs_Debt_Settlement,SALT311;
FilePrev := DATASET([], CC_Layout_Debt_Settlement);
FileNew := DATASET([], CC_Layout_Debt_Settlement);
d := Scrubs_Debt_Settlement.CC_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
