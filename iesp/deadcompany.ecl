export deadcompany := MODULE
			
export t_DeadCompanySearchBy := record (share.t_BaseSearchBy)
	string BusinessId {xpath('BusinessId')};
	string FullContactName {xpath('FullContactName')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string Phone {xpath('Phone')};
	share.t_Name ContactName {xpath('ContactName')};
end;
		
export t_DeadCompanySearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_BizContactPerson := record
	string ProfessionalTitle {xpath('ProfessionalTitle')};
	share.t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
end;
		
export t_DeadCompanyBaseRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string CarrierCode {xpath('CarrierCode')};
	string Phone {xpath('Phone')};
	t_BizContactPerson ContactPerson {xpath('ContactPerson')};
	string YellowPagesAdvertiseSize {xpath('YellowPagesAdvertiseSize')};
	string BusinessLocationPopulation {xpath('BusinessLocationPopulation')};
	string FirmVsProfessionalPersonIndicator {xpath('FirmVsProfessionalPersonIndicator')};
	integer YearBusinessStarted {xpath('YearBusinessStarted')};
	share.t_Date DateAddedToDB {xpath('DateAddedToDB')};
	share.t_Date ProductionDate {xpath('ProductionDate')};
	string EmployeeSize {xpath('EmployeeSize')};
	string SalesVolume {xpath('SalesVolume')};
	string IndustryTypeSpecifics {xpath('IndustryTypeSpecifics')};
	string BranchOrHeadquarters {xpath('BranchOrHeadquarters')};
	string OfficeSize {xpath('OfficeSize')};
	string AmericanBusinessId {xpath('AmericanBusinessId')};
	string SubsidiaryBusinessIdNumber {xpath('SubsidiaryBusinessIdNumber')};
	string UltimateParentABIBusinessIDNumber {xpath('UltimateParentABIBusinessIDNumber')};
	string PrimarySIC {xpath('PrimarySIC')};
	string TotalCorpEmployeeSize {xpath('TotalCorpEmployeeSize')};
	string TotalCorpSales {xpath('TotalCorpSales')};
	string PublicCompanyIndicator {xpath('PublicCompanyIndicator')};
	string StockExchangeTickerSymbol {xpath('StockExchangeTickerSymbol')};
	string NumberOfActualEmployees {xpath('NumberOfActualEmployees')};
	dataset(share.t_StringArrayItem) Franchises {xpath('Franchises/Franchise'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) SecondarySICs {xpath('SecondarySICs/SecondarySIC'), MAXCOUNT(1)};
end;
		
export t_DeadCompanySearchRecord := record (t_DeadCompanyBaseRecord)
end;
		
export t_DeadCompanySearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_DeadCompanySearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_DeadCompanySearchRequest := record (share.t_BaseRequest)
	t_DeadCompanySearchBy SearchBy {xpath('SearchBy')};
	t_DeadCompanySearchOption Options {xpath('Options')};
end;
		
export t_DeadCompanySearchResponseEx := record
	t_DeadCompanySearchResponse response {xpath('response')};
end;
		

end;

