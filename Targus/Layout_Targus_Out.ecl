Layout_Address := record
  string28	StreetName {xpath('StreetName')}; 
  string10	StreetNumber {xpath('StreetNumber')}; 
  string2	StreetPreDirection {xpath('StreetPreDirection')};
  string2	StreetPostDirection {xpath('StreetPostDirection')};
  string4	StreetSuffix {xpath('StreetSuffix')}; 
  string10	UnitDesignation {xpath('UnitDesignation')}; 
  string8	UnitNumber {xpath('UnitNumber')}; 
  string100	StreetAddress1 {xpath('StreetAddress1')}; 
  string100	StreetAddress2 {xpath('StreetAddress2')};
  string2	State {xpath('State')}; 
  string25	City {xpath('City')}; 
  string5	Zip5 {xpath('Zip5')}; 
  string4	Zip4 {xpath('Zip4')}; 
  string30	County {xpath('County')};
  string10	PostalCode {xpath('PostalCode')}; 
  string40	StateCityZip {xpath('StateCityZip')}; 
end;

Layout_ConsumerName := record
	string75	Fll {xpath('Full')};
	string20	frst {xpath('First')};
	string20	mddl {xpath('Middle')};
	string20	lst	{xpath('Last')};
end;

Layout_SearchBy := record
	Layout_consumerName consumername {xpath('ConsumerName/')};
	string120	CompanyName {xpath('CompanyName')};
	string10	PhoneNumber {xpath('PhoneNumber')};
	layout_address	Address {xpath('Address/')};
end;
	
layout_ResponseHeader := record
	integer	Status {xpath('Status')};
	string20	QueryId {xpath('QueryId')};
	integer	TransactionID {xpath('TransactionID')};
	string100	ErrorMessage;
	unsigned	ErrorCode;
end;

layout_consumername2 := record
	string75	Fll {xpath('Full')};
	string20	frst {xpath('First')};
	string20	lst	{xpath('Last')};
end;

Layout_WirelessConnectionSearchResult := record
	integer	ErrorCode {xpath('ErrorCode')};
	string10	OwnerType {xpath('OwnerType')};
	layout_ConsumerName2 ConsumerName {xpath('ConsumerName/')};
	string120 CompanyName {xpath('CompanyName')};
end;

Layout_VerAddress := record
  string3	AddressIsAHighrise {xpath('AddressIsAHighrise')};
  string3	ZIP5WasChanged {xpath('ZIP5WasChanged')};
  string3	ZIP9WasAddedChanged {xpath('ZIP9WasAddedChanged')};
  string3 CityWasChanged {xpath('CityWasChanged')};
  string3 StateWasChanged {xpath('StateWasChanged')};
  string3 StreetNameWasChanged {xpath('StreetNameWasChanged')};
  string3 StreetTypeWasChanged {xpath('StreetTypeWasChanged')};
  string3 PreDirectionalWasChanged {xpath('PreDirectionalWasChanged')};
  string3 PostDirectionalWasChanged {xpath('PostDirectionalWasChanged')};
end;

layout_VerPhone := record
	string25 	PhoneType {xpath('PhoneType')};
	string50 	PointCode {xpath('PointCode')};
	string25 	TimeZone {xpath('TimeZone')};
	string3	DaylightSavings {xpath('DaylightSavings')};
	string3	IsDialable {xpath('IsDialable')};
	string2	StateCode {xpath('StateCode')};
	string3	AreaCodeSplitApplied {xpath('AreaCodeSplitApplied')};
end;

Layout_InputVerification := record
	string10	BusinessName {xpath('BusinessName')};
	layout_VerAddress	Address {xpath('Address/')};
	layout_VerPhone	Phone {xpath('Phone/')};
end;

layout_MatchAddr := record
	string100	SearchDomain {xpath('SearchDomain')};
	string100	MatchLevel {xpath('MatchLevel')};
end;

layout_Composition := record
	string35 	PhoneNumberMatchLevel {xpath('PhoneNumberMatchLevel')};
	integer	NumericScore {xpath('NumericScore')};
	string100 Description {xpath('Description')};
  end;

layout_MatchResults := record
	string10			BusinessName {xpath('BusinessName')};
	layout_MatchAddr  	Address {xpath('Address/')};
	string100			Phone {xpath('Phone')};
	layout_Composition	Composition {xpath('Composition/')};
end;

