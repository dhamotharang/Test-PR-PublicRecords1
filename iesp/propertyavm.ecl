export propertyavm := MODULE
			
export t_PropertyAVMReportOption := record (share.t_BaseReportOption)
end;
		
export t_PropertyAVMReportBy := record
	string ParcelId {xpath('ParcelId')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_PropertyAVMDocument := record
	string Book {xpath('Book')};
	string Page {xpath('Page')};
	string Number {xpath('Number')};
end;
		
export t_PropertyAVMPropertyRecord := record
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
		
export t_AVMSSNInfo := record (share.t_SSNInfo)
	boolean RecentlyIssued {xpath('RecentlyIssued')};
	boolean IssuedPriorToDOB {xpath('IssuedPriorToDOB')};
	boolean Deceased {xpath('Deceased')};
	share.t_Date LastReported {xpath('LastReported')};
end;
		
export t_PropertyAVMIndividual := record
	share.t_Name Name {xpath('Name')};
	share.t_AddressEx CurrentAddress {xpath('CurrentAddress')};
	share.t_PhoneInfoEx Phone {xpath('Phone')};
	boolean MortgageFraudArea {xpath('MortgageFraudArea')};
	string UniqueId {xpath('UniqueId')};
	t_AVMSSNInfo RiskAssessedSSNInfo {xpath('RiskAssessedSSNInfo')};
end;
		
export t_PropertyAVMResident := record
	share.t_Name Name {xpath('Name')};
	t_AVMSSNInfo RiskAssessedSSNInfo {xpath('RiskAssessedSSNInfo')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_PhoneInfo Phone {xpath('Phone')};
	string UniqueId {xpath('UniqueId')};
end;
		
export t_PropertyAVMDeedRecord := record
	share.t_AddressEx MailingAddress {xpath('MailingAddress')};
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
	t_PropertyAVMDocument PropertyDocument {xpath('PropertyDocument')};
end;
		
export t_PropertyAVMSaleRecord := record
	string TitleCompanyName {xpath('TitleCompanyName')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string SalePrice {xpath('SalePrice')};
	share.t_Date RecordedDate {xpath('RecordedDate')};
	t_PropertyAVMDocument PropertyDocument {xpath('PropertyDocument')};
	dataset(t_PropertyAVMIndividual) Buyers {xpath('Buyers/Buyer'), MAXCOUNT(1)};
	dataset(t_PropertyAVMIndividual) Sellers {xpath('Sellers/Seller'), MAXCOUNT(1)};
end;
		
export t_PropertyAVMTransaction := record
	string SourcePropertyRecordId {xpath('SourcePropertyRecordId')};
	boolean MailingSameAsPropertyAddress {xpath('MailingSameAsPropertyAddress')};
	boolean PartiesAtSameAddress {xpath('PartiesAtSameAddress')};
	t_PropertyAVMDeedRecord Deed {xpath('Deed')};
	t_PropertyAVMSaleRecord Sale {xpath('Sale')};
	dataset(share.t_StringArrayItem) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;
		
export t_PropertyAVMSummary := record
	integer TotalDeedTransfers {xpath('TotalDeedTransfers')};
	integer TotalDeedTransferPeriod {xpath('TotalDeedTransferPeriod')};
	boolean VacantLot {xpath('VacantLot')};
	integer LastDeedTransfer {xpath('LastDeedTransfer')};
	integer PeriodSinceOwnerVacatedProperty {xpath('PeriodSinceOwnerVacatedProperty')};
	share.t_Date LastSaleDate {xpath('LastSaleDate')};
	dataset(share.t_StringArrayItem) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;
		
export t_PropertyAVMNeighborSale := record
	string FaresId {xpath('FaresId')};
	share.t_Address Address {xpath('Address')};
	real4 Distance {xpath('Distance')};
	string LandUse {xpath('LandUse')};
	share.t_Date RecordingDate {xpath('RecordingDate')};
	integer SalesPrice {xpath('SalesPrice')};
	integer AssessedValueYear {xpath('AssessedValueYear')};
	integer AssessedTotalValue {xpath('AssessedTotalValue')};
	integer TotalMarketValue {xpath('TotalMarketValue')};
	integer YearBuilt {xpath('YearBuilt')};
	string LotSize {xpath('LotSize')};
	integer BuildingArea {xpath('BuildingArea')};
	integer Rooms {xpath('Rooms')};
	integer Bedrooms {xpath('Bedrooms')};
	integer Baths {xpath('Baths')};
	integer Stories {xpath('Stories')};
end;
		
export t_PropertyValuation := record
	string LandUse {xpath('LandUse')};
	share.t_Date RecordingDate {xpath('RecordingDate')};
	integer AssessedValueYear {xpath('AssessedValueYear')};
	integer SalesPrice {xpath('SalesPrice')};
	integer AssessedTotalValue {xpath('AssessedTotalValue')};
	integer TotalMarketValue {xpath('TotalMarketValue')};
	integer TaxAssessmentValuation {xpath('TaxAssessmentValuation')};
	integer PriceIndexValuation {xpath('PriceIndexValuation')};
	integer HedonicValuation {xpath('HedonicValuation')};
	integer AutomatedValuation {xpath('AutomatedValuation')};
	integer ConfidenceScore {xpath('ConfidenceScore')};
	dataset(t_PropertyAVMNeighborSale) ComparableSales {xpath('ComparableSales/Sale'), MAXCOUNT(1)};
	dataset(t_PropertyAVMNeighborSale) NearbySales {xpath('NearbySales/Sale'), MAXCOUNT(1)};
end;
		
export t_PropertyAVMReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	share.t_AddressEx Address {xpath('Address')};
	share.t_AddressEx MailingAddress {xpath('MailingAddress')};
	t_PropertyAVMPropertyRecord PropertyRecord {xpath('PropertyRecord')};
	t_PropertyAVMSummary Summary {xpath('Summary')};
	t_PropertyValuation PropertyValuation {xpath('PropertyValuation')};
	dataset(t_PropertyAVMIndividual) Owners {xpath('Owners/Owner'), MAXCOUNT(1)};
	dataset(t_PropertyAVMTransaction) Transactions {xpath('Transactions/Transaction'), MAXCOUNT(1)};
	dataset(t_PropertyAVMResident) Residents {xpath('Residents/Resident'), MAXCOUNT(1)};
end;
		
export t_PropertyAVMReportRequest := record (share.t_BaseRequest)
	t_PropertyAVMReportOption Options {xpath('Options')};
	t_PropertyAVMReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_PropertyAVMReportResponseEx := record
	t_PropertyAVMReportResponse response {xpath('response')};
end;
		

end;

