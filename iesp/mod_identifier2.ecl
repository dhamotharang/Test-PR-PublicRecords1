﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from mod_identifier2.xml. ***/
/*===================================================*/

import iesp;
export mod_identifier2 := MODULE

export t_UnicodeName := record
	unicode62 Full {xpath('Full')}; // Xsd type: string
	unicode20 First {xpath('First')}; // Xsd type: string
	unicode20 Middle {xpath('Middle')}; // Xsd type: string
	unicode20 Last {xpath('Last')}; // Xsd type: string
	unicode5 Suffix {xpath('Suffix')}; // Xsd type: string
	unicode3 Prefix {xpath('Prefix')}; // Xsd type: string
 end;
			
export t_RequireExactMatch := record
	boolean LastName {xpath('LastName')};
	boolean FirstName {xpath('FirstName')};
	boolean FirstNameAllowNickname {xpath('FirstNameAllowNickname')};
	boolean Address {xpath('Address')};
	boolean HomePhone {xpath('HomePhone')};
	boolean SSN {xpath('SSN')};
	boolean DOB {xpath('DOB')};
end;
		
export t_VerifyInputAddressPropertyOwnership := record
	boolean CurrentOwner {xpath('CurrentOwner')};
	boolean EverOwner {xpath('EverOwner')};
	integer EverOwnedPastYears {xpath('EverOwnedPastYears')};
end;
		
export t_VerifyInput := record
	boolean DOBMatchesSSN {xpath('DOBMatchesSSN')};
	boolean YOBMatchesSSN {xpath('YOBMatchesSSN')};
	boolean ZipMatchesState {xpath('ZipMatchesState')};
	boolean SSNMatchesLastAndDOB {xpath('SSNMatchesLastAndDOB')};
end;
		
export t_VerifyInputAddressOccupancy := record
	boolean CurrentOccupant {xpath('CurrentOccupant')};
	boolean EverOccupant {xpath('EverOccupant')};
	integer EverOccupantPastMonths {xpath('EverOccupantPastMonths')};
	iesp.share.t_Date EverOccupantStartDate {xpath('EverOccupantStartDate')};
	boolean IncludeNAPData {xpath('IncludeNAPData')};
end;
		
