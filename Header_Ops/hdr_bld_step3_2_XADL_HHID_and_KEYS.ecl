import _control,header,dops, std;

/*
Directly set the version(yyyymmdd) here instead of calling version_build
to get rid of any confusion of what is in version_build
*/
build_version := header.version_build; //'20191023'
#stored ('version', build_version);
#stored ('buildname', 'PersonHeader');

wuname:= build_version + ' Header, slimsorts, and relative Keys';
#WORKUNIT('name', wuname);

dops_datasetname:=header._info.dops_datasetname;
dlog(string bld_cmp_nm):=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,bld_cmp_nm);

sf_name := '~thor_data400::out::header_xadl_to_keys_status';
emailList:='Debendra.Kumar@lexisnexisrisk.com;gabriel.marcan@lexisnexisrisk.com';

status := Header.LogBuildStatus(sf_name, build_version).GetLatestVersionCompletedStatus:INDEPENDENT;
update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;

// 3_2 xadl
step1:=Header.proc_postHeaderBuilds(build_version).XADLkeys;
// 4_0 hhid
step2:=Header.proc_postHeaderBuilds(build_version).hhid;
// 4_01 update supression list
step3:=Header.Suppressions.BuildNewReferenceKey(header.version_build,emailList);
// 4_1 header_keys
step4:=Header.proc_postHeaderBuilds(build_version).headerKeys;
// Turning ON the flag for Quick Header Build to wait for the Header Move
step5:= STD.File.MoveExternalFile(_control.IPAddress.bctlpedata10, _Constant.QH_path_ready + _Constant.QH_filename, _Constant.QH_path_done + _Constant.QH_filename);

sequential(
            header._config.setup_build,
            dlog('KEY BUILD:XADL TO KEYS'),
            if(status<1,sequential(step1,update_status(1))),
            if(status<2,sequential(step2,update_status(2))),
            if(status<3,sequential(step3,update_status(3))),
            if(status<4,sequential(step4,update_status(4))),
            if(status<5,sequential(step5,update_status(5)))
          );
          
//WorkUnits History
// 20191023 W20191120-084316 W20191122-102546 W20191124-113755
// 20190818 W20190909-090401 W20190912-202542 W20190913-150408
// 20190722 W20190824-163636
// 20181224 W20190120-135405