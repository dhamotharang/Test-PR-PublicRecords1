


import BO_Address;

export CleanAddressEnclarity(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
       := function  

  	
  
	
	//cleanserver := if (server = '',BO_Address.BO_EnclarityServer,server);
	//cleanport := if (port = 0,BO_Address.BO_EnclarityPort,port);
	
	
  cleanserver := BO_Address.BO_EnclarityServer;
	cleanport := BO_Address.BO_EnclarityPort;

	clean := BO_Address.CleanAddressEnclarity(addrline, lastline, cleanserver, cleanport);
	//clean := BO_Address.CleanAddressEnclarity(addrline, lastline, 'postalbuild01.risk.regn.net', 21600);
  
  return clean; 
	


end;  // Function