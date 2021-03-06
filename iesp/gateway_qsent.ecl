/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from gateway_qsent.xml. ***/
/*===================================================*/

export gateway_qsent := MODULE
			
export t_QSentCISSearchOptions := record (share.t_BaseOption)
	string QueryType {xpath('QueryType')}; //values['BR','RS','BG','']
	integer StartSequence {xpath('StartSequence')};
	integer ResultCount {xpath('ResultCount')};
	boolean ShowNonPublished {xpath('ShowNonPublished')};
	string ServiceType {xpath('ServiceType')}; //values['','iQ411','PVS','PVSD','']
	string QueryCategory {xpath('QueryCategory')};
	boolean IntelligentSearch {xpath('IntelligentSearch')};
	boolean Match {xpath('Match')};
	string MatchSortCode {xpath('MatchSortCode')}; //values['','A','S','']
	integer MinScore {xpath('MinScore')};
	string RequestCredential {xpath('RequestCredential')}; //values['0','1','2','']
end;
		
export t_QSentCISSearchBy := record
	string BusinessName {xpath('BusinessName')};
	boolean UseSimilarBusinessNames {xpath('UseSimilarBusinessNames')};
	string FirstName {xpath('FirstName')};
	boolean UseSimilarFirstNames {xpath('UseSimilarFirstNames')};
	string LastName {xpath('LastName')};
	boolean UseSimilarLastNames {xpath('UseSimilarLastNames')};
	string StreetAddress {xpath('StreetAddress')};
	string City {xpath('City')};
	string State {xpath('State')}; //values['','ALL','AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY','']
	string Zip5 {xpath('Zip5')};
	string Zip4 {xpath('Zip4')};
	gateway_qsent_common.t_QSentCISPhone Phone {xpath('Phone')};
	string SurroundMiles {xpath('SurroundMiles')}; //values['','0','25','']
	string MetroCode {xpath('MetroCode')}; //values['','CMSA','MSA','']
	string GeoQuery {xpath('GeoQuery')};
	string GeoState {xpath('GeoState')};
	string SSN {xpath('SSN')};
	dataset(share.t_StringArrayItem) ExcludedPhones {xpath('ExcludedPhones/ExcludedPhone'), MAXCOUNT(iesp.Constants.MAX_EXCLUDED_PHONES)};
end;
		
export t_OCContactInfo := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string Email {xpath('Email')};
end;
		
export t_OCPhoneInfo := record (gateway_qsent_common.t_QSentCISPhone)
	string PhoneExt {xpath('PhoneExt')};
	string FaxLine {xpath('FaxLine')};
	string FaxNpa {xpath('FaxNpa')};
	string FaxNxx {xpath('FaxNxx')};
end;
		
export t_OperatingCompany := record
	string Number {xpath('Number')};
	string Name {xpath('Name')};
	string AffiliatedTo {xpath('AffiliatedTo')};
	share.t_Address Address {xpath('Address')};
	t_OCPhoneInfo PhoneInfo {xpath('PhoneInfo')};
	t_OCContactInfo Contact {xpath('Contact')};
end;
		
export t_Listing := record
	string CongressionalDistrict {xpath('CongressionalDistrict')};
	string Latitude {xpath('Latitude')};
	string Longitude {xpath('Longitude')};
	string ListingType {xpath('ListingType')};
	string ListingTypeDescription {xpath('ListingTypeDescription')};
	string ListingName {xpath('ListingName')};
	string MatchCode {xpath('MatchCode')};
	string MatchScore {xpath('MatchScore')};
	string ServiceClass {xpath('ServiceClass')};
	string DataSource {xpath('DataSource')};
	string NonPublished {xpath('NonPublished')};
	string SSNMatch {xpath('SSNMatch')};
	share.t_Date ListingCreationDate {xpath('ListingCreationDate')};
	share.t_Date ListingTransactionDate {xpath('ListingTransactionDate')};
	share.t_Name Name {xpath('Name')};
	gateway_qsent_common.t_QSentCISPhone Phone {xpath('Phone')};
	t_OperatingCompany OperatingCompany {xpath('OperatingCompany')};
	gateway_qsent_common.t_QSentCISAddress Address {xpath('Address')};
	gateway_qsent_common.t_DeliveryInfo DeliveryInfo {xpath('DeliveryInfo')};
end;
		
export t_StateListing := record
	string ListingsReturned {xpath('ListingsReturned')};
	string ListingsFound {xpath('ListingsFound')};
	string StateName {xpath('StateName')};
	string StateAbbr {xpath('StateAbbr')};
	string Filtered {xpath('Filtered')};
	dataset(t_Listing) Listings {xpath('Listings/Listing'), MAXCOUNT(iesp.Constants.REALTIME_PHONE_LIMIT)};
end;
		
