//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_MT_Main.BWR_Scrubs - Checking field validity in a file - SALT V3.10.1');
IMPORT Scrubs_Corp2_Mapping_MT_Main,SALT310;
infile := Scrubs_Corp2_Mapping_MT_Main.In_In_MT;
mod_scrubs := Scrubs_Corp2_Mapping_MT_Main.Scrubs;
expandedfile := mod_scrubs.FromNone(infile).ExpandedInfile;
fromexpandedGlobal := mod_scrubs.FromExpanded(expandedfile);
// Summary of errors found across all sources
summaryGlobal := fromexpandedGlobal.SummaryStats;
// Specific error values across any source
errsGlobal := fromexpandedGlobal.AllErrors;
standardStats := mod_scrubs.StandardStats(infile);
PARALLEL(
         OUTPUT(summaryGlobal, ALL, NAMED('ScrubsSummaryStats')),
         OUTPUT(ENTH(errsGlobal, 1000), ALL, NAMED('ScrubsErrs')),
         OUTPUT(standardStats, ALL, NAMED('StandardStats'))
        );

