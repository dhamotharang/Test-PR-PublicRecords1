Import Dops, FraudGovPlatform,std,_control;
ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor','Thor400_Dev',	'Thor400_36');
RIN_CERT_Version:= Dops.GetBuildVersion('FraudGovKeys','B','N','C');
string currentBuildVersion := RIN_CERT_Version;

CustomerDash_WU						:=	FraudGovPlatform.files().CustomerDashboard.response[1].workunitid;
CustomerDashboard1_1_WU		:=	FraudGovPlatform.files().CustomerDashboard1_1.response[1].workunitid;
ClusterDetails_WU					:=	FraudGovPlatform.files().ClusterDetails.response[1].workunitid;

CustomerDash_WUState					:=	FraudGovPlatform.fn_Getwuinfo(CustomerDash_wu,'ramps_prod_esp.risk.regn.net')[1].state;
CustomerDashboard1_1_WUState	:=	FraudGovPlatform.fn_Getwuinfo(CustomerDashboard1_1_WU,'ramps_prod_esp.risk.regn.net')[1].state;
ClusterDetails_WUState				:=	FraudGovPlatform.fn_Getwuinfo(ClusterDetails_wu,'ramps_prod_esp.risk.regn.net')[1].state;
//Write Prod Dashboards version to a file
ProdDashVer_Super					:=	FraudGovPlatform.FileNames().ProdDashboardVersion;
ProdDashVer_Logical					:=	ProdDashVer_Super +'::' + currentBuildVersion;

dUpdateBuildVersion					:=	dataset([{currentBuildVersion}], FraudGovPlatform.Layouts.ProdDashboardVersion);
updateBuildVersion					:=	OUTPUT(dUpdateBuildVersion,, ProdDashVer_Logical, cluster(ThorName),compressed,overwrite);

//Resetting the flag file to false once the dashboards succesful
ProdDashVerRefresh_Super			:=	FraudGovPlatform.FileNames().flags.RefreshProdDashVersion;
ProdDashVerRefresh_Logical:=	ProdDashVerRefresh_Super +'::'+(STRING8)STD.Date.Today();

dRefreshProdVer						:=	dataset([{false}], FraudGovPlatform.Layouts.flags.RefreshProdDashVersion);
updatedRefreshProdVer				:=	OUTPUT(dRefreshProdVer,, ProdDashVerRefresh_Logical,cluster(ThorName), compressed,overwrite);

CreateSuper := Sequential(IF(~(STD.File.SuperFileExists(ProdDashVer_Super)), STD.File.CreateSuperFile(ProdDashVer_Super),output('DashboardVer Superfile already exists. Skipping creating superfile.')),
															STD.File.StartSuperFileTransaction(),
															STD.File.ClearSuperfile(ProdDashVer_Super,true),
															STD.File.ClearSuperfile(ProdDashVerRefresh_Super,true),
															STD.File.FinishSuperFileTransaction()
														);
																											
fsuperadd	:= Sequential(
												STD.File.StartSuperFileTransaction(),
												STD.File.AddSuperfile(ProdDashVer_Super, ProdDashVer_Logical),
												STD.File.AddSuperfile(ProdDashVerRefresh_Super, ProdDashVerRefresh_Logical),
												STD.File.FinishSuperFileTransaction()
												);
DashboardsReady 					:=	If(CustomerDash_WUState='completed' and CustomerDashboard1_1_WUState='completed' and ClusterDetails_WUState='completed',true,false);


EXPORT GenerateProdDashVersion		:= If(DashboardsReady,
											Sequential(	CreateSuper,
														updateBuildVersion,
														updatedRefreshProdVer,
														fsuperadd
														),
											output('Prod Dashboards Not Ready')
										 );										 