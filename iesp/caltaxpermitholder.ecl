export caltaxpermitholder := MODULE
			
export t_CalTaxPermitHolderSearchBy := record (share.t_BaseSearchBy)
	string BusinessId {xpath('BusinessId')};
	string BusinessName {xpath('BusinessName')};
	string PermitHolderNumber {xpath('PermitHolderNumber')};
	share.t_Name OwnerName {xpath('OwnerName')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_CalTaxPermitHolderSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_CalTaxPermitHolderSearchRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	string BusinessId {xpath('BusinessId')};
	string BusinessName {xpath('BusinessName')};
	share.t_Name OwnerName {xpath('OwnerName')};
	share.t_UniversalAddress BusinessAddress {xpath('BusinessAddress')};
	share.t_UniversalAddress MailingAddress {xpath('MailingAddress')};
	string OwnershipCode {xpath('OwnershipCode')};
	share.t_Date StartDate {xpath('StartDate')};
	string IndustryCode {xpath('IndustryCode')};
	string PermitHolderNumber {xpath('PermitHolderNumber')};
	string TaxCode {xpath('TaxCode')};
end;
		
export t_CalTaxPermitHolderSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_CalTaxPermitHolderSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_CalTaxPermitHolderSearchRequest := record (share.t_BaseRequest)
	t_CalTaxPermitHolderSearchBy SearchBy {xpath('SearchBy')};
	t_CalTaxPermitHolderSearchOption Options {xpath('Options')};
end;
		
export t_CalTaxPermitHolderSearchResponseEx := record
	t_CalTaxPermitHolderSearchResponse response {xpath('response')};
end;
		

end;

