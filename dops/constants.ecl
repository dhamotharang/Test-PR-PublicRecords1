﻿/*2018-02-13T00:25:56Z (Ros, Charlene (RIS-BCT))
Added skipclustersforcompression to support DUS-272
*/
import STD,lib_thorlib;
export constants := module
	
	export location := 'B';
	export devdaliip := fileservices.ResolveHostName('dataland_dali.br.seisint.com');
	export proddaliip := fileservices.ResolveHostName('prod_dali.br.seisint.com');
	
	export daliip := nothor(STD.Str.SplitWords(lib_thorlib.thorlib.daliServers(),':')[1]) : independent;
	export jobowner := nothor(lib_thorlib.thorlib.jobowner()) : independent;
	
	export ThorEnvironment := map (
																	daliip = devdaliip => 'dev'
																	,daliip = proddaliip => 'prod'
																	,'na'
																	);
	
	// N - NonFCRA; F - FCRA; B - Boolean; S - Customer Support
	// FS - FCRA Customer Support; T - Customer Test
	
	export environmentset := ['N','F','B','S','FS','T'];
	
	// H - Health Care Prod; HC - Health Care Customer Test; HU - UAT
	
	
	export healthcareset := ['H','HC','HU'];
	
	export locationset := ['B','A']; 
	
	export gethost(string dopsenv, string environment = '') := 
																								if (dopsenv = 'prod'
																									,MAP (
																											(environment in healthcareset) and (location in locationset)
																																=> 'ushc-dopsservices.risk.regn.net'
																											,environment not in healthcareset and location = 'B'
																																=> 'uspr-dopsservices.risk.regn.net'
																											,environment not in healthcareset and location = 'A'
																																=> 'usins-dopsservices.risk.regn.net'
																											,'NA'
																										)
																									,MAP (
																											(environment in healthcareset) and (location in locationset)
																																=> 'devdopsservices.risk.regn.net/hc'
																											,environment not in healthcareset and location = 'B'
																																=> 'devdopsservices.risk.regn.net'
																											,environment not in healthcareset and location = 'A'
																																=> 'devdopsservices.risk.regn.net'
																											,'NA'
																										)
																									);
	
	export prboca := module
		export serviceurl(string dopsenv
								, string environment = '') := 'http://'+ trim(gethost(dopsenv,environment),left,right)+ '/demodopsservice.asmx';
																																	
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
	
end;