﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.BWR_Scrubs - Checking field validity in a file - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
infile := Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_In_PhonesInfo;
mod_scrubs := Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_Scrubs;
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
