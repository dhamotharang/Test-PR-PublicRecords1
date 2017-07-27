/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from emailsearch.xml. ***/
/*===================================================*/

export emailsearch := MODULE
			
export t_EmailSearchBy := record
	string12 UniqueId {xpath('UniqueId')};
	string60 Email {xpath('Email')};
	string11 SSN {xpath('SSN')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_EmailSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean AllowMultipleResults {xpath('AllowMultipleResults')};//hidden[internal]
end;
		
export t_EmailSearchEmail := record
	string60 EmailAddress {xpath('EmailAddress')};
	string60 WebSite {xpath('WebSite')};
	share.t_Date LoginDate {xpath('LoginDate')};
end;
		
export t_EmailSearchRecord := record
	string12 UniqueId {xpath('UniqueId')};
	string12 EmailId {xpath('EmailId')};//hidden[internal]
	string9 SSN {xpath('SSN')};
	dataset(share.t_Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.Email.MAX_NAMES_PER_PERSON)};
	dataset(share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.Email.MAX_ADDRS_PER_PERSON)};
	dataset(t_EmailSearchEmail) Emails {xpath('Emails/Email'), MAXCOUNT(iesp.Constants.Email.MAX_EMAILS_PER_PERSON)};
	share.t_Date DOB {xpath('DOB')};
	boolean AlsoFound {xpath('AlsoFound')};
	string2 Source {xpath('Source')};//hidden[internal]
end;
		
export t_EmailSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_EmailSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.Email.MAX_RECS_PER_DID)};
	dataset(share.t_InfoMessage) Messages {xpath('Messages/Message'), MAXCOUNT(iesp.Constants.Email.MAX_MSGS_PER_DID)};
end;
		
export t_EmailSearchRequest := record (share.t_BaseRequest)
	t_EmailSearchBy SearchBy {xpath('SearchBy')};
	t_EmailSearchOption Options {xpath('Options')};
end;
		
export t_EmailSearchResponseEx := record
	t_EmailSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from emailsearch.xml. ***/
/*===================================================*/
