/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from peopleatwork.xml. ***/
/*===================================================*/

export peopleatwork := MODULE
			
export t_PeopleAtWorkSearchBy := record
	string SSN {xpath('SSN')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
	string CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_PeopleAtWorkSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_PeopleAtWorkRecord := record
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	string1 ConfidenceLevel {xpath('ConfidenceLevel')};
	boolean Verified {xpath('Verified')};
	share.t_Name Name {xpath('Name')};
	string12 UniqueId {xpath('UniqueId')};
	string35 Title {xpath('Title')};
	string9 SSN {xpath('SSN')};
	string60 EMail {xpath('EMail')};
	string10 Phone10 {xpath('Phone10')};
	string6 Gender {xpath('Gender')};
	string4 TimeZone {xpath('TimeZone')};
	string4 CompanyTimeZone {xpath('CompanyTimeZone')};
	string120 CompanyName {xpath('CompanyName')};
	string35 Department {xpath('Department')};
	string9 FEIN {xpath('FEIN')};
	string12 BusinessId {xpath('BusinessId')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_PeopleAtWorkSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_PeopleAtWorkRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_PeopleAtWorkSearch2By := record
	string SSN {xpath('SSN')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
	string CompanyName {xpath('CompanyName')};
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_PeopleAtWorkSearch2Option := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean IncludeCriminalIndicators {xpath('IncludeCriminalIndicators')};//hidden[internal]
end;
		
export t_DateSeen := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_Position := record
	dataset(t_DateSeen) DatesSeen {xpath('DatesSeen/DateSeen'), MAXCOUNT(1)};
	string Title {xpath('Title')};
	string Department {xpath('Department')};
end;
		
export t_PeopleAtWorkPhone := record (share.t_PhoneTimeZone)
	boolean Verified {xpath('Verified')};
end;
		
export t_PeopleAtWorkAddressWithPhones := record (share.t_Address)
	dataset(t_PeopleAtWorkPhone) Phones {xpath('Phones/Phone'), MAXCOUNT(1)};
end;
		
export t_Employer := record
	string BusinessId {xpath('BusinessId')};
	dataset(t_DateSeen) DatesSeen {xpath('DatesSeen/DateSeen'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) FEINs {xpath('FEINs/FEIN'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) CompanyNames {xpath('CompanyNames/CompanyName'), MAXCOUNT(1)};
	dataset(t_PeopleAtWorkAddressWithPhones) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
	dataset(t_Position) Positions {xpath('Positions/Position'), MAXCOUNT(1)};
end;
		
export t_PeopleAtWorkSearch2Record := record (share.t_CriminalIndicators)
	boolean AlsoFound {xpath('AlsoFound')};
	string UniqueId {xpath('UniqueId')};
	dataset(share.t_StringArrayItem) SSNs {xpath('SSNs/SSN'), MAXCOUNT(1)};
	dataset(share.t_Name) Names {xpath('Names/Name'), MAXCOUNT(1)};
	dataset(t_Employer) Employers {xpath('Employers/Employer'), MAXCOUNT(1)};
	bpssearch.t_BpsRecordCounts RecordCounts {xpath('RecordCounts')};//hidden[internal]
end;
		
export t_PeopleAtWorkSearch2Response := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_PeopleAtWorkSearch2Record) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_PeopleAtWorkSearchRequest := record (share.t_BaseRequest)
	t_PeopleAtWorkSearchBy SearchBy {xpath('SearchBy')};
	t_PeopleAtWorkSearchOption Options {xpath('Options')};
end;
		
export t_PeopleAtWorkSearch2Request := record (share.t_BaseRequest)
	t_PeopleAtWorkSearch2By SearchBy {xpath('SearchBy')};
	t_PeopleAtWorkSearch2Option Options {xpath('Options')};
end;
		
export t_PeopleAtWorkSearchResponseEx := record
	t_PeopleAtWorkSearchResponse response {xpath('response')};
end;
		
export t_PeopleAtWorkSearch2ResponseEx := record
	t_PeopleAtWorkSearch2Response response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from peopleatwork.xml. ***/
/*===================================================*/

