﻿/**************************************************************************************************************************************************/
/* PROJECT: RISK INTELLIGENCE NETWORK - AKA: RIN, OTTO, FraudGov
/* DOCUMENTATION: https://confluence.rsi.lexisnexis.com/display/GTG/OTTO+-+Data+Build
/* AUTHORS: DATA ENGINEERING (SESHA NOOKALA, OSCAR BARRIENTOS)
/**************************************************************************************************************************************************/
import tools, _control, FraudShared, Orbit3, FraudGovPlatform_Validation, STD, FraudGovPlatform_Analytics;

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
+'	,Sequential(FraudGovPlatform_Analytics.GenerateDashboards(False,False,,True),FraudGovPlatform_Analytics.GenerateRinDashboards(False,False,True))\n'
+'	,Sequential(FraudGovPlatform_Analytics.GenerateDashboards(False,True),FraudGovPlatform_Analytics.GenerateRinDashboards(False,True))\n'
+		'):failure(IF(_control.ThisEnvironment.Name <> \'Prod_Thor\',email(\'Dev dashboards failed\'),email(\'Cert dashboards failed\')));\n'
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
										 Build_Keys(pVersion).Delta_All
										,Build_Base_Kel(pVersion).Delta_All
										,Promote(pversion).buildfiles.New2Built
										,Promote(pversion).buildfiles.Built2QA
										,Build_Keys(pVersion).All
										,Build_Base_Kel(pVersion).All
										,Promote(pversion).buildfiles.New2Built
										,Promote(pversion).buildfiles.Built2QA
										,FraudGovPlatform.Promote(pversion).promote_keys
										,FraudGovPlatform.proc_Orbit3_CreateBuild_AddItem('FraudGov',pversion)
										,_Control.fSubmitNewWorkunit(GenerateDashboards,ThorName)
										,_Control.fSubmitNewWorkunit(BuildStatusReport,ECLThorName)
										,FraudGovPlatform.Send_Emails(pversion).Roxie										
									);
		
End;		