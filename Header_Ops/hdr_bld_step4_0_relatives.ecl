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
Header.proc_postHeaderBuilds.relatives; 
// XADL2 and re-ADL external sources must have completed successfuly
// in previous step before relatives build starts.
// This is a disk space hog.  Some self joins are broken into pieces
// to free up temporary space during the build or the sorts will fail.
// Estimated THOR time: 36-48hrs
// header.version_build