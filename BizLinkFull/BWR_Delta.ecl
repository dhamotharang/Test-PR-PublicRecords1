//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_Delta - Finding the Delta of Two Files - SALT V4.4.1');
IMPORT BizLinkFull,SALT44;
FilePrev := DATASET([], BizLinkFull.Layout_BizHead);
FileNew := DATASET([], BizLinkFull.Layout_BizHead);
d := BizLinkFull.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
 
