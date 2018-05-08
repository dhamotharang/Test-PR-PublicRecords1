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
Header.proc_postHeaderBuilds.headerKeys;
//  Builds file_header_building and all header keys including
// Relatives and XADL1.  It moves all except source keys to _QA
// superfiles. It also builds and desprays DISTRIX Hash
// files in a quarterly bases ie. when versio_build[5..6] in
// ['03','06','09','12']; for notification of completion
// add your email address in misc.header_hash_split.
// This step will use all the base files created in earlier steps
// Estimated THOR time: 72-96hrs


// 20180130 W20180301-155327