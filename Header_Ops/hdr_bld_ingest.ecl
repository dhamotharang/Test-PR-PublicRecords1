import std,header,dops,wk_ut;
       
operatorEmailList    := Header.email_list.BocaDevelopersEx;
extraNotifyEmailList := '';

setup_ingest := sequential(
            Header.BWR_IngestSetup(operatorEmailList,false),
            Header.Inputs_Set(),
            nothor(Header_ops.fn_SetIKBInput()),
            Header.BWR_IngestSetup(operatorEmailList,true)
            );       

dops_datasetname:='PersonHeaderKeys';
build_component:='PREPROCESS:INGEST';
dlog(string8 build_version) :=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

percent_nbm_change_threshold:=100;

ecl(string build_version) := '\n'
+ '#WORKUNIT(\'protect\',true);\n'
+ '#WORKUNIT(\'name\',\'' + build_version + ' Header Ingest STAT\');\n\n'
+ 'Header.Header_Ingest_Stats_Report(\'' + build_version + '\',' + percent_nbm_change_threshold + ');\n'
;

sf_name(boolean incremental) := Header_Ops._Constant.ingest_build_sf(incremental);
update_status(unsigned2 new_status, string8 build_version, boolean incremental) := Header.LogBuildStatus(sf_name(incremental),build_version,new_status).Write;

EXPORT hdr_bld_ingest(string8 build_version, boolean incremental, unsigned2 status) := sequential(
    if(~incremental, dlog(build_version)),
    if(status<1,sequential(setup_ingest, update_status(1, build_version, incremental))),
    if(status<2,sequential(Header.proc_Header(build_version,operatorEmailList,extraNotifyEmailList).run_ingest(incremental),update_status(2, build_version, incremental))),
    if(status<3,sequential(if(~incremental, Header.REPORT_shifts_over_time_test()), update_status(3, build_version, incremental))),
    if(status<4,sequential(wk_ut.CreateWuid(ECL(build_version),'hthor_eclcc',wk_ut._constants.ProdEsp),update_status(4, build_version, incremental))),
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 9
    if(status<9,update_status(9, build_version, incremental))
    );

