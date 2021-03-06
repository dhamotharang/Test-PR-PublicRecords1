/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from huntingfishing.xml. ***/
/*===================================================*/

export huntingfishing := MODULE
			
export t_HuntFishSearchBy := record
	string11 SSN {xpath('SSN')};
	string10 Phone10 {xpath('Phone10')};
	string12 UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_HuntFishOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_HuntFishRecord := record
	integer _Penalty {xpath('Penalty')};//hidden[ecldev]
	boolean AlsoFound {xpath('AlsoFound')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Address MailAddress {xpath('MailAddress')};
	share.t_Date LicenseDate {xpath('LicenseDate')};
	share.t_Date DOB {xpath('DOB')};
	string15 LicenseNumber {xpath('LicenseNumber')};
	string20 LicenseType {xpath('LicenseType')};
	string20 LicenseState {xpath('LicenseState')};
	string20 HomeState {xpath('HomeState')};
	string30 Occupation {xpath('Occupation')};
	string6 Sex {xpath('Sex')};
	string9 SSN {xpath('SSN')};
	string12 UniqueId {xpath('UniqueId')};
	string20 Race {xpath('Race')};
end;
		
export t_HuntFishSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_HuntFishRecord) Records {xpath('Records/Record'), MAXCOUNT(Constants.HF_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_HuntFishSearchRequest := record (share.t_BaseRequest)
	t_HuntFishSearchBy SearchBy {xpath('SearchBy')};
	t_HuntFishOption Options {xpath('Options')};
end;
		
export t_HuntFishSearchResponseEx := record
	t_HuntFishSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from huntingfishing.xml. ***/
/*===================================================*/

