﻿import _Control,Std,FraudGovPlatform_Validation;

ThorName	:=		IF(_control.ThisEnvironment.Name	<> 'Prod_Thor',		Constants.ThorName_Dev,	Constants.ThorName_Prod);

lECL1 :=
 'import ut;\n'
+'wuname := \'FraudGov PII SOAP Appends\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#Constant(\'Platform\',\'FraudGov\');\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'sesha.nookala@lexisnexis.com\'\n'
+' 	 ,\'FraudGov PII SOAP Appends\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'submitted\',\'compiling\',\'compiled\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'base	:= fileservices.superfilecontents(\'~thor_data400::base::fraudgov::built::main_orig\');\n'
+'version	:= Std.Str.SplitWords(base[1].name,\'::\')[4];\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_Base_Pii(version).All\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov PII SOAP Appends Controller');

_Control.fSubmitNewWorkunit(lECL1, ThorName )	: WHEN('Build_FraudGov_PII_SOAP_Appends')
																								,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																								,'FraudGov PII SOAP Appends Controller failure'
																								,FraudGovPlatform_Validation.Constants.NOC_MSG
																								));
																			
																
