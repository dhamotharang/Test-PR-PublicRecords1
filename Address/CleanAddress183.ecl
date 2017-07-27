/*

This wrapper calls lib_AddrClean.AddrCleanLib.CleanAddress183
with the appropriate port.  Bug #13335

This function is normaly called by doxie.CleanAddress183

*/

import BO_Address;

export CleanAddress183(const string addrline, const string lastline)
       := function  

	
  //clean := AddrCleanLib.CleanAddress183(addrline, lastline, CorrectServer, CorrectPort);  
	clean := BO_Address.CleanAddress183(addrline, lastline,Address.Constants.CorrectServer,Address.Constants.CorrectPort);
  
  return clean; 

end;  // Function