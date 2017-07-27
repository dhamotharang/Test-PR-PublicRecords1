export rollupbizreport := MODULE
			
export t_BizReportFor := record
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	string FEIN {xpath('FEIN')};
	share.t_Address Address {xpath('Address')};
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
	string ReportId {xpath('ReportId')};
	string MsaNumber {xpath('MsaNumber')};
	string MsaDescription {xpath('MsaDescription')};
end;
		
export t_Incorp := record
	string StateOfOrigin {xpath('StateOfOrigin')};
	string CharterNumber {xpath('CharterNumber')};
	string CompanyName {xpath('CompanyName')};
end;
		
export t_Business := record
	string BusinessId {xpath('BusinessId')};
	dataset(share.t_StringArrayItem) DUNs {xpath('DUNs/DUN'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) FEINs {xpath('FEINs/FEIN'), MAXCOUNT(1)};
	dataset(t_Incorp) StateIds {xpath('StateIds/StateId'), MAXCOUNT(1)};
end;
		
export t_Profile := record
	string CompanyName {xpath('CompanyName')};
	string BusinessId {xpath('BusinessId')};
	string CharterNumber {xpath('CharterNumber')};
	string StatusOfIncorporation {xpath('StatusOfIncorporation')};
	string CorporationStructure {xpath('CorporationStructure')};
	string StateOfOrigin {xpath('StateOfOrigin')};
	share.t_Date DateOfIncorporation {xpath('DateOfIncorporation')};
	string Duration {xpath('Duration')};
end;
		
export t_RegisteredAgent := record
	string BusinessId {xpath('BusinessId')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_Contact := record
	string BusinessId {xpath('BusinessId')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	share.t_Address Address {xpath('Address')};
	share.t_Name Name {xpath('Name')};
	dataset(share.t_StringArrayItem) CompanyTitles {xpath('CompanyTitles/Title'), MAXCOUNT(1)};
end;
		
export t_Domain := record
	string BusinessId {xpath('BusinessId')};
	string DomainName {xpath('DomainName')};
end;
		
export t_ProfLicense := record
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	string ObtainedBy {xpath('ObtainedBy')};
	string BoardAction {xpath('BoardAction')};
	string Status {xpath('Status')};
	string LicenseNumber {xpath('LicenseNumber')};
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	string ProfessionOrBoard {xpath('ProfessionOrBoard')};
	string LicenseType {xpath('LicenseType')};
	string LicenseState {xpath('LicenseState')};
end;
		
export t_Executive := record
	string UniqueId {xpath('UniqueId')};
	string BusinessId {xpath('BusinessId')};
	share.t_Name Name {xpath('Name')};
	dataset(share.t_StringArrayItem) CompanyTitles {xpath('CompanyTitles/Title'), MAXCOUNT(1)};
end;
		
export t_Debtor := record
	string DebtorType {xpath('DebtorType')};
	string SSN {xpath('SSN')};
	string UniqueId {xpath('UniqueId')};
	string BusinessId {xpath('BusinessId')};
	dataset(share.t_NameAndCompany) Names {xpath('Names/Name'), MAXCOUNT(1)};
	dataset(share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
end;
		
export t_Attorney := record
	string Name {xpath('Name')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_Bankruptcy := record
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date OriginalFilingDate {xpath('OriginalFilingDate')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtState {xpath('CourtState')};
	string CourtName {xpath('CourtName')};
	string CourtCode {xpath('CourtCode')};
	string Chapter {xpath('Chapter')};
	string RecordType {xpath('RecordType')};
	string OriginalCaseNumber {xpath('OriginalCaseNumber')};
	dataset(t_Attorney) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(1)};
	dataset(t_Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(1)};
end;
		
export t_BidJudgmentOrLien := record
	string Court {xpath('Court')};
	string Plaintiff {xpath('Plaintiff')};
	string Defendant {xpath('Defendant')};
	string Amount {xpath('Amount')};
	share.t_Date FilingDate {xpath('FilingDate')};
	string FilingDescription {xpath('FilingDescription')};
	string CaseNumber {xpath('CaseNumber')};
end;
		
export t_BidUCC := record
	string Debtor {xpath('Debtor')};
	string SecuredName {xpath('SecuredName')};
	share.t_Date FilingDate {xpath('FilingDate')};
	string FilingDescription {xpath('FilingDescription')};
	string FilingState {xpath('FilingState')};
	string DocumentNumber {xpath('DocumentNumber')};
end;
		
export t_BidJudgmentsLiensAndUCCs := record
	dataset(t_BidJudgmentOrLien) JudgmentsAndLiens {xpath('JudgmentsAndLiens/JudgmentOrLien'), MAXCOUNT(1)};
	dataset(t_BidUCC) UCCs {xpath('UCCs/UCC'), MAXCOUNT(1)};
end;
		
export t_ParentCompany := record
	integer Level {xpath('Level')};
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_BizProperty := record
	string BusinessId {xpath('BusinessId')};
	string Current {xpath('Current')};
	string RecordType {xpath('RecordType')};
	string Uapn {xpath('Uapn')};
	string Fapn {xpath('Fapn')};
	string BookPage {xpath('BookPage')};
	string LotNumber {xpath('LotNumber')};
	string PropertyCounty {xpath('PropertyCounty')};
	string LandUsage {xpath('LandUsage')};
	string SubdivisionName {xpath('SubdivisionName')};
	string TotalValue {xpath('TotalValue')};
	string LandValue {xpath('LandValue')};
	string ImprovementValue {xpath('ImprovementValue')};
	string LandSize {xpath('LandSize')};
	string BuildingSize {xpath('BuildingSize')};
	string YearBuilt {xpath('YearBuilt')};
	string SalePrice {xpath('SalePrice')};
	string LegalDescription {xpath('LegalDescription')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string NameOfSeller {xpath('NameOfSeller')};
	string LoanAmount {xpath('LoanAmount')};
	string LoanTermCode {xpath('LoanTermCode')};
	string LoanTerm {xpath('LoanTerm')};
	string LoanType {xpath('LoanType')};
	string LoanDeedType {xpath('LoanDeedType')};
	string LoanDeedSubType {xpath('LoanDeedSubType')};
	string LenderName {xpath('LenderName')};
	string BuildingSquareFeet {xpath('BuildingSquareFeet')};
	string TitleCompanyName {xpath('TitleCompanyName')};
	string DocumentNumber {xpath('DocumentNumber')};
	string DocumentType {xpath('DocumentType')};
	string TransactionType {xpath('TransactionType')};
	string TaxYear {xpath('TaxYear')};
	string TaxAmount {xpath('TaxAmount')};
	string MktTotalVal {xpath('MktTotalVal')};
	string MktLandVal {xpath('MktLandVal')};
	string MktImprovementVal {xpath('MktImprovementVal')};
	string LivingSquareFeet {xpath('LivingSquareFeet')};
	string StoriesNumber {xpath('StoriesNumber')};
	string Foundation {xpath('Foundation')};
	string Bedrooms {xpath('Bedrooms')};
	string FullBaths {xpath('FullBaths')};
	string HalfBaths {xpath('HalfBaths')};
	string AssdTotalVal {xpath('AssdTotalVal')};
	share.t_Address Address {xpath('Address')};
	dataset(share.t_StringArrayItem) OtherBuyers {xpath('OtherBuyers/Buyer'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) OtherSellers {xpath('OtherSellers/Seller'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Owners {xpath('Owners/Owner'), MAXCOUNT(1)};
end;
		
export t_SicCode := record
	string Sic {xpath('Sic')};
	string Description {xpath('Description')};
end;
		
export t_AddressInfo := record
	share.t_Address Address {xpath('Address')};
	string LocationId {xpath('LocationId')};
	string MsaNumber {xpath('MsaNumber')};
	string MsaDescription {xpath('MsaDescription')};
	string SourceDocId {xpath('SourceDocId')};
end;
		
export t_BusinessAssociate := record
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string BusinessId {xpath('BusinessId')};
end;
		
export t_CompanyNameVariation := record
	string CompanyName {xpath('CompanyName')};
	string SourceDocId {xpath('SourceDocId')};
end;
		
export t_PhoneVariation := record
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
	string SourceDocId {xpath('SourceDocId')};
end;
		
export t_BidReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	t_BizReportFor ReportFor {xpath('ReportFor')};
	t_BidJudgmentsLiensAndUCCs JudgmentsLiensAndUCCs {xpath('JudgmentsLiensAndUCCs')};
	t_BizReportFor ParentCompanyInfo {xpath('ParentCompanyInfo')};
	dataset(t_AddressInfo) AddressVariations {xpath('AddressVariations/AddressInfo'), MAXCOUNT(1)};
	dataset(t_Business) Businesses {xpath('Businesses/Business'), MAXCOUNT(1)};
	dataset(t_Profile) Profiles {xpath('Profiles/Profile'), MAXCOUNT(1)};
	dataset(t_RegisteredAgent) RegisteredAgents {xpath('RegisteredAgents/RegisteredAgent'), MAXCOUNT(1)};
	dataset(t_Contact) Contacts {xpath('Contacts/Contact'), MAXCOUNT(1)};
	dataset(t_Domain) InternetDomains {xpath('InternetDomains/Domain'), MAXCOUNT(1)};
	dataset(t_ProfLicense) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(1)};
	dataset(t_Executive) Executives {xpath('Executives/Executive'), MAXCOUNT(1)};
	dataset(t_Bankruptcy) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(1)};
	dataset(bankruptcy.t_BankruptcyReport2Record) Bankruptcies2 {xpath('Bankruptcies2/Bankruptcy'), MAXCOUNT(1)};
	dataset(lienjudgement.t_LienJudgmentReportRecord) LiensJudgments2 {xpath('LiensJudgments2/LienJudgment'), MAXCOUNT(1)};
	dataset(t_BidUCC) UCCs {xpath('UCCs/UCC'), MAXCOUNT(1)};
	dataset(ucc.t_UCCRecordBase) UCCsEx {xpath('UCCsEx/UCC'), MAXCOUNT(1)};
	dataset(t_ParentCompany) ParentCompanies {xpath('ParentCompanies/ParentCompany'), MAXCOUNT(1)};
	dataset(t_BizProperty) Properties {xpath('Properties/Property'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Sales {xpath('Sales/Amount'), MAXCOUNT(1)};
	dataset(t_SicCode) SicCodes {xpath('SicCodes/SicCode'), MAXCOUNT(1)};
	dataset(share.t_SourceSection) Sources {xpath('Sources/Source'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) SuperiorLiens {xpath('SuperiorLiens/SuperiorLien'), MAXCOUNT(1)};
	dataset(t_BusinessAssociate) BusinessAssociates {xpath('BusinessAssociates/BusinessAssociate'), MAXCOUNT(1)};
	dataset(motorvehicle.t_MVReportRecord) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(1)};
	dataset(faaaircraft.t_AircraftReportRecord) Aircrafts {xpath('Aircrafts/Aircraft'), MAXCOUNT(1)};
	dataset(watercraft.t_WaterCraftReportRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(1)};
	dataset(watercraft.t_WaterCraftReport2Record) WaterCrafts2 {xpath('WaterCrafts2/WaterCraft'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) NameVariations {xpath('NameVariations/CompanyName'), MAXCOUNT(1)};
	dataset(t_CompanyNameVariation) NameVariationsEx {xpath('NameVariationsEx/CompanyNameVariation'), MAXCOUNT(1)};
	dataset(t_PhoneVariation) PhoneVariationsEx {xpath('PhoneVariationsEx/PhoneVariation'), MAXCOUNT(1)};
	dataset(share.t_PhoneInfo) PhoneVariations {xpath('PhoneVariations/PhoneInfo'), MAXCOUNT(1)};
end;
		
export t_BIDReportOptions := record (share.t_BaseSearchOption)
	boolean IncludeDPPABusinessSources {xpath('IncludeDPPABusinessSources')};
end;
		
export t_BIDReportBy := record
	string BusinessId {xpath('BusinessId')};
end;
		
export t_BIDReportRequest := record (share.t_BaseRequest)
	t_BIDReportOptions Options {xpath('Options')};
	t_BIDReportBy SearchBy {xpath('SearchBy')};
end;
		
export t_BIDReportResponseEx := record
	t_BidReportResponse response {xpath('response')};
end;
		

end;

