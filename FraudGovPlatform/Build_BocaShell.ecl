﻿Import tools, _control, FraudGovPlatform_Validation, STD;
EXPORT Build_BocaShell(	 string version 	) := module

ECLThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

Build_Kel_Ecl := 
 'import tools, FraudGovPlatform, FraudShared, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;\n'
+'#CONSTANT(\'RunKelDemo\',false);\n'
+'#CONSTANT(\'Platform\',\'FraudGov\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'defaultSkewError\', 1);\n'
+'wuname := \'FraudGov Kel Build\';\n'
+'#WORKUNIT(\'protect\', true);\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Kel Build\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_Kel(\''+version+'\').All\n'
+'	):failure(email(\'FraudGov Kel Build failed\'));\n'
;

	Export All := Sequential(FraudGovPlatform.Build_Base_Pii(version).BocaShell,	
													_Control.fSubmitNewWorkunit(Build_Kel_Ecl,ECLThorName)
													);
													
END;													