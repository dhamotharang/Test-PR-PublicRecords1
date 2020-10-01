import std,header,dops,wk_ut;

EXPORT hdr_bld_ingest(string8 build_version, boolean incremental) := MODULE
         
operatorEmailList := Header.email_list.BocaDevelopersEx;

bldtype := '_' + if(incremental,'inc','mon');
ingest_status_fn := 'headeringest'+bldtype;

setup_ingest := sequential(
            Header.mac_runIfNotCompleted (ingest_status_fn, build_version, Header.BWR_IngestSetup(operatorEmailList,false),10),
            Header.mac_runIfNotCompleted (ingest_status_fn, build_version, Header.Inputs_Set(),20),
            Header.mac_runIfNotCompleted (ingest_status_fn, build_version, nothor(Header_ops.fn_SetIKBInput()),30),
            Header.mac_runIfNotCompleted (ingest_status_fn, build_version, Header.BWR_IngestSetup(operatorEmailList,true),40),
            );       

dops_datasetname:='PersonHeaderKeys';
build_component:='PREPROCESS:INGEST';
dlog :=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

percent_nbm_change_threshold:=100;

ecl := '\n'
+ '#WORKUNIT(\'protect\',true);\n'
+ '#WORKUNIT(\'name\',\'' + build_version + ' Header Ingest STAT\');\n\n'
+ 'Header.Header_Ingest_Stats_Report(\'' + build_version + '\',' + percent_nbm_change_threshold + ');\n'
;

step1 := setup_ingest;
step2 := Header.proc_header_ingest(incremental,build_version).run;
step3 := if(~incremental, Header.REPORT_shifts_over_time_test());
step4 := wk_ut.CreateWuid(ECL,'hthor_eclcc',wk_ut._constants.ProdEsp);
step5 := output('Header Ingest completed');

 EXPORT seq := sequential(
    if(~incremental, dlog),
    Header.mac_runIfNotCompleted (ingest_status_fn,build_version, step1,100),
    Header.mac_runIfNotCompleted (ingest_status_fn,build_version, step2,200),
    Header.mac_runIfNotCompleted (ingest_status_fn,build_version, step3,300),
    Header.mac_runIfNotCompleted (ingest_status_fn,build_version, step4,400),
//In order to keep consistency across all builds and 
//reserving status to add future steps, the end status is set as 900    
    Header.mac_runIfNotCompleted (ingest_status_fn,build_version, step5,900)
    );

END;