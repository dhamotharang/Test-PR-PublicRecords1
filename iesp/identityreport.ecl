/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identityreport.xml. ***/
/*===================================================*/

import iesp;

export identityreport := MODULE
			
export t_RINIdentityReportBy := record
	string20 HouseholdId {xpath('HouseholdId')};
	string20 CustomerPersonId {xpath('CustomerPersonId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string11 SSN {xpath('SSN')};
	string15 Phone10 {xpath('Phone10')};
	string50 EmailAddress {xpath('EmailAddress')};
	iesp.rin_share.t_RINDriverLicense DriverLicense {xpath('DriverLicense')};
	iesp.rin_share.t_RINBankInformation BankInformation {xpath('BankInformation')};
	string12 AmountMin {xpath('AmountMin')};
	string12 AmountMax {xpath('AmountMax')};
	string75 ISPName {xpath('ISPName')};
	string25 IpAddress {xpath('IpAddress')};
	string25 MACAddress {xpath('MACAddress')};
	string50 DeviceId {xpath('DeviceId')};
	string20 DeviceSerialNumber {xpath('DeviceSerialNumber')};
	string12 UniqueId {xpath('UniqueId')};
	string10 ProgramCode {xpath('ProgramCode')};
	iesp.share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	iesp.share.t_Date TransactionStartDate {xpath('TransactionStartDate')};
	iesp.share.t_Date TransactionEndDate {xpath('TransactionEndDate')};
end;
		
export t_RINIdentityReportOption := record (iesp.share.t_BaseReportOption)
	boolean AppendBest {xpath('AppendBest')};//hidden[internal]
	unsigned3 DIDScoreThreshold {xpath('DIDScoreThreshold')};//hidden[internal]
	boolean IsOnline {xpath('IsOnline')};//hidden[internal]
	boolean UseAllSearchFields {xpath('UseAllSearchFields')};//hidden[internal]
	string Platform {xpath('Platform')};//hidden[internal]
end;
		
export t_RINProfileElementKnownRisk := record
	string70 AnalyticsRecordId {xpath('AnalyticsRecordId')};
	string60 ElementType {xpath('ElementType')};
	boolean HasKnownRisk {xpath('HasKnownRisk')};
	string10 RiskLevel {xpath('RiskLevel')};
end;
		
export t_RINIdentityProfile := record
	string12 UniqueId {xpath('UniqueId')};
	string70 AnalyticsRecordId {xpath('AnalyticsRecordId')};
	iesp.share.t_Name Name {xpath('Name')};
	string11 SSN {xpath('SSN')};
	t_RINProfileElementKnownRisk SSNKnownRisk {xpath('SSNKnownRisk')};
	iesp.share.t_Date DOB {xpath('DOB')};
	iesp.share.t_Date DOD {xpath('DOD')};
	boolean IsDeceased {xpath('IsDeceased')};
	iesp.share.t_Address Address {xpath('Address')};
	t_RINProfileElementKnownRisk AddressKnownRisk {xpath('AddressKnownRisk')};
	string15 Phone {xpath('Phone')};
	t_RINProfileElementKnownRisk PhoneKnownRisk {xpath('PhoneKnownRisk')};
	string50 EmailAddress {xpath('EmailAddress')};
	t_RINProfileElementKnownRisk EmailKnownRisk {xpath('EmailKnownRisk')};
	iesp.rin_share.t_RINDriverLicense DriverLicense {xpath('DriverLicense')};
	t_RINProfileElementKnownRisk DriverLicenseKnownRisk {xpath('DriverLicenseKnownRisk')};
	iesp.rin_share.t_RINBankInformation BankInformation {xpath('BankInformation')};
	t_RINProfileElementKnownRisk BankInformationKnownRisk {xpath('BankInformationKnownRisk')};
	string25 IpAddress {xpath('IpAddress')};
	t_RINProfileElementKnownRisk IpAddressKnownRisk {xpath('IpAddressKnownRisk')};
	string50 DeviceId {xpath('DeviceId')};
	t_RINProfileElementKnownRisk DeviceIdKnownRisk {xpath('DeviceIdKnownRisk')};
	dataset(iesp.share.t_NameValuePair) NVPs {xpath('NVPs/NVP'), MAXCOUNT(iesp.Constants.RIN.MAX_COUNT_NVP)};
end;
		
export t_RINRiskAttribute := record
	string60 ElementType {xpath('ElementType')};
	string20 KnownRiskCode {xpath('KnownRiskCode')};
	string200 KnownRiskDescription {xpath('KnownRiskDescription')};
	string10 RiskLevel {xpath('RiskLevel')};
	dataset(iesp.share.t_NameValuePair) NVPs {xpath('NVPs/NVP'), MAXCOUNT(iesp.Constants.RIN.MAX_COUNT_NVP)};
end;
		
export t_RINIdentityReportRecord := record
	t_RINIdentityProfile IdentityProfile {xpath('IdentityProfile')};
	string10 RiskLevel {xpath('RiskLevel')};
	dataset(t_RINRiskAttribute) RiskAttributes {xpath('RiskAttributes/RiskAttribute'), MAXCOUNT(iesp.Constants.RIN.MAX_COUNT_INDICATOR_ATTRIBUTE)};//hidden[internal]
end;
		
export t_IdentityReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_RINIdentityReportBy InputEcho {xpath('InputEcho')};
	unsigned2 RecordCount {xpath('RecordCount')};
	dataset(t_RINIdentityReportRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_IdentityReportRequest := record (iesp.rin_share.t_RINBaseRequest)
	t_RINIdentityReportBy ReportBy {xpath('ReportBy')};
	t_RINIdentityReportOption Options {xpath('Options')};
end;
		
export t_IdentityReportResponseEx := record
	t_IdentityReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identityreport.xml. ***/
/*===================================================*/