export t_Identifier2Option := record (iesp.share.t_BaseSearchOption)
	boolean IncludeOFAC {xpath('IncludeOFAC')};
	boolean IncludeOtherWatchLists {xpath('IncludeOtherWatchLists')};
	boolean ExcludeWatchLists {xpath('ExcludeWatchLists')};
	boolean IncludeOFACOnly {xpath('IncludeOFACOnly')};
	dataset(iesp.share.t_StringArrayItem) WatchLists {xpath('WatchLists/WatchList'), MAXCOUNT(Constants.MaxCountWatchLists)};
	boolean UseDOBFilter {xpath('UseDOBFilter')};
	integer DOBRadius {xpath('DOBRadius')};
	integer AgeThreshold {xpath('AgeThreshold')};
	integer CVIThreshold {xpath('CVIThreshold')};
	boolean PoBoxCompliance {xpath('PoBoxCompliance')};
	iesp.instantid.t_InstantIDModels IncludeModels {xpath('IncludeModels')};
	string RedFlagsReport {xpath('RedFlagsReport')};
	real4 GlobalWatchlistThreshold {xpath('GlobalWatchlistThreshold')};
	boolean DisallowTargusEID3220 {xpath('DisallowTargusEID3220')};//hidden[internal]
	t_RequireExactMatch RequireExactMatch {xpath('RequireExactMatch')};
	iesp.instantid.t_DOBMatchOptions DOBMatch {xpath('DOBMatch')};
	t_VerifyInputAddressPropertyOwnership VerifyInputAddressPropertyOwnership {xpath('VerifyInputAddressPropertyOwnership')};
	boolean VerifyOwnedAnyProperty {xpath('VerifyOwnedAnyProperty')};
	boolean DiscoverDOB {xpath('DiscoverDOB')};
	boolean ValidateDiscoveredDOBToSSN {xpath('ValidateDiscoveredDOBToSSN')};
	boolean ReturnMultipleIdentities {xpath('ReturnMultipleIdentities')};
	integer MaxIdentities {xpath('MaxIdentities')};
	boolean VerifySSNExistsOnAnyAddress {xpath('VerifySSNExistsOnAnyAddress')};
	t_VerifyInput VerifyInput {xpath('VerifyInput')};
	t_VerifyInputAddressOccupancy VerifyInputAddressOccupancy {xpath('VerifyInputAddressOccupancy')};
	boolean VerifyValidDEALicense {xpath('VerifyValidDEALicense')};
	boolean VerifyValidProfessionalLicense {xpath('VerifyValidProfessionalLicense')};
	boolean VerifyValidDriversLicense {xpath('VerifyValidDriversLicense')};
	integer NumberOfRiskCodesReturned {xpath('NumberOfRiskCodesReturned')};
	boolean IncludePropertyData {xpath('IncludePropertyData')};
	boolean IncludeMultipleIdentitiesData {xpath('IncludeMultipleIdentitiesData')};
	boolean IncludeDEALicenseData {xpath('IncludeDEALicenseData')};
	boolean IncludeProfessionalLicenseData {xpath('IncludeProfessionalLicenseData')};
	boolean IncludeDriversLicenseData {xpath('IncludeDriversLicenseData')};
	boolean IncludeSSNExistsData {xpath('IncludeSSNExistsData')};
	string4 LastSeenThreshold {xpath('LastSeenThreshold')};
	boolean IncludeAllRiskIndicators {xpath('IncludeAllRiskIndicators')};
	string CustomDataFilter {xpath('CustomDataFilter')};
	string VerifyInputAddressMatchesKnownBad {xpath('VerifyInputAddressMatchesKnownBad')};//hidden[internal]
	integer OFACVersion {xpath('OFACVersion')};//hidden[internal]
end;
		
