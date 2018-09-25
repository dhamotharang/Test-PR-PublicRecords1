import std,header,dops;
#WORKUNIT('protect',true);
#WORKUNIT('priority','high');
#WORKUNIT('priority',11);
#STORED ('production', false);
#STORED ('_Validate_Year_Range_Low', '1800');
#STORED ('_Validate_Year_Range_high', ((STRING8)Std.Date.Today())[1..4]);
#OPTION ('multiplePersistInstances',FALSE);
#OPTION ('implicitSubSort',FALSE);
#OPTION ('implicitBuildIndexSubSort',FALSE);
#OPTION ('implicitJoinSubSort',FALSE);
#OPTION ('implicitGroupSubSort',FALSE);

operatorEmailList :=  Header.email_list.BocaDevelopersEx;
extraNotifyEmailList := '';

build_version:= header.version_build;
dops_datasetname:='PersonHeaderKeys';
build_component:='PREPROCESS:INGEST';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

sequential(dlog,Header.proc_Header(operatorEmailList,extraNotifyEmailList).STEP1);

// CHECK / UPDATE header.version_build;

// sets inputs, builds source keys and header_raw. When it completes,
// transfer output stats to Header_Build_Stats.xls and verify
// BasicMatch Stats for unusual source spikes/drops or new sources
// *** CONTINUE ONLY AFTER STATS HAVE BEEN SATISFACTORILY REVIEWED ****
// Estimated THOR time: 24-48hrs

//20180821 W20180821-160017
//20180724 W20180725-214137
//20180626 W20180626-125705 and W20180628-100600
//20180522 W20180522-115502
