import header,ut,dops;
#WORKUNIT('protect',true);
#WORKUNIT('priority','high');
#WORKUNIT('priority',11);
#STORED ('production', false);
#STORED ('_Validate_Year_Range_Low', '1800');
#STORED ('_Validate_Year_Range_high', ut.GetDate[1..4]);
#stored ('isHeaderBuild',TRUE);
#OPTION ('multiplePersistInstances',FALSE);
#OPTION ('implicitSubSort',FALSE);
#OPTION ('implicitBuildIndexSubSort',FALSE);
#OPTION ('implicitJoinSubSort',FALSE);
#OPTION ('implicitGroupSubSort',FALSE);

// #stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com'); 

build_version:= header.version_build;
dops_datasetname:='PersonHeaderKeys';
build_component:='BASE BUILD:RELATHHID';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);
sequential(dlog,Header.proc_postHeaderBuilds.relatives);

// XADL2 and re-ADL external sources must have completed successfuly
// in previous step before relatives build starts.
// This is a disk space hog.  Some self joins are broken into pieces
// to free up temporary space during the build or the sorts will fail.
// Estimated THOR time: 36-48hrs
// header.version_build

// 20180724 W20180818-094327
// 20180626 W20180712-090444
// 20180522 W20180614-144751