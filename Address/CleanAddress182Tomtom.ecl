/*

This wrapper calls lib_AddrClean.AddrCleanLib.CleanAddress182
with the appropriate port.  Bug #13335

This function is normaly called by doxie.CleanAddress182

*/

import BO_Address;

export CleanAddress182Tomtom(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
       := function  

  	
  //clean := AddrCleanLib.CleanAddress182(addrline, lastline, CorrectServer, CorrectPort); 
	
	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
	
	clean := BO_Address.CleanAddress182(addrline, lastline,cleanserver,cleanport);
  return clean; 

end;  // Function