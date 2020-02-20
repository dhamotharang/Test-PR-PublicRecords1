/*
  NOTE:  This layout has been generated manually and it is not the official layout used for Targus.

  *** Use it for test only ***
  
*/
import iesp;

export gateway_targus := module

  export t_TargusSearchVerifyExpressOptions := record
    boolean	IncludeInputNameScore {xpath('IncludeInputNameScore')};
    boolean	IncludeInputAddressScore  {xpath('IncludeInputAddressScore')};
    boolean	IncludeInputPhoneScore {xpath('IncludeInputPhoneScore')};
    boolean	IncludeMatchedNameScore {xpath('IncludeMatchedNameScore')};
    boolean	IncludeMatchedAddressScore {xpath('IncludeMatchedAddressScore')};
    boolean	IncludeMatchedPhoneScore {xpath('IncludeMatchedPhoneScore')};
    boolean	IncludeMatchedCompositeScore {xpath('IncludeMatchedCompositeScore')};
    boolean	IncludeMatchedName {xpath('IncludeMatchedName')}; 
    boolean	IncludeMatchedPrimaryAddress {xpath('IncludeMatchedPrimaryAddress')};
    boolean	IncludeMatchedSecondaryAddress {xpath('IncludeMatchedSecondaryAddress')};
    boolean	IncludeMatchedCityName {xpath('IncludeMatchedCityName')};
    boolean	IncludeMatchedState {xpath('IncludeMatchedState')} ;
    boolean	IncludeMatchedCorrectedZIPCode {xpath('IncludeMatchedCorrectedZIPCode')};
    boolean	IncludeStatusCodes {xpath('IncludeStatusCodes')};
    boolean	IncludeMatchedOrCorrectedPhone {xpath('IncludeMatchedOrCorrectedPhone')};
    boolean	IncludeDoNotCallFlag {xpath('IncludeDoNotCallFlag')};
    boolean	IncludeCurrentPhoneStatus {xpath('IncludeCurrentPhoneStatus')}; 
    boolean	IncludeNameAddressCurrencyIndicator {xpath('IncludeNameAddressCurrencyIndicator')};
    boolean	IncludeStateDoNotCall {xpath('IncludeStateDoNotCall')};
    boolean	IncludeEquipmentPortFlag {xpath('IncludeEquipmentPortFlag')};
    string20 ScreenOptions {xpath('ScreenOptions')}; 
  end;

  export t_TargusSearchOptions := record
    boolean	Blind {xpath('Blind')}; // internal
    boolean	Encrypt {xpath('Encrypt')}; // internal
    string IntendedUse {xpath('IntendedUse')};
    boolean IncludeWirelessConnectionSearch {xpath('IncludeWirelessConnectionSearch')};
    boolean	IncludePhoneDataExpressSearch {xpath('IncludePhoneDataExpressSearch')};
    boolean	IncludeIntlPhoneDataExpressSearch {xpath('IncludeIntlPhoneDataExpressSearch')};
    t_TargusSearchVerifyExpressOptions 	VerifyExpressOptions {xpath('VerifyExpressOptions')};
    boolean	IncludeNameVerificationSearch {xpath('IncludeNameVerificationSearch')};
  end;

  export t_TargusSearchBy := record
    string12 UniqueId {xpath('UniqueId')};
    iesp.share.t_Name	ConsumerName {xpath('ConsumerName')};
    string120	CompanyName {xpath('CompanyName')};
    string120	UnknownName {xpath('UnknownName')};
    string10 PhoneNumber {xpath('PhoneNumber')};
    iesp.share.t_Address Address {xpath('Address')} ;
  end;
      
  export t_TargusSearchRequest := record (iesp.share.t_BaseRequest)
    iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
    t_TargusSearchOptions Options {xpath('Options')};
    t_TargusSearchBy SearchBy {xpath('SearchBy')};
  end;

  export t_WirelessConnectionSearchResult := record
    integer	ErrorCode {xpath('ErrorCode')};
    string10	OwnerType {xpath('OwnerType')};
    iesp.share.t_Name ConsumerName {xpath('ConsumerName')};
    string120 CompanyName {xpath('CompanyName')};
  end;

  export t_PhoneDataExpressSearchResult := record
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

  export t_VerifyExpressInputVerificationConsumerName := record
    string3 LastNameScore {xpath('LastNameScore')};
    string3 FirstNameScore {xpath('FirstNameScore')};
    string3 MiddleNameScore {xpath('MiddleNameScore')};
  end;  

  export t_VerifyExpressInputVerificationAddress := record
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

  export t_VerifyExpressInputVerificationPhone := record
    string25 PhoneType {xpath('PhoneType')};
    string50 PointCode {xpath('PointCode')};
    string25 TimeZone {xpath('TimeZone')};
    string3	DaylightSavings {xpath('DaylightSavings')};
    string3	IsDialable {xpath('IsDialable')};
    string2	StateCode {xpath('StateCode')};
    string3	AreaCodeSplitApplied {xpath('AreaCodeSplitApplied')};
  end;

  export t_VerifyExpressInputVerification := record
    t_VerifyExpressInputVerificationConsumerName ConsumerName {xpath('ConsumerName')}; // missing from query internal layout. Not used?
    string10	BusinessName {xpath('BusinessName')};
    t_VerifyExpressInputVerificationAddress	Address {xpath('Address')};
    t_VerifyExpressInputVerificationPhone	Phone {xpath('Phone')};
  end;

  export t_VerifyExpressionMatchAddress := record
	  string100	SearchDomain {xpath('SearchDomain')};
	  string100	MatchLevel {xpath('MatchLevel')};
    string100	MatchOnStreetName {xpath('MatchOnStreetName')}; //not used by query
    string100	MatchOnStreetNumber {xpath('MatchOnStreetNumber')}; //not used by query
    string100	MatchOnSecondaryAddress {xpath('MatchOnSecondaryAddress')}; //not used by query
  end;

  export t_VerifyExpressComposition := record
    string35 PhoneNumberMatchLevel {xpath('PhoneNumberMatchLevel')};
    integer	NumericScore {xpath('NumericScore')};
    string100 Description {xpath('Description')};
  end;

  export t_VerifyExpressMatchResults := record
	string10 BusinessName {xpath('BusinessName')};
	t_VerifyExpressionMatchAddress Address {xpath('Address/')};
	string100	Phone {xpath('Phone')};
	t_VerifyExpressComposition Composition {xpath('Composition/')};
