/*

This wrapper calls Address.CallCleanAddress183 which then calls the old AddrCleanLib.CleanAddress183
Bug #13335

By calling this doxie function first the roxie queries will not need to include the Address import.

*/

import Address;

export CleanAddress183(const string addrline, const string lastline)
       := function  

  clean := Address.CleanAddress183(addrline, lastline);  
  return clean; 

end;  // Function