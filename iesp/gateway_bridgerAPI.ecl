IMPORT iesp;

EXPORT gateway_bridgerAPI := MODULE


export t_WatchlistDataFiles := record
  boolean AlwaysGenerateMatchesForCitiesAndPorts {xpath('AlwaysGenerateMatchesForCitiesAndPorts')};
  boolean Custom {xpath('Custom')};
  boolean IgnoreWeakAKAs {xpath('IgnoreWeakAKAs')};
	integer MinScore {xpath('MinScore')};
	unicode Name {xpath('Name')};
  boolean TopLevelOperatorIsOr {xpath('TopLevelOperatorIsOr')};
end;

export t_DataFiles := record
  dataset(t_WatchlistDataFiles) WatchlistDataFile {xpath('WatchlistDataFile'), MAXCOUNT(iesp.Constants.gwBridger.MaxList)};
end;


export t_ConfigGeneralOptions := record
  boolean GenerateAlertsForAllRecords {xpath('GenerateAlertsForAllRecords')};
  boolean GenerateAlertsForErrors {xpath('GenerateAlertsForErrors')};
  boolean IgnoreMatchesAgainstVessels {xpath('IgnoreMatchesAgainstVessels')};
  boolean ScanAddressForBlockedCountries {xpath('ScanAddressForBlockedCountries')};
  boolean ScanNameForBlockedCountries {xpath('ScanNameForBlockedCountries')};
  boolean ScanRunTogetherWordsForBlockedCountries {xpath('ScanRunTogetherWordsForBlockedCountries')};
end;


export t_ConfigMatchDispositionRules := record
  boolean GenerateTrueMatchUpdates {xpath('GenerateTrueMatchUpdates')};
  boolean IndividualMatchDisposition {xpath('IndividualMatchDisposition')};
  boolean TrueMatchSetsOthersToFalsePositive {xpath('TrueMatchSetsOthersToFalsePositive')};
  boolean CheckForFalseMatchUpdates {xpath('CheckForFalseMatchUpdates')};
end;

export t_EFTOptions := record
  boolean ACHGatewayOperatorOFACScreeningIndicator {xpath('ACHGatewayOperatorOFACScreeningIndicator')};
  boolean ACHSecondaryOFACScreeningIndicator {xpath('ACHSecondaryOFACScreeningIndicator')};
end;
	
export t_PaymentScreeningOptions := record
  dataset(t_EFTOptions) EFTOptions {xpath('EFTOptions/WatchlistEFTMatchOptions'), MAXCOUNT(iesp.Constants.gwBridger.MaxList)};
  boolean ScanAllFieldsForBICs {xpath('ScanAllFieldsForBICs')};
  boolean ScanAllFieldsForCountryCodes {xpath('ScanAllFieldsForCountryCodes')};
  boolean ScanAllFieldsForCountryNames {xpath('ScanAllFieldsForCountryNames')};
  boolean ScanAllFieldsForNames {xpath('ScanAllFieldsForNames')};
end;
		
export t_ConfigMatchOptions := record
  boolean Addresses {xpath('Addresses')};
  boolean IDs {xpath('IDs')};
  boolean InfluencedByInitials {xpath('InfluencedByInitials')};
  boolean InfluencedBySingleWords {xpath('InfluencedBySingleWords')};
  dataset(t_PaymentScreeningOptions) PaymentScreeningOptions {xpath('PaymentScreeningOptions/WatchlistPaymentScreeningOptions'), MAXCOUNT(iesp.Constants.gwBridger.MaxList)};
  boolean Phones {xpath('Phones')};
end;

export t_ConfigFalseMatchSettings := record
  boolean Name {xpath('Name')};
  boolean Dob {xpath('Dob')};
  boolean Gender {xpath('Gender')};
  boolean Aka {xpath('Aka')};
  boolean IdNumbers {xpath('IdNumbers')};
  boolean Address {xpath('Address')};
  boolean Phone {xpath('Phone')};
  boolean Citizenship {xpath('Citizenship')};
  boolean GenerateFalseMatchUpdate {xpath('GenerateFalseMatchUpdate')};
end;

