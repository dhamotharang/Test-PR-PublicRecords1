export tsunami := MODULE
			
export t_SurnameSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean BlanksFilledIn {xpath('BlanksFilledIn')};
end;
		
export t_SurnameSearchBy := record
	string LastName {xpath('LastName')};
	string FirstName {xpath('FirstName')};
	string State {xpath('State')};
	integer MaxResults {xpath('MaxResults')};
end;
		
export t_SurnameSearchRecord := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Phone {xpath('Phone')};
end;
		
export t_SurnameSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	integer SurnameCount {xpath('SurnameCount')};
	dataset(t_SurnameSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_BatchPersonSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean BlanksFilledIn {xpath('BlanksFilledIn')};
end;
		
export t_BatchPersonSearchBy := record
	dataset(share.t_StringArrayItem) Phones {xpath('Phones/Item'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) SSNs {xpath('SSNs/Item'), MAXCOUNT(1)};
	dataset(share.t_Date) DOBs {xpath('DOBs/Item'), MAXCOUNT(1)};
	dataset(share.t_Address) Addresses {xpath('Addresses/Item'), MAXCOUNT(1)};
	dataset(share.t_Name) Names {xpath('Names/Item'), MAXCOUNT(1)};
end;
		
export t_BatchPersonSearchRecord := record
	string Penlty {xpath('Penlty')};
	string UniqueId {xpath('UniqueId')};
end;
		
export t_BatchPersonSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	integer ResultsStatus {xpath('ResultsStatus')};
	dataset(t_BatchPersonSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_BIDReportSourceOptions := record
	boolean IncludeNameVariations {xpath('IncludeNameVariations')};
	boolean IncludeAddressVariations {xpath('IncludeAddressVariations')};
	boolean IncludePhoneVariations {xpath('IncludePhoneVariations')};
	boolean IncludeLiensJudgments {xpath('IncludeLiensJudgments')};
	boolean IncludeAssociatedPeople {xpath('IncludeAssociatedPeople')};
	boolean IncludeInternetDomains {xpath('IncludeInternetDomains')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
	boolean IncludeBusinessRegistrations {xpath('IncludeBusinessRegistrations')};
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludeCompanyIDnumbers {xpath('IncludeCompanyIDnumbers')};
	boolean IncludeCompanyProfile {xpath('IncludeCompanyProfile')};
	integer MaxSupergroup {xpath('MaxSupergroup')};
	integer MaxNameVariations {xpath('MaxNameVariations')};
	integer MaxPhoneVariations {xpath('MaxPhoneVariations')};
	integer MaxLiensJudgments {xpath('MaxLiensJudgments')};
	integer MaxAssociatedPeople {xpath('MaxAssociatedPeople')};
	integer MaxInternetDomains {xpath('MaxInternetDomains')};
	integer MaxBankruptcies {xpath('MaxBankruptcies')};
	integer MaxBusinessRegistrations {xpath('MaxBusinessRegistrations')};
	integer MaxProperties {xpath('MaxProperties')};
	integer MaxProfessionalLicenses {xpath('MaxProfessionalLicenses')};
	boolean Blind {xpath('Blind')};//hidden[internal]
end;
		
export t_BIDReportSourceBy := record
	string BusinessId {xpath('BusinessId')};
end;
		
export t_BIDReportSourceResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
end;
		
export t_SourceDocOptions := record (share.t_BaseOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean PruneAgedSSNs {xpath('PruneAgedSSNs')};//hidden[lndayton]
	boolean IncludeDPPABusinessSources {xpath('IncludeDPPABusinessSources')};
end;
		
export t_SourceDocBy := record
	dataset(share.t_StringArrayItem) SourceDocIds {xpath('SourceDocIds/Item'), MAXCOUNT(1)};
end;
		
export t_SourceDocResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(sourcedoc.t_SrcFinder) FinderDocuments {xpath('FinderDocuments/FinderDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcDca) DcaDocuments {xpath('DcaDocuments/DcaDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcBusHeader) BusinessHeaderDocuments {xpath('BusinessHeaderDocuments/BusinessHeaderDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcDnb) DnbDocuments {xpath('DnbDocuments/DnbDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcCorpFiling) CorporateFilingDocuments {xpath('CorporateFilingDocuments/CorporateFilingDocument'), MAXCOUNT(1)};
	dataset(corporate.t_CorporateReport2Record) CorporateFilings {xpath('CorporateFilings/CorporateFiling'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcInternet) InternetDomainDocuments {xpath('InternetDomainDocuments/InternetDomainDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcUcc) UccDocuments {xpath('UccDocuments/UccDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcUccV2) UccDocumentsEx {xpath('UccDocumentsEx/UccDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcLienJudgment) LienJudgmentDocuments {xpath('LienJudgmentDocuments/LienJudgmentDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcJudgmentLien) JudgmentLienDocuments {xpath('JudgmentLienDocuments/JudgmentLienDocument'), MAXCOUNT(1)};
	dataset(rollupbizreport.t_BizProperty) PropertyDocuments {xpath('PropertyDocuments/PropertyDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcBankruptcy) BankruptcyDocuments {xpath('BankruptcyDocuments/BankruptcyDocument'), MAXCOUNT(1)};
	dataset(bankruptcy.t_BankruptcyReport2Record) BankruptcyReportRecords {xpath('BankruptcyReportRecords/BankruptcyReportRecord'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcProfLic) ProfessionalLicenseDocuments {xpath('ProfessionalLicenseDocuments/ProfessionalLicenseDocument'), MAXCOUNT(1)};
	dataset(proflicense.t_ProfessionalLicenseRecord) ProfessionalLicenseRecords {xpath('ProfessionalLicenseRecords/ProfessionalLicenseRecord'), MAXCOUNT(1)};
	dataset(motorvehicle.t_MVReportRecord) MotorVehicleDocuments {xpath('MotorVehicleDocuments/MotorVehicleDocument'), MAXCOUNT(1)};
	dataset(motorvehicle.t_MotorVehicleReport2Record) MotorVehicleRecords {xpath('MotorVehicleRecords/MotorVehicleRecord'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcDeed) DeedDocuments {xpath('DeedDocuments/DeedDocument'), MAXCOUNT(1)};
	dataset(property.t_PropDeedSrc2Record) DeedRecords {xpath('DeedRecords/DeedRecord'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcDeath) DeathRecordDocuments {xpath('DeathRecordDocuments/DeathRecordDocument'), MAXCOUNT(1)};
	dataset(death.t_DeathReportRecord) DeathRecords {xpath('DeathRecords/DeathRecord'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcMsWork) MsWorkmenCompDocuments {xpath('MsWorkmenCompDocuments/MsWorkmenCompDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcAkPermenantFund) AkPermFundDocuments {xpath('AkPermFundDocuments/AkPermFundDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcDea) DeaDocuments {xpath('DeaDocuments/DeaDocument'), MAXCOUNT(1)};
	dataset(foreclosure.t_ForeclosureReportRecord) ForeclosureDocuments {xpath('ForeclosureDocuments/ForeclosureDocument'), MAXCOUNT(1)};
	dataset(driverlicense.t_DriverLicenseRecord) DriverLicenseDocuments {xpath('DriverLicenseDocuments/DriverLicenseDocument'), MAXCOUNT(1)};
	dataset(driverlicense2.t_DLReport2DLConvictionPoint) DLConvictionPointsEx {xpath('DLConvictionPointsEx/DLConvictionPoint'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcEmerges) EmergeDocuments {xpath('EmergeDocuments/EmergeDocument'), MAXCOUNT(1)};
	dataset(voter.t_VoterReport2Record) VoterRegistrations {xpath('VoterRegistrations/VoterRegistration'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcPhone) PhoneDocuments {xpath('PhoneDocuments/PhoneDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcCorpAffil) CorporateAffiliationDocuments {xpath('CorporateAffiliationDocuments/CorporateAffiliationDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcVessel) MerchantVesselDocuments {xpath('MerchantVesselDocuments/MerchantVesselDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcUtility) UtilityDocuments {xpath('UtilityDocuments/UtilityDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcAtf) AtfDocuments {xpath('AtfDocuments/AtfDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcWatercraft) WatercraftDocuments {xpath('WatercraftDocuments/WatercraftDocument'), MAXCOUNT(1)};
	dataset(watercraft.t_WaterCraftReport2Record) WatercraftEx {xpath('WatercraftEx/Watercraft'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcBoat) BoatDocuments {xpath('BoatDocuments/BoatDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcAssessor) AssessorDocuments {xpath('AssessorDocuments/AssessorDocument'), MAXCOUNT(1)};
	dataset(property.t_PropAssessSrc2Record) AssessorRecords {xpath('AssessorRecords/AssessorRecord'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcPilotCert) PilotCertificationDocuments {xpath('PilotCertificationDocuments/PilotCertificationDocument'), MAXCOUNT(1)};
	dataset(faapilot.t_PilotRecord) PilotDocuments {xpath('PilotDocuments/PilotDocument'), MAXCOUNT(1)};
	dataset(faaaircraft.t_AircraftReportRecord) AircraftDocuments {xpath('AircraftDocuments/AircraftDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcBusContact) ContactDocuments {xpath('ContactDocuments/ContactDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcStateDeathRecord) StateDeathRecordDocuments {xpath('StateDeathRecordDocuments/StateDeathRecordDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcEbrRecord) ExperianBusinessReports {xpath('ExperianBusinessReports/ExperianBusinessReport'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcTu) TuDocuments {xpath('TuDocuments/TuDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcTu) PL2Documents {xpath('PL2Documents/PL2Document'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcEQ) EQDocuments {xpath('EQDocuments/EQDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcEQ) PL1Documents {xpath('PL1Documents/PL1Document'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcForm5500) Irs5500Forms {xpath('Irs5500Forms/Irs5500Form'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcForm990) Irs990Forms {xpath('Irs990Forms/Irs990Form'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcOrWorkComp) OrWorkmenCompDocuments {xpath('OrWorkmenCompDocuments/OrWorkmenCompDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcBBBMember) BBBMemberDocuments {xpath('BBBMemberDocuments/BBBMemberDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcNonBBBMember) BBBNonMemberDocuments {xpath('BBBNonMemberDocuments/BBBNonMemberDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcFdic) FdicDocuments {xpath('FdicDocuments/FdicDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcSalesTax) SalesTaxDocuments {xpath('SalesTaxDocuments/SalesTaxDocument'), MAXCOUNT(1)};
	dataset(sourcedoc.t_SrcTargusDoc) PL4Documents {xpath('PL4Documents/PL4Document'), MAXCOUNT(1)};
	dataset(dirassistwireless.t_PhonesPlusRecord) PhonesPlusRecords {xpath('PhonesPlusRecords/PhonesPlusRecord'), MAXCOUNT(1)};
	dataset(emailsearch.t_EmailSearchRecord) EmailAddresses {xpath('EmailAddresses/EmailAddress'), MAXCOUNT(1)};
	dataset(proflicense.t_ProviderRecord) ProviderRecords {xpath('ProviderRecords/ProviderRecord'), MAXCOUNT(1)};
	dataset(proflicense.t_SanctionRecord) SanctionRecords {xpath('SanctionRecords/SanctionRecord'), MAXCOUNT(1)};
end;
		
export t_LocationSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean BlanksFilledIn {xpath('BlanksFilledIn')};
end;
		
export t_LocationSearchBy := record
	share.t_Address Address {xpath('Address')};
	integer Radius {xpath('Radius')};
end;
		
export t_LocationSearchRecord := record
	enhancedperson.t_EnhancedAddress EnhancedAddress {xpath('EnhancedAddress')};
	dataset(share.t_StringArrayItem) SourceDocIds {xpath('SourceDocIds/SourceDocId'), MAXCOUNT(1)};
end;
		
export t_LocationSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_LocationSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_RollupPersonSearchOptions := record (share.t_BaseSearchOption)
	boolean SSNTypos {xpath('SSNTypos')};
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	integer ScoreThreshold {xpath('ScoreThreshold')};
	boolean IncludeFullHistory {xpath('IncludeFullHistory')};
	boolean IncludeRelativeNames {xpath('IncludeRelativeNames')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean CheckNameVariants {xpath('CheckNameVariants')};
	boolean IncludeDidOnlyRecords {xpath('IncludeDidOnlyRecords')};//hidden[internal]
	boolean IncludeRecordsWithoutADL {xpath('IncludeRecordsWithoutADL')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean BlanksFilledIn {xpath('BlanksFilledIn')};
	boolean IncludeHousehold {xpath('IncludeHousehold')};
	boolean PruneAgedSSNs {xpath('PruneAgedSSNs')};//hidden[lndayton]
	boolean ReducedData {xpath('ReducedData')};
end;
		
export t_RollupPersonSearchBy := record
	share.t_Name Name {xpath('Name')};
	bpssearch.t_BpsRelatedInfo RelatedInfo {xpath('RelatedInfo')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	string Phone10 {xpath('Phone10')};
	integer Radius {xpath('Radius')};
	share.t_Date DOB {xpath('DOB')};
	share.t_IntRange AgeRange {xpath('AgeRange')};
	string UniqueId {xpath('UniqueId')};
	string LocationId {xpath('LocationId')};
end;
		
export t_DOBInfo := record
	share.t_Date DOB {xpath('DOB')};
	integer CurrentAge {xpath('CurrentAge')};
end;
		
export t_DODInfo := record
	share.t_Date DOD {xpath('DOD')};
	integer AgeAtDeath {xpath('AgeAtDeath')};
end;
		
export t_EnhancedSSNInfo := record (share.t_SSNInfo)
	string EncryptSsn {xpath('EncryptSsn')};//hidden[flagship]
	dataset(enhancedperson.t_HighRiskIndicator) HighRiskIndicators {xpath('HighRiskIndicators/HighRiskIndicator'), MAXCOUNT(1)};
end;
		
export t_EnhancedPhoneInfo := record
	string Phone10 {xpath('Phone10')};
	string Listed {xpath('Listed')};
	string TypeBusiness {xpath('TypeBusiness')};
	string TypeGoverment {xpath('TypeGoverment')};
	string ListedName {xpath('ListedName')};
	string CaptionText {xpath('CaptionText')};
	string BusinessId {xpath('BusinessId')};
	string TimeZone {xpath('TimeZone')};
	dataset(enhancedperson.t_HighRiskIndicator) HighRiskIndicators {xpath('HighRiskIndicators/HighRiskIndicator'), MAXCOUNT(1)};
end;
		
export t_AddressWithPhones := record
	enhancedperson.t_EnhancedAddress EnhancedAddress {xpath('EnhancedAddress')};
	string RecordType {xpath('RecordType')};
	string CensusAge {xpath('CensusAge')};
	string CensusIncome {xpath('CensusIncome')};
	string CensusHomeValue {xpath('CensusHomeValue')};
	string CensusEducation {xpath('CensusEducation')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	dataset(t_EnhancedPhoneInfo) Phones {xpath('Phones/EnhancedPhoneInfo'), MAXCOUNT(1)};
	string Verified {xpath('Verified')}; //values['U','Y','N','']
end;
		
export t_SourceDocInfo := record
	string SourceDocId {xpath('SourceDocId')};
	string Type {xpath('Type')};
	integer Count {xpath('Count')};
end;
		
export t_InputPhoneType := record
	string AreaCode {xpath('AreaCode')};
	string Prefix {xpath('Prefix')};
	string City {xpath('City')};
	string State {xpath('State')};
	string Provider {xpath('Provider')};
	string ServiceType {xpath('ServiceType')};
	string Dialable {xpath('Dialable')};
end;
		
export t_InputInfo := record
	t_InputPhoneType InputPhone {xpath('InputPhone')};
end;
		
export t_NameEx := record
	share.t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
end;
		
export t_RollupCounts := record (bpssearch.t_BpsRecordCounts)
	integer Foreclosures {xpath('Foreclosures')};
end;
		
export t_RollupPersonSearchRecord := record
	string UniqueId {xpath('UniqueId')};
	t_RollupCounts Counts {xpath('Counts')};
	string Penalty {xpath('Penalty')};
	string AddressScore {xpath('AddressScore')};
	integer SequenceNumber {xpath('SequenceNumber')};
	boolean HouseHoldMatch {xpath('HouseHoldMatch')};
	dataset(share.t_Name) Names {xpath('Names/'), MAXCOUNT(1)};
	dataset(t_NameEx) NamesEx {xpath('NamesEx/'), MAXCOUNT(1)};
	dataset(t_AddressWithPhones) AddressesWithPhones {xpath('AddressesWithPhones/AddressWithPhones'), MAXCOUNT(1)};
	dataset(t_EnhancedSSNInfo) SSNs {xpath('SSNs/EnhancedSSNInfo'), MAXCOUNT(1)};
	dataset(share.t_Name) RelativeNames {xpath('RelativeNames/RelativeName'), MAXCOUNT(1)};
	dataset(t_NameEx) Relatives {xpath('Relatives/Relative'), MAXCOUNT(1)};
	dataset(t_DOBInfo) DOBs {xpath('DOBs/DOBInfo'), MAXCOUNT(1)};
	dataset(t_DODInfo) DODs {xpath('DODs/DODInfo'), MAXCOUNT(1)};
	dataset(t_SourceDocInfo) SourceDocIds {xpath('SourceDocIds/SourceDocInfo'), MAXCOUNT(1)};
end;
		
export t_RollupPersonSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	t_InputInfo InputInfo {xpath('InputInfo')};
	dataset(t_RollupPersonSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
	dataset(share.t_InfoMessage) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;
		
export t_NeighborSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_NeighborSearchBy := record
	string UniqueId {xpath('UniqueId')};
	share.t_Address Address {xpath('Address')};
	integer NeighborsPerAddress {xpath('NeighborsPerAddress')};
	string LocationId {xpath('LocationId')};
end;
		
export t_NeighborSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_RollupPersonSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_AdvancedAddrSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean RandR {xpath('RandR')};
end;
		
export t_AdvancedAddrSearchBy := record
	string UniqueId {xpath('UniqueId')};
end;
		
export t_AdvancedAddrSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_RollupPersonSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_BusinessHeaderSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean BDIDOnly {xpath('BDIDOnly')};
	boolean ExactOnly {xpath('ExactOnly')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeDPPABusinessSources {xpath('IncludeDPPABusinessSources')};//hidden[lndayton]
	boolean ExcludeBlankAddresses {xpath('ExcludeBlankAddresses')};
end;
		
export t_BusinessHeaderSearchBy := record
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
	string BusinessId {xpath('BusinessId')};
	string ParentBusinessId {xpath('ParentBusinessId')};
	share.t_Name ExecutiveName {xpath('ExecutiveName')};
end;
		
export t_Exec := record
	share.t_Name Name {xpath('Name')};
	dataset(share.t_StringArrayItem) CompanyTitles {xpath('CompanyTitles/Title'), MAXCOUNT(1)};
end;
		
export t_PosFlags := record
	boolean SosFlag {xpath('SosFlag')};
	boolean UccFlag {xpath('UccFlag')};
	boolean PropFlag {xpath('PropFlag')};
	boolean MvrFlag {xpath('MvrFlag')};
end;
		
export t_BusinessSourceFlags := record
	t_PosFlags BusinessFlags {xpath('BusinessFlags')};
	t_PosFlags ParentFlags {xpath('ParentFlags')};
end;
		
export t_BusinessHeaderSearchRecord := record
	string ParentBusinessID {xpath('ParentBusinessID')};
	string BusinessID {xpath('BusinessID')};
	string ParentCompanyName {xpath('ParentCompanyName')};
	share.t_Address ParentCompanyAddress {xpath('ParentCompanyAddress')};
	t_BusinessSourceFlags SourceFlags {xpath('SourceFlags')};
	dataset(share.t_StringArrayItem) Names {xpath('Names/CompanyName'), MAXCOUNT(1)};
	dataset(t_AddressWithPhones) AddressesWithPhones {xpath('AddressesWithPhones/AddressWithPhones'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) FEINs {xpath('FEINs/FEIN'), MAXCOUNT(1)};
	dataset(t_Exec) Executives {xpath('Executives/Executive'), MAXCOUNT(1)};
end;
		
export t_BusinessHeaderSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_BusinessHeaderSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_LocationReportOptions := record (share.t_BaseSearchOption)
end;
		
export t_LocationReportBy := record
	string LocationId {xpath('LocationId')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_LocationReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	sourcedoc.t_LocationInfo LocationInfo {xpath('LocationInfo')};
	sourcedoc.t_LocAssociates Associates {xpath('Associates')};
	dataset(share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) ParcelNumbers {xpath('ParcelNumbers/ParcelNumber'), MAXCOUNT(1)};
	dataset(sourcedoc.t_PropInfo) Properties {xpath('Properties/Property'), MAXCOUNT(1)};
	dataset(sourcedoc.t_NeighborInfo) Neighbors {xpath('Neighbors/Neighbor'), MAXCOUNT(1)};
	dataset(share.t_SourceSection) Sources {xpath('Sources/Source'), MAXCOUNT(1)};
end;
		
export t_DistrixMVSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(motorvehicle.t_MVSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_PhoneHistorySearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	integer ScoreThreshold {xpath('ScoreThreshold')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean CheckNameVariants {xpath('CheckNameVariants')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean SourceDocView {xpath('SourceDocView')};
end;
		
export t_PhoneHistorySearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Phone {xpath('Phone')};
	integer Radius {xpath('Radius')};
	string UniqueId {xpath('UniqueId')};
	string HouseHoldId {xpath('HouseHoldId')};
end;
		
export t_PhoneHistorySearchRecord := record
	integer Penalty {xpath('Penalty')};
	integer NumCompares {xpath('NumCompares')};
	integer SeqNo {xpath('SeqNo')};
	string Phone {xpath('Phone')};
	string CaptionText {xpath('CaptionText')};
	string ListedName {xpath('ListedName')};
	boolean OmitAddress {xpath('OmitAddress')};
	boolean OmitLocality {xpath('OmitLocality')};
	boolean OmitPhone {xpath('OmitPhone')};
	boolean TypeBis {xpath('TypeBis')};
	boolean TypeRes {xpath('TypeRes')};
	boolean TypeGov {xpath('TypeGov')};
	string PublishCode {xpath('PublishCode')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date DeletionDate {xpath('DeletionDate')};
	boolean CurrentRecord {xpath('CurrentRecord')};
	string UniqueId {xpath('UniqueId')};
	string BDID {xpath('BDID')};
	string HouseHoldId {xpath('HouseHoldId')};
	dataset(share.t_Name) Names {xpath('Names/Name'), MAXCOUNT(1)};
	dataset(t_AddressWithPhones) Addresses {xpath('Addresses/AddressWithPhones'), MAXCOUNT(1)};
end;
		
export t_PhoneHistoryTelcordiaRecord := record
	string NPXType {xpath('NPXType')};
	string City {xpath('City')};
	string State {xpath('State')};
	string OCN {xpath('OCN')};
	string DialInd {xpath('DialInd')};
end;
		
export t_PhoneHistorySearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer SubjectTotalCount {xpath('SubjectTotalCount')};
	dataset(t_PhoneHistorySearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
	dataset(t_PhoneHistoryTelcordiaRecord) HighRiskIndicator {xpath('HighRiskIndicator/PhoneInput'), MAXCOUNT(1)};
	dataset(share.t_InfoMessage) Messages {xpath('Messages/Message'), MAXCOUNT(1)};
end;
		
export t_RelativeAssociateReportBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_RelativeAssociateReportOption := record (share.t_BaseReportOption)
	integer RelativeDepth {xpath('RelativeDepth')};
	integer MaxRelatives {xpath('MaxRelatives')};
	integer MaxRelativeAddresses {xpath('MaxRelativeAddresses')};
end;
		
export t_Associate := record
	string UniqueId {xpath('UniqueId')};
	dataset(share.t_Identity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(1)};
	dataset(bpsreport.t_AssociateAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
end;
		
export t_Relative := record
	string UniqueId {xpath('UniqueId')};
	dataset(share.t_Identity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(1)};
	dataset(bpsreport.t_AssociateAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(1)};
end;
		
export t_RelativeAssociateReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_Relative) Relatives {xpath('Relatives/Relative'), MAXCOUNT(1)};
	dataset(t_Associate) Associates {xpath('Associates/Associate'), MAXCOUNT(1)};
end;
		
export t_NeighborReportOption := record (share.t_BaseReportOption)
	integer NeighborhoodCount {xpath('NeighborhoodCount')};
	integer NeighborCount {xpath('NeighborCount')};
end;
		
export t_NeighborReportBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_NeighborReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(bpsreport.t_Neighbor) Neighbors {xpath('Neighbors/Neighborhood'), MAXCOUNT(1)};
end;
		
export t_FindAddressSearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string CompanyName {xpath('CompanyName')};
	string Phone10 {xpath('Phone10')};
	integer MinimumScore {xpath('MinimumScore')};
end;
		
export t_FindAddressSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_FindAddressRecord := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
	share.t_Address CurrentAddress {xpath('CurrentAddress')};
	integer Score {xpath('Score')};
	dataset(share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(1)};
end;
		
export t_FindAddressSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer ReturnCount {xpath('ReturnCount')};
	dataset(t_FindAddressRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_SurnameSearchRequest := record (share.t_BaseRequest)
	t_SurnameSearchOptions Options {xpath('Options')};
	t_SurnameSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BatchPersonSearchRequest := record (share.t_BaseRequest)
	t_BatchPersonSearchOptions Options {xpath('Options')};
	t_BatchPersonSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BIDReportSourceRequest := record (share.t_BaseRequest)
	t_BIDReportSourceOptions Options {xpath('Options')};
	t_BIDReportSourceBy SearchBy {xpath('SearchBy')};
end;
		
export t_SourceDocRequest := record (share.t_BaseRequest)
	t_SourceDocOptions Options {xpath('Options')};
	t_SourceDocBy SearchBy {xpath('SearchBy')};
end;
		
export t_LocationSearchRequest := record (share.t_BaseRequest)
	t_LocationSearchOptions Options {xpath('Options')};
	t_LocationSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RollupPersonSearchRequest := record (share.t_BaseRequest)
	t_RollupPersonSearchOptions Options {xpath('Options')};
	t_RollupPersonSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_NeighborSearchRequest := record (share.t_BaseRequest)
	t_NeighborSearchOptions Options {xpath('Options')};
	t_NeighborSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_AdvancedAddrSearchRequest := record (share.t_BaseRequest)
	t_AdvancedAddrSearchOptions Options {xpath('Options')};
	t_AdvancedAddrSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BusinessHeaderSearchRequest := record (share.t_BaseRequest)
	t_BusinessHeaderSearchOptions Options {xpath('Options')};
	t_BusinessHeaderSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_LocationReportRequest := record (share.t_BaseRequest)
	t_LocationReportOptions Options {xpath('Options')};
	t_LocationReportBy SearchBy {xpath('SearchBy')};
end;
		
export t_PhoneHistorySearchRequest := record (share.t_BaseRequest)
	t_PhoneHistorySearchOptions Options {xpath('Options')};
	t_PhoneHistorySearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RelativeAssociateReportRequest := record (share.t_BaseRequest)
	t_RelativeAssociateReportOption Options {xpath('Options')};
	t_RelativeAssociateReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_NeighborReportRequest := record (share.t_BaseRequest)
	t_NeighborReportOption Options {xpath('Options')};
	t_NeighborReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_FindAddressSearchRequest := record (share.t_BaseRequest)
	t_FindAddressSearchOption Options {xpath('Options')};
	t_FindAddressSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SurnameSearchResponseEx := record
	t_SurnameSearchResponse response {xpath('response')};
end;
		
export t_BatchPersonSearchResponseEx := record
	t_BatchPersonSearchResponse response {xpath('response')};
end;
		
export t_BIDReportSourceResponseEx := record
	t_BIDReportSourceResponse response {xpath('response')};
end;
		
export t_SourceDocResponseEx := record
	t_SourceDocResponse response {xpath('response')};
end;
		
export t_LocationSearchResponseEx := record
	t_LocationSearchResponse response {xpath('response')};
end;
		
export t_RollupPersonSearchResponseEx := record
	t_RollupPersonSearchResponse response {xpath('response')};
end;
		
export t_NeighborSearchResponseEx := record
	t_NeighborSearchResponse response {xpath('response')};
end;
		
export t_AdvancedAddrSearchResponseEx := record
	t_AdvancedAddrSearchResponse response {xpath('response')};
end;
		
export t_BusinessHeaderSearchResponseEx := record
	t_BusinessHeaderSearchResponse response {xpath('response')};
end;
		
export t_LocationReportResponseEx := record
	t_LocationReportResponse response {xpath('response')};
end;
		
export t_PhoneHistorySearchResponseEx := record
	t_PhoneHistorySearchResponse response {xpath('response')};
end;
		
export t_RelativeAssociateReportResponseEx := record
	t_RelativeAssociateReportResponse response {xpath('response')};
end;
		
export t_NeighborReportResponseEx := record
	t_NeighborReportResponse response {xpath('response')};
end;
		
export t_FindAddressSearchResponseEx := record
	t_FindAddressSearchResponse response {xpath('response')};
end;
		

end;

