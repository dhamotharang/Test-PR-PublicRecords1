// Header_ops._CRON_Header_Boolean_Scheduler
// scheduler job name -> Header Boolean Scheduler

// ON_NOTIFY: Build_Header_Boolean
	// 1 - Move  Keys
	// 2 - Build FCRA keys
	// 3 - Build Boolean Keys
    // Expected execution time -> Estimated around 16 hrs

import ut,wk_ut,_control,STD, header;
#WORKUNIT('name', 'PersonHeader: Build_Header_Boolean');

build_version:= header.version_build;

valid_state := ['blocked','running','wait','submitted','compiling','compiled'];
ikb_wuname 	:= '*MOVE, FCRA and BOOLEAN*';

wks := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=ikb_wuname))(wuid <> thorlib.wuid() and state in valid_state)
		 ,-wuid);

active_wk :=  exists(wks);
sf_name := '~thor_data400::out::header_post_move_status';

ver    := Header.LogBuildStatus(sf_name).GetLatest.versionName;
status := Header.LogBuildStatus(sf_name).GetLatest.versionStatus;

bldversion := if(status <> 0, ver, build_version); // 0 -> Completed

norun := if(build_version = ver and status = 0, true, false);
wuname1 := bldversion + ' MOVE, FCRA and BOOLEAN - Running Right Now';
wuname2 := bldversion + ' MOVE, FCRA and BOOLEAN - Data Was Already Built';
wuname3 := bldversion + if(status <> 0, ' RECOVER - MOVE, FCRA and BOOLEAN', ' MOVE, FCRA and BOOLEAN');

ECL1 := '\n'
+'#WORKUNIT(\'name\',\'' + wuname1 + '\');\n'
;

ECL2 := '\n'
+'#WORKUNIT(\'name\',\'' + wuname2 + '\');\n'
;

ECL3 := '\n'
+'#WORKUNIT(\'name\',\'' + wuname3 + '\');\n'
+'Header_Ops.hdr_bld_step5_to_7_MOVE_FCRA_and_BOOLEAN(\'' + bldversion + '\',' + status + ');\n\n'
;

ECL := if(active_wk
          ,ECL1
          ,if(norun, ECL2, ECL3)
         );

THOR := 'thor400_44_eclcc';

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
wk_ut.CreateWuid(ECL,THOR,wk_ut._constants.ProdEsp) : when('Build_Header_Boolean')
                            ,FAILURE(fileservices.sendemail(Header.email_list.BocaDevelopersEx
                                ,'*** ALERT **** Header Boolean Scheduler Failure'
                                ,NOC_MSG
                            ));