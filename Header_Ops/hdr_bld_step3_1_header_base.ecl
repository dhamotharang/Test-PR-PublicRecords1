import header, ut,dops;

build_version:= header.version_build;
step:=build_version+' Header Sync;Rollup & Stats';
#WORKUNIT('name', step);

dops_datasetname:='PersonHeaderKeys';
build_component:='BASE BUILD:SYNCROLLUP';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

sequential(
		dlog,
		header._config.setup_build,
		Header.proc_Header(build_version).run
		);
// syncs header_raw to LAB LexId. Outputs header_raw_syncd and final header base file.
// Start it after receiving confirmation that iHeader linking has completed
// and a new LAB pairs file is available for use in Boca.
// Transfer output stats to Header_Build_Stats.xls and verify
// STATS, segementation, new_dids_by_src, and src counts
// Header.version_build
// *** CONTINUE ONLY AFTER STATS HAVE BEEN SATISFACTORILY REVIEWED ****
// Estimated THOR time: 24-48hrs

//20200827 W20200914-102752
//20200721 W20200807-170248
//20200624 W20200710-083944
//20200526 W20200614-172725 W20200614-190929
//20200325 
//20191226 W20200115-143933 and W20200115-193755
//20191128 W20191223-183409
//20191023 W20191113-211207
//20180821 W20180907-134837 and W20180910-092751
//20180724 W20180809-101333
//20180626 W20180709-094610
//20180522 W20180611-101225
