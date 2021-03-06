/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from midexcompreport.xml. ***/
/*===================================================*/

import iesp;
export midexcompreport := MODULE
			
export t_MIDEXCompReportOption := record (iesp.share.t_BaseReportOption)
	string BusinessReportFetchLevel {xpath('BusinessReportFetchLevel')}; //values['S','D','E','W','P','O','U','','']
	boolean IncludeSourceDocs {xpath('IncludeSourceDocs')};//hidden[internal]
	boolean IncludeRelatives {xpath('IncludeRelatives')};//hidden[internal]
	boolean IncludeSexualOffenses {xpath('IncludeSexualOffenses')};//hidden[internal]
	boolean IncludePersonBusinessAssociates {xpath('IncludePersonBusinessAssociates')};//hidden[internal]
	boolean IncludeCorporateAffiliations {xpath('IncludeCorporateAffiliations')};//hidden[internal]
	boolean IncludeNoticeOfDefault {xpath('IncludeNoticeOfDefault')};//hidden[internal]
	boolean IncludeForeclosures {xpath('IncludeForeclosures')};//hidden[internal]
end;
		
export t_MIDEXCompReportAlertOption := record
	boolean TrackName {xpath('TrackName')};
	boolean TrackAddress {xpath('TrackAddress')};
	boolean TrackPhone {xpath('TrackPhone')};
	boolean TrackIncident {xpath('TrackIncident')};
	boolean TrackLicenseStatus {xpath('TrackLicenseStatus')};
	boolean TrackBankruptcy {xpath('TrackBankruptcy')};
	boolean TrackCriminal {xpath('TrackCriminal')};
	boolean TrackLienJudgment {xpath('TrackLienJudgment')};
	boolean TrackNMLSId {xpath('TrackNMLSId')};
	boolean TrackNMLSRepresents {xpath('TrackNMLSRepresents')};
	boolean TrackNMLSDisciplinary {xpath('TrackNMLSDisciplinary')};
	boolean TrackNMLSRegistration {xpath('TrackNMLSRegistration')};
	boolean TrackEmail {xpath('TrackEmail')};
	boolean TrackProperty {xpath('TrackProperty')};
	boolean TrackBusinessAssociate {xpath('TrackBusinessAssociate')};
	boolean TrackRelative {xpath('TrackRelative')};
	boolean TrackEmployer {xpath('TrackEmployer')};
	boolean TrackNameVariation {xpath('TrackNameVariation')};
	boolean TrackExecutive {xpath('TrackExecutive')};
	boolean TrackSecretaryOfStateFiling {xpath('TrackSecretaryOfStateFiling')};
end;
		
export t_MIDEXCompReportAlertHash := record
	iesp.midex_share.t_AlertHash Name {xpath('Name')};
	iesp.midex_share.t_AlertHash Address {xpath('Address')};
	iesp.midex_share.t_AlertHash Phone {xpath('Phone')};
	iesp.midex_share.t_AlertHash Incident {xpath('Incident')};
	iesp.midex_share.t_AlertHash LicenseStatus {xpath('LicenseStatus')};
	iesp.midex_share.t_AlertHash Bankruptcy {xpath('Bankruptcy')};
	iesp.midex_share.t_AlertHash Criminal {xpath('Criminal')};
	iesp.midex_share.t_AlertHash LienJudgment {xpath('LienJudgment')};
	iesp.midex_share.t_AlertHash NMLSId {xpath('NMLSId')};
	iesp.midex_share.t_AlertHash NMLSRepresents {xpath('NMLSRepresents')};
	iesp.midex_share.t_AlertHash NMLSDisciplinary {xpath('NMLSDisciplinary')};
	iesp.midex_share.t_AlertHash NMLSRegistration {xpath('NMLSRegistration')};
	iesp.midex_share.t_AlertHash Email {xpath('Email')};
	iesp.midex_share.t_AlertHash Property {xpath('Property')};
	iesp.midex_share.t_AlertHash BusinessAssociate {xpath('BusinessAssociate')};
	iesp.midex_share.t_AlertHash Relative {xpath('Relative')};
	iesp.midex_share.t_AlertHash Employer {xpath('Employer')};
	iesp.midex_share.t_AlertHash NameVariation {xpath('NameVariation')};
	iesp.midex_share.t_AlertHash Executive {xpath('Executive')};
	iesp.midex_share.t_AlertHash SecretaryOfStateFiling {xpath('SecretaryOfStateFiling')};
end;
		
export t_MIDEXCompReportAlertInput := record
	boolean EnableAlert {xpath('EnableAlert')};
	integer AlertVersion {xpath('AlertVersion')};
	t_MIDEXCompReportAlertOption Options {xpath('Options')};
	t_MIDEXCompReportAlertHash Hashes {xpath('Hashes')};
