// A wrapper for lib_AddrClean.AddrCleanLib.CleanDualName140;
// chooses the appropriate port.
import BO_Address;

EXPORT CleanDualName140 (const string dualname, 
                         const string server = '', 
                         unsigned2 port = 0)	:= FUNCTION

	
	
  //clean := AddrCleanLib.CleanDualName140 (dualname, CorrectServer, CorrectPort);  
	clean := BO_Address.CleanDualName140 (dualname,Address.Constants.CorrectServer,Address.Constants.CorrectPort);  
  
  return clean; 
END;
