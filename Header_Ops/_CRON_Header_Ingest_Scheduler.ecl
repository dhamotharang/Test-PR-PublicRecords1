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
#WORKUNIT('name', 'Header Ingest Scheduler');
			
ECL0:=  
'// Header_ops._CRON_Header_Ingest_Scheduler\n\n'
+'// scheduler job name -> Header Ingest Scheduler\n\n'
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
wuname := '*Header Ingest';
valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
active_workunit :=  exists(d);
run_build          := if(active_workunit, 'false', 'true');

ECL := ECL0
     + if(run_build='true'
	,'Header_Ops.hdr_bld_ingest;\n'
//ELSE
	,'wuname := \'Header Ingest is RUNNING Right now, Please try to run once the current build completes\';\n'
	+'#WORKUNIT(\'name\', wuname);\n'
	);

THOR := if (active_workunit,'hthor','thor400_44');
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
wk_ut.CreateWuid(ECL,THOR,wk_ut._constants.ProdEsp) : when('Header Ingest Scheduler')
                            ,FAILURE(fileservices.sendemail(Header.email_list.BocaDevelopersEx
                                ,'*** ALERT **** Header Ingest Scheduler Failure'
                                ,NOC_MSG
                            ));
