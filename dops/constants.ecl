/*2018-02-13T00:25:56Z (Ros, Charlene (RIS-BCT))
Added skipclustersforcompression to support DUS-272
*/
import STD,lib_thorlib,_Control;
export constants := module
	
	export location := 'B';
	export devdaliip := [fileservices.ResolveHostName('dataland_dali.br.seisint.com')];
	export proddaliip := [fileservices.ResolveHostName('prod_dali.br.seisint.com'),'10.173.26.7'];
	
	export daliip := nothor(STD.Str.SplitWords(lib_thorlib.thorlib.daliServers(),':')[1]) : independent;
	export jobowner := nothor(lib_thorlib.thorlib.jobowner()) : independent;
	
	export ThorEnvironment := map (
																	daliip in devdaliip => 'dev'
																	,daliip in proddaliip => 'prod'
																	,'na'
																	);
	
	export esp(string dopsenv = ThorEnvironment) := map (
																	dopsenv = 'dev' => _Control.IPAddress.dataland_esp
																	,dopsenv = 'prod' => _Control.IPAddress.prod_thor_esp
																	,'na'
																	);
	
	export rptemail(string l_location = location) := map (
																	l_location = 'B' => 'bocaroxiepackageteam@lexisnexisrisk.com'
																	,l_location = 'A' => 'alproxiepackageteam@lexisnexisrisk.com'
																	,'roxiepackageteam@lexisnexis.com'
																	);
	
	export hthorcluster(string dopsenv = ThorEnvironment) := if (regexfind('eclcc',STD.System.Job.Target()),
													map( dopsenv = 'prod' => 'hthor_eclcc'
															,dopsenv = 'dev' => 'hthor_dev_eclcc'
															,'na'
													)
													,map( dopsenv = 'prod' => 'hthor'
															,dopsenv = 'dev' => 'hthor_dev'
															,'na'
													));
	
	// N - NonFCRA; F - FCRA; B - Boolean; S - Customer Support
	// FS - FCRA Customer Support; T - Customer Test
	
	export environmentset := ['N','F','B','S','FS','T'];
	
	// H - Health Care Prod; HC - Health Care Customer Test; HU - UAT
	
	
	export healthcareset := ['H','HC','HU'];
	
	export locationset := ['B','A']; 
	
	export gethost(string dopsenv, string environment = ''
									,string l_loc  = location
									,string l_testenv = 'NA') := 
																								if (dopsenv = 'prod'
																									,if (l_testenv = 'NA'
																										,MAP (
																											(environment in healthcareset) and (l_loc in locationset)
																																=> 'ushc-dopsservices.risk.regn.net'
																											,environment not in healthcareset and l_loc = 'B'
																																=> 'uspr-dopsservices.risk.regn.net'
																											,environment not in healthcareset and l_loc = 'A'
																																=> 'usins-dopsservices.risk.regn.net'																																
																											,'NA'
																											)
																										,MAP (
																												l_loc = 'B' and STD.Str.ToUpperCase(l_testenv) = 'DATAQA'
																																=> 'uspr-dopsservices.risk.regn.net/dataqa'
																												,l_loc = 'B' and STD.Str.ToUpperCase(l_testenv) = 'CORE'
																																=> 'uspr-dopsservices.risk.regn.net/core'
																												,l_loc = 'B' and STD.Str.ToUpperCase(l_testenv) = 'PRTE'
																																=> 'uspr-dopsservices.risk.regn.net/prte'
																												,'NA'
																											)
																											
																										)
																									,MAP (
																											(environment in healthcareset) and (l_loc in locationset)
																																=> 'devdopsservices.risk.regn.net/hc'
																											,environment not in healthcareset and l_loc = 'B'
																																=> 'devdopsservices.risk.regn.net/' + 
																																					if (l_testenv <> 'NA' and l_testenv <> ''
																																							,l_testenv
																																							,'pr')
																											,environment not in healthcareset and l_loc = 'A'
																																=> 'devdopsservices.risk.regn.net/ins'
																											,'NA'
																										)
																								);
	
	export prboca := module
		export serviceurl(string dopsenv
								, string environment = ''
								,string l_loc = location
								,string l_testenv = 'NA') := 'http://'+ trim(gethost(dopsenv,environment,l_loc,l_testenv),left,right)+ '/demodopsservice.asmx';
																																	
	end;

	export dopsenvironment := Thorenvironment;
	
	export set of string allowedclusters := if (ThorEnvironment = 'prod',
																									['thor400_20'
																											,'thor400_30'
																											//,'thor400_31_store'
																											,'thor400_60'
																											,'thor400_44'],
																										['thor400_dev'
																											,'thor400_prod'
																											,'thor50_dev02'
																											,'thor50_dev']
																							);

	export skipclustersforcompression := if (ThorEnvironment = 'prod',
																							['thor400_31_store',
																									'hthor__eclagent',
																									'hthor__eclagent_1',
																									'hthor__eclagent_3',
																									'hthor__eclagent_centos7',
																									'hthor__eclagent_centos7_2',
																									'pound_option_thor',
																									'thor100_21_3',
																									'thor_200',
																									'thor400_84'],
																							['hthor_sta',
																							 'hthor_dev']
																				);
	
	export vFileScope(string l_loc = location
										,string environment = '') := MAP (
																(environment in healthcareset) and (l_loc in locationset)
																		=> 'ushc'
																,environment not in healthcareset and l_loc = 'B'
																		=> 'uspr'
																,environment not in healthcareset and l_loc = 'A'
																		=> 'usins'																																
																,'NA'
													);
	
	export vESPSet(string p_cluster
									,string p_environment
									,string p_loc = location
										) := MAP(vFileScope(p_loc) = 'uspr'
																																=> MAP(
																																			p_cluster = 'fcra' and p_environment = 'cert' =>  ['10.173.162.41'
																																																												,'10.173.164.41'
																																																												,'10.173.165.41']
																																			,p_cluster = 'fcra' and p_environment = 'prod' =>  ['10.173.166.41'
																																																													,'10.173.167.41'
																																																													,'10.173.168.41'
																																																													,'10.173.169.41'
																																																													,'10.173.170.41'
																																																													,'10.173.171.41'
																																																													,'10.173.172.41'
																																																													,'10.173.173.41'
																																																													,'10.173.174.41'
																																																													,'10.173.175.41'
																																																													,'10.173.176.41'
																																																													,'10.173.177.41'
																																																													]
																																			,p_cluster = 'nonfcra' and p_environment = 'cert' =>  ['10.173.101.101'
																																																											,'10.173.102.101'
																																																											,'10.173.103.101']
																																			,p_cluster = 'nonfcra' and p_environment = 'prod' =>  ['10.173.104.101'
																																																											,'10.173.105.101'
																																																											,'10.173.106.101'
																																																											,'10.173.107.101'
																																																											,'10.173.108.101'
																																																											,'10.173.109.101'
																																																											,'10.173.110.101'
																																																											,'10.173.111.101'
																																																											,'10.173.112.101'
																																																											,'10.173.113.101'
																																																											,'10.173.114.101']
																																				,['NA']
																																				)
																																,vFileScope(p_loc) = 'usins'
																																=> MAP(
																																			p_cluster = 'fcra' and p_environment = 'cert' =>  ['10.194.21.18']
																																			,p_cluster = 'fcra' and p_environment = 'prod' =>  ['10.194.21.98','10.194.21.66']
																																			,p_cluster = 'nonfcra' and p_environment = 'cert' =>  ['10.194.21.34'
																																																											,'10.194.219.101'
																																																											,'10.194.220.101']
																																			,p_cluster = 'nonfcra' and p_environment = 'prod' =>  ['10.194.21.82'
																																																											,'10.194.21.50'
																																																											,'10.194.221.101'
																																																											,'10.194.222.101'
																																																											,'10.194.223.101'
																																																											,'10.194.224.101'
																																																											,'10.194.225.101'
																																																											,'10.194.226.101'
																																																											,'10.194.227.101'
																																																											,'10.194.228.101'
																																																											,'10.194.229.101'
																																																											,'10.194.230.101'
																																																											,'10.194.231.101'
																																																											,'10.194.232.101']
																																				,['NA']
																																				)
																																	,['NA']);
	
	export vRoxieVIP(string p_cluster
										,string p_environment
										,string p_loc = location) := MAP(vFileScope(p_loc) = 'uspr'
																																			=> MAP(
																																					p_cluster = 'fcra' and p_environment = 'cert' =>  'http://certfcraroxievip.sc.seisint.com:9876'
																																					,p_cluster = 'fcra' and p_environment = 'prod' =>  _Control.RoxieEnv.prod_batch_fcra
																																					,p_cluster = 'nonfcra' and p_environment = 'cert' =>  'http://roxiestaging.sc.seisint.com:9876'
																																					,p_cluster = 'nonfcra' and p_environment = 'prod' =>  _Control.RoxieEnv.prodvip
																																					,'NA')
																																	,vFileScope(p_loc) = 'usins'
																																			=> MAP(
																																					p_cluster = 'fcra' and p_environment = 'cert' =>  'http://ifcraqaroxievip.sc.seisint.com:9876'
																																					,p_cluster = 'fcra' and p_environment = 'prod' =>  'http://ifcraroxievip.sc.seisint.com:9876'
																																					,p_cluster = 'nonfcra' and p_environment = 'cert' =>  'http://iroxieqavip.sc.seisint.com:9876'
																																					,p_cluster = 'nonfcra' and p_environment = 'prod' =>  'http://iroxievip.sc.seisint.com:9876'
																																					,'NA')
																																	,'NA'
																																	);	
	
	export integer pythonversion := 2;
	
end;