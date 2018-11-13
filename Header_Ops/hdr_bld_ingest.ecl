import std,header,dops;
       
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

sf_name(boolean isMonthly) := '~thor_data400::out::header_ingest_status_' + if(isMonthly, 'mon', 'inc');

EXPORT hdr_bld_ingest(string8 build_version, boolean isMonthly, unsigned2 status) := sequential(
                               if(isMonthly, dlog(build_version))
                              ,if(status = 0,
                                 sequential(
                                   Header.LogBuildStatus(sf_name(isMonthly), build_version, 1).Write // 1 -> Ingest started
                                   )
                                 )
                               ,if(status < 2,
                                 sequential(
                                   setup_ingest,
                                   Header.LogBuildStatus(sf_name(isMonthly), build_version, 2).Write // 2 -> Ingest Setup Completed
                                   )
                                 )
                               ,if(status < 3,
                                 sequential(
                                   Header.proc_Header(operatorEmailList,extraNotifyEmailList).run_ingest(isMonthly, build_version),
                                   Header.LogBuildStatus(sf_name(isMonthly), build_version, 3).Write // 3 -> Ingest Run Completed
                                   )
                                 )
                               ,if(status < 4,
                                 sequential(
                                   Header.Header_Ingest_Stats_Report(build_version, percent_nbm_change_threshold),
                                   Header.LogBuildStatus(sf_name(isMonthly), build_version, 0).Write  // 0 -> Ingest Build Completed
                                   )
                                 )
                             );
            