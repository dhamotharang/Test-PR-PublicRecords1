// A wrapper for lib_AddrClean.AddrCleanLib.CleanPersonFML73;
// chooses the appropriate port.

import BO_Address,Address;

EXPORT CleanPersonFML73 (const string name, 
                         const string server = '', 
											   unsigned2 port = 0)	:= FUNCTION

	//CorrectPort := address.CleaningServer.CorrectPort(port); 
	//CorrectServer := address.CleaningServer.CorrectServer(server);
	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
  //clean := AddrCleanLib.CleanPersonFML73 (name, CorrectServer, CorrectPort);  
	clean := BO_Address.CleanPersonFML73 (name,cleanserver,cleanport);  
  
  return clean; 
END;