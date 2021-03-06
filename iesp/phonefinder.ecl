/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from phonefinder.xml. ***/
/*===================================================*/

import iesp;

export phonefinder := MODULE
			
export t_PhoneFinderSearchBy := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	string PhoneNumber {xpath('PhoneNumber')};
end;
		
export t_PhoneFinderVerificationSearchOption := record
	boolean VerifyPhoneName {xpath('VerifyPhoneName')};
	boolean VerifyPhoneNameAddress {xpath('VerifyPhoneNameAddress')};
	boolean VerifyPhoneIsActive {xpath('VerifyPhoneIsActive')};
	boolean UseDateFirstSeenVerify {xpath('UseDateFirstSeenVerify')};
	boolean UseDateLastSeenVerify {xpath('UseDateLastSeenVerify')};
	boolean UseLengthOfTimeVerify {xpath('UseLengthOfTimeVerify')};
	integer DateFirstSeenThreshold {xpath('DateFirstSeenThreshold')};
	integer DateLastSeenThreshold {xpath('DateLastSeenThreshold')};
	integer LengthOfTimeThreshold {xpath('LengthOfTimeThreshold')};
	boolean VerifyPhoneLastNameAddress {xpath('VerifyPhoneLastNameAddress')};
	boolean VerifyPhoneAddress {xpath('VerifyPhoneAddress')};
end;
		
export t_ZumigoOption := record
	boolean NameAddressValidation {xpath('NameAddressValidation')};
	boolean NameAddressInfo {xpath('NameAddressInfo')};
	boolean AccountInfo {xpath('AccountInfo')};
	boolean CarrierInfo {xpath('CarrierInfo')};
	boolean CallHandlingInfo {xpath('CallHandlingInfo')};
	boolean DeviceInfo {xpath('DeviceInfo')};
	boolean DeviceChangeInfo {xpath('DeviceChangeInfo')};
	boolean DeviceHistory {xpath('DeviceHistory')};
end;
		
export t_PhoneFinderRiskIndicator := record
	string Category {xpath('Category')};
	string Level {xpath('Level')}; //values['','L','M','H','']
	integer LevelCount {xpath('LevelCount')};
	integer RiskId {xpath('RiskId')};
	string100 RiskDescription {xpath('RiskDescription')};
	integer Threshold {xpath('Threshold')};
	integer ThresholdA {xpath('ThresholdA')};
	boolean OTP {xpath('OTP')};
	boolean Active {xpath('Active')};
end;
		
export t_PhoneFinderSearchOption := record (iesp.share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	string _Type {xpath('Type')}; //values['Basic','Premium','Ultimate','PhoneRiskAssessment','']
	t_PhoneFinderVerificationSearchOption VerificationOptions {xpath('VerificationOptions')};//hidden[internal]
	boolean IncludePhoneMetadata {xpath('IncludePhoneMetadata')};
	boolean SubjectMetadataOnly {xpath('SubjectMetadataOnly')};
	boolean UseDeltabase {xpath('UseDeltabase')};
	boolean IncludeRiskIndicators {xpath('IncludeRiskIndicators')};
	dataset(t_PhoneFinderRiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxPRIRules)};//hidden[internal]
	boolean IncludeOtherPhoneRiskIndicators {xpath('IncludeOtherPhoneRiskIndicators')};
	string LineIdentityUseCase {xpath('LineIdentityUseCase')};//hidden[internal]
	integer LineIdentityConsentLevel {xpath('LineIdentityConsentLevel')};//hidden[internal]
	integer MaxOtherPhones {xpath('MaxOtherPhones')};
	integer MaxIdentities {xpath('MaxIdentities')};
	boolean UseInHousePhoneMetadata {xpath('UseInHousePhoneMetadata')};//hidden[internal]
	boolean IncludeAccudataOCN {xpath('IncludeAccudataOCN')};//hidden[internal]
	boolean IncludeEquifax {xpath('IncludeEquifax')};//hidden[internal]
	boolean IncludeInhousePhones {xpath('IncludeInhousePhones')};//hidden[internal]
	boolean IncludeOTP {xpath('IncludeOTP')};//hidden[internal]
	boolean IncludePorting {xpath('IncludePorting')};//hidden[internal]
	boolean IncludeSpoofing {xpath('IncludeSpoofing')};//hidden[internal]
	boolean IncludeTargus {xpath('IncludeTargus')};//hidden[internal]
	boolean IncludeTransUnionIQ411 {xpath('IncludeTransUnionIQ411')};//hidden[internal]
	boolean IncludeTransUnionPVS {xpath('IncludeTransUnionPVS')};//hidden[internal]
	t_ZumigoOption IncludeZumigoOptions {xpath('IncludeZumigoOptions')};//hidden[internal]
	boolean AllowFuzzyNameAddrMatch {xpath('AllowFuzzyNameAddrMatch')};//hidden[internal]
	boolean IsRDPRequest {xpath('IsRDPRequest')};//hidden[internal]
	string PrimarySearchCriteria {xpath('PrimarySearchCriteria')}; //values['Phone','PII','']
