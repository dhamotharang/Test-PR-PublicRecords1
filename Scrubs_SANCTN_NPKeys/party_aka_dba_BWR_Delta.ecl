//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTN_NPKeys.party_aka_dba_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_SANCTN_NPKeys,SALT311;
FilePrev := DATASET([], Scrubs_SANCTN_NPKeys.party_aka_dba_Layout_SANCTN_NPKeys);
FileNew := DATASET([], Scrubs_SANCTN_NPKeys.party_aka_dba_Layout_SANCTN_NPKeys);
d := Scrubs_SANCTN_NPKeys.party_aka_dba_Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
