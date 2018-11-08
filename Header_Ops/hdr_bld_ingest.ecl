import std,header,dops;

#WORKUNIT('protect',true);
#WORKUNIT('priority','high');
#WORKUNIT('priority',11);
#STORED ('production', false);
#STORED ('_Validate_Year_Range_Low', '1800');
#STORED ('_Validate_Year_Range_high', ((STRING8)Std.Date.Today())[1..4]);
#OPTION ('multiplePersistInstances',FALSE);
#OPTION ('implicitSubSort',FALSE);
#OPTION ('implicitBuildIndexSubSort',FALSE);
#OPTION ('implicitJoinSubSort',FALSE);
#OPTION ('implicitGroupSubSort',FALSE);

today := (STRING8)Std.Date.Today();

file_version(string super) := function        
  sub:=stringlib.stringfind(super, today[1..2],1);
  return super[sub+4..sub+5];        
end;

in_raw         := nothor(fileservices.SuperFileContents('~thor_data400::in::hdr_raw',1)[1].name); // ( thor_data400::in::quickhdr_raw )
monthly_ingest := nothor(fileservices.SuperFileContents('~thor_data400::base::header_raw',1)[1].name);

the_eq_file_for_this_month_is_available := today[5..6] = file_version(in_raw);
the_full_ingest_for_this_month_is_completed := today[5..6] = file_version(monthly_ingest);
isMonthly := the_eq_file_for_this_month_is_available AND not(the_full_ingest_for_this_month_is_completed);

sf_name := '~thor_data400::out::header_ingest_status_' + if(isMonthly, 'mon', 'inc');
ver    := Header.LogBuildStatus(sf_name).Read[1].version;
status := Header.LogBuildStatus(sf_name).Read[1].status;
build_version := if(status <> 0, ver, today); // 0 -> Completed

#stored ('versionBuild', build_version);         
operatorEmailList    := Header.email_list.BocaDevelopersEx;
extraNotifyEmailList := '';

setup_ingest := sequential(
            nothor(Header.BWR_IngestSetup(operatorEmailList,false)),
            Header.Inputs_Set(),
            nothor(Header_ops.fn_SetIKBInput()),
            nothor(Header.BWR_IngestSetup(operatorEmailList,true))
            );       

dops_datasetname:='PersonHeaderKeys';
build_component:='PREPROCESS:INGEST';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

percent_nbm_change_threshold:=100;

EXPORT hdr_bld_ingest := if(isMonthly
                             ,dlog
                             ,sequential(
                               map(status = 0 =>
                                 sequential(
                                   Header.LogBuildStatus(sf_name, build_version, 1).Write // 1 -> Ingest started
                                   ),
                                   status < 2 =>
                                 sequential(
                                   setup_ingest,
                                   Header.LogBuildStatus(sf_name, build_version, 2).Write // 2 -> Ingest Setup Completed
                                   ),
                                   status < 3 =>
                                 sequential(
                                   Header.proc_Header(operatorEmailList,extraNotifyEmailList).run_ingest(isMonthly, build_version),
                                   Header.LogBuildStatus(sf_name, build_version, 3).Write // 3 -> Ingest Run Completed
                                   ),
                                   status < 4 =>
                                 sequential(
                                   nothor(Header.Header_Ingest_Stats_Report(build_version, percent_nbm_change_threshold)),
                                   Header.LogBuildStatus(sf_name, build_version, 0).Write  // 0 -> Ingest Build Completed
                                   )
                               )
                             )
                          );
            