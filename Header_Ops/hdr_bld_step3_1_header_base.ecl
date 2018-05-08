import header;
#WORKUNIT('protect',true);
#WORKUNIT('priority','high');
#WORKUNIT('priority',11);
#STORED ('production', false);
#STORED ('_Validate_Year_Range_Low', '1800');
#STORED ('_Validate_Year_Range_high', ut.GetDate[1..4]);
#OPTION ('multiplePersistInstances',FALSE);
#OPTION ('implicitSubSort',FALSE);
#OPTION ('implicitBuildIndexSubSort',FALSE);
#OPTION ('implicitJoinSubSort',FALSE);
#OPTION ('implicitGroupSubSort',FALSE);
Header.proc_Header.STEP2;
// syncs header_raw to LAB LexId. Outputs header_raw_syncd and final header base file.
// Start it after receiving confirmation that iHeader linking has completed
// and a new LAB pairs file is available for use in Boca.
// Transfer output stats to Header_Build_Stats.xls and verify
// STATS, segementation, new_dids_by_src, and src counts
// Header.version_build
// *** CONTINUE ONLY AFTER STATS HAVE BEEN SATISFACTORILY REVIEWED ****
// Estimated THOR time: 24-48hrs
