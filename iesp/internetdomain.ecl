 /* This is Generated code.  Do not modify this attribute directly, 
			or if you do please modify the ESDL interface definiton to match */

export internetdomain := MODULE
			
export t_InetDomainSearchBy := record
	string120 CompanyName {xpath('CompanyName')};
	string46 DomainName {xpath('DomainName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_InetDomainOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_InetDomainPerson := record
	string46 Name {xpath('Name')};
	string40 EMail {xpath('EMail')};
	dataset(share.t_StringArrayItem) InetDomainAddress {xpath('InetDomainAddress/Line'), MAXCOUNT(iesp.constants.INTERNETDOMAIN_MAX_COUNT_ADDRESSES)};
end;
		
export t_InetDomainRecord := record
	string46 DomainName {xpath('DomainName')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date DateLastUpdated {xpath('DateLastUpdated')};
	share.t_Date DateExpires {xpath('DateExpires')};
	share.t_Date DateCreated {xpath('DateCreated')};
	share.t_Date DateDatabase {xpath('DateDatabase')};
	t_InetDomainPerson Registrant {xpath('Registrant')};
	t_InetDomainPerson AdministrativeContact {xpath('AdministrativeContact')};
	t_InetDomainPerson TechnicalContact {xpath('TechnicalContact')};
end;
		
export t_InetDomainSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_InetDomainRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.INTERNETDOMAIN_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_InetDomainSearchRequest := record (share.t_BaseRequest)
	t_InetDomainSearchBy SearchBy {xpath('SearchBy')};
	t_InetDomainOption Options {xpath('Options')};
end;
		
export t_InetDomainSearchResponseEx := record
	t_InetDomainSearchResponse response {xpath('response')};
end;
		

end;

