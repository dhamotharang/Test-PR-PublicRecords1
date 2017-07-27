export sourcedoc := MODULE
			
export t_Person := record
	string Phone {xpath('Phone')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_EntityName := record
	share.t_Name Name {xpath('Name')};
	string CompanyName {xpath('CompanyName')};
end;
		
export t_SrcTu := record
	share.t_Date FilingDate {xpath('FilingDate')};
	string RecordType {xpath('RecordType')};
	share.t_Name Name {xpath('Name')};
	string SSN {xpath('SSN')};
	string Phone {xpath('Phone')};
	string DlNumber {xpath('DlNumber')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string Deceased {xpath('Deceased')};
	dataset(share.t_StringArrayItem) Akas {xpath('Akas/Aka'), MAXCOUNT(1)};
end;
		
export t_SrcBankruptcy := record
	string Source {xpath('Source')};
	string ID {xpath('ID')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtState {xpath('CourtState')};
	string CourtName {xpath('CourtName')};
	string CourtCode {xpath('CourtCode')};
	string CourtLocation {xpath('CourtLocation')};
	string Chapter {xpath('Chapter')};
	string RecordType {xpath('RecordType')};
	string OriginalCaseNumber {xpath('OriginalCaseNumber')};
	string FilingStatus {xpath('FilingStatus')};
	string OriginalFilingType {xpath('OriginalFilingType')};
	string OriginalChapter {xpath('OriginalChapter')};
	string CorporationFlag {xpath('CorporationFlag')};
	string MeetingTime {xpath('MeetingTime')};
	string ClaimsDeadline {xpath('ClaimsDeadline')};
	string ComplaintDeadline {xpath('ComplaintDeadline')};
	string Disposition {xpath('Disposition')};
	string JudgeName {xpath('JudgeName')};
	string AssetsForUnsecured {xpath('AssetsForUnsecured')};
	string FilingType {xpath('FilingType')};
	string FilerType {xpath('FilerType')};
	string SelfRepresented {xpath('SelfRepresented')};
	string JudgesIdentification {xpath('JudgesIdentification')};
	string SequenceNumber {xpath('SequenceNumber')};
	share.t_Date CreatedDate {xpath('CreatedDate')};
	share.t_Date ModifiedDate {xpath('ModifiedDate')};
	share.t_Date ClosingDate {xpath('ClosingDate')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	share.t_Date MeetingDate {xpath('MeetingDate')};
	share.t_Date DischargeDate {xpath('DischargeDate')};
	share.t_Date ConvertedDate {xpath('ConvertedDate')};
	share.t_Date ReopenDate {xpath('ReopenDate')};
	share.t_Date FiledDate {xpath('FiledDate')};
	t_Person Trustee {xpath('Trustee')};
	share.t_Address Address {xpath('Address')};
	dataset(t_Person) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(1)};
	dataset(rollupbizreport.t_Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(1)};
end;
		
export t_SrcLienJudgment := record
	string CourtId {xpath('CourtId')};
	string CourtDescription {xpath('CourtDescription')};
	string FilingType {xpath('FilingType')};
	string CaseNumber {xpath('CaseNumber')};
	string Book {xpath('Book')};
	string Page {xpath('Page')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date ReleaseDate {xpath('ReleaseDate')};
	string Amount {xpath('Amount')};
	string Assets {xpath('Assets')};
	string OtherCase {xpath('OtherCase')};
	string OriginalSsn {xpath('OriginalSsn')};
	string Lni {xpath('Lni')};
	share.t_Address Address {xpath('Address')};
	t_EntityName Plaintiff {xpath('Plaintiff')};
	t_EntityName Defendant {xpath('Defendant')};
	string TypeFlag {xpath('TypeFlag')};
end;
		
export t_SrcUcc := record
	string UccKey {xpath('UccKey')};
	string StateOfFiling {xpath('StateOfFiling')};
	string DocumentNumber {xpath('DocumentNumber')};
	share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	share.t_Date FilingDate {xpath('FilingDate')};
	string FilingDescription {xpath('FilingDescription')};
	t_Person Debtor {xpath('Debtor')};
	t_Person Secured {xpath('Secured')};
	dataset(share.t_StringArrayItem) Collateral {xpath('Collateral/Description'), MAXCOUNT(1)};
end;
		
export t_SrcDomainContact := record
	string FullName {xpath('FullName')};
	string Email {xpath('Email')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcInternet := record
	string BusinessId {xpath('BusinessId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string CurrentFlag {xpath('CurrentFlag')};
	string DomainName {xpath('DomainName')};
	share.t_Date DateUpdated {xpath('DateUpdated')};
	share.t_Date ExpireDate {xpath('ExpireDate')};
	share.t_Date DateCreated {xpath('DateCreated')};
	share.t_Address Address {xpath('Address')};
	string RegistrantName {xpath('RegistrantName')};
	t_SrcDomainContact AdministratorContact {xpath('AdministratorContact')};
	t_SrcDomainContact TechnicalContact {xpath('TechnicalContact')};
end;
		
export t_SrcCorpFiling := record
	string RecordType {xpath('RecordType')};
	string BusinessId {xpath('BusinessId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string StateOrigin {xpath('StateOrigin')};
	share.t_Date RecordDate {xpath('RecordDate')};
	string CorporationNumber {xpath('CorporationNumber')};
	string CompanyName {xpath('CompanyName')};
	string EmailAddress {xpath('EmailAddress')};
	string WebAddress {xpath('WebAddress')};
	string TickerSymbol {xpath('TickerSymbol')};
	string StockExchange {xpath('StockExchange')};
	string FEIN {xpath('FEIN')};
	string StateTaxID {xpath('StateTaxID')};
	string Phone10 {xpath('Phone10')};
	string StateOfIncorporation {xpath('StateOfIncorporation')};
	share.t_Date DateOfIncorporation {xpath('DateOfIncorporation')};
	string StatusOfIncorporation {xpath('StatusOfIncorporation')};
	string CorporationStructure {xpath('CorporationStructure')};
	dataset(share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
	dataset(share.t_Name) RegisteredAgents {xpath('RegisteredAgents/Name'), MAXCOUNT(1)};
end;
		
export t_SrcDnb := record
	string BusinessId {xpath('BusinessId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string DUNS {xpath('DUNS')};
	string CompanyName {xpath('CompanyName')};
	string Phone10 {xpath('Phone10')};
	string BusinessDescription {xpath('BusinessDescription')};
	string IndustryGroup {xpath('IndustryGroup')};
	string YearStarted {xpath('YearStarted')};
	share.t_Date IncorporationDate {xpath('IncorporationDate')};
	string IncorporationState {xpath('IncorporationState')};
	string AnnualSalesVolumeSign {xpath('AnnualSalesVolumeSign')};
	string AnnualSalesVolume {xpath('AnnualSalesVolume')};
	string EmployeesHereSign {xpath('EmployeesHereSign')};
	string EmployeesHere {xpath('EmployeesHere')};
	string EmployeesTotalSign {xpath('EmployeesTotalSign')};
	string EmployeesTotal {xpath('EmployeesTotal')};
	string AnnualSalesRevisionDate {xpath('AnnualSalesRevisionDate')};
	string TrendSalesSign {xpath('TrendSalesSign')};
	string TrendSales {xpath('TrendSales')};
	string TrendEmploymentTotalSign {xpath('TrendEmploymentTotalSign')};
	string TrendEmploymentTotal {xpath('TrendEmploymentTotal')};
	string BaseSalesSign {xpath('BaseSalesSign')};
	string BaseSales {xpath('BaseSales')};
	string BaseEmploymentTotalSign {xpath('BaseEmploymentTotalSign')};
	string BaseEmploymentTotal {xpath('BaseEmploymentTotal')};
	string SquareFootage {xpath('SquareFootage')};
	string SalesTerritory {xpath('SalesTerritory')};
	string OwnsRents {xpath('OwnsRents')};
	string NumberOfAccounts {xpath('NumberOfAccounts')};
	string SmallBusinessIndicator {xpath('SmallBusinessIndicator')};
	string MinorityOwned {xpath('MinorityOwned')};
	string CottageIndicator {xpath('CottageIndicator')};
	string ForeignOwned {xpath('ForeignOwned')};
	string ManufacturingHereIndicator {xpath('ManufacturingHereIndicator')};
	string PublicIndicator {xpath('PublicIndicator')};
	string ImporterExporterIndicator {xpath('ImporterExporterIndicator')};
	string StructureType {xpath('StructureType')};
	string EstablishmentType {xpath('EstablishmentType')};
	string OwnsRentsDecoded {xpath('OwnsRentsDecoded')};
	share.t_Address MailingAddress {xpath('MailingAddress')};
	share.t_Address Address {xpath('Address')};
	dataset(rollupbizreport.t_SicCode) Sics {xpath('Sics/SicCode'), MAXCOUNT(1)};
end;
		
export t_SrcBusHeader := record
	string BusinessId {xpath('BusinessId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_SrcBusContact := record
	string BusinessId {xpath('BusinessId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string Phone10 {xpath('Phone10')};
	share.t_Name Name {xpath('Name')};
	string CompanyTitle {xpath('CompanyTitle')};
	string Department {xpath('Department')};
end;
		
export t_SrcContact := record
	string Name {xpath('Name')};
	string Title {xpath('Title')};
end;
		
export t_SrcDca := record
	string BusinessId {xpath('BusinessId')};
	share.t_Date ProcessDate {xpath('ProcessDate')};
	string EnterpriseNumber {xpath('EnterpriseNumber')};
	string TypeOrig {xpath('TypeOrig')};
	string CompanyName {xpath('CompanyName')};
	string Note {xpath('Note')};
	string Level {xpath('Level')};
	string Root {xpath('Root')};
	string Sub {xpath('Sub')};
	string ParentName {xpath('ParentName')};
	string Phone {xpath('Phone')};
	string Fax {xpath('Fax')};
	string Telex {xpath('Telex')};
	string Email {xpath('Email')};
	string Url {xpath('Url')};
	string Incorp {xpath('Incorp')};
	string Earnings {xpath('Earnings')};
	string Sales {xpath('Sales')};
	string SalesDescription {xpath('SalesDescription')};
	string Assets {xpath('Assets')};
	string Liabilities {xpath('Liabilities')};
	string NetWorth {xpath('NetWorth')};
	integer EmployeeNumber {xpath('EmployeeNumber')};
	string BusinessDescription {xpath('BusinessDescription')};
	string TickerSymbol {xpath('TickerSymbol')};
	share.t_Address Address {xpath('Address')};
	dataset(rollupbizreport.t_SicCode) Sics {xpath('Sics/SicCode'), MAXCOUNT(constants.DCA.MAX_SICS)};
	dataset(t_SrcContact) Contacts {xpath('Contacts/Contact'), MAXCOUNT(constants.DCA.MAX_CONTACTS)};
	dataset(share.t_Name) Executives {xpath('Executives/Name'), MAXCOUNT(constants.DCA.MAX_EXECUTIVES)};
	dataset(share.t_StringArrayItem) Exchanges {xpath('Exchanges/Exchange'), MAXCOUNT(constants.DCA.MAX_EXCHANGES)};
end;
		
export t_SrcUtility := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string UtilityType {xpath('UtilityType')};
	string ExchSerialNumber {xpath('ExchSerialNumber')};
	share.t_Date ExchFirstSeenDate {xpath('ExchFirstSeenDate')};
	share.t_Date ConnectDate {xpath('ConnectDate')};
	share.t_Date RecordDate {xpath('RecordDate')};
	share.t_Date FirstSeen {xpath('FirstSeen')};
end;
		
export t_SrcAirc := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Name Name {xpath('Name')};
	string CompanyName {xpath('CompanyName')};
	string SSN {xpath('SSN')};
	string UniqueId {xpath('UniqueId')};
	string BusinessId {xpath('BusinessId')};
	string CurrentFlag {xpath('CurrentFlag')};
	string Number {xpath('Number')};
	string SerialNumber {xpath('SerialNumber')};
	string ManufactorModelCode {xpath('ManufactorModelCode')};
	string EngineModelCode {xpath('EngineModelCode')};
	string ManufactorYear {xpath('ManufactorYear')};
	string RegistrantType {xpath('RegistrantType')};
	share.t_Date LastActionDate {xpath('LastActionDate')};
	share.t_Date IssuedDate {xpath('IssuedDate')};
	string Certification {xpath('Certification')};
	string AircraftType {xpath('AircraftType')};
	string EngineType {xpath('EngineType')};
	string ManufactorName {xpath('ManufactorName')};
	string ModelName {xpath('ModelName')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcAssessor := record
	string RecordType {xpath('RecordType')};
	string SourcePropertyRecordId {xpath('SourcePropertyRecordId')};
	string ParcelNumber {xpath('ParcelNumber')};
	string ParcelId {xpath('ParcelId')};
	share.t_Address Address {xpath('Address')};
	string LotNumber {xpath('LotNumber')};
	string Block {xpath('Block')};
	string Section {xpath('Section')};
	string District {xpath('District')};
	string Unit {xpath('Unit')};
	string Township {xpath('Township')};
	string SubdivisionName {xpath('SubdivisionName')};
	string Phase {xpath('Phase')};
	string TractNumber {xpath('TractNumber')};
	string PropertyDescription {xpath('PropertyDescription')};
	string SalePrice {xpath('SalePrice')};
	string LoanAmount {xpath('LoanAmount')};
	string LenderName {xpath('LenderName')};
	string AssessedLandValue {xpath('AssessedLandValue')};
	string AssessedImprovementValue {xpath('AssessedImprovementValue')};
	string AssessedTotalValue {xpath('AssessedTotalValue')};
	string YearAssessed {xpath('YearAssessed')};
	string MarketLandValue {xpath('MarketLandValue')};
	string MarketImprovementValue {xpath('MarketImprovementValue')};
	string MarketTotalValue {xpath('MarketTotalValue')};
	string YearMarketValue {xpath('YearMarketValue')};
	string TaxAmount {xpath('TaxAmount')};
	string TaxYear {xpath('TaxYear')};
	string DataSource {xpath('DataSource')};
end;
		
export t_SrcProfLic := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
	string Phone10 {xpath('Phone10')};
	string Vendor {xpath('Vendor')};
	string FileName {xpath('FileName')};
	string StateName {xpath('StateName')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	share.t_Date LastRenewalDate {xpath('LastRenewalDate')};
	string LicenseKey {xpath('LicenseKey')};
	string Profession {xpath('Profession')};
	string LicenseType {xpath('LicenseType')};
	string LicenseNumber {xpath('LicenseNumber')};
	string BusinessFlag {xpath('BusinessFlag')};
	share.t_Date IssueDate {xpath('IssueDate')};
	string FAX {xpath('FAX')};
	string UniqueId {xpath('UniqueId')};
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	string Sex {xpath('Sex')};
end;
		
export t_SrcFinder := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
	string Phone10 {xpath('Phone10')};
	string Vendor {xpath('Vendor')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
end;
		
export t_PersonInfo := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string DealerLicenseNumber {xpath('DealerLicenseNumber')};
	integer Age {xpath('Age')};
	share.t_Date DOB {xpath('DOB')};
	string Sex {xpath('Sex')};
end;
		
export t_SrcMV := record
	string OwnerType {xpath('OwnerType')};
	string RegistrantType {xpath('RegistrantType')};
	string LienHolderType {xpath('LienHolderType')};
	string FEID_SSN {xpath('FEID_SSN')};
	share.t_Date LienDate {xpath('LienDate')};
	t_PersonInfo PersonInfo {xpath('PersonInfo')};
end;
		
export t_Defendent := record
	string CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_Plaintiff := record
	string CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_SrcLein := record
	t_Defendent Defendent {xpath('Defendent')};
	t_Plaintiff Plaintiff {xpath('Plaintiff')};
	share.t_Address Address {xpath('Address')};
	string UniqueId {xpath('UniqueId')};
	string CourtID {xpath('CourtID')};
	string CourtName {xpath('CourtName')};
	string FileTypeID {xpath('FileTypeID')};
	string FilingType {xpath('FilingType')};
	string CaseNumber {xpath('CaseNumber')};
	string Book {xpath('Book')};
	string Page {xpath('Page')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date ReleaseDate {xpath('ReleaseDate')};
	string Amount {xpath('Amount')};
	string Assets {xpath('Assets')};
	string StateOrigin {xpath('StateOrigin')};
	string StateOriginName {xpath('StateOriginName')};
	string HullNumber {xpath('HullNumber')};
	string VesselName {xpath('VesselName')};
	string RecordType {xpath('RecordType')};
	string VesselNumber {xpath('VesselNumber')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_Engine := record
	string HorsePower {xpath('HorsePower')};
	string Make {xpath('Make')};
	string Model {xpath('Model')};
end;
		
export t_LienHolder := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_Owner := record
	share.t_Date DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
	string CompanyName {xpath('CompanyName')};
	string UniqueId {xpath('UniqueId')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_Description := record
	string Length {xpath('Length')};
	string Width {xpath('Width')};
	string Weight {xpath('Weight')};
	string Make {xpath('Make')};
	string Model {xpath('Model')};
	string YearMake {xpath('YearMake')};
	string HullType {xpath('HullType')};
	string Use {xpath('Use')};
	string MajorColor {xpath('MajorColor')};
	string MinorColor {xpath('MinorColor')};
	string PropulsionType {xpath('PropulsionType')};
	string FuelType {xpath('FuelType')};
	string Breadth {xpath('Breadth')};
	string Depth {xpath('Depth')};
	string GrossTons {xpath('GrossTons')};
	string NetTons {xpath('NetTons')};
end;
		
export t_Registration := record
	string Status {xpath('Status')};
	string Number {xpath('Number')};
	share.t_Date IssueDate {xpath('IssueDate')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
end;
		
export t_SrcTitle := record
	string State {xpath('State')};
	string Number {xpath('Number')};
	string Status {xpath('Status')};
	string _Type {xpath('Type')};
	share.t_Date IssueDate {xpath('IssueDate')};
end;
		
export t_Purchase := record
	share.t_Date Date {xpath('Date')};
	string Price {xpath('Price')};
	string Dealer {xpath('Dealer')};
	string StatePurchased {xpath('StatePurchased')};
end;
		
export t_Port := record
	string State {xpath('State')};
	string City {xpath('City')};
	string Province {xpath('Province')};
	string Country {xpath('Country')};
end;
		
export t_SrcWManufacture := record
	string ShipYard {xpath('ShipYard')};
	string YearBuilt {xpath('YearBuilt')};
end;
		
export t_SrcWatercraft := record
	string StateOrigin {xpath('StateOrigin')};
	string StateOriginName {xpath('StateOriginName')};
	string HullNumber {xpath('HullNumber')};
	string VesselName {xpath('VesselName')};
	string RecordType {xpath('RecordType')};
	string VesselNumber {xpath('VesselNumber')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	t_Description Description {xpath('Description')};
	t_Registration Registration {xpath('Registration')};
	t_SrcWManufacture Manufacture {xpath('Manufacture')};
	t_Purchase Purchase {xpath('Purchase')};
	t_SrcTitle Title {xpath('Title')};
	dataset(t_Engine) Engines {xpath('Engines/Engine'), MAXCOUNT(1)};
	dataset(t_LienHolder) Liens {xpath('Liens/LienHolder'), MAXCOUNT(1)};
end;
		
export t_License := record
	string Title {xpath('Title')};
	string First {xpath('First')};
	string Middle {xpath('Middle')};
	string Last {xpath('Last')};
	string Suffix {xpath('Suffix')};
	string CompanyName {xpath('CompanyName')};
end;
		
export t_SrcAtf := record
	t_License License1 {xpath('License1')};
	t_License License2 {xpath('License2')};
	share.t_Address Premise {xpath('Premise')};
	share.t_Address Mail {xpath('Mail')};
	string CompanyName {xpath('CompanyName')};
	string SSN {xpath('SSN')};
	string UniqueId {xpath('UniqueId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string Expired {xpath('Expired')};
	string RecordType {xpath('RecordType')};
	string LicenseNumber {xpath('LicenseNumber')};
	string LicenseRegion {xpath('LicenseRegion')};
	string OriginalLicenseDistrict {xpath('OriginalLicenseDistrict')};
	string LicenseDistrict {xpath('LicenseDistrict')};
	string LicenseCounty {xpath('LicenseCounty')};
	string LicenseType {xpath('LicenseType')};
	share.t_Date ExpireDate {xpath('ExpireDate')};
	string LicenseName {xpath('LicenseName')};
end;
		
export t_AKA := record
	share.t_Name Name {xpath('Name')};
end;
		
export t_PriorRecord := record
	string ReportedDate {xpath('ReportedDate')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcEQ := record
	share.t_Name Name {xpath('Name')};
	t_AKA Aka {xpath('Aka')};
	string SSN {xpath('SSN')};
	string FullAddress {xpath('FullAddress')};
	string ReportedDate {xpath('ReportedDate')};
	share.t_Address Address {xpath('Address')};
	t_PriorRecord PriorRecord1 {xpath('PriorRecord1')};
	t_PriorRecord PriorRecord2 {xpath('PriorRecord2')};
end;
		
export t_SrcDebtor := record
	string DebtorType {xpath('DebtorType')};
	string DebtorSeq {xpath('DebtorSeq')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string CompanyName {xpath('CompanyName')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
end;
		
export t_SrcDea := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RegistrationNumber {xpath('RegistrationNumber')};
	string BusinessActivityCode {xpath('BusinessActivityCode')};
	string DrugSchedules {xpath('DrugSchedules')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_SrcAirm := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string SSN {xpath('SSN')};
	string Current {xpath('Current')};
	string RecordType {xpath('RecordType')};
	string UniqueId {xpath('UniqueId')};
	string MedClass {xpath('MedClass')};
	share.t_Date MedDate {xpath('MedDate')};
	share.t_Date MedExpiredDate {xpath('MedExpiredDate')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_SrcDeath := record
	share.t_Name Name {xpath('Name')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	string SSN {xpath('SSN')};
	share.t_Date FileDate {xpath('FileDate')};
	string ExchSerialNumber {xpath('ExchSerialNumber')};
	share.t_Date ExchFirstSeenDate {xpath('ExchFirstSeenDate')};
	share.t_Date ConnectDate {xpath('ConnectDate')};
	share.t_Date RecordDate {xpath('RecordDate')};
	string LastZip {xpath('LastZip')};
	string State {xpath('State')};
end;
		
export t_DeedEntity := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcBorrower := record
	string FullName {xpath('FullName')};
	string IdCode {xpath('IdCode')};
end;
		
export t_SrcLoan := record
	string Amount {xpath('Amount')};
	string LenderTypeCode {xpath('LenderTypeCode')};
	string LoanType {xpath('LoanType')};
	string InterestRate {xpath('InterestRate')};
	share.t_Date DueDate {xpath('DueDate')};
end;
		
export t_SrcDeed := record
	string State {xpath('State')};
	string CountyName {xpath('CountyName')};
	string RecordType {xpath('RecordType')};
	share.t_Address Address {xpath('Address')};
	t_DeedEntity Buyer {xpath('Buyer')};
	t_DeedEntity Seller {xpath('Seller')};
	string LenderName {xpath('LenderName')};
	string LegalLotCode {xpath('LegalLotCode')};
	string LegalLotNumber {xpath('LegalLotNumber')};
	string LegalBlock {xpath('LegalBlock')};
	string LegalSection {xpath('LegalSection')};
	string LegalDistrict {xpath('LegalDistrict')};
	string LegalLandLot {xpath('LegalLandLot')};
	string LegalUnit {xpath('LegalUnit')};
	string LegalCityMunicipalityTownship {xpath('LegalCityMunicipalityTownship')};
	string LegalSubdivisionName {xpath('LegalSubdivisionName')};
	string LegalPhaseNumber {xpath('LegalPhaseNumber')};
	string LegalTractNumber {xpath('LegalTractNumber')};
	string LegalSecTwnRngMer {xpath('LegalSecTwnRngMer')};
	string LegalBriefDescription {xpath('LegalBriefDescription')};
	share.t_Date ContractDate {xpath('ContractDate')};
	share.t_Date RecordingDate {xpath('RecordingDate')};
	string DocumentNumber {xpath('DocumentNumber')};
	string DocumentTypeCode {xpath('DocumentTypeCode')};
	string LoanNumber {xpath('LoanNumber')};
	string RecorderBookNumber {xpath('RecorderBookNumber')};
	string RecorderPageNumber {xpath('RecorderPageNumber')};
	string SalesPrice {xpath('SalesPrice')};
	string SalesPriceCode {xpath('SalesPriceCode')};
	string CityTransferTax {xpath('CityTransferTax')};
	string CountyTransferTax {xpath('CountyTransferTax')};
	string TotalTransferTax {xpath('TotalTransferTax')};
	string ParcelNumber {xpath('ParcelNumber')};
	string LandUse {xpath('LandUse')};
	string TitleCompany {xpath('TitleCompany')};
	string DataSource {xpath('DataSource')};
	dataset(t_SrcBorrower) Borrowers {xpath('Borrowers/Borrower'), MAXCOUNT(1)};
	dataset(t_SrcLoan) Loans {xpath('Loans/Loan'), MAXCOUNT(1)};
end;
		
export t_SrcClaimant := record
	string SSN {xpath('SSN')};
	string Sex {xpath('Sex')};
	string Age {xpath('Age')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcEmployer := record (t_Person)
	string SIC {xpath('SIC')};
end;
		
export t_SrcMsWork := record
	t_SrcEmployer Employer {xpath('Employer')};
	t_SrcClaimant Claimant {xpath('Claimant')};
	t_Person Attorney {xpath('Attorney')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date InjuryDate {xpath('InjuryDate')};
	share.t_Date FiledDate {xpath('FiledDate')};
	share.t_Date ReturnedToWorkDate {xpath('ReturnedToWorkDate')};
	share.t_Date HiredDate {xpath('HiredDate')};
	share.t_Date EmployerAwareDate {xpath('EmployerAwareDate')};
	share.t_Date DisabilityDate {xpath('DisabilityDate')};
	share.t_Date DOD {xpath('DOD')};
	share.t_Date B31ApprovedDate {xpath('B31ApprovedDate')};
	string CarrierClaimNumber {xpath('CarrierClaimNumber')};
	string CarrierName {xpath('CarrierName')};
	string MweeNumber {xpath('MweeNumber')};
	string CountyOfInjury {xpath('CountyOfInjury')};
	string WeeklyWage {xpath('WeeklyWage')};
	string Injury {xpath('Injury')};
	string PartOfBody {xpath('PartOfBody')};
	string CauseOfInjury {xpath('CauseOfInjury')};
	string NatureCode {xpath('NatureCode')};
	string PartCode {xpath('PartCode')};
	string CauseCode {xpath('CauseCode')};
	string Status {xpath('Status')};
end;
		
export t_SrcAkPermenantFund := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string StateOrigin {xpath('StateOrigin')};
	share.t_Date ProcessDate {xpath('ProcessDate')};
	share.t_Date ProcessYear {xpath('ProcessYear')};
end;
		
export t_SrcVoteReg := record
	string BirthPlace {xpath('BirthPlace')};
	string Occupation {xpath('Occupation')};
	string MaidenName {xpath('MaidenName')};
	string MotorVehicleId {xpath('MotorVehicleId')};
	string RegistrationSource {xpath('RegistrationSource')};
	share.t_Date RegistrationDate {xpath('RegistrationDate')};
	string Sex {xpath('Sex')};
	string Race {xpath('Race')};
	string PoliticalParty {xpath('PoliticalParty')};
	string Phone10 {xpath('Phone10')};
	string WorkPhone10 {xpath('WorkPhone10')};
	string OtherPhone10 {xpath('OtherPhone10')};
	string VoterStatus {xpath('VoterStatus')};
	share.t_Address Address {xpath('Address')};
	share.t_Address MailAddress {xpath('MailAddress')};
	string VoterId {xpath('VoterId')};
	string StateHouseDistrict {xpath('StateHouseDistrict')};
	string StateSenateDistrict {xpath('StateSenateDistrict')};
	string CongressionalDistrict {xpath('CongressionalDistrict')};
	string DOB {xpath('DOB')};
end;
		
export t_SrcHunting := record
	string Permit {xpath('Permit')};
	share.t_Date LicenseDate {xpath('LicenseDate')};
	string State {xpath('State')};
	string Resident {xpath('Resident')};
	string Nonresident {xpath('Nonresident')};
	string Hunt {xpath('Hunt')};
	string Fish {xpath('Fish')};
	string Combosuper {xpath('Combosuper')};
	string Sportsman {xpath('Sportsman')};
	string Trap {xpath('Trap')};
	string Archery {xpath('Archery')};
	string Muzzle {xpath('Muzzle')};
	string Drawing {xpath('Drawing')};
	string Day1 {xpath('Day1')};
	string Day3 {xpath('Day3')};
	string Day7 {xpath('Day7')};
	string Day14to15 {xpath('Day14to15')};
	string Dayfiller {xpath('Dayfiller')};
	string Seasonannual {xpath('Seasonannual')};
	string Lifetimepermit {xpath('Lifetimepermit')};
	string Landowner {xpath('Landowner')};
	string Family {xpath('Family')};
	string Junior {xpath('Junior')};
	string Seniorcit {xpath('Seniorcit')};
	string Crewmemeber {xpath('Crewmemeber')};
	string Retarded {xpath('Retarded')};
	string Indian {xpath('Indian')};
	string Serviceman {xpath('Serviceman')};
	string Disabled {xpath('Disabled')};
	string Lowincome {xpath('Lowincome')};
	string Regioncounty {xpath('Regioncounty')};
	string Blind {xpath('Blind')};
	string Huntfiller {xpath('Huntfiller')};
	string Salmon {xpath('Salmon')};
	string Freshwater {xpath('Freshwater')};
	string Saltwater {xpath('Saltwater')};
	string Lakesandresevoirs {xpath('Lakesandresevoirs')};
	string Setlinefish {xpath('Setlinefish')};
	string Trout {xpath('Trout')};
	string Fallfishing {xpath('Fallfishing')};
	string Steelhead {xpath('Steelhead')};
	string Whitejubherring {xpath('Whitejubherring')};
	string Sturgeon {xpath('Sturgeon')};
	string Shellfishcrab {xpath('Shellfishcrab')};
	string Shellfishlobster {xpath('Shellfishlobster')};
	string Deer {xpath('Deer')};
	string Bear {xpath('Bear')};
	string Elk {xpath('Elk')};
	string Moose {xpath('Moose')};
	string Buffalo {xpath('Buffalo')};
	string Antelope {xpath('Antelope')};
	string Sikebull {xpath('Sikebull')};
	string Bighorn {xpath('Bighorn')};
	string Javelina {xpath('Javelina')};
	string Cougar {xpath('Cougar')};
	string Anterless {xpath('Anterless')};
	string Pheasant {xpath('Pheasant')};
	string Goose {xpath('Goose')};
	string Duck {xpath('Duck')};
	string Turkey {xpath('Turkey')};
	string Snowmobile {xpath('Snowmobile')};
	string Biggame {xpath('Biggame')};
	string Skipass {xpath('Skipass')};
	string Migbird {xpath('Migbird')};
	string Smallgame {xpath('Smallgame')};
	string Sturgeon2 {xpath('Sturgeon2')};
	string Gun {xpath('Gun')};
	string Bonus {xpath('Bonus')};
	string Lottery {xpath('Lottery')};
	string Otherbirds {xpath('Otherbirds')};
end;
		
export t_SrcCCW := record
	string PermitNumber {xpath('PermitNumber')};
	string WeaponType {xpath('WeaponType')};
	share.t_Date RegistrationDate {xpath('RegistrationDate')};
	share.t_Date ExpireDate {xpath('ExpireDate')};
	string PermitType {xpath('PermitType')};
end;
		
export t_SrcEmerges := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string SSN {xpath('SSN')};
	string Vendor {xpath('Vendor')};
	string StateName {xpath('StateName')};
	t_SrcVoteReg VoterRegistration {xpath('VoterRegistration')};
	t_SrcHunting HuntingFishingPermit {xpath('HuntingFishingPermit')};
	t_SrcCCW ConcealledWeaponPermit {xpath('ConcealledWeaponPermit')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string RaceMapped {xpath('RaceMapped')};
	string GenderMapped {xpath('GenderMapped')};
end;
		
export t_SrcPhone := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_SrcCorpAffil := record
	string StateOfOrigin {xpath('StateOfOrigin')};
	string CharterNumber {xpath('CharterNumber')};
	string CorporationName {xpath('CorporationName')};
	string Status {xpath('Status')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcVessel := record
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date IssuedDate {xpath('IssuedDate')};
	share.t_Date ExpireDate {xpath('ExpireDate')};
	string VesselPropulsionType {xpath('VesselPropulsionType')};
	string HullMaterialType {xpath('HullMaterialType')};
	string VesselId {xpath('VesselId')};
	string VesselName {xpath('VesselName')};
	string HullNumber {xpath('HullNumber')};
	string HullIdentificationNumber {xpath('HullIdentificationNumber')};
	string LengthFeet {xpath('LengthFeet')};
	string WidthFeet {xpath('WidthFeet')};
end;
		
export t_SrcBoat := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string Vendor {xpath('Vendor')};
	share.t_Date DateVendorFirstSeen {xpath('DateVendorFirstSeen')};
	share.t_Date DateVendorLastSeen {xpath('DateVendorLastSeen')};
	string SourceID {xpath('SourceID')};
	string State {xpath('State')};
	string Product {xpath('Product')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date IssueDate {xpath('IssueDate')};
	share.t_Date ExpireDate {xpath('ExpireDate')};
	share.t_Date AcquisitionDate {xpath('AcquisitionDate')};
	string HullConstruction {xpath('HullConstruction')};
	string PrimaryUse {xpath('PrimaryUse')};
	string Propulsion {xpath('Propulsion')};
	string VesselType {xpath('VesselType')};
	string Length {xpath('Length')};
	string DecalId {xpath('DecalId')};
	string SerialNumber {xpath('SerialNumber')};
	string HullId {xpath('HullId')};
	string HullManufacturer {xpath('HullManufacturer')};
	string Cost {xpath('Cost')};
	string PrimaryColor {xpath('PrimaryColor')};
end;
		
export t_SrcPilotCert := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string Current {xpath('Current')};
	string CertificationType {xpath('CertificationType')};
	string CertificationLevel {xpath('CertificationLevel')};
	share.t_Date ExpireDate {xpath('ExpireDate')};
	string Rating {xpath('Rating')};
end;
		
export t_SrcStateDeathRecord := record
	string PublicationState {xpath('PublicationState')};
	string Publication {xpath('Publication')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	string SSN {xpath('SSN')};
	string Race {xpath('Race')};
	string Origin {xpath('Origin')};
	string Sex {xpath('Sex')};
	string Age {xpath('Age')};
	string Education {xpath('Education')};
	string Occupation {xpath('Occupation')};
	string WorkPlace {xpath('WorkPlace')};
	string Cause {xpath('Cause')};
	string Birthplace {xpath('Birthplace')};
	string MaritalStatus {xpath('MaritalStatus')};
	string Father {xpath('Father')};
	string Mother {xpath('Mother')};
	string Autopsy {xpath('Autopsy')};
	string AutopsyFindings {xpath('AutopsyFindings')};
	string MedicalExam {xpath('MedicalExam')};
	string LicenseNumber {xpath('LicenseNumber')};
	string Disposition {xpath('Disposition')};
	string WorkRelatedInjury {xpath('WorkRelatedInjury')};
	string WorkRelatedInjuryType {xpath('WorkRelatedInjuryType')};
	string WorkRelatedInjuryLocation {xpath('WorkRelatedInjuryLocation')};
	string SurgeryPerformed {xpath('SurgeryPerformed')};
	string HospitalStatus {xpath('HospitalStatus')};
	string Pregnancy {xpath('Pregnancy')};
	string Facility {xpath('Facility')};
	string EmbalmerLicenseNumber {xpath('EmbalmerLicenseNumber')};
	string TypeOfDeath {xpath('TypeOfDeath')};
	string TimeOfDeath {xpath('TimeOfDeath')};
	string BirthCertificate {xpath('BirthCertificate')};
	string Certifier {xpath('Certifier')};
	string CertifierNumber {xpath('CertifierNumber')};
	string LocalFileNumber {xpath('LocalFileNumber')};
	share.t_Date DispositionDate {xpath('DispositionDate')};
	share.t_Date SurgeryDate {xpath('SurgeryDate')};
	share.t_Date WorkRelatedInjuryDate {xpath('WorkRelatedInjuryDate')};
end;
		
export t_EbrJudgment := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string TypeCode {xpath('TypeCode')};
	string TypeDescription {xpath('TypeDescription')};
	string ActionCode {xpath('ActionCode')};
	string ActionDescription {xpath('ActionDescription')};
	string DocumentNumber {xpath('DocumentNumber')};
	string FilingLocation {xpath('FilingLocation')};
	string LiabilityAmount {xpath('LiabilityAmount')};
	string Plaintiff {xpath('Plaintiff')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	share.t_Date FiledDate {xpath('FiledDate')};
end;
		
export t_EbrUcc := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string TypeCode {xpath('TypeCode')};
	string TypeDescription {xpath('TypeDescription')};
	string ActionCode {xpath('ActionCode')};
	string ActionDescription {xpath('ActionDescription')};
	string DocumentNumber {xpath('DocumentNumber')};
	string FilingLocation {xpath('FilingLocation')};
	string SecuredParty {xpath('SecuredParty')};
	string Assignee {xpath('Assignee')};
	string FilingState {xpath('FilingState')};
	string FilingNumber {xpath('FilingNumber')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	share.t_Date FiledDate {xpath('FiledDate')};
	dataset(share.t_StringArrayItem) Collaterals {xpath('Collaterals/Collateral'), MAXCOUNT(1)};
end;
		
export t_EbrTrade := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string PaymentIndicator {xpath('PaymentIndicator')};
	string BusinessCategory {xpath('BusinessCategory')};
	string PaymentTerms {xpath('PaymentTerms')};
	string RecentHighCredit {xpath('RecentHighCredit')};
	string AccountBalance {xpath('AccountBalance')};
	string CurrentPercent {xpath('CurrentPercent')};
	string Debt01to30Percent {xpath('Debt01to30Percent')};
	string Debt31to60Percent {xpath('Debt31to60Percent')};
	string Debt61to90Percent {xpath('Debt61to90Percent')};
	string Debt91PlusPercent {xpath('Debt91PlusPercent')};
	string Comment {xpath('Comment')};
	string NewTradeFlag {xpath('NewTradeFlag')};
	string TradeType {xpath('TradeType')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	string SegmentCode {xpath('SegmentCode')};
	share.t_Date DateReported {xpath('DateReported')};
	share.t_Date LastSaleDate {xpath('LastSaleDate')};
end;
		
export t_EbrPaymentTotal := record
	string Count {xpath('Count')};
	string Debt {xpath('Debt')};
	string RecentHighCredit {xpath('RecentHighCredit')};
	string AccountBalance {xpath('AccountBalance')};
	string CurrentBalancePercent {xpath('CurrentBalancePercent')};
	string Debt01to30Percent {xpath('Debt01to30Percent')};
	string Debt31to60Percent {xpath('Debt31to60Percent')};
	string Debt61to90Percent {xpath('Debt61to90Percent')};
	string Debt91PlusPercent {xpath('Debt91PlusPercent')};
end;
		
export t_EbrPayment := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string HighestCreditMedian {xpath('HighestCreditMedian')};
	string OriginalAccountBalance {xpath('OriginalAccountBalance')};
	string OriginalNewAccountBalance {xpath('OriginalNewAccountBalance')};
	string OriginalCombinedAccountBalance {xpath('OriginalCombinedAccountBalance')};
	string AgedCount {xpath('AgedCount')};
	string AccountBalance {xpath('AccountBalance')};
	string NewAccountBalance {xpath('NewAccountBalance')};
	string CombinedAccountBalance {xpath('CombinedAccountBalance')};
	t_EbrPaymentTotal Continuous {xpath('Continuous')};
	t_EbrPaymentTotal Aged {xpath('Aged')};
	t_EbrPaymentTotal Total {xpath('Total')};
end;
		
export t_EbrTrend := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string TrendMonth {xpath('TrendMonth')};
	string TrendYear {xpath('TrendYear')};
	string DBT {xpath('DBT')};
	string AccountBalance {xpath('AccountBalance')};
	string CurrentAccountBalancePercent {xpath('CurrentAccountBalancePercent')};
	string DBT01to30Percent {xpath('DBT01to30Percent')};
	string DBT31to60Percent {xpath('DBT31to60Percent')};
	string DBT61to90Percent {xpath('DBT61to90Percent')};
	string DBT91PlusPercent {xpath('DBT91PlusPercent')};
end;
		
export t_EbrAverage := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string Quarter {xpath('Quarter')};
	string Year {xpath('Year')};
	string Debt {xpath('Debt')};
	string AccountBalance {xpath('AccountBalance')};
	string CurrentAccountBalancePercent {xpath('CurrentAccountBalancePercent')};
	string DBT01to30Percent {xpath('DBT01to30Percent')};
	string DBT31to60Percent {xpath('DBT31to60Percent')};
	string DBT61to90Percent {xpath('DBT61to90Percent')};
	string DBT91PlusPercent {xpath('DBT91PlusPercent')};
end;
		
export t_EbrBankruptcy := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string TypeDescription {xpath('TypeDescription')};
	string ActionDescription {xpath('ActionDescription')};
	string DocumentNumber {xpath('DocumentNumber')};
	string LiabilityAmount {xpath('LiabilityAmount')};
	string AssetAmount {xpath('AssetAmount')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	share.t_Date FiledDate {xpath('FiledDate')};
end;
		
export t_EbrTaxLien := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string TypeDescription {xpath('TypeDescription')};
	string ActionDescription {xpath('ActionDescription')};
	string DocumentNumber {xpath('DocumentNumber')};
	string LiabilityAmount {xpath('LiabilityAmount')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	share.t_Date FiledDate {xpath('FiledDate')};
	string FilingLocation {xpath('FilingLocation')};
	string TaxLienDescription {xpath('TaxLienDescription')};
end;
		
export t_EbrCollateral := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string TotalUccFiled {xpath('TotalUccFiled')};
	string UccCollateralCount {xpath('UccCollateralCount')};
	dataset(share.t_StringArrayItem) Collateral {xpath('Collateral/Description'), MAXCOUNT(1)};
end;
		
export t_EbrBank := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string Name {xpath('Name')};
	string Phone10 {xpath('Phone10')};
	string Relationship {xpath('Relationship')};
	string BalanceRangeCode {xpath('BalanceRangeCode')};
	string AccountBalanceRangeCode {xpath('AccountBalanceRangeCode')};
	string AccountBalanceTotal {xpath('AccountBalanceTotal')};
	string DateAccountOpened {xpath('DateAccountOpened')};
	string DateAccountClosed {xpath('DateAccountClosed')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	string AccountRatingCode {xpath('AccountRatingCode')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_EbrDemo5600 := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string YearsInBusiness {xpath('YearsInBusiness')};
	string SalesDescription {xpath('SalesDescription')};
	string SalesAmount {xpath('SalesAmount')};
	string Employees {xpath('Employees')};
	string BusinessType {xpath('BusinessType')};
	string OwnerType {xpath('OwnerType')};
	string Location {xpath('Location')};
	dataset(rollupbizreport.t_SicCode) SICs {xpath('SICs/SicCode'), MAXCOUNT(1)};
end;
		
export t_EbrDemo5610 := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string SSN {xpath('SSN')};
	string FiscalYearEndMonth {xpath('FiscalYearEndMonth')};
	string ProfitRangeDescription {xpath('ProfitRangeDescription')};
	string ProfitRangeActual {xpath('ProfitRangeActual')};
	string NetWorthDescription {xpath('NetWorthDescription')};
	string NetWorthActual {xpath('NetWorthActual')};
	string InBuildingSinceYear {xpath('InBuildingSinceYear')};
	string OwnOrRent {xpath('OwnOrRent')};
	string BuildingSquareFeet {xpath('BuildingSquareFeet')};
	string ActiveCustomerCount {xpath('ActiveCustomerCount')};
	string Ownership {xpath('Ownership')};
	string CorporateName {xpath('CorporateName')};
	string CorporateCity {xpath('CorporateCity')};
	string CorporateState {xpath('CorporateState')};
	string Phone10 {xpath('Phone10')};
	string OfficerTitle {xpath('OfficerTitle')};
	share.t_Name OfficerName {xpath('OfficerName')};
end;
		
export t_EBRInquiryCount := record
	string Month {xpath('Month')};
	string Year {xpath('Year')};
	string Count {xpath('Count')};
end;
		
export t_EbrInquiry := record
	share.t_Date ProcessDate {xpath('ProcessDate')};
	string RecordType {xpath('RecordType')};
	string BusinessCode {xpath('BusinessCode')};
	string BusinessDescription {xpath('BusinessDescription')};
	string SegmentCode {xpath('SegmentCode')};
	string SequenceNumber {xpath('SequenceNumber')};
	dataset(t_EBRInquiryCount) PriorInquiries {xpath('PriorInquiries/PriorInquiry'), MAXCOUNT(1)};
end;
		
export t_EbrGovTrade := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string PaymentIndicator {xpath('PaymentIndicator')};
	string BusinessCategoryCode {xpath('BusinessCategoryCode')};
	string BusinessCategoryDescription {xpath('BusinessCategoryDescription')};
	string PaymentTerms {xpath('PaymentTerms')};
	string RecentHighCredit {xpath('RecentHighCredit')};
	string CurrentAccountBalancePercent {xpath('CurrentAccountBalancePercent')};
	string DBT01to30Percent {xpath('DBT01to30Percent')};
	string DBT31to60Percent {xpath('DBT31to60Percent')};
	string DBT61to90Percent {xpath('DBT61to90Percent')};
	string DBT91PlusPercent {xpath('DBT91PlusPercent')};
	string Comment {xpath('Comment')};
	string NewTradeFlag {xpath('NewTradeFlag')};
	string TradeTypeDescription {xpath('TradeTypeDescription')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	share.t_Date ReportedDate {xpath('ReportedDate')};
	string LastSaleDate {xpath('LastSaleDate')};
end;
		
export t_EbrContractor := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string ActionDescription {xpath('ActionDescription')};
	string ExtentOfAction {xpath('ExtentOfAction')};
	string AgencyDescription {xpath('AgencyDescription')};
	string DisputeIndicator {xpath('DisputeIndicator')};
	string DisputeCode {xpath('DisputeCode')};
	share.t_Date FiledDate {xpath('FiledDate')};
	share.t_Date ReportedDate {xpath('ReportedDate')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_EbrSummary := record
	string FileNumber {xpath('FileNumber')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string RecordType {xpath('RecordType')};
	string CurrentDBT {xpath('CurrentDBT')};
	string PredictedDBT {xpath('PredictedDBT')};
	string ConfidentPercent {xpath('ConfidentPercent')};
	string ConfidentSlope {xpath('ConfidentSlope')};
	string AverageIndustryDBT {xpath('AverageIndustryDBT')};
	string AverageAllIndustryDBT {xpath('AverageAllIndustryDBT')};
	string LowBalance {xpath('LowBalance')};
	string HighBalance {xpath('HighBalance')};
	string CurrentAccountBalance {xpath('CurrentAccountBalance')};
	string HighCreditExtended {xpath('HighCreditExtended')};
	string MedianCreditExtended {xpath('MedianCreditExtended')};
	string PaymentPerformance {xpath('PaymentPerformance')};
	string PaymentTrend {xpath('PaymentTrend')};
	string IndustryDescription {xpath('IndustryDescription')};
	share.t_Date PredictedDBTDate {xpath('PredictedDBTDate')};
end;
		
export t_SrcEbrRecord := record
	string ExperianFileNumber {xpath('ExperianFileNumber')};
	string RecordType {xpath('RecordType')};
	string CompanyName {xpath('CompanyName')};
	string Phone10 {xpath('Phone10')};
	string BusinessDescription {xpath('BusinessDescription')};
	string SIC {xpath('SIC')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date EstablishedDate {xpath('EstablishedDate')};
	share.t_Date ExtractDate {xpath('ExtractDate')};
	share.t_Address Address {xpath('Address')};
	t_EbrSummary ExecutiveSummary {xpath('ExecutiveSummary')};
	dataset(t_EbrJudgment) Judgments {xpath('Judgments/Judgment'), MAXCOUNT(1)};
	dataset(t_EbrUcc) UCCs {xpath('UCCs/UCC'), MAXCOUNT(1)};
	dataset(t_EbrTrade) TradeRecords {xpath('TradeRecords/TradeRecord'), MAXCOUNT(1)};
	dataset(t_EbrPayment) TradePaymentTotals {xpath('TradePaymentTotals/TradePaymentTotal'), MAXCOUNT(1)};
	dataset(t_EbrTrend) TradePaymentTrends {xpath('TradePaymentTrends/TradePaymentTrend'), MAXCOUNT(1)};
	dataset(t_EbrAverage) TradeAverageRecs {xpath('TradeAverageRecs/TradeAverageRec'), MAXCOUNT(1)};
	dataset(t_EbrBankruptcy) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(1)};
	dataset(t_EbrTaxLien) TaxLiens {xpath('TaxLiens/TaxLien'), MAXCOUNT(1)};
	dataset(t_EbrCollateral) CollateralAccounts {xpath('CollateralAccounts/CollateralAccount'), MAXCOUNT(1)};
	dataset(t_EbrBank) BankDetails {xpath('BankDetails/BankDetail'), MAXCOUNT(1)};
	dataset(t_EbrDemo5600) Demographic5600Records {xpath('Demographic5600Records/Demographic5600'), MAXCOUNT(1)};
	dataset(t_EbrDemo5610) Demographic5610Records {xpath('Demographic5610Records/Demographic5610'), MAXCOUNT(1)};
	dataset(t_EbrInquiry) Inquiries {xpath('Inquiries/Inquiry'), MAXCOUNT(1)};
	dataset(t_EbrGovTrade) GovermentTradeRecords {xpath('GovermentTradeRecords/GovermentTradeRecord'), MAXCOUNT(1)};
	dataset(t_EbrContractor) GovDebarredContractors {xpath('GovDebarredContractors/GovDebarredContractor'), MAXCOUNT(1)};
end;
		
export t_SrcSponsor := record
	share.t_Address Address {xpath('Address')};
	share.t_Name Signature {xpath('Signature')};
	string FullName {xpath('FullName')};
	string DoingBusinessAs {xpath('DoingBusinessAs')};
	string FEIN {xpath('FEIN')};
	string Phone {xpath('Phone')};
	string BusinessCode {xpath('BusinessCode')};
	string LastReportedName {xpath('LastReportedName')};
	string LastReportedFEIN {xpath('LastReportedFEIN')};
	string LastReportedPlanNumber {xpath('LastReportedPlanNumber')};
	share.t_Date SignatureDate {xpath('SignatureDate')};
end;
		
export t_SrcOtherEntity := record
	string Name {xpath('Name')};
	string CareOfName {xpath('CareOfName')};
	share.t_Address Address {xpath('Address')};
	string FEIN {xpath('FEIN')};
	string Phone {xpath('Phone')};
	share.t_Date SignatureDate {xpath('SignatureDate')};
	string Signature {xpath('Signature')};
end;
		
export t_SrcForm5500 := record
	string FormId {xpath('FormId')};
	string FormDate {xpath('FormDate')};
	string PlanName {xpath('PlanName')};
	string PlanNumber {xpath('PlanNumber')};
	share.t_Date PlanYearBegin {xpath('PlanYearBegin')};
	share.t_Date PlanEffectiveDate {xpath('PlanEffectiveDate')};
	t_SrcSponsor Sponsor {xpath('Sponsor')};
	t_SrcOtherEntity Administrator {xpath('Administrator')};
	t_SrcOtherEntity Preparer {xpath('Preparer')};
end;
		
export t_SrcForm990 := record
	share.t_Date ProcessDate {xpath('ProcessDate')};
	string Organization {xpath('Organization')};
	string FEIN {xpath('FEIN')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcBBBMember := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date MemberSince {xpath('MemberSince')};
	string MemberId {xpath('MemberId')};
	string CompanyName {xpath('CompanyName')};
	string URL {xpath('URL')};
	string MemberTitle {xpath('MemberTitle')};
	string MemberCategory {xpath('MemberCategory')};
	string Phone10 {xpath('Phone10')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcNonBBBMember := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date ReportDate {xpath('ReportDate')};
	string BBBId {xpath('BBBId')};
	string CompanyName {xpath('CompanyName')};
	string URL {xpath('URL')};
	string NonMemberTitle {xpath('NonMemberTitle')};
	string NonMemberCategory {xpath('NonMemberCategory')};
	string Phone10 {xpath('Phone10')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcFdic := record
	share.t_Date ProcessDate {xpath('ProcessDate')};
	share.t_Date LastStructureChangeDate {xpath('LastStructureChangeDate')};
	share.t_Date EstablishedDate {xpath('EstablishedDate')};
	share.t_Date DateOfDepositInsurance {xpath('DateOfDepositInsurance')};
	share.t_Date LastStructureChangeProcessDate {xpath('LastStructureChangeProcessDate')};
	string CertificateNumber {xpath('CertificateNumber')};
	string TotalAssets {xpath('TotalAssets')};
	string BankCharterClass {xpath('BankCharterClass')};
	string TotalDeposits {xpath('TotalDeposits')};
	string EquityCapital {xpath('EquityCapital')};
	string FdicGeographicRegion {xpath('FdicGeographicRegion')};
	string FederalReserveDistrict {xpath('FederalReserveDistrict')};
	string InsuranceFundMembership {xpath('InsuranceFundMembership')};
	string InstitutionName {xpath('InstitutionName')};
	string OfficeOfTheComptroller {xpath('OfficeOfTheComptroller')};
	string QuarterlyBankingProfileCommercialBankRegion {xpath('QuarterlyBankingProfileCommercialBankRegion')};
	string ReturnOnAssets {xpath('ReturnOnAssets')};
	string ReturnOnEquity {xpath('ReturnOnEquity')};
	string PrimaryWebAddress {xpath('PrimaryWebAddress')};
	string FdicFieldOffice {xpath('FdicFieldOffice')};
	string OfficeOfThriftSupervisionRegion {xpath('OfficeOfThriftSupervisionRegion')};
	string OwnershipType {xpath('OwnershipType')};
	string BankHoldingCompany {xpath('BankHoldingCompany')};
	string DomesticOffices {xpath('DomesticOffices')};
	string ForeignOffices {xpath('ForeignOffices')};
	string SubchapterSCorporations {xpath('SubchapterSCorporations')};
	string FdicSupervisoryRegion {xpath('FdicSupervisoryRegion')};
	string DirectlyOwnedByAnotherBank {xpath('DirectlyOwnedByAnotherBank')};
	string TrustPowers {xpath('TrustPowers')};
	string AssetConcentrationHierarchy {xpath('AssetConcentrationHierarchy')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_SrcSalesTax := record
	share.t_Address MailingAddress {xpath('MailingAddress')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Owner {xpath('Owner')};
	share.t_Name TradeName {xpath('TradeName')};
	share.t_Date IssueDate {xpath('IssueDate')};
	string PermitNumber {xpath('PermitNumber')};
	dataset(share.t_StringArrayItem) Companies {xpath('Companies/CompanyName'), MAXCOUNT(1)};
end;
		
export t_SrcOrWorkComp := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string Phone10 {xpath('Phone10')};
	string CompanyName {xpath('CompanyName')};
	share.t_Date LiabilityEndDate {xpath('LiabilityEndDate')};
	share.t_Date LiabilityBeginDate {xpath('LiabilityBeginDate')};
	string NumberOfEmployees {xpath('NumberOfEmployees')};
	string EmployerNumber {xpath('EmployerNumber')};
	string NCCI {xpath('NCCI')};
	string BusinessDescription {xpath('BusinessDescription')};
	string InsurerNumber {xpath('InsurerNumber')};
	string InsurerName {xpath('InsurerName')};
	string PolicyName {xpath('PolicyName')};
	share.t_Address PPBAddress {xpath('PPBAddress')};
	share.t_Address EmployerAddress {xpath('EmployerAddress')};
	dataset(share.t_StringArrayItem) Names {xpath('Names/Name'), MAXCOUNT(1)};
end;
		
export t_SrcFilingStatus := record
	string Status {xpath('Status')};
	string Description {xpath('Description')};
end;
		
export t_SrcAddressPhones := record
	share.t_Address Address {xpath('Address')};
	dataset(share.t_StringArrayItem) Phones {xpath('Phones/Phone10'), MAXCOUNT(1)};
end;
		
export t_SrcJnLParty := record
	string OriginName {xpath('OriginName')};
	dataset(lienjudgement.t_LienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(1)};
	dataset(t_SrcAddressPhones) Addresses {xpath('Addresses/AddressWithPhones'), MAXCOUNT(1)};
end;
		
export t_SrcJudgmentLien := record
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	string FilingState {xpath('FilingState')};
	string OriginFilingNumber {xpath('OriginFilingNumber')};
	string OriginFilingType {xpath('OriginFilingType')};
	share.t_Date OriginFilingDate {xpath('OriginFilingDate')};
	string OriginFilingTime {xpath('OriginFilingTime')};
	string CaseNumber {xpath('CaseNumber')};
	string TaxCode {xpath('TaxCode')};
	share.t_Date ReleaseDate {xpath('ReleaseDate')};
	string Amount {xpath('Amount')};
	string Eviction {xpath('Eviction')};
	share.t_Date JudgeSatisfiedDate {xpath('JudgeSatisfiedDate')};
	share.t_Date JudgeVacatedDate {xpath('JudgeVacatedDate')};
	string IrsSerialNumber {xpath('IrsSerialNumber')};
	string CertificateNumber {xpath('CertificateNumber')};
	dataset(t_SrcFilingStatus) FilingStatus {xpath('FilingStatus/Status'), MAXCOUNT(1)};
	dataset(t_SrcJnLParty) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(1)};
	dataset(t_SrcJnLParty) Creditors {xpath('Creditors/Creditor'), MAXCOUNT(1)};
	dataset(t_SrcJnLParty) DebtorAttorneys {xpath('DebtorAttorneys/Attorney'), MAXCOUNT(1)};
	dataset(t_SrcJnLParty) ThirdParties {xpath('ThirdParties/Party'), MAXCOUNT(1)};
	dataset(lienjudgement.t_LienJudgmentFiling) Filings {xpath('Filings/Filing'), MAXCOUNT(1)};
end;
		
export t_SrcUCCCollateralV2 := record
	string Description {xpath('Description')};
	string Count {xpath('Count')};
	string PropertyDescription {xpath('PropertyDescription')};
	string Address {xpath('Address')};
	string SerialNumber {xpath('SerialNumber')};
	string PrimaryMachine {xpath('PrimaryMachine')};
	string SecondaryMachine {xpath('SecondaryMachine')};
	string Manufacturer {xpath('Manufacturer')};
	string ManufacturerCode {xpath('ManufacturerCode')};
	string ModelYear {xpath('ModelYear')};
	string Model {xpath('Model')};
	string ModelDesc {xpath('ModelDesc')};
	string ManufacturedYear {xpath('ManufacturedYear')};
	string NewUsed {xpath('NewUsed')};
	string Borough {xpath('Borough')};
	string Block {xpath('Block')};
	string Lot {xpath('Lot')};
	string AirRights {xpath('AirRights')};
	string SubterraneanRights {xpath('SubterraneanRights')};
	string Easment {xpath('Easment')};
end;
		
export t_SrcUccV2 := record
	string TMSId {xpath('TMSId')};
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	string OriginFilingNumber {xpath('OriginFilingNumber')};
	string OriginFilingType {xpath('OriginFilingType')};
	share.t_Date OriginFilingDate {xpath('OriginFilingDate')};
	string OriginFilingTime {xpath('OriginFilingTime')};
	dataset(ucc.t_UCCReport2Person) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(1)};
	dataset(ucc.t_UCCReport2Person) Creditors {xpath('Creditors/Creditor'), MAXCOUNT(1)};
	dataset(ucc.t_UCCReport2Person) Secureds {xpath('Secureds/Secured'), MAXCOUNT(1)};
	dataset(ucc.t_UCCReport2Person) Assignees {xpath('Assignees/Assignee'), MAXCOUNT(1)};
	dataset(ucc.t_UCCSigner) Signers {xpath('Signers/Signer'), MAXCOUNT(1)};
	dataset(t_SrcUCCCollateralV2) Collaterals {xpath('Collaterals/Collateral'), MAXCOUNT(1)};
	dataset(ucc.t_UCCReport2Filing) Filings {xpath('Filings/Filing'), MAXCOUNT(1)};
	dataset(ucc.t_UCCFilingOffice) FilingOffices {xpath('FilingOffices/Office'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) FilingStatus {xpath('FilingStatus/Description'), MAXCOUNT(1)};
end;
		
export t_SrcTargusDoc := record
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_LocationInfo := record
	string Lat {xpath('Lat')};
	string Lon {xpath('Lon')};
	string CountyName {xpath('CountyName')};
	string Msa {xpath('Msa')};
	string MsaDescription {xpath('MsaDescription')};
	share.t_Address Address {xpath('Address')};
	string ReportId {xpath('ReportId')};
end;
		
export t_PropInfo := record
	string LegalDescription {xpath('LegalDescription')};
	string LandUsage {xpath('LandUsage')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string SalePrice {xpath('SalePrice')};
	string Lender {xpath('Lender')};
	string LoanType {xpath('LoanType')};
	string LoanAmount {xpath('LoanAmount')};
	string TermOfLoan {xpath('TermOfLoan')};
	string TaxYear {xpath('TaxYear')};
	string LandValue {xpath('LandValue')};
	string ImprovementValue {xpath('ImprovementValue')};
	string TotalValue {xpath('TotalValue')};
end;
		
export t_NeighborInfo := record
	string UniqueId {xpath('UniqueId')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
	share.t_SSNInfo SSNInfo {xpath('SSNInfo')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOD {xpath('DOD')};
end;
		
export t_Entity := record
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_BusinessEntity := record
	string BusinessId {xpath('BusinessId')};
	dataset(share.t_StringArrayItem) CompanyNames {xpath('CompanyNames/CompanyName'), MAXCOUNT(1)};
end;
		
export t_LocationAssociate := record
	integer Count {xpath('Count')};
	dataset(t_Entity) Entities {xpath('Entities/Entity'), MAXCOUNT(1)};
end;
		
export t_LocationBusAssociate := record
	integer Count {xpath('Count')};
	dataset(t_BusinessEntity) BusinessEntities {xpath('BusinessEntities/BusinessEntity'), MAXCOUNT(1)};
end;
		
export t_LocAssociates := record
	t_LocationAssociate CurrentOwnerResidents {xpath('CurrentOwnerResidents')};
	t_LocationAssociate CurrentOwners {xpath('CurrentOwners')};
	t_LocationAssociate CurrentResidents {xpath('CurrentResidents')};
	t_LocationAssociate PreviousOwners {xpath('PreviousOwners')};
	t_LocationAssociate PreviousResidents {xpath('PreviousResidents')};
	t_LocationBusAssociate Others {xpath('Others')};
end;
		
export t_SourceDocCounts := record
	integer ak {xpath('ak')};
	integer atf {xpath('atf')};
	integer Bankruptcy {xpath('Bankruptcy')};
	integer lien {xpath('lien')};
	integer DriverLicense {xpath('DriverLicense')};
	integer emerge {xpath('emerge')};
	integer mswork {xpath('mswork')};
	integer Death {xpath('Death')};
	integer ProfessionLicense {xpath('ProfessionLicense')};
	integer Utility {xpath('Utility')};
	integer MotorVehicle {xpath('MotorVehicle')};
	integer eq {xpath('eq')};
	integer for {xpath('for')};
	integer dea {xpath('dea')};
	integer airc {xpath('airc')};
	integer pilot {xpath('pilot')};
	integer pilotcert {xpath('pilotcert')};
	integer Watercraft {xpath('Watercraft')};
	integer Boat {xpath('Boat')};
	integer Finder {xpath('Finder')};
	integer ucc {xpath('ucc')};
	integer Corpaffil {xpath('Corpaffil')};
	integer MerchVessel {xpath('MerchVessel')};
	integer VoterRegistration {xpath('VoterRegistration')};
	integer ccw {xpath('ccw')};
	integer HuntingLicense {xpath('HuntingLicense')};
	integer whois {xpath('whois')};
	integer Phone {xpath('Phone')};
	integer tu {xpath('tu')};
	integer Property {xpath('Property')};
	integer Deed {xpath('Deed')};
end;
		

end;