end;
		
export t_MIDEXCompReportBy := record
	string MIDEXReportNumber {xpath('MIDEXReportNumber')};
	string12 UniqueId {xpath('UniqueId')};
	string12 BusinessId {xpath('BusinessId')};
	string SearchType {xpath('SearchType')}; //values['I','C','B','']
	iesp.share.t_Date StartLoadDate {xpath('StartLoadDate')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
end;
		
export t_MIDEXCompComment := record
	iesp.share.t_Date Date {xpath('Date')};
	dataset(iesp.share.t_StringArrayItem) Text {xpath('Text/Line'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT)};
end;
		
export t_MIDEXDBAName := record
	string45 Name {xpath('Name')};
end;
		
export t_MIDEXCompSubject := record
	iesp.share.t_Name IndividualName {xpath('IndividualName')};
	dataset(iesp.share.t_Name) AKANames {xpath('AKANames/AKA'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA)};
	string10 Phone {xpath('Phone')};
	string12 UniqueId {xpath('UniqueId')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string JobTitle {xpath('JobTitle')};
	dataset(iesp.share.t_StringArrayItem) Professions {xpath('Professions/Profession'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS)};
	string CompanyName {xpath('CompanyName')};
	dataset(t_MIDEXDBAName) DBANames {xpath('DBANames/DBA'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA)};
	iesp.share.t_Address CompanyAddress {xpath('CompanyAddress')};
	string12 BusinessId {xpath('BusinessId')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string45 CompanyAKA {xpath('CompanyAKA')};
	string20 TIN {xpath('TIN')};
	iesp.share.t_Address PropertyAddress {xpath('PropertyAddress')};
	dataset(iesp.midex_share.t_MIDEXLicenseInfo) Licenses {xpath('Licenses/License'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES)};
	dataset(iesp.share.t_StringArrayItem) OtherIdentifyingReferences {xpath('OtherIdentifyingReferences/Line'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT)};
	iesp.midex_share.t_NMLSInfo NMLSInfo {xpath('NMLSInfo')};
end;
		
export t_MIDEXCompSource := record
	string255 SourceDocument {xpath('SourceDocument')};
	string70 DataSource {xpath('DataSource')};
	iesp.share.t_Date IncidentDate {xpath('IncidentDate')};
	iesp.share.t_Date DateOfInclusion {xpath('DateOfInclusion')};
	string Jurisdiction {xpath('Jurisdiction')};
	string CaseNumber {xpath('CaseNumber')};
	string AdditionalInfo {xpath('AdditionalInfo')};
end;
		
export t_MIDEXCompParty := record
	iesp.share.t_Name Name {xpath('Name')};
	dataset(iesp.share.t_Name) AKANames {xpath('AKANames/AKA'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA)};
	string12 UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	dataset(iesp.share.t_StringArrayItem) Professions {xpath('Professions/Profession'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS)};
	string PartyEmployer {xpath('PartyEmployer')};
	dataset(t_MIDEXDBAName) DBANames {xpath('DBANames/DBA'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA)};
	string PartyPosition {xpath('PartyPosition')};
	string PartyFirm {xpath('PartyFirm')};
	string12 BusinessId {xpath('BusinessId')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string TIN {xpath('TIN')};
	string AdditionalInfo {xpath('AdditionalInfo')};
	iesp.share.t_Address Address {xpath('Address')};
	dataset(iesp.midex_share.t_MIDEXLicenseInfo) Licenses {xpath('Licenses/License'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES)};
	dataset(iesp.share.t_StringArrayItem) OtherIdentifyingReferences {xpath('OtherIdentifyingReferences/Line'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT)};
	iesp.midex_share.t_NMLSInfo NMLSInfo {xpath('NMLSInfo')};
end;
		
export t_MIDEXCompPublicRecord := record
	string MIDEXFileNumber {xpath('MIDEXFileNumber')};
	t_MIDEXCompSubject SubjectReported {xpath('SubjectReported')};
	t_MIDEXCompSource SourceInfo {xpath('SourceInfo')};
	t_MIDEXCompComment IncidentInfo {xpath('IncidentInfo')};
	t_MIDEXCompComment RebuttalInfo {xpath('RebuttalInfo')};
	dataset(t_MIDEXCompParty) AdditionalParties {xpath('AdditionalParties/AdditionalParty'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_PARTY)};
	dataset(iesp.share.t_StringArrayItem) PublicActions {xpath('PublicActions/PublicAction'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_PUBLICACTION)};
	iesp.share.t_Date ModifiedDate {xpath('ModifiedDate')};
	iesp.share.t_Date LoadDate {xpath('LoadDate')};
	string10 Restitution {xpath('Restitution')};
	string10 FineLevied {xpath('FineLevied')};
	string10 AllegedAmount {xpath('AllegedAmount')};
	string10 EstimatedLoss {xpath('EstimatedLoss')};
end;
		
export t_MIDEXCompNonPublicRecord := record
	string MIDEXFileNumber {xpath('MIDEXFileNumber')};
	t_MIDEXCompSubject SubjectReported {xpath('SubjectReported')};
	t_MIDEXCompSource SourceInfo {xpath('SourceInfo')};
	iesp.share.t_Date ModifiedDate {xpath('ModifiedDate')};
	iesp.share.t_Date LoadDate {xpath('LoadDate')};
	string IncidentVerification {xpath('IncidentVerification')};
	dataset(t_MIDEXCompParty) Professionals {xpath('Professionals/Professional'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_PARTY)};
	t_MIDEXCompComment IncidentInfo {xpath('IncidentInfo')};
	t_MIDEXCompComment RebuttalInfo {xpath('RebuttalInfo')};
end;
		
export t_MIDEXCompNonPublicExRecord := record
	string MIDEXFileNumber {xpath('MIDEXFileNumber')};
	t_MIDEXCompSubject SubjectReported {xpath('SubjectReported')};
	t_MIDEXCompSource SourceInfo {xpath('SourceInfo')};
	string Action {xpath('Action')};
	iesp.share.t_Date ModifiedDate {xpath('ModifiedDate')};
	iesp.share.t_Date LoadDate {xpath('LoadDate')};
	iesp.share.t_Date ReportDate {xpath('ReportDate')};
	dataset(t_MIDEXCompParty) AKAs {xpath('AKAs/AKA'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_PARTY)};
	t_MIDEXCompComment IncidentInfo {xpath('IncidentInfo')};
end;
		
export t_MIDEXCompPersonSmartlinxRecord := record
	string UniqueId {xpath('UniqueId')};
	iesp.smartlinxreport.t_SLRBestInfo BestInformation {xpath('BestInformation')};
	dataset(iesp.smartlinxreport.t_SLREntities) AKAEntities {xpath('AKAEntities/Entity'), MAXCOUNT(iesp.Constants.SMART.MaxAKA)};
	dataset(iesp.bps_share.t_BpsReportImposter) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(iesp.Constants.SMART.MaxImposters)};
	dataset(iesp.smartlinxreport.t_SLREntities) ImposterEntities {xpath('ImposterEntities/Entity'), MAXCOUNT(iesp.Constants.SMART.MaxImposters)};
	dataset(iesp.smartlinxreport.t_SLRProperties) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.Constants.SMART.MaxProperties)};
	dataset(iesp.foreclosure.t_ForeclosureReportRecord) NoticesOfDefault {xpath('NoticesOfDefault/NoticeOfDefault'), MAXCOUNT(iesp.Constants.SMART.MaxNOD)};
	dataset(iesp.foreclosure.t_ForeclosureReportRecord) Foreclosures {xpath('Foreclosures/Foreclosure'), MAXCOUNT(iesp.Constants.SMART.MaxForeclosures)};
	dataset(iesp.emailsearch.t_EmailSearchRecord) EmailAddresses {xpath('EmailAddresses/EmailAddress'), MAXCOUNT(iesp.Constants.SMART.MaxEmails)};
	dataset(iesp.smartlinxreport.t_SLRBankruptcies) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.Constants.SMART.MaxBankruptcies)};
	dataset(iesp.smartlinxreport.t_SLRLiensJudgments) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.Constants.SMART.MaxLiens)};
	dataset(iesp.smartlinxreport.t_SLRAddresses) ReportAddresses {xpath('ReportAddresses/ReportAddress'), MAXCOUNT(iesp.Constants.SMART.MaxAddress)};
	dataset(iesp.smartlinxreport.t_SLRAssociate) Associates {xpath('Associates/Associate'), MAXCOUNT(iesp.Constants.SMART.MaxAssociates)};
	dataset(iesp.smartlinxreport.t_SLRRelative) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.Constants.SMART.MaxRelatives)};
	dataset(iesp.criminal.t_CrimReportRecord) Criminals {xpath('Criminals/Criminal'), MAXCOUNT(iesp.Constants.SMART.MaxCrimRecords)};
	dataset(iesp.sexualoffender.t_SexOffReportRecord) SexualOffenses {xpath('SexualOffenses/SexualOffense'), MAXCOUNT(iesp.Constants.SMART.MaxSexualOffenses)};
	dataset(iesp.bpsreport.t_BpsCorpAffiliation) CorporateAffiliations {xpath('CorporateAffiliations/Affiliation'), MAXCOUNT(iesp.Constants.SMART.MaxBusiness)};
	dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) PeopleAtWorks {xpath('PeopleAtWorks/PeopleAtWork'), MAXCOUNT(iesp.Constants.SMART.MAXPEOPLEATWORK)};
	dataset(iesp.smartlinxreport.t_SLROtherAssociatedBusinesses) OtherAssociatedBusinesses {xpath('OtherAssociatedBusinesses/OtherAssociatedBusiness'), MAXCOUNT(iesp.Constants.SMART.MaxPeopleAtWork)};
