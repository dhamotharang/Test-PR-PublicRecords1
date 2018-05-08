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
Header.proc_postHeaderBuilds.booleanSrch;
// builds Power Search Boolean keys.
// This is a disk space hog.  While it may be run as soon as
// a new header base file is ready, it is recomende to wait
// for header keys to finish to avoid THOR time and space
// competiton.
// Estimated THOR time: 24hrs
    