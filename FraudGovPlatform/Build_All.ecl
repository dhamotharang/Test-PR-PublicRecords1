/**************************************************************************************************************************************************/
/* PROJECT: RISK INTELLIGENCE NETWORK - AKA: RIN, OTTO, FraudGov
/* DOCUMENTATION: https://confluence.rsi.lexisnexis.com/display/GTG/OTTO+-+Data+Build
/* AUTHORS: DATA ENGINEERING (SESHA NOOKALA, OSCAR BARRIENTOS)
/**************************************************************************************************************************************************/
import tools, _control, FraudShared, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;

export Build_All(
	 string version 	
) :=
module
ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);

ECL := 
 'import ut,FraudGovPlatform_Analytics;\n'
+'wuname := \'FraudGov Cert Dashboards Refresh\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'protect\', true);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Analytics\n'
+' 	 ,\'FraudGov Cert Dashboards Refresh\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'FraudGovPlatform_Analytics.GenerateDashboards(False,True):failure(email(\'Cert dashboards failed\'));\n'
;
	export build_all := sequential(
		FraudGovPlatform.Build_Input(version).ALL,
		FraudGovPlatform.Build_Base(version).ALL,
		FraudGovPlatform.Build_Main(version).ALL,
		if ( FraudGovPlatform.Mac_TestRecordID(version) = 'Passed' and FraudGovPlatform.Mac_TestRinID(version) = 'Passed', 
				sequential(
					FraudGovPlatform.Promote(version).promote_base,
					FraudGovPlatform.promote(version).promote_sprayed_files,
					FraudShared.Build_Keys(version).All,
					FraudGovPlatform.Append_DemoData(version),
					FraudShared.Build_AutoKeys(version),
					FraudGovPlatform.Promote().Clear_DemoData,
					FraudGovPlatform.Build_Base_Pii(version).All,
					FraudGovPlatform.Build_Kel(version).All,
					FraudGovPlatform.Promote(version).promote_keys,
					Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',version),
					_Control.fSubmitNewWorkunit(ECL,ThorName),
					FraudGovPlatform.Send_Emails(version).Roxie),
				FAIL('Unit Test Failed'))
	): success(FraudGovPlatform.Send_Emails(version).BuildSuccess), failure(FraudGovPlatform.Send_Emails(version).BuildFailure);

	export All :=
	if(tools.fun_IsValidVersion(version),
		 build_all
		,output('No Valid version parameter passed, skipping FraudGovPlatform.Build_All'));	
end;	