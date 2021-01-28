import wk_ut,_Control,Data_services,PromoteSupers;
import _control,FraudGovPlatform_Validation;
EXPORT _CRON_Master_Controller := MODULE

SHARED THOR:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',	FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);

SHARED valid_state := ['blocked','compiled','submitted','running','wait'];

dummy:='';
SHARED noGo:=sequential(dummy);

SHARED ENV:='PROD';
SHARED ESP:=_Control.IPAddress.prod_thor_esp;
SHARED RESTART_MSG(string pMSG):='Restated '+pMSG+' in '+ENV;
SHARED EMAIL(string pMSG) :=
						fileservices.sendemail(
								FraudGovPlatform.Email_Notification_Lists().BuildFailure
								,RESTART_MSG(pMSG)
								,RESTART_MSG(pMSG)
								)
								;

//EVERY 10 MINUTES 8AM/5PM
wuname:='FraudGov Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_InputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_InputPrepSchedule:=if(d=0,Go,noGo);

//9AM
wuname:='FraudGov MBS Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_MBSInputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_MBSInputPrepSchedule:=if(d=0,Go,noGo);

//10AM
wuname:='FraudGov Deltabase Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_DeltabaseInputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_DeltabaseInputPrepSchedule:=if(d=0,Go,noGo);

//10AM
wuname:='FraudGov InquiryLogs Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_InquiryLogsInputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_InquiryLogsInputPrepSchedule:=if(d=0,Go,noGo);

//10AM
wuname:='FraudGov RDP Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_RDPInputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_RDPInputPrepSchedule:=if(d=0,Go,noGo);

//10AM
wuname:='FraudGov NAC Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_NACInputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_NACInputPrepSchedule:=if(d=0,Go,noGo);

//10AM
wuname:='FraudGov DEDI Input Prep Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform_Validation._CRON_DEDIInputPrepSchedule;';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_DEDIInputPrepSchedule:=if(d=0,Go,noGo);

//1AM
wuname:='FraudGov Build Base Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform._CRON_Base_Schedule';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_Base_Schedule:=if(d=0,Go,noGo);

//Every 1 Hour
wuname:='FraudGov Prod Dashboards Refresh Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform._CRON_Refresh_PROD_Dashboards';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_ProdDashboards_Schedule:=if(d=0,Go,noGo);

//Every 9 minutes
wuname:='FraudGov Prod Dashboards Version Refresh Schedule';
d:=count(WorkunitServices.WorkunitList('',jobname:=wuname)(state in valid_state));
ECL:='FraudGovPlatform._CRON_Refresh_ProdDashVersion';
Go:=sequential(wk_ut.CreateWuid(ECL,THOR,ESP),email(wuname));
EXPORT CRON_ProdDashboardVersion_Schedule:=if(d=0,Go,noGo);


Go:=sequential(
						 CRON_DeltabaseInputPrepSchedule
						,CRON_InputPrepSchedule
						,CRON_InquiryLogsInputPrepSchedule
						,CRON_RDPInputPrepSchedule
						,CRON_MBSInputPrepSchedule
						,CRON_NACInputPrepSchedule
						,CRON_DEDIInputPrepSchedule
						,CRON_Base_Schedule
						,CRON_ProdDashboards_Schedule
						,CRON_ProdDashboardVersion_Schedule
);

EXPORT all := Go;

END;