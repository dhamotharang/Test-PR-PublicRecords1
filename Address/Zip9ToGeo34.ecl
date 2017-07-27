/*
This wrapper calls lib_AddrClean.AddrCleanLib.Zip9ToGeo34 with the appropriate port. 
*/

import BO_Address;

export Zip9ToGeo34(const string zip9) := function  

	
  clean := BO_Address.Zip9ToGeo34(zip9, Address.Constants.CorrectServer,Address.Constants.CorrectPort);  
  return clean; 

end;

  