end;
		
export t_SpoofCommon := record
	boolean Spoofed {xpath('Spoofed')};
	integer SpoofedCount {xpath('SpoofedCount')};
	iesp.share.t_Date FirstSpoofedDate {xpath('FirstSpoofedDate')};
	iesp.share.t_Date LastSpoofedDate {xpath('LastSpoofedDate')};
end;
		
export t_SpoofHistory := record
	string1 PhoneOrigin {xpath('PhoneOrigin')};
	iesp.share.t_Date EventDate {xpath('EventDate')};
end;
		
export t_Spoofing := record
	t_SpoofCommon Spoof {xpath('Spoof')};
	t_SpoofCommon Destination {xpath('Destination')};
	t_SpoofCommon Source {xpath('Source')};
	integer TotalSpoofedCount {xpath('TotalSpoofedCount')};
	iesp.share.t_Date FirstEventSpoofedDate {xpath('FirstEventSpoofedDate')};
	iesp.share.t_Date LastEventSpoofedDate {xpath('LastEventSpoofedDate')};
	dataset(t_SpoofHistory) SpoofingHistory {xpath('SpoofingHistory/SpoofHistory'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxSpoofs)};
end;
		
export t_OTPHistory := record
	boolean OTPStatus {xpath('OTPStatus')};
	iesp.share.t_Date EventDate {xpath('EventDate')};
end;
		
export t_OneTimePassword := record
	boolean OTP {xpath('OTP')};
	integer OTPCount {xpath('OTPCount')};
	iesp.share.t_Date FirstOTPDate {xpath('FirstOTPDate')};
	iesp.share.t_Date LastOTPDate {xpath('LastOTPDate')};
	boolean LastOTPStatus {xpath('LastOTPStatus')};
	dataset(t_OTPHistory) OTPHistory {xpath('OTPHistory/History'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxOTPs)};
end;
		
export t_PhoneFinderAlertIndicator := record
	integer RiskId {xpath('RiskId')};
	string Level {xpath('Level')}; //values['','L','M','H','']
	string Flag {xpath('Flag')};
	string256 Messages {xpath('Messages')};
end;
		
export t_PhoneFinderAlert := record
	string Flag {xpath('Flag')};
	dataset(iesp.share.t_StringArrayItem) Messages {xpath('Messages/Message'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxAlertMessages)};
	dataset(t_PhoneFinderAlertIndicator) AlertIndicators {xpath('AlertIndicators/AlertIndicator'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxPRIRules)};//hidden[ecl_only]
end;
		
