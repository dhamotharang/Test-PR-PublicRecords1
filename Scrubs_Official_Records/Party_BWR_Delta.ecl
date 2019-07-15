//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Official_Records.Party_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_Official_Records,SALT311;
FilePrev := DATASET([], Party_Layout_Official_Records);
FileNew := DATASET([], Party_Layout_Official_Records);
d := Scrubs_Official_Records.Party_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
