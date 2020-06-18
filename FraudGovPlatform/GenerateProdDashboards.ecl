Import Dops,Orbit3,std,FraudGovPlatform_Analytics,_control,FraudGovPlatform_Validation;
ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor','Thor400_Dev',	'Thor400_36');
//Refresh ProdDashVersion flag file
Superfilename					:= FraudGovPlatform.FileNames().Flags.RefreshProdDashVersion;
Logicalfilename				:= Superfilename +'::'+(STRING8)STD.Date.Today();

RefreshVersion				:= dataset([{true}], {boolean RefreshVersion});
UpdateRefreshVersion	:= OUTPUT(RefreshVersion,, Logicalfilename,cluster(ThorName), compressed,overwrite);

CreateSuper := Sequential(IF(~(STD.File.SuperFileExists(Superfilename)), STD.File.CreateSuperFile(Superfilename),output('DashboardVer Refresh Superfile already exists. Skipping creating superfile.')),
															STD.File.ClearSuperfile(Superfilename,true)
														);
														
fsuperadd	:= STD.File.AddSuperfile(Superfilename, Logicalfilename);

ECLHThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		
	FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);

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
+'FraudGovPlatform.Build_CoverageDates_Push.push_to_prod:failure(email(\'Build Coverage Dates failed\'));\n'
;

RunDashboards:=  SEQUENTIAL(	FraudGovPlatform_Analytics.GenerateDashboards(true,true),
								CreateSuper,
								UpdateRefreshVersion,
								fsuperadd,
								_Control.fSubmitNewWorkunit(BuildCoverageDates,ECLHThorName));

EXPORT GenerateProdDashboards := RunDashboards;