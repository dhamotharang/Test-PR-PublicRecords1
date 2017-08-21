Import STD, _Control,ut;
EXPORT PackageFileConstants(string env, boolean isFull = false) := module

	ts := (string8)std.date.today() + ut.getTime() : INDEPENDENT;

	shared pkg_name := if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1, 'drbair_', 'bair_') + if(isFull, 'full_', '') + ts;
	// export packageip := if (regexfind('server can\'t find',STD.System.Util.CmdProcess('nslookup',STD.Str.Reverse( '1.1.2.2' )))
										// ,'10.240.160.26'
										// ,'1.1.2.2'
										// );// the ip to login to the machine is 10.240.32.39 but to despray use 1.1.2.2; 10.240.160.26/2.1.1.146 is DR machine
	
	//2.1.1.146 - DR IP to de-spray the pkg file
	//1.1.2.2 	- PROD IP to de-spray the pkg file
	export packageip := if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.bair_DR_dali1,'2.1.1.146', '1.1.2.2'); 
	export noswitchlocation := if(isFull,
																	'/home/svc-deployment/package/pkgfromthor/bair/' + env + '/switch/full/' + pkg_name + '.pkg',
																	'/home/svc-deployment/package/pkgfromthor/bair/' + env + '/switch/' + pkg_name + '.pkg'); // delta data, for now we are always deploying to switch location so we switch roxie each time
	export switchlocation := if(isFull,
																	'/home/svc-deployment/package/pkgfromthor/bair/' + env + '/switch/full/' + pkg_name + '.pkg',
																	'/home/svc-deployment/package/pkgfromthor/bair/' + env + '/switch/' + pkg_name + '.pkg'); // full data
	export switchfulllocation := '/home/svc-deployment/package/pkgfromthor/bair/' + env + '/switch/full/';
	export fulldeploylocation := '/home/svc-deployment/package/deployment/auto/bair/' + env + '/pkgtodeploy/full';
end;