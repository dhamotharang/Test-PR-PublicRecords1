/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fraudgovreport.xml. ***/
/*===================================================*/

import iesp;

export fraudgovreport := MODULE
			
export t_UInt2ArrayItem := record
	unsigned2 Value {xpath('Value')};
end;
		
export t_FraudGovPhoneInfo := record
	string10 PhoneType {xpath('PhoneType')};
	string10 PhoneNumber {xpath('PhoneNumber')};
	string60 PhoneRiskCode {xpath('PhoneRiskCode')};
end;
		
export t_FraudGovReportOption := record (iesp.share.t_BaseReportOption)
	boolean AppendBest {xpath('AppendBest')};//hidden[internal]
	unsigned3 DIDScoreThreshold {xpath('DIDScoreThreshold')};//hidden[internal]
	boolean IsOnline {xpath('IsOnline')};//hidden[internal]
	boolean IsIdentityTestRequest {xpath('IsIdentityTestRequest')};//hidden[internal]
	boolean IsElementTestRequest {xpath('IsElementTestRequest')};//hidden[internal]
	boolean ReturnSlimDetails {xpath('ReturnSlimDetails')};//hidden[internal]
	integer MaxAssociatedAddresses {xpath('MaxAssociatedAddresses')};//hidden[internal]
	integer MaxScoreBreakdown {xpath('MaxScoreBreakdown')};//hidden[internal]
	integer MaxIndicatorAttributes {xpath('MaxIndicatorAttributes')};//hidden[internal]
	integer MaxRelatedClusters {xpath('MaxRelatedClusters')};//hidden[internal]
	integer MaxAssociatedIdentities {xpath('MaxAssociatedIdentities')};//hidden[internal]
	integer MaxVelocities {xpath('MaxVelocities')};//hidden[internal]
	integer MaxKnownRisks {xpath('MaxKnownRisks')};//hidden[internal]
	integer MaxTimelineDetails {xpath('MaxTimelineDetails')};//hidden[internal]
	integer MaxCriminals {xpath('MaxCriminals')};//hidden[internal]
	integer MaxRedFlags {xpath('MaxRedFlags')};//hidden[internal]
	integer MaxGlobalWatchlists {xpath('MaxGlobalWatchlists')};//hidden[internal]
	integer ReturnCount {xpath('ReturnCount')};//hidden[internal]
	integer StartingRecord {xpath('StartingRecord')};//hidden[internal]
	string Platform {xpath('Platform')};//hidden[internal]
	string AgencyVerticalType {xpath('AgencyVerticalType')};
	string18 AgencyCounty {xpath('AgencyCounty')};
	string2 AgencyState {xpath('AgencyState')};
	dataset(t_UInt2ArrayItem) ExcludedIndTypes {xpath('ExcludedIndTypes/ExcludedIndType'), MAXCOUNT(iesp.Constants.FDN.MAX_COUNT_EXCLUDE_IND_TYPES)};//hidden[internal]
	dataset(t_UInt2ArrayItem) FileTypes {xpath('FileTypes/FileType'), MAXCOUNT(iesp.Constants.FDN.MAX_COUNT_FILE_TYPES)};//hidden[internal]
	integer DeltaUse {xpath('DeltaUse')};//hidden[internal]
	integer DeltaStrict {xpath('DeltaStrict')};//hidden[internal]
end;
		
export t_FraudGovReportBy := record
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Name Name {xpath('Name')};
	string12 UniqueId {xpath('UniqueId')};
	string15 Phone10 {xpath('Phone10')};
	string11 SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	unsigned6 AppendedProviderId {xpath('AppendedProviderId')};
	unsigned6 LNPID {xpath('LNPID')};
	string10 TIN {xpath('TIN')};
	string10 NPI {xpath('NPI')};
	string50 EmailAddress {xpath('EmailAddress')};
	string25 IpAddress {xpath('IpAddress')};
	string50 DeviceId {xpath('DeviceId')};
	string12 ProfessionalId {xpath('ProfessionalId')};
	iesp.fraudgovplatform.t_FraudGovBankInformation BankInformation {xpath('BankInformation')};
	iesp.fraudgovplatform.t_FraudGovDriversLicense DriversLicense {xpath('DriversLicense')};
	iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	dataset(iesp.share.t_BusinessIdentity) BusinessLinkIds {xpath('BusinessLinkIds/BusinessLinkId'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_BUSINESS_LINKIDS)};
	iesp.share.t_Address MailingAddress {xpath('MailingAddress')};
	boolean UseAllSearchFields {xpath('UseAllSearchFields')};//hidden[internal]
	string60 ReportEntityType {xpath('ReportEntityType')};//hidden[internal]
end;
		
