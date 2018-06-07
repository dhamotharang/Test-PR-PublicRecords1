//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BIPV2.BWR_Scrubs - Checking field validity in a file - SALT V3.9.0');
IMPORT Scrubs_BIPV2,SALT39;
infile := Scrubs_BIPV2.Ingest_In_BIPV2;
mod_scrubs := Scrubs_BIPV2.Ingest_Scrubs;
expandedfile := mod_scrubs.FromNone(infile).ExpandedInfile;
fromexpandedGlobal := mod_scrubs.FromExpanded(expandedfile, TRUE);
// Summary of errors found across all sources
summaryGlobal := fromexpandedGlobal.SummaryStats;
// Specific error values across any source
errsGlobal := fromexpandedGlobal.AllErrors;
fromexpandedPerSrc := mod_scrubs.FromExpanded(expandedfile, FALSE);
// Summary of errors found per source
summaryPerSrc := fromexpandedPerSrc.SummaryStats;
// Specific error values per source
errsPerSrc := fromexpandedPerSrc.AllErrors;
standardStats := mod_scrubs.StandardStats(infile);
PARALLEL(
         OUTPUT(summaryGlobal, ALL, NAMED('ScrubsSummaryStats')),
         OUTPUT(ENTH(errsGlobal, 1000), ALL, NAMED('ScrubsErrs')),
         OUTPUT(summaryPerSrc, ALL, NAMED('ScrubsSummaryStatsPerSrc')),
         OUTPUT(ENTH(errsPerSrc, 1000), ALL, NAMED('ScrubsErrsPerSrc')),
         OUTPUT(standardStats, ALL, NAMED('StandardStats'))
        );
