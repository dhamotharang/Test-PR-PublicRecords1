import ut, header,dops;

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

build_version:= header.version_build;
dops_datasetname:='PersonHeaderKeys';
build_component:='KEY BUILD:BOOLEAN';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

sequential(dlog,Header.proc_postHeaderBuilds.booleanSrch);
// builds Power Search Boolean keys.
// This is a disk space hog.  While it may be run as soon as
// a new header base file is ready, it is recomende to wait
// for header keys to finish to avoid THOR time and space
// competiton.
// Estimated THOR time: 24hrs


//20180821 W20180823-094540
//20180626 W20180717-090331
//20180522 W20180619-230143    