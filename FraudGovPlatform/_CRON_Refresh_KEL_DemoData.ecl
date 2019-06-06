import _Control,STD,FraudGovPlatform_Validation;

Every_SAT_AT_1AM := '0 5 * * 6';

ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

ECL :=
 'import ut,FraudGovPlatform;\n'
+'wuname := \'FraudGov KEL DemoData Refresh\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#CONSTANT(\'Platform\',\'FraudGov\');\n'
+'#CONSTANT(\'RunKelDemo\',true);\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'defaultSkewError\', 1);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov KEL DemoData Refresh\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'pVersion := ut.GetDate : independent;\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,sequential( FraudGovPlatform.Build_Keys(pVersion).Demo_All\n'
+'											,FraudGovPlatform.Build_Base_Kel(pVersion).Demo_All\n'
+'											,FraudGovPlatform.Promote(pversion).buildfiles.New2Built\n'
+'											,FraudGovPlatform.Promote(pversion).buildfiles.Built2QA\n'
+'										)\n'
+'	);\n'
;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov KEL DamoData Refresh Schedule');

_Control.fSubmitNewWorkunit(ECL,ThorName):WHEN(CRON(Every_SAT_AT_1AM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
			,'FraudGov KEL DamoData Refresh Schedule failure'
			,FraudGovPlatform_Validation.Constants.NOC_MSG
			));