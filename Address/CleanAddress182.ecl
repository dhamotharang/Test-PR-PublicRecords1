/*

This wrapper is intended to ease switching to call either 
   lib_AddrClean.AddrCleanLib.CleanAddress182Tomtom
or lib_AddrClean.AddrCleanLib.CleanAddress182Navteq

*/

import Address;

export CleanAddress182(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
       := function  
	
	cleanserver := if (server = '',Address.Constants.CorrectServer,server);
	cleanport := if (port = 0,Address.Constants.CorrectPort,port);
	
  // hard-code a constant of 182 characters instead of calling the address cleaner with missing inputs
  empty_address_constant    := '                                                                                                                                                                                 5E502';
  empty_lastline_constant   := '                                                                                                                                                                                 5E101';
  missing_input := trim(addrline)='' and trim(lastline)='';
  missing_lastline := trim(lastline)='';
  
  clean := map(missing_input => empty_address_constant,
               missing_lastline => empty_lastline_constant,
               Address.CleanAddress182Navteq(addrline, lastline, cleanserver, cleanport)
               );

  return clean; 

end;  // Function