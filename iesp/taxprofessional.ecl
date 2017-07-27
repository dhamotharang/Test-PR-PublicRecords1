export taxprofessional := MODULE
			
export t_TaxProfessionalSearchBy := record (share.t_BaseSearchBy)
	string UniqureId {xpath('UniqureId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_TaxProfessionalSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_TaxProfessionalSearchRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	integer UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	share.t_Name Name {xpath('Name')};
	share.t_UniversalAddress Address {xpath('Address')};
	integer BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	string Occupation {xpath('Occupation')};
	integer EnrollYear {xpath('EnrollYear')};
end;
		
export t_TaxProfessionalSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_TaxProfessionalSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_TaxProfessionalSearchRequest := record (share.t_BaseRequest)
	t_TaxProfessionalSearchBy SearchBy {xpath('SearchBy')};
	t_TaxProfessionalSearchOption Options {xpath('Options')};
end;
		
export t_TaxProfessionalSearchResponseEx := record
	t_TaxProfessionalSearchResponse response {xpath('response')};
end;
		

end;

