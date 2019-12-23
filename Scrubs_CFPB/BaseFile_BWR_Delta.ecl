//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CFPB.BaseFile_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_CFPB,SALT311;
FilePrev := DATASET([], Scrubs_CFPB.BaseFile_Layout_CFPB);
FileNew := DATASET([], Scrubs_CFPB.BaseFile_Layout_CFPB);
d := Scrubs_CFPB.BaseFile_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