export t_PVListing := record
	string GenericName {xpath('GenericName')};
	string PortingCode {xpath('PortingCode')};
	string DataSource {xpath('DataSource')};
	string ServiceClass {xpath('ServiceClass')};
	string SSNMatch {xpath('SSNMatch')};
	gateway_qsent_common.t_QSentCISPhone Phone {xpath('Phone')};
	t_OperatingCompany OperatingCompany {xpath('OperatingCompany')};
end;
		
export t_QSContactName := record
	string120 First {xpath('First')};
	string120 Last {xpath('Last')};
end;
		
export t_CIPOperatingCarrier := record
	string OperatingCompanyNumber {xpath('OperatingCompanyNumber')};
	string OperatingCompanyName {xpath('OperatingCompanyName')};
	share.t_Address OperatingCompanyAddress {xpath('OperatingCompanyAddress')};
	string Affiliate {xpath('Affiliate')};
	t_QSContactName ContactName {xpath('ContactName')};
	share.t_Address ContactAddress {xpath('ContactAddress')};
	string ContactEmail {xpath('ContactEmail')};
	string ContactPhone {xpath('ContactPhone')};
	string ContactExtension {xpath('ContactExtension')};
	string ContactFax {xpath('ContactFax')};
end;
		
export t_CIPPhoneInfo := record
	string Phone {xpath('Phone')};
	string ServiceClass {xpath('ServiceClass')};
	integer PortingCode {xpath('PortingCode')};
	integer StatusCode {xpath('StatusCode')};
	string GenericName {xpath('GenericName')};
	t_CIPOperatingCarrier OperatingCarrier {xpath('OperatingCarrier')};
end;
		
export t_CIPContactInfo := record
	share.t_Name Name {xpath('Name')};
	share.t_GeoAddress GeoAddress {xpath('GeoAddress')};
	string ListingName {xpath('ListingName')};
	string PrivacyIndicator {xpath('PrivacyIndicator')};
	string MetropolitanStatisticalAreacode {xpath('MetropolitanStatisticalAreacode')};
	string ConsolidatedMetropolitanStatisticalAreaCode {xpath('ConsolidatedMetropolitanStatisticalAreaCode')};
	string FederalInformationProcessingStandards {xpath('FederalInformationProcessingStandards')};
	string CarrierRoute {xpath('CarrierRoute')};
	string CarrierRouteSortZone {xpath('CarrierRouteSortZone')};
	string CongressionalDistrict {xpath('CongressionalDistrict')};
	string DeliveryPointCode {xpath('DeliveryPointCode')};
	string DeliveryPointCheckDigit {xpath('DeliveryPointCheckDigit')};
	string AddressType {xpath('AddressType')};
	t_CIPPhoneInfo PhoneInfo {xpath('PhoneInfo')};
end;
		
export t_CIPDataSourceInfo := record
	string DataSource {xpath('DataSource')};
	string ListingType {xpath('ListingType')};
	share.t_Date CreationDate {xpath('CreationDate')};
	share.t_Date ListingTransactionDate {xpath('ListingTransactionDate')};
end;
		
export t_CIPContactResult := record
	string MatchCode {xpath('MatchCode')};
	string SSNMatch {xpath('SSNMatch')};
	boolean IsLinkingMatchCode {xpath('IsLinkingMatchCode')};
	t_CIPDataSourceInfo DataSourceInfo {xpath('DataSourceInfo')};
	t_CIPContactInfo ContactInfo {xpath('ContactInfo')};
end;
		
export t_VendorHeader := record
	integer TotalListingsFound {xpath('TotalListingsFound')};
	integer TotalListingsFiltered {xpath('TotalListingsFiltered')};
	integer TotalListingsReturned {xpath('TotalListingsReturned')};
	string ReferenceClass {xpath('ReferenceClass')};
	string ReferenceCode {xpath('ReferenceCode')};
	string ReferenceId {xpath('ReferenceId')};
	string TransactionId {xpath('TransactionId')};
	integer IntelligentSearchResult {xpath('IntelligentSearchResult')};
end;
		
export t_QSentCISSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	gateway_qsent_common.t_SearchSummary Summary {xpath('Summary')};
	dataset(t_StateListing) StateListings {xpath('StateListings/StateListing'), MAXCOUNT(iesp.Constants.REALTIME_PHONE_LIMIT)};
	t_PVListing PVListing {xpath('PVListing')};
	t_VendorHeader VendorHeader {xpath('VendorHeader')};
	dataset(t_CIPContactResult) ContactResults {xpath('ContactResults/ContactResult'), MAXCOUNT(iesp.Constants.REALTIME_PHONE_LIMIT)};
end;
		
export t_QSentCISSearchRequest := record (share.t_BaseRequest)
	share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_QSentCISSearchOptions Options {xpath('Options')};
	t_QSentCISSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_QSentCISSearchResponseEx := record
	t_QSentCISSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from gateway_qsent.xml. ***/
/*===================================================*/

