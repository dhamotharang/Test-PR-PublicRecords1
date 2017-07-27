/*2016-03-22T19:30:18Z (Dan Abittan)
202516 - Address Cleaner Port Load Balance - Internal Project - ensured that batch services hit a different port than the online services
*/
import BO_Address,lib_thorlib,lib_stringlib,BatchShare;

export Constants := module
		shared addressswitch  := '1'; // 0 - old, 1 - new
		shared caddressswitch := '0'; // 0 - old, 1 - new - for canada cleaner
		shared Priority    		:= thorlib.priority();
		shared is_batch       := BatchShare.fn_Is_Batch_Service(); //returns true if the service calling this attribute is a batch service
	//shared is_online      := ~is_batch; //returns true if the service calling this attribute is an online/esp service
		
		export boolean not_roxie := stringlib.stringtouppercase((STRING5)thorlib.platform()) <> 'ROXIE';
		// all defaults - old cleaner
		export string defaultserver := 'thorclean.br.seisint.com';
		export integer defaultport := 11000;
																				
		// all defaults - new cleaner
		export string newdefaultserver := BO_Address.BO_server;
		export integer newdefaultport := BO_Address.BO_Port;

		export string oldserver := if(not_roxie,defaultserver,
																		thorlib.getenv('AddressCleaningServer',defaultserver)
																		);
		//for batch services  we hit PORT 11200 --> OldBAddressCleaningPort
		//for online services we hit PORT 11100	--> OldIAddressCleaningPort															
		export integer oldport := map(not_roxie => defaultport,
																map(
																		is_batch      => (integer)thorlib.getenv('OldBAddressCleaningPort',(string5)defaultport), 
																		Priority >= 0 => (integer)thorlib.getenv('OldIAddressCleaningPort',(string5)defaultport), 
																		defaultport
																)															
															);
		export string newserver := if(not_roxie,BO_Address.BO_server,
																		thorlib.getenv('NewAddressCleaningServer',newdefaultserver)
																		);
		//for batch services  we hit PORT 21200 --> NewBAddressCleaningPort
		//for online services we hit PORT 21100 --> NewIAddressCleaningPort
		export integer newport := map(not_roxie => BO_Address.BO_Port,
																map(
																	is_batch      => (integer)thorlib.getenv('NewBAddressCleaningPort',(string5)newdefaultport), 
																	Priority >= 0 => (integer)thorlib.getenv('NewIAddressCleaningPort',(string5)newdefaultport), 
																	newdefaultport
																)														
															); 
		export string HealthcareDefaultServer := BO_Address.BO_EnclarityServer;
		export integer HealthcareDefaultPort := BO_Address.BO_EnclarityPort;
		export string HCServer :=  if(not_roxie,HealthcareDefaultServer,
																		thorlib.getenv('HealthcareAddressCleaningServer',HealthcareDefaultServer));
		export integer HCPort := if(not_roxie,HealthcareDefaultPort,
																		(integer)thorlib.getenv('HealthcareAddressCleaningPort',(string5)HealthcareDefaultPort));
		// Canadian parameters
		
		export string defaultcserver := 'canadacleanlb2.br.seisint.com';
		export integer defaultcport := 11300;
		export string newdefaultcserver := 'sap_tcanadalb.br.seisint.com';
		export integer newdefaultcport := 21300;
		export string oldcserver := thorlib.getenv('CanadianAddressCleaningServer',defaultcserver);
		export integer oldcport := (integer)thorlib.getenv('CanadianAddressCleaningPort',(string5)defaultcport);
		export string newcserver := thorlib.getenv('NewCanadianAddressCleaningServer',newdefaultcserver);
		export integer newcport := (integer)thorlib.getenv('NewCanadianAddressCleaningPort',(string5)newdefaultcport);
		export string CorrectServer := if (addressswitch = '1', newserver, oldserver);
		export integer CorrectPort := if (addressswitch = '1', newport, oldport);
		export string CorrectCServer := if (caddressswitch = '1', newcserver, oldcserver);
		export integer CorrectCPort := if (caddressswitch = '1', newcport, oldcport);
		export string newbatchserver := 'sap_tbatchthorlb.risk.regn.net';
    export integer newbatchport := 21200;
		export string HealthcareServer := HCServer;
		export integer HealthcarePort := HCPort;
																		
end;