export t_FraudGovScoreDetails := record
	string10 RecordType {xpath('RecordType')};
	string60 ElementType {xpath('ElementType')};
	string100 ElementValue {xpath('ElementValue')};
	integer Score {xpath('Score')};
end;
		
export t_FraudGovIdentityCardDetails := record
	t_FraudGovScoreDetails ScoreDetails {xpath('ScoreDetails')};
	iesp.fraudgovplatform.t_FraudGovBestInfo ContributedBest {xpath('ContributedBest')};
	string50 EmailAddress {xpath('EmailAddress')};
	dataset(iesp.share.t_NameValuePair) IdentityNVPs {xpath('IdentityNVPs/IdentityNVP'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_NVP)};
end;
		
export t_FraudGovElementCardDetails := record
	t_FraudGovScoreDetails ScoreDetails {xpath('ScoreDetails')};
	integer NoOfIdentities {xpath('NoOfIdentities')};
	integer NoOfRecentTransactions {xpath('NoOfRecentTransactions')};
	integer NoOfClusters {xpath('NoOfClusters')};
	iesp.share.t_Date LastActivityDate {xpath('LastActivityDate')};
	dataset(iesp.share.t_NameValuePair) ElementNVPs {xpath('ElementNVPs/ElementNVP'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_NVP)};
end;
		
