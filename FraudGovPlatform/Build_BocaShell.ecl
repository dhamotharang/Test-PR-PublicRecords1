Import tools, _control, FraudGovPlatform_Validation, STD;
EXPORT Build_BocaShell(	 string version 	) := module

ECLThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

Build_BocaShell_Patch_Ecl := 
 'import tools, FraudGovPlatform, FraudGovPlatform_Validation, STD;\n'
+'#CONSTANT(\'Platform\',\'FraudGov\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'wuname := \'FraudGov BocaShell Copy\';\n'
+'#WORKUNIT(\'protect\', true);\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov BocaShell Copy\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_BocaShell_Patch(\''+version+'\').All\n'
+'	):failure(email(\'FraudGov BocaShell Copy failed\'));\n'
;

	Export All := Sequential(FraudGovPlatform.Build_Base_Pii(version).BocaShell,	
													_Control.fSubmitNewWorkunit(Build_BocaShell_Patch_Ecl,ECLThorName)
													);
													
END;													