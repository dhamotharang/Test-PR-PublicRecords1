/**************************************************************************************************************************************************/
/* PROJECT: RISK INTELLIGENCE NETWORK - AKA: RIN, OTTO, FraudGov
/* DOCUMENTATION: https://confluence.rsi.lexisnexis.com/display/GTG/OTTO+-+Data+Build
/* AUTHORS: DATA ENGINEERING (SESHA NOOKALA, OSCAR BARRIENTOS)
/**************************************************************************************************************************************************/
import tools, FraudGovPlatform_Validation, STD,_control;

export Build_All(
	 string version 	
) :=
module

ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);
ECLThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

Build_Kel_Ecl := 
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
	export build_all := sequential(
		FraudGovPlatform.Health_CheckUp(version).ALL,
		FraudGovPlatform.Build_Input(version).ALL,
		FraudGovPlatform.Build_Base(version).ALL,
		FraudGovPlatform.Build_Base_UnitTests(version).ALL,
		FraudGovPlatform.Promote(version).promote_base,
		FraudGovPlatform.promote(version).promote_sprayed_files,
		FraudGovPlatform.Build_Base_Pii(version).All,
		_Control.fSubmitNewWorkunit(Build_Kel_Ecl,ECLThorName)
	): success(FraudGovPlatform.Send_Emails(version).BuildSuccess), failure(FraudGovPlatform.Send_Emails(version).BuildFailure);

	export All :=
	if(tools.fun_IsValidVersion(version),
		 build_all
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_All'));	
end;	