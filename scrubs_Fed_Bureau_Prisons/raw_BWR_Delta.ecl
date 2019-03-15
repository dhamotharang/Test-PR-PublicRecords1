//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_Fed_Bureau_Prisons.raw_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.3');
IMPORT scrubs_Fed_Bureau_Prisons,SALT311;
FilePrev := DATASET([], raw_Layout_Fed_Bureau_Prisons);
FileNew := DATASET([], raw_Layout_Fed_Bureau_Prisons);
d := scrubs_Fed_Bureau_Prisons.raw_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
