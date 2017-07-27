// A wrapper for lib_AddrClean.AddrCleanLib.CleanDualNameLFM140;
// chooses the appropriate port.

import BO_Address;

EXPORT CleanDualNameLFM140 (const string dualname, 
                            const string server = '', 
                            unsigned2 port = 0)	:= FUNCTION

	//CorrectPort := address.CleaningServer.CorrectPort(port); 
	//CorrectServer := address.CleaningServer.CorrectServer(server);
	
  //clean := AddrCleanLib.CleanDualNameLFM140 (dualname, CorrectServer, CorrectPort);  
	clean := BO_Address.CleanDualNameLFM140 (dualname,address.Constants.CorrectServer,address.Constants.correctport);  
  
  return clean; 
END;
