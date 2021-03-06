/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identitymanagementreport2.xml. ***/
/*===================================================*/

import iesp;

export identitymanagementreport := MODULE

export t_IdmSSNInfo := record
	string9 SSN {xpath('SSN')};
	string32 IssuedLocation {xpath('IssuedLocation')};
	iesp.share.t_Date IssuedStartDate {xpath('IssuedStartDate')};
	iesp.share.t_Date IssuedEndDate {xpath('IssuedEndDate')};
end;

export t_IdmIdentity := record
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string6 Gender {xpath('Gender')};
	dataset(iesp.share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(iesp.Constants.IDM.MaxAKAs)};
end;

export t_IdmAddressInfo := record
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.share.t_AddressWithGeoLocation Address {xpath('Address')};
	boolean Filtered {xpath('Filtered')};
end;

export t_IdmPersonRecord := record
	iesp.share.t_Name Name {xpath('Name')};
	t_IdmSSNInfo SSNInfo {xpath('SSNInfo')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string6 Gender {xpath('Gender')};
	dataset(t_IdmAddressInfo) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.IDM.MaxAddress)};
	dataset(iesp.share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(iesp.Constants.IDM.MaxAKAs)};
end;

export t_IdmWaterCraftReport2Description := record
	string30 HullNumber {xpath('HullNumber')};
	string20 VesselType {xpath('VesselType')};
	string20 VesselName {xpath('VesselName')};
	string20 HullType {xpath('HullType')};
	integer ModelYear {xpath('ModelYear')};
	string30 Make {xpath('Make')};
	string30 Model {xpath('Model')};
	string7 Length {xpath('Length')};
end;

export t_IdmWaterCraftReport2Title := record
	string2 State {xpath('State')};
	iesp.share.t_Date IssueDate {xpath('IssueDate')};
end;

export t_IdmWaterCraftDetail := record
	string30 WaterCraftKey {xpath('WaterCraftKey')};
	iesp.share.t_Date PurchaseDate {xpath('PurchaseDate')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	t_IdmWaterCraftReport2Description Description {xpath('Description')};
	t_IdmWaterCraftReport2Title Title {xpath('Title')};
	boolean Filtered {xpath('Filtered')};
end;

export t_IdmWaterCraftRecord := record
	t_IdmWaterCraftDetail Watercraft {xpath('Watercraft')};
end;

export t_IdmReportAddressSlim := record
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.share.t_Address Address {xpath('Address')};
	boolean _Shared {xpath('_Shared')};
	boolean Filtered {xpath('Filtered')};
end;

export t_IdmReportRNASlim := record
	t_IdmIdentity Identity {xpath('Identity')};
	string1 Deceased {xpath('Deceased')};
	integer Confidence {xpath('Confidence')};
	dataset(t_IdmReportAddressSlim) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.IDM.MaxRNA_Address)};
	boolean Filtered {xpath('Filtered')};
end;

export t_IdmRNARecord := record
	dataset(t_IdmReportRNASlim) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.Constants.IDM.MaxRelatives)};
	dataset(t_IdmReportRNASlim) Associates {xpath('Associates/Associate'), MAXCOUNT(iesp.Constants.IDM.MaxAssociates)};
end;