end;
		
export t_MIDEXAddressInfo := record
	iesp.share.t_Address Address {xpath('Address')};
	string LocationId {xpath('LocationId')};
	string MsaNumber {xpath('MsaNumber')};
	string MsaDescription {xpath('MsaDescription')};
	string SourceDocId {xpath('SourceDocId')};
end;
		
export t_MIDEXCompBusinessSmartLinxRecord := record, MAXLENGTH (7500000)
	iesp.rollupbizreport.t_BizReportFor BestInformation {xpath('BestInformation')};
	dataset(iesp.rollupbizreport.t_CompanyNameVariation) NameVariations {xpath('NameVariations/Variant'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_NAME_VARIATIONS)};
	dataset(t_MIDEXAddressInfo) AddressVariations {xpath('AddressVariations/Variant'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_ADDRESS_VARIATIONS)};
	dataset(iesp.bankruptcy.t_BankruptcyReport2Record) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_BANKRUPTCIES)};
	dataset(iesp.lienjudgement.t_LienJudgmentReportRecord) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_LIENS_JUDGMENTS)};
	dataset(iesp.enhancedbizreport.t_EnhancedBizReportContact) Contacts {xpath('Contacts/Contact'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_ASSOCIATED_PEOPLE)};
	dataset(iesp.property.t_PropertyReport2Record) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_PROPERTIES)};
	dataset(iesp.rollupbizreport.t_BusinessAssociate) BusinessAssociates {xpath('BusinessAssociates/Associate'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_BUSINESS_ASSOCIATES)};
	dataset(iesp.rollupbizreport.t_PhoneVariation) PhoneVariations {xpath('PhoneVariations/Variant'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_SMARTLINX_BIZ_PHONE_VARIATIONS)};
