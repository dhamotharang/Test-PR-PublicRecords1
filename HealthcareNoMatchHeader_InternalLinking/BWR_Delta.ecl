//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_InternalLinking.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_InternalLinking,SALT311;
FilePrev := DATASET([], Layout_HEADER);
FileNew := DATASET([], Layout_HEADER);
d := HealthcareNoMatchHeader_InternalLinking.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
