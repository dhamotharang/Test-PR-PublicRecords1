Import Dops,Orbit3,std,FraudGovPlatform_Analytics;

RIN_CERT_Version:= Dops.GetBuildVersion('FraudGovKeys','B','N','C');
RIN_PROD_Version:= Dops.GetBuildVersion('FraudGovKeys','B','N','P');
string currentBuildVersion := RIN_CERT_Version;

ptoken := orbit3.GetToken();
orbitbuildstatus := GetBuildInstance('FraudGov',currentbuildversion,ptoken).retcode.buildstatus;

filename :='~fraudgov::base::'+currentBuildVersion+'::rindashboardbuildversion';
supername := '~fraudgov::base::rindashboardbuildversion';

fname := std.file.SuperFileContents(supername)[1].name;

Dashboard_Build_version := Std.Str.SplitWords(fname,'::')[3];

dUpdateBuildVersion := dataset([{currentBuildVersion}], {string DashboardBuildVersion});
updateDashboardBuildVersion := OUTPUT(dUpdateBuildVersion,, filename, compressed,overwrite);

fsuperadd	:= Sequential(STD.File.StartSuperFileTransaction()
											 ,STD.File.Clearsuperfile(supername)
									     ,STD.File.AddSuperfile(supername, filename)	
											 ,STD.File.FinishSuperFileTransaction()
												);

RunDashboards:=  SEQUENTIAL(FraudGovPlatform_Analytics.GenerateDashboards(true,true), updateDashboardBuildVersion,fsuperadd);

EXPORT GenerateProdDashboards := If((RIN_CERT_Version=RIN_PROD_Version and Orbitbuildstatus='PRODUCTION' and RIN_CERT_Version <> Dashboard_Build_version)
																	,RunDashboards
																	,output('Prod Dashboards are upto date')
																	);