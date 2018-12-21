import ut,header,dops;
build_version:= header.version_build;

dops_datasetname:=header._config.dops_datasetname;

dlog(string bld_cmp_nm):=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,bld_cmp_nm);

sf_name := '~thor_data400::out::header_post_move_status';

status := Header.LogBuildStatus(sf_name, build_version).GetLatestCompletedStatus:INDEPENDENT;

update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;

step5:=Header.proc_postHeaderBuilds.finalize;
step6:=Header.proc_postHeaderBuilds.FCRAheader;
step7:=Header.proc_postHeaderBuilds.booleanSrch;

sequential(
            header._config.setup_build,
            if(status<5,sequential(dlog('KEY BUILD:MOVE'   ),step5,update_status(5))),
            if(status<6,sequential(dlog('KEY BUILD:FCRA'   ),step6,update_status(6))),
            if(status<7,sequential(dlog('KEY BUILD:BOOLEAN'),step7,update_status(7))),
          );