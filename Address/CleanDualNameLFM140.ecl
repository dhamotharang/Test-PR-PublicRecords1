// A wrapper for lib_AddrClean.AddrCleanLib.CleanDualNameLFM140;
// chooses the appropriate port.

import BO_Address;

EXPORT CleanDualNameLFM140 (const string dualname, 
                            const string server = '', 
                            unsigned2 port = 0)	:= FUNCTION

	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
	
  //clean := AddrCleanLib.CleanDualNameLFM140 (dualname, CorrectServer, CorrectPort);  
	clean := BO_Address.CleanDualNameLFM140 (dualname,cleanserver,cleanport);  
  
  return clean; 
END;
