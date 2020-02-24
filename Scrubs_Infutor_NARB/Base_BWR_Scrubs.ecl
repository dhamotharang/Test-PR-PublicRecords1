//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Infutor_NARB.Base_BWR_Scrubs - Checking field validity in a file - SALT V3.11.4');
IMPORT Scrubs_Infutor_NARB,SALT311;
infile := Scrubs_Infutor_NARB.Base_In_Infutor_NARB;
mod_scrubs := Scrubs_Infutor_NARB.Base_Scrubs;
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
