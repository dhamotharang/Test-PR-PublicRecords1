import ut,header,dops;
build_version:= header.version_build;

dops_datasetname:=header._info.dops_datasetname;

dlog(string bld_cmp_nm):=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,bld_cmp_nm);

sf_name := '~thor_data400::out::header_xadl_to_keys_status';
emailList:='Debendra.Kumar@lexisnexisrisk.com;gabriel.marcan@lexisnexisrisk.com';

status := Header.LogBuildStatus(sf_name, build_version).GetLatestVersionCompletedStatus:INDEPENDENT;

update_status(unsigned2 new_status) := Header.LogBuildStatus(sf_name,build_version,new_status).Write;

// 3_2 xadl
step1:=Header.proc_postHeaderBuilds().XADLkeys;
// 4_0 hhid
step2:=Header.proc_postHeaderBuilds().hhid;
// 4_01 update supression list
step3:=Header.Suppressions.BuildNewReferenceKey(header.version_build,emailList);
// 4_1 header_keys
step4:=Header.proc_postHeaderBuilds().headerKeys;
// 8_6
// step5:=Header.Suppressions.BuildNewReferenceKey(filedate,emailList);
sequential(
            header._config.setup_build,
            dlog('KEY BUILD:XADL TO KEYS'),
            if(status<1,sequential(step1,update_status(1))),
            if(status<2,sequential(step2,update_status(2))),
            if(status<3,sequential(step3,update_status(3))),
            if(status<4,sequential(step4,update_status(4))),
            // if(status<5,sequential(step5,update_status(5))),
          );
          
//WorkUnits History
// 20181224 W20190120-135405