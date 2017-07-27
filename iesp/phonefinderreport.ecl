/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from phonefinder.xml. ***/
/*===================================================*/

export phonefinderreport := MODULE
			
export t_PhoneFinderSearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string UniqueId {xpath('UniqueId')};
	string SSN {xpath('SSN')};
	string PhoneNumber {xpath('PhoneNumber')};
end;
		
export t_PhoneFinderSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	string _Type {xpath('Type')}; //values['Basic','Premium','Ultimate','']
end;
		
export t_PhoneFinderInfo := record
	string Number {xpath('Number')};
	string _Type {xpath('Type')};
	string Carrier {xpath('Carrier')};
	string CarrierCity {xpath('CarrierCity')};
	string CarrierState {xpath('CarrierState')};
	string CarrierStatus {xpath('CarrierStatus')};
	string ListingName {xpath('ListingName')};
end;
		
export t_PhoneIdentityInfo := record
	string UniqueId {xpath('UniqueId')};
	string Deceased {xpath('Deceased')};
	share.t_Name Name {xpath('Name')};
	// share.t_Date DOB {xpath('DOB')};
	// integer Age {xpath('Age')};
	// string Gender {xpath('Gender')};
	share.t_Address RecentAddress {xpath('RecentAddress')};
	share.t_Date FirstSeenWithPrimaryPhone {xpath('FirstSeenWithPrimaryPhone')};
	share.t_Date LastSeenWithPrimaryPhone {xpath('LastSeenWithPrimaryPhone')};
	string TimeWithPrimaryPhone {xpath('TimeWithPrimaryPhone')};
	string TimeSinceLastSeenWithPrimaryPhone {xpath('TimeSinceLastSeenWithPrimaryPhone')};
end;
		
export t_PhoneFinderHistory := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date FirstSeen {xpath('FirstSeen')};
	share.t_Date LastSeen {xpath('LastSeen')};
end;
		
export t_PhoneFinderOperatingCompany := record
	string CompanyNumber {xpath('CompanyNumber')};
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string AffiliatedTo {xpath('AffiliatedTo')};
	share.t_Name ContactName {xpath('ContactName')};
	share.t_Address ContactAddress {xpath('ContactAddress')};
	string Email {xpath('Email')};
	string ContactPhone {xpath('ContactPhone')};
	string ContactPhoneExt {xpath('ContactPhoneExt')};
	string Fax {xpath('Fax')};
end;
		
export t_PhoneFinderDetailedInfo := record
	t_PhoneFinderInfo;
	string ListingType {xpath('ListingType')};
	share.t_Date CreationDate {xpath('CreationDate')};
	share.t_Date TransactionDate {xpath('TransactionDate')};
	string PrivacyIndicator {xpath('PrivacyIndicator')};
	string MSA {xpath('MSA')};
	string CMSA {xpath('CMSA')};
	string FIPS {xpath('FIPS')};
	string CarrierRoute {xpath('CarrierRoute')};
	string CarrierRouteZoneCode {xpath('CarrierRouteZoneCode')};
	string CongressionalDistrict {xpath('CongressionalDistrict')};
	string DeliveryPointCode {xpath('DeliveryPointCode')};
	share.t_GeoLocation GeoLocation {xpath('GeoLocation')};
	string AddressType {xpath('AddressType')};
	string ServiceClass {xpath('ServiceClass')};
	string PortingCode {xpath('PortingCode')};
	string StatusCode {xpath('StatusCode')};
	string GenericName {xpath('GenericName')};
	t_PhoneFinderOperatingCompany OperatingCompany {xpath('OperatingCompany')};
end;
		
export t_PhoneFinderSearchRecord := record
	dataset(t_PhoneIdentityInfo) Identities {xpath('Identities/Identity'), MAXCOUNT(iesp.Constants.PhoneFinder.MaxIdentities)};
	dataset(t_PhoneFinderInfo) OtherPhones {xpath('OtherPhones/Phone'), MAXCOUNT(iesp.Constants.PhoneFinder.MaxOtherPhones)};
	dataset(t_PhoneFinderHistory) PhonesHistory {xpath('PhonesHistory/Phone'), MAXCOUNT(iesp.Constants.PhoneFinder.MaxPhoneHistory)};
	t_PhoneFinderDetailedInfo PrimaryPhoneDetails {xpath('PrimaryPhoneDetails')};
end;
		
export t_PhoneFinderSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_PhoneFinderSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.PhoneFinder.MaxPhoneFinderRecords)};
	t_PhoneFinderSearchBy InputEcho {xpath('InputEcho')};
end;
		
export t_PhoneFinderSearchRequest := record (share.t_BaseRequest)
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

