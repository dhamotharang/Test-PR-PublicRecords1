﻿EXPORT fnValidCounty(string input):= function
Set of String CountyList:=['MIAMI-DADE','RIVERSIDE','ORANGE','BROWARD','HILLSBOROUGH','BREVARD','VOLUSIA','POLK','INDIAN RIVER','MARION','LAKE','CHARLOTTE','ALACHUA','SARASOTA','ST LUCIE','CITRUS','HERNANDO','MARTIN','EL DORADO','FLAGLER','MONROE','BAKER'];

return if(input in CountyList,1,0);

end;;