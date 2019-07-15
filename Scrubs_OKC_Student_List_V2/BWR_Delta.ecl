//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OKC_Student_List_V2.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_OKC_Student_List_V2,SALT311;
FilePrev := DATASET([], Layout_OKC_Student_List);
FileNew := DATASET([], Layout_OKC_Student_List);
d := Scrubs_OKC_Student_List_V2.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
