export usbusinessdirectory := MODULE
			
export t_USBusinessDirectorySearchBy := record (share.t_BaseSearchBy)
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string StateCode {xpath('StateCode')};
	string StateDescription {xpath('StateDescription')};
	string CountyDescription {xpath('CountyDescription')};
	string Phone {xpath('Phone')};
	string ContactProfessionalTitle {xpath('ContactProfessionalTitle')};
	share.t_Name ContactName {xpath('ContactName')};
	string AmericanBusinessIDCompanyNumber {xpath('AmericanBusinessIDCompanyNumber')};
end;
		
export t_USBusinessDirectorySearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_USBizContactPerson := record
	string ProfessionalTitle {xpath('ProfessionalTitle')};
	share.t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
end;
		
export t_USBusinessDirectoryBaseRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string CarrierCode {xpath('CarrierCode')};
	string Phone {xpath('Phone')};
	string SelectedStandardIndustryType {xpath('SelectedStandardIndustryType')};
	string YellowPagesAdvertiseSize {xpath('YellowPagesAdvertiseSize')};
	string BusinessLocationPopulation {xpath('BusinessLocationPopulation')};
	string FirmVsProfessionalPersonIndicator {xpath('FirmVsProfessionalPersonIndicator')};
	integer YearBusinessStarted {xpath('YearBusinessStarted')};
	share.t_Date DateAddedToDB {xpath('DateAddedToDB')};
	string EmployeeSize {xpath('EmployeeSize')};
	string SalesVolume {xpath('SalesVolume')};
	string IndustryTypeSpecifics {xpath('IndustryTypeSpecifics')};
	string BusinessStatus {xpath('BusinessStatus')};
	string OfficeSize {xpath('OfficeSize')};
	share.t_Date ProductionDate {xpath('ProductionDate')};
	string AmericanBusinessIDCompanyNumber {xpath('AmericanBusinessIDCompanyNumber')};
	string SubsidiaryABIBusinessIDNumber {xpath('SubsidiaryABIBusinessIDNumber')};
	string UltimateParentABIBusinessIDNumber {xpath('UltimateParentABIBusinessIDNumber')};
	string PrimarySIC {xpath('PrimarySIC')};
	string TotalEmployeeSize {xpath('TotalEmployeeSize')};
	string TotalOutputSales {xpath('TotalOutputSales')};
	string PublicCompanyIndicator {xpath('PublicCompanyIndicator')};
	string StockExchange {xpath('StockExchange')};
	string StockTickerSymbol {xpath('StockTickerSymbol')};
	string NumberOfEmployeesActual {xpath('NumberOfEmployeesActual')};
	string TotalNumberOfEmployeesActual {xpath('TotalNumberOfEmployeesActual')};
	string Credit {xpath('Credit')};
	dataset(t_USBizContactPerson) ContactPersons {xpath('ContactPersons/ContactPerson'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Franchises {xpath('Franchises/Franchise'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) SecondarySICs {xpath('SecondarySICs/SecondarySIC'), MAXCOUNT(1)};
end;
		
export t_USBusinessDirectorySearchRecord := record (t_USBusinessDirectoryBaseRecord)
end;
		
export t_USBusinessDirectorySearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_USBusinessDirectorySearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_USBusinessDirectorySearchRequest := record (share.t_BaseRequest)
	t_USBusinessDirectorySearchBy SearchBy {xpath('SearchBy')};
	t_USBusinessDirectorySearchOption Options {xpath('Options')};
end;
		
export t_USBusinessDirectorySearchResponseEx := record
	t_USBusinessDirectorySearchResponse response {xpath('response')};
end;
		

end;

