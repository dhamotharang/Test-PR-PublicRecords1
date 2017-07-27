export bizreport := MODULE
			
export t_BizReportBy := record
	string BusinessId {xpath('BusinessId')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_BizReportOption := record (share.t_BaseReportOption)
	boolean IncludeCorporateFilings {xpath('IncludeCorporateFilings')};
	boolean IncludeContacts {xpath('IncludeContacts')};
	boolean IncludeBussinessesAtSameAddress {xpath('IncludeBussinessesAtSameAddress')};
	boolean IncludeBussinessesWithSamePhone {xpath('IncludeBussinessesWithSamePhone')};
	boolean IncludeBusinessesAtSameAddress {xpath('IncludeBusinessesAtSameAddress')};
	boolean IncludeBusinessesWithSamePhone {xpath('IncludeBusinessesWithSamePhone')};
	boolean IncludeUCCFilings {xpath('IncludeUCCFilings')};
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludeMotorVehicles {xpath('IncludeMotorVehicles')};
	boolean IncludeInternetDomains {xpath('IncludeInternetDomains')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
	boolean IncludeResidentsAtSameAddress {xpath('IncludeResidentsAtSameAddress')};
	boolean IncludeBusinessRegistrations {xpath('IncludeBusinessRegistrations')};
	boolean IncludeDnBReport {xpath('IncludeDnBReport')};
	boolean IncludeLiensJudgments {xpath('IncludeLiensJudgments')};
	boolean IncludeAssociatedBusinesses {xpath('IncludeAssociatedBusinesses')};
end;
		
export t_BizIdentity := record
	string UniqueId {xpath('UniqueId')};
	string Name {xpath('Name')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_BizSIC := record
	string Code {xpath('Code')};
	string Description {xpath('Description')};
end;
		
export t_BizInternetDomain := record
	string DomainName {xpath('DomainName')};
end;
		
export t_BizRegistration := record
	string State {xpath('State')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	string FilingNumber {xpath('FilingNumber')};
	share.t_Date FilingDate {xpath('FilingDate')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string BusinessDescription {xpath('BusinessDescription')};
	string Phone {xpath('Phone')};
	string FilingType1 {xpath('FilingType1')};
	string FilingType2 {xpath('FilingType2')};
	string FilingType3 {xpath('FilingType3')};
	string Status {xpath('Status')};
	string FEIN {xpath('FEIN')};
end;
		
export t_DnBExecutive := record
	string Title {xpath('Title')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_DnBRcord := record
	string CompanyName {xpath('CompanyName')};
	string DunsNumber {xpath('DunsNumber')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string TradeName {xpath('TradeName')};
	share.t_Address Address {xpath('Address')};
	share.t_Address MailingAddress {xpath('MailingAddress')};
	string Phone {xpath('Phone')};
	integer YearStarted {xpath('YearStarted')};
	share.t_Date DateOfIncorporation {xpath('DateOfIncorporation')};
	string StateOfIncorporation {xpath('StateOfIncorporation')};
	string AnnualSales {xpath('AnnualSales')};
	share.t_Date SalesRevisionDate {xpath('SalesRevisionDate')};
	integer TotalEmployees {xpath('TotalEmployees')};
	integer EmployeesHere {xpath('EmployeesHere')};
	string NetWorth {xpath('NetWorth')};
	string LineOfBusiness {xpath('LineOfBusiness')};
	string PrimarySIC {xpath('PrimarySIC')};
	string PrimarySICDescription {xpath('PrimarySICDescription')};
	string SecondarySIC {xpath('SecondarySIC')};
	string SecondarySICDescription {xpath('SecondarySICDescription')};
	string EstablishmentType {xpath('EstablishmentType')};
	string StructureType {xpath('StructureType')};
	string FacilityOwnership {xpath('FacilityOwnership')};
	boolean SmallBusiness {xpath('SmallBusiness')};
	boolean MinorityOwned {xpath('MinorityOwned')};
	boolean ForeignOwned {xpath('ForeignOwned')};
	boolean Public {xpath('Public')};
end;
		
export t_DnBReportRecord := record (t_DnBRcord)
	dataset(t_DnBExecutive) Executives {xpath('Executives/Executive'), MAXCOUNT(1)};
end;
		
export t_PropertyRecord := record
	string ParcelNumber {xpath('ParcelNumber')};
	string AlternateParcelNumber {xpath('AlternateParcelNumber')};
	string LotNumber {xpath('LotNumber')};
	string FirstOwnerName {xpath('FirstOwnerName')};
	string SecondOwnerName {xpath('SecondOwnerName')};
	share.t_Address OwnerAddress {xpath('OwnerAddress')};
	share.t_Address PropertyAddress {xpath('PropertyAddress')};
	string LandUse {xpath('LandUse')};
	string SubdivisionName {xpath('SubdivisionName')};
	string TotalValue {xpath('TotalValue')};
	string LandValue {xpath('LandValue')};
	string ImprovementValue {xpath('ImprovementValue')};
	string LandSize {xpath('LandSize')};
	string BuildingSize {xpath('BuildingSize')};
	integer YearBuilt {xpath('YearBuilt')};
	share.t_Date SaleDate {xpath('SaleDate')};
	string SalePrice {xpath('SalePrice')};
	string SellerName {xpath('SellerName')};
	string LegalDescription {xpath('LegalDescription')};
	integer BookNumber {xpath('BookNumber')};
	integer PageNumber {xpath('PageNumber')};
	integer DocumentNumber {xpath('DocumentNumber')};
	share.t_Address SellerAddress {xpath('SellerAddress')};
	string BriefDescription {xpath('BriefDescription')};
	dataset(share.t_StringArrayItem) Owners {xpath('Owners/Name'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Sellers {xpath('Sellers/Name'), MAXCOUNT(1)};
end;
		
export t_BizProperties := record
	dataset(t_PropertyRecord) PresentProperties {xpath('PresentProperties/PresentProperty'), MAXCOUNT(1)};
	dataset(t_PropertyRecord) PriorProperties {xpath('PriorProperties/PriorProperty'), MAXCOUNT(1)};
end;
		
export t_BizResidentIdentity := record
	share.t_Name Name {xpath('Name')};
	share.t_SSNInfo SSNInfo {xpath('SSNInfo')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date DOD {xpath('DOD')};
	integer Age {xpath('Age')};
end;
		
export t_BizResidentCurrentAddress := record
	share.t_Address Address {xpath('Address')};
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
end;
		
export t_BizResidentRecord := record
	t_BizResidentIdentity Identity {xpath('Identity')};
	t_BizResidentCurrentAddress CurrentAddress {xpath('CurrentAddress')};
	dataset(t_BizResidentIdentity) AKAs {xpath('AKAs/AKA'), MAXCOUNT(1)};
end;
		
export t_BizResidentsAtAddress := record
	string Remark {xpath('Remark')};
	dataset(t_BizResidentRecord) Residents {xpath('Residents/Resident'), MAXCOUNT(1)};
end;
		
export t_BizBusinessEntity := record
	share.t_Address Address {xpath('Address')};
	dataset(t_BizIdentity) Identities {xpath('Identities/Identity'), MAXCOUNT(1)};
	dataset(t_BizSIC) SICs {xpath('SICs/SIC'), MAXCOUNT(1)};
end;
		
export t_BizOtherBusinesses := record
	string Remark {xpath('Remark')};
	dataset(t_BizBusinessEntity) Businesses {xpath('Businesses/Business'), MAXCOUNT(1)};
end;
		
export t_LienJudgmentDefendant := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string CompanyName {xpath('CompanyName')};
	string SSN {xpath('SSN')};
	string Book {xpath('Book')};
	string Page {xpath('Page')};
	string OtherCaseNumber {xpath('OtherCaseNumber')};
end;
		
export t_BizLienJudgment := record
	string FilingType {xpath('FilingType')};
	string CourtLocation {xpath('CourtLocation')};
	string CourtState {xpath('CourtState')};
	string CourtDescription {xpath('CourtDescription')};
	string CaseNumber {xpath('CaseNumber')};
	string Amount {xpath('Amount')};
	share.t_Date DateFiled {xpath('DateFiled')};
	share.t_Date DateDisposed {xpath('DateDisposed')};
	string Plaintiff {xpath('Plaintiff')};
	t_LienJudgmentDefendant Defendant {xpath('Defendant')};
end;
		
export t_BizAssociatedBy := record
	boolean Phone {xpath('Phone')};
	boolean FEIN {xpath('FEIN')};
	boolean FBN {xpath('FBN')};
	boolean CorporateFiling {xpath('CorporateFiling')};
end;
		
export t_BizAssociatedBusiness := record (t_BizIdentity)
	t_BizAssociatedBy AssociatedBy {xpath('AssociatedBy')};
end;
		
export t_BizAssociatedBusinesses := record
	string Remark {xpath('Remark')};
	dataset(t_BizBusinessEntity) Businesses {xpath('Businesses/Business'), MAXCOUNT(1)};
end;
		
export t_BizReportRecord := record
	t_BizIdentity SubjectIdentity {xpath('SubjectIdentity')};
	t_BizOtherBusinesses BusinessesWithSamePhone {xpath('BusinessesWithSamePhone')};
	t_BizOtherBusinesses BusinessesAtSameAddress {xpath('BusinessesAtSameAddress')};
	t_BizAssociatedBusinesses AssociatedBusinesses2 {xpath('AssociatedBusinesses2')};
	t_BizProperties Properties {xpath('Properties')};
	t_BizResidentsAtAddress ResidentsAtSameAddress {xpath('ResidentsAtSameAddress')};
	dataset(t_BizIdentity) AlternateIdentities {xpath('AlternateIdentities/Identity'), MAXCOUNT(1)};
	dataset(t_BizAssociatedBusiness) AssociatedBusinesses {xpath('AssociatedBusinesses/AssociatedBusiness'), MAXCOUNT(1)};
	dataset(corporate.t_CorpReportRecord) CorporateFilings {xpath('CorporateFilings/CorporateFiling'), MAXCOUNT(1)};
	dataset(ucc.t_UCCReportRecord) UCCFilings {xpath('UCCFilings/UCCFiling'), MAXCOUNT(1)};
	dataset(corporate.t_CorpContact) Contacts {xpath('Contacts/Contact'), MAXCOUNT(1)};
	dataset(t_BizSIC) SICs {xpath('SICs/SIC'), MAXCOUNT(1)};
	dataset(t_BizInternetDomain) InternetDomains {xpath('InternetDomains/Domain'), MAXCOUNT(1)};
	dataset(bankruptcy.t_BankruptcyReportRecord) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(1)};
	dataset(t_BizRegistration) BusinessRegistrations {xpath('BusinessRegistrations/BusinessRegistration'), MAXCOUNT(1)};
	dataset(t_DnBReportRecord) DnBReports {xpath('DnBReports/DnBReport'), MAXCOUNT(1)};
	dataset(motorvehicle.t_MVReportRecord) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(1)};
	dataset(t_BizLienJudgment) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(1)};
end;
		
export t_BizReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_BizReportRecord Business {xpath('Business')};
end;
		
export t_BizReportRequest := record (share.t_BaseRequest)
	t_BizReportBy ReportBy {xpath('ReportBy')};
	t_BizReportOption Options {xpath('Options')};
end;
		
export t_BizReportResponseEx := record
	t_BizReportResponse response {xpath('response')};
end;
		

end;

