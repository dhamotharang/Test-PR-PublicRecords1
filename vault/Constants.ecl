import Vault, STD, _Control;
EXPORT Constants() := module
	
	export devdaliip := STD.System.Util.ResolveHostName('dataland_dali.br.seisint.com');
	export proddaliip := STD.System.Util.ResolveHostName('prod_dali.br.seisint.com');
	
	export daliip := nothor(STD.Str.SplitWords(STD.System.Thorlib.DaliServer(),':')[1]) : independent;
	
	export ThorEnvironment := map (
																	daliip = devdaliip => 'dev'
																	,daliip = proddaliip => 'prod'
																	,'na'
																	);
	
	
	export MyEnvironment := ThorEnvironment : independent;

	export vSourceESP := 'prod_esp.br.seisint.com';
												
	export vVaultESP := 'dataland_esp.br.seisint.com';
															//'10.194.90.203';
															
	export vSourceGroups := ['thor400_44','thor400_36'];
	
	export vVaultGroup := 'thor400_dev';
															//,'analyt_thor400_90_dev');
	
	export vVaultTargetCluster := 'thor50_dev_eclcc';
	
		
	export vVaultHthorCluster := 'hthor_dev_eclcc';
															//,'hthor');//'analyt_thor400_90_dev';
	export vVaultDali := 'dataland_dali.br.seisint.com';
	
	export vSourceDali := 'prod_dali.br.seisint.com';
															// ,'10.194.90.202');//'10.194.90.202';
	
	export vVaultDaliIP := STD.System.Util.ResolveHostName(vVaultDali);
	
	export vSenderEmail := 'Anantha.Venkatachalam@lexisnexisrisk.com';
	//export vReceiveEmail := 'Anantha.Venkatachalam@lexisnexisrisk.com, Sanjay.Narla@lexisnexisrisk.com, sajish.sasikumar@lexisnexisrisk.com, soujanya.gade@lexisnexisrisk.com, sean.rousey@lexisnexisrisk.com';
	export vReceiveEmail := 'Anantha.Venkatachalam@lexisnexisrisk.com';

	export vESPSet(string p_cluster, string p_environment) := MAP(
																															p_cluster = 'fcra' and p_environment = 'cert' =>  ['10.173.235.22','10.173.1.136']
																															,p_cluster = 'fcra' and p_environment = 'prod' =>  ['10.173.1.133','10.173.1.135']
																															,p_cluster = 'nonfcra' and p_environment = 'cert' =>  ['10.173.101.101'
																																																											,'10.173.102.101'
																																																											,'10.173.103.101']
																															,p_cluster = 'nonfcra' and p_environment = 'prod' =>  ['10.173.109.101'
																																																											,'10.173.108.101'
																																																											,'10.173.114.101'
																																																											,'10.173.115.101']
																															,['NA']);
	
	export vRoxieVIP(string p_cluster, string p_environment) := MAP(
																															p_cluster = 'fcra' and p_environment = 'cert' =>  'http://certfcraroxievip.sc.seisint.com:9876'
																															,p_cluster = 'fcra' and p_environment = 'prod' =>  _Control.RoxieEnv.prod_batch_fcra
																															,p_cluster = 'nonfcra' and p_environment = 'cert' =>  _Control.RoxieEnv.certvip
																															,p_cluster = 'nonfcra' and p_environment = 'prod' =>  _Control.RoxieEnv.prodvip
																															,'NA');	
	
	export vIsCorrectDestination := if (daliip = vVaultDaliIP, true, false);
	
	export vIsHthorCluster := regexfind('hthor',STD.System.Job.Target());
	
	///////////////////// CONSTANTS /////////////////////////////////
end;