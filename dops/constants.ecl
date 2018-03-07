import STD,lib_thorlib;
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
		export serviceurl := 'http://dopsservices.risk.lexisnexis.com/demodopsservice.asmx';
	end;
	
	
	export gethost(string environment = '') := if ( environment in healthcareset
																							,if (regexfind('server can\'t find',STD.System.Util.CmdProcess('nslookup','hcdops.risk.lexisnexis.com' ))
																										,'hcdops-dr.risk.lexisnexis.com'
																										,'hcdops.risk.lexisnexis.com')
																							,'dopsservices.risk.lexisnexis.com');
	
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
		export serviceurl := 'http://dopsservices.risk.lexisnexis.com/demodopsservice.asmx';
	end;

	export dopsenvironment := Thorenvironment;
											

	export location := 'B';
	
	
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
	
end;