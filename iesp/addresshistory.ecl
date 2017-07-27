export addresshistory := MODULE
			
export t_AddressHistoryReportOption := record (share.t_BaseReportOption)
end;
		
export t_AddressHistoryReportBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string UniqueId {xpath('UniqueId')};
	string CompanyName {xpath('CompanyName')};
	string BusinessId {xpath('BusinessId')};
end;
		
export t_AddressHistoryResident := record
	share.t_Name Name {xpath('Name')};
	string UniqueId {xpath('UniqueId')};
end;
		
export t_AddressHistoryAddress := record
	boolean OwnedBySubject {xpath('OwnedBySubject')};
	share.t_AddressEx Address {xpath('Address')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	dataset(share.t_PhoneInfo) Phones {xpath('Phones/Phone'), MAXCOUNT(1)};
end;
		
export t_AddressHistoryProperty := record
	boolean OwnerIsResident {xpath('OwnerIsResident')};
	boolean Foreclosure {xpath('Foreclosure')};
	string SalePrice {xpath('SalePrice')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string PurchasePrice {xpath('PurchasePrice')};
	share.t_Date PurchaseDate {xpath('PurchaseDate')};
	share.t_Date RefinanceDate {xpath('RefinanceDate')};
	integer YearsOwned {xpath('YearsOwned')};
	string NetProfitFromSale {xpath('NetProfitFromSale')};
	string PercentChangeOnSale {xpath('PercentChangeOnSale')};
	share.t_AddressEx Address {xpath('Address')};
	dataset(share.t_StringArrayItem) Sellers {xpath('Sellers/Seller'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Purchasers {xpath('Purchasers/Purchaser'), MAXCOUNT(1)};
	dataset(share.t_PhoneInfo) Phones {xpath('Phones/Phone'), MAXCOUNT(1)};
	dataset(t_AddressHistoryResident) Residents {xpath('Residents/Resident'), MAXCOUNT(1)};
end;
		
export t_AddressHistoryRecord := record
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	integer PropertiesOwned {xpath('PropertiesOwned')};
	integer PropertiesSold {xpath('PropertiesSold')};
	integer Age {xpath('Age')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	boolean Deceased {xpath('Deceased')};
	integer AgeAtDeath {xpath('AgeAtDeath')};
	string DeathCounty {xpath('DeathCounty')};
	string DeathState {xpath('DeathState')};
	string DeathVerificationCode {xpath('DeathVerificationCode')};
	t_AddressHistoryAddress CurrentAddress {xpath('CurrentAddress')};
	dataset(t_AddressHistoryAddress) PreviousAddresses {xpath('PreviousAddresses/PreviousAddress'), MAXCOUNT(1)};
	dataset(share.t_PhoneInfo) Phoness {xpath('Phoness/Phone'), MAXCOUNT(1)};
	dataset(share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(1)};
	dataset(t_AddressHistoryProperty) CurrentProperties {xpath('CurrentProperties/Property'), MAXCOUNT(1)};
	dataset(t_AddressHistoryProperty) PreviousProperties {xpath('PreviousProperties/Property'), MAXCOUNT(1)};
end;
		
export t_AddressHistoryReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_AddressHistoryRecord) AddressHistories {xpath('AddressHistories/AddressHistory'), MAXCOUNT(1)};
end;
		
export t_AddressHistoryReportRequest := record (share.t_BaseRequest)
	t_AddressHistoryReportOption Options {xpath('Options')};
	t_AddressHistoryReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_AddressHistoryReportResponseEx := record
	t_AddressHistoryReportResponse response {xpath('response')};
end;
		

end;

