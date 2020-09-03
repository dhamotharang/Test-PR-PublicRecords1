﻿/*2018-02-13T00:25:56Z (Ros, Charlene (RIS-BCT))
Added skipclustersforcompression to support DUS-272
*/
import STD,lib_thorlib,_Control;
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
	
	export gethost(string dopsenv, string environment = '', string l_loc  = location) := 
																								if (dopsenv = 'prod'
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
																											(environment in healthcareset) and (l_loc in locationset)
																																=> 'devdopsservices.risk.regn.net/hc'
																											,environment not in healthcareset and l_loc = 'B'
																																=> 'devdopsservices.risk.regn.net'
																											,environment not in healthcareset and l_loc = 'A'
																																=> 'devdopsservices.risk.regn.net'
																											,'NA'
																										)
																									);
	
	export prboca := module
		export serviceurl(string dopsenv
								, string environment = ''
								,string l_loc = location) := 'http://'+ trim(gethost(dopsenv,environment,l_loc),left,right)+ '/demodopsservice.asmx';
																																	
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
	
end;import STD,lib_thorlib;
export constants := module
	
	
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
	

	export demo := module
		export serviceurl := 'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx?WSDL';
	end;
	
	
	export gethost(string environment = '') := if ( environment in healthcareset
																							,if (regexfind('server can\'t find',STD.System.Util.CmdProcess('nslookup','hcdops.risk.lexisnexis.com' ))
																										,'hcdops-dr.risk.lexisnexis.com'
																										,'hcdops.risk.lexisnexis.com')
																							,'uspr-dopsservices.risk.regn.net');
	
	export prboca := module
		export serviceurl(string dopsenv
								, string environment = '') := if (environment in healthcareset // Health care
																							,if (dopsenv = 'prod'
																								,'http://'+ gethost(environment) +'/webservices/demodopsservice.asmx'
																								,'http://10.176.142.139:83/webservices/demodopsservice.asmx')
																							,if (dopsenv = 'prod'
																								,'http://'+ gethost(environment) +'/demodopsservice.asmx'
																								,'http://10.176.142.139:81/demodopsservice.asmx')
																							);													
	end;

	// dev196 roxie
	export prbocadev := module
		export serviceurl := 'http://uspr-dopsservices.risk.regn.net/demodopsservice.asmx?WSDL';
	end;

	export dopsenvironment := Thorenvironment;
											

	export location := 'B';
	
	
	export set of string allowedclusters := if (ThorEnvironment = 'prod',
																									['thor400_20'
																											,'thor400_30'
																											,'thor400_36'
																											,'thor400_36_eclcc'
																											//,'thor400_31_store'
																											,'thor400_60'
																											,'thor400_44'
																											,'thor400_44_eclcc'
																											,'thor400_44_scoring'
																											,'thor400_44_scoring_eclcc'
																											,'thor400_44_sla'
																											,'thor400_44_sla_eclcc'
																											],
																									 	['thor400_dev'
																											,'thor400_prod'
																											,'thor50_dev02'
																											,'thor50_dev'
																											,'thor400_30'
																											,'thor400_dev_eclcc'
																											,'thor400_prod_eclcc'
																											,'thor400_sta'
																											,'thor400_sta_eclcc'
																											,'thor50_dev02_eclcc'
																											,'thor50_dev_eclcc'	 
																											]
																							);
	
end;