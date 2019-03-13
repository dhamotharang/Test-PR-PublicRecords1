import header, ut,dops;
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

operatorEmailList :=  Header.email_list.BocaDevelopersEx;
extraNotifyEmailList := '';

build_version:= header.version_build;
dops_datasetname:='PersonHeaderKeys';
build_component:='BASE BUILD:SYNCROLLUP';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

sequential(dlog,Header.proc_Header(operatorEmailList,extraNotifyEmailList).STEP2);
// syncs header_raw to LAB LexId. Outputs header_raw_syncd and final header base file.
// Start it after receiving confirmation that iHeader linking has completed
// and a new LAB pairs file is available for use in Boca.
// Transfer output stats to Header_Build_Stats.xls and verify
// STATS, segementation, new_dids_by_src, and src counts
// Header.version_build
// *** CONTINUE ONLY AFTER STATS HAVE BEEN SATISFACTORILY REVIEWED ****
// Estimated THOR time: 24-48hrs

//20180821 W20180907-134837 and W20180910-092751
//20180724 W20180809-101333
//20180626 W20180709-094610
//20180522 W20180611-101225
