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
SHARED OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT
														:= ENV<>'DEV' and ENV='PROD' and DR_THOR_STATE=false
														or ENV<>'DEV' and ENV='DR'   and DR_THOR_STATE=true
														;
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
								Bair.Email_Notification_Lists.SchedFailure
								,RESTART_MSG(pMSG)
								,RESTART_MSG(pMSG)
								)
								;

wuname:='Bair Prep Manifest Transfer Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Transfer_Prep_Manifest;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Transfer_Prep_Manifest:=if(d=0,Go,noGo);

wuname:='Bair Base Manifest Transfer Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Transfer_Base_Manifest;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Transfer_Base_Manifest:=if(d=0,Go,noGo);

wuname:='Bair Composite Manifest Transfer Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Transfer_Composite_Manifest;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Transfer_Composite_Manifest:=if(d=0,Go,noGo);

wuname:='Bair Importer Scheduler Batch';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Import_Scheduler_Batch;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Import_Scheduler_Batch:=if(d=0,Go,noGo);

wuname:='Bair Importer Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Import_Scheduler;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Import_Scheduler:=if(d=0,Go,noGo);

wuname:='Bair Importer Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Import_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Import_Controller:=if(d=0,Go,noGo);

wuname:='Bair Importer Cleanup';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Delete_orphan_Inputs;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Delete_orphan_Inputs:=if(d=0,Go,noGo);

wuname:='Housekeeping_controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Housekeeping_controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Housekeeping_controller:=if(d=0,Go,noGo);

wuname:='Bair Build All Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_pload_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_pload_Controller:=if(d=0,Go,noGo);

wuname:='Bair Full Build All Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_pload_full_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_pload_full_Controller:=if(d=0,Go,noGo);

wuname:='Bair Build All Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_Payloads;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_Payloads:=if(d=0,Go,noGo);

wuname:='Bair Boolean Full Build Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_Boolean_Full;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_Boolean_Full:=if(d=0,Go,noGo);

wuname:='Bair Boolean Delta Build Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_Boolean_Delta;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_Boolean_Delta:=if(d=0,Go,noGo);

wuname:='Bair Composite Full Build Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_Comp_Full;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_Comp_Full:=if(d=0,Go,noGo);

wuname:='Bair Full Build All Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_Pload_Full;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_Pload_Full:=if(d=0,Go,noGo);

wuname:='Bair Composite Delta Build Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Build_Comp_Delta;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Build_Comp_Delta:=if(d=0,Go,noGo);

wuname:='Bair Raids Report Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_RAIDS_Report_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_RAIDS_Report_Controller:=if(d=0,Go,noGo);

wuname:='Bair Raids Report Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Send_RAIDS_Report;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Send_RAIDS_Report:=if(d=0,Go,noGo);

wuname:='Bair Backup Base Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_Base_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_Base_Controller:=if(d=0,Go,noGo);

wuname:='Bair Backup Base Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_Base_Scheduler;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_Base_Scheduler:=if(d=0,Go,noGo);

wuname:='Bair Backup Prep Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_Prep_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_Prep_Controller:=if(d=0,Go,noGo);

wuname:='Bair Backup Prep Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_Prep_Scheduler;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_Prep_Scheduler:=if(d=0,Go,noGo);

wuname:='Bair Backup ByPeriod Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_ByPeriod_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_ByPeriod_Controller:=if(d=0,Go,noGo);

wuname:='Bair Backup ByPeriod Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_ByPeriod_Scheduler;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_ByPeriod_Scheduler:=if(d=0,Go,noGo);

wuname:='Bair Backup Composite Controller';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_Composite_Controller;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_Composite_Controller:=if(d=0,Go,noGo);

wuname:='Bair Backup Composite Scheduler';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='Bair._CRON_Backup_Composite_Scheduler;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,Bair._ESP),email(wuname));
EXPORT CRON_Backup_Composite_Scheduler:=if(d=0,Go,noGo);


Go:=sequential(
						 CRON_Import_Scheduler
						,CRON_Delete_orphan_Inputs
						,CRON_Housekeeping_controller
						,CRON_Build_Payloads
						,CRON_Build_Boolean_Delta
						,CRON_Build_Comp_Delta
						,CRON_Build_Comp_Full
						,CRON_Build_Pload_Full
						,CRON_Build_Boolean_Full
						,CRON_Send_RAIDS_Report
						,CRON_Import_Scheduler_Batch
						);
EXPORT Schedules := if(OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT, Go, fail(ERROR_MSG));

Go:=sequential(
						 CRON_Import_Controller
						,CRON_Build_pload_full_Controller
						// ,CRON_Build_pload_Controller
						,CRON_RAIDS_Report_Controller
						);
EXPORT Controllers := if(OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT, Go, fail(ERROR_MSG));

Go:=sequential(
						 Schedules
						 ,Controllers
						);
EXPORT all := if(OK_TO_SCHEDULE_JOBS_IN_THIS_ENVIRONMENT, Go, fail(ERROR_MSG));

Go:=sequential(
						CRON_Transfer_Prep_Manifest
					 ,CRON_Transfer_Base_Manifest
					 ,CRON_Transfer_Composite_Manifest
					 ,CRON_Backup_Base_Controller
					 ,CRON_Backup_Base_Scheduler				
					 ,CRON_Backup_Prep_Controller
					 ,CRON_Backup_Prep_Scheduler		
					 ,CRON_Backup_Composite_Controller
					 ,CRON_Backup_Composite_Scheduler						 
					 ,CRON_Backup_ByPeriod_Controller
					 ,CRON_Backup_ByPeriod_Scheduler			 
						);
EXPORT Backups := if(OK_TO_SCHEDULE_BACKUP_JOBS_IN_THIS_ENVIRONMENT, Go, fail('ERROR - INVALID STATE AND/OR ENVIRONMENT - *** NO ACTION TAKEN ***'));

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