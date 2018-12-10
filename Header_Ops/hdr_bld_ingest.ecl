﻿import std,header,dops,wk_ut;
       
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

sf_name(boolean incremental) := '~thor_data400::out::header_ingest_status_' + if(incremental, 'inc', 'mon');

ecl(string build_version) := '#WORKUNIT(\'name\',\'' + build_version + ' Header Ingest STAT\');\n\n'
+ 'Header.Header_Ingest_Stats_Report(\'' + build_version + '\',' + percent_nbm_change_threshold + ');';

EXPORT hdr_bld_ingest(string8 build_version, boolean incremental, unsigned2 status) := sequential(
                               if(~incremental, dlog(build_version))
                              ,if(status = 0,
                                 sequential(
                                   Header.LogBuildStatus(sf_name(incremental), build_version, 1).Write // 1 -> Ingest started
                                   )
                                 )
                               ,if(status < 2,
                                 sequential(
                                   setup_ingest,
                                   Header.LogBuildStatus(sf_name(incremental), build_version, 2).Write // 2 -> Ingest Setup Completed
                                   )
                                 )
                               ,if(status < 3,
                                 sequential(
                                   Header.proc_Header(operatorEmailList,extraNotifyEmailList).run_ingest(incremental, build_version),
                                   Header.LogBuildStatus(sf_name(incremental), build_version, 0).Write, // 3 -> Ingest Run Completed
                                   wk_ut.CreateWuid(ECL(build_version),'hthor_eclcc',wk_ut._constants.ProdEsp)
                                   )
                                 )
                             );
            