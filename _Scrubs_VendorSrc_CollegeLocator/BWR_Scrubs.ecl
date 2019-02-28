//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_CollegeLocator.BWR_Scrubs - Checking field validity in a file - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_CollegeLocator,SALT311;
infile := _Scrubs_VendorSrc_CollegeLocator.In_CollegeLocator;
mod_scrubs := _Scrubs_VendorSrc_CollegeLocator.Scrubs;
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
