//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BKMortgage_Assignments.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.6');
IMPORT Scrubs_BKMortgage_Assignments,SALT311;
FilePrev := DATASET([], Layout_BKMortgage_Assignments);
FileNew := DATASET([], Layout_BKMortgage_Assignments);
d := Scrubs_BKMortgage_Assignments.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
