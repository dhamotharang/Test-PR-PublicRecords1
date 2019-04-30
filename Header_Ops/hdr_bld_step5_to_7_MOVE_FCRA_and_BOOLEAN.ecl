import ut,header,dops;

dops_datasetname:=header._info.dops_datasetname;

EXPORT hdr_bld_step5_to_7_MOVE_FCRA_and_BOOLEAN(string8 build_version, unsigned2 bld_status) := FUNCTION

dlog(string bld_cmp_nm):=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,bld_cmp_nm);

sf_name := '~thor_data400::out::header_post_move_status';
update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;

step1:=Header.proc_postHeaderBuilds(build_version).finalize;
step2:=Header.proc_postHeaderBuilds(build_version).FCRAheader;
step3:=Header.proc_postHeaderBuilds(build_version).booleanSrch;

return sequential(
             header._config.setup_build
            ,dlog('KEY BUILD:POST MOVE')
            ,if(bld_status = 0,
                 sequential(
                   update_status(1) // 1 -> Build started
                 )
             )
            ,if(bld_status < 2,
                 sequential(
                   step1,
                   update_status(2) // 2 -> Move Completed
                 )
             )
            ,if(bld_status < 3,
                 sequential(
                   step2,
                   update_status(3) // 3 -> FCRA Completed
                 )
             )
            ,if(bld_status < 4,
                 sequential(
                   step3,
                   update_status(0) // 3 -> Boolean Completed
                 )
             )
          );

END;
          

//WorkUnits History

// 20190324 W20190422-081331 & W20190422-103255
// 20181224 W20190120-135405