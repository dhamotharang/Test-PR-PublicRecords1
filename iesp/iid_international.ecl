/*2012-06-12T20:49:22Z (Curt Reese)
Phase 4 minor enhancements
*/
/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from iid_international.xml. ***/
/*===================================================*/

export iid_international := MODULE

export t_Name := record
	unicode62 Full {xpath('Full')};
	unicode20 First {xpath('First')};
	unicode20 Middle {xpath('Middle')};
	unicode20 Last {xpath('Last')};
	unicode5 Suffix {xpath('Suffix')};
	unicode3 Prefix {xpath('Prefix')};
end;

export t_IIDIUniversalAddress := record
	unicode10 StreetNumber {xpath('StreetNumber')};
	unicode15 StreetPreDirection {xpath('StreetPreDirection')};
	unicode28 StreetName {xpath('StreetName')};
	unicode15 StreetSuffix {xpath('StreetSuffix')};
	unicode15 StreetPostDirection {xpath('StreetPostDirection')};
	unicode10 UnitDesignation {xpath('UnitDesignation')};
	unicode8 UnitNumber {xpath('UnitNumber')};
	unicode60 StreetAddress1 {xpath('StreetAddress1')};
	unicode60 StreetAddress2 {xpath('StreetAddress2')};
	unicode40 City {xpath('City')};
	unicode30 State {xpath('State')};
	unicode5 Zip5 {xpath('Zip5')};
	unicode4 Zip4 {xpath('Zip4')};
	unicode18 County {xpath('County')};
	unicode9 PostalCode {xpath('PostalCode')};
	unicode50 StateCityZip {xpath('StateCityZip')};
	string30 Country {xpath('Country')};
	unicode30 Province {xpath('Province')};
	boolean IsForeign {xpath('IsForeign')};
end;

export t_CountryConfig := record
	string Name {xpath('Name')};
	string CreditFlag {xpath('CreditFlag')};
end;
		
export t_InstantIDInternationalOption := record (share.t_BaseOption)
	boolean IncludeOFAC {xpath('IncludeOFAC')};
	boolean IncludeOtherWatchLists {xpath('IncludeOtherWatchLists')};
	boolean UseDOBFilter {xpath('UseDOBFilter')};
	integer DOBRadius {xpath('DOBRadius')};
	string GlobalWatchlistThreshold {xpath('GlobalWatchlistThreshold')};
	dataset(share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(Constants.MaxCountWatchLists)};
	boolean PassportValidationOnly {xpath('PassportValidationOnly')};
	boolean VisaValidationOnly {xpath('VisaValidationOnly')};
	integer PermissibleUse {xpath('PermissibleUse')};
	boolean GetCountrySettings {xpath('GetCountrySettings')};
	string1 CreditFlag {xpath('CreditFlag')};//hidden[internal]
	string32 EndUserCompanyId {xpath('EndUserCompanyId')};//hidden[internal]
	dataset(t_CountryConfig) Countries {xpath('Countries/Country'), MAXCOUNT(Constants.MaxCountCountrySettings)};//hidden[internal]
end;
		
export t_InstantIDInternationalSearchBy := record
	share.t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
	share.t_Date DOB {xpath('DOB')};
	t_IIDIUniversalAddress Address {xpath('Address')};
	string NationalIDNumber {xpath('NationalIDNumber')};
	string NationalIDCountry {xpath('NationalIDCountry')};
	instantid.t_Passport Passport {xpath('Passport')};
	instantid.t_Passport Visa {xpath('Visa')};
	string HomePhone {xpath('HomePhone')};
	boolean IsHomePhonePublished {xpath('IsHomePhonePublished')};
	string MobilePhone {xpath('MobilePhone')};
	boolean IsMobilePhonePublished {xpath('IsMobilePhonePublished')};
	string WorkPhone {xpath('WorkPhone')};
	boolean IsWorkPhonePublished {xpath('IsWorkPhonePublished')};
	string IPAddress {xpath('IPAddress')};
end;