export t_AutomaticFalsePositiveRules := record
  boolean Addresses {xpath('Addresses')};
  boolean Citizenship {xpath('Citizenship')};
  boolean Countries {xpath('Countries')};
  boolean DisplayAFPMatches {xpath('DisplayAFPMatches')};
  boolean DOB {xpath('DOB')};
  integer DOBTolerance {xpath('DOBTolerance')};
  boolean EntityType {xpath('EntityType')};
  boolean Gender {xpath('Gender')};
  boolean GenerateResultRecord {xpath('GenerateResultRecord')};
  boolean IDs {xpath('IDs')};
  boolean Phones {xpath('Phones')};
  boolean ShowResultAsAlert {xpath('ShowResultAsAlert')};
  boolean WhiteList {xpath('WhiteList')};
end;
		
export t_Watchlist := record
  t_AutomaticFalsePositiveRules AutomaticFalsePositiveRules {xpath('AutomaticFalsePositiveRules')};
  t_DataFiles DataFiles {xpath('DataFiles')};
  t_ConfigGeneralOptions GeneralOptions {xpath('GeneralOptions')};
	t_ConfigMatchDispositionRules MatchDispositionRules {xpath('MatchDispositionRules')};
	t_ConfigMatchOptions MatchOptions {xpath('MatchOptions')};
	t_ConfigFalseMatchSettings FalseMatchSettings {xpath('FalseMatchSettings')};
end;


export t_SearchConfiguration := record
  string PredefinedSearchName {xpath('PredefinedSearchName')};
	t_Watchlist Watchlist {xpath('Watchlist')};
  boolean WriteResultsToDatabase {xpath('WriteResultsToDatabase')};
  boolean ExcludeScreeningListMatches {xpath('ExcludeScreeningListMatches')};
  boolean DuplicateMatchSuppression {xpath('DuplicateMatchSuppression')};
  boolean DuplicateMatchSuppressionSameDivisionOnly {xpath('DuplicateMatchSuppressionSameDivisionOnly')};
end;

export t_InputEFT := record
  string _Type {xpath('Type')};
	string Value {xpath('Value')};
end;

export t_DatePieces := record
  integer Day {xpath('Day')};
  integer Month {xpath('Month')};
  integer Year {xpath('Year')};
  string Unparsed {xpath('Unparsed')};
end;

export t_NamePieces := record
	unicode First {xpath('First')};
	unicode Full {xpath('Full')};
	unicode Generation {xpath('Generation')};
	unicode Last {xpath('Last')};
	unicode Middle {xpath('Middle')};
	unicode Title {xpath('Title')};
	unicode MaidenName {xpath('MaidenName')};
	unicode SecondSurname {xpath('SecondSurname')};
end;

export t_AddressPieces := record
  string BuildingOrStreetNumber {xpath('BuildingOrStreetNumber')};
  string City {xpath('City')};
  string Country {xpath('Country')};
  string County {xpath('County')};
  string FullAddress {xpath('FullAddress')};
  string PostalCode {xpath('PostalCode')};
  string StateProvinceDistrict {xpath('StateProvinceDistrict')};
  string StreetAddress1 {xpath('Street1')};
  string StreetAddress2 {xpath('Street2')};
  string StreetName {xpath('StreetName')};
  string StreetPostDirection {xpath('StreetPostDirection')};
  string StreetPreDirection {xpath('StreetPreDirection')};
  string StreetSuffixOrType {xpath('StreetSuffixOrType')};
  string _Type {xpath('Type')};
  string UnitDesignation {xpath('UnitDesignation')};
  string UnitNumber {xpath('UnitNumber')};
  string HouseNumber {xpath('HouseNumber')};
  string BuildingName {xpath('BuildingName')};
  string FloorNumber {xpath('FloorNumber')};
  string Suburb {xpath('Suburb')};
  string District {xpath('District')};
  string IntlStreetType {xpath('IntlStreetType')};
end;

export t_NumberType := record
  string Number {xpath('Number')};
  string _Type {xpath('Type')};
end;

export t_AdditionalInfo := record
  string Label {xpath('Label')};
  string _Type {xpath('Type')};  
  string Value {xpath('Value')};
end;