layout_AddrStatus := record
	string25	USPSZipType {xpath('USPSZipType')};
	string25	HouseholdCode {xpath('HouseholdCode')};
	string25	TimeZone {xpath('TimeZone')};
	string3	DaylightSavings {xpath('DaylightSavings')};
	string10	MajorRecordType {xpath('MajorRecordType')};
end;
 
layout_EnhancedData := record
	string100	Name {xpath('Name')};
	string100	PrimaryAddress {xpath('PrimaryAddress')};
	string25	CityName {xpath('CityName')};
	string2	State {xpath('State')};
	string11	ZIPCode {xpath('ZIPCode')};
	layout_AddrStatus AddressStatus {xpath('AddressStatus/')};
	string10	Phone {xpath('Phone')};
	string100	DoNotCall {xpath('DoNotCall')};
	string15	PhoneStatus {xpath('PhoneStatus')};
	integer	NameAddressCurrencyIndicator {xpath('NameAddressCurrencyIndicator')};
end;

layout_VerifyExpressResult := record
	integer	ErrorCode {xpath('ErrorCode')};
	layout_InputVerification	InputVerification {xpath('InputVerification/')};
	layout_MatchResults		MatchResults {xpath('MatchResults/')};
	layout_EnhancedData		EnhancedData {xpath('EnhancedData/')};
end;

layout_PhoneDataExpressSearchResult := record
	integer ErrorCode {xpath('ErrorCode')};
	string30 Recordtype {xpath('RecordType')};
	string10 PrimaryAddress {xpath('PrimaryAddress')};
	string50 BuildingFirmName  {xpath('BuildingFirmName')};
	string10 PrimaryAddressNumber  {xpath('PrimaryAddressNumber')};
	string2 StreetPreDirection {xpath('StreetPreDirection')};
	string28 StreetName {xpath('StreetName')}; 
	string4 StreetNameSuffix {xpath('StreetNameSuffix')}; 
	string2 StreetNamePostDirection {xpath('StreetNamePostDirection')};
	string8 SecondaryAddressNumber {xpath('SecondaryAddressNumber')};
	string10 SecondaryAddressType {xpath('SecondaryAddressType')};
	string25 PostOfficeCityName {xpath('PostOfficeCityName')};
	string2 State {xpath('State')};
	string5 ZipCode {xpath('ZipCode')};
	string4 ZipPlus4 {xpath('ZipPlus4')};
	string3 DeliveryPointCode {xpath('DeliveryPointCode')};
	string30 AddressReturnStatus {xpath('AddressReturnStatus')};
	string10 StatusCode {xpath('StatusCode')};
	string9 SpatialKey {xpath('SpatialKey')};
	string6 LatLongitudeMatchPrecision {xpath('LatLongitudeMatchPrecision')};
	string3 PointCode {xpath('PointCode')};
	string3 TimeZone {xpath('TimeZone')};
	string1 InsideNXXMasterSourceTable {xpath('InsideNXXMasterSourceTable')};
	string1 DialableFlag {xpath('DialableFlag')};
	string1 DayLightSavingTime {xpath('DayLightSavingTime')};
	string10 NameType {xpath('NameType')};
	string50 BusinessName {xpath('BusinessName')};
	string20 LastName {xpath('LastName')};
	string20 FirstName {xpath('FirstName')};
	string20 MiddleName {xpath('MiddleName')};
	string3 NewNPA {xpath('NewNPA')};
	string4 CarrierRoute {xpath('CarrierRoute')};
	string1 SpatiallyInconsistent {xpath('SpatiallyInconsistent')};
end;

layout_NameVerificationSearchResult := record
	integer ErrorCode {xpath('ErrorCode')};
	string10 MatchedName {xpath('MatchedName')};
	string10 NameType {xpath('NameType')};
end;

layout_response := record
	layout_ResponseHeader	Header {xpath('Header/')};
	layout_WirelessConnectionSearchResult WirelessConnectionSearchResult {xpath('WirelessConnectionSearchResult/')};
	layout_PhoneDataExpressSearchResult PhoneDataExpressSearchResult {xpath('PhoneDataExpressSearchResult/')};
	layout_PhoneDataExpressSearchResult USPhoneDataExpressSearchResult {xpath('USPhoneDataExpressSearchResult/')};
	layout_VerifyExpressResult VerifyExpressResult {xpath('VerifyExpressResult/')};
	layout_NameVerificationSearchResult NameVerificationSearchResult {xpath('NameVerificationSearchResult/')};
end;

export Layout_Targus_Out := record
	layout_SearchBy 		SearchBy {xpath('SearchBy/')};
	layout_response		Response {xpath('response/')};
end;
