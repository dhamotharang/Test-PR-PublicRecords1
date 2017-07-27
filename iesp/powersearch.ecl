/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from powersearch.xml. ***/
/*===================================================*/

export powersearch := MODULE
			
export t_PowerSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean TermsAndConnectors {xpath('TermsAndConnectors')};
	boolean RankBooleanResult {xpath('RankBooleanResult')};
end;
		
export t_PowerSearchBy := record (share.t_BaseSearchBy)
end;
		
export t_PowerSearchRecord := record
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	string1 Deceased {xpath('Deceased')}; //values['U','Y','N','']
	string12 UniqueId {xpath('UniqueId')};
	string12 BusinessId {xpath('BusinessId')};
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	share.t_Date LastSeen {xpath('LastSeen')};
	string10 SourceDocType {xpath('SourceDocType')};
	string62 RecordId {xpath('RecordId')};
	string120 CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
	string9 SSN {xpath('SSN')};
	string9 FEIN {xpath('FEIN')};
end;
		
export t_PowerSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_PowerSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.POWERSRCH.SEARCH_MAX_COUNT_RESPONSE_RECORDS)};
end;
		
export t_PowerSearchRequest := record (share.t_BaseRequest)
	t_PowerSearchOption Options {xpath('Options')};
	t_PowerSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_PowerSearchResponseEx := record
	t_PowerSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from powersearch.xml. ***/
/*===================================================*/

