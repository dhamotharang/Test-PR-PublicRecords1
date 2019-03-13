//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_Fed_Bureau_Prisons.raw_BWR_Scrubs - Checking field validity in a file - SALT V3.11.3');
IMPORT scrubs_Fed_Bureau_Prisons,SALT311;
infile := scrubs_Fed_Bureau_Prisons.raw_In_Fed_Bureau_Prisons;
mod_scrubs := scrubs_Fed_Bureau_Prisons.raw_Scrubs;
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
