export taxpayerinfo := MODULE
			
export t_TaxpayerInfoSearchBy := record (share.t_BaseSearchBy)
	string UniqureId {xpath('UniqureId')};
	string BusinessId {xpath('BusinessId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Telephone {xpath('Telephone')};
	string TaxpayerNumber {xpath('TaxpayerNumber')};
	string BusinessName {xpath('BusinessName')};
end;
		
export t_TaxpayerInfoSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_TaxpayerInfo := record
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Telephone {xpath('Telephone')};
	integer TaxpayerNumber {xpath('TaxpayerNumber')};
	string TaxpayerNumber2 {xpath('TaxpayerNumber2')};
	string OrganizationType {xpath('OrganizationType')};
end;
		
export t_OutletInfo := record
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Telephone {xpath('Telephone')};
	integer StandardIndustrialClassification {xpath('StandardIndustrialClassification')};
	share.t_Date PermitIssedDate {xpath('PermitIssedDate')};
	share.t_Date FirstSaleDate {xpath('FirstSaleDate')};
end;
		
export t_TaxpayerInfoSearchRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	t_TaxpayerInfo Taxpayer {xpath('Taxpayer')};
	dataset(t_OutletInfo) Outlets {xpath('Outlets/Outlet'), MAXCOUNT(1)};
end;
		
export t_TaxpayerInfoSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_TaxpayerInfoSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_TaxpayerInfoSearchRequest := record (share.t_BaseRequest)
	t_TaxpayerInfoSearchBy SearchBy {xpath('SearchBy')};
	t_TaxpayerInfoSearchOption Options {xpath('Options')};
end;
		
export t_TaxpayerInfoSearchResponseEx := record
	t_TaxpayerInfoSearchResponse response {xpath('response')};
end;
		

end;