export t_InstantIDInternationalSearchBy_Unicode := record
	t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
	share.t_Date DOB {xpath('DOB')};
	t_IIDIUniversalAddress Address {xpath('Address')};
	string NationalIDNumber {xpath('NationalIDNumber')};
	string NationalIDCountry {xpath('NationalIDCountry')};
	instantid.t_Passport Passport {xpath('Passport')};
	instantid.t_Passport Visa {xpath('Visa')};
	string HomePhone {xpath('HomePhone')};
	boolean IsHomePhonePublished {xpath('IsHomePhonePublished')};
	string MobilePhone {xpath('MobilePhone')};
	boolean IsMobilePhonePublished {xpath('IsMobilePhonePublished')};
	string WorkPhone {xpath('WorkPhone')};
	boolean IsWorkPhonePublished {xpath('IsWorkPhonePublished')};
	string IPAddress {xpath('IPAddress')};
end;
		
export t_InstantIDInternationalInputFields := record
	string PermissibleUse {xpath('PermissibleUse')};
	string NameFull {xpath('NameFull')};
	string NameFirst {xpath('NameFirst')};
	string NameMiddle {xpath('NameMiddle')};
	string NameLast {xpath('NameLast')};
	string Gender {xpath('Gender')};
	string DOBYear {xpath('DOBYear')};
	string DOBMonth {xpath('DOBMonth')};
	string DOBDay {xpath('DOBDay')};
	string AddressStreetAddress1 {xpath('AddressStreetAddress1')};
	string AddressStreetAddress2 {xpath('AddressStreetAddress2')};
	string AddressStreetNumber {xpath('AddressStreetNumber')};
	string AddressUnitDesignation {xpath('AddressUnitDesignation')};
	string AddressUnitNumber {xpath('AddressUnitNumber')};
	string AddressStreetName {xpath('AddressStreetName')};
	string AddressStreetSuffix {xpath('AddressStreetSuffix')};
	string AddressCity {xpath('AddressCity')};
	string AddressState {xpath('AddressState')};
	string AddressPostalCode {xpath('AddressPostalCode')};
	string AddressProvince {xpath('AddressProvince')};
	string AddressCountry {xpath('AddressCountry')};
	string NationalIDNumber {xpath('NationalIDNumber')};
	string NationalIDCountry {xpath('NationalIDCountry')};
	string PassportNumber {xpath('PassportNumber')};
	string PassportExpirationDateYear {xpath('PassportExpirationDateYear')};
	string PassportExpirationDateMonth {xpath('PassportExpirationDateMonth')};
	string PassportExpirationDateDay {xpath('PassportExpirationDateDay')};
	string PassportCountry {xpath('PassportCountry')};
	string PassportMachineReadableLine1 {xpath('PassportMachineReadableLine1')};
	string PassportMachineReadableLine2 {xpath('PassportMachineReadableLine2')};
	string PhoneNumber {xpath('PhoneNumber')};
	string HomePhone {xpath('HomePhone')};
	string MobilePhone {xpath('MobilePhone')};
	string WorkPhone {xpath('WorkPhone')};
	string IPAddress {xpath('IPAddress')};
end;
		
export t_CountrySetup := record
	string CountryName {xpath('CountryName')};
	string ISO3Alpha {xpath('ISO3Alpha')};
	string ISO3Numeric {xpath('ISO3Numeric')};
	string CreditFlag {xpath('CreditFlag')};
	t_InstantIDInternationalInputFields InputFields {xpath('InputFields')};
end;
		
export t_VerificationResult := record
	string FieldName {xpath('FieldName')};
	boolean IsVerified {xpath('IsVerified')};
	integer Count {xpath('Count')};
end;
		
export t_IPAddressInfo := record
	string Continent {xpath('Continent')};
	string Country {xpath('Country')};
	string RoutingType {xpath('RoutingType')};
	string TopLevelDomain {xpath('TopLevelDomain')};
	string SecondLevelDomain {xpath('SecondLevelDomain')};
	string City {xpath('City')};
	string RegionDescription {xpath('RegionDescription')};
	string Latitude {xpath('Latitude')};
	string Longitude {xpath('Longitude')};
end;
		
export t_InternationalVerificationIndex := record
	string IVI {xpath('IVI')};
	string CitVL {xpath('CitVL')};
	string ComVL {xpath('ComVL')};
end;
		
export t_DataSourceVerification := record
	string FieldName {xpath('FieldName')};
	boolean IsVerified {xpath('IsVerified')};
	string Verification {xpath('Verification')};
end;
		
