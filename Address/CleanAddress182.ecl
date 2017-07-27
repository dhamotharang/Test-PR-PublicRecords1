/*

This wrapper is intended to ease switching to call either 
   lib_AddrClean.AddrCleanLib.CleanAddress182Tomtom
or lib_AddrClean.AddrCleanLib.CleanAddress182Navteq

*/

import BO_Address, Address;

export CleanAddress182(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
       := function  

  	
  //clean := AddrCleanLib.CleanAddress182(addrline, lastline, CorrectServer, CorrectPort); 
	
	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
	
	clean := Address.CleanAddress182Navteq(addrline, lastline, cleanserver, cleanport);;
	// clean := CleanAddress182Tomtom(addrline, lastline, cleanserver, cleanport);

  return clean; 

end;  // Function