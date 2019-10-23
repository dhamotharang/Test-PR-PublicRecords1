import wk_ut,_Control,Data_services,PromoteSupers;

EXPORT _CRON_Master_Controller := MODULE

SHARED THOR:='hthor';
SHARED valid_state := ['blocked','compiled','submitted','running','wait'];

dummy:='';
SHARED noGo:=sequential(dummy);

SHARED ENV:=CASE(_Control.ThisEnvironment.ThisDaliIp
								,_Control.IPAddress.bair_dataland_dali => 'DEV'
								,_Control.IPAddress.bair_prod_dali1    => 'PROD'
								,_Control.IPAddress.bair_DR_dali1      => 'DR'
								,''
								);

SHARED SF:='thor_data::flag::dr_state';
SHARED DR_STATE_rec :={boolean THOR_IN_DR_STATE,boolean LZ_IN_DR_STATE};
SHARED DR_STATE_FLAG := DATASET(Data_services.foreign_bair_DR+SF,DR_STATE_rec,flat)[1];
SHARED DR_THOR_STATE := DR_STATE_FLAG.THOR_IN_DR_STATE;
SHARED OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT := TRUE;
														// := ENV<>'DEV' and ENV='PROD' and DR_THOR_STATE=false
														// or ENV<>'DEV' and ENV='DR'   and DR_THOR_STATE=true
														// ;
SHARED OK_TO_SCHEDULE_BACKUP_JOBS_IN_THIS_ENVIRONMENT
														:= ENV<>'DEV' and ENV='PROD' and DR_THOR_STATE=true
														or ENV<>'DEV' and ENV='DR'   and DR_THOR_STATE=false
														;
SHARED ERROR_MSG
	:=
	map(
			 ENV='DEV'                     => 'ERROR - THIS IS A DEV ENVIRONMENT - *** NO ACTION TAKEN ***'
			,DR_THOR_STATE=true  and ENV='PROD' => 'ERROR - PRODUCTION SYSTEM IS IN A FAILOVER STATE - *** NO ACTION TAKEN ***'
			,DR_THOR_STATE=false and ENV='DR  ' => 'ERROR - PRODUCTION SYSTEM IS NOT IN A FAILOVER STATE - *** NO ACTION TAKEN ***'
			,'ERROR - INVALID STATE AND/OR ENVIRONMENT - *** NO ACTION TAKEN ***'
			);
SHARED RESTART_MSG(string pMSG):='Restated '+pMSG+' in '+ENV;
SHARED EMAIL(string pMSG) :=
						fileservices.sendemail(
								INQL_v2.email_notification_lists.BuildFailure
								,RESTART_MSG(pMSG)
								,RESTART_MSG(pMSG)
								)
								;

wuname:=INQL_v2._Constants.FCRA_DAILY_BLD_CONTROLLERNAME;
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_FCRA_Daily_Controller';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_DAILY_BLD_CONTROLLER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_DAILY_BLD_CONTROLLERNAME;
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_NonFCRA_Daily_Controller';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.NON_FCRA_ESP),email(wuname));
EXPORT NON_FCRA_DAILY_BLD_CONTROLLER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.FCRA_WEEKLY_BLD_CONTROLLERNAME;
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_FCRA_Weekly_Controller';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_WEEKLY_BLD_CONTROLLER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_WEEKLY_BLD_CONTROLLERNAME;
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_NonFCRA_Weekly_Controller';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.NON_FCRA_ESP),email(wuname));
EXPORT NON_FCRA_WEEKLY_BLD_CONTROLLER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.FCRA_SPRAY_SCHEDULERNAME;
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_SPRAY_FCRA_Scheduler';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_SPRAY_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME;
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_SPRAY_NONFCRA_Scheduler';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.NON_FCRA_ESP),email(wuname));
EXPORT NON_FCRA_SPRAY_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_FCRA_Daily_Base';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_DAILY_BLD_BASE_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_FCRA_Daily_Keys';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_DAILY_BLD_KEYS_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_NonFCRA_Daily_Base';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.NON_FCRA_ESP),email(wuname));
EXPORT NON_FCRA_DAILY_BLD_BASE_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_NonFCRA_Daily_Keys';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.NON_FCRA_ESP),email(wuname));
EXPORT NON_FCRA_DAILY_BLD_KEYS_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.FCRA_WEEKLY_BLD_SCHEDULERNAME + ' BASE SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_FCRA_Weekly_Base';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_WEEKLY_BLD_BASE_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.FCRA_WEEKLY_BLD_SCHEDULERNAME + ' KEYS SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_FCRA_Weekly_Keys';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT FCRA_WEEKLY_BLD_KEYS_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_WEEKLY_BLD_SCHEDULERNAME + ' BASE SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_NonFCRA_Weekly_Base';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.FCRA_ESP),email(wuname));
EXPORT NON_FCRA_WEEKLY_BLD_BASE_SCHEDULER:=if(d=0,Go,noGo);