end;

export t_VerifyExpressAddrStatus := record
	string25 USPSZipType {xpath('USPSZipType')};
	string25 HouseholdCode {xpath('HouseholdCode')};
	string25 TimeZone {xpath('TimeZone')};
	string3	DaylightSavings {xpath('DaylightSavings')};
	string10 MajorRecordType {xpath('MajorRecordType')};
end;
 
t_VerifyExpressEnhancedData := record
	string100	Name {xpath('Name')};
	string100	PrimaryAddress {xpath('PrimaryAddress')};
	string25	CityName {xpath('CityName')};
	string2	State {xpath('State')};
	string11	ZIPCode {xpath('ZIPCode')};
	t_VerifyExpressAddrStatus AddressStatus {xpath('AddressStatus')};
	string10	Phone {xpath('Phone')};
	string100	DoNotCall {xpath('DoNotCall')};
	string15	PhoneStatus {xpath('PhoneStatus')};
	integer	NameAddressCurrencyIndicator {xpath('NameAddressCurrencyIndicator')};
end;

  export t_VerifyExpressResult := record
    integer	ErrorCode {xpath('ErrorCode')};
    t_VerifyExpressInputVerification	InputVerification {xpath('InputVerification')};
    t_VerifyExpressMatchResults MatchResults {xpath('MatchResults')};
    t_VerifyExpressEnhancedData	EnhancedData {xpath('EnhancedData')};
  end;

  export t_NameVerificationSearchResult := record
    integer ErrorCode {xpath('ErrorCode')};
    string10 MatchedName {xpath('MatchedName')};
    string10 NameType {xpath('NameType')};
  end;

  export t_TargusSearchResponse := record
    iesp.share.t_ResponseHeader _Header {xpath('Header')};
	  t_WirelessConnectionSearchResult WirelessConnectionSearchResult {xpath('WirelessConnectionSearchResult')};
	  t_PhoneDataExpressSearchResult PhoneDataExpressSearchResult {xpath('PhoneDataExpressSearchResult')};
	  t_PhoneDataExpressSearchResult USPhoneDataExpressSearchResult {xpath('USPhoneDataExpressSearchResult')};
	  t_VerifyExpressResult VerifyExpressResult {xpath('VerifyExpressResult')};
	  t_NameVerificationSearchResult NameVerificationSearchResult {xpath('NameVerificationSearchResult')};
  end;
      
  export t_TargusSearchResponseEx := record
    t_TargusSearchResponse response {xpath('response')};
  end;


end;
