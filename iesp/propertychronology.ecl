export propertychronology := MODULE
			
export t_PropertyChronologyReportOption := record (share.t_BaseReportOption)
end;
		
export t_PropertyChronologyReportBy := record
	string ParcelId {xpath('ParcelId')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_PropertyDocument := record
	string Book {xpath('Book')};
	string Page {xpath('Page')};
	string Number {xpath('Number')};
end;
		
export t_ChronologyPropertyRecord := record
	string ParcelNumber {xpath('ParcelNumber')};
	string AlternateParcelNumber {xpath('AlternateParcelNumber')};
	string ParcelId {xpath('ParcelId')};
	string SubdivisionName {xpath('SubdivisionName')};
	string LandUse {xpath('LandUse')};
	integer YearBuilt {xpath('YearBuilt')};
	string LandValue {xpath('LandValue')};
	string ImprovementValue {xpath('ImprovementValue')};
	string TotalValue {xpath('TotalValue')};
	string AssessedValue {xpath('AssessedValue')};
	string TaxAmount {xpath('TaxAmount')};
	string MarketLandValue {xpath('MarketLandValue')};
	string MarketImprovementValue {xpath('MarketImprovementValue')};
	string TotalMarketValue {xpath('TotalMarketValue')};
	integer TaxYear {xpath('TaxYear')};
	integer LivingSize {xpath('LivingSize')};
	integer LandSize {xpath('LandSize')};
	integer Stories {xpath('Stories')};
	integer Bedrooms {xpath('Bedrooms')};
	integer FullBaths {xpath('FullBaths')};
	integer HalfBaths {xpath('HalfBaths')};
	string Condition {xpath('Condition')};
	boolean Fireplace {xpath('Fireplace')};
	boolean Pool {xpath('Pool')};
	string AirConditioning {xpath('AirConditioning')};
	string Heating {xpath('Heating')};
	string Fuel {xpath('Fuel')};
	string Sewer {xpath('Sewer')};
	string Water {xpath('Water')};
	string Electric {xpath('Electric')};
	string Frame {xpath('Frame')};
	string Roof {xpath('Roof')};
	string LegalDescription {xpath('LegalDescription')};
	string Style {xpath('Style')};
end;
		
export t_RiskAssessedAddress := record (share.t_Address)
	share.t_HRIWarning Warning {xpath('Warning')};
end;
		
export t_RiskAssessedSSNInfo := record (share.t_SSNInfo)
	boolean RecentlyIssued {xpath('RecentlyIssued')};
	boolean IssuedPriorToDOB {xpath('IssuedPriorToDOB')};
	boolean Deceased {xpath('Deceased')};
	share.t_Date LastReported {xpath('LastReported')};
end;
		
export t_PropertyChronologyIndividual := record
	share.t_Name Name {xpath('Name')};
	t_RiskAssessedAddress CurrentAddress {xpath('CurrentAddress')};
	share.t_AddressEx CurrentAddressX {xpath('CurrentAddressX')};
	string Description {xpath('Description')};
	share.t_PhoneInfo Phone {xpath('Phone')};
	share.t_PhoneInfoEx PhoneEx {xpath('PhoneEx')};
	boolean MortgageFraudArea {xpath('MortgageFraudArea')};
	string UniqueId {xpath('UniqueId')};
	t_RiskAssessedSSNInfo RiskAssessedSSNInfo {xpath('RiskAssessedSSNInfo')};
end;
		
export t_PropertyChronologyResident := record
	share.t_Name Name {xpath('Name')};
	t_RiskAssessedSSNInfo RiskAssessedSSNInfo {xpath('RiskAssessedSSNInfo')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_PhoneInfo Phone {xpath('Phone')};
	string UniqueId {xpath('UniqueId')};
end;
		
export t_PropertyChronologyDeedRecord := record
	t_RiskAssessedAddress MailingAddress {xpath('MailingAddress')};
	share.t_AddressEx MailingAddressX {xpath('MailingAddressX')};
	share.t_Date MortgageDate {xpath('MortgageDate')};
	string LenderName {xpath('LenderName')};
	string LenderType {xpath('LenderType')};
	string MortgageAmount {xpath('MortgageAmount')};
	string MortgageTerm {xpath('MortgageTerm')};
	string MortgageTermUnits {xpath('MortgageTermUnits')};
	string MortgageLoanType {xpath('MortgageLoanType')};
	string MortgageDeedSubtype {xpath('MortgageDeedSubtype')};
	string MortgageDeedType {xpath('MortgageDeedType')};
	string DocumentType {xpath('DocumentType')};
	string TransactionType {xpath('TransactionType')};
	share.t_Date RecordingDate {xpath('RecordingDate')};
	t_PropertyDocument PropertyDocument {xpath('PropertyDocument')};
end;
		
export t_PropertyChronologySaleRecord := record
	string TitleCompanyName {xpath('TitleCompanyName')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string SalePrice {xpath('SalePrice')};
	share.t_Date RecordedDate {xpath('RecordedDate')};
	t_PropertyDocument PropertyDocument {xpath('PropertyDocument')};
	dataset(t_PropertyChronologyIndividual) Buyers {xpath('Buyers/Buyer'), MAXCOUNT(1)};
	dataset(t_PropertyChronologyIndividual) Sellers {xpath('Sellers/Seller'), MAXCOUNT(1)};
end;
		
export t_PropertyChronologyTransaction := record
	string SourcePropertyRecordId {xpath('SourcePropertyRecordId')};
	boolean MailingSameAsPropertyAddress {xpath('MailingSameAsPropertyAddress')};
	boolean PartiesAtSameAddress {xpath('PartiesAtSameAddress')};
	t_PropertyChronologyDeedRecord Deed {xpath('Deed')};
	t_PropertyChronologySaleRecord Sale {xpath('Sale')};
	dataset(share.t_StringArrayItem) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;
		
export t_PropertyChronologySummary := record
	integer TotalDeedTransfers {xpath('TotalDeedTransfers')};
	integer TotalDeedTransferPeriod {xpath('TotalDeedTransferPeriod')};
	boolean VacantLot {xpath('VacantLot')};
	integer LastDeedTranfer {xpath('LastDeedTranfer')};
	integer LastDeedTransfer {xpath('LastDeedTransfer')};
	integer PeriodSinceOwnerVacatedProperty {xpath('PeriodSinceOwnerVacatedProperty')};
	share.t_Date LastSaleDate {xpath('LastSaleDate')};
	dataset(share.t_StringArrayItem) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;
		
export t_PropertyChronologyReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_RiskAssessedAddress Address {xpath('Address')};
	share.t_AddressEx AddressX {xpath('AddressX')};
	t_RiskAssessedAddress MailingAddress {xpath('MailingAddress')};
	share.t_AddressEx MailingAddressX {xpath('MailingAddressX')};
	t_ChronologyPropertyRecord PropertyRecord {xpath('PropertyRecord')};
	t_PropertyChronologySummary Summary {xpath('Summary')};
	dataset(t_PropertyChronologyIndividual) Owners {xpath('Owners/Owner'), MAXCOUNT(1)};
	dataset(t_PropertyChronologyTransaction) Transactions {xpath('Transactions/Transaction'), MAXCOUNT(1)};
	dataset(t_PropertyChronologyResident) Residents {xpath('Residents/Resident'), MAXCOUNT(1)};
end;
		
export t_PropertyChronologyReportRequest := record (share.t_BaseRequest)
	t_PropertyChronologyReportOption Options {xpath('Options')};
	t_PropertyChronologyReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_PropertyChronologyReportResponseEx := record
	t_PropertyChronologyReportResponse response {xpath('response')};
end;
		

end;

