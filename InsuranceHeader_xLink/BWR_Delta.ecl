//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_xLink.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.10-PV1');
IMPORT InsuranceHeader_xLink,SALT311;
FilePrev := DATASET([], InsuranceHeader_xLink.Layout_InsuranceHeader);
FileNew := DATASET([], InsuranceHeader_xLink.Layout_InsuranceHeader);
d := InsuranceHeader_xLink.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
