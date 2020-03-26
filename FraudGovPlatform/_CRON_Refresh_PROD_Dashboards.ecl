import _Control,STD,Dops,FraudGovPlatform_Validation,FraudGovPlatform;

every_hour := '0 0-23 * * *';

ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);

ECL :=
 'import ut;\n'
+'wuname := \'FraudGov Prod Dashboards Refresh\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Analytics\n'
+' 	 ,\'FraudGov Prod Dashboards Refresh\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,Sequential(FraudGovPlatform.GenerateProdDashboards\n'
+'		,email(\'RIN Production Dashboards Refresh Started \'))\n'
+'	);\n'
;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Prod Dashboards Refresh Schedule');

RIN_CERT_Version:= Dops.GetBuildVersion('FraudGovKeys','B','N','C');
RIN_PROD_Version:= Dops.GetBuildVersion('FraudGovKeys','B','N','P');
Superfilename :=FraudGovPlatform.FileNames().ProdDashboardVersion;
fname := std.file.SuperFileContents(Superfilename)[1].name;
Dashboard_Build_version := Std.Str.SplitWords(fname,'::')[5];

valid_state := ['blocked','compiled','submitted','running','wait','compiling'];
CustomerDash_WU						:=	FraudGovPlatform.files().CustomerDashboard.response[1].workunitid;
CustomerDashboard1_1_WU		:=	FraudGovPlatform.files().CustomerDashboard1_1.response[1].workunitid;
ClusterDetails_WU					:=	FraudGovPlatform.files().ClusterDetails.response[1].workunitid;

CustomerDash_WUState					:=	FraudGovPlatform.fn_Getwuinfo(CustomerDash_wu,'ramps_prod_esp.risk.regn.net')[1].state;
CustomerDashboard1_1_WUState	:=	FraudGovPlatform.fn_Getwuinfo(CustomerDashboard1_1_WU,'ramps_prod_esp.risk.regn.net')[1].state;
ClusterDetails_WUState				:=	FraudGovPlatform.fn_Getwuinfo(ClusterDetails_wu,'ramps_prod_esp.risk.regn.net')[1].state;

Active_RampsWU := If(CustomerDash_WUState in valid_state or ClusterDetails_WUState in valid_state or CustomerDashboard1_1_WUState in valid_state,true,false);

RunJob := If(RIN_CERT_Version=RIN_PROD_Version and RIN_CERT_Version <> Dashboard_Build_version and ~Active_RampsWU,true,false);
Run_ECL := if(RunJob=true,ECL, 'output(\'Refresh Prod Dashboards Skipped\');\n' );

_Control.fSubmitNewWorkunit(Run_ECL,ThorName):WHEN(CRON(every_hour))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
			,'FraudGov Prod Dashboards Refresh Schedule failure'
			,FraudGovPlatform_Validation.Constants.NOC_MSG
			));