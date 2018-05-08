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

// DO NOT RUN BEFORE A PENDING INCREMENTAL KEY UPDATE (RUN THAT FIRST)

Header.proc_postHeaderBuilds.finalize;
//  *** ENSURE THAT QH IS NOT -IN PROCESS- BEFORE EXCECUTING ****
// Moves header_raw to _PROD and source keys to _QA superfiles.
// This is done manually to avoid collisions with Quick Header(QH).
// The next QH will use these new files at build time.
// NOTE: Check-in Header.version_build with the version just completed
// The next Utility build will use this date to filter out
// over five years old utility records as per vendor agreement
// Estimated THOR time: 1hrs

// 0130 W20180302-134423, W20180302-140235