export t_FraudGovAssociatedAddress := record
	string20 AddressType {xpath('AddressType')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_GeoLocation RoofTopLatLong {xpath('RoofTopLatLong')};
end;
		
export t_FraudGovScoreBreakdown := record
	string20 IndicatorTypeCode {xpath('IndicatorTypeCode')};
	string200 IndicatorTypeDescription {xpath('IndicatorTypeDescription')};
	string20 RiskLevel {xpath('RiskLevel')};
	string20 PopulationType {xpath('PopulationType')};
	integer5 Value {xpath('Value')};
end;
		
export t_FraudGovIndicatorAttribute := record
	string20 IndicatorTypeCode {xpath('IndicatorTypeCode')};
	string200 IndicatorTypeDescription {xpath('IndicatorTypeDescription')};
	string10 DataType {xpath('DataType')};
	string20 RiskLevel {xpath('RiskLevel')};
	string DescriptionCode {xpath('DescriptionCode')};
	string DescriptionValue {xpath('DescriptionValue')};
	string200 Description {xpath('Description')};
	iesp.share.t_Date EventDate {xpath('EventDate')};
end;
		
export t_FraudGovClusterCardDetails := record
	string70 AnalyticsRecordId {xpath('AnalyticsRecordId')};
	t_FraudGovScoreDetails ScoreDetails {xpath('ScoreDetails')};
	integer NoOfIdentities {xpath('NoOfIdentities')};
	string100 ClusterName {xpath('ClusterName')};
	dataset(iesp.share.t_NameValuePair) ClusterNVPs {xpath('ClusterNVPs/ClusterNVP'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_NVP)};
end;
		
export t_FraudGovVelocity := record
	integer FoundCount {xpath('FoundCount')};
	string Description {xpath('Description')};
end;
		
export t_FraudGovKnownRisk := record
	integer KnownRiskCount {xpath('KnownRiskCount')};
	dataset(iesp.share.t_StringArrayItem) KnownRiskReasons {xpath('KnownRiskReasons/KnownRiskReason'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK)};
end;
		
export t_FraudGovTimelineDetails := record
	boolean IsRecentActivity {xpath('IsRecentActivity')};
	unsigned3 FileType {xpath('FileType')};
	integer GlobalCompanyId {xpath('GlobalCompanyId')};
	string20 TransactionId {xpath('TransactionId')};
	string20 HouseholdId {xpath('HouseholdId')};
	string20 CustomerPersonId {xpath('CustomerPersonId')};
	string20 CustomerEventId {xpath('CustomerEventId')};
	integer2 DeceitfulConfidenceId {xpath('DeceitfulConfidenceId')};
	iesp.share.t_TimeStamp ReportedDateTime {xpath('ReportedDateTime')};
	string30 ReportedBy {xpath('ReportedBy')};
	iesp.share.t_Date EventDate {xpath('EventDate')};
	iesp.share.t_Date EventEndDate {xpath('EventEndDate')};
	string75 EventLocation {xpath('EventLocation')};
	string75 EventType1 {xpath('EventType1')};
	string75 EventType2 {xpath('EventType2')};
	string75 EventType3 {xpath('EventType3')};
	string256 IndustryTypeDescription {xpath('IndustryTypeDescription')};
	string250 ActivityReason {xpath('ActivityReason')};
	iesp.share.t_Date StartDate {xpath('StartDate')};
	iesp.share.t_Date EndDate {xpath('EndDate')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Name Name {xpath('Name')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string20 AddressType {xpath('AddressType')};
	iesp.share.t_Address PhysicalAddress {xpath('PhysicalAddress')};
	iesp.share.t_Address MailingAddress {xpath('MailingAddress')};
	string30 County {xpath('County')};
	dataset(t_FraudGovPhoneInfo) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.FraudGov.MAX_TIMELINE_PHONES)};
	string50 EmailAddress {xpath('EmailAddress')};
	iesp.fraudgovplatform.t_FraudGovDriversLicense DriversLicense {xpath('DriversLicense')};
	iesp.fraudgovplatform.t_FraudGovBankInformation BankInformation1 {xpath('BankInformation1')};
	iesp.fraudgovplatform.t_FraudGovBankInformation BankInformation2 {xpath('BankInformation2')};
	string1 Ethnicity {xpath('Ethnicity')};
	string1 Race {xpath('Race')};
	string1 HeadOfHouseholdIndicator {xpath('HeadOfHouseholdIndicator')};
	string20 RelationshipIndicator {xpath('RelationshipIndicator')};
	string25 IpAddress {xpath('IpAddress')};
	string50 DeviceId {xpath('DeviceId')};
	string12 AmountPaid {xpath('AmountPaid')};
	string60 NameRiskCode {xpath('NameRiskCode')};
	string60 SSNRiskCode {xpath('SSNRiskCode')};
	string60 DOBRiskCode {xpath('DOBRiskCode')};
	string60 PhysicalAddressRiskCode {xpath('PhysicalAddressRiskCode')};
	string60 MailingAddressRiskCode {xpath('MailingAddressRiskCode')};
	string60 EmailAddressRiskCode {xpath('EmailAddressRiskCode')};
	string60 DriversLicenseRiskCode {xpath('DriversLicenseRiskCode')};
	string60 BankAccount1RiskCode {xpath('BankAccount1RiskCode')};
	string60 BankAccount2RiskCode {xpath('BankAccount2RiskCode')};
	string30 IPAddressFraudCode {xpath('IPAddressFraudCode')};
	string30 DeviceRiskCode {xpath('DeviceRiskCode')};
	iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
end;
		
export t_FraudGovDeceased := record
	string9 SSN {xpath('SSN')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Date DOD {xpath('DOD')};
	string1 VorPCode {xpath('VorPCode')};
	string30 MatchCode {xpath('MatchCode')};
	string3 Source {xpath('Source')};
end;
		
export t_FraudGovOffense := record
	string31 Offense {xpath('Offense')};
	string75 OffenseDescription {xpath('OffenseDescription')};
	string20 OffenseCode {xpath('OffenseCode')};
	string1 OffenseType {xpath('OffenseType')};
	string2 OffenseLevel {xpath('OffenseLevel')};
	iesp.share.t_Date OffenseDate {xpath('OffenseDate')};
end;
		
export t_FraudGovCase := record
	dataset(t_FraudGovOffense) Offenses {xpath('Offenses/Offense'), MAXCOUNT(iesp.constants.FraudGov.MAX_COUNT_OFFENSES)};
	string35 CaseNumber {xpath('CaseNumber')};
	string3 NumberOfCounts {xpath('NumberOfCounts')};
	string30 County {xpath('County')};
	iesp.share.t_Date SentenceDate {xpath('SentenceDate')};
end;
		
export t_FraudGovCriminal := record
	string1 MatchType {xpath('MatchType')};
	string2 StateOrigin {xpath('StateOrigin')};
	string12 UniqueId {xpath('UniqueId')};
	string60 OffenderKey {xpath('OffenderKey')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Name Name {xpath('Name')};
	string10 DocNumber {xpath('DocNumber')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Address Address {xpath('Address')};
	string1 CurrentIncarceratedFlag {xpath('CurrentIncarceratedFlag')};
	string45 DataSource {xpath('DataSource')};
	dataset(t_FraudGovCase) Cases {xpath('Cases/Case'), MAXCOUNT(iesp.constants.FraudGov.MAX_COUNT_CRIMINAL_CASES)};
end;
		
export t_FraudGovGlobalWatchlist := record
	string3 HitNum {xpath('HitNum')};
	string5 Score {xpath('Score')};
	string20 PartyKey {xpath('PartyKey')};
	string60 Source {xpath('Source')};
	string350 OriginalPartyName {xpath('OriginalPartyName')};
	string100 BlockedCountry {xpath('BlockedCountry')};
	dataset(iesp.share.t_StringArrayItem) Addresses {xpath('Addresses/Address50'), MAXCOUNT(iesp.constants.fraudgov.MAX_COUNT_ADDRESS)};
	dataset(iesp.share.t_StringArrayItem) Remarks {xpath('Remarks/Remark75'), MAXCOUNT(iesp.constants.FraudGov.MAX_COUNT_REMARKS)};
end;
		
export t_FraudGovIndDescPlusSequence := record
	unsigned1 seq {xpath('Sequence')};
	string5 hri {xpath('HRI')};
	string150 desc {xpath('Description')};
end;
		
export t_FraudGovRedFlag := record
	dataset(t_FraudGovIndDescPlusSequence) AddressDiscrepancyCodes {xpath('AddressDiscrepancyCodes/AddressDiscrepancyCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) SuspiciousDocumentsCodes {xpath('SuspiciousDocumentsCodes/SuspiciousDocumentsCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) SuspiciousAddressCodes {xpath('SuspiciousAddressCodes/SuspiciousAddressCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) SuspiciousSSNCodes {xpath('SuspiciousSSNCodes/SuspiciousSSNCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) SuspiciousDOBCodes {xpath('SuspiciousDOBCodes/SuspiciousDOBCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) HighRiskAddressCodes {xpath('HighRiskAddressCodes/HighRiskAddressCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) SuspiciousPhoneCodes {xpath('SuspiciousPhoneCodes/SuspiciousPhoneCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) SSNMultipleLastCodes {xpath('SSNMultipleLastCodes/SSNMultipleLastCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) MissingInputCodes {xpath('MissingInputCodes/MissingInputCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) FraudAlertCodes {xpath('FraudAlertCodes/FraudAlertCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) CreditFreezeCodes {xpath('CreditFreezeCodes/CreditFreezeCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
	dataset(t_FraudGovIndDescPlusSequence) IdentityTheftCodes {xpath('IdentityTheftCodes/IdentityTheftCode'), MAXCOUNT(iesp.Constants.fraudgov.MAX_ALERT)};
end;
		
export t_FraudGovRecord := record
	unsigned2 RiskScore {xpath('RiskScore')};
	string6 RiskLevel {xpath('RiskLevel')};
	string1 IdentityResolved {xpath('IdentityResolved')};
	unsigned6 LexID {xpath('LexID')};
	t_FraudGovIdentityCardDetails IdentityCardDetails {xpath('IdentityCardDetails')};//hidden[internal]
	iesp.fraudgovplatform.t_FraudGovBestInfo GovernmentBest {xpath('GovernmentBest')};//hidden[internal]
	t_FraudGovElementCardDetails ElementCardDetails {xpath('ElementCardDetails')};//hidden[internal]
	dataset(t_FraudGovAssociatedAddress) AssociatedAddresses {xpath('AssociatedAddresses/AssociatedAddress'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_ASSOCIATED_ADDRESS)};//hidden[internal]
	dataset(t_FraudGovScoreBreakdown) ScoreBreakdown {xpath('ScoreBreakdown/Record'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_SCORE_BREAKDOWN)};//hidden[internal]
	dataset(t_FraudGovIndicatorAttribute) IndicatorAttributes {xpath('IndicatorAttributes/IndicatorAttribute'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_INDICATOR_ATTRIBUTE)};//hidden[internal]
	dataset(t_FraudGovClusterCardDetails) RelatedClusters {xpath('RelatedClusters/RelatedCluster'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_CLUSTER)};//hidden[internal]
	dataset(t_FraudGovIdentityCardDetails) AssociatedIdentities {xpath('AssociatedIdentities/AssociatedIdentity'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_ASSOCIATED_IDENTITY)};//hidden[internal]
	dataset(t_FraudGovVelocity) Velocities {xpath('Velocities/Velocity'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_VELOCITY)};
	dataset(t_FraudGovKnownRisk) KnownRisks {xpath('KnownRisks/KnownRisk'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK)};
	dataset(t_FraudGovTimelineDetails) TimelineDetails {xpath('TimelineDetails/TimelineDetails'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_TIMELINE_DETAILS)};//hidden[internal]
	t_FraudGovDeceased Deceased {xpath('Deceased')};//hidden[internal]
	dataset(t_FraudGovCriminal) Criminals {xpath('Criminals/Criminal'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_CRIMINAL)};//hidden[internal]
	dataset(t_FraudGovRedFlag) RedFlags {xpath('RedFlags/RedFlag'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_RED_FLAG)};//hidden[internal]
	dataset(t_FraudGovGlobalWatchlist) GlobalWatchlists {xpath('GlobalWatchlists/GlobalWatchlist'), MAXCOUNT(iesp.Constants.FraudGov.MAX_COUNT_GLOBAL_WATCHLIST)};//hidden[internal]
end;
		
export t_FraudGovReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_FraudGovRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_FraudGovReportRequest := record (iesp.fraudgovplatform.t_FraudGovBaseRequest)
	t_FraudGovReportBy ReportBy {xpath('ReportBy')};
	t_FraudGovReportOption Options {xpath('Options')};
end;
		
export t_FraudGovReportResponseEx := record
	t_FraudGovReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fraudgovreport.xml. ***/
/*===================================================*/

