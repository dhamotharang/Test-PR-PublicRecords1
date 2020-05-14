//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_ECRulings.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_ECRulings,SALT311;
FilePrev := DATASET([], Scrubs_ECRulings.Layout_ECRulings);
FileNew := DATASET([], Scrubs_ECRulings.Layout_ECRulings);
d := Scrubs_ECRulings.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