export t_ZumigoDeviceInfo := record
	iesp.share.t_Date IMSISeenSince {xpath('IMSISeenSince')};
	iesp.share.t_Date IMSIChangeDate {xpath('IMSIChangeDate')};
	iesp.share.t_Date IMSIActivationDate {xpath('IMSIActivationDate')};
	boolean IMSIChangedThisTime {xpath('IMSIChangedThisTime')};
	boolean ICCIDChangedThisTime {xpath('ICCIDChangedThisTime')};
	iesp.share.t_Date ICCIDSeenSince {xpath('ICCIDSeenSince')};
	iesp.share.t_Date IMEISeenSince {xpath('IMEISeenSince')};
	iesp.share.t_Date IMEIChangeDate {xpath('IMEIChangeDate')};
	boolean IMEIChangedThisTime {xpath('IMEIChangedThisTime')};
	boolean LostStolen {xpath('LostStolen')};
	iesp.share.t_Date LostStolenDate {xpath('LostStolenDate')};
end;
		
export t_InquiryInfo := record
	integer InquiryRecordsReturned {xpath('InquiryRecordsReturned')};
	dataset(iesp.share.t_Date) InquiryDates {xpath('InquiryDates/InquiryDate'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxInquiries)};
end;
		
export t_BasePhoneInfo := record
	string Number {xpath('Number')};
	string _Type {xpath('Type')};
	string Carrier {xpath('Carrier')};
	string CarrierCity {xpath('CarrierCity')};
	string CarrierState {xpath('CarrierState')};
	string ListingName {xpath('ListingName')};
	string PhoneStatus {xpath('PhoneStatus')};
	string2 PhoneAddressState {xpath('PhoneAddressState')};
end;
		
export t_PhoneFinderInfo := record (t_BasePhoneInfo)
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string MonthsWithPhone {xpath('MonthsWithPhone')};
	string MonthsSinceLastSeen {xpath('MonthsSinceLastSeen')};
	string PortingCode {xpath('PortingCode')};
	iesp.share.t_Date LastPortedDate {xpath('LastPortedDate')};
	string PhoneRiskIndicator {xpath('PhoneRiskIndicator')};
	boolean OTPRIFailed {xpath('OTPRIFailed')};
	dataset(t_PhoneFinderAlert) Alerts {xpath('Alerts/Alert'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxAlerts)};
	string CallForwardingIndicator {xpath('CallForwardingIndicator')};
	boolean PhoneOwnershipIndicator {xpath('PhoneOwnershipIndicator')};
	t_InquiryInfo InquiryDetails {xpath('InquiryDetails')};//hidden[internal]
	t_ZumigoDeviceInfo ZumigoDeviceDetails {xpath('ZumigoDeviceDetails')};//hidden[internal]
end;
		