export t_DataSourceResult := record
	string DataSourceName {xpath('DataSourceName')};
	string DataSourceID {xpath('DataSourceID')};
	string DataSourceType {xpath('DataSourceType')};
	string DataSourceError {xpath('DataSourceError')};
	string DataSourceMessage {xpath('DataSourceMessage')};
	string25000 DataSourcePhoto {xpath('DataSourcePhoto')};
	dataset(t_DataSourceVerification) DataSourceVerifications {xpath('DataSourceVerifications/DataSourceVerification'), MAXCOUNT(Constants.MaxCountVerificationResults)};
end;
		
export t_InstantIDInternationalResult := record
	t_InstantIDInternationalSearchBy InputEcho {xpath('InputEcho')};
	string InternationalVerificationIndex {xpath('InternationalVerificationIndex')};
	t_InternationalVerificationIndex VerificationIndex {xpath('VerificationIndex')};
	dataset(share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(Constants.MaxCountHRI)};
	dataset(t_VerificationResult) VerificationResults {xpath('VerificationResults/VerificationResult'), MAXCOUNT(Constants.MaxCountVerificationResults)};
	instantid.t_WatchList WatchList {xpath('WatchList')};
	t_IPAddressInfo IPAddressInfo {xpath('IPAddressInfo')};
	boolean PassportNumberValidated {xpath('PassportNumberValidated')};
	boolean VisaNumberValidated {xpath('VisaNumberValidated')};
	boolean IsBillable {xpath('IsBillable')};//hidden[internal]
	string BillingCountry {xpath('BillingCountry')};
	string BillingCountryCode {xpath('BillingCountryCode')};
	dataset(t_DataSourceResult) DataSourceResults {xpath('DataSourceResults/DataSourceResult'), MAXCOUNT(Constants.MaxCountDataSourceResults)};
end;
		
export t_InstantIDInternationalResult_Unicode := record
	t_InstantIDInternationalSearchBy_Unicode InputEcho {xpath('InputEcho')};
	string InternationalVerificationIndex {xpath('InternationalVerificationIndex')};
	string ComplianceLevel {xpath('ComplianceLevel')};
	t_InternationalVerificationIndex VerificationIndex {xpath('VerificationIndex')};
	dataset(share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(Constants.MaxCountHRI)};
	dataset(t_VerificationResult) VerificationResults {xpath('VerificationResults/VerificationResult'), MAXCOUNT(Constants.MaxCountVerificationResults)};
	instantid.t_WatchList WatchList {xpath('WatchList')};
	t_IPAddressInfo IPAddressInfo {xpath('IPAddressInfo')};
	boolean PassportNumberValidated {xpath('PassportNumberValidated')};
	boolean VisaNumberValidated {xpath('VisaNumberValidated')};
	boolean IsBillable {xpath('IsBillable')};//hidden[internal]
	string BillingCountry {xpath('BillingCountry')};
	string BillingCountryCode {xpath('BillingCountryCode')};
	dataset(t_DataSourceResult) DataSourceResults {xpath('DataSourceResults/DataSourceResult'), MAXCOUNT(Constants.MaxCountDataSourceResults)};
end;
		
export t_InstantIDInternationalResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_InstantIDInternationalResult Result {xpath('Result')};
	dataset(t_CountrySetup) CountrySettings {xpath('CountrySettings/CountrySetup'), MAXCOUNT(Constants.MaxCountCountrySettings)};
end;
		
export t_InstantIDInternationalResponse_Unicode := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_InstantIDInternationalResult_Unicode Result {xpath('Result')};
	dataset(t_CountrySetup) CountrySettings {xpath('CountrySettings/CountrySetup'), MAXCOUNT(Constants.MaxCountCountrySettings)};
end;
		
export t_InstantIDInternationalRequest := record (share.t_BaseRequest)
	t_InstantIDInternationalOption Options {xpath('Options')};
	t_InstantIDInternationalSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_InstantIDInternationalRequest_Unicode := record (share.t_BaseRequest)
	t_InstantIDInternationalOption Options {xpath('Options')};
	t_InstantIDInternationalSearchBy_Unicode SearchBy {xpath('SearchBy')};
end;
		
export t_InstantIDInternationalResponseEx := record
	t_InstantIDInternationalResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from iid_international.xml. ***/
/*===================================================*/