export t_IdmHistPhonesRecord := record
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone10 {xpath('Phone10')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string1 Source {xpath('Source')}; //RR 176709: not in sync with ESP while product makes a decision whether they want this field or not
end;

export t_IdmPropertyMortgageInfo := record
	string60 LenderName {xpath('LenderName')};
	string60 MortgageLenderName {xpath('MortgageLenderName')};
	string11 MortgageAmount {xpath('MortgageAmount')};
	string MortgageLoanType {xpath('MortgageLoanType')};
	iesp.share.t_Date MortgageDueDate {xpath('MortgageDueDate')};
end;

export t_IdmPropertyDeed := record
	string1 DataSource {xpath('DataSource')};
	string2 State {xpath('State')};
	string18 CountyName {xpath('CountyName')};
	string11 SalesPrice {xpath('SalesPrice')};
	t_IdmPropertyMortgageInfo MortgageInfo {xpath('MortgageInfo')};
	iesp.share.t_Date ContractDate {xpath('ContractDate')};
	iesp.share.t_Date RecordingDate {xpath('RecordingDate')};
	string3 DocumentTypeCode {xpath('DocumentTypeCode')};
	string DocumentTypeDescription {xpath('DocumentTypeDescription')};
	boolean Filtered {xpath('Filtered')};
	string3 TransactionTypeCode {xpath('TransactionTypeCode')};
	string40 TransactionType {xpath('TransactionType')};
	string9 LandSize {xpath('LandSize')};
end;

export t_IdmPropertyInfo := record
	string40 Subdivision {xpath('Subdivision')};
	string LivingSquareFeet {xpath('LivingSquareFeet')};
	string30 BuildingAreaMain {xpath('BuildingAreaMain')};
	string30 BuildingArea1 {xpath('BuildingArea1')};
	string30 BuildingArea2 {xpath('BuildingArea2')};
	string30 BuildingArea3 {xpath('BuildingArea3')};
	string30 BuildingArea4 {xpath('BuildingArea4')};
	string30 BuildingArea5 {xpath('BuildingArea5')};
	string30 BuildingArea6 {xpath('BuildingArea6')};
	string30 BuildingArea7 {xpath('BuildingArea7')};
	string30 BuildingAreaMainDesc {xpath('BuildingAreaMainDesc')};
	string30 BuildingArea1Desc {xpath('BuildingArea1Desc')};
	string30 BuildingArea2Desc {xpath('BuildingArea2Desc')};
	string30 BuildingArea3Desc {xpath('BuildingArea3Desc')};
	string30 BuildingArea4Desc {xpath('BuildingArea4Desc')};
	string30 BuildingArea5Desc {xpath('BuildingArea5Desc')};
	string30 BuildingArea6Desc {xpath('BuildingArea6Desc')};
	string30 BuildingArea7Desc {xpath('BuildingArea7Desc')};
	string4 YearBuilt {xpath('YearBuilt')};
	string AirConditioning {xpath('AirConditioning')};
	string2 NumberOfBedrooms {xpath('NumberOfBedrooms')};
	string2 NumberOfBathrooms {xpath('NumberOfBathrooms')};
	string2 NumberOfStories {xpath('NumberOfStories')};
end;

export t_IdmPropertyAssess := record
	string1 DataSource {xpath('DataSource')};
	string18 CountyName {xpath('CountyName')};
	iesp.share.t_Date SaleDate {xpath('SaleDate')};
	iesp.share.t_Date RecordingDate {xpath('RecordingDate')};
	string11 SalesPrice {xpath('SalesPrice')};
	string4 TaxYear {xpath('TaxYear')};
	string13 TaxAmount {xpath('TaxAmount')};
	t_IdmPropertyInfo PropertyInfo {xpath('PropertyInfo')};
end;

export t_IdmEntity := record
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
end;

export t_IdmPropertyParty := record
	string2 PartyType {xpath('PartyType')};
	string8 PartyTypeName {xpath('PartyTypeName')};
	iesp.share.t_Address Address {xpath('Address')};
	dataset(t_IdmEntity) Entities {xpath('Entities/Entity'), MAXCOUNT(iesp.Constants.IDM.MaxPropertyEntities)};
	integer LinkingWeight {xpath('LinkingWeight')};
end;

export t_IdmPropertyMatchedParty := record
	string12 UniqueId {xpath('UniqueId')};
	string2 PartyType {xpath('PartyType')};
	string8 PartyTypeName {xpath('PartyTypeName')};
	integer LinkingWeight {xpath('LinkingWeight')};
end;

export t_IdmPropertyRecordDetails := record
	string1 RecordType {xpath('RecordType')};
	t_IdmPropertyAssess Assessment {xpath('Assessment')};
	t_IdmPropertyDeed Deed {xpath('Deed')};
	dataset(t_IdmPropertyParty) Parties {xpath('Parties/Party'), MAXCOUNT(iesp.Constants.IDM.MaxPropertyParties)};
	t_IdmPropertyMatchedParty MatchedParty {xpath('MatchedParty')};
end;

export t_IdmPropertyRecord := record
	string ApnaOrPinNumber {xpath('ApnaOrPinNumber')};
	iesp.share.t_Address PropertyAddress {xpath('PropertyAddress')};
	dataset(t_IdmPropertyRecordDetails) PropertyRecords {xpath('PropertyRecords/PropertyRecord'), MAXCOUNT(iesp.Constants.IDM.MaxPropertyRecords)};
end;

export t_IdmDriverLicenseRecord := record
	string12 UniqueId {xpath('UniqueId')};
	string3 Height {xpath('Height')};
	string15 HairColor {xpath('HairColor')};
	string15 EyeColor {xpath('EyeColor')};
	string24 LicenseNumber {xpath('LicenseNumber')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string2 IssueState {xpath('IssueState')};
	iesp.share.t_Date IssueDate {xpath('IssueDate')};
end;

export t_IdmInsuranceDriverLicenseRecord := record
	string12 UniqueId {xpath('UniqueId')};
	string24 LicenseNumber {xpath('LicenseNumber')};
	string2 IssueState {xpath('IssueState')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string9 Source {xpath('Source')};
end;

export t_IdmMVehicleRegistrationInfo := record
	iesp.share.t_Date FirstDate {xpath('FirstDate')};
	iesp.share.t_Date ExpirationDate {xpath('ExpirationDate')};
	string10 RegLicensePlate {xpath('RegLicensePlate')};
	string2 RegLicenseState {xpath('RegLicenseState')};
	string4 LicensePlateTypeCode {xpath('LicensePlateTypeCode')};
	string65 LicensePlateTypeDesc {xpath('LicensePlateTypeDesc')};
	iesp.share.t_Address Address {xpath('Address')};
end;

export t_IdmMVehicleSpecification := record
	string30 MajorColor {xpath('MajorColor')};
	string25 BodyType {xpath('BodyType')};
end;

export t_IdmMVehicleDetail := record
	integer ModelYear {xpath('ModelYear')};
	string36 Make {xpath('Make')};
	string36 Model {xpath('Model')};
	t_IdmMVehicleSpecification VehicleSpecification {xpath('VehicleSpecification')};
	iesp.share.t_Date TitleIssueDate {xpath('TitleIssueDate')};
	dataset(t_IdmMVehicleRegistrationInfo) Registrations {xpath('Registrations/Registration'), MAXCOUNT(iesp.Constants.MV.MaxCountRegistrants)};
end;

export t_IdmMVehicleRecord := record
	string VIN {xpath('VIN')};
	dataset(t_IdmMVehicleDetail) VehicleDetails {xpath('VehicleDetails/VehicleDetail'), MAXCOUNT(iesp.Constants.IDM.MaxVehicleDetails)};
end;

export t_IdmStudentCollege := record
	iesp.share.t_Date FirstReported {xpath('FirstReported')};
	iesp.share.t_Date LastReported {xpath('LastReported')};
	string50 CollegeName {xpath('CollegeName')};
	string50 CollegeMajor {xpath('CollegeMajor')};
	string25 CollegeLevel {xpath('CollegeLevel')};
	string30 CollegeType {xpath('CollegeType')};
	iesp.share.t_Address AddressAtCollege {xpath('AddressAtCollege')};
	string10 PhoneAtCollege {xpath('PhoneAtCollege')};
	boolean Filtered {xpath('Filtered')};
end;

export t_IdmStudentRecord := record
	string12 UniqueId {xpath('UniqueId')};
	string4 HighSchoolGradYear {xpath('HighSchoolGradYear')};
	dataset(t_IdmStudentCollege) Colleges {xpath('Colleges/College'), MAXCOUNT(iesp.Constants.IDM.MaxStudentColleges)};
end;

export t_IdmAircraftRegistrant := record
	string50 Name {xpath('Name')};
	string33 Street {xpath('Street')};
	string33 Street2 {xpath('Street2')};
	string18 City {xpath('City')};
	string5 State {xpath('State')};
	string10 ZipCode {xpath('ZipCode')};
	string6 Region {xpath('Region')};
	string18 CountyName {xpath('CountyName')};
	string7 Country {xpath('Country')};
	string50 CompanyName {xpath('CompanyName')};
end;

export t_IdmAircraftRegistration := record
	string10 Current {xpath('Current')};
	string8 NNumber {xpath('NNumber')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.share.t_Date LastAction {xpath('LastAction')};
	iesp.share.t_Date CertificationIssue {xpath('CertificationIssue')};
	string13 Certification {xpath('Certification')};
	t_IdmAircraftRegistrant Registrant {xpath('Registrant')};
end;

export t_IdmAircraftRecord := record
	string30 ManufacturerName {xpath('ManufacturerName')};
	string20 ModelName {xpath('ModelName')};
	string25 TypeAircraft {xpath('TypeAircraft')};
	string12 Category {xpath('Category')};
	string3 NumberOfSeats {xpath('NumberOfSeats')};
	string22 TypeEngine {xpath('TypeEngine')};
	string4 CruisingSpeed {xpath('CruisingSpeed')};
	dataset(t_IdmAircraftRegistration) Registrations {xpath('Registrations/Registration'), MAXCOUNT(iesp.Constants.IDM.MaxAircraftRegistrations)};
end;

export t_IdmNeighborAddress := record
	dataset(t_IdmIdentity) Residents {xpath('Residents/Identity'), MAXCOUNT(iesp.Constants.BR.Neigbors_Residents)};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	string110 LocationId {xpath('LocationId')};
end;

export t_IdmProfessionalLicense := record
	string60 LicenseType {xpath('LicenseType')};
	string20 LicenseNumber {xpath('LicenseNumber')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string60 ProfessionOrBoard {xpath('ProfessionOrBoard')};
	string45 Status {xpath('Status')};
	iesp.share.t_Date StatusEffectiveDate {xpath('StatusEffectiveDate')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone {xpath('Phone')};
	string8 Gender {xpath('Gender')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Date IssuedDate {xpath('IssuedDate')};
	iesp.share.t_Date ExpirationDate {xpath('ExpirationDate')};
	iesp.share.t_Date LastRenewalDate {xpath('LastRenewalDate')};
	string50 LicenseObtainedBy {xpath('LicenseObtainedBy')};
	string1 BoardActionIndicator {xpath('BoardActionIndicator')};
	string20 SourceState {xpath('SourceState')};
	string50 Occupation {xpath('Occupation')};
	string50 ProlicSeqId {xpath('ProlicSeqId')};
end;

export t_IdmInetDomainRecord := record
	string45 DomainName {xpath('DomainName')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	iesp.share.t_Date DateLastUpdated {xpath('DateLastUpdated')};
	iesp.share.t_Date DateExpires {xpath('DateExpires')};
	iesp.internetdomain.t_InetDomainPerson Registrant {xpath('Registrant')};
end;

export t_IdentityManagementReportOption := record (iesp.share.t_BaseSearchOption)
	boolean IncludePersonReport {xpath('IncludePersonReport')};
	boolean IncludeDriversLicenses {xpath('IncludeDriversLicenses')};
	boolean IncludeMotorVehicles {xpath('IncludeMotorVehicles')};
	boolean IncludeHistoricalPhones {xpath('IncludeHistoricalPhones')};
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludeRelatives {xpath('IncludeRelatives')};
	boolean IncludeNeighbors {xpath('IncludeNeighbors')};
	boolean IncludeAssociates {xpath('IncludeAssociates')};
	boolean IncludeStudentRecords {xpath('IncludeStudentRecords')};
	boolean IncludeWatercrafts {xpath('IncludeWatercrafts')};
	boolean IncludeAircrafts {xpath('IncludeAircrafts')};
	boolean IncludePeopleAtWork {xpath('IncludePeopleAtWork')};
	boolean IncludeCorporateAffiliations {xpath('IncludeCorporateAffiliations')};
	boolean IncludeEmailAddresses {xpath('IncludeEmailAddresses')};
	boolean IncludeTransactionHistory {xpath('IncludeTransactionHistory')};
	boolean IncludeRealTimeVehicle {xpath('IncludeRealTimeVehicle')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludeInternetDomains {xpath('IncludeInternetDomains')};
	integer RelativeDepth {xpath('RelativeDepth')};
	integer MaxNeighborhoods {xpath('MaxNeighborhoods')};
	integer NeighborsPerAddress {xpath('NeighborsPerAddress')};
	integer NeighborsPerNA {xpath('NeighborsPerNA')};
	string RealTimePermissibleUse {xpath('RealTimePermissibleUse')};
	integer LinkingWeightThreshold {xpath('LinkingWeightThreshold')};//hidden[internal]
	boolean IncludeNonRegulatedVehicleSources {xpath('IncludeNonRegulatedVehicleSources')};
	boolean IncludeNonRegulatedWatercraftSources {xpath('IncludeNonRegulatedWatercraftSources')};
	boolean IncludeInsuranceDrivers {xpath('IncludeInsuranceDrivers')};//hidden[internal]
	boolean SuppressCompromisedDLs {xpath('SuppressCompromisedDLs')};//hidden[internal]
end;

export t_IdentityManagementReportBy := record
	string12 UniqueId {xpath('UniqueId')};
end;

export t_IdentityManagementReportIndividual := record
	string12 UniqueId {xpath('UniqueId')};
	t_IdmPersonRecord PersonRecord {xpath('PersonRecord')};
	dataset(t_IdmPropertyRecord) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.Constants.IDM.MaxProperties)};
	dataset(t_IdmHistPhonesRecord) HistoricalPhones {xpath('HistoricalPhones/HistoricalPhone'), MAXCOUNT(iesp.Constants.IDM.MaxHistoricalPhones)};
	dataset(t_IdmMVehicleRecord) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(iesp.Constants.IDM.MaxVehicles)};
	dataset(t_IdmWaterCraftRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.Constants.IDM.MaxWatercrafts)};
	dataset(t_IdmAircraftRecord) Aircrafts {xpath('Aircrafts/Aircraft'), MAXCOUNT(iesp.Constants.IDM.MaxAircrafts)};
	dataset(t_IdmReportRNASlim) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.Constants.IDM.MaxRelatives)};
	dataset(t_IdmNeighborAddress) Neighbors {xpath('Neighbors/Neighbor'), MAXCOUNT(iesp.Constants.IDM.MaxNeighbors)};
	dataset(t_IdmReportRNASlim) Associates {xpath('Associates/Associate'), MAXCOUNT(iesp.Constants.IDM.MaxAssociates)};
	t_IdmStudentRecord StudentRecord {xpath('StudentRecord')};
	dataset(t_IdmDriverLicenseRecord) DriverLicenses {xpath('DriverLicenses/DriverLicense'), MAXCOUNT(iesp.Constants.IDM.MaxDriverLicenses)};
	dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) PeopleAtWork {xpath('PeopleAtWork/PeopleAtWork'), MAXCOUNT(iesp.Constants.IDM.MaxPeopleAtWork)};
	dataset(iesp.bpsreport.t_BpsCorpAffiliation) CorporateAffiliations {xpath('CorporateAffiliations/Affiliation'), MAXCOUNT(iesp.Constants.SMART.MaxBusiness)};
	dataset(iesp.motorvehicle.t_MotorVehicleReport2Record) MotorVehicleRecords {xpath('MotorVehicleRecords/MotorVehicleRecord'), MAXCOUNT(iesp.Constants.IDM.MaxVehicles)};
	dataset(iesp.emailsearch.t_EmailSearchRecord) EmailAddresses {xpath('EmailAddresses/EmailAddress'), MAXCOUNT(iesp.Constants.IDM.MaxEmails)};
	dataset(iesp.transactionhistory.t_TransactionHistoryRecord) TransactionHistory {xpath('TransactionHistory/Transactions'), MAXCOUNT(iesp.Constants.IDM.MaxTransactions)};
	dataset(t_IdmProfessionalLicense) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(iesp.Constants.IDM.MaxProfLicenses)};
	dataset(t_IdmInetDomainRecord) InternetDomains {xpath('InternetDomains/InternetDomain'), MAXCOUNT(iesp.Constants.BR.MaxInternetDomains)};
	dataset(t_IdmInsuranceDriverLicenseRecord) InsuranceDriverLicenses {xpath('InsuranceDriverLicenses/InsuranceDriverLicense'), MAXCOUNT(iesp.Constants.IDM.MaxDriverLicenses)};
	boolean SuppressCompromisedDLIndicator {xpath('SuppressCompromisedDLIndicator')};//hidden[internal]
	string128 CompromisedDLHash {xpath('CompromisedDLHash')};//hidden[internal]
end;

export t_IdentityManagementReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_IdentityManagementReportBy InputEcho {xpath('InputEcho')};
	t_IdentityManagementReportIndividual Individual {xpath('Individual')};
end;

export t_IdentityManagementReportRequest := record (iesp.share.t_BaseRequest)
	t_IdentityManagementReportOption Options {xpath('Options')};
	t_IdentityManagementReportBy ReportBy {xpath('ReportBy')};
end;

export t_IdentityManagementReportResponseEx := record
	t_IdentityManagementReportResponse response {xpath('response')};
end;


end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identitymanagementreport2.xml. ***/
/*===================================================*/

