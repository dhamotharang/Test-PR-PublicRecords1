/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from business.xml. ***/
/*===================================================*/

export business := MODULE
			
export t_BusinessSearchBy := record
	string CompanyName {xpath('CompanyName')};
	string FEIN {xpath('FEIN')};
	string PhoneNumber {xpath('PhoneNumber')};
	string SSN {xpath('SSN')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	integer Radius {xpath('Radius')};
end;
		
export t_BusinessOption := record (share.t_BaseSearchOption)
	boolean IncludeAllContacts {xpath('IncludeAllContacts')};
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_BusinessRecord := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	string Title {xpath('Title')};
	string TimeZone {xpath('TimeZone')};
	string Phone10 {xpath('Phone10')};
	string CompanyName {xpath('CompanyName')};
	string FEIN {xpath('FEIN')};
	string BusinessId {xpath('BusinessId')};
	boolean Verified {xpath('Verified')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_BusinessSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_BusinessRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_BusinessSearchRequest := record (share.t_BaseRequest)
	t_BusinessSearchBy SearchBy {xpath('SearchBy')};
	t_BusinessOption Options {xpath('Options')};
end;
		
export t_BusinessSearchResponseEx := record
	t_BusinessSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from business.xml. ***/
/*===================================================*/

