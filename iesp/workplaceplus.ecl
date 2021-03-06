/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from workplaceplus.xml. ***/
/*===================================================*/

export workplaceplus := MODULE
			
export t_WorkPlacePlusSearchBy := record (workplace.t_WPSearchBy)
	string CompanyName {xpath('CompanyName')};
end;
		
export t_WorkPlacePlusSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean IncludeSpouseData {xpath('IncludeSpouseData')};
	boolean IncludeSecretaryOfStateInfo {xpath('IncludeSecretaryOfStateInfo')};
	string ExcludedSources {xpath('ExcludedSources')};//hidden[internal]
end;
		
export t_WorkPlacePlusSearchRecord := record (workplace.t_WPSearchRecord)
end;
		
export t_WorkPlacePlusSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_WorkPlacePlusSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.WP_PLUS_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_WorkPlacePlusSearchRequest := record (share.t_BaseRequest)
	t_WorkPlacePlusSearchBy SearchBy {xpath('SearchBy')};
	t_WorkPlacePlusSearchOption Options {xpath('Options')};
end;
		
export t_WorkPlacePlusSearchResponseEx := record
	t_WorkPlacePlusSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from workplaceplus.xml. ***/
/*===================================================*/

