﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from businessinstantid20.xml. ***/
/*===================================================*/

import iesp;

export businessinstantid20 := MODULE
			
export t_BIID20Company := record
	string100 CompanyName {xpath('CompanyName')};
	string100 AlternateCompanyName {xpath('AlternateCompanyName')};
	iesp.share.t_Address Address {xpath('Address')};
	string10 Phone {xpath('Phone')};
	string9 FEIN {xpath('FEIN')};
end;
		
export t_BIID20AuthRep := record
	iesp.share.t_Name Name {xpath('Name')};
	string20 FormerLastName {xpath('FormerLastName')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string3 Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string10 Phone {xpath('Phone')};
	string15 DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string100 Email {xpath('Email')};
end;
		
export t_BIID20SearchBy := record
	string30 Sequence {xpath('Sequence')};//hidden[ecldev]
	t_BIID20Company Company {xpath('Company')};
	t_BIID20AuthRep AuthorizedRep1 {xpath('AuthorizedRep1')};
	t_BIID20AuthRep AuthorizedRep2 {xpath('AuthorizedRep2')};
	t_BIID20AuthRep AuthorizedRep3 {xpath('AuthorizedRep3')};
	t_BIID20AuthRep AuthorizedRep4 {xpath('AuthorizedRep4')};
	t_BIID20AuthRep AuthorizedRep5 {xpath('AuthorizedRep5')};
end;
		
export t_BIID20DOBMatchOptions := record
	string MatchType {xpath('MatchType')}; //values['FuzzyCCYYMMDD','FuzzyCCYYMM','RadiusCCYY','ExactCCYYMMDD','ExactCCYYMM','']
	integer MatchYearRadius {xpath('MatchYearRadius')};
end;
		
export t_BIID20Gateway := record
	string40 ServiceName {xpath('ServiceName')};
	string150 URL {xpath('URL')};
end;
		
export t_BIID20Options := record (iesp.share.t_BaseOption)
	string IndustryClass {xpath('IndustryClass')};//hidden[internal]
	unsigned6 HistoryDate {xpath('HistoryDate')};//hidden[internal]
	unsigned1 LinkSearchLevel {xpath('LinkSearchLevel')};//hidden[internal]
	unsigned1 MarketingMode {xpath('MarketingMode')};//hidden[internal]
	unsigned1 BusShellVersion {xpath('BusShellVersion')};//hidden[internal]
	string AllowedSources {xpath('AllowedSources')};//hidden[internal]
	unsigned1 BIPBestAppend {xpath('BIPBestAppend')};//hidden[internal]
	unsigned1 OFACVersion {xpath('OFACVersion')};//hidden[internal]
	integer GlobalWatchlistThreshold {xpath('GlobalWatchlistThreshold')};
	dataset(iesp.share.t_StringArrayItem) WatchListsRequested {xpath('WatchListsRequested/WatchList'), MAXCOUNT(iesp.constants.Identifier2c.MaxWatchlists)};
	dataset(t_BIID20Gateway) Gateways {xpath('Gateways/Gateway'), MAXCOUNT(iesp.constants.HC_PROVIDERPOINT.Max_Gateways)};//hidden[internal]
	boolean OverRideExperianRestriction {xpath('OverRideExperianRestriction')};//hidden[internal]
	unsigned1 BIID20ProductType {xpath('BIID20ProductType')};
	boolean OutcomeTrackingOptOut {xpath('OutcomeTrackingOptOut')};//hidden[internal]
	boolean TestDataEnabled {xpath('TestDataEnabled')};//hidden[internal]
	string32 TestDataTableName {xpath('TestDataTableName')};//hidden[internal]
	string20 CompanyID {xpath('CompanyID')};//hidden[internal]
	string32 LoginID {xpath('LoginID')};//hidden[internal]
	boolean DisableCustomerNetworkOptionInCVI {xpath('DisableCustomerNetworkOptionInCVI')};//hidden[internal]
	boolean DLMask {xpath('DLMask')};//hidden[internal]
	string6 DOBMask {xpath('DOBMask')};//hidden[internal]
	dataset(t_BIID20DOBMatchOptions) DOBMatchOptions {xpath('DOBMatchOptions/DOBMatchOption'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	integer DOBRadius {xpath('DOBRadius')};
	boolean EnableEmergingID {xpath('EnableEmergingID')};//hidden[internal]
	boolean ExactAddrMatch {xpath('ExactAddrMatch')};
	boolean ExactDOBMatch {xpath('ExactDOBMatch')};
	boolean ExactDriverLicenseMatch {xpath('ExactDriverLicenseMatch')};
	boolean ExactFirstNameMatch {xpath('ExactFirstNameMatch')};
	boolean ExactFirstNameMatchAllowNicknames {xpath('ExactFirstNameMatchAllowNicknames')};
	boolean ExactLastNameMatch {xpath('ExactLastNameMatch')};
	boolean ExactPhoneMatch {xpath('ExactPhoneMatch')};
	boolean ExactSSNMatch {xpath('ExactSSNMatch')};
	boolean ExcludeWatchLists {xpath('ExcludeWatchLists')};
	boolean IIDVersionOverride {xpath('IIDVersionOverride')};//hidden[internal]
	boolean IncludeAdditionalWatchlists {xpath('IncludeAdditionalWatchlists')};
	boolean IncludeAllRiskIndicators {xpath('IncludeAllRiskIndicators')};//hidden[internal]
	boolean IncludeCLOverride {xpath('IncludeCLOverride')};
	boolean IncludeDLVerification {xpath('IncludeDLVerification')};
	boolean IncludeDOBInCVI {xpath('IncludeDOBInCVI')};
	boolean IncludeDPBC {xpath('IncludeDPBC')};
	boolean IncludeDriverLicenseInCVI {xpath('IncludeDriverLicenseInCVI')};
	boolean IncludeMIOverride {xpath('IncludeMIOverride')};
	boolean IncludeMSOverride {xpath('IncludeMSOverride')};
	boolean IncludeOFAC {xpath('IncludeOFAC')};
	boolean IncludeTargusE3220 {xpath('IncludeTargusE3220')};//hidden[internal]
	string6 InstantIDVersion {xpath('InstantIDVersion')};//hidden[internal]
	string4 LastSeenThreshold {xpath('LastSeenThreshold')};
	string8 NameInputOrder {xpath('NameInputOrder')};
	boolean OFACOnly {xpath('OFACOnly')};//hidden[internal]
	boolean PoBoxCompliance {xpath('PoBoxCompliance')};
	string6 SSNMask {xpath('SSNMask')};//hidden[internal]
	string8 TimeofApplication {xpath('TimeofApplication')};//hidden[internal]
	boolean UseDOBFilter {xpath('UseDOBFilter')};
end;
		
export t_BIID20InputEcho := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	t_BIID20Company Company {xpath('Company')};
	dataset(t_BIID20AuthRep) AuthorizedRepresentatives {xpath('AuthorizedRepresentatives/AuthorizedRepresentative'), MAXCOUNT(iesp.constants.BIID.MAXAUTHORIZEDREPS)};
end;
		
export t_BIID20VerificationIndicators := record
	string1 CompanyName {xpath('CompanyName')};
	string1 StreetAddress {xpath('StreetAddress')};
	string1 City {xpath('City')};
	string1 State {xpath('State')};
	string1 Zip {xpath('Zip')};
	string1 Phone {xpath('Phone')};
	string1 FEIN {xpath('FEIN')};
end;
		
export t_BIID20NameAddressLinkIDs := record
	string100 CompanyName {xpath('CompanyName')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
end;
		
export t_BIID20PhoneOfNameAddress := record
	string10 PhoneOfNameAddress {xpath('PhoneOfNameAddress')};
end;
		
export t_BIID20WatchList := record
	string60 Table {xpath('Table')};
	string50 Program {xpath('Program')};
	string30 RecordNumber {xpath('RecordNumber')};
	string120 CompanyName {xpath('CompanyName')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string30 Country {xpath('Country')};
	string120 EntityName {xpath('EntityName')};
	string4 Sequence {xpath('Sequence')};
end;
		
export t_BIID20BusinessToAuthorizedRepLinkIndex := record
	string1 InputRepNumber {xpath('InputRepNumber')};
	string2 Index {xpath('Index')};
	string150 Description {xpath('Description')};
end;
		
export t_BIID20ParentCompanyLinkIDs := record
	unsigned6 SeleID {xpath('SeleID')}; // Xsd type: long
	unsigned6 OrgID {xpath('OrgID')}; // Xsd type: long
	unsigned6 UltID {xpath('UltID')}; // Xsd type: long
end;
		
export t_BIID20ParentCompany := record
	t_BIID20ParentCompanyLinkIDs BusinessIds {xpath('BusinessIds')};
	string100 CompanyName {xpath('CompanyName')};
end;
		
export t_BIID20PersonRoleAuthorizedRep := record
	string60 AuthorizedRep1 {xpath('AuthorizedRep1')};
	string60 AuthorizedRep2 {xpath('AuthorizedRep2')};
	string60 AuthorizedRep3 {xpath('AuthorizedRep3')};
	string60 AuthorizedRep4 {xpath('AuthorizedRep4')};
	string60 AuthorizedRep5 {xpath('AuthorizedRep5')};
end;
		
export t_BIID20Compliance := record
	dataset(t_BIID20WatchList) GlobalWatchLists {xpath('GlobalWatchLists/GlobalWatchList'), MAXCOUNT(iesp.constants.BIID.MAXWATCHLISTS)};
	string8 SICCode {xpath('SICCode')};
	string50 SICDescription {xpath('SICDescription')};
	string6 NAICSCode {xpath('NAICSCode')};
	string50 NAICSDescription {xpath('NAICSDescription')};
	string120 SOSFilingName {xpath('SOSFilingName')};
	string5 TimeOnSOS {xpath('TimeOnSOS')};
	string60 SOSStatus {xpath('SOSStatus')};
	string50 LNStatus {xpath('LNStatus')};
	string100 BusinessDescription {xpath('BusinessDescription')};
	string5 TimeOnPublicRecord {xpath('TimeOnPublicRecord')};
	string20 County {xpath('County')};
	string4 BusinessFirstSeenYYYY {xpath('BusinessFirstSeenYYYY')};
	t_BIID20ParentCompany Parent {xpath('Parent')};
	t_BIID20PersonRoleAuthorizedRep AuthorizedRepTitles {xpath('AuthorizedRepTitles')};
end;
		
export t_BIID20SBFEVerification := record
	string3 TimeOnSBFE {xpath('TimeOnSBFE')};
	string3 LastSeenSBFE {xpath('LastSeenSBFE')};
	string3 SBFEOpenCount {xpath('SBFEOpenCount')};
end;
		
export t_BIID20VerificationSummary := record
	string20 _Type {xpath('Type')};
	string3 Index {xpath('Index')};
	string60 Description {xpath('Description')};
end;
		
export t_BIID20BusinessVerification := record
	string3 Index {xpath('Index')};
	string150 Description {xpath('Description')};
end;
		
export t_BIID20ResidentialBusiness := record
	string1 Indicator {xpath('Indicator')};
	string30 Description {xpath('Description')};
end;
		
export t_BIID20CompanyResults := record
	t_BIID20Company VerifiedInput {xpath('VerifiedInput')};
	t_BIID20VerificationIndicators VerificationIndicators {xpath('VerificationIndicators')};
	t_BIID20Company BestInformation {xpath('BestInformation')};
	dataset(t_BIID20NameAddressLinkIDs) NamesAddressesOfPhones {xpath('NamesAddressesOfPhones/NamesAddressesOfPhone'), MAXCOUNT(iesp.constants.BIID.MAXNAMESADDRESSESOFPHONE)};
	dataset(t_BIID20PhoneOfNameAddress) PhonesOfNameAddresses {xpath('PhonesOfNameAddresses/PhonesOfNameAddress'), MAXCOUNT(iesp.constants.BIID.MAXNAMESADDRESSESOFPHONE)};
	dataset(t_BIID20NameAddressLinkIDs) FEINMatchResults {xpath('FEINMatchResults/FEINMatchResult'), MAXCOUNT(iesp.constants.BIID.MAXFEINMATCHRESULTS)};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	t_BIID20BusinessVerification BusinessVerification {xpath('BusinessVerification')};
	dataset(iesp.share.t_SequencedRiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.constants.BIID.MAXRISKINDICATORSSMALL)};
	dataset(t_BIID20ResidentialBusiness) ResidentialBusinesses {xpath('ResidentialBusinesses/ResidentialBusiness'), MAXCOUNT(iesp.constants.BIID.MAXRESIDENTIALBUSINESSINDICATORS)};
	dataset(t_BIID20VerificationSummary) VerificationSummaries {xpath('VerificationSummaries/VerificationSummary'), MAXCOUNT(iesp.constants.BIID.MAXVERIFICATIONSUMMARIES)};
	dataset(t_BIID20BusinessToAuthorizedRepLinkIndex) BusinessToAuthorizedRepLinkIndexes {xpath('BusinessToAuthorizedRepLinkIndexes/BusinessToAuthorizedRepLinkIndex'), MAXCOUNT(iesp.constants.BIID.MAXBUS2EXECINDEXES)};
	dataset(t_BIID20WatchList) OFACWatchLists {xpath('OFACWatchLists/OFACWatchList'), MAXCOUNT(iesp.constants.BIID.MAXWATCHLISTS)};
	t_BIID20Compliance Compliance {xpath('Compliance')};
	t_BIID20SBFEVerification SBFEVerification {xpath('SBFEVerification')};
end;
		
export t_BIID20ConsumerInstantIDInputEcho := record
	string4 Sequence {xpath('Sequence')};
	iesp.share.t_Name Name {xpath('Name')};
	string20 FormerLastName {xpath('FormerLastName')};
	iesp.share.t_Address Address {xpath('Address')};
	string AddressType {xpath('AddressType')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string3 Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string10 Phone {xpath('Phone')};
	string10 WorkPhone {xpath('WorkPhone')};
	string15 DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string100 Email {xpath('Email')};
end;
		
export t_BIID20ConsumerInstantIDVerifiedInput := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string9 SSN {xpath('SSN')};
	string10 Phone {xpath('Phone')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string15 DriverLicenseNumber {xpath('DriverLicenseNumber')};
end;
		
export t_BIID20ConsumerInstantIDInputCorrected := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string9 SSN {xpath('SSN')};
	string10 Phone {xpath('Phone')};
	iesp.share.t_Date DOB {xpath('DOB')};
end;
		
export t_BIID20ConsumerInstantIDNewAreaCode := record
	string AreaCode {xpath('AreaCode')};
	iesp.share.t_Date EffectiveDate {xpath('EffectiveDate')};
end;
		
export t_BIID20ConsumerInstantIDIdentityReversePhone := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_BIID20ConsumerInstantIDSSNInfo := record
	string9 SSN {xpath('SSN')};
	string1 Valid {xpath('Valid')};
	iesp.share.t_Date IssuedStartDate {xpath('IssuedStartDate')};
	iesp.share.t_Date IssuedEndDate {xpath('IssuedEndDate')};
	string2 IssuedState {xpath('IssuedState')};
	string20 IssuedStateName {xpath('IssuedStateName')};
end;
		
export t_BIID20ConsumerInstantIDAlternateName := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_BIID20ConsumerInstantIDRedFlags := record
	dataset(iesp.share.t_SequencedRiskIndicator) AddressDiscrepancyCodes {xpath('AddressDiscrepancyCodes/AddressDiscrepancyCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) SuspiciousDocumentsCodes {xpath('SuspiciousDocumentsCodes/SuspiciousDocumentsCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) SuspiciousAddressCodes {xpath('SuspiciousAddressCodes/SuspiciousAddressCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) SuspiciousSSNCodes {xpath('SuspiciousSSNCodes/SuspiciousSSNCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) SuspiciousDOBCodes {xpath('SuspiciousDOBCodes/SuspiciousDOBCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) HighRiskAddressCodes {xpath('HighRiskAddressCodes/HighRiskAddressCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) SuspiciousPhoneCodes {xpath('SuspiciousPhoneCodes/SuspiciousPhoneCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) SSNMultipleLastCodes {xpath('SSNMultipleLastCodes/SSNMultipleLastCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) MissingInputCodes {xpath('MissingInputCodes/MissingInputCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) FraudAlertCodes {xpath('FraudAlertCodes/FraudAlertCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) CreditFreezeCodes {xpath('CreditFreezeCodes/CreditFreezeCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_SequencedRiskIndicator) IdentityTheftCodes {xpath('IdentityTheftCodes/IdentityTheftCode'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
end;
		
export t_BIID20ConsumerInstantIDAddressRisk := record
	boolean AddressIsPOBox {xpath('AddressIsPOBox')};
	boolean AddressIsCMRA {xpath('AddressIsCMRA')};
end;
		
export t_BIID20AuthorizedRepresentativeResults := record
	string12 UniqueId {xpath('UniqueId')};
	t_BIID20ConsumerInstantIDInputEcho InputEcho {xpath('InputEcho')};
	t_BIID20ConsumerInstantIDVerifiedInput VerifiedInput {xpath('VerifiedInput')};
	boolean SSNFoundForLexID {xpath('SSNFoundForLexID')};
	string1 DOBMatchLevel {xpath('DOBMatchLevel')};
	integer NameAddressSSNSummary {xpath('NameAddressSSNSummary')};
	integer NameAddressPhoneSummary {xpath('NameAddressPhoneSummary')};
	string1 NameAddressPhoneType {xpath('NameAddressPhoneType')};
	string1 NameAddressPhoneStatus {xpath('NameAddressPhoneStatus')};
	integer ComprehensiveVerificationIndex {xpath('ComprehensiveVerificationIndex')};
	dataset(iesp.share.t_SequencedRiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) PotentialFollowupActions {xpath('PotentialFollowupActions/PotentialFollowupAction'), MAXCOUNT(iesp.constants.FI.MaxCVIRiskIndicators)};
	t_BIID20ConsumerInstantIDInputCorrected InputCorrected {xpath('InputCorrected')};
	string AreaCodeSplitFlag {xpath('AreaCodeSplitFlag')};
	t_BIID20ConsumerInstantIDNewAreaCode NewAreaCode {xpath('NewAreaCode')};
	t_BIID20ConsumerInstantIDIdentityReversePhone ReversePhone {xpath('ReversePhone')};
	string PhoneOfNameAddress {xpath('PhoneOfNameAddress')};
	iesp.share.t_Address PhoneAddress {xpath('PhoneAddress')};
	t_BIID20ConsumerInstantIDSSNInfo SSNInfo {xpath('SSNInfo')};
	iesp.share.t_Name CurrentName {xpath('CurrentName')};
	dataset(iesp.instantid.t_ChronologyHistory) ChronologyHistories {xpath('ChronologyHistories/ChronologyHistory'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	dataset(t_BIID20ConsumerInstantIDAlternateName) AKAs {xpath('AKAs/AKA'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	dataset(iesp.instantid.t_WatchList) WatchLists {xpath('WatchLists/WatchList'), MAXCOUNT(iesp.constants.BIID.MAXWATCHLISTS)};
	t_BIID20ConsumerInstantIDAddressRisk AddressRisk {xpath('AddressRisk')};
	iesp.instantid.t_DecedentInfo DecedentInfo {xpath('DecedentInfo')};
end;
		
export t_BIID20Result := record
	unsigned1 NumberValidAuthRepsInput {xpath('NumberValidAuthRepsInput')};
	t_BIID20InputEcho InputEcho {xpath('InputEcho')};
	t_BIID20CompanyResults CompanyResults {xpath('CompanyResults')};
	dataset(t_BIID20AuthorizedRepresentativeResults) AuthorizedRepresentativeResults {xpath('AuthorizedRepresentativeResults/AuthorizedRepresentativeResult'), MAXCOUNT(iesp.constants.BIID.MAXAUTHORIZEDREPS)};
end;
		
export t_BIID20Response := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_BIID20Result Result {xpath('Result')};
end;
		
export t_BusinessInstantID20Request := record (iesp.share.t_BaseRequest)
	t_BIID20Options Options {xpath('Options')};
	t_BIID20SearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_BIID20ResponseEx := record
	t_BIID20Response response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from businessinstantid20.xml. ***/
/*===================================================*/
