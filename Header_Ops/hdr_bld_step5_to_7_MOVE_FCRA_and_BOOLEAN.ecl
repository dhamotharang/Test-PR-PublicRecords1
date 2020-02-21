import ut,header,dops,std,_control;

dops_datasetname:=header._info.dops_datasetname;

qhdr := '*QuickHeader*';
valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=qhdr))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
qh_running :=  false;//exists(d);

/*
Directly set the version(yyyymmdd) here instead of calling version_build
to get rid of any confusion of what is in version_build
*/
build_version := header.version_build; //'20191023'
#stored ('version', build_version);
#stored ('buildname', 'PersonHeader');

wname := build_version + ' Header Move, FCRA and Boolean';
#WORKUNIT('name', wname);

dlog(string bld_cmp_nm):=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,bld_cmp_nm);

sf_name := header_ops._Constant.postmove_build_sf;
update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;

status := Header.LogBuildStatus(sf_name, build_version).GetLatestVersionCompletedStatus:INDEPENDENT;

step1 := Header.proc_postHeaderBuilds(build_version).finalize;
step2 := STD.File.MoveExternalFile(_control.IPAddress.bctlpedata10, _Constant.QH_path_done + _Constant.QH_filename, _Constant.QH_path_ready + _Constant.QH_filename);
// step3 := Header.proc_postHeaderBuilds(build_version).FCRAheader;
step4 := Header.proc_postHeaderBuilds(build_version).booleanSrch;

seq := sequential(
             header._config.setup_build
            ,dlog('KEY BUILD:POST MOVE')
            ,if(status<1,sequential(step1,update_status(1)))
            ,if(status<2,sequential(step2,update_status(2)))
            // ,if(status<3,sequential(step3,update_status(3)))
            ,if(status<4,sequential(step4,update_status(4)))
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 9
            ,if(status<9,update_status(9))
          );
   
if(qh_running
        ,sequential(
          output('Quick Header Build is running, wait until QH completes!'),
          fileservices.sendemail(Header.email_list.BocaDevelopers,workunit + ' - hdr_bld_step5_to_7_MOVE_FCRA_and_BOOLEAN', 'Quick Header Build is running, wait until QH completes!')
          )
        ,seq
  );   

//WorkUnits History
// 20191128 W20200101-195006 W20200101-195006 W20200102-111321
// 20190324 W20190422-081331 & W20190422-103255
// 20181224 W20190120-135405