/**************************************************************************************************************************************************/
/* PROJECT: RISK INTELLIGENCE NETWORK - AKA: RIN, OTTO, FraudGov
/* DOCUMENTATION: https://confluence.rsi.lexisnexis.com/display/GTG/OTTO+-+Data+Build
/* AUTHORS: DATA ENGINEERING (SESHA NOOKALA, OSCAR BARRIENTOS)
/**************************************************************************************************************************************************/
import tools, _control, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;

export Build_Kel(
	 string pversion 	
) :=
module

ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);
ECLThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

GenerateDashboards := 
 'import ut,FraudGovPlatform_Analytics,_control;\n'
+'wuname := \'FraudGov Cert Dashboards Refresh\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'protect\', true);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Analytics\n'
+' 	 ,\'FraudGov Cert Dashboards Refresh\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'IF(_control.ThisEnvironment.Name <> \'Prod_Thor\'\n'
//GRP-5211 Commented out Old rin dashboards
+'	,Sequential(/*FraudGovPlatform_Analytics.GenerateDashboards(False,False,,True),*/FraudGovPlatform_Analytics.GenerateRinDashboards(False,False,True))\n'
+'	,Sequential(/*FraudGovPlatform_Analytics.GenerateDashboards(False,True),*/FraudGovPlatform_Analytics.GenerateRinDashboards(False,True))\n'
+		'):failure(IF(_control.ThisEnvironment.Name <> \'Prod_Thor\',email(\'Dev dashboards failed\'),email(\'Cert dashboards failed\')));\n'
;
BuildCoverageDates := 
 'import ut,FraudGovPlatform;\n'
+'wuname := \'FraudGov Build Coverage Dates\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'protect\', true);\n'
+'#OPTION(\'defaultSkewError\', 1);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Build Coverage Dates\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'FraudGovPlatform.Build_CoverageDates_Push.push_to_cert:failure(email(\'Build Coverage Dates failed\'));\n'
;
BuildStatusReport := 
 'import ut,FraudGovPlatform,FraudGovPlatform_Validation;\n'
+'wuname := \'FraudGov Build Status Report\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'protect\', true);\n'
+'#OPTION(\'defaultSkewError\', 1);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Build Status Report\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'FraudGovPlatform.Build_Summary(\''+pversion+'\').send:failure(email(\'Build Status Report failed\'));\n'
;

			
	Export	All := Sequential(
										 Build_Base_Kel(pVersion).All
										,Promote(pversion).buildfiles.New2Built
										,Promote(pversion,,true).buildfiles.Built2QA
										,Build_Keys(pVersion).Kel
										,Build_Keys(pversion).All
										,Build_AutoKeys(pversion)
										,FraudGovPlatform.Build_Keys_UnitTests(pversion).ALL
										,FraudGovPlatform.Promote(pversion,,true).promote_keys
										,Orbit3.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion)
										,_Control.fSubmitNewWorkunit(GenerateDashboards,ThorName)
										,_Control.fSubmitNewWorkunit(BuildStatusReport,ECLThorName)
										,_Control.fSubmitNewWorkunit(BuildCoverageDates,ThorName)
										,FraudGovPlatform.Send_Emails(pversion).Roxie										
									);
		
End;		