export t_InputIDs := record
  t_DatePieces DateExpires {xpath('DateExpires')};
  t_DatePieces DateIssued {xpath('DateIssued')};
  string Issuer {xpath('Issuer')};
  string Label {xpath('Label')};
  string MachineReadableLine1 {xpath('MachineReadableLine1')};
  string MachineReadableLine2 {xpath('MachineReadableLine2')};
  string Number {xpath('Number')};
  string PlaceOfBirth {xpath('PlaceOfBirth')};
  string CountryOfBirth {xpath('CountryOfBirth')};
  string FamilyNameAtBirth {xpath('FamilyNameAtBirth')};
  string FamilyNameAtCitizenship {xpath('FamilyNameAtCitizenship')};
  string CityOfIssue {xpath('CityOfIssue')};
  string CountyOfIssue {xpath('CountyOfIssue')};
  string DistrictOfIssue {xpath('DistrictOfIssue')};
  string ProvinceOfIssue {xpath('ProvinceOfIssue')};
  string StateOfBirth {xpath('StateOfBirth')};
  string DriverLicenceVersionNumber {xpath('DriverLicenceVersionNumber')};
  string _Type {xpath('Type')};
  string AccountType {xpath('AccountType')};
end;

export t_InputEntity := record
  dataset(t_AdditionalInfo) AdditionalInfo {xpath('AdditionalInfo/InputAdditionalInfo'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  dataset(t_AddressPieces) Addresses {xpath('Addresses/InputAddress'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string EntityType {xpath('EntityType')};
  string Gender {xpath('Gender')};
  t_NamePieces Name {xpath('Name')};  
  dataset(t_NumberType) Phones {xpath('Phones/InputPhone'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
end;

export t_Text := record
  dataset(t_InputIDs) IDs {xpath('IDs/InputID'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
end;

export t_InputRecord := record  
  integer RecordID {xpath('RecordID')};
  t_InputEntity Entity {xpath('Entity')};
end;

export t_SearchInput := record
	string BlockID {xpath('BlockID')};
	dataset(t_InputRecord) InputRecords {xpath('Records/InputRecord'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
end;

export t_SearchContext := record
  string ClientID {xpath('ClientID')};
  string Password {xpath('Password')};
  string UserID {xpath('UserID')};
end;

export t_Error := record
  integer Code {xpath('Code')}; 
  string Message {xpath('Message')};
end;

export t_WatchlistMatchState := record
  integer MatchID {xpath('MatchID')};
  string _Type {xpath('Type')};
end;

export t_RecordState := record
  boolean AddedToAcceptList {xpath('AddedToAcceptList')};
  string AlertState {xpath('AlertState')};  
  dataset(iesp.share.t_StringArrayItem) AssignedTo {xpath('AssignedTo/String'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string AssignmentType {xpath('AssignmentType')};
  string Division {xpath('Division')};
end;

export t_ResultRecordDetails := record
  integer AcceptListID {xpath('AcceptListID')};
  string AccountAmount {xpath('AccountAmount')};
  string AccountDate {xpath('AccountDate')};
  string AccountGroupID {xpath('AccountGroupID')};
  string AccountOtherData {xpath('AccountOtherData')};
  string AccountProviderID {xpath('AccountProviderID')};
  string AccountType {xpath('AccountType')};
  boolean AddedToAcceptList {xpath('AddedToAcceptList')};
  dataset(t_AdditionalInfo) AdditionalInfo {xpath('AdditionalInfo/InputAdditionalInfo'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  dataset(t_AddressPieces) Addresses {xpath('Addresses/InputAddress'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string DPPA {xpath('DPPA')};
  string EFTContext {xpath('EFTContext')};
  string EFTType {xpath('EFTType')};
  string EntityType {xpath('EntityType')};
  t_Error _Error {xpath('Error')};
  string Gender {xpath('Gender')};
  integer GLB {xpath('GLB')};
  string LastUpdatedDate {xpath('LastUpdatedDate')};
  dataset(t_InputIDs) IDs {xpath('IDs/InputID'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  t_namePieces Name {xpath('Name')};
  dataset(t_NumberType) Phones {xpath('Phones/InputPhone'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  t_recordState RecordState {xpath('RecordState')};
  string SearchDate {xpath('SearchDate')};
  string Text {xpath('Text')};
end;

export t_WLMatch_InputValueListValueScoreType := record
  string InputValue {xpath('InputValue')};
  string ListValue {xpath('ListValue')};
  integer Score {xpath('Score')};
  string _Type {xpath('Type')};
end;

export t_WLMatch_InputValueListValueScore := record
  string InputValue {xpath('InputValue')};
  string ListValue {xpath('ListValue')};
  integer Score {xpath('Score')};
end;

export t_WLMatchConflicts := record
  boolean AddressConflict {xpath('AddressConflict')};
  boolean CitizenshipConflict {xpath('CitizenshipConflict')};
  boolean CountryConflict {xpath('CountryConflict')};
  boolean DOBConflict {xpath('DOBConflict')};
  boolean EntityTypeConflict {xpath('EntityTypeConflict')};
  boolean GenderConflict {xpath('GenderConflict')};
  boolean IDConflict {xpath('IDConflict')};
  boolean PhoneConflict {xpath('PhoneConflict')};
end;

export t_WLCountryDetails := record
  dataset(iesp.share.t_StringArrayItem) AKAs {xpath('AKAs/String'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  dataset(iesp.share.t_StringArrayItem) Cities {xpath('Cities/String'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  dataset(iesp.share.t_StringArrayItem) Codes {xpath('Codes/String'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string Comments {xpath('Comments')};
  string Country {xpath('Country')};
  string DateListed {xpath('DateListed')};
  string ListReferenceNumber {xpath('ListReferenceNumber')};
  dataset(iesp.share.t_StringArrayItem) Ports {xpath('Ports/String'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string ReasonListed {xpath('ReasonListed')};
  dataset(iesp.share.t_StringArrayItem) Terms {xpath('Terms/String'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
end;

export t_EntityAdditionalInfo := record
  string Comments {xpath('Comments')};
  integer ID {xpath('ID')};
  string _Type {xpath('Type')};
  string _Value {xpath('Value')};
end;

export t_EntityAddress := record
  string City {xpath('City')};
  string Comments {xpath('Comments')};
  string Country {xpath('Country')};
  integer ID {xpath('ID')};
  string PostalCode {xpath('PostalCode')};
  string StateProvinceDistrict {xpath('StateProvinceDistrict')};
  string Street1 {xpath('Street1')};
  string Street2 {xpath('Street2')};
  string _Type {xpath('Type')};
end;

export t_EntityName := record
  string First {xpath('First')};
  string Full {xpath('Full')};
  string Generation {xpath('Generation')};
  string Last {xpath('Last')};
  string Middle {xpath('Middle')};
  string Title {xpath('Title')};
end;

export t_EntityAKA := record
  string Category {xpath('Category')};
  string Comments {xpath('Comments')};
  integer ID {xpath('ID')};
  t_EntityName Name {xpath('Name')};
  string _Type {xpath('Type')};
end;

export t_EntityID := record
  string Comments {xpath('Comments')};
  t_DatePieces DateExpires {xpath('DateExpires')};
  t_DatePieces DateIssued {xpath('DateIssued')};
  integer ID {xpath('ID')};
  string Issuer {xpath('Issuer')};
  string Label {xpath('Label')};
  string Number {xpath('Number')};
  string _Type {xpath('Type')};
end;

export t_EntityPhone := record
  string Comments {xpath('Comments')};
  integer ID {xpath('ID')};
  string Number {xpath('Number')};
  string _Type {xpath('Type')};
end;

export t_WLEntityDetails := record
  dataset(t_EntityAdditionalInfo) AdditionalInfo {xpath('AdditionalInfo/EntityAdditionalInfo'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  dataset(t_EntityAddress) Addresses {xpath('Addresses/EntityAddress'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  dataset(t_EntityAKA) AKAs {xpath('AKAs/EntityAKA'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string Comments {xpath('Comments')};
  string DateListed {xpath('DateListed')};
  string EntityType {xpath('EntityType')};
  string Gender {xpath('Gender')};
  dataset(t_EntityID) IDs {xpath('IDs/EntityID'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string ListReferenceNumber {xpath('ListReferenceNumber')};
  t_EntityName Name {xpath('Name')};
  dataset(t_EntityPhone) Phones {xpath('Phones/EntityPhone'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string ReasonListed {xpath('ReasonListed')};
end;

export t_WLMatchFile := record
  string _Build {xpath('Build')};
  boolean Custom {xpath('Custom')};
  integer ID {xpath('ID')};
  string Name {xpath('Name')};
  string Published {xpath('Published')};
  string _Type {xpath('Type')};
end;

export t_WLMatch := record
  integer AcceptListID {xpath('AcceptListID')};
  boolean AddedToAcceptList {xpath('AddedToAcceptList')};
  dataset(t_WLMatch_InputValueListValueScoreType) Addresses {xpath('Addresses/WLAddressMatch'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  boolean AddressName {xpath('AddressName')};
  boolean AutoFalsePositive {xpath('AutoFalsePositive')};
  boolean BestAddressIsPartial {xpath('BestAddressIsPartial')};
  string BestCountry {xpath('BestCountry')};
  integer BestCountryScore {xpath('BestCountryScore')};
  string BestCountryType {xpath('BestCountryType')};
  boolean BestDOBIsPartial {xpath('BestDOBIsPartial')};
  unicode BestName {xpath('BestName')};
  integer BestNameScore {xpath('BestNameScore')};
  integer CheckSum {xpath('CheckSum')};
  dataset(t_WLMatch_InputValueListValueScore) Citizenships {xpath('Citizenships/WLCitizenshipMatch'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  t_WLMatchConflicts Conflicts {xpath('Conflicts')};
  t_WLCountryDetails CountryDetails {xpath('CountryDetails')};
  dataset(t_WLMatch_InputValueListValueScore) DOBs {xpath('DOBs/WLDOBMatch'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  t_WLEntityDetails EntityDetails {xpath('EntityDetails')};
  string EntityName {xpath('EntityName')};
  integer EntityScore {xpath('EntityScore')};
  string EntityUniqueID {xpath('EntityUniqueID')};
  t_Error _Error {xpath('Error')};
  boolean FalsePositive {xpath('FalsePositive')};
  t_WLMatchFile File {xpath('File')};
  boolean GatewayOFACScreeningIndicatorMatch {xpath('GatewayOFACScreeningIndicatorMatch')};
  integer ID {xpath('ID')};
  dataset(t_WLMatch_InputValueListValueScoreType) IDs {xpath('IDs/WLIDMatch'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  boolean MatchReAlert {xpath('MatchReAlert')};
  dataset(t_WLMatch_InputValueListValueScoreType) Phones {xpath('Phones/WLPhoneMatch'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  integer PreviousResultID {xpath('PreviousResultID')};
  string ReasonListed {xpath('ReasonListed')};
  string ResultDate {xpath('ResultDate')};
  boolean SecondaryOFACScreeningIndicatorMatch {xpath('SecondaryOFACScreeningIndicatorMatch')};
  boolean TrueMatch {xpath('TrueMatch')};
end;

export t_WatchlistResults := record
  dataset(t_WLMatch) Matches {xpath('Matches/WLMatch'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
end;

export t_ResultRecords := record
  integer ResultRecordID {xpath('Record')};
  t_ResultRecordDetails RecordDetails {xpath('RecordDetails')};
  integer ResultID {xpath('ResultID')};
  integer RunID {xpath('RunID')};
  t_WatchlistResults Watchlist {xpath('Watchlist')};
  boolean HasScreeningListMatches {xpath('HasScreeningListMatches')};
  string RecordStatus {xpath('RecordStatus')};
end;

export t_SearchResponseResult := record
  string BlockID {xpath('BlockID')};
  dataset(t_ResultRecords) Records {xpath('Records/ResultRecord'), MAXCOUNT(iesp.Constants.gwBridger.MaxItem)};
  string SearchEngineVersion {xpath('SearchEngineVersion')};
end;

export t_SearchRequest := record
  t_SearchContext Context {xpath('context')};
	t_SearchConfiguration Config {xpath('config')};
	t_SearchInput Input {xpath('input')};
end;


export t_SearchResponse := record
  t_SearchResponseResult SearchResult {xpath('SearchResult')};
end;


export t_SearchRequestWrapper := record
  t_SearchRequest request {xpath('request')};
end;

export t_SearchResponseWrapper := record
  t_SearchResponse response {xpath('response')};
end;


END;