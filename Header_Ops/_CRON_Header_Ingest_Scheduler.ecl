// Header_ops._CRON_Header_Ingest_Scheduler
// scheduler job name -> Header Ingest Scheduler
// ON_NOTIFY: Header_Ops.hdr_bld_ingest
	// Determine the status of the last ingest build
	// Determine the ingest type(monthly/incremental)
	// Setup Ingest - logs and move the input files in correct suuperfiles 
    // Run Ingest - create new raw header, src keys and blank file 
    // Create and email Header Stat summary report
// Expected execution time -> Estimated 24-48 hrs
	
import ut,wk_ut,_control,STD, header;
#WORKUNIT('name', 'PersonHeader: Build_Header_Ingest');
			
ECL0:=  
'// Header_ops._CRON_Header_Ingest_Scheduler\n\n'
+'// scheduler job name -> PersonHeader: Build_Header_Ingest\n\n'
+'// ON_NOTIFY: Header_Ops.hdr_bld_ingest\n\n'
+'// ACTIONS:\n'
+'// -------------\n'
+'//          1)Determine the status of the last ingest build\n'
+'//          2)Determine the ingest type(monthly/incremental)\n'
+'//          3)Setup Ingest - logs and move the input files in correct suuperfiles\n'
+'//          4)Run Ingest - create new raw header, src keys and blank file\n'
+'//          5)Create and email Header Stat summary report\n\n'
+'// Expected execution time -> Estimated 24-48 hrs\n'	
+'\n'
;
wuname := '*Header Ingest*';
valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
active_workunit :=  exists(d);
run_build          := if(active_workunit, 'false', 'true');

today := (STRING8)Std.Date.Today() : independent;

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

incremental := if(isMonthly, 'false', 'true');
ingestType := if(isMonthly, 'monthly', 'incremental');

ECL1 := '\n'
+'#WORKUNIT(\'protect\',true);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'#STORED (\'production\', false);\n'
+'#STORED (\'_Validate_Year_Range_Low\', \'1800\');\n'
+'#STORED (\'_Validate_Year_Range_high\', ((STRING8)Std.Date.Today())[1..4]);\n'
+'#OPTION (\'multiplePersistInstances\',FALSE);\n'
+'#OPTION (\'implicitSubSort\',FALSE);\n'
+'#OPTION (\'implicitBuildIndexSubSort\',FALSE);\n'
+'#OPTION (\'implicitJoinSubSort\',FALSE);\n'
+'#OPTION (\'implicitGroupSubSort\',FALSE);\n\n'

+'#stored (\'versionBuild\',\''+ build_version + '\');\n'
+'#WORKUNIT(\'name\',\'' + build_version + ' Header Ingest ' + ingestType + if(status <> 0, ' RECOVER ', '') + '\');\n\n'

+'Header_Ops.hdr_bld_ingest(\'' + build_version + '\',' + incremental + ', ' + status + ');\n';

ECL := ECL0
     + if(run_build='true'
         ,ECL1
	     ,'wuname := \'Header Ingest is RUNNING Right now\';\n'
	       + '#WORKUNIT(\'name\', wuname);\n'
	 );

THOR := if (active_workunit,'hthor_eclcc','thor400_44_eclcc');

NOC_MSG
	:=
	'** NOC **\n\n'
    
	+'Please investigate cause of failure of workunit '+workunit+' linked\n'
	+'above in Boca Prod THOR.  Then please resubmit it to ensure process\n'
	+'is running.\n\n'

	+'If the error message includes mention of "SOAP RPC error" or similar, this has historically\n'
	+'meant one or more Prod Thor ESP services require a bounce.\n\n'

	+'If this failure has occurred during the maintenance window, it is possibly related to network\n'
	+'or other updates/changes. Please resubmit knowing it is possible that it may fail again if\n'
	+'maintenance is ongoing.  In that case, you may delay resubmission temporarily,\n'
	+'but please do not forget.\n\n'

	+'If issues persist/repeat outside the Sunday maintenance window,\n'
	+'please contact ' + Header.email_list.BocaDevelopersEx + '.\n'
	;
    
#WORKUNIT('protect',true);
wk_ut.CreateWuid(ECL,THOR,wk_ut._constants.ProdEsp) : when('Build_Header_Ingest')
                            ,FAILURE(fileservices.sendemail(Header.email_list.BocaDevelopersEx
                                ,'*** ALERT **** Header Ingest Scheduler Failure'
                                ,NOC_MSG
                            ));
