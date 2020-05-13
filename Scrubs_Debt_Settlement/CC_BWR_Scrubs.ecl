//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Debt_Settlement.CC_BWR_Scrubs - Checking field validity in a file - SALT V3.11.8');
IMPORT Scrubs_Debt_Settlement,SALT311;
infile := Scrubs_Debt_Settlement.CC_In_Debt_Settlement;
mod_scrubs := Scrubs_Debt_Settlement.CC_Scrubs;
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