export t_Identifier2SearchBy := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	string SSN {xpath('SSN')};
	string SSNLast4 {xpath('SSNLast4')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string IPAddress {xpath('IPAddress')};
	string HomePhone {xpath('HomePhone')};
	string WorkPhone {xpath('WorkPhone')};
	boolean UseDOBFilter {xpath('UseDOBFilter')};
	integer DOBRadius {xpath('DOBRadius')};
	iesp.instantid.t_Passport Passport {xpath('Passport')};
	string Gender {xpath('Gender')};
	string UniqueId {xpath('UniqueId')};
	unsigned GovIdThreshold {xpath('GovIdThreshold')};
	dataset(share.t_StringArrayItem) GovIdInAttributes {xpath('GovIdInAttributes/GovIdInAttribute'), MAXCOUNT(iesp.Constants.Identifier2c.MaxGovIdAttributes)};//values['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','']
end;
		
export t_PropertyOwnership := record
	boolean IsPropertyOwner {xpath('IsPropertyOwner')};
	iesp.propdeed.t_DeedReportRecord Deed {xpath('Deed')};
	iesp.propassess.t_AssessReportRecord Assessment {xpath('Assessment')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_AnyPropertyOwnership := record (t_PropertyOwnership)
	integer UniqueDeedsCount {xpath('UniqueDeedsCount')};
	integer UniquePropertiesCount {xpath('UniquePropertiesCount')};
end;
		
export t_IIDControlledSubstance := record
	boolean HasValidDEALicense {xpath('HasValidDEALicense')};
	iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record ControlledSubstanceRecord {xpath('ControlledSubstanceRecord')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_IIDDriversLicense := record
	boolean HasValidDriversLicense {xpath('HasValidDriversLicense')};
	iesp.driverlicense2.t_DLSearch2Record DriverLicenseRecord {xpath('DriverLicenseRecord')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_IIDProfessionalLicense := record
	boolean HasValidProfessionalLicense {xpath('HasValidProfessionalLicense')};
	iesp.proflicense.t_ProviderRecord ProviderRecord {xpath('ProviderRecord')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_IIDImposters := record
	boolean HasImposters {xpath('HasImposters')};
	integer UniqueADLCount {xpath('UniqueADLCount')};
	integer UniqueLastNameCount {xpath('UniqueLastNameCount')};
	iesp.bps_share.t_BpsReportImposter Imposters {xpath('Imposters')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_DiscoveredDOB := record
	boolean DOBDiscovered {xpath('DOBDiscovered')};
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_DiscoveredDOBComparedToSSN := record
	boolean DiscoveredDOBMatchedSSNIssueDate {xpath('DiscoveredDOBMatchedSSNIssueDate')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_SSNExistsOnAnAddress := record
	boolean SSNExistsOnAnAddress {xpath('SSNExistsOnAnAddress')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_InputDOBMatchesSSN := record
	boolean InputDOBMatchesSSN {xpath('InputDOBMatchesSSN')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_InputSSNMatchesLastAndDOB := record
	boolean InputSSNMatchesLastAndDOB {xpath('InputSSNMatchesLastAndDOB')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_InputYOBMatchesSSN := record
	boolean InputYOBMatchesSSN {xpath('InputYOBMatchesSSN')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_InputZipMatchesState := record
	boolean InputZipMatchesState {xpath('InputZipMatchesState')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_InputAddressCurrentOccupant := record
	boolean IsCurrentOccupant {xpath('IsCurrentOccupant')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_InputAddressEverOccupant := record
	boolean WasEverOccupant {xpath('WasEverOccupant')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) StatusIndicators {xpath('StatusIndicators/StatusIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxStatusIndicators)};
end;
		
export t_InputAddressRisk := record
	boolean AddressDoNotDeliver {xpath('AddressDoNotDeliver')};
	boolean AddressIsNotHighRisk {xpath('AddressIsNotHighRisk')};
	boolean AddressIsNotABusiness {xpath('AddressIsNotABusiness')};
end;
		
export t_GovIdAttributes := record
	string Attribute {xpath('Attribute')};
	unsigned Result {xpath('Result')};
end;
		
export t_GovIdOutResult := record
	boolean GovIdPass {xpath('GovIdPass')};
	dataset(t_GovIdAttributes) GovIdAttributes {xpath('GovIdAttributes/GovIdAttribute'), MAXCOUNT(iesp.Constants.Identifier2c.MaxGovIdAttributes)};
end;
		
export t_InstantIDResultNoEcho := record
	string UniqueId {xpath('UniqueId')};
	iesp.instantid.t_VerifiedInput VerifiedInput {xpath('VerifiedInput')};
	boolean DOBVerified {xpath('DOBVerified')};
	unsigned1 DOBMatchLevel {xpath('DOBMatchLevel')};
	integer NameAddressSSNSummary {xpath('NameAddressSSNSummary')};
	iesp.instantid.t_NameAddressPhone NameAddressPhone {xpath('NameAddressPhone')};
	integer ComprehensiveVerificationIndex {xpath('ComprehensiveVerificationIndex')};
	dataset(iesp.share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	dataset(iesp.share.t_RiskIndicator) PotentialFollowupActions {xpath('PotentialFollowupActions/FollowupAction'), MAXCOUNT(iesp.Constants.Identifier2c.MaxRiskIndicators)};
	iesp.instantid.t_InputCorrected InputCorrected {xpath('InputCorrected')};
	iesp.instantid.t_NewAreaCode NewAreaCode {xpath('NewAreaCode')};
	iesp.instantid.t_IdentityReversePhone ReversePhone {xpath('ReversePhone')};
	string PhoneOfNameAddress {xpath('PhoneOfNameAddress')};
	iesp.share.t_SSNInfo SSNInfo {xpath('SSNInfo')};
	unsigned1 SSN5FullNameMatch {xpath('SSN5FullNameMatch')};
	dataset(iesp.instantid.t_ChronologyHistory) ChronologyHistories {xpath('ChronologyHistories/ChronologyHistory'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	unsigned1 NameStreetAddressMatch {xpath('NameStreetAddressMatch')};
	unsigned1 NameCityStateMatch {xpath('NameCityStateMatch')};
	unsigned1 NameZipMatch {xpath('NameZipMatch')};
	dataset(t_UnicodeName) AKAs {xpath('AKAs/AKA'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	iesp.instantid.t_WatchList WatchList {xpath('WatchList')};
	dataset(iesp.instantid.t_WatchList) WatchLists {xpath('WatchLists/WatchList'), MAXCOUNT(iesp.constants.Identifier2c.MaxWatchlists)};
	string AdditionalScore1 {xpath('AdditionalScore1')};
	string AdditionalScore2 {xpath('AdditionalScore2')};
	iesp.share.t_Name CurrentName {xpath('CurrentName')};
	dataset(iesp.instantid.t_AdditionalLastName) AdditionalLastNames {xpath('AdditionalLastNames/AdditionalLastName'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	dataset(iesp.instantid.t_Model) Models {xpath('Models/Model'), MAXCOUNT(iesp.constants.Identifier2c.MaxOther)};
	iesp.instantid.t_RedFlagsReport RedFlagsReport {xpath('RedFlagsReport')};
	boolean PassportValidated {xpath('PassportValidated')};
	boolean InputAddressMatchesKnownBad {xpath('InputAddressMatchesKnownBad')};
end;
		
export t_Identifier2Result := record (t_InstantIDResultNoEcho)
	t_Identifier2SearchBy InputEcho {xpath('InputEcho')};
	t_PropertyOwnership EverOwnedInputProperty {xpath('EverOwnedInputProperty')};
	t_PropertyOwnership CurrentlyOwnInputProperty {xpath('CurrentlyOwnInputProperty')};
	t_AnyPropertyOwnership OwnedAnyProperty {xpath('OwnedAnyProperty')};
	t_IIDControlledSubstance DEALicense {xpath('DEALicense')};
	t_IIDDriversLicense DriversLicense {xpath('DriversLicense')};
	t_IIDProfessionalLicense ProfessionalLicense {xpath('ProfessionalLicense')};
	t_IIDImposters AdditionalIdentities {xpath('AdditionalIdentities')};
	t_DiscoveredDOB DiscoveredDOB {xpath('DiscoveredDOB')};
	t_DiscoveredDOBComparedToSSN DiscoveredDOBComparedToSSN {xpath('DiscoveredDOBComparedToSSN')};
	t_SSNExistsOnAnAddress SSNExistsOnAnAddress {xpath('SSNExistsOnAnAddress')};
	t_InputDOBMatchesSSN InputDOBMatchesSSN {xpath('InputDOBMatchesSSN')};
	t_InputYOBMatchesSSN InputYOBMatchesSSN {xpath('InputYOBMatchesSSN')};
	t_InputZipMatchesState InputZipMatchesState {xpath('InputZipMatchesState')};
	t_InputSSNMatchesLastAndDOB InputSSNMatchesLastAndDOB {xpath('InputSSNMatchesLastAndDOB')};
	t_InputAddressCurrentOccupant InputAddressCurrentOccupant {xpath('InputAddressCurrentOccupant')};
	t_InputAddressEverOccupant InputAddressEverOccupant {xpath('InputAddressEverOccupant')};
	t_InputAddressRisk InputAddressRisk {xpath('InputAddressRisk')};
	t_GovIdOutResult GovIdOutResult {xpath('GovIdOutResult')};
end;
		
export t_Identifier2Response := record
	integer RecordCount {xpath('RecordCount')};
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_Identifier2Result Result {xpath('Result')};
end;
		
export t_Identifier2Request := record (iesp.share.t_BaseRequest)
	t_Identifier2Option Options {xpath('Options')};
	t_Identifier2SearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_Identifier2ResponseEx := record
	t_Identifier2Response response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from mod_identifier2.xml. ***/
/*===================================================*/

