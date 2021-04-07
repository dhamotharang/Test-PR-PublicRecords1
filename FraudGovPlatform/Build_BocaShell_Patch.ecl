Import tools, _control, FraudGovPlatform_Validation, STD;
EXPORT Build_BocaShell_Patch(	 string version 	) := module

shared ECLThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

shared Build_Kel_Ecl := 
 'import tools, FraudGovPlatform, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;\n'
+'#CONSTANT(\'RunKelDemo\',false);\n'
+'#CONSTANT(\'Platform\',\'FraudGov\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'defaultSkewError\', 1);\n'
+'#OPTION(\'resourceMaxHeavy\', 2);\n'
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

//move bocashell file to thor400														
Shell_in := distribute((FraudGovPlatform.files().base.BocaShell.built
											+FraudGovPlatform.files().base.BocaShell.qa),hash(record_id));	

tools.mac_WriteFile(Filenames(version+'_patch').Base.BocaShell.New,Shell_in,Build_BocaShell_Copy);

BocaShell_patch :=
								Sequential( 
										 Build_BocaShell_Copy
										,Promote(version).buildfiles.Built2QA
										,STD.File.StartSuperFileTransaction()
										,FileServices.clearsuperfile(FraudGovplatform.Filenames().Base.BocaShell.qa)
										,FileServices.clearsuperfile(FraudGovplatform.Filenames().Base.BocaShell.Built, true)
										,FileServices.AddSuperfile(FraudGovplatform.Filenames().Base.BocaShell.Built,FraudGovplatform.Filenames(version+'_Patch').Base.BocaShell.New)
										,FileServices.AddSuperfile(FraudGovplatform.Filenames().Base.BocaShell.QA,FraudGovplatform.Filenames(version+'_Patch').Base.BocaShell.New)
										,STD.File.FinishSuperFileTransaction()
													);


Export All := Sequential(BocaShell_patch,	
													_Control.fSubmitNewWorkunit(Build_Kel_Ecl,ECLThorName) 
													);
													
END;													