export t_PhoneIdentityInfo := record
	string UniqueId {xpath('UniqueId')};
	string Deceased {xpath('Deceased')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address RecentAddress {xpath('RecentAddress')};
	iesp.share.t_Date FirstSeenWithPrimaryPhone {xpath('FirstSeenWithPrimaryPhone')};
	iesp.share.t_Date LastSeenWithPrimaryPhone {xpath('LastSeenWithPrimaryPhone')};
	string TimeWithPrimaryPhone {xpath('TimeWithPrimaryPhone')};
	string TimeSinceLastSeenWithPrimaryPhone {xpath('TimeSinceLastSeenWithPrimaryPhone')};
	string PrimaryAddressType {xpath('PrimaryAddressType')};
	string1 RecordType {xpath('RecordType')};
	boolean PhoneOwnershipIndicator {xpath('PhoneOwnershipIndicator')};
end;
		
export t_PhoneFinderHistory := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date FirstSeen {xpath('FirstSeen')};
	iesp.share.t_Date LastSeen {xpath('LastSeen')};
end;
		
export t_PhoneFinderOperatingCompany := record
	string CompanyNumber {xpath('CompanyNumber')};
	string Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string AffiliatedTo {xpath('AffiliatedTo')};
	iesp.share.t_Name ContactName {xpath('ContactName')};
	iesp.share.t_Address ContactAddress {xpath('ContactAddress')};
	string Email {xpath('Email')};
	string ContactPhone {xpath('ContactPhone')};
	string ContactPhoneExt {xpath('ContactPhoneExt')};
	string Fax {xpath('Fax')};
end;
		
export t_PhoneFinderVerificationStatus := record
	string100 PhoneVerificationDescription {xpath('PhoneVerificationDescription')};
	boolean PhoneVerified {xpath('PhoneVerified')};
end;
		
export t_PortingHistory := record
	string ServiceProvider {xpath('ServiceProvider')};
	iesp.share.t_Date PortStartDate {xpath('PortStartDate')};
	iesp.share.t_Date PortEndDate {xpath('PortEndDate')};
end;
		
export t_PhoneFinderDetailedInfo := record (t_BasePhoneInfo)
	string ListingType {xpath('ListingType')};
	string PrivacyIndicator {xpath('PrivacyIndicator')};
	string MSA {xpath('MSA')};
	string CMSA {xpath('CMSA')};
	string FIPS {xpath('FIPS')};
	string CarrierRoute {xpath('CarrierRoute')};
	string CarrierRouteZoneCode {xpath('CarrierRouteZoneCode')};
	string CongressionalDistrict {xpath('CongressionalDistrict')};
	string DeliveryPointCode {xpath('DeliveryPointCode')};
	iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	string AddressType {xpath('AddressType')};
	string PortingCode {xpath('PortingCode')};
	string CallerId {xpath('CallerId')};
	unsigned1 PortingCount {xpath('PortingCount')};
	iesp.share.t_Date FirstPortedDate {xpath('FirstPortedDate')};
	iesp.share.t_Date LastPortedDate {xpath('LastPortedDate')};
	iesp.share.t_Date ActivationDate {xpath('ActivationDate')};
	iesp.share.t_Date DisconnectDate {xpath('DisconnectDate')};
	t_PhoneFinderOperatingCompany OperatingCompany {xpath('OperatingCompany')};
	t_PhoneFinderVerificationStatus VerificationStatus {xpath('VerificationStatus')};//hidden[internal]
	string PortingStatus {xpath('PortingStatus')};
	dataset(t_PortingHistory) PortingHistory {xpath('PortingHistory/PortHistory'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxPorts)};
	t_Spoofing SpoofingData {xpath('SpoofingData')};
	boolean NoContractCarrier {xpath('NoContractCarrier')};
	boolean Prepaid {xpath('Prepaid')};
	t_OneTimePassword OneTimePassword {xpath('OneTimePassword')};
	string PhoneRiskIndicator {xpath('PhoneRiskIndicator')};
	dataset(t_PhoneFinderAlert) Alerts {xpath('Alerts/Alert'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxAlerts)};
	boolean OTPRIFailed {xpath('OTPRIFailed')};
	string CallForwardingIndicator {xpath('CallForwardingIndicator')};
	t_InquiryInfo InquiryDetails {xpath('InquiryDetails')};//hidden[internal]
	t_ZumigoDeviceInfo ZumigoDeviceDetails {xpath('ZumigoDeviceDetails')};//hidden[internal]
end;
		
export t_PhoneFinderSearchRecord := record
	dataset(t_PhoneIdentityInfo) Identities {xpath('Identities/Identity'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxIdentities)};
	dataset(t_PhoneFinderInfo) OtherPhones {xpath('OtherPhones/Phone'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxOtherPhones)};
	dataset(t_PhoneFinderHistory) PhonesHistory {xpath('PhonesHistory/Phone'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxPhoneHistory)};
	t_PhoneFinderDetailedInfo PrimaryPhoneDetails {xpath('PrimaryPhoneDetails')};
end;
		
export t_PhoneFinderSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_PhoneFinderSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.Phone_Finder.MaxPhoneFinderRecords)};
	t_PhoneFinderSearchBy InputEcho {xpath('InputEcho')};
end;
		
export t_PhoneFinderSearchRequest := record (iesp.share.t_BaseRequest)
	t_PhoneFinderSearchBy SearchBy {xpath('SearchBy')};
	t_PhoneFinderSearchOption Options {xpath('Options')};
end;
		
export t_PhoneFinderSearchResponseEx := record
	t_PhoneFinderSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from phonefinder.xml. ***/
/*===================================================*/