end;
		
export t_MIDEXCompTopBusinessContactSection := record
	integer2 CurrentContactCount {xpath('CurrentContactCount')};
	integer2 TotalCurrentContactCount {xpath('TotalCurrentContactCount')};
	dataset(iesp.topbusinessreport.t_TopBusinessIndividual) CurrentIndividuals {xpath('CurrentIndividuals/Individual'), MAXCOUNT(iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS)};
	integer2 CurrentExecutiveCount {xpath('CurrentExecutiveCount')};
	integer2 TotalCurrentExecutiveCount {xpath('TotalCurrentExecutiveCount')};
	dataset(iesp.topbusinessreport.t_TopBusinessIndividual) CurrentExecutives {xpath('CurrentExecutives/Individual'), MAXCOUNT(iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS)};
	dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) CurrentSourceDocs {xpath('CurrentSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	integer2 PriorContactCount {xpath('PriorContactCount')};
	integer2 TotalPriorContactCount {xpath('TotalPriorContactCount')};
	dataset(iesp.topbusinessreport.t_TopBusinessIndividual) PriorIndividuals {xpath('PriorIndividuals/Individual'), MAXCOUNT(iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	integer2 PriorExecutiveCount {xpath('PriorExecutiveCount')};
	integer2 TotalPriorExecutiveCount {xpath('TotalPriorExecutiveCount')};
	dataset(iesp.topbusinessreport.t_TopBusinessIndividual) PriorExecutives {xpath('PriorExecutives/Individual'), MAXCOUNT(iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
end;
		
export t_MIDEXCompTopBusinessRecord := record, MAXLENGTH (7500000)
	iesp.topbusinessreport.t_TopBusinessBestSection BestSection {xpath('BestSection')};
	t_MIDEXCompTopBusinessContactSection ContactSection {xpath('ContactSection')};
	iesp.topbusinessreport.t_TopBusinessIncorporationSection IncorporationSection {xpath('IncorporationSection')};
	iesp.topbusinessreport.t_TopBusinessOperationsSitesSection OperationsSitesSection {xpath('OperationsSitesSection')};
	iesp.topbusinessreport.t_TopBusinessParentSection ParentSection {xpath('ParentSection')};
	iesp.topbusinessreport.t_TopBusinessRegisteredAgentSection RegisteredAgentSection {xpath('RegisteredAgentSection')};
	iesp.topbusinessreport.t_TopBusinessAssociateSection AssociateSection {xpath('AssociateSection')};
	iesp.topbusinessreport.t_TopBusinessConnectedBusinessSection ConnectedBusinessSection {xpath('ConnectedBusinessSection')};
	iesp.topbusinessreport.t_TopBusinessBankruptcySection BankruptcySection {xpath('BankruptcySection')};
	iesp.topbusinessreport.t_TopBusinessLienSection LienSection {xpath('LienSection')};
	iesp.topbusinessreport.t_TopBusinessPropertySection PropertySection {xpath('PropertySection')};
end;
		
export t_MIDEXCompReportRecord := record
	dataset(t_MIDEXCompPublicRecord) PublicRecords {xpath('PublicRecords/Record'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_PUBRECS)};
	dataset(t_MIDEXCompNonPublicRecord) NonPublicRecords {xpath('NonPublicRecords/Record'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_NPRECS)};
	dataset(t_MIDEXCompNonPublicExRecord) NonPublicExRecords {xpath('NonPublicExRecords/Record'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_FMRECS)};
	dataset(iesp.midexlicensereport.t_MIDEXLicenseReportRecord) Licenses {xpath('Licenses/License'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_LICENSES)};
	dataset(iesp.share.t_SourceSection) SourceSummary {xpath('SourceSummary/Source'), MAXCOUNT(iesp.Constants.SMART.MAXSOURCES)};
	t_MIDEXCompBusinessSmartLinxRecord BusinessSmartLinxRecord {xpath('BusinessSmartLinxRecord')};
	t_MIDEXCompPersonSmartlinxRecord PersonSmartLinxRecord {xpath('PersonSmartLinxRecord')};
	t_MIDEXCompTopBusinessRecord TopBusinessRecord {xpath('TopBusinessRecord')};
end;
		
export t_MIDEXCompReportAlertChange := record
	boolean NameChanged {xpath('NameChanged')};
	boolean AddressChanged {xpath('AddressChanged')};
	boolean PhoneChanged {xpath('PhoneChanged')};
	boolean IncidentChanged {xpath('IncidentChanged')};
	boolean LicenseStatusChanged {xpath('LicenseStatusChanged')};
	boolean BankruptcyChanged {xpath('BankruptcyChanged')};
	boolean CriminalChanged {xpath('CriminalChanged')};
	boolean LienJudgmentChanged {xpath('LienJudgmentChanged')};
	boolean NMLSIdChanged {xpath('NMLSIdChanged')};
	boolean NMLSRepresentsChanged {xpath('NMLSRepresentsChanged')};
	boolean NMLSDisciplinaryChanged {xpath('NMLSDisciplinaryChanged')};
	boolean NMLSRegistrationChanged {xpath('NMLSRegistrationChanged')};
	boolean EmailChanged {xpath('EmailChanged')};
	boolean PropertyChanged {xpath('PropertyChanged')};
	boolean BusinessAssociateChanged {xpath('BusinessAssociateChanged')};
	boolean RelativeChanged {xpath('RelativeChanged')};
	boolean EmployerChanged {xpath('EmployerChanged')};
	boolean NameVariationChanged {xpath('NameVariationChanged')};
	boolean ExecutiveChanged {xpath('ExecutiveChanged')};
	boolean SecretaryOfStateFilingChanged {xpath('SecretaryOfStateFilingChanged')};
end;
		
export t_MIDEXComprReportAlertResult := record
	boolean RecordDeleted {xpath('RecordDeleted')};
	integer AlertVersion {xpath('AlertVersion')};
	t_MIDEXCompReportAlertHash Hashes {xpath('Hashes')};
	t_MIDEXCompReportAlertChange Changes {xpath('Changes')};
end;
		
export t_MIDEXCompReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_MIDEXCompReportRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_RECORDS)};
	t_MIDEXComprReportAlertResult AlertResult {xpath('AlertResult')};//hidden[alerting]
end;
		
export t_MIDEXCompReportRequest := record (iesp.share.t_BaseRequest)
	t_MIDEXCompReportOption Options {xpath('Options')};
	t_MIDEXCompReportAlertInput AlertInput {xpath('AlertInput')};//hidden[alerting]
	t_MIDEXCompReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_MIDEXCompReportResponseEx := record
	t_MIDEXCompReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from midexcompreport.xml. ***/
/*===================================================*/

