Import Dops,Orbit3,std,FraudGovPlatform_Analytics,_control;
ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor','Thor400_Dev',	'Thor400_44');
//Refresh ProdDashVersion flag file
Superfilename					:= FraudGovPlatform.FileNames().Flags.RefreshProdDashVersion;
Logicalfilename				:= Superfilename +'::'+(STRING8)STD.Date.Today();

RefreshVersion				:= dataset([{true}], {boolean RefreshVersion});
UpdateRefreshVersion	:= OUTPUT(RefreshVersion,, Logicalfilename,cluster(ThorName), compressed,overwrite);

CreateSuper := Sequential(IF(~(STD.File.SuperFileExists(Superfilename)), STD.File.CreateSuperFile(Superfilename),output('DashboardVer Refresh Superfile already exists. Skipping creating superfile.')),
															STD.File.ClearSuperfile(Superfilename,true)
														);
														
fsuperadd	:= STD.File.AddSuperfile(Superfilename, Logicalfilename);

RunDashboards:=  SEQUENTIAL(FraudGovPlatform_Analytics.GenerateDashboards(true,true),
														CreateSuper,
														UpdateRefreshVersion,
														fsuperadd);

EXPORT GenerateProdDashboards := RunDashboards;