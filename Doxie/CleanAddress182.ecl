/*

This wrapper calls Address.CallCleanAddress182 which then calls the old AddrCleanLib.CleanAddress182
Bug #13335

By calling this doxie function first the roxie queries will not need to include the Address import.

*/

import Address;

export CleanAddress182(const string addrline, const string lastline)
       := function  

  clean := Address.CleanAddress182(addrline, lastline);  
  return clean; 

end;  // Function