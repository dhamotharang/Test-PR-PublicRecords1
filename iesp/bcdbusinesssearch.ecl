﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bcdbusinesssearch.xml. ***/
/*===================================================*/

import iesp;

export bcdbusinesssearch := MODULE
			
export t_BcdTopBusinessSearchBy := record (iesp.topbusinesssearch.t_TopBusinessSearchBy)
end;
		
export t_BcdTopBusinessSearchOption := record (iesp.topbusinesssearch.t_TopBusinessSearchOption)
end;
		
export t_BcdTopBusinessSearchRecord := record (iesp.topbusinesssearch.t_TopBusinessSearchRecord)
end;
		
export t_BcdBusinessSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_BcdTopBusinessSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_BcdBusinessSearchRequest := record (iesp.share.t_BaseRequest)
	t_BcdTopBusinessSearchBy SearchBy {xpath('SearchBy')};
	t_BcdTopBusinessSearchOption Options {xpath('Options')};
end;
		
export t_BcdBusinessSearchResponseEx := record
	t_BcdBusinessSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bcdbusinesssearch.xml. ***/
/*===================================================*/

