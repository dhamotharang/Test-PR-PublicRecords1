export enhancedbizsearch := MODULE
			
export t_EnhancedBusinessSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean BDIDOnly {xpath('BDIDOnly')};
	boolean ExactOnly {xpath('ExactOnly')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean ExcludeBlankAddresses {xpath('ExcludeBlankAddresses')};
end;
		
export t_EnhancedBusinessSearchBy := record
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string MileRadius {xpath('MileRadius')};
	string SSN {xpath('SSN')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
	string BusinessId {xpath('BusinessId')};
	string ParentBusinessId {xpath('ParentBusinessId')};
	share.t_Name ExecutiveName {xpath('ExecutiveName')};
end;
		
export t_EnhancedBusinessSearchRecord := record
	string ParentBusinessID {xpath('ParentBusinessID')};
	string BusinessID {xpath('BusinessID')};
	string ParentCompanyName {xpath('ParentCompanyName')};
	share.t_Address ParentCompanyAddress {xpath('ParentCompanyAddress')};
	tsunami.t_BusinessSourceFlags SourceFlags {xpath('SourceFlags')};
	dataset(share.t_StringArrayItem) Names {xpath('Names/CompanyName'), MAXCOUNT(1)};
	dataset(tsunami.t_AddressWithPhones) AddressesWithPhones {xpath('AddressesWithPhones/AddressWithPhones'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) FEINs {xpath('FEINs/FEIN'), MAXCOUNT(1)};
	dataset(tsunami.t_Exec) Executives {xpath('Executives/Executive'), MAXCOUNT(1)};
end;
		
export t_EnhancedBusinessSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_EnhancedBusinessSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_EnhancedBusinessSearchRequest := record (share.t_BaseRequest)
	t_EnhancedBusinessSearchOptions Options {xpath('Options')};
	t_EnhancedBusinessSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_EnhancedBusinessSearchResponseEx := record
	t_EnhancedBusinessSearchResponse response {xpath('response')};
end;
		

end;