wuname:=INQL_v2._Constants.NON_FCRA_WEEKLY_BLD_SCHEDULERNAME + ' KEYS SCHEDULER';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='INQL_v2._CRON_Build_NonFCRA_Weekly_Keys';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.NON_FCRA_ESP),email(wuname));
EXPORT NON_FCRA_WEEKLY_BLD_KEYS_SCHEDULER:=if(d=0,Go,noGo);

Go:=sequential(
						 FCRA_SPRAY_SCHEDULER
						,NON_FCRA_SPRAY_SCHEDULER
						,FCRA_DAILY_BLD_BASE_SCHEDULER
						,FCRA_DAILY_BLD_KEYS_SCHEDULER
						,NON_FCRA_DAILY_BLD_BASE_SCHEDULER
						,NON_FCRA_DAILY_BLD_KEYS_SCHEDULER
						,FCRA_WEEKLY_BLD_BASE_SCHEDULER
						,FCRA_WEEKLY_BLD_KEYS_SCHEDULER
						,NON_FCRA_WEEKLY_BLD_BASE_SCHEDULER
						,NON_FCRA_WEEKLY_BLD_KEYS_SCHEDULER
						);
						
EXPORT Schedules := if(OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT, Go, fail(ERROR_MSG));

Go:=sequential(
						 FCRA_DAILY_BLD_CONTROLLER
						,NON_FCRA_DAILY_BLD_CONTROLLER
						,FCRA_WEEKLY_BLD_CONTROLLER
						,NON_FCRA_WEEKLY_BLD_CONTROLLER
						);
						
EXPORT Controllers := if(OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT, Go, fail(ERROR_MSG));

Go:=sequential(
						 Schedules
						 ,Controllers
						);
EXPORT all := if(OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT, Go, fail(ERROR_MSG));

EXPORT fnSetThorDRstate(boolean pDR_state=false) := function
	d:=dataset([{pDR_state,DR_STATE_FLAG.LZ_IN_DR_STATE}],DR_STATE_rec);
	PromoteSupers.MAC_SF_BuildProcess(d	,'~'+SF	,go	,3,	,true);
	return if(ENV='DR', Go, fail('ERROR - FLAG MAY ONLY EXIST IN DR ENVIRONMENT - *** NO ACTION TAKEN ***'));
END;

EXPORT fnSetLzDRstate(boolean pDR_state=false) := function
	d:=dataset([{DR_STATE_FLAG.THOR_IN_DR_STATE,pDR_state}],DR_STATE_rec);
	PromoteSupers.MAC_SF_BuildProcess(d	,'~'+SF	,go	,3,	,true);
	return if(ENV='DR', Go, fail('ERROR - FLAG MAY ONLY EXIST IN DR ENVIRONMENT - *** NO ACTION TAKEN ***'));
END;

EXPORT isLZinDR := DR_STATE_FLAG.LZ_IN_DR_STATE;;

END;