export CleaningServer := 
MODULE


	shared not_roxie 									:= stringlib.stringtouppercase((STRING5)thorlib.platform()) <> 'ROXIE';
	shared Priority    								:= thorlib.priority();
	shared str_CleaningServerBarName 	:= 'AddressCleaningServer';
	shared str_CleaningPortBarName 		:= 'AddressCleaningPort';
	
/*
  Port mappings:
	
	not roxie			use 11000
	roxie					use env var, else default to old behavior
	old behavior	low priority(0), use 11200.  higher priority(>=1), use 11100
	
	*note about env variable.  online (aka transactional aka non-batch) roxie will set 11100 in package file and batch roxie will set 11200.  this should prevent a given roxie from having to switch ports.

*/

	shared unsigned2 useEnvVarPort(unsigned2 port) := 
	FUNCTION
	
		string5 strDefault := 
		map(
			Priority = 0 =>'11200', 
			Priority >= 1 => '11100', 
			(string5)port
		); 
		
		return (unsigned2)thorlib.getenv(str_CleaningPortBarName, strDefault);
		
	END;
	
	export unsigned2 CorrectPort(unsigned2 port) := 
		if(
			not_roxie,
			11000, 
			useEnvVarPort(port)
		);


/*
  Server mappings:
	
  roxie     use env. varible, else default(for default, see address.CleanAddress18*)
	thor      use input, else default
	hthor     use input, else default

*/
		
	export string CorrectServer(string server)	:= 
		map(not_roxie => server,
										 thorlib.getenv(str_CleaningServerBarName,server));
										 
										 
	
	
	
	shared str_CanadaCleaningServerBarName := 'CanadianAddressCleaningServer';
	export unsigned2 CorrectPortCanada(unsigned2 port) := 11300; 
		
	export string CorrectServerCanada(string server)	:= map(not_roxie => server,
																thorlib.getenv(str_CanadaCleaningServerBarName,server));
										 


END;

/* BATCH
<Package id="EnvironmentVariables">
  <Environment id='AddressCleaningPort' val='11200'/>
  <Environment id='AddressCleaningServer' val='postalcleanlb03.br.seisint.com'/>
  <Environment id='CanadianAddressCleaningServer' val='canadacleanlb2.br.seisint.com'/>
</Package>
*/

/* ONLINE
<Package id="EnvironmentVariables">
  <Environment id='AddressCleaningPort' val='11100'/>
  <Environment id='AddressCleaningServer' val='postalcleanlb03.br.seisint.com'/>
  <Environment id='CanadianAddressCleaningServer' val='canadacleanlb2.br.seisint.com'/>
</Package>
*/