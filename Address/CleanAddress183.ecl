/*

This wrapper calls lib_AddrClean.AddrCleanLib.CleanAddress183
with the appropriate port.  Bug #13335

This function is normaly called by doxie.CleanAddress183

*/

import BO_Address;

export CleanAddress183(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
       := function  

	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
  //clean := AddrCleanLib.CleanAddress183(addrline, lastline, CorrectServer, CorrectPort);  
	clean := BO_Address.CleanAddress183(addrline, lastline,cleanserver,cleanport);
  
  return clean; 

end;  // Function