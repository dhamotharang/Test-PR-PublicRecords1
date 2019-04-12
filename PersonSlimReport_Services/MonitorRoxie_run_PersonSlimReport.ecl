/*** Generated Code do not hand edit ***/

IMPORT cassandra;


IMPORT std;
IMPORT lib_timelib.TimeLib;
  
IMPORT iesp as iesp;

IMPORT iesp.constants as constants;


DiffStatus := MODULE

  EXPORT JoinRowType := MODULE
    export integer1 IsInner := 0;
    export integer1 OuterLeft := 1;
    export integer1 OuterRight := 2;
  END;

  // Records in the old and new results are matched by virtual record ID (VID) -- something,
  // which makes "this" record unique. Usually is defined by business logic.
  // If two records have the same VID, they are compared field by field.
  EXPORT State := MODULE
    export integer1 VOID           := 0; // no comparison occured (for example, no alerts were requested)
    export integer1 UNCHANGED      := 1; // no changes
    export integer1 UPDATED        := 2; // there are changes to a scalar field
    export integer1 ADDED          := 4; // record is new (with respect to VID)
    export integer1 DELETED        := 8; // record doesn't exist anymore
    export integer1 PREVIOUS      := 16; // for UPDATED records only: will only have populated fields which are changed
    export integer1 CHILD_UPDATED := 32; // a record has a child dataset which has some records ADDED, DELETED or UPDATED
  END;

  EXPORT string Convert (integer sts) :=
    MAP (sts = State.DELETED   => 'deleted',
         sts = State.ADDED     => 'added',
         sts = State.UPDATED   => 'updated',
         sts = State.UNCHANGED => '',
         '');
END;

request := MODULE

  EXPORT _lt_EndUserInfo := RECORD
    string120 CompanyName {xpath('CompanyName')};
    string200 StreetAddress1 {xpath('StreetAddress1')};
    string25 City {xpath('City')};
    string2 State {xpath('State')};
    string5 Zip5 {xpath('Zip5')};//hidden[!_uk_]
    string10 Phone {xpath('Phone')};
  END;

  EXPORT _lt_User := RECORD
    string50 ReferenceCode {xpath('ReferenceCode')};
    string20 BillingCode {xpath('BillingCode')};
    string50 QueryId {xpath('QueryId')};
    string20 CompanyId {xpath('CompanyId')};//hidden[internal]
    string20 BillingId {xpath('BillingId')};//hidden[internal]
    string2 GLBPurpose {xpath('GLBPurpose')};//hidden[!_uk_]
    string2 DLPurpose {xpath('DLPurpose')};//hidden[!_uk_]
    string20 LoginHistoryId {xpath('LoginHistoryId')};//hidden[internal]
    integer DebitUnits {xpath('DebitUnits')};//hidden[internal]
    string15 IP {xpath('IP')};//hidden[internal]
    string5 IndustryClass {xpath('IndustryClass')};//hidden[internal]
    string3 ResultFormat {xpath('ResultFormat')};//hidden[internal]
    string16 LogAsFunction {xpath('LogAsFunction')};//hidden[internal]
    string16 LogAsSuplFunction {xpath('LogAsSuplFunction')};//hidden[internal]
    string6 SSNMask {xpath('SSNMask')};//hidden[internal]
    string6 DOBMask {xpath('DOBMask')};//hidden[internal]
    boolean ExcludeDMVPII {xpath('ExcludeDMVPII')};//hidden[internal]
    boolean DLMask {xpath('DLMask')};//hidden[internal]
    string DataRestrictionMask {xpath('DataRestrictionMask')};//hidden[internal]
    string50 DataPermissionMask {xpath('DataPermissionMask')};//hidden[internal]
    string10 DeathMasterPurpose {xpath('DeathMasterPurpose')};//hidden[internal]
    string SourceCode {xpath('SourceCode')};//hidden[internal]
    string32 ApplicationType {xpath('ApplicationType')};//hidden[internal]
    boolean SSNMaskingOn {xpath('SSNMaskingOn')};//hidden[internal]
    boolean DLMaskingOn {xpath('DLMaskingOn')};//hidden[internal]
    boolean LnBranded {xpath('LnBranded')};//hidden[internal]
    _lt_EndUserInfo EndUser {xpath('EndUser')};
    integer MaxWaitSeconds {xpath('MaxWaitSeconds')};
    string RelatedTransactionId {xpath('RelatedTransactionId')};//hidden[internal]
    string AccountNumber {xpath('AccountNumber')};
    boolean TestDataEnabled {xpath('TestDataEnabled')};//hidden[ecl_only]
    string32 TestDataTableName {xpath('TestDataTableName')};//hidden[ecl_only]
    boolean OutcomeTrackingOptOut {xpath('OutcomeTrackingOptOut')};//hidden[internal]
    integer NonSubjectSuppression {xpath('NonSubjectSuppression')};//hidden[internal]
    string ProductType {xpath('ProductType')};//hidden[internal]
    string11 BatchJobId {xpath('BatchJobId')};//hidden[internal]
    string11 BatchSequenceNumber {xpath('BatchSequenceNumber')};//hidden[internal]
    boolean ArchiveOptIn {xpath('ArchiveOptIn')};//hidden[internal]
    string ProcessSpecId {xpath('ProcessSpecId')};//hidden[internal]
    string ProductCode {xpath('ProductCode')};//hidden[internal]
    boolean AllowRoamingBypass {xpath('AllowRoamingBypass')};//hidden[internal]
    string DataSource {xpath('DataSource')};//hidden[internal]
    string OutputType {xpath('OutputType')}; 
  END;

  EXPORT _lt_ServiceParameter := RECORD
    string32 Name {xpath('Name')};
    string Value {xpath('Value'), maxlength(128)};
  END;

  EXPORT _lt_ServiceLocation := RECORD
    string LocationId {xpath('LocationId'), maxlength(256)};
    string ServiceName {xpath('ServiceName'), maxlength(128)};
    dataset(_lt_ServiceParameter) Parameters {xpath('Parameters/Parameter'), MAXCOUNT(10)};
  END;

  EXPORT _lt_BaseOption := RECORD
    boolean Blind {xpath('Blind')};//hidden[internal]
  END;

  EXPORT _lt_BaseReportOption := RECORD (_lt_BaseOption)
  END;

  EXPORT _lt_PersonSlimReportOption := RECORD (_lt_BaseReportOption)
    boolean EnableNationalAccidents {xpath('EnableNationalAccidents')};
    boolean EnableExtraAccidents {xpath('EnableExtraAccidents')};
    boolean IncludePriorProperties {xpath('IncludePriorProperties')};
    boolean IncludeNonRegulatedWatercraftSources {xpath('IncludeNonRegulatedWatercraftSources')};
    boolean IncludeNonRegulatedVehicleSources {xpath('IncludeNonRegulatedVehicleSources')};
    string RealTimePermissibleUse {xpath('RealTimePermissibleUse')};
    boolean IncludeAddresses {xpath('IncludeAddresses')};
    boolean IncludePhones {xpath('IncludePhones')};
    boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
    boolean IncludePeopleAtWork {xpath('IncludePeopleAtWork')};
    boolean IncludeAircrafts {xpath('IncludeAircrafts')};
    boolean IncludePilotCerts {xpath('IncludePilotCerts')};
    boolean IncludeWatercrafts {xpath('IncludeWatercrafts')};
    boolean IncludeUccs {xpath('IncludeUccs')};
    boolean IncludeSexualOffences {xpath('IncludeSexualOffences')};
    boolean IncludeCrimRecords {xpath('IncludeCrimRecords')};
    boolean IncludeConcealedWeapons {xpath('IncludeConcealedWeapons')};
    boolean IncludeHuntingFishingPermits {xpath('IncludeHuntingFishingPermits')};
    boolean IncludeFederalFirearms {xpath('IncludeFederalFirearms')};
    boolean IncludeControlledSubstances {xpath('IncludeControlledSubstances')};
    boolean IncludeVoters {xpath('IncludeVoters')};
    boolean IncludeDriversLicenses {xpath('IncludeDriversLicenses')};
    boolean IncludeMotorVehicles {xpath('IncludeMotorVehicles')};
    boolean IncludeRealTimeVehicles {xpath('IncludeRealTimeVehicles')};
    boolean IncludeAccidents {xpath('IncludeAccidents')};
    boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
    boolean IncludeLiens {xpath('IncludeLiens')};
    boolean IncludeProperties {xpath('IncludeProperties')};
    boolean IncludeMarriageDivorces {xpath('IncludeMarriageDivorces')};
    boolean IncludeEducation {xpath('IncludeEducation')};
    boolean IncludeAKAs {xpath('IncludeAKAs')};
    boolean IncludeImposters {xpath('IncludeImposters')};
    boolean IncludeDeaths {xpath('IncludeDeaths')};
    boolean IncludeUtility {xpath('IncludeUtility')};
  END;

  EXPORT _lt_PersonSlimReportBy := RECORD
    string12 UniqueId {xpath('UniqueId')};
  END;

  EXPORT _lt_BaseRequest := RECORD
    _lt_User User {xpath('User')};
    SET OF STRING RemoteLocations {xpath('RemoteLocations/Item'), MAXCOUNT(10)};//hidden[internal]
    dataset(_lt_ServiceLocation) ServiceLocations {xpath('ServiceLocations/ServiceLocation'), MAXCOUNT(10)};//hidden[internal]
  END;

  EXPORT _lt_PersonSlimReportRequest := RECORD (_lt_BaseRequest)
    _lt_PersonSlimReportOption Options {xpath('Options')};
    _lt_PersonSlimReportBy ReportBy {xpath('ReportBy')};
  END;

END;

layouts := MODULE

  EXPORT DiffString := RECORD
    string7 _diff {XPATH('@diff')} := '';
    string value {XPATH('')} := '';
  END;

  EXPORT DiffStringRow := RECORD  (DiffString)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT DiffMetaRow := RECORD
    string name {XPATH ('@name')};
    string prior {XPATH ('@prior')};
  END;

  EXPORT DiffMetaRec := RECORD
    string7 _child_diff {XPATH('@child_diff')} := '';
    string7 _diff {XPATH('@diff')} := '';
    DATASET (DiffMetaRow) _diffmeta {XPATH ('DiffMeta/Field')} := DATASET ([], DiffMetaRow);
  END;
  EXPORT _lt_WsException := RECORD
    string Source {xpath('Source'), maxlength(64)};
    integer Code {xpath('Code')};
    string Location {xpath('Location'), maxlength(64)};
    string256 Message {xpath('Message')};
  END;

  EXPORT _lt_TransactionCap := RECORD
    integer Maximum {xpath('Maximum')};
    integer Count {xpath('Count')};
    boolean AllowAboveMax {xpath('AllowAboveMax')};
  END;

  EXPORT _lt_ResponseHeader := RECORD
    integer Status {xpath('Status')};
    string256 Message {xpath('Message')};
    string50 QueryId {xpath('QueryId')};
    string16 TransactionId {xpath('TransactionId')};
    _lt_TransactionCap TransactionCap {xpath('TransactionCap')};//hidden[internal]
    dataset(_lt_WsException) Exceptions {xpath('Exceptions/Item'), MAXCOUNT(iesp.Constants.MaxResponseExceptions * 2)};
  END;

  EXPORT _lt_Address := RECORD (DiffMetaRec)
    string10 StreetNumber {xpath('StreetNumber')};
    string2 StreetPreDirection {xpath('StreetPreDirection')};
    string28 StreetName {xpath('StreetName')};
    string4 StreetSuffix {xpath('StreetSuffix')};
    string2 StreetPostDirection {xpath('StreetPostDirection')};
    string10 UnitDesignation {xpath('UnitDesignation')};
    string8 UnitNumber {xpath('UnitNumber')};
    string60 StreetAddress1 {xpath('StreetAddress1')};
    string60 StreetAddress2 {xpath('StreetAddress2')};
    string25 City {xpath('City')};
    string2 State {xpath('State')};
    string5 Zip5 {xpath('Zip5')};
    string4 Zip4 {xpath('Zip4')};
    string18 County {xpath('County')};
    string9 PostalCode {xpath('PostalCode')};
    string50 StateCityZip {xpath('StateCityZip')};
    string10 Latitude {xpath('Latitude')};
    string11 Longitude {xpath('Longitude')};
  END;

  EXPORT _lt_row_Address := RECORD  (_lt_Address)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_Date := RECORD (DiffMetaRec)
    integer2 Year {xpath('Year')};
    integer2 Month {xpath('Month')};
    integer2 Day {xpath('Day')};
  END;

  EXPORT _lt_row_Date := RECORD  (_lt_Date)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PersonSlimReportAddress := RECORD (_lt_Address)
    string7 GeoBlk {xpath('GeoBlk')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
  END;

  EXPORT _lt_row_PersonSlimReportAddress := RECORD  (_lt_PersonSlimReportAddress)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_Name := RECORD (DiffMetaRec)
    string62 Full {xpath('Full')};
    string20 First {xpath('First')};
    string20 Middle {xpath('Middle')};
    string20 Last {xpath('Last')};
    string5 Suffix {xpath('Suffix')};
    string3 Prefix {xpath('Prefix')};
  END;

  EXPORT _lt_row_Name := RECORD  (_lt_Name)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PhonesPlusRecord := RECORD
    string120 ListedName {xpath('ListedName')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string10 PhoneNumber {xpath('PhoneNumber')};
    string4 TimeZone {xpath('TimeZone')};
    string12 PhoneType {xpath('PhoneType')};
    string30 CarrierName {xpath('CarrierName')};
    string25 CarrierCity {xpath('CarrierCity')};
    string2 CarrierState {xpath('CarrierState')};
    DATASET (DiffString) ListingTypes {xpath('ListingTypes/Type'), MAXCOUNT(CONSTANTS.DAW.MAX_LISTING_TYPES * 2)};
  END;

  EXPORT _lt_BusinessIdentity := RECORD
    unsigned6 DotID {xpath('DotID')}; // Xsd type: long
    unsigned6 EmpID {xpath('EmpID')}; // Xsd type: long
    unsigned6 POWID {xpath('POWID')}; // Xsd type: long
    unsigned6 ProxID {xpath('ProxID')}; // Xsd type: long
    unsigned6 SeleID {xpath('SeleID')}; // Xsd type: long
    unsigned6 OrgID {xpath('OrgID')}; // Xsd type: long
    unsigned6 UltID {xpath('UltID')}; // Xsd type: long
  END;

  EXPORT _lt_PL2Action := RECORD
    string8 _Type {xpath('Type')};
    string200 ViolationDescription {xpath('ViolationDescription')};
    _lt_Date ViolationDate {xpath('ViolationDate')};
    _lt_Date EffectiveDate {xpath('EffectiveDate')};
    string200 Description {xpath('Description')};
    string30 Status {xpath('Status')};
    _lt_Date PostingDate {xpath('PostingDate')};
    string50 CaseNumber {xpath('CaseNumber')};
  END;

  EXPORT _lt_PL2Education := RECORD
    string30 School {xpath('School')};
    string15 Degree {xpath('Degree')};
    string25 Curriculum {xpath('Curriculum')};
    string15 DatesAttended {xpath('DatesAttended')};
  END;

  EXPORT _lt_ProfessionalLicenseRecord := RECORD
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string60 LicenseType {xpath('LicenseType')};
    string20 LicenseNumber {xpath('LicenseNumber')};
    integer ProviderNumber {xpath('ProviderNumber')};
    string9 SSN {xpath('SSN')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    string60 ProfessionOrBoard {xpath('ProfessionOrBoard')};
    string45 Status {xpath('Status')};
    _lt_Date StatusEffectiveDate {xpath('StatusEffectiveDate')};
    _lt_Name Name {xpath('Name')};
    _lt_Name OriginalName {xpath('OriginalName')};
    _lt_Name AdditionalOrigName {xpath('AdditionalOrigName')};
    string100 CompanyName {xpath('CompanyName')};
    _lt_Address Address {xpath('Address')};
    _lt_Address OriginalAddress {xpath('OriginalAddress')};
    _lt_Address AdditionalOrigAddress {xpath('AdditionalOrigAddress')};
    string10 Phone {xpath('Phone')};
    string4 TimeZone {xpath('TimeZone')};
    string10 AdditionalPhone {xpath('AdditionalPhone')};
    string8 Gender {xpath('Gender')};
    _lt_Date DOB {xpath('DOB')};
    _lt_Date IssuedDate {xpath('IssuedDate')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
    _lt_Date LastRenewalDate {xpath('LastRenewalDate')};
    string50 LicenseObtainedBy {xpath('LicenseObtainedBy')};
    string1 BoardActionIndicator {xpath('BoardActionIndicator')};
    string20 SourceState {xpath('SourceState')};
    string50 Occupation {xpath('Occupation')};
    integer PracticeHours {xpath('PracticeHours')};
    string50 PracticeType {xpath('PracticeType')};
    string50 Email {xpath('Email')};
    string10 Fax {xpath('Fax')};
    _lt_PL2Action Action {xpath('Action')};
    string75 ContinueEducation {xpath('ContinueEducation')};
    _lt_PL2Education Education1 {xpath('Education1')};
    _lt_PL2Education Education2 {xpath('Education2')};
    _lt_PL2Education Education3 {xpath('Education3')};
    string75 AdditionalLicensingSpecs {xpath('AdditionalLicensingSpecs')};
    string25 PlaceOfBirth {xpath('PlaceOfBirth')};
    string25 Race {xpath('Race')};
    string50 ProlicSeqId {xpath('ProlicSeqId')};
    string15 TaxId {xpath('TaxId')};
  END;

  EXPORT _lt_PeopleAtWorkRecord := RECORD
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string1 ConfidenceLevel {xpath('ConfidenceLevel')};
    boolean Verified {xpath('Verified')};
    _lt_Name Name {xpath('Name')};
    string12 UniqueId {xpath('UniqueId')};
    string35 Title {xpath('Title')};
    string9 SSN {xpath('SSN')};
    string60 EMail {xpath('EMail')};
    string10 Phone10 {xpath('Phone10')};
    string6 Gender {xpath('Gender')};
    string4 TimeZone {xpath('TimeZone')};
    string4 CompanyTimeZone {xpath('CompanyTimeZone')};
    string120 CompanyName {xpath('CompanyName')};
    string35 Department {xpath('Department')};
    string9 FEIN {xpath('FEIN')};
    string12 BusinessId {xpath('BusinessId')};
    _lt_Address Address {xpath('Address')};
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
  END;

  EXPORT _lt_AircraftReportRecordBase := RECORD
    string20 Status {xpath('Status')};
    string8 AircraftNumber {xpath('AircraftNumber')};
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    _lt_Date LastActionDate {xpath('LastActionDate')};
    _lt_Date CertificationDate {xpath('CertificationDate')};
  END;

  EXPORT _lt_AircraftReportRegistrant := RECORD
    string1 _Type {xpath('Type')};
    string50 CompanyName {xpath('CompanyName')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string12 UniqueId {xpath('UniqueId')};//hidden[ecl_only]
    string12 BusinessId {xpath('BusinessId')};//hidden[ecl_only]
  END;

  EXPORT _lt_AircraftReportAircraft := RECORD
    string30 ManufacturerName {xpath('ManufacturerName')};
    string20 ModelName {xpath('ModelName')};
    string7 ModelCode {xpath('ModelCode')};
    string30 SerialNumber {xpath('SerialNumber')};
    integer ManufactureYear {xpath('ManufactureYear')};
    string40 AircraftType {xpath('AircraftType')};
    string20 EngineType {xpath('EngineType')};
    integer Engines {xpath('Engines')};
    integer Seats {xpath('Seats')};
    string20 Category {xpath('Category')};
    string30 Certification {xpath('Certification')};
    string15 Weight {xpath('Weight')};
    string4 CruisingSpeed {xpath('CruisingSpeed')};
  END;

  EXPORT _lt_AircraftReportEngine := RECORD
    string10 ManufacturerName {xpath('ManufacturerName')};
    string20 ModelName {xpath('ModelName')};
    string5 Horsepower {xpath('Horsepower')};
    string6 FuelConsumption {xpath('FuelConsumption')};
  END;

  EXPORT _lt_AircraftReportRecord := RECORD (_lt_AircraftReportRecordBase)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string1 AmateurCertification {xpath('AmateurCertification')};
    _lt_AircraftReportRegistrant Registrant {xpath('Registrant')};
    _lt_AircraftReportAircraft AircraftInfo {xpath('AircraftInfo')};
    _lt_AircraftReportEngine EngineInfo {xpath('EngineInfo')};
  END;

  EXPORT _lt_BaseBpsFAACertification := RECORD (DiffMetaRec)
    _lt_Name Name {xpath('Name')};
    string6 Gender {xpath('Gender')};
    _lt_Address Address {xpath('Address')};
    string10 RecordType {xpath('RecordType')};
    string20 RecordTypeDesc {xpath('RecordTypeDesc')};
    string15 ClassDesc {xpath('ClassDesc')};
    string15 Class {xpath('Class')};
    string20 Region {xpath('Region')};
    _lt_Date DateCertifiedMedical {xpath('DateCertifiedMedical')};
    _lt_Date DateExpiresMedical {xpath('DateExpiresMedical')};
  END;

  EXPORT _lt_FAACertificate := RECORD
    string1 Letter {xpath('Letter')};
    string7 FAAPilotRecordId {xpath('FAAPilotRecordId')};
    string20 _Type {xpath('Type')};
    string20 TypeDesc {xpath('TypeDesc')};
    string45 Level {xpath('Level')};
    string45 LevelDesc {xpath('LevelDesc')};
    _lt_Date DateExpires {xpath('DateExpires')};
    string99 Ratings {xpath('Ratings')};
  END;

  EXPORT _lt_BpsFAACertification := RECORD (_lt_BaseBpsFAACertification)
    dataset(_lt_FAACertificate) Certificates {xpath('Certificates/Certificate'), MAXCOUNT(iesp.Constants.MAX_COUNT_PILOT_CERTIFICATES * 2)};
  END;

  EXPORT _lt_row_BpsFAACertification := RECORD  (_lt_BpsFAACertification)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_WaterCraftDescription := RECORD
    integer Length {xpath('Length')};
    integer Width {xpath('Width')};
    integer Weight {xpath('Weight')};
    string30 Make {xpath('Make')};
    string30 Model {xpath('Model')};
    integer YearMake {xpath('YearMake')};
    string20 HullType {xpath('HullType')};
    string20 Use {xpath('Use')};
    string20 MajorColor {xpath('MajorColor')};
    string20 MinorColor {xpath('MinorColor')};
    string20 PropulsionType {xpath('PropulsionType')};
    string20 FuelType {xpath('FuelType')};
  END;

  EXPORT _lt_WaterCraftDescriptionEx := RECORD (_lt_WaterCraftDescription)
    string6 Breadth {xpath('Breadth')};
    string6 Depth {xpath('Depth')};
    string7 GrossTons {xpath('GrossTons')};
    string7 NetTons {xpath('NetTons')};
  END;

  EXPORT _lt_WaterCraftRegistration := RECORD
    string40 Status {xpath('Status')};
    string20 Number {xpath('Number')};
    _lt_Date IssueDate {xpath('IssueDate')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
  END;

  EXPORT _lt_WaterCraftTitle := RECORD
    string2 State {xpath('State')};
    string40 Status {xpath('Status')};
    string20 Number {xpath('Number')};
    string20 _Type {xpath('Type')};
    _lt_Date IssueDate {xpath('IssueDate')};
  END;

  EXPORT _lt_WaterCraftPurchase := RECORD
    _lt_Date Date {xpath('Date')};
    integer Price {xpath('Price')};
    string40 Dealer {xpath('Dealer')};
    string2 StatePurchased {xpath('StatePurchased')};
  END;

  EXPORT _lt_WaterCraftAddress := RECORD
    string50 City {xpath('City')};
    string2 State {xpath('State')};
    string50 Province {xpath('Province')};
    string64 Country {xpath('Country')};
  END;

  EXPORT _lt_WaterCraftManufacture := RECORD
    string50 ShipYard {xpath('ShipYard')};
    integer YearBuilt {xpath('YearBuilt')};
    string50 HailingPort {xpath('HailingPort')};
    _lt_WaterCraftAddress HailingPortAddress {xpath('HailingPortAddress')};
    _lt_WaterCraftAddress HullBuildAddress {xpath('HullBuildAddress')};
    _lt_WaterCraftAddress CompleteBuildAddress {xpath('CompleteBuildAddress')};
  END;

  EXPORT _lt_WaterCraftLienHolder := RECORD
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
  END;

  EXPORT _lt_WaterCraftEngine := RECORD
    integer HorsePower {xpath('HorsePower')};
    string20 Make {xpath('Make')};
    string20 Model {xpath('Model')};
  END;

  EXPORT _lt_BaseWaterCraftReportRecord := RECORD
    _lt_WaterCraftDescriptionEx Description {xpath('Description')};
    _lt_WaterCraftRegistration Registration {xpath('Registration')};
    _lt_WaterCraftTitle Title {xpath('Title')};
    _lt_WaterCraftPurchase Purchase {xpath('Purchase')};
    _lt_WaterCraftManufacture Manufacture {xpath('Manufacture')};
    string2 StateOfOrigin {xpath('StateOfOrigin')};
    string25 StateOfOriginName {xpath('StateOfOriginName')};
    string30 HullNumber {xpath('HullNumber')};
    string50 VesselName {xpath('VesselName')};
    string10 RecordType {xpath('RecordType')};
    string10 VesselNumber {xpath('VesselNumber')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    boolean NonDMVSource {xpath('NonDMVSource')};
    dataset(_lt_WaterCraftLienHolder) LienHolders {xpath('LienHolders/LienHolder'), MAXCOUNT(iesp.Constants.WATERCRAFTS.MaxLienholders * 2)};
    dataset(_lt_WaterCraftEngine) Engines {xpath('Engines/Engine'), MAXCOUNT(iesp.Constants.WATERCRAFTS.MaxEngines * 2)};
  END;

  EXPORT _lt_WaterCraftOwner := RECORD
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string9 SSN {xpath('SSN')};
    _lt_Date DOB {xpath('DOB')};
    string60 CompanyName {xpath('CompanyName')};
    string12 UniqueId {xpath('UniqueId')};
  END;

  EXPORT _lt_WaterCraftReportRecord := RECORD (_lt_BaseWaterCraftReportRecord)
    dataset(_lt_WaterCraftOwner) Owners {xpath('Owners/Owner'), MAXCOUNT(iesp.Constants.WATERCRAFTS.MaxOwners * 2)};
  END;

  EXPORT _lt_UCCParsedParty := RECORD
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string12 BusinessId {xpath('BusinessId')};
    string12 UniqueId {xpath('UniqueId')};
    _lt_Name Name {xpath('Name')};
    string120 CompanyName {xpath('CompanyName')};
    string9 SSN {xpath('SSN')};
    string10 FEIN {xpath('FEIN')};
    string45 IncorporatedState {xpath('IncorporatedState')};
    string30 CorporateNumber {xpath('CorporateNumber')};
    string30 CorporateType {xpath('CorporateType')};
  END;

  EXPORT _lt_AddressWithRawInfo := RECORD (_lt_Address)
    string OrigStreetAddress1 {xpath('OrigStreetAddress1'), maxlength(128)};
    string OrigStreetAddress2 {xpath('OrigStreetAddress2'), maxlength(128)};
  END;

  EXPORT _lt_row_AddressWithRawInfo := RECORD  (_lt_AddressWithRawInfo)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_UniversalAndRawAddress := RECORD (_lt_Address)
    string30 Country {xpath('Country')};
    string30 Province {xpath('Province')};
    boolean IsForeign {xpath('IsForeign')};
    string OrigStreetAddress1 {xpath('OrigStreetAddress1'), maxlength(128)};
    string OrigStreetAddress2 {xpath('OrigStreetAddress2'), maxlength(128)};
  END;

  EXPORT _lt_UCCPerson := RECORD
    string120 OriginName {xpath('OriginName')};
    string IsDisputed {xpath('IsDisputed')};
    dataset(_lt_UCCParsedParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.UCCF.MaxPersonParsedParties * 2)};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(Constants.UCCF.MaxPersonAddresses * 2)};
    dataset(_lt_AddressWithRawInfo) Addresses2 {xpath('Addresses2/Address'), MAXCOUNT(Constants.UCCF.MaxPersonAddresses * 2)};
    dataset(_lt_UniversalAndRawAddress) Addresses3 {xpath('Addresses3/Address'), MAXCOUNT(Constants.UCCF.MaxPersonAddresses * 2)};
  END;

  EXPORT _lt_UniversalAddress := RECORD (_lt_Address)
    string30 Country {xpath('Country')};
    string30 Province {xpath('Province')};
    boolean IsForeign {xpath('IsForeign')};
  END;

  EXPORT _lt_UCCReport2Person := RECORD
    string120 OriginName {xpath('OriginName')};
    dataset(_lt_UCCParsedParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.UCCF.MaxPersonParsedParties * 2)};
    dataset(_lt_UniversalAndRawAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.UCCF.MaxPersonAddresses * 2)};
  END;

  EXPORT _lt_UCCCollateral := RECORD
    string512 Description {xpath('Description')};
    string5 Count {xpath('Count')};
    string50 PropertyDescription {xpath('PropertyDescription')};
    string60 Address {xpath('Address')};
    string30 SerialNumber {xpath('SerialNumber')};
  END;

  EXPORT _lt_UCCReport2Collateral := RECORD (_lt_UCCCollateral)
    string145 PrimaryMachine {xpath('PrimaryMachine')};
    string145 SecondMachine {xpath('SecondMachine')};
    string5 ManufacturerCode {xpath('ManufacturerCode')};
    string120 Manufacturer {xpath('Manufacturer')};
    integer ModelYear {xpath('ModelYear')};
    string15 Model {xpath('Model')};
    string50 ModelDesc {xpath('ModelDesc')};
    integer ManufacturedYear {xpath('ManufacturedYear')};
    string9 Borough {xpath('Borough')};
    string5 Block {xpath('Block')};
    string4 Lot {xpath('Lot')};
    string1 AirRights {xpath('AirRights')};
    string1 SubterraneanRights {xpath('SubterraneanRights')};
    string1 Easement {xpath('Easement')};
    string1 NewUsed {xpath('NewUsed')};
  END;

  EXPORT _lt_UCCSigner := RECORD
    string75 Name {xpath('Name')};
    string60 Title {xpath('Title')};
  END;

  EXPORT _lt_UCCFiling := RECORD
    string8 FilingStatus {xpath('FilingStatus')};
    string14 Number {xpath('Number')};
    string40 _Type {xpath('Type')};
    _lt_Date Date {xpath('Date')};
    string4 Time {xpath('Time')};
    string3 Pages {xpath('Pages')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
    string17 Amount {xpath('Amount')};
    string9 ContractType {xpath('ContractType')};
    _lt_Date EffectiveDate {xpath('EffectiveDate')};
    string30 SerialNumber {xpath('SerialNumber')};
  END;

  EXPORT _lt_UCCReport2Filing := RECORD (_lt_UCCFiling)
    string1 FilingNumberIndicator {xpath('FilingNumberIndicator')};
    _lt_Date VendorEntryDate {xpath('VendorEntryDate')};
    _lt_Date VendorUpdateDate {xpath('VendorUpdateDate')};
    string8 ContinuousExpiration {xpath('ContinuousExpiration')};
    string3 StatementsFiled {xpath('StatementsFiled')};
    string17 MicrofilmNumber {xpath('MicrofilmNumber')};
  END;

  EXPORT _lt_UCCFilingOffice := RECORD
    string120 FilingAgency {xpath('FilingAgency')};
    _lt_Address Address {xpath('Address')};
    _lt_UniversalAddress Address2 {xpath('Address2')};
  END;

  EXPORT _lt_UCCReport2Record := RECORD
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string31 TMSId {xpath('TMSId')};
    string3 FilingJurisdiction {xpath('FilingJurisdiction')};
    string25 FilingJurisdictionName {xpath('FilingJurisdictionName')};
    string20 OriginFilingNumber {xpath('OriginFilingNumber')};
    string40 OriginFilingType {xpath('OriginFilingType')};
    _lt_Date OriginFilingDate {xpath('OriginFilingDate')};
    string4 OriginFilingTime {xpath('OriginFilingTime')};
    string8 FilingStatus {xpath('FilingStatus')};
    string500 Comment {xpath('Comment')};
    _lt_Date CommentEffectiveDate {xpath('CommentEffectiveDate')};
    dataset(_lt_UCCReport2Person) Debtors2 {xpath('Debtors2/Debtor'), MAXCOUNT(iesp.Constants.UCCF.MaxDebtors * 2)};
    dataset(_lt_UCCReport2Person) Creditors2 {xpath('Creditors2/Creditor'), MAXCOUNT(iesp.Constants.UCCF.MaxCreditors * 2)};
    dataset(_lt_UCCReport2Person) Secureds2 {xpath('Secureds2/Secured'), MAXCOUNT(iesp.Constants.UCCF.MaxSecureds * 2)};
    dataset(_lt_UCCReport2Person) Assignees2 {xpath('Assignees2/Assignee'), MAXCOUNT(iesp.Constants.UCCF.MaxAssignees * 2)};
    dataset(_lt_UCCReport2Collateral) Collaterals2 {xpath('Collaterals2/Collateral'), MAXCOUNT(iesp.Constants.UCCF.MaxCollaterals * 2)};
    dataset(_lt_UCCSigner) Signers {xpath('Signers/Signer'), MAXCOUNT(iesp.Constants.UCCF.MaxSigners * 2)};
    dataset(_lt_UCCReport2Filing) Filings2 {xpath('Filings2/Filing'), MAXCOUNT(iesp.Constants.UCCF.MaxFilings * 2)};
    dataset(_lt_UCCFilingOffice) FilingOffices {xpath('FilingOffices/Office'), MAXCOUNT(iesp.Constants.UCCF.MaxFilingOffices * 2)};
  END;

  EXPORT _lt_SexOffReportPoliceAgency := RECORD
    string50 Name {xpath('Name')};
    string35 ContactName {xpath('ContactName')};
    _lt_Address Address {xpath('Address')};
    string10 Phone {xpath('Phone')};
  END;

  EXPORT _lt_SexOffReportSchool := RECORD
    string55 Name {xpath('Name')};
    string55 Address1 {xpath('Address1')};
    string35 Address2 {xpath('Address2')};
    string35 Address3 {xpath('Address3')};
    string35 Address4 {xpath('Address4')};
    string35 Address5 {xpath('Address5')};
    string35 County {xpath('County')};
  END;

  EXPORT _lt_SexOffReportEmployer := RECORD
    string55 Name {xpath('Name')};
    string55 Address1 {xpath('Address1')};
    string35 Address2 {xpath('Address2')};
    string35 Address3 {xpath('Address3')};
    string35 Address4 {xpath('Address4')};
    string35 Address5 {xpath('Address5')};
    string35 County {xpath('County')};
  END;

  EXPORT _lt_SexOffReportRegistration := RECORD
    string25 _Type {xpath('Type')};
    _lt_Date Date1 {xpath('Date1')};
    string28 Date1Type {xpath('Date1Type')};
    _lt_Date Date2 {xpath('Date2')};
    string28 Date2Type {xpath('Date2Type')};
    _lt_Date Date3 {xpath('Date3')};
    string28 Date3Type {xpath('Date3Type')};
    string125 Address1 {xpath('Address1')};
    string45 Address2 {xpath('Address2')};
    string35 Address3 {xpath('Address3')};
    string35 Address4 {xpath('Address4')};
    string35 Address5 {xpath('Address5')};
    string35 County {xpath('County')};
  END;

  EXPORT _lt_SexOffReportVehicle := RECORD
    integer2 Year {xpath('Year')};
    string40 Color {xpath('Color')};
    string40 MakeModel {xpath('MakeModel')};
    string40 Plate {xpath('Plate')};
    string30 State {xpath('State')};
  END;

  EXPORT _lt_SexOffRecordPhysicalCharacteristics := RECORD
    string3 Age {xpath('Age')};
    string30 Race {xpath('Race')};
    string30 Ethnicity {xpath('Ethnicity')};
    string10 Sex {xpath('Sex')};
    string40 HairColor {xpath('HairColor')};
    string40 EyeColor {xpath('EyeColor')};
    string3 Height {xpath('Height')};
    string3 Weight {xpath('Weight')};
    string20 SkinTone {xpath('SkinTone')};
    string30 BuildType {xpath('BuildType')};
    string200 ScarsMarksTattoos {xpath('ScarsMarksTattoos')};
    string6 ShoeSize {xpath('ShoeSize')};
    boolean CorrectiveLenseFlag {xpath('CorrectiveLenseFlag')};
  END;

  EXPORT _lt_SexOffRecordIdNumbers := RECORD
    string30 OffenderId {xpath('OffenderId')};
    string30 DocNumber {xpath('DocNumber')};
    string30 SORNumber {xpath('SORNumber')};
    string30 StateIdNumber {xpath('StateIdNumber')};
    string30 FBINumber {xpath('FBINumber')};
    string30 NCICNumber {xpath('NCICNumber')};
  END;

  EXPORT _lt_OffenderAddress := RECORD
    string5 AddressType {xpath('AddressType')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    _lt_Address Address {xpath('Address')};
  END;

  EXPORT _lt_OffenderBestAddress := RECORD (_lt_OffenderAddress)
    boolean BestAddressIsNewer {xpath('BestAddressIsNewer')};
    boolean BestAddressIsDifferent {xpath('BestAddressIsDifferent')};
  END;

  EXPORT _lt_BaseSexOffReportRecord := RECORD
    string60 PrimaryKey {xpath('PrimaryKey')};
    string10 RecordType {xpath('RecordType')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string9 SSN {xpath('SSN')};
    string9 OrigSSN {xpath('OrigSSN')};
    string12 UniqueId {xpath('UniqueId')};
    _lt_Date DOB {xpath('DOB')};
    _lt_Date DOB2 {xpath('DOB2')};
    string3 Age {xpath('Age')};//hidden[internal]
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    _lt_Date DateOffenderLastUpdated {xpath('DateOffenderLastUpdated')};//hidden[internal]
    string30 StateOfOrigin {xpath('StateOfOrigin')};
    string2 OriginStateCode {xpath('OriginStateCode')};
    string50 OffenderStatus {xpath('OffenderStatus')};
    string40 OffenderCategory {xpath('OffenderCategory')};
    string10 RiskLevelCode {xpath('RiskLevelCode')};
    string50 RiskDescription {xpath('RiskDescription')};
    _lt_SexOffReportPoliceAgency PoliceAgency {xpath('PoliceAgency')};
    _lt_SexOffReportSchool School {xpath('School')};
    _lt_SexOffReportEmployer Employer {xpath('Employer')};
    _lt_SexOffReportRegistration Registration {xpath('Registration')};
    _lt_SexOffReportVehicle Vehicle1 {xpath('Vehicle1')};
    _lt_SexOffReportVehicle Vehicle2 {xpath('Vehicle2')};
    _lt_SexOffRecordPhysicalCharacteristics PhysicalCharacteristics {xpath('PhysicalCharacteristics')};
    _lt_SexOffRecordIdNumbers IdNumbers {xpath('IdNumbers')};
    string30 DriverLicenseNumber {xpath('DriverLicenseNumber')};
    string30 DriverLicenseState {xpath('DriverLicenseState')};
    string140 AdditionalComment1 {xpath('AdditionalComment1')};
    string140 AdditionalComment2 {xpath('AdditionalComment2')};
    string150 ImageLink {xpath('ImageLink')};//hidden[internal]
    _lt_OffenderBestAddress BestAddress {xpath('BestAddress')};//hidden[internal]
    dataset(_lt_Name) AKAs {xpath('AKAs/AKA'), MAXCOUNT(iesp.Constants.SEXOFF_MAX_COUNT_AKAS * 2)};
  END;

  EXPORT _lt_SexOffReportConviction := RECORD
    string80 ConvictionJurisdiction {xpath('ConvictionJurisdiction')};
    _lt_Date ConvictionDate {xpath('ConvictionDate')};
    string30 CourtName {xpath('CourtName')};
    string25 CourtCaseNumber {xpath('CourtCaseNumber')};
    _lt_Date OffenseDate {xpath('OffenseDate')};
    string20 OffenseCodeOrStatute {xpath('OffenseCodeOrStatute')};
    string500 OffenseDescription {xpath('OffenseDescription')};
    string20 OffenseCategory {xpath('OffenseCategory')};//hidden[internal]
    boolean VictimIsMinor {xpath('VictimIsMinor')};
    integer1 VictimAge {xpath('VictimAge')};
    string10 VictimGender {xpath('VictimGender')};
    string30 VictimRelationship {xpath('VictimRelationship')};
    string360 SentenceDescription {xpath('SentenceDescription')};
    string1 VictimIsMinor2 {xpath('VictimIsMinor2')}; 
  END;

  EXPORT _lt_SexOffReportRecord := RECORD (_lt_BaseSexOffReportRecord)
    dataset(_lt_SexOffReportConviction) Convictions {xpath('Convictions/Conviction'), MAXCOUNT(iesp.Constants.SEXOFF_MAX_COUNT_CONVICTIONS * 2)};
    boolean IsAccurintData {xpath('IsAccurintData')};//hidden[internal]
  END;

  EXPORT _lt_BaseCrimReportRecord := RECORD
    string OffenderId {xpath('OffenderId')};
    string35 CaseNumber {xpath('CaseNumber')};
    string30 CountyOfOrigin {xpath('CountyOfOrigin')};
    string10 DOCNumber {xpath('DOCNumber')};
    _lt_Date CaseFilingDate {xpath('CaseFilingDate')};
    string15 Eyes {xpath('Eyes')};
    string15 Hair {xpath('Hair')};
    string3 Height {xpath('Height')};
    string3 Weight {xpath('Weight')};
    string30 Race {xpath('Race')};
    string7 Sex {xpath('Sex')};
    string15 Skin {xpath('Skin')};
    string45 DataSource {xpath('DataSource')};
    string9 SSN {xpath('SSN')};
    string12 UniqueId {xpath('UniqueId')};
    string25 StateOfBirth {xpath('StateOfBirth')};
    string25 StateOfOrigin {xpath('StateOfOrigin')};
    string60 Status {xpath('Status')};
    _lt_Address Address {xpath('Address')};
    _lt_Name Name {xpath('Name')};
    _lt_Date DOB {xpath('DOB')};
    boolean isImageAvailable {xpath('isImageAvailable')};//hidden[internal]
    string99 CaseTypeDescription {xpath('CaseTypeDescription')};
    dataset(_lt_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(iesp.constants.CRIM.MaxAKAs * 2)};
  END;

  EXPORT _lt_CrimReportAppeal := RECORD
    _lt_Date Date {xpath('Date')};
    string40 Disposition {xpath('Disposition')};
    string40 FinalDisposition {xpath('FinalDisposition')};
  END;

  EXPORT _lt_CrimReportArrest := RECORD
    string50 Agency {xpath('Agency')};
    string35 CaseNumber {xpath('CaseNumber')};
    _lt_Date Date {xpath('Date')};
    string125 Disposition {xpath('Disposition')};
    _lt_Date DispositionDate {xpath('DispositionDate')};
    string35 Level {xpath('Level')};
    string125 Offense {xpath('Offense')};
    string70 Statute {xpath('Statute')};
    string30 _Type {xpath('Type')};
  END;

  EXPORT _lt_CrimReportCourt := RECORD
    string35 CaseNumber {xpath('CaseNumber')};
    string8 Costs {xpath('Costs')};
    string40 Description {xpath('Description')};
    string80 Disposition {xpath('Disposition')};
    _lt_Date DispositionDate {xpath('DispositionDate')};
    string9 Fine {xpath('Fine')};
    string35 Level {xpath('Level')};
    string125 Offense {xpath('Offense')};
    string30 Plea {xpath('Plea')};
    string70 Statute {xpath('Statute')};
    string9 SuspendedFine {xpath('SuspendedFine')};
  END;

  EXPORT _lt_CrimReportCourtSentence := RECORD
    string50 Jail {xpath('Jail')};
    string50 Probation {xpath('Probation')};
    string50 Suspended {xpath('Suspended')};
  END;

  EXPORT _lt_CrimReportOffense := RECORD
    string1 AdjudicationWithheld {xpath('AdjudicationWithheld')};
    string35 CaseNumber {xpath('CaseNumber')};
    string99 CaseType {xpath('CaseType')};
    string99 CaseTypeDescription {xpath('CaseTypeDescription')};
    string99 Count {xpath('Count')};
    string30 County {xpath('County')};
    string99 Description {xpath('Description')};
    string35 MaximumTerm {xpath('MaximumTerm')};
    string35 MinimumTerm {xpath('MinimumTerm')};
    string3 NumberCounts {xpath('NumberCounts')};
    _lt_Date OffenseDate {xpath('OffenseDate')};
    string1 OffenseType {xpath('OffenseType')};
    string99 Sentence {xpath('Sentence')};
    string50 SentenceLengthDescription {xpath('SentenceLengthDescription')};
    _lt_Date SentenceDate {xpath('SentenceDate')};
    _lt_Date IncarcerationDate {xpath('IncarcerationDate')};
    _lt_CrimReportAppeal Appeal {xpath('Appeal')};
    _lt_CrimReportArrest Arrest {xpath('Arrest')};
    _lt_CrimReportCourt Court {xpath('Court')};
    _lt_CrimReportCourtSentence CourtSentence {xpath('CourtSentence')};
  END;

  EXPORT _lt_CrimReportPrison := RECORD
    _lt_Date AdmittedDate {xpath('AdmittedDate')};
    string50 CurrentStatus {xpath('CurrentStatus')};
    string99 CustodyType {xpath('CustodyType')};
    _lt_Date CustodyTypeChangeDate {xpath('CustodyTypeChangeDate')};
    string3 GainTimeGranted {xpath('GainTimeGranted')};
    _lt_Date LastGainTime {xpath('LastGainTime')};
    string99 Location {xpath('Location')};
    _lt_Date ScheduledReleaseDate {xpath('ScheduledReleaseDate')};
    string60 Sentence {xpath('Sentence')};
  END;

  EXPORT _lt_CrimReportParole := RECORD
    _lt_Date ActualEndDate {xpath('ActualEndDate')};
    string18 County {xpath('County')};
    string50 CurrentStatus {xpath('CurrentStatus')};
    string60 Length {xpath('Length')};
    _lt_Date ScheduledEndDate {xpath('ScheduledEndDate')};
    _lt_Date StartDate {xpath('StartDate')};
  END;

  EXPORT _lt_TimeStamp := RECORD (_lt_Date)
    integer2 Hour24 {xpath('Hour24')};
    integer2 Minute {xpath('Minute')};
    integer2 Second {xpath('Second')};
  END;

  EXPORT _lt_Duration := RECORD
    integer2 Years {xpath('Years')};
    integer2 Months {xpath('Months')};
    integer2 Days {xpath('Days')};
  END;

  EXPORT _lt_CrimReportParoleOffense := RECORD
    _lt_Date SentenceDate {xpath('SentenceDate')};
    integer Length {xpath('Length')};
    string13 OffenseCounty {xpath('OffenseCounty')};
    string35 CauseNo {xpath('CauseNo')};
    string20 NCICCode {xpath('NCICCode')};
    integer OffenseCount {xpath('OffenseCount')};
    _lt_Date OffenseDate {xpath('OffenseDate')};
  END;

  EXPORT _lt_CrimReportParoleEx := RECORD (_lt_CrimReportParole)
    _lt_Date DateReported {xpath('DateReported')};
    string10 PubicSaftyId {xpath('PubicSaftyId')};
    string10 InmateId {xpath('InmateId')};
    string15 ParoleInAbsentiaId {xpath('ParoleInAbsentiaId')};
    _lt_Name Name {xpath('Name')};
    string1 Race {xpath('Race')};
    string1 Gender {xpath('Gender')};
    _lt_Date DOB {xpath('DOB')};
    string13 CountyOfBirth {xpath('CountyOfBirth')};
    string25 StateOfBirth {xpath('StateOfBirth')};
    integer HeightFeet {xpath('HeightFeet')};
    integer HeightInches {xpath('HeightInches')};
    integer WeightInPounds {xpath('WeightInPounds')};
    string3 HairColor {xpath('HairColor')};
    string3 SkinColor {xpath('SkinColor')};
    string3 EyeColor {xpath('EyeColor')};
    string2 PrisonFacilityType {xpath('PrisonFacilityType')};
    string15 PrisonFacilityName {xpath('PrisonFacilityName')};
    _lt_Date AdmittedDate {xpath('AdmittedDate')};
    string1 PrisonStatus {xpath('PrisonStatus')};
    string2 LastReceiveOrDepartCode {xpath('LastReceiveOrDepartCode')};
    _lt_Date LastReceiveOrDepartCDate {xpath('LastReceiveOrDepartCDate')};
    _lt_TimeStamp RecordCreatedTimeStamp {xpath('RecordCreatedTimeStamp')};
    string1 CurrentStatusFlag {xpath('CurrentStatusFlag')};
    _lt_Date CurrentStatusEffectiveDate {xpath('CurrentStatusEffectiveDate')};
    string2 ParoleRegion {xpath('ParoleRegion')};
    string30 SupervisingOffice {xpath('SupervisingOffice')};
    string30 SupervisingOfficerName {xpath('SupervisingOfficerName')};
    string14 SupervisingOfficerPhone {xpath('SupervisingOfficerPhone')};
    _lt_Address LastKnownResidence {xpath('LastKnownResidence')};
    _lt_Date ReleaseArrivalDate {xpath('ReleaseArrivalDate')};
    string4 ReleaseType {xpath('ReleaseType')};
    string13 ReleaseCounty {xpath('ReleaseCounty')};
    string13 LegalResidenceCounty {xpath('LegalResidenceCounty')};
    _lt_Date LastParoleReviewDate {xpath('LastParoleReviewDate')};
    integer OffenseCount {xpath('OffenseCount')};
    boolean Is3GOffender {xpath('Is3GOffender')};
    boolean IsViolentOffender {xpath('IsViolentOffender')};
    boolean IsSexOffender {xpath('IsSexOffender')};
    boolean IsOnViolentOffenderProgram {xpath('IsOnViolentOffenderProgram')};
    _lt_Duration LongestTimeToServe {xpath('LongestTimeToServe')};
    string50 LongestTimeToServeDescription {xpath('LongestTimeToServeDescription')};
    _lt_Date DischargeDate {xpath('DischargeDate')};
    DATASET (DiffString) ScarsMarksTattoos {xpath('ScarsMarksTattoos/SMT'), MAXCOUNT(iesp.Constants.crim.MaxScarsMarksTattoos * 2)};
    dataset(_lt_CrimReportParoleOffense) Offenses {xpath('Offenses/Offense'), MAXCOUNT(iesp.Constants.crim.MaxParOffenses * 2)};
  END;

  EXPORT _lt_CrimReportEvent := RECORD
    _lt_Date Date {xpath('Date')};
    string101 Description {xpath('Description')};
  END;

  EXPORT _lt_CrimReportRecord := RECORD (_lt_BaseCrimReportRecord)
    dataset(_lt_CrimReportOffense) Offenses {xpath('Offenses/Offense'), MAXCOUNT(iesp.constants.CRIM.MaxOffenses * 2)};
    dataset(_lt_CrimReportPrison) PrisonSentences {xpath('PrisonSentences/PrisonSentence'), MAXCOUNT(iesp.constants.CRIM.MaxPrisons * 2)};
    dataset(_lt_CrimReportParoleEx) ParoleSentences {xpath('ParoleSentences/ParoleSentence'), MAXCOUNT(iesp.constants.CRIM.MaxParoles * 2)};
    dataset(_lt_CrimReportEvent) Activities {xpath('Activities/Activity'), MAXCOUNT(iesp.constants.CRIM.MaxEvents * 2)};
    boolean IsAccurintData {xpath('IsAccurintData')};//hidden[internal]
  END;

  EXPORT _lt_CCWPermit := RECORD
    string15 PermitNumber {xpath('PermitNumber')};
    string46 PermitType {xpath('PermitType')};
    string15 WeaponType {xpath('WeaponType')};
    _lt_Date RegistrationDate {xpath('RegistrationDate')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
  END;

  EXPORT _lt_WeaponRecord := RECORD
    string2 StateCode {xpath('StateCode')};
    string25 StateName {xpath('StateName')};
    string30 Occupation {xpath('Occupation')};
    string6 Sex {xpath('Sex')};
    string9 SSN {xpath('SSN')};
    string12 UniqueId {xpath('UniqueId')};
    string20 Race {xpath('Race')};
    _lt_CCWPermit Permit {xpath('Permit')};
    _lt_Date DOB {xpath('DOB')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
  END;

  EXPORT _lt_HuntFishRecord := RECORD (DiffMetaRec)
    integer _Penalty {xpath('Penalty')};//hidden[ecldev]
    boolean AlsoFound {xpath('AlsoFound')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    _lt_Address MailAddress {xpath('MailAddress')};
    _lt_Date LicenseDate {xpath('LicenseDate')};
    _lt_Date DOB {xpath('DOB')};
    string15 LicenseNumber {xpath('LicenseNumber')};
    string20 LicenseType {xpath('LicenseType')};
    string20 LicenseState {xpath('LicenseState')};
    string20 HomeState {xpath('HomeState')};
    string30 Occupation {xpath('Occupation')};
    string6 Sex {xpath('Sex')};
    string9 SSN {xpath('SSN')};
    string12 UniqueId {xpath('UniqueId')};
    string20 Race {xpath('Race')};
  END;

  EXPORT _lt_row_HuntFishRecord := RECORD  (_lt_HuntFishRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_CriminalIndicators := RECORD (DiffMetaRec)
    boolean HasCriminalConviction {xpath('HasCriminalConviction')};//hidden[internal]
    boolean IsSexualOffender {xpath('IsSexualOffender')};//hidden[internal]
  END;

  EXPORT _lt_FirearmRecord := RECORD (_lt_CriminalIndicators)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    integer _Penalty {xpath('Penalty')};//hidden[ecldev]
    boolean AlsoFound {xpath('AlsoFound')};
    string2 LicenseIssueState {xpath('LicenseIssueState')};
    string15 LicenseNumber {xpath('LicenseNumber')};
    string64 LicenseType {xpath('LicenseType')};
    _lt_Date LicenseExpireDate {xpath('LicenseExpireDate')};
    _lt_Name LicenseName {xpath('LicenseName')};
    string51 RawLicenseName {xpath('RawLicenseName')};
    string51 LicenseCompany {xpath('LicenseCompany')};
    string51 TradeName {xpath('TradeName')};
    string9 SSN {xpath('SSN')};
    _lt_Address MailingAddress {xpath('MailingAddress')};
    _lt_Address PremiseAddress {xpath('PremiseAddress')};
    string10 BusinessPhone {xpath('BusinessPhone')};
    string10 IRSRegion {xpath('IRSRegion')};
    string9 LicenseRegion {xpath('LicenseRegion')};
    string18 CountyName {xpath('CountyName')};
    string12 UniqueId {xpath('UniqueId')};
    dataset(_lt_Name) LicenseNames {xpath('LicenseNames/Name'), MAXCOUNT(2 * 2)};
  END;

  EXPORT _lt_row_FirearmRecord := RECORD  (_lt_FirearmRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_DEAControlledSubstanceRecord := RECORD (_lt_CriminalIndicators)
    string9 SSN {xpath('SSN')};
    string40 CompanyName {xpath('CompanyName')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string20 BusinessType {xpath('BusinessType')};
    string16 DrugSchedules {xpath('DrugSchedules')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
    string255 ExternalKey {xpath('ExternalKey')};
  END;

  EXPORT _lt_row_DEAControlledSubstanceRecord := RECORD  (_lt_DEAControlledSubstanceRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_DEAControlledSubstanceSearch2Record := RECORD (DiffMetaRec)
    boolean AlsoFound {xpath('AlsoFound')};
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string9 RegistrationNumber {xpath('RegistrationNumber')};
    dataset(_lt_DEAControlledSubstanceRecord) ControlledSubstancesInfo {xpath('ControlledSubstancesInfo/ControlledSubstanceInfo'), MAXCOUNT(iesp.constants.MAX_COUNT_DEA_REGISTRATION * 2)};
  END;

  EXPORT _lt_row_DEAControlledSubstanceSearch2Record := RECORD  (_lt_DEAControlledSubstanceSearch2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_VoterBaseRecord2 := RECORD (DiffMetaRec)
    boolean AlsoFound {xpath('AlsoFound')};
    string12 VoterRecordId {xpath('VoterRecordId')};
    string12 UniqueId {xpath('UniqueId')};
    string9 SSN {xpath('SSN')};
    _lt_Name Name {xpath('Name')};
    _lt_Date DOB {xpath('DOB')};
    string30 Occupation {xpath('Occupation')};
    string25 Race {xpath('Race')};
    string7 Gender {xpath('Gender')};
    _lt_Date RegistrationDate {xpath('RegistrationDate')};
    _lt_Date LastVoteDate {xpath('LastVoteDate')};
    string25 PoliticalParty {xpath('PoliticalParty')};
    string50 VoterStatus {xpath('VoterStatus')};
    string20 ActiveOrInactive {xpath('ActiveOrInactive')};
    string1 ActiveOrInactiveFlag {xpath('ActiveOrInactiveFlag')};
    string2 RegistrateState {xpath('RegistrateState')};
    string35 RegistrateStateName {xpath('RegistrateStateName')};
    _lt_Address ResidentAddress {xpath('ResidentAddress')};
    _lt_Address MailingAddress {xpath('MailingAddress')};
  END;

  EXPORT _lt_VoterDistrictInfo := RECORD
    string5 TownCode {xpath('TownCode')};
    string5 DistrictCode {xpath('DistrictCode')};
    string5 CountyCode {xpath('CountyCode')};
    string5 SchoolCode {xpath('SchoolCode')};
    string1 PrecinctType {xpath('PrecinctType')};
    string20 SpecialDistrict1 {xpath('SpecialDistrict1')};
    string20 SpecialDistrict2 {xpath('SpecialDistrict2')};
    string7 Precinct1 {xpath('Precinct1')};
    string7 Precinct2 {xpath('Precinct2')};
    string7 Precinct3 {xpath('Precinct3')};
    string7 VillagePrecinct {xpath('VillagePrecinct')};
    string7 SchoolPrecinct {xpath('SchoolPrecinct')};
    string7 Ward {xpath('Ward')};
    string7 PrecinctCityOrTown {xpath('PrecinctCityOrTown')};
    string7 AdvisoryNeigborCommissioner {xpath('AdvisoryNeigborCommissioner')};
    string4 CityConcilDistrict {xpath('CityConcilDistrict')};
    string4 CountCommonDistric {xpath('CountCommonDistric')};
    string3 StateHouseInfo {xpath('StateHouseInfo')};
    string3 StateSenateInfo {xpath('StateSenateInfo')};
    string3 USHouseOfRepresentativesInfo {xpath('USHouseOfRepresentativesInfo')};
    string4 ElementarySchoolDistrict {xpath('ElementarySchoolDistrict')};
    string4 SchoolDistrict {xpath('SchoolDistrict')};
    string4 CommunityCollegeDistrict {xpath('CommunityCollegeDistrict')};
    string4 Municipal {xpath('Municipal')};
    string4 VillageDistrict {xpath('VillageDistrict')};
    string4 PoliceJurisdiction {xpath('PoliceJurisdiction')};
    string4 PoliceDistrict {xpath('PoliceDistrict')};
    string4 PublicServiceCommission {xpath('PublicServiceCommission')};
    string4 RescureSquad {xpath('RescureSquad')};
    string4 FireDepartment {xpath('FireDepartment')};
    string4 SanitaryDepartment {xpath('SanitaryDepartment')};
    string4 SewerDistrict {xpath('SewerDistrict')};
    string4 WaterDistrict {xpath('WaterDistrict')};
    string4 MosquitoDistrict {xpath('MosquitoDistrict')};
    string4 TaxationDistrict {xpath('TaxationDistrict')};
    string4 SupremeCourt {xpath('SupremeCourt')};
    string4 JusticeOfPeace {xpath('JusticeOfPeace')};
    string4 JudicialDistrict {xpath('JudicialDistrict')};
    string4 SuperiorCourtDistrict {xpath('SuperiorCourtDistrict')};
    string4 CourtOfAppeals {xpath('CourtOfAppeals')};
    string3 CongressionalDistrict {xpath('CongressionalDistrict')};
  END;

  EXPORT _lt_VotingHistory := RECORD
    string4 VotedYear {xpath('VotedYear')};
    string2 Primary {xpath('Primary')};
    string2 Special1 {xpath('Special1')};
    string2 Special2 {xpath('Special2')};
    string2 General {xpath('General')};
    string2 PresidentialPrimary {xpath('PresidentialPrimary')};
    string2 Other {xpath('Other')};
  END;

  EXPORT _lt_VoterReport2Record := RECORD (_lt_VoterBaseRecord2)
    string30 MaidenName {xpath('MaidenName')};
    integer AgeCategory {xpath('AgeCategory')};
    string10 AgeRange {xpath('AgeRange')};
    string10 HomePhone {xpath('HomePhone')};
    string10 WorkPhone {xpath('WorkPhone')};
    string1 HeadHouseHold {xpath('HeadHouseHold')};
    string18 PlaceOfBirth {xpath('PlaceOfBirth')};
    _lt_VoterDistrictInfo VoterDistrictInfo {xpath('VoterDistrictInfo')};
    dataset(_lt_VotingHistory) VotingHistories {xpath('VotingHistories/VotingHistory'), MAXCOUNT(iesp.Constants.BR.MaxVoterHistory * 2)};
  END;

  EXPORT _lt_row_VoterReport2Record := RECORD  (_lt_VoterReport2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_MaskableDate := RECORD
    string4 Year {xpath('Year')};
    string2 Month {xpath('Month')};
    string2 Day {xpath('Day')};
  END;

  EXPORT _lt_DLRecord := RECORD (_lt_CriminalIndicators)
    string DLSequenceId {xpath('DLSequenceId')};//hidden[internal]
    string15 UniqueId {xpath('UniqueId')};
    _lt_Name Name {xpath('Name')};
    _lt_Date DOB {xpath('DOB')};
    _lt_MaskableDate DOB2 {xpath('DOB2')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
    _lt_Date IssueDate {xpath('IssueDate')};
    string14 DriverLicense {xpath('DriverLicense')};
    string9 SSN {xpath('SSN')};
    string3 Height {xpath('Height')};
    string3 Weight {xpath('Weight')};
    string250 LicenseClass {xpath('LicenseClass')};
    string6 LicenseClassCode {xpath('LicenseClassCode')};
    string10 HairColor {xpath('HairColor')};
    string15 EyeColor {xpath('EyeColor')};
    string75 LicenseType {xpath('LicenseType')};
    string2 OriginState {xpath('OriginState')};
    string20 OriginStateName {xpath('OriginStateName')};
    string2 RecordType {xpath('RecordType')};
    string20 Race {xpath('Race')};
    string10 Sex {xpath('Sex')};
    string50 Status {xpath('Status')};
    string50 CDLStatus {xpath('CDLStatus')};
    string10 History {xpath('History')};
    string25 Attention {xpath('Attention')};
    string120 Restrictions {xpath('Restrictions')};
    string120 Endorsements {xpath('Endorsements')};
    string MotorCycle {xpath('MotorCycle')}; 
    DATASET (DiffString) RestrictionsDetail {xpath('RestrictionsDetail/Restriction'), MAXCOUNT(10)};
    DATASET (DiffString) EndorsementsDetail {xpath('EndorsementsDetail/Endorsement'), MAXCOUNT(10)};
  END;

  EXPORT _lt_DLEmbeddedReport2Record := RECORD (_lt_DLRecord)
    _lt_UniversalAddress Address {xpath('Address')};
    _lt_Date DOD {xpath('DOD')};
    _lt_Date OrigIssueDate {xpath('OrigIssueDate')};
    _lt_Date OrigExpDate {xpath('OrigExpDate')};
    _lt_Date ActiveDate {xpath('ActiveDate')};
    _lt_Date InactiveDate {xpath('InactiveDate')};
    string1 NameChange {xpath('NameChange')};
    string8 AddressChange {xpath('AddressChange')};
    string42 RestrictionsDelimited {xpath('RestrictionsDelimited')};
    string25 OOSPrevDLNumber {xpath('OOSPrevDLNumber')};
    string2 OOSPrevState {xpath('OOSPrevState')};
    string14 OldDLNumber {xpath('OldDLNumber')};
    string2 Issuance {xpath('Issuance')};
    integer Age {xpath('Age')};
    string Src {xpath('Src')};//hidden[internal]
    string NonDMVSource {xpath('NonDMVSource')};
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
  END;

  EXPORT _lt_row_DLEmbeddedReport2Record := RECORD  (_lt_DLEmbeddedReport2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_MotorVehicleReportVehicleInfo := RECORD
    string15 IterationKey {xpath('IterationKey')};//hidden[internal]
    string15 SequenceKey {xpath('SequenceKey')};//hidden[internal]
    string30 VehicleRecordId {xpath('VehicleRecordId')};
    string25 VIN {xpath('VIN')};
    string1 TransferOnDeath {xpath('TransferOnDeath')};
    integer YearMake {xpath('YearMake')};
    string25 Series {xpath('Series')};
    string36 Make {xpath('Make')};
    string36 Model {xpath('Model')};
    string15 MajorColor {xpath('MajorColor')};
    string15 MinorColor {xpath('MinorColor')};
    string40 _Type {xpath('Type')};
    string25 Style {xpath('Style')};
    string6 NetWeight {xpath('NetWeight')};
    integer NumberOfAxles {xpath('NumberOfAxles')};
    string30 VehicleUse {xpath('VehicleUse')};
    string2 StateOfOrigin {xpath('StateOfOrigin')};
  END;

  EXPORT _lt_MVR2VinaData := RECORD
    integer Year {xpath('Year')};
    string3 Series {xpath('Series')};
    string25 SeriesName {xpath('SeriesName')};
    string3 Model {xpath('Model')};
    string120 Restraint {xpath('Restraint')};
    string20 AirConditioning {xpath('AirConditioning')};
    string20 PowerSteering {xpath('PowerSteering')};
    string20 PowerBrakes {xpath('PowerBrakes')};
    string20 PowerWindows {xpath('PowerWindows')};
    string20 TiltWheel {xpath('TiltWheel')};
    string30 Roof {xpath('Roof')};
    string30 OptionalRoof1 {xpath('OptionalRoof1')};
    string30 OptionalRoof2 {xpath('OptionalRoof2')};
    string20 Radio {xpath('Radio')};
    string20 OptionalRadio1 {xpath('OptionalRadio1')};
    string20 OptionalRadio2 {xpath('OptionalRadio2')};
    string1 Transmission {xpath('Transmission')};
    string50 TransmissionDesc {xpath('TransmissionDesc')};
    string40 AntiLockBrakes {xpath('AntiLockBrakes')};
    string30 FrontWheelDrive {xpath('FrontWheelDrive')};
    string30 FourWheelDrive {xpath('FourWheelDrive')};
    string50 SecuritySystem {xpath('SecuritySystem')};
    string20 DaytimeRunningLights {xpath('DaytimeRunningLights')};
    integer NumberOfCylinders {xpath('NumberOfCylinders')};
    integer EngineSize {xpath('EngineSize')};
    string60 FuelType {xpath('FuelType')};
    string6 Price {xpath('Price')};
  END;

  EXPORT _lt_MotorVehicleReportPersonOrBusiness := RECORD (DiffMetaRec)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string12 UniqueId {xpath('UniqueId')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string9 SSN {xpath('SSN')};
    string9 AppendSSN {xpath('AppendSSN')};
    string12 FEIN {xpath('FEIN')};
    string12 AppendedFEIN {xpath('AppendedFEIN')};
    string20 DriverLicenseNumber {xpath('DriverLicenseNumber')};
    _lt_Date DOB {xpath('DOB')};
    integer Age {xpath('Age')};
    string10 Gender {xpath('Gender')};
    string70 BusinessName {xpath('BusinessName')};
    string12 BusinessId {xpath('BusinessId')};
    string30 NameSource {xpath('NameSource')};
  END;

  EXPORT _lt_MotorVehicleReportRegistrationInfo := RECORD (DiffMetaRec)
    string10 TrueLicensePlate {xpath('TrueLicensePlate')};
    string2 LicenseState {xpath('LicenseState')};
    _lt_Date FirstDate {xpath('FirstDate')};
    _lt_Date EarliestEffectiveDate {xpath('EarliestEffectiveDate')};
    _lt_Date LatestEffectiveDate {xpath('LatestEffectiveDate')};
    _lt_Date LatestExpirationDate {xpath('LatestExpirationDate')};
    string10 DecalNumber {xpath('DecalNumber')};
    string4 DecalYear {xpath('DecalYear')};
    string20 StatusDesc {xpath('StatusDesc')};
    string10 LicensePlate {xpath('LicensePlate')};
    string4 LicensePlateTypeCode {xpath('LicensePlateTypeCode')};
    string65 LicensePlateTypeDesc {xpath('LicensePlateTypeDesc')};
    string10 PreviousLicensePlate {xpath('PreviousLicensePlate')};
    string2 PreviousLicenseState {xpath('PreviousLicenseState')};
  END;

  EXPORT _lt_MotorVehicleReportRegistrant := RECORD (DiffMetaRec)
    string30 HistoryDescription {xpath('HistoryDescription')};
    _lt_MotorVehicleReportPersonOrBusiness RegistrantInfo {xpath('RegistrantInfo')};
    _lt_MotorVehicleReportRegistrationInfo RegistrationInfo {xpath('RegistrationInfo')};
    _lt_Date TitleIssueDate {xpath('TitleIssueDate')};
  END;

  EXPORT _lt_row_MotorVehicleReportRegistrant := RECORD  (_lt_MotorVehicleReportRegistrant)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_MotorVehicleReportTitleInfo := RECORD
    string20 Number {xpath('Number')};
    _lt_Date EarliestIssueDate {xpath('EarliestIssueDate')};
    _lt_Date LatestIssueDate {xpath('LatestIssueDate')};
    _lt_Date PreviousIssueDate {xpath('PreviousIssueDate')};
    string1 StatusCode {xpath('StatusCode')};
    string42 StatusDesc {xpath('StatusDesc')};
    integer OdometerMileage {xpath('OdometerMileage')};
  END;

  EXPORT _lt_MotorVehicleReportOwner := RECORD
    string30 HistoryDescription {xpath('HistoryDescription')};
    _lt_MotorVehicleReportPersonOrBusiness OwnerInfo {xpath('OwnerInfo')};
    _lt_MotorVehicleReportTitleInfo TitleInfo {xpath('TitleInfo')};
    _lt_Date SourceDateFirstSeen {xpath('SourceDateFirstSeen')};
    _lt_Date SourceDateLastSeen {xpath('SourceDateLastSeen')};
  END;

  EXPORT _lt_MotorVehicleReportLienHolder := RECORD
    string30 HistoryDescription {xpath('HistoryDescription')};
    _lt_MotorVehicleReportPersonOrBusiness LienHolderInfo {xpath('LienHolderInfo')};
    _lt_Date LienDate {xpath('LienDate')};
    string70 StandardizedName {xpath('StandardizedName')};
  END;

  EXPORT _lt_MotorVehicleReportLessee := RECORD
    string30 HistoryDescription {xpath('HistoryDescription')};
    _lt_MotorVehicleReportPersonOrBusiness LesseeInfo {xpath('LesseeInfo')};
  END;

  EXPORT _lt_MotorVehicleReportLessor := RECORD
    string30 HistoryDescription {xpath('HistoryDescription')};
    _lt_MotorVehicleReportPersonOrBusiness LessorInfo {xpath('LessorInfo')};
  END;

  EXPORT _lt_MotorVehicleSearchBrand := RECORD
    _lt_Date Date {xpath('Date')};
    string2 State {xpath('State')};
    string3 Code {xpath('Code')};
    string50 _Type {xpath('Type')};
  END;

  EXPORT _lt_MotorVehicleReport2Record := RECORD (DiffMetaRec)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    boolean IsCurrent {xpath('IsCurrent')};
    boolean NonDMVSource {xpath('NonDMVSource')};
    _lt_MotorVehicleReportVehicleInfo VehicleInfo {xpath('VehicleInfo')};
    _lt_MVR2VinaData VinaData {xpath('VinaData')};
    string15 IterationKey {xpath('IterationKey')};//hidden[internal]
    string15 SequenceKey {xpath('SequenceKey')};//hidden[internal]
    string15 DataSource {xpath('DataSource')}; 
    dataset(_lt_MotorVehicleReportRegistrant) Registrants {xpath('Registrants/Registrant'), MAXCOUNT(Constants.MV.MaxCountRegistrants * 2)};
    dataset(_lt_MotorVehicleReportOwner) Owners {xpath('Owners/Owner'), MAXCOUNT(Constants.MV.MaxCountOwners * 2)};
    dataset(_lt_MotorVehicleReportLienHolder) LienHolders {xpath('LienHolders/LienHolder'), MAXCOUNT(Constants.MV.MaxCountLienHolders * 2)};
    dataset(_lt_MotorVehicleReportLessee) Lessees {xpath('Lessees/Lessee'), MAXCOUNT(Constants.MV.MaxCountLessees * 2)};
    dataset(_lt_MotorVehicleReportLessor) Lessors {xpath('Lessors/Lessor'), MAXCOUNT(Constants.MV.MaxCountLessors * 2)};
    dataset(_lt_MotorVehicleSearchBrand) Brands {xpath('Brands/Brand'), MAXCOUNT(Constants.MV.MaxCountBrands * 2)};
  END;

  EXPORT _lt_row_MotorVehicleReport2Record := RECORD  (_lt_MotorVehicleReport2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_AccidentReportLocation := RECORD
    string3 StateRoadAccident {xpath('StateRoadAccident')};
    string12 County {xpath('County')};
    string30 City {xpath('City')};
    integer FootCityTown {xpath('FootCityTown')};
    integer MilesCityTown {xpath('MilesCityTown')};
    string5 DirectionCityTown {xpath('DirectionCityTown')};
    string25 CityTownName {xpath('CityTownName')};
    string5 AtNodeNumber {xpath('AtNodeNumber')};
    string4 FootMilesNode {xpath('FootMilesNode')};
    string1 FootMiles1 {xpath('FootMiles1')};
    string5 FromNodeNumber {xpath('FromNodeNumber')};
    string5 NextNodeRoadway {xpath('NextNodeRoadway')};
    string36 StateRoadHighwayName {xpath('StateRoadHighwayName')};
    string36 AtIntersectOf {xpath('AtIntersectOf')};
    string4 FootMilesFromIntersect {xpath('FootMilesFromIntersect')};
    string1 FootMiles2 {xpath('FootMiles2')};
    string5 IntersectDirectionOf {xpath('IntersectDirectionOf')};
    string36 OfIntersectOf {xpath('OfIntersectOf')};
    boolean IsCodeable {xpath('CodeableNoncodeable')};
    string6 TypeFRCase {xpath('TypeFRCase')};
    string10 Action {xpath('Action')};
  END;

  EXPORT _lt_AccidentReportTime := RECORD
    string9 DayOfWeek {xpath('DayOfWeek')};
    integer1 HourOfAccident {xpath('HourOfAccident')};
    integer1 MinuteOfAccident {xpath('MinuteOfAccident')};
    integer1 HourOffNotified {xpath('HourOffNotified')};
    integer1 MinuteOffNotified {xpath('MinuteOffNotified')};
    integer1 HourOffArrived {xpath('HourOffArrived')};
    integer1 MinuteOffArrived {xpath('MinuteOffArrived')};
  END;

  EXPORT _lt_AccidentReportDOTInfo := RECORD
    string1 TypeFacility {xpath('TypeFacility')};
    string1 RoadType {xpath('RoadType')};
    integer1 NumberOfLanes {xpath('NumberOfLanes')};
    string2 SiteLocation {xpath('SiteLocation')};
    string1 DistrictIndex {xpath('DistrictIndex')};
    string2 County {xpath('County')};
    integer2 SectionNumber {xpath('SectionNumber')};
    string2 SkidResistance {xpath('SkidResistance')};
    string1 FrictionCoarse {xpath('FrictionCoarse')};
    string6 AverageDailyTraffic {xpath('AverageDailyTraffic')};
    integer3 NodeNumber {xpath('NodeNumber')};
    string5 DistanceFromNode {xpath('DistanceFromNode')};
    string5 DirectionFromNode {xpath('DirectionFromNode')};
    integer3 StateRoadNumber {xpath('StateRoadNumber')};
    integer3 USRoadNumber {xpath('USRoadNumber')};
    string6 Milepost {xpath('Milepost')};
    string1 HighwayLocation {xpath('HighwayLocation')};
    string3 Subsection {xpath('Subsection')};
    string10 SystemType {xpath('SystemType')};
    string3 Travelway {xpath('Travelway')};
    string2 NodeType {xpath('NodeType')};
    string2 FixtureType {xpath('FixtureType')};
    string3 SideOfRoad {xpath('SideOfRoad')};
    string15 AccidentSeverity {xpath('AccidentSeverity')};
    integer1 LaneId {xpath('LaneId')};
  END;

  EXPORT _lt_AccidentReportCondition := RECORD
    string30 LocationType {xpath('LocationType')};
    string1 Population {xpath('Population')};
    string5 RuralUrban {xpath('RuralUrban')};
    string40 SiteLocation {xpath('SiteLocation')};
    string100 FirstHarmfulEvent {xpath('FirstHarmfulEvent')};
    string100 SecondHarmfulEvent {xpath('SecondHarmfulEvent')};
    string25 OnOffRoadway {xpath('OnOffRoadway')};
    string40 LightCondition {xpath('LightCondition')};
    string40 Weather {xpath('Weather')};
    string40 RoadSurfaceType {xpath('RoadSurfaceType')};
    string10 ShoulderType {xpath('ShoulderType')};
    string40 RoadSurfaceCondition {xpath('RoadSurfaceCondition')};
    string50 FirstContributingCause {xpath('FirstContributingCause')};
    string50 SecondContributingCause {xpath('SecondContributingCause')};
    string40 FirstContributingEnvirionment {xpath('FirstContributingEnvirionment')};
    string40 SecondContributingEnvirionment {xpath('SecondContributingEnvirionment')};
    string30 FirstTrafficControl {xpath('FirstTrafficControl')};
    string30 SecondTrafficControl {xpath('SecondTrafficControl')};
    string30 TrafficwayChar {xpath('TrafficwayChar')};
    string2 NumberOfLanes {xpath('NumberOfLanes')};
    string10 DividedUndivided {xpath('DividedUndivided')};
    string20 RoadSystemId {xpath('RoadSystemId')};
    string100 InvestigationAgent {xpath('InvestigationAgent')};
    string25 InjurySeverity {xpath('InjurySeverity')};
    string100 DamageSeverity {xpath('DamageSeverity')};
    string15 Insurance {xpath('Insurance')};
    string40 AccidentFault {xpath('AccidentFault')};
    string40 AlcoholDrug {xpath('AlcoholDrug')};
  END;

  EXPORT _lt_AccidentReportInvestigationAgent := RECORD
    string15 AgentReportNumber {xpath('AgentReportNumber')};
    string25 AgentName {xpath('AgentName')};
    string15 AgentRank {xpath('AgentRank')};
    string6 AgentIdBadgeNumber {xpath('AgentIdBadgeNumber')};
    string25 AgentDepartmentName {xpath('AgentDepartmentName')};
  END;

  EXPORT _lt_AccidentReportInvestigation := RECORD
    _lt_AccidentReportInvestigationAgent InvestigationAgent {xpath('InvestigationAgent')};
    string25 InvestMaede {xpath('InvestMaede')};
    string25 InvestComplete {xpath('InvestComplete')};
    _lt_Date SearchDate {xpath('SearchDate')};
    string30 PhotosTaken {xpath('PhotosTaken')};
    string40 PhotosTakenWhom {xpath('PhotosTakenWhom')};
    string25 FirstAidName {xpath('FirstAidName')};
    string20 FirstAidPersonType {xpath('FirstAidPersonType')};
    string41 InjuredTakenTo {xpath('InjuredTakenTo')};
    string25 InjuredTakenBy {xpath('InjuredTakenBy')};
    string20 TypeDriverAccident {xpath('TypeDriverAccident')};
    string2 HourOfEMSNotified {xpath('HourOfEMSNotified')};
    string2 MinuteOfEMSNotified {xpath('MinuteOfEMSNotified')};
    string2 HourOfEMSArrived {xpath('HourOfEMSArrived')};
    string2 MinuteOfEMSArrived {xpath('MinuteOfEMSArrived')};
  END;

  EXPORT _lt_AccidentReportStatistics := RECORD
    string7 TotalTarDamage {xpath('TotalTarDamage')};
    string7 TotalVehicleDamage {xpath('TotalVehicleDamage')};
    string7 TotalPropertyDamage {xpath('TotalPropertyDamage')};
    integer2 TotalNumberOfPersons {xpath('TotalNumberOfPersons')};
    integer1 TotalNumberOfDrivers {xpath('TotalNumberOfDrivers')};
    integer1 TotalNumberOfVehicles {xpath('TotalNumberOfVehicles')};
    integer2 TotalNumberOfFatalities {xpath('TotalNumberOfFatalities')};
    integer1 TotalNumberOfNonTrafficFatal {xpath('TotalNumberOfNonTrafficFatal')};
    integer2 TotalNumberOfInjuries {xpath('TotalNumberOfInjuries')};
    integer1 TotalNumberOfPedestrians {xpath('TotalNumberOfPedestrians')};
    integer1 TotalNumberOfPedalcyclists {xpath('TotalNumberOfPedalcyclists')};
  END;

  EXPORT _lt_AccidentReportPassenger := RECORD
    integer1 Number {xpath('Number')};
    _lt_Name Name {xpath('Name')};
    string6 Gender {xpath('Gender')};
    _lt_Address Address {xpath('Address')};
    integer1 Age {xpath('Age')};
    string20 Location {xpath('Location')};
    string30 InjurySeverity {xpath('InjurySeverity')};
    string30 FirstPassengerSafe {xpath('FirstPassengerSafe')};
    string30 SecondPassengerSafe {xpath('SecondPassengerSafe')};
    string10 Eject {xpath('Eject')};
    string2 FRInjuryCap {xpath('FRInjuryCap')};
  END;

  EXPORT _lt_AccidentReportOwner := RECORD
    string12 UniqueId {xpath('UniqueId')};
    _lt_Name Name {xpath('Name')};
    string25 CompanyName {xpath('CompanyName')};
    string15 DriverLicenseNumber {xpath('DriverLicenseNumber')};
    _lt_Date DOB {xpath('DOB')};
    string6 Sex {xpath('Sex')};
    string20 Race {xpath('Race')};
    string3 ForgeAsterisk {xpath('ForgeAsterisk')};
    _lt_Address Address {xpath('Address')};
  END;

  EXPORT _lt_AccidentReportTowedTrailer := RECORD
    integer2 Year {xpath('Year')};
    string20 Make {xpath('Make')};
    string40 _Type {xpath('Type')};
    string10 TagNumber {xpath('TagNumber')};
    string2 State {xpath('State')};
    string22 IDNumber {xpath('IDNumber')};
    string7 EstimatedDamage {xpath('EstimatedDamage')};
    string50 OwnerName {xpath('OwnerName')};
    string2 OwnerNameSuffix {xpath('OwnerNameSuffix')};
    string60 OwnerCity {xpath('OwnerCity')};
    string2 OwnerState {xpath('OwnerState')};
    string5 OwnerZip5 {xpath('OwnerZip5')};
    string2 FRCap {xpath('FRCap')};
  END;

  EXPORT _lt_AccidentReportDriverLicenseInfo := RECORD
    string15 LicenseNumber {xpath('LicenseNumber')};
    string3 ForceAsterisk {xpath('ForceAsterisk')};
    string2 LicenseState {xpath('LicenseState')};
    string25 LicenseType {xpath('LicenseType')};
  END;

  EXPORT _lt_AccidentReportIndividualInvolved := RECORD
    string12 UniqueId {xpath('UniqueId')};
    _lt_Name Name {xpath('Name')};
    _lt_Date DOB {xpath('DOB')};
    _lt_Address Address {xpath('Address')};
    string6 Sex {xpath('Sex')};
    string20 Race {xpath('Race')};
    string2 FRInjuryCap {xpath('FRInjuryCap')};
    string10 BACTestType {xpath('BACTestType')};
    string3 BACForce {xpath('BACForce')};
    string20 BACTestResults {xpath('BACTestResults')};
    string35 AlcoholDrug {xpath('AlcoholDrug')};
    string25 PhysicalDefect {xpath('PhysicalDefect')};
    string25 Residence {xpath('Residence')};
    string30 InjurySeverity {xpath('InjurySeverity')};
    string35 FirstContributeCause {xpath('FirstContributeCause')};
    string35 SecondContributeCause {xpath('SecondContributeCause')};
    string35 ThirdContributeCause {xpath('ThirdContributeCause')};
    DATASET (DiffString) ChargedOffenses {xpath('ChargedOffenses/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_CHARGED_OFFENSES * 2)};
    DATASET (DiffString) FRDLCharges {xpath('FRDLCharges/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_FRDL_CHARGES * 2)};
    DATASET (DiffString) Citations {xpath('Citations/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_CITATIONS * 2)};
  END;

  EXPORT _lt_AccidentReportDriver := RECORD
    string2 ResidentState {xpath('ResidentState')};
    string30 FirstSafety {xpath('FirstSafety')};
    string30 SecondSafety {xpath('SecondSafety')};
    string10 Eject {xpath('Eject')};
    string35 RecommandReExam {xpath('RecommandReExam')};
    string10 PhoneNumber {xpath('PhoneNumber')};
    string4 DriverLicenseNumberGoodBad {xpath('DriverLicenseNumberGoodBad')};
    string3 ReqEndorsement {xpath('ReqEndorsement')};
    string15 OosDriverLicenseNumber {xpath('OosDriverLicenseNumber')};
    _lt_AccidentReportDriverLicenseInfo DriverLicense {xpath('DriverLicense')};
    _lt_AccidentReportIndividualInvolved Individual {xpath('Individual')};
    string41 InsuranceCompany {xpath('InsuranceCompany')};
    string25 InsurancePolicyNumber {xpath('InsurancePolicyNumber')};
  END;

  EXPORT _lt_AccidentReportVehicle := RECORD
    string2 Vehicle {xpath('Vehicle')};
    string20 OwnerDriver {xpath('OwnerDriver')};
    string20 DriverAction {xpath('DriverAction')};
    integer2 Year {xpath('Year')};
    string20 Make {xpath('Make')};
    string40 _Type {xpath('Type')};
    string10 TagNumber {xpath('TagNumber')};
    string2 RegisterState {xpath('RegisterState')};
    string22 IDNumber {xpath('IDNumber')};
    string36 TravelOn {xpath('TravelOn')};
    string15 TravelDirection {xpath('TravelDirection')};
    string3 EstimatedSpeed {xpath('EstimatedSpeed')};
    string2 PostedSpeed {xpath('PostedSpeed')};
    string7 EstimatedDamage {xpath('EstimatedDamage')};
    string10 DamageType {xpath('DamageType')};
    string41 InsuranceCompany {xpath('InsuranceCompany')};
    string25 InsurancePolicyNumber {xpath('InsurancePolicyNumber')};
    string25 RemovedBy {xpath('RemovedBy')};
    string20 HowRemoved {xpath('HowRemoved')};
    string30 PointOfImpact {xpath('PointOfImpact')};
    string35 Movement {xpath('Movement')};
    string30 _Function {xpath('Function')};
    string30 VehicleFirstDefect {xpath('VehicleFirstDefect')};
    string30 VehicleSecondDefect {xpath('VehicleSecondDefect')};
    string2 Modified {xpath('Modified')};
    string25 RoadwayLocation {xpath('RoadwayLocation')};
    string40 HazardMaterialTransport {xpath('HazardMaterialTransport')};
    string3 TotalOccupants {xpath('TotalOccupants')};
    string3 TotalSaftyEquipments {xpath('TotalSaftyEquipments')};
    string50 MovingViolation {xpath('MovingViolation')};
    string20 Insurance {xpath('Insurance')};
    string20 Fault {xpath('Fault')};
    string2 Cap {xpath('Cap')};
    string6 FR {xpath('FR')};
    string30 Use {xpath('Use')};
    string3 Placarded {xpath('Placarded')};
    string3 DhsmvInd {xpath('DhsmvInd')};
    string25 Model {xpath('Model')};
    string25 Series {xpath('Series')};
    _lt_AccidentReportOwner Owner {xpath('Owner')};
    _lt_AccidentReportTowedTrailer TowedTrailer {xpath('TowedTrailer')};
    _lt_AccidentReportDriver Driver {xpath('Driver')};
    dataset(_lt_AccidentReportPassenger) Passengers {xpath('Passengers/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_PASSENGERS * 2)};
  END;

  EXPORT _lt_AccidentReportPropertyOwner := RECORD
    _lt_Name Name {xpath('Name')};
    string6 Gender {xpath('Gender')};
    string25 CompanyName {xpath('CompanyName')};
    _lt_Address Address {xpath('Address')};
  END;

  EXPORT _lt_AccidentReportPropertyDamage := RECORD
    string2 PropertyDamageNumber {xpath('PropertyDamageNumber')};
    string25 PropertyDamaged {xpath('PropertyDamaged')};
    string7 PropertyDamageAmount {xpath('PropertyDamageAmount')};
    string2 FRFixedObjectCap {xpath('FRFixedObjectCap')};
    _lt_AccidentReportPropertyOwner Owner {xpath('Owner')};
  END;

  EXPORT _lt_AccidentReportPedestrian := RECORD
    string35 Action {xpath('Action')};
    string15 DriverLicenseNumber {xpath('DriverLicenseNumber')};
    _lt_AccidentReportIndividualInvolved Individual {xpath('Individual')};
  END;

  EXPORT _lt_AccidentReportRecord := RECORD
    _lt_Date AccidentDate {xpath('AccidentDate')};
    string3 DhsmvVehicleCrash {xpath('DhsmvVehicleCrash')};
    string1 FormType {xpath('FormType')};
    string2 UpdateNumber {xpath('UpdateNumber')};
    string2 AccidentState {xpath('AccidentState')};
    _lt_AccidentReportLocation AccidentLocation {xpath('AccidentLocation')};
    _lt_AccidentReportTime AccidentTime {xpath('AccidentTime')};
    _lt_AccidentReportDOTInfo DotInfo {xpath('DotInfo')};
    _lt_AccidentReportCondition Conditions {xpath('Conditions')};
    _lt_AccidentReportInvestigation Investigation {xpath('Investigation')};
    _lt_AccidentReportStatistics Statistics {xpath('Statistics')};
    dataset(_lt_AccidentReportVehicle) Vehicles {xpath('Vehicles/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_VEHICLES * 2)};
    dataset(_lt_AccidentReportPropertyDamage) PropertyDamages {xpath('PropertyDamages/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_PROP_DAMAGES * 2)};
    dataset(_lt_AccidentReportPedestrian) Pedestrians {xpath('Pedestrians/Item'), MAXCOUNT(iesp.constants.ACCIDENTS_MAX_COUNT_PEDESTRIANS * 2)};
  END;

  EXPORT _lt_Bankruptcy2Meeting := RECORD
    _lt_Date Date {xpath('Date')};
    string8 Time {xpath('Time')};
    string90 Address {xpath('Address')};
  END;

  EXPORT _lt_BankruptcyStatus := RECORD
    string30 _Type {xpath('Type')};
    _lt_Date Date {xpath('Date')};
  END;

  EXPORT _lt_BankruptcyComment := RECORD
    string30 Description {xpath('Description')};
    _lt_Date FilingDate {xpath('FilingDate')};
  END;

  EXPORT _lt_NameAndCompany := RECORD (_lt_Name)
    string120 CompanyName {xpath('CompanyName')};
  END;

  EXPORT _lt_BankruptcySearch2Name := RECORD (_lt_NameAndCompany)
    string2 _Type {xpath('Type')};
  END;

  EXPORT _lt_row_BankruptcySearch2Name := RECORD  (_lt_BankruptcySearch2Name)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PhoneTimeZone := RECORD
    string10 Phone10 {xpath('Phone10')};
    string10 Fax {xpath('Fax')};
    string4 TimeZone {xpath('TimeZone')};
  END;

  EXPORT _lt_BankruptcyPerson2 := RECORD (_lt_CriminalIndicators)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string12 UniqueId {xpath('UniqueId')};
    string12 BusinessId {xpath('BusinessId')};
    string9 SSN {xpath('SSN')};
    string9 AppendedSSN {xpath('AppendedSSN')};
    string9 TaxId {xpath('TaxId')};
    string9 AppendedTaxId {xpath('AppendedTaxId')};
    dataset(_lt_BankruptcySearch2Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonNames * 2)};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses * 2)};
    dataset(_lt_AddressWithRawInfo) AddressesEx {xpath('AddressesEx/Address'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonAddresses * 2)};
    DATASET (DiffString) Phones {xpath('Phones/Phone10'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones * 2)};
    dataset(_lt_PhoneTimeZone) PhonesEx {xpath('PhonesEx/Phone'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonPhones * 2)};
    DATASET (DiffString) Emails {xpath('Emails/Email'), MAXCOUNT(iesp.Constants.BANKRPT.MaxPersonEmails * 2)};
  END;

  EXPORT _lt_row_BankruptcyPerson2 := RECORD  (_lt_BankruptcyPerson2)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_BankruptcyReport2Debtor := RECORD (_lt_BankruptcyPerson2)
    string12 CaseId {xpath('CaseId')};
    string12 DefendantId {xpath('DefendantId')};
    string12 RecordId {xpath('RecordId')};
    string30 OriginalCounty {xpath('OriginalCounty')};
    string1 SSNSource {xpath('SSNSource')};
    string35 SSNSourceDesc {xpath('SSNSourceDesc')};
    string9 SSNMatch {xpath('SSNMatch')};
    string35 SSNMatchDesc {xpath('SSNMatchDesc')};
    string1 SSNMatchSource {xpath('SSNMatchSource')};
    string1 Screen {xpath('Screen')};
    string35 ScreenDesc {xpath('ScreenDesc')};
    string2 DispositionCode {xpath('DispositionCode')};
    string35 DispositionCodeDesc {xpath('DispositionCodeDesc')};
    string3 DispositionType {xpath('DispositionType')};
    string35 DispositionTypeDesc {xpath('DispositionTypeDesc')};
    string3 DispositionReason {xpath('DispositionReason')};
    _lt_Date StatusDate {xpath('StatusDate')};
    string8 HoldCase {xpath('HoldCase')};
    _lt_Date DateVacated {xpath('DateVacated')};
    _lt_Date DateTransferred {xpath('DateTransferred')};
    string12 ActivityReceipt {xpath('ActivityReceipt')};
    string1 DefendantType {xpath('DefendantType')}; 
  END;

  EXPORT _lt_row_BankruptcyReport2Debtor := RECORD  (_lt_BankruptcyReport2Debtor)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_BankruptcyReport2Record := RECORD (DiffMetaRec)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string1 CorpFlag {xpath('CorpFlag')};
    string10 FilingType {xpath('FilingType')};
    string10 FilerType {xpath('FilerType')};
    string2 FilingJurisdiction {xpath('FilingJurisdiction')};
    string1 CaseType {xpath('CaseType')};
    string7 CaseNumber {xpath('CaseNumber')};
    _lt_Date FilingDate {xpath('FilingDate')};
    _lt_Date OriginalFilingDate {xpath('OriginalFilingDate')};
    _lt_Date ClosedDate {xpath('ClosedDate')};
    _lt_Date ReopenDate {xpath('ReopenDate')};
    _lt_Date ConvertedDate {xpath('ConvertedDate')};
    string3 Chapter {xpath('Chapter')};
    string3 OriginalChapter {xpath('OriginalChapter')};
    string50 CourtName {xpath('CourtName')};
    string40 CourtLocation {xpath('CourtLocation')};
    string35 JudgeName {xpath('JudgeName')};
    string5 JudgeIdentification {xpath('JudgeIdentification')};
    _lt_Date ClaimsDeadline {xpath('ClaimsDeadline')};
    _lt_Date ComplaintDeadline {xpath('ComplaintDeadline')};
    string12 FilingStatus {xpath('FilingStatus')};
    string5 CourtCode {xpath('CourtCode')};
    _lt_Date DischargeDate {xpath('DischargeDate')};
    string35 Disposition {xpath('Disposition')};
    string20 Liabilities {xpath('Liabilities')};
    string20 Assets {xpath('Assets')};
    _lt_Bankruptcy2Meeting Meeting {xpath('Meeting')};
    string1 MethodDismiss {xpath('MethodDismiss')};
    string1 CaseStatus {xpath('CaseStatus')};
    string25 SplitCase {xpath('SplitCase')};
    _lt_Date DateReclosed {xpath('DateReclosed')};
    string12 TrusteeId {xpath('TrusteeId')};
    string12 CaseId {xpath('CaseId')};
    _lt_Date BarDate {xpath('BarDate')};
    string7 TransferIn {xpath('TransferIn')};
    boolean DeleteFlag {xpath('DeleteFlag')};
    string1 SelfRepresented {xpath('SelfRepresented')}; 
    string1 AssetsForUnsecured {xpath('AssetsForUnsecured')}; 
    string FiledInError {xpath('FiledInError')}; 
    dataset(_lt_BankruptcyStatus) StatusHistory {xpath('StatusHistory/Status'), MAXCOUNT(iesp.Constants.BANKRPT.MaxStatusHistory * 2)};
    dataset(_lt_BankruptcyComment) Comments {xpath('Comments/Comment'), MAXCOUNT(iesp.Constants.BANKRPT.MaxComments * 2)};
    dataset(_lt_BankruptcyReport2Debtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.BANKRPT.MaxDebtors * 2)};
    dataset(_lt_BankruptcyPerson2) Attorneys {xpath('Attorneys/Attorney'), MAXCOUNT(2 * 2)};
    dataset(_lt_BankruptcyPerson2) Trustees {xpath('Trustees/Trustee'), MAXCOUNT(10)};
  END;

  EXPORT _lt_row_BankruptcyReport2Record := RECORD  (_lt_BankruptcyReport2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_MatchedParty := RECORD
    string PartyType {xpath('PartyType')};
    string1 UniqueId {xpath('UniqueId')};
    string64 OriginName {xpath('OriginName')};
    _lt_Name ParsedParty {xpath('ParsedParty')};
    _lt_NameAndCompany ParsedParty2 {xpath('ParsedParty2')};
    _lt_Address Address {xpath('Address')};
  END;

  EXPORT _lt_CommonLienJudgmentRecordV2Base := RECORD (DiffMetaRec)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string50 RMSId {xpath('RMSId')};
    string10 OriginFilingTime {xpath('OriginFilingTime')};
    string20 TaxCode {xpath('TaxCode')};
    string100 Judge {xpath('Judge')};
    string50 ExternalKey {xpath('ExternalKey')};
    string50 TMSId {xpath('TMSId')};
    _lt_MatchedParty MatchedParty {xpath('MatchedParty')};
    string11 IRSSerialNumber {xpath('IRSSerialNumber')};
    string20 OriginFilingNumber {xpath('OriginFilingNumber')};
    string30 OriginFilingType {xpath('OriginFilingType')};
    _lt_Date OriginFilingDate {xpath('OriginFilingDate')};
    string25 CaseNumber {xpath('CaseNumber')};
    string15 Eviction {xpath('Eviction')};
    string15 Amount {xpath('Amount')};
    string50 FilingJurisdiction {xpath('FilingJurisdiction')};
    string21 FilingJurisdictionName {xpath('FilingJurisdictionName')};
    string2 FilingState {xpath('FilingState')};
    string100 FilingStatus {xpath('FilingStatus')};
    string40 CertificateNumber {xpath('CertificateNumber')};
    string MultipleDefendant {xpath('MultipleDefendant')};
    _lt_Date JudgeSatisfiedDate {xpath('JudgeSatisfiedDate')};
    _lt_Date SuitDate {xpath('SuitDate')};
    _lt_Date JudgeVacatedDate {xpath('JudgeVacatedDate')};
    _lt_Date ReleaseDate {xpath('ReleaseDate')};
    string6 LegalLot {xpath('LegalLot')};
    string6 LegalBlock {xpath('LegalBlock')};
  END;

  EXPORT _lt_BaseLienJudgmentDebtor := RECORD (_lt_CriminalIndicators)
    string120 OriginName {xpath('OriginName')};
    string9 TaxId {xpath('TaxId')};
    string9 SSN {xpath('SSN')};
    _lt_Address Address {xpath('Address')};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.Liens.MAX_ADDRESSES * 2)};
    dataset(_lt_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.Liens.MAX_PHONES * 2)};
  END;

  EXPORT _lt_LienJudgmentParty := RECORD (_lt_CriminalIndicators)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    _lt_Name Name {xpath('Name')};
    string200 CompanyName {xpath('CompanyName')};
    string12 UniqueId {xpath('UniqueId')};
    string12 BusinessId {xpath('BusinessId')};
    string9 SSN {xpath('SSN')};
    string9 FEIN {xpath('FEIN')};
    string10 PersonFilterId {xpath('PersonFilterId')};
    string9 TaxId {xpath('TaxId')};
  END;

  EXPORT _lt_row_LienJudgmentParty := RECORD  (_lt_LienJudgmentParty)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_LienJudgmentDebtor := RECORD (_lt_BaseLienJudgmentDebtor)
    dataset(_lt_LienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES * 2)};
  END;

  EXPORT _lt_row_LienJudgmentDebtor := RECORD  (_lt_LienJudgmentDebtor)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_BaseLienJudgmentThirdParty := RECORD (_lt_CriminalIndicators)
    string120 OriginName {xpath('OriginName')};
    _lt_Address Address {xpath('Address')};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.Liens.MAX_ADDRESSES * 2)};
    dataset(_lt_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.Liens.MAX_PHONES * 2)};
  END;

  EXPORT _lt_LienJudgmentThirdParty := RECORD (_lt_BaseLienJudgmentThirdParty)
    dataset(_lt_LienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES * 2)};
  END;

  EXPORT _lt_BaseLienJudgmentCreditor := RECORD (_lt_CriminalIndicators)
    string120 Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.Liens.MAX_ADDRESSES * 2)};
    dataset(_lt_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.Liens.MAX_PHONES * 2)};
  END;

  EXPORT _lt_LienJudgmentCreditor := RECORD (_lt_BaseLienJudgmentCreditor)
    dataset(_lt_LienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES * 2)};
  END;

  EXPORT _lt_BaseLienJudgmentDebtorAttorney := RECORD (_lt_CriminalIndicators)
    string120 Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string10 Phone {xpath('Phone')};
    string3 TimeZone {xpath('TimeZone')};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.Liens.MAX_ADDRESSES * 2)};
    dataset(_lt_PhoneTimeZone) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.Constants.Liens.MAX_PHONES * 2)};
  END;

  EXPORT _lt_LienJudgmentDebtorAttorney := RECORD (_lt_BaseLienJudgmentDebtorAttorney)
    dataset(_lt_LienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES * 2)};
  END;

  EXPORT _lt_LienJudgmentFiling := RECORD
    string20 Number {xpath('Number')};
    string50 _Type {xpath('Type')};
    _lt_Date Date {xpath('Date')};
    _lt_Date OriginFilingDate {xpath('OriginFilingDate')};
    string10 Book {xpath('Book')};
    string10 Page {xpath('Page')};
    string60 Agency {xpath('Agency')};
    string35 AgencyCity {xpath('AgencyCity')};
    string2 AgencyState {xpath('AgencyState')};
    string35 AgencyCounty {xpath('AgencyCounty')};
    string100 FilingStatus {xpath('FilingStatus')};
    string200 FilingDescription {xpath('FilingDescription')};
    string10 FilingTime {xpath('FilingTime')};
  END;

  EXPORT _lt_LienJudgmentRecordV2Base := RECORD (_lt_CommonLienJudgmentRecordV2Base)
    dataset(_lt_LienJudgmentDebtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.Liens.MAX_DEBTORS * 2)};
    dataset(_lt_LienJudgmentThirdParty) ThirdParties {xpath('ThirdParties/ThirdParty'), MAXCOUNT(iesp.Constants.Liens.MAX_THIRD_PARTIES * 2)};
    dataset(_lt_LienJudgmentCreditor) Creditors {xpath('Creditors/Creditor'), MAXCOUNT(iesp.Constants.Liens.MAX_CREDITORS * 2)};
    dataset(_lt_LienJudgmentDebtorAttorney) DebtorAttorneys {xpath('DebtorAttorneys/Attorney'), MAXCOUNT(iesp.Constants.Liens.MAX_ATTORNEYS * 2)};
    dataset(_lt_LienJudgmentFiling) Filings {xpath('Filings/Filing'), MAXCOUNT(iesp.Constants.Liens.MAX_FILINGS * 2)};
  END;

  EXPORT _lt_LienJudgmentReportRecord := RECORD (_lt_LienJudgmentRecordV2Base)
  END;

  EXPORT _lt_row_LienJudgmentReportRecord := RECORD  (_lt_LienJudgmentReportRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_LegalInfo := RECORD
    string BriefDescription {xpath('BriefDescription'), maxlength(100)};
    string2 LotCode {xpath('LotCode')};
    string LotDesc {xpath('LotDesc'), maxlength(54)};
    string10 LotNumber {xpath('LotNumber')};
    string7 Block {xpath('Block')};
    string7 Section {xpath('Section')};
    string7 District {xpath('District')};
    string LandLot {xpath('LandLot'), maxlength(54)};
    string6 Unit {xpath('Unit')};
    string30 CityMunicipalityTownship {xpath('CityMunicipalityTownship')};
    string Subdivision {xpath('Subdivision'), maxlength(50)};
    string7 PhaseNumber {xpath('PhaseNumber')};
    string10 TractNumber {xpath('TractNumber')};
    string30 SecTwnRngMer {xpath('SecTwnRngMer')};
    string20 AssessorMapRef {xpath('AssessorMapRef')};
  END;

  EXPORT _lt_PropertyAssessmentFares := RECORD
    string7 LivingSquareFeet {xpath('LivingSquareFeet')};
    string IrisApn {xpath('IrisApn'), maxlength(60)};
    string11 CalculatedLandValue {xpath('CalculatedLandValue')};
    string11 CalculatedImprovementValue {xpath('CalculatedImprovementValue')};
    string11 CalculatedTotalValue {xpath('CalculatedTotalValue')};
    string7 AdjustedGrossSquareFeet {xpath('AdjustedGrossSquareFeet')};
    string5 NoOfFullBaths {xpath('NoOfFullBaths')};
    string5 NoOfHalfBaths {xpath('NoOfHalfBaths')};
    string1 PoolIndicator {xpath('PoolIndicator')};
    string3 Frame {xpath('Frame')};
    string25 FrameDesc {xpath('FrameDesc')};
    string3 ElectricEnergy {xpath('ElectricEnergy')};
    string20 ElectricEnergyDesc {xpath('ElectricEnergyDesc')};
    string3 Sewer {xpath('Sewer')};
    string12 SewerDesc {xpath('SewerDesc')};
    string12 Water {xpath('Water')};
    string12 WaterDesc {xpath('WaterDesc')};
    string3 Condition {xpath('Condition')};
    string18 ConditionDesc {xpath('ConditionDesc')};
  END;

  EXPORT _lt_PropertyAssessmentSrcPrptyRcd := RECORD
    string7 LivingSquareFeet {xpath('LivingSquareFeet')};
    string IrisApn {xpath('IrisApn'), maxlength(60)};
    string11 CalculatedLandValue {xpath('CalculatedLandValue')};
    string11 CalculatedImprovementValue {xpath('CalculatedImprovementValue')};
    string11 CalculatedTotalValue {xpath('CalculatedTotalValue')};
    string7 AdjustedGrossSquareFeet {xpath('AdjustedGrossSquareFeet')};
    string5 NoOfFullBaths {xpath('NoOfFullBaths')};
    string5 NoOfHalfBaths {xpath('NoOfHalfBaths')};
    string1 PoolIndicator {xpath('PoolIndicator')};
    string3 Frame {xpath('Frame')};
    string25 FrameDesc {xpath('FrameDesc')};
    string3 ElectricEnergy {xpath('ElectricEnergy')};
    string20 ElectricEnergyDesc {xpath('ElectricEnergyDesc')};
    string3 Sewer {xpath('Sewer')};
    string12 SewerDesc {xpath('SewerDesc')};
    string3 Water {xpath('Water')};
    string12 WaterDesc {xpath('WaterDesc')};
    string3 Condition {xpath('Condition')};
    string18 ConditionDesc {xpath('ConditionDesc')};
  END;

  EXPORT _lt_BuildingAreaInfo := RECORD
    string9 Area {xpath('Area')};
    string1 Indicator {xpath('Indicator')};
    string30 Description {xpath('Description')};
  END;

  EXPORT _lt_PropertyAssessment := RECORD
    string2 StateCode {xpath('StateCode')};
    string30 County {xpath('County')};
    string ParcelId {xpath('ParcelId'), maxlength(45)};
    string5 FipsCode {xpath('FipsCode')};
    string2 DuplicateApnMultipleAddressId {xpath('DuplicateApnMultipleAddressId')};
    _lt_Date TapeCutDate {xpath('TapeCutDate')};
    string2 EditionNumber {xpath('EditionNumber')};
    _lt_Date CertificationDate {xpath('CertificationDate')};
    string AssesseeOwnershipRights {xpath('AssesseeOwnershipRights'), maxlength(47)};
    string AssesseeRelationship {xpath('AssesseeRelationship'), maxlength(47)};
    string10 AssesseePhoneNumber {xpath('AssesseePhoneNumber')};
    string30 TaxAccountNumber {xpath('TaxAccountNumber')};
    string ContractOwner {xpath('ContractOwner'), maxlength(45)};
    string10 AssesseeNameType {xpath('AssesseeNameType')};
    string10 SecondAssesseeNameType {xpath('SecondAssesseeNameType')};
    string10 MailCareOfNameType {xpath('MailCareOfNameType')};
    string MailingCareOf {xpath('MailingCareOf'), maxlength(60)};
    string PropertyAddress {xpath('PropertyAddress'), maxlength(76)};
    string1 OwnerOccupied {xpath('OwnerOccupied')};
    _lt_Date RecordingDate {xpath('RecordingDate')};
    _lt_Date PriorRecordingDate {xpath('PriorRecordingDate')};
    string RecordType {xpath('RecordType'), maxlength(103)};
    string4 LandUseCode {xpath('LandUseCode')};
    string LandUse {xpath('LandUse'), maxlength(76)};
    string10 RecorderBookNumber {xpath('RecorderBookNumber')};
    string10 RecorderPageNumber {xpath('RecorderPageNumber')};
    string7 LegalLotNumber {xpath('LegalLotNumber')};
    string LegalSubdivision {xpath('LegalSubdivision'), maxlength(40)};
    string LegalBriefDescription {xpath('LegalBriefDescription'), maxlength(250)};
    string LegalLot {xpath('LegalLot'), maxlength(54)};
    string10 LegalLandLot {xpath('LegalLandLot')};
    string7 LegalBlock {xpath('LegalBlock')};
    string7 LegalSection {xpath('LegalSection')};
    string12 LegalDistrict {xpath('LegalDistrict')};
    string6 LegalUnit {xpath('LegalUnit')};
    string30 LegalCityMunicipalityTownship {xpath('LegalCityMunicipalityTownship')};
    string7 LegalPhaseNumber {xpath('LegalPhaseNumber')};
    string10 LegalTractNumber {xpath('LegalTractNumber')};
    string30 LegalSecTwnRngMer {xpath('LegalSecTwnRngMer')};
    string15 LegalAssessorMapRef {xpath('LegalAssessorMapRef')};
    _lt_LegalInfo LegalInfo {xpath('LegalInfo')};
    string10 CensusTract {xpath('CensusTract')};
    string17 OwnershipType {xpath('OwnershipType')};
    string35 NewRecordType {xpath('NewRecordType')};
    string1 TimeshareCode {xpath('TimeshareCode')};
    string25 Zoning {xpath('Zoning')};
    string20 RecorderDocumentNumber {xpath('RecorderDocumentNumber')};
    _lt_Date TransferDate {xpath('TransferDate')};
    string DocumentTypeDesc {xpath('DocumentTypeDesc'), maxlength(36)};
    _lt_Date PriorTransferDate {xpath('PriorTransferDate')};
    string25 DocumentType {xpath('DocumentType')};
    _lt_Date SaleDate {xpath('SaleDate')};
    string11 SalesPrice {xpath('SalesPrice')};
    string SalesPriceDescription {xpath('SalesPriceDescription'), maxlength(108)};
    string11 PriorSalesPrice {xpath('PriorSalesPrice')};
    string PriorSalesPriceDescription {xpath('PriorSalesPriceDescription'), maxlength(108)};
    string11 MortgageLoanAmount {xpath('MortgageLoanAmount')};
    string MortgageLoanType {xpath('MortgageLoanType'), maxlength(31)};
    string MortgageLender {xpath('MortgageLender'), maxlength(60)};
    string30 MortgageLenderType {xpath('MortgageLenderType')};
    string11 AssessedTotalValue {xpath('AssessedTotalValue')};
    string1 HomesteadHomeownerExemption {xpath('HomesteadHomeownerExemption')};
    string11 AssessedImprovementValue {xpath('AssessedImprovementValue')};
    string11 MarketLandValue {xpath('MarketLandValue')};
    string11 MarketImprovementValue {xpath('MarketImprovementValue')};
    string11 MarketTotalValue {xpath('MarketTotalValue')};
    string4 MarketValueYear {xpath('MarketValueYear')};
    string11 AssessedLandValue {xpath('AssessedLandValue')};
    string4 AssessedValueYear {xpath('AssessedValueYear')};
    string4 TaxYear {xpath('TaxYear')};
    string13 TaxAmount {xpath('TaxAmount')};
    string18 TaxRateCodeArea {xpath('TaxRateCodeArea')};
    string4 TaxDelinquentYear {xpath('TaxDelinquentYear')};
    string30 LandSquareFootage {xpath('LandSquareFootage')};
    string4 YearBuilt {xpath('YearBuilt')};
    string5 NoOfStories {xpath('NoOfStories')};
    string28 NoOfStoriesDesc {xpath('NoOfStoriesDesc')};
    string5 NoOfBedrooms {xpath('NoOfBedrooms')};
    string8 NoOfBaths {xpath('NoOfBaths')};
    string2 NoOfPartialBaths {xpath('NoOfPartialBaths')};
    string30 GarageType {xpath('GarageType')};
    string27 Pool {xpath('Pool')};
    string30 ExteriorWalls {xpath('ExteriorWalls')};
    string20 RoofType {xpath('RoofType')};
    string28 Heating {xpath('Heating')};
    string23 HeatingFuelTypeDesc {xpath('HeatingFuelTypeDesc')};
    string28 AirConditioning {xpath('AirConditioning')};
    string18 AirConditioningType {xpath('AirConditioningType')};
    string3 HeatingFuelTypeCode {xpath('HeatingFuelTypeCode')};
    string30 LandAcres {xpath('LandAcres')};
    string30 LandDimensions {xpath('LandDimensions')};
    string9 BuildingArea {xpath('BuildingArea')};
    string4 EffectiveYearBuilt {xpath('EffectiveYearBuilt')};
    string3 NoOfBuildings {xpath('NoOfBuildings')};
    string5 NoOfUnits {xpath('NoOfUnits')};
    string5 NoOfRooms {xpath('NoOfRooms')};
    string5 ParkingNoOfCars {xpath('ParkingNoOfCars')};
    string27 TypeConstructionDesc {xpath('TypeConstructionDesc')};
    string Foundation {xpath('Foundation'), maxlength(31)};
    string28 RoofCoverDesc {xpath('RoofCoverDesc')};
    string1 Elevator {xpath('Elevator')};
    string1 FireplaceIndicator {xpath('FireplaceIndicator')};
    string3 FireplaceNumber {xpath('FireplaceNumber')};
    string25 Basement {xpath('Basement')};
    string BuildingClassDesc {xpath('BuildingClassDesc'), maxlength(210)};
    string20 CondoProject {xpath('CondoProject')};
    string20 Building {xpath('Building')};
    string Comments {xpath('Comments'), maxlength(120)};
    string5 StyleCode {xpath('StyleCode')};
    string29 StyleDesc {xpath('StyleDesc')};
    string27 TypeConstructionCode {xpath('TypeConstructionCode')};
    string28 RoofCoverCode {xpath('RoofCoverCode')};
    string3 BuildingClassCode {xpath('BuildingClassCode')};
    string9 NeighborhoodCode {xpath('NeighborhoodCode')};
    string AddlLegal {xpath('AddlLegal'), maxlength(1924)};
    _lt_PropertyAssessmentSrcPrptyRcd SourcePropertyRecord {xpath('SourcePropertyRecord')};
    DATASET (DiffString) SchoolTaxDistricts {xpath('SchoolTaxDistricts/SchoolTaxDistrict'), MAXCOUNT(iesp.Constants.Prop.MaxSchoolTaxDistrict * 2)};
    DATASET (DiffString) TaxExemptions {xpath('TaxExemptions/TaxExemption'), MAXCOUNT(iesp.Constants.Prop.MaxTaxExemptions * 2)};
    DATASET (DiffString) BuildingAreas {xpath('BuildingAreas/BuildingArea'), MAXCOUNT(iesp.Constants.Prop.MaxBuildingAreas * 2)};
    dataset(_lt_BuildingAreaInfo) BuildingAreas2 {xpath('BuildingAreas2/BuildingArea'), MAXCOUNT(iesp.Constants.Prop.MaxBuildingAreas * 2)};
    DATASET (DiffString) SiteInfluences {xpath('SiteInfluences/SiteInfluence'), MAXCOUNT(iesp.Constants.Prop.MaxSiteInfluences * 2)};
    DATASET (DiffString) Amenities {xpath('Amenities/Amenity'), MAXCOUNT(iesp.Constants.Prop.MaxAmenities * 2)};
    DATASET (DiffString) OtherBuildings {xpath('OtherBuildings/Building'), MAXCOUNT(iesp.Constants.Prop.MaxOtherBuildings * 2)};
  END;

  EXPORT _lt_PartyInfo := RECORD
    string2 Id1Code {xpath('Id1Code')};
    string Id1Description {xpath('Id1Description'), maxlength(54)};
    string2 Id2Code {xpath('Id2Code')};
    string Id2Description {xpath('Id2Description'), maxlength(54)};
    string2 VestingCode {xpath('VestingCode')};
    string24 VestingDescription {xpath('VestingDescription')};
    string1 AddendumFlag {xpath('AddendumFlag')};
  END;

  EXPORT _lt_LenderInfo := RECORD
    string Name {xpath('Name'), maxlength(40)};
    string6 NameId {xpath('NameId')};
    string DbaAka {xpath('DbaAka'), maxlength(40)};
    string FullStreetAddress {xpath('FullStreetAddress'), maxlength(60)};
    string6 AddressUnitNumber {xpath('AddressUnitNumber')};
    string AddressCitystatezip {xpath('AddressCitystatezip'), maxlength(41)};
  END;

  EXPORT _lt_DeedSrcPrptyRcdInfo := RECORD
    string3 TransactionType {xpath('TransactionType')};
    string TransactionTypeDesc {xpath('TransactionTypeDesc'), maxlength(33)};
    string6 MortgageDeedType {xpath('MortgageDeedType')};
    string MortgageDeedTypeDesc {xpath('MortgageDeedTypeDesc'), maxlength(69)};
    string5 MortgageTermCode {xpath('MortgageTermCode')};
    string6 MortgageTermCodeDesc {xpath('MortgageTermCodeDesc')};
    string5 MortgageTerm {xpath('MortgageTerm')};
    string IrisApn {xpath('IrisApn'), maxlength(60)};
    string LenderAddress {xpath('LenderAddress'), maxlength(60)};
    _lt_Date MortgageDate {xpath('MortgageDate')};
    string9 BuildingSquareFeet {xpath('BuildingSquareFeet')};
    string1 Foreclosure {xpath('Foreclosure')};
    string19 ForeclosureDesc {xpath('ForeclosureDesc')};
    string1 RefiFlag {xpath('RefiFlag')};
    string22 RefiFlagDesc {xpath('RefiFlagDesc')};
    string1 EquityFlag {xpath('EquityFlag')};
    string11 EquityFlagDesc {xpath('EquityFlagDesc')};
  END;

  EXPORT _lt_PropertyDeed := RECORD
    string30 County {xpath('County')};
    string ParcelId {xpath('ParcelId'), maxlength(45)};
    string5 FipsCode {xpath('FipsCode')};
    string1 DeedType {xpath('DeedType')};
    string DeedTypeDesc {xpath('DeedTypeDesc'), maxlength(77)};
    string MortgageDeedSubType {xpath('MortgageDeedSubType')};
    string4 MultiApnFlag {xpath('MultiApnFlag')};
    string TaxIdNumber {xpath('TaxIdNumber'), maxlength(39)};
    string10 PhoneNumber {xpath('PhoneNumber')};
    string1 PropertyAddressCode {xpath('PropertyAddressCode')};
    string PropertyAddressDesc {xpath('PropertyAddressDesc'), maxlength(76)};
    string2 Buyer1IdCode {xpath('Buyer1IdCode')};
    string2 Buyer2IdCode {xpath('Buyer2IdCode')};
    string24 BuyerVestingCode {xpath('BuyerVestingCode')};
    string1 BuyerAddendumFlag {xpath('BuyerAddendumFlag')};
    string Buyer1IdDesc {xpath('Buyer1IdDesc'), maxlength(54)};
    string Buyer2IdDesc {xpath('Buyer2IdDesc'), maxlength(54)};
    string24 BuyerVestingDesc {xpath('BuyerVestingDesc')};
    _lt_PartyInfo BuyersInfo {xpath('BuyersInfo')};
    string2 Borrower1IdCode {xpath('Borrower1IdCode')};
    string2 Borrower2IdCode {xpath('Borrower2IdCode')};
    string2 BorrowerVestingCode {xpath('BorrowerVestingCode')};
    string Borrower1IdDesc {xpath('Borrower1IdDesc'), maxlength(54)};
    string Borrower2IdDesc {xpath('Borrower2IdDesc'), maxlength(54)};
    string24 BorrowerVestingDesc {xpath('BorrowerVestingDesc')};
    _lt_PartyInfo BorrowersInfo {xpath('BorrowersInfo')};
    string2 Seller1IdCode {xpath('Seller1IdCode')};
    string3 Seller2IdCode {xpath('Seller2IdCode')};
    string1 SellerAddendumFlag {xpath('SellerAddendumFlag')};
    string Seller1IdDesc {xpath('Seller1IdDesc'), maxlength(54)};
    string Seller2IdDesc {xpath('Seller2IdDesc'), maxlength(54)};
    _lt_PartyInfo SellersInfo {xpath('SellersInfo')};
    string Lender {xpath('Lender'), maxlength(40)};
    string6 LenderNameId {xpath('LenderNameId')};
    string LenderDbaAka {xpath('LenderDbaAka'), maxlength(40)};
    string LenderFullStreetAddress {xpath('LenderFullStreetAddress'), maxlength(60)};
    string6 LenderAddressUnitNumber {xpath('LenderAddressUnitNumber')};
    string LenderAddressCitystatezip {xpath('LenderAddressCitystatezip'), maxlength(41)};
    _lt_LenderInfo LenderInfo {xpath('LenderInfo')};
    _lt_Date ContractDate {xpath('ContractDate')};
    _lt_Date RecordingDate {xpath('RecordingDate')};
    string3 DocumentTypeCode {xpath('DocumentTypeCode')};
    string DocumentTypeDesc {xpath('DocumentTypeDesc'), maxlength(70)};
    _lt_Date ArmResetDate {xpath('ArmResetDate')};
    string20 DocumentNumber {xpath('DocumentNumber')};
    string10 RecorderBookNumber {xpath('RecorderBookNumber')};
    string10 RecorderPageNumber {xpath('RecorderPageNumber')};
    string10 LandLotSize {xpath('LandLotSize')};
    string LegalBriefDescription {xpath('LegalBriefDescription'), maxlength(100)};
    string2 LegalLotCode {xpath('LegalLotCode')};
    string LegalLotDesc {xpath('LegalLotDesc'), maxlength(54)};
    string10 LegalLotNumber {xpath('LegalLotNumber')};
    string7 LegalBlock {xpath('LegalBlock')};
    string7 LegalSection {xpath('LegalSection')};
    string7 LegalDistrict {xpath('LegalDistrict')};
    string7 LegalLandLot {xpath('LegalLandLot')};
    string6 LegalUnit {xpath('LegalUnit')};
    string30 LegalCityMunicipalityTownship {xpath('LegalCityMunicipalityTownship')};
    string LegalSubdivision {xpath('LegalSubdivision'), maxlength(50)};
    string7 LegalPhaseNumber {xpath('LegalPhaseNumber')};
    string10 LegalTractNumber {xpath('LegalTractNumber')};
    string30 LegalSecTwnRngMer {xpath('LegalSecTwnRngMer')};
    _lt_LegalInfo LegalInfo {xpath('LegalInfo')};
    string20 RecorderMapReference {xpath('RecorderMapReference')};
    string1 CompleteLegalDescriptionCode {xpath('CompleteLegalDescriptionCode')};
    string20 LoanNumber {xpath('LoanNumber')};
    string19 ConcurrentMortgageBookPageDocumentNumber {xpath('ConcurrentMortgageBookPageDocumentNumber')};
    string6 HawaiiTct {xpath('HawaiiTct')};
    string4 HawaiiCondoCprCode {xpath('HawaiiCondoCprCode')};
    string30 HawaiiCondo {xpath('HawaiiCondo')};
    string1 FillerExceptHawaii {xpath('FillerExceptHawaii')};
    string11 SalesPrice {xpath('SalesPrice')};
    string8 CityTransferTax {xpath('CityTransferTax')};
    string8 CountyTransferTax {xpath('CountyTransferTax')};
    string8 TotalTransferTax {xpath('TotalTransferTax')};
    string1 SalesPriceCode {xpath('SalesPriceCode')};
    string SalesPriceDesc {xpath('SalesPriceDesc'), maxlength(143)};
    string10 ExciseTaxNumber {xpath('ExciseTaxNumber')};
    string3 PropertyUseCode {xpath('PropertyUseCode')};
    string PropertyUseDesc {xpath('PropertyUseDesc'), maxlength(41)};
    string4 AssessmentMatchLandUseCode {xpath('AssessmentMatchLandUseCode')};
    string AssessmentMatchLandUseDesc {xpath('AssessmentMatchLandUseDesc'), maxlength(76)};
    string1 CondoCode {xpath('CondoCode')};
    string17 CondoDesc {xpath('CondoDesc')};
    string1 TimeshareFlag {xpath('TimeshareFlag')};
    string11 FirstTdLoanAmount {xpath('FirstTdLoanAmount')};
    string FirstTdLoanType {xpath('FirstTdLoanType'), maxlength(39)};
    string4 TypeFinancing {xpath('TypeFinancing')};
    string27 TypeFinancingDesc {xpath('TypeFinancingDesc')};
    string5 FirstTdInterestRate {xpath('FirstTdInterestRate')};
    _lt_Date FirstTdDueDate {xpath('FirstTdDueDate')};
    string TitleCompany {xpath('TitleCompany'), maxlength(60)};
    string1 RateChangeFrequency {xpath('RateChangeFrequency')};
    string27 RateChangeFrequencyDesc {xpath('RateChangeFrequencyDesc')};
    string4 ChangeIndex {xpath('ChangeIndex')};
    string15 AdjustableRateIndex {xpath('AdjustableRateIndex')};
    string AdjustableRateIndexDesc {xpath('AdjustableRateIndexDesc'), maxlength(55)};
    string1 AdjustableRateRider {xpath('AdjustableRateRider')};
    string1 GraduatedPaymentRider {xpath('GraduatedPaymentRider')};
    string1 BalloonRider {xpath('BalloonRider')};
    string1 FixedStepRateRider {xpath('FixedStepRateRider')};
    string1 CondominiumRider {xpath('CondominiumRider')};
    string1 PlannedUnitDevelopmentRider {xpath('PlannedUnitDevelopmentRider')};
    string1 RateImprovementRider {xpath('RateImprovementRider')};
    string1 AssumabilityRider {xpath('AssumabilityRider')};
    string1 PrepaymentRider {xpath('PrepaymentRider')};
    string1 OneFourFamilyRider {xpath('OneFourFamilyRider')};
    string1 BiweeklyPaymentRider {xpath('BiweeklyPaymentRider')};
    string1 SecondHomeRider {xpath('SecondHomeRider')};
    string11 SecondTdLoanAmount {xpath('SecondTdLoanAmount')};
    string1 FirstTdLenderTypeCode {xpath('FirstTdLenderTypeCode')};
    string26 FirstTdLenderTypeDesc {xpath('FirstTdLenderTypeDesc')};
    string5 SecondTdLenderTypeCode {xpath('SecondTdLenderTypeCode')};
    string26 SecondTdLenderTypeDesc {xpath('SecondTdLenderTypeDesc')};
    string3 PartialInterestTransferred {xpath('PartialInterestTransferred')};
    string5 LoanTermMonths {xpath('LoanTermMonths')};
    string5 LoanTermYears {xpath('LoanTermYears')};
    _lt_Date FaresMortgageDate {xpath('FaresMortgageDate')};
    string9 FaresBuildingSquareFeet {xpath('FaresBuildingSquareFeet')};
    string1 FaresForeclosure {xpath('FaresForeclosure')};
    string19 FaresForeclosureDesc {xpath('FaresForeclosureDesc')};
    string1 FaresRefiFlag {xpath('FaresRefiFlag')};
    string22 FaresRefiFlagDesc {xpath('FaresRefiFlagDesc')};
    string1 FaresEquityFlag {xpath('FaresEquityFlag')};
    string11 FaresEquityFlagDesc {xpath('FaresEquityFlagDesc')};
    string3 FaresTransactionType {xpath('FaresTransactionType')};
    string FaresTransactionTypeDesc {xpath('FaresTransactionTypeDesc'), maxlength(33)};
    string6 FaresMortgageDeedType {xpath('FaresMortgageDeedType')};
    string FaresMortgageDeedTypeDesc {xpath('FaresMortgageDeedTypeDesc'), maxlength(69)};
    string4 FaresMortgageTermCode {xpath('FaresMortgageTermCode')};
    string6 FaresMortgageTermCodeDesc {xpath('FaresMortgageTermCodeDesc')};
    string5 FaresMortgageTerm {xpath('FaresMortgageTerm')};
    string FaresIrisApn {xpath('FaresIrisApn'), maxlength(60)};
    string FaresLenderAddress {xpath('FaresLenderAddress'), maxlength(60)};
    _lt_DeedSrcPrptyRcdInfo DeedSourcePropertyRecord {xpath('DeedSourcePropertyRecord')};
  END;

  EXPORT _lt_Property2Name := RECORD (_lt_NameAndCompany)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string12 UniqueId {xpath('UniqueId')};
    string12 BusinessId {xpath('BusinessId')};
    string9 AppendedSSN {xpath('AppendedSSN')};
    integer LinkingWeight {xpath('LinkingWeight')};//hidden[internal]
  END;

  EXPORT _lt_GeoLocation := RECORD
    string10 Latitude {xpath('Latitude')};
    string11 Longitude {xpath('Longitude')};
  END;

  EXPORT _lt_PhoneInfo := RECORD
    string10 Phone10 {xpath('Phone10')};
    string1 PubNonpub {xpath('PubNonpub')};
    string10 ListingPhone10 {xpath('ListingPhone10')};
    string120 ListingName {xpath('ListingName')};
    string4 TimeZone {xpath('TimeZone')};
    string4 ListingTimeZone {xpath('ListingTimeZone')};
  END;

  EXPORT _lt_OriginalName := RECORD
    string4 NameSeq {xpath('NameSeq')};
    string Name {xpath('Name'), maxlength(120)};
    string IdDescription {xpath('IdDescription'), maxlength(54)};
    integer LinkingWeight {xpath('LinkingWeight')};//hidden[internal]
  END;

  EXPORT _lt_Property2Entity := RECORD
    dataset(_lt_Property2Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.Prop.MaxNames * 2)};
    DATASET (DiffString) OriginalNames {xpath('OriginalNames/Name'), MAXCOUNT(iesp.Constants.Prop.MaxOriginalNames * 2)};
    dataset(_lt_OriginalName) OriginalNames2 {xpath('OriginalNames2/OriginalName'), MAXCOUNT(iesp.Constants.Prop.MaxOriginalNames * 2)};
    _lt_Address Address {xpath('Address')};
    _lt_GeoLocation GeoLocation {xpath('GeoLocation')};
    _lt_PhoneInfo Phone {xpath('Phone')};
    string1 EntityTypeCode {xpath('EntityTypeCode')};
    string8 EntityType {xpath('EntityType')};
    _lt_Address OriginalAddress {xpath('OriginalAddress')};
    string4 Lot {xpath('Lot')};
    string1 LotOrder {xpath('LotOrder')};
    integer LinkingWeight {xpath('LinkingWeight')};//hidden[internal]
  END;

  EXPORT _lt_PropertyReport2Record := RECORD
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string1 DataSource {xpath('DataSource')};
    string12 FaresId {xpath('FaresId')};
    string12 SourcePropertyRecordId {xpath('SourcePropertyRecordId')};
    string1 RecordType {xpath('RecordType')};
    string8 RecordTypeDesc {xpath('RecordTypeDesc')};
    string ParcelNumber {xpath('ParcelNumber'), maxlength(45)};
    string4 OutputSeqNo {xpath('OutputSeqNo')};
    _lt_PropertyAssessment Assessment {xpath('Assessment')};
    _lt_PropertyDeed Deed {xpath('Deed')};
    dataset(_lt_Property2Entity) Entities {xpath('Entities/Entity'), MAXCOUNT(iesp.Constants.Prop.MaxEntities * 2)};
  END;

  EXPORT _lt_BaseMarriageSearch2Record := RECORD
    boolean AlsoFound {xpath('AlsoFound')};
    string15 RecordId {xpath('RecordId')};
    string10 FilingType {xpath('FilingType')};
    string1 FilingTypeCode {xpath('FilingTypeCode')};
    string20 StateOrigin {xpath('StateOrigin')};
    string50 FilingNumber {xpath('FilingNumber')};
    _lt_Date FilingDate {xpath('FilingDate')};
    _lt_Date MarriageDate {xpath('MarriageDate')};
    _lt_Date DivorceDate {xpath('DivorceDate')};
    string35 CountyOrigin {xpath('CountyOrigin')};
    string35 DivorceCounty {xpath('DivorceCounty')};
    string30 CityOrigin {xpath('CityOrigin')};
    string50 DivorceGrounds {xpath('DivorceGrounds')};
    integer NumberOfChildren {xpath('NumberOfChildren')};
    string10 Ceremony {xpath('Ceremony')};
    string10 PlaceOfMarriage {xpath('PlaceOfMarriage')};
    string255 ExternalKey {xpath('ExternalKey')};
    string ExternalKey_2 {xpath('ExternalKey_2')};//hidden[internal]
  END;

  EXPORT _lt_MarriageSearch2Party := RECORD
    string UniqueId {xpath('UniqueId')};
    string10 PartyType {xpath('PartyType')};
    string2 PartyTypeCode {xpath('PartyTypeCode')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    integer Age {xpath('Age')};
    integer TimesMarried {xpath('TimesMarried')};
    _lt_Date DOB {xpath('DOB')};
    string20 PreviousMaritalStatus {xpath('PreviousMaritalStatus')};
    string2 BirthState {xpath('BirthState')};
    string20 HowMarriageEnded {xpath('HowMarriageEnded')};
    string30 Race {xpath('Race')};
  END;

  EXPORT _lt_MarriageSearch2Record := RECORD (_lt_BaseMarriageSearch2Record)
    _lt_MarriageSearch2Party Party1 {xpath('Party1')};
    _lt_MarriageSearch2Party Party2 {xpath('Party2')};
  END;

  EXPORT _lt_CollegeData := RECORD
    string50 Name {xpath('Name')};
    string50 Major {xpath('Major')};
    string25 Level {xpath('Level')};
    string30 _Type {xpath('Type')};
    string50 OriginalName {xpath('OriginalName')};
  END;

  EXPORT _lt_StudentData := RECORD
    string1 AttendedHighSchool {xpath('AttendedHighSchool')};
    string2 YearsSinceHSGraduation {xpath('YearsSinceHSGraduation')};
    string1 AttendedCollege1 {xpath('AttendedCollege1')};
    string1 CollegePublicPrivate1 {xpath('CollegePublicPrivate1')};
    string1 College2Yr4YrGrad1 {xpath('College2Yr4YrGrad1')};
    string2 CollegeEducationProgramTier1 {xpath('CollegeEducationProgramTier1')};
    string1 AttendedCollege2 {xpath('AttendedCollege2')};
    string1 CollegePublicPrivate2 {xpath('CollegePublicPrivate2')};
    string1 College2Yr4YrGrad2 {xpath('College2Yr4YrGrad2')};
    string2 CollegeEducationProgramTier2 {xpath('CollegeEducationProgramTier2')};
  END;

  EXPORT _lt_StudentRecord := RECORD
    _lt_Name Name {xpath('Name')};
    string12 UniqueId {xpath('UniqueId')};//hidden[internal]
    _lt_Date FirstReported {xpath('FirstReported')};
    _lt_Date LastReported {xpath('LastReported')};
    string4 HighSchoolGradYear {xpath('HighSchoolGradYear')};
    _lt_Address AddressAtCollege {xpath('AddressAtCollege')};
    string10 PhoneAtCollege {xpath('PhoneAtCollege')};
    string11 SSN {xpath('SSN')};
    _lt_MaskableDate DOB {xpath('DOB')};
    string30 ClassRank {xpath('ClassRank')};
    string30 SchoolPeriod {xpath('SchoolPeriod')};
    string20 SchoolSize {xpath('SchoolSize')};
    string20 Tuition {xpath('Tuition')};
    boolean IsCurrent {xpath('IsCurrent')};
    _lt_CollegeData CollegeData {xpath('CollegeData')};
    _lt_StudentData StudentData {xpath('StudentData')};
    integer _Penalty {xpath('Penalty')};//hidden[ecldev]
    boolean AlsoFound {xpath('AlsoFound')};
  END;

  EXPORT _lt_SSNInfoBase := RECORD
    string9 SSN {xpath('SSN')};
    string5 Valid {xpath('Valid')};
    string32 IssuedLocation {xpath('IssuedLocation')};
    _lt_Date IssuedStartDate {xpath('IssuedStartDate')};
    _lt_Date IssuedEndDate {xpath('IssuedEndDate')};
  END;

  EXPORT _lt_SSNInfo := RECORD (_lt_SSNInfoBase)
    integer FDNSsnInd {xpath('FDNSsnInd')};
  END;

  EXPORT _lt_RiskIndicator := RECORD
    string4 RiskCode {xpath('RiskCode')};
    string150 Description {xpath('Description')};
  END;

  EXPORT _lt_SSNInfoEx := RECORD (_lt_SSNInfo)
    dataset(_lt_RiskIndicator) HighRiskIndicators {xpath('HighRiskIndicators/HighRiskIndicator'), MAXCOUNT(Constants.MaxCountHRI * 2)};
  END;

  EXPORT _lt_Identity := RECORD
    string12 UniqueId {xpath('UniqueId')};
    _lt_Name Name {xpath('Name')};
    string6 Gender {xpath('Gender')};
    _lt_SSNInfoEx SSNInfoEx {xpath('SSNInfoEx')};
    _lt_Date DOB {xpath('DOB')};
    _lt_Date DOD {xpath('DOD')};
    integer Age {xpath('Age')};
    integer AgeAtDeath {xpath('AgeAtDeath')};
    string18 DeathCounty {xpath('DeathCounty')};
    string2 DeathState {xpath('DeathState')};
    string1 DeathVerificationCode {xpath('DeathVerificationCode')};
    string1 Deceased {xpath('Deceased')}; 
  END;

  EXPORT _lt_BpsReportDriverLicense := RECORD
    string24 LicenseNumber {xpath('LicenseNumber')};
    _lt_Date IssueDate {xpath('IssueDate')};
    _lt_Date OriginalIssueDate {xpath('OriginalIssueDate')};
    string2 IssueState {xpath('IssueState')};
    string75 LicenseType {xpath('LicenseType')};
    string75 LicenseClass {xpath('LicenseClass')};
    string14 Attention {xpath('Attention')};
    string4 LicenseTypeCode {xpath('LicenseTypeCode')};
    string42 RestrictionCodes {xpath('RestrictionCodes')};
    string10 EndorsementCodes {xpath('EndorsementCodes')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    _lt_Date DOB {xpath('DOB')};
    integer Age {xpath('Age')};
    string9 SSN {xpath('SSN')};
    string7 Sex {xpath('Sex')};
    string15 Race {xpath('Race')};
    string3 Height {xpath('Height')};
    string3 Weight {xpath('Weight')};
    string3 HairColor {xpath('HairColor')};
    string3 EyeColor {xpath('EyeColor')};
    string10 History {xpath('History')};
    string20 StateName {xpath('StateName')};
    string2 Src {xpath('Src')};//hidden[internal]
    string1 NonDMVSource {xpath('NonDMVSource')};
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    boolean IsAccurintData {xpath('IsAccurintData')};//hidden[internal]
    DATASET (DiffString) Restrictions {xpath('Restrictions/Restriction'), MAXCOUNT(iesp.constants.DL.MaxCountRestrictions * 2)};
    DATASET (DiffString) Endorsements {xpath('Endorsements/Endorsement'), MAXCOUNT(iesp.constants.DL.MaxCountEndorsements * 2)};
  END;

  EXPORT _lt_PlaceOfBirth := RECORD
    string CountryCode {xpath('CountryCode')};
    string CountyCode {xpath('CountyCode')};
    string StateCode {xpath('StateCode')};
    string CityCode {xpath('CityCode')};
    string FullDescription {xpath('FullDescription')};
  END;

  EXPORT _lt_AdditionalNumber := RECORD
    string TypeCode {xpath('TypeCode')};
    string _Type {xpath('Type')};
    string LocationCode {xpath('LocationCode')};
    string Location {xpath('Location')};
    string Number {xpath('Number')};
  END;

  EXPORT _lt_MatrixCrimReportAppend := RECORD
    _lt_Date ProcessDate {xpath('ProcessDate')};
    string Vendor {xpath('Vendor')};
    string StateOrigin {xpath('StateOrigin')};
    string OffenderId {xpath('OffenderId')};
    string SequenceNumber {xpath('SequenceNumber')};
    string Occupation {xpath('Occupation')};
    string Employer {xpath('Employer')};
    string Fingerprints {xpath('Fingerprints')};
    string LeftFingerprintCodes {xpath('LeftFingerprintCodes')};
    string RightFingerprintCodes {xpath('RightFingerprintCodes')};
    _lt_PlaceOfBirth PlaceOfBirth {xpath('PlaceOfBirth')};
    string StateSpecificFields {xpath('StateSpecificFields')};
    DATASET (DiffString) ScarMarkTattoos {xpath('ScarMarkTattoos/ScarMarkTattoo'), MAXCOUNT(10)};
    dataset(_lt_Date) DOBs {xpath('DOBs/DOB'), MAXCOUNT(10)};
    DATASET (DiffString) SSNs {xpath('SSNs/SSN'), MAXCOUNT(10)};
    dataset(_lt_AdditionalNumber) AdditionalNumbers {xpath('AdditionalNumbers/AdditionalNumber'), MAXCOUNT(10)};
  END;

  EXPORT _lt_MatrixCrimReportIdentity := RECORD
    string StateOriginName {xpath('StateOriginName')};
    string StateOriginCode {xpath('StateOriginCode')};
    string DataType {xpath('DataType')};
    string SourceFile {xpath('SourceFile')};
    string CaseNumber {xpath('CaseNumber')};
    string CaseCourt {xpath('CaseCourt')};
    string CaseName {xpath('CaseName')};
    string CaseTypeCode {xpath('CaseTypeCode')};
    string CaseType {xpath('CaseType')};
    _lt_Date CaseFilingDate {xpath('CaseFilingDate')};
    string PartyName {xpath('PartyName')};
    string PartyNameFormat {xpath('PartyNameFormat')};
    string PartyStatusCode {xpath('PartyStatusCode')};
    string PartyStatus {xpath('PartyStatus')};
    string PartyType {xpath('PartyType')};
    boolean NonOffenderRecord {xpath('NonOffenderRecord')};
    string SSN {xpath('SSN')};
    string SSNOrigin {xpath('SSNOrigin')};
    string UniqueId {xpath('UniqueId')};
    string DriverLicenseNumber {xpath('DriverLicenseNumber')};
    string DriverLicenseState {xpath('DriverLicenseState')};
    string DriverLicenseNumberOrigin {xpath('DriverLicenseNumberOrigin')};
    string DriverLicenseStateOrigin {xpath('DriverLicenseStateOrigin')};
    string DLENumber {xpath('DLENumber')};
    string FBINumber {xpath('FBINumber')};
    string DOCNumber {xpath('DOCNumber')};
    string INSNumber {xpath('INSNumber')};
    string IDNumber {xpath('IDNumber')};
    _lt_Name NameOrigin {xpath('NameOrigin')};
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    _lt_Date DOB {xpath('DOB')};
    string PlaceOfBirth {xpath('PlaceOfBirth')};
    string Citizenship {xpath('Citizenship')};
    string RaceCode {xpath('RaceCode')};
    string Race {xpath('Race')};
    string Sex {xpath('Sex')};
    string HairColorCode {xpath('HairColorCode')};
    string HairColor {xpath('HairColor')};
    string EyeColorCode {xpath('EyeColorCode')};
    string EyeColor {xpath('EyeColor')};
    string SkinColorCode {xpath('SkinColorCode')};
    string SkinColor {xpath('SkinColor')};
    string Height {xpath('Height')};
    string Weight {xpath('Weight')};
    DATASET (DiffString) RawAddress {xpath('RawAddress/AddressLine'), MAXCOUNT(10)};
  END;

  EXPORT _lt_MatrixCrimReportAgency := RECORD
    string AgencyId {xpath('AgencyId')};
    string AgencyIdCode {xpath('AgencyIdCode')};
    string AgencyCaseNumber {xpath('AgencyCaseNumber')};
  END;

  EXPORT _lt_MatrixCrimReportOffenseCharge := RECORD
    string OffenseNumeric {xpath('OffenseNumeric')};
    string OffenseLiteral {xpath('OffenseLiteral')};
    string OffenseCharacter {xpath('OffenseCharacter')};
    string ChargeStatus {xpath('ChargeStatus')};
    string ChargeLevelDegree {xpath('ChargeLevelDegree')};
    string ChargeStatute {xpath('ChargeStatute')};
    string ChargeQualifier {xpath('ChargeQualifier')};
    string ChargeRange {xpath('ChargeRange')};
    string ChargeAmount {xpath('ChargeAmount')};
    string ChargeUnit {xpath('ChargeUnit')};
    string ChargeCounts {xpath('ChargeCounts')};
  END;

  EXPORT _lt_MatrixCrimReportCharge := RECORD
    string StateSpecificChargeFields {xpath('StateSpecificChargeFields')};
    string ChargeNumber {xpath('ChargeNumber')};
    _lt_Date OffenseDate {xpath('OffenseDate')};
    _lt_MatrixCrimReportOffenseCharge OffenseCharge {xpath('OffenseCharge')};
    string NoFingerprintClass {xpath('NoFingerprintClass')};
    _lt_Date EntryDate {xpath('EntryDate')};
    _lt_Date LastUpdateDate {xpath('LastUpdateDate')};
    string ModifyCount {xpath('ModifyCount')};
    string VictimType {xpath('VictimType')};
    boolean DomesticViolenceFlag {xpath('DomesticViolenceFlag')};
    _lt_Date DispositionDate {xpath('DispositionDate')};
    DATASET (DiffString) DispositionCodes {xpath('DispositionCodes/DispositionCode'), MAXCOUNT(10)};
    DATASET (DiffString) Dispositions {xpath('Dispositions/Disposition'), MAXCOUNT(10)};
  END;

  EXPORT _lt_MatrixCrimReportJudicialCharge := RECORD
    string ArrestChargeNumber {xpath('ArrestChargeNumber')};
    string ArrestChargeStatus {xpath('ArrestChargeStatus')};
    string ArrestChargeLevelDegree {xpath('ArrestChargeLevelDegree')};
    string StateSpecificFields {xpath('StateSpecificFields')};
    _lt_MatrixCrimReportOffenseCharge ProsecutionCharge {xpath('ProsecutionCharge')};
    string ProsecutionDispositionCode {xpath('ProsecutionDispositionCode')};
    _lt_Date ProsecutionDispositionDate {xpath('ProsecutionDispositionDate')};
    _lt_MatrixCrimReportOffenseCharge CourtCharge {xpath('CourtCharge')};
    string CourtDispositionCode {xpath('CourtDispositionCode')};
    _lt_Date CourtDispositionDate {xpath('CourtDispositionDate')};
    _lt_Date SentenceDate {xpath('SentenceDate')};
    string ProbationLength {xpath('ProbationLength')};
    string CommunityControl {xpath('CommunityControl')};
    string DriverLicenseSuspensionLength {xpath('DriverLicenseSuspensionLength')};
    string CourtFine {xpath('CourtFine')};
    string Restitution {xpath('Restitution')};
    string CourtCost {xpath('CourtCost')};
    string SentenceLiteral {xpath('SentenceLiteral')};
    string CourtTimeServed {xpath('CourtTimeServed')};
    string CounselType {xpath('CounselType')};
    string PleaType {xpath('PleaType')};
    string TrialType {xpath('TrialType')};
    string FinalDisposition {xpath('FinalDisposition')};
    string CcCsIndictator {xpath('CcCsIndictator')};
    string CcCsOffenseReference {xpath('CcCsOffenseReference')};
    string SentenceConfinement {xpath('SentenceConfinement')};
    string SentenceProvision {xpath('SentenceProvision')};
    string SentenceDocketNumber {xpath('SentenceDocketNumber')};
    string SentenceStatus {xpath('SentenceStatus')};
    string ConfinementLength {xpath('ConfinementLength')};
    string SuspendedConfinement {xpath('SuspendedConfinement')};
    _lt_Date EntryDate {xpath('EntryDate')};
    _lt_Date LastUpdateDate {xpath('LastUpdateDate')};
    _lt_Date JudicialAppealDate {xpath('JudicialAppealDate')};
    integer ModifyCount {xpath('ModifyCount')};
    boolean DomesticViolenceFlag {xpath('DomesticViolenceFlag')};
    string FillerToBeKnown {xpath('FillerToBeKnown')};
    string NoFingerprintClass {xpath('NoFingerprintClass')};
    DATASET (DiffString) CourtProvisionCodes {xpath('CourtProvisionCodes/CourtProvisionCode'), MAXCOUNT(10)};
  END;

  EXPORT _lt_MatrixCrimReportJudicial := RECORD
    _lt_Date ProcessDate {xpath('ProcessDate')};
    string OffenderId {xpath('OffenderId')};
    string Vendor {xpath('Vendor')};
    string StateOrigin {xpath('StateOrigin')};
    string DLENumber {xpath('DLENumber')};
    string StateSpecificFields {xpath('StateSpecificFields')};
    string ArrestTrackingNumber {xpath('ArrestTrackingNumber')};
    _lt_Date ArrestDate {xpath('ArrestDate')};
    string ArrestSequenceCode {xpath('ArrestSequenceCode')};
    _lt_MatrixCrimReportAgency JudicialAgency {xpath('JudicialAgency')};
    string JudicialSequenceNumber {xpath('JudicialSequenceNumber')};
    dataset(_lt_MatrixCrimReportJudicialCharge) JudicialCharges {xpath('JudicialCharges/JudicialCharge'), MAXCOUNT(10)};
  END;

  EXPORT _lt_MatrixCrimReportEvent := RECORD
    _lt_Date SortDate {xpath('SortDate')};
    _lt_Date ArrestDate {xpath('ArrestDate')};
    _lt_Date StatusStartDate {xpath('StatusStartDate')};
    _lt_Date ScheduledEndDate {xpath('ScheduledEndDate')};
    _lt_Date ActualEndDate {xpath('ActualEndDate')};
    _lt_Date EntryDate {xpath('EntryDate')};
    _lt_Date LastUpdateDate {xpath('LastUpdateDate')};
    string EventType {xpath('EventType')};
    string StateSpecificFields {xpath('StateSpecificFields')};
    string ArrestTrackingNumber {xpath('ArrestTrackingNumber')};
    string RestrictedService {xpath('RestrictedService')};
    string StatusChange {xpath('StatusChange')};
    string SuspendedStatus {xpath('SuspendedStatus')};
    _lt_MatrixCrimReportAgency Agency {xpath('Agency')};
    string Status1 {xpath('Status1')};
    string Status2 {xpath('Status2')};
    string NoFingerprintClass {xpath('NoFingerprintClass')};
    integer ModifyCount {xpath('ModifyCount')};
  END;

  EXPORT _lt_MatrixCrimReportArrest := RECORD
    _lt_Date ProcessDate {xpath('ProcessDate')};
    string OffenderId {xpath('OffenderId')};
    string Vendor {xpath('Vendor')};
    string StateOrigin {xpath('StateOrigin')};
    string DLENumber {xpath('DLENumber')};
    string StateSpecificFields {xpath('StateSpecificFields')};
    string ArrestTrackingNumber {xpath('ArrestTrackingNumber')};
    _lt_Date ArrestDate {xpath('ArrestDate')};
    integer ArrestCount {xpath('ArrestCount')};
    string SequenceCode {xpath('SequenceCode')};
    dataset(_lt_MatrixCrimReportAgency) ArrestAgencies {xpath('ArrestAgencies/ArrestAgency'), MAXCOUNT(10)};
    dataset(_lt_MatrixCrimReportCharge) ArrestCharges {xpath('ArrestCharges/ArrestCharge'), MAXCOUNT(10)};
    dataset(_lt_MatrixCrimReportJudicial) Judicials {xpath('Judicials/Judicial'), MAXCOUNT(10)};
    dataset(_lt_MatrixCrimReportEvent) Events {xpath('Events/Event'), MAXCOUNT(10)};
  END;

  EXPORT _lt_MatrixCrimReportRecord := RECORD
    dataset(_lt_MatrixCrimReportAppend) Appends {xpath('Appends/Append'), MAXCOUNT(10)};
    dataset(_lt_MatrixCrimReportIdentity) Identities {xpath('Identities/Identity'), MAXCOUNT(10)};
    dataset(_lt_MatrixCrimReportArrest) Arrests {xpath('Arrests/Arrest'), MAXCOUNT(10)};
  END;

  EXPORT _lt_BpsReportIdentity := RECORD (_lt_Identity), MAXLENGTH (852233)
    boolean HasConcealedWeapon {xpath('HasConcealedWeapon')};
    string ConcealedWeaponId {xpath('ConcealedWeaponId')};
    boolean HasCriminalConviction {xpath('HasCriminalConviction')};
    string CriminalConvictionId {xpath('CriminalConvictionId')};
    boolean IsSexualOffender {xpath('IsSexualOffender')};
    string SexualOffenderId {xpath('SexualOffenderId')};
    boolean HasCorporateAffiliation {xpath('HasCorporateAffiliation')};
    boolean IsCurrentName {xpath('IsCurrentName')};
    boolean IsCorrectDOB {xpath('IsCorrectDOB')};
    _lt_Date UtilityFactorDate {xpath('UtilityFactorDate')};
    integer FDNDidInd {xpath('FDNDidInd')};
    dataset(_lt_BpsReportDriverLicense) DriverLicenses {xpath('DriverLicenses/DriverLicense'), MAXCOUNT(iesp.Constants.DL.MaxCOuntDL * 2)};
    dataset(_lt_DLEmbeddedReport2Record) DriverLicenses2 {xpath('DriverLicenses2/DriverLicense'), MAXCOUNT(iesp.Constants.DL.MaxCountDL * 2)};
    dataset(_lt_MatrixCrimReportRecord) CriminalHistories {xpath('CriminalHistories/CriminalHistory'), MAXCOUNT(iesp.Constants.BR.MaxCrimHistoryRecords * 2)};//hidden[internal]
    string SubjectSSNIndicator {xpath('SubjectSSNIndicator')}; 
  END;

  EXPORT _lt_BpsReportImposter := RECORD
    dataset(_lt_BpsReportIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.Constants.BR.MaxImposters_AKA * 2)};
  END;

  EXPORT _lt_DeathReportDecedent := RECORD
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    _lt_Date DOB {xpath('DOB')};
    _lt_Date DOD {xpath('DOD')};
    string Sex {xpath('Sex')};
    string Race {xpath('Race')};
    string UniqueId {xpath('UniqueId')};
    string SSN {xpath('SSN')};
    string BirthPlace {xpath('BirthPlace')};
    integer DeathAge {xpath('DeathAge')};
    string DeathAgeUnit {xpath('DeathAgeUnit')};
    string BirthCertificateNumber {xpath('BirthCertificateNumber')};
    string BirthVolYear {xpath('BirthVolYear')};
    string Education {xpath('Education')};
    string Occupation {xpath('Occupation')};
    string MaritalStatus {xpath('MaritalStatus')};
    string ArmedForces {xpath('ArmedForces')}; 
  END;

  EXPORT _lt_DeathReportDecedentFamily := RECORD
    string Father {xpath('Father')};
    string Mother {xpath('Mother')};
  END;

  EXPORT _lt_DeathReportDeathInfo := RECORD
    string IssuingAuthority {xpath('IssuingAuthority')};
    string CertificateNumber {xpath('CertificateNumber')};
    _lt_Date CertificateFileDate {xpath('CertificateFileDate')};
    string CertificateVolNumber {xpath('CertificateVolNumber')};
    integer CertificateVolYear {xpath('CertificateVolYear')};
    string LocalFileNumber {xpath('LocalFileNumber')};
    string FuneralHomeLicenseNumber {xpath('FuneralHomeLicenseNumber')};
    string EmbalmerLicenseNumber {xpath('EmbalmerLicenseNumber')};
    string ZipLastPayment {xpath('ZipLastPayment')};
    string CauseOfDeath {xpath('CauseOfDeath')};
    string TimeOfDeath {xpath('TimeOfDeath')};
    string DeathLocation {xpath('DeathLocation')};
    string Facilty {xpath('Facilty')};
    string DeathType {xpath('DeathType')};
    string Disposition {xpath('Disposition')};
    _lt_Date DispositionDate {xpath('DispositionDate')};
    string Autopsy {xpath('Autopsy')};
    string AutopsyFindings {xpath('AutopsyFindings')};
    string MedicalExamination {xpath('MedicalExamination')};
    _lt_Date InjuryDate {xpath('InjuryDate')};
    string InjuryLocation {xpath('InjuryLocation')};
    _lt_Date SurgeryDate {xpath('SurgeryDate')};
    string Pregnancy {xpath('Pregnancy')};
    string Certifier {xpath('Certifier')};
    string HospitalStatus {xpath('HospitalStatus')};
    string WorkInjury {xpath('WorkInjury')}; 
    string SurgeryPerformed {xpath('SurgeryPerformed')}; 
  END;

  EXPORT _lt_DeathReportRecord := RECORD
    string StateDeathId {xpath('StateDeathId')};
    string SourceState {xpath('SourceState')};
    string County {xpath('County')};
    string VerifiedOrProved {xpath('VerifiedOrProved')};
    string Source {xpath('Source')};//hidden[internal]
    _lt_DeathReportDecedent Decedent {xpath('Decedent')};
    _lt_DeathReportDecedentFamily Family {xpath('Family')};
    _lt_DeathReportDeathInfo DeathInfo {xpath('DeathInfo')};
  END;

  EXPORT _lt_PersonSlimReportUtility := RECORD
    string1 UtilType {xpath('UtilType')};
    string20 UtilCategory {xpath('UtilCategory')};
    string20 UtilTypeDescription {xpath('UtilTypeDescription')};
    _lt_Date ConnectDate {xpath('ConnectDate')};
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date RecordDate {xpath('RecordDate')};
    _lt_Name Name {xpath('Name')};
    string9 SSN {xpath('SSN')};
    _lt_Date DOB {xpath('DOB')};
    string2 DriversLicenseStateCode {xpath('DriversLicenseStateCode')};
    string22 DriversLicense {xpath('DriversLicense')};
    string10 WorkPhone {xpath('WorkPhone')};
    string10 Phone {xpath('Phone')};
    string1 AddrDual {xpath('AddrDual')};
    dataset(_lt_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAddresses * 2)};
  END;

  EXPORT _lt_PersonSlimReportResponse := RECORD
    _lt_ResponseHeader _Header {xpath('Header')};
    string12 UniqueId {xpath('UniqueId')};
    dataset(_lt_PersonSlimReportAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAddresses * 2)};
    dataset(_lt_PhonesPlusRecord) Phones {xpath('Phones/Phone'), MAXCOUNT(iesp.constants.PersonSlim.MaxPhones * 2)};
    dataset(_lt_ProfessionalLicenseRecord) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(iesp.Constants.PersonSlim.MaxProfLic * 2)};
    dataset(_lt_PeopleAtWorkRecord) PeopleAtWorks {xpath('PeopleAtWorks/PeopleAtWork'), MAXCOUNT(iesp.constants.PersonSlim.MaxPeopleAtWork * 2)};
    dataset(_lt_AircraftReportRecord) Aircrafts {xpath('Aircrafts/Aircraft'), MAXCOUNT(iesp.constants.PersonSlim.MaxAircrafts * 2)};
    dataset(_lt_BpsFAACertification) FAACertifications {xpath('FAACertifications/Certification'), MAXCOUNT(iesp.constants.PersonSlim.MaxFaaCerts * 2)};
    dataset(_lt_WaterCraftReportRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.constants.PersonSlim.MaxWatercrafts * 2)};
    dataset(_lt_UCCReport2Record) UCCFilings {xpath('UCCFilings/UCCFiling'), MAXCOUNT(iesp.Constants.PersonSlim.MaxUCCs * 2)};
    dataset(_lt_SexOffReportRecord) SexualOffenses {xpath('SexualOffenses/SexualOffense'), MAXCOUNT(iesp.Constants.PersonSlim.MaxSexOffenses * 2)};
    dataset(_lt_CrimReportRecord) Criminals {xpath('Criminals/Criminal'), MAXCOUNT(iesp.Constants.PersonSlim.MaxCrimRecords * 2)};
    dataset(_lt_WeaponRecord) WeaponPermits {xpath('WeaponPermits/WeaponPermit'), MAXCOUNT(iesp.Constants.PersonSlim.MaxWeapons * 2)};
    dataset(_lt_HuntFishRecord) HuntingFishingLicenses {xpath('HuntingFishingLicenses/HuntingFishingLicense'), MAXCOUNT(iesp.Constants.PersonSlim.MaxHuntFish * 2)};
    dataset(_lt_FirearmRecord) FirearmExplosives {xpath('FirearmExplosives/FirearmExplosive'), MAXCOUNT(iesp.Constants.PersonSlim.MaxFirearms * 2)};
    dataset(_lt_DEAControlledSubstanceSearch2Record) ControlledSubstances {xpath('ControlledSubstances/ControlledSubstance'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDEA * 2)};
    dataset(_lt_VoterReport2Record) VoterRegistrations {xpath('VoterRegistrations/VoterRegistration'), MAXCOUNT(iesp.Constants.PersonSlim.MaxVoter * 2)};
    dataset(_lt_DLEmbeddedReport2Record) Drivers {xpath('Drivers/Driver'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDLs * 2)};
    dataset(_lt_MotorVehicleReport2Record) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(iesp.Constants.PersonSlim.MaxVehicles * 2)};
    dataset(_lt_AccidentReportRecord) Accidents {xpath('Accidents/Accident'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAccidents * 2)};
    dataset(_lt_BankruptcyReport2Record) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.Constants.PersonSlim.MaxBankruptcies * 2)};
    dataset(_lt_LienJudgmentReportRecord) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.Constants.PersonSlim.MaxLiens * 2)};
    dataset(_lt_PropertyReport2Record) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.Constants.PersonSlim.MaxProperties * 2)};
    dataset(_lt_MarriageSearch2Record) MarriageDivorces {xpath('MarriageDivorces/MarriageDivorce'), MAXCOUNT(iesp.Constants.PersonSlim.MaxMarriageDiv * 2)};
    dataset(_lt_StudentRecord) Educations {xpath('Educations/Education'), MAXCOUNT(iesp.Constants.PersonSlim.MaxStudent * 2)};
    dataset(_lt_BpsReportIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAKA * 2)};
    dataset(_lt_BpsReportImposter) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(iesp.Constants.PersonSlim.MaxImposters * 2)};
    dataset(_lt_DeathReportRecord) Deaths {xpath('Deaths/Death'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDeaths * 2)};
    dataset(_lt_PersonSlimReportUtility) Utilities {xpath('Utilities/Utility'), MAXCOUNT(iesp.Constants.PersonSlim.MaxUtilities * 2)};
  END;

  EXPORT _lt_PersonSlimReportResponseEx := RECORD
    _lt_PersonSlimReportResponse response {xpath('response')};
  END;

END;

difference := MODULE

  EXPORT boolean MonitorAddress := FALSE : STORED('Monitor_Address', FORMAT(sequence(11)));
  EXPORT boolean MonitorCertification := FALSE : STORED('Monitor_Certification', FORMAT(sequence(12)));
  EXPORT boolean MonitorHuntingFishingLicense := FALSE : STORED('Monitor_HuntingFishingLicense', FORMAT(sequence(13)));
  EXPORT boolean MonitorFirearmExplosive := FALSE : STORED('Monitor_FirearmExplosive', FORMAT(sequence(14)));
  EXPORT boolean MonitorControlledSubstance := FALSE : STORED('Monitor_ControlledSubstance', FORMAT(sequence(15)));
  EXPORT boolean MonitorVoterRegistration := FALSE : STORED('Monitor_VoterRegistration', FORMAT(sequence(16)));
  EXPORT boolean MonitorDriver := FALSE : STORED('Monitor_Driver', FORMAT(sequence(17)));
  EXPORT boolean MonitorVehicle := FALSE : STORED('Monitor_Vehicle', FORMAT(sequence(18)));
  EXPORT boolean MonitorBankruptcy := FALSE : STORED('Monitor_Bankruptcy', FORMAT(sequence(19)));
  EXPORT boolean MonitorLienJudgment := FALSE : STORED('Monitor_LienJudgment', FORMAT(sequence(20)));



EXPORT _df_DiffString(boolean is_active, string path) := MODULE

  EXPORT layouts.DiffStringRow ProcessTxRow(layouts.DiffStringRow L, layouts.DiffStringRow R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;


    integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      DiffStatus.State.UNCHANGED);

    SELF._diff := IF(is_active, DiffStatus.Convert (_change), '');
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;

  EXPORT  integer1 CheckOuter(layouts.DiffString L, layouts.DiffString R) := FUNCTION
    boolean IsInner :=  (L.Value = R.Value);
    boolean IsOuterRight :=   (L.Value = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;

  EXPORT  AsDataset (dataset(layouts.DiffString) _n, dataset(layouts.DiffString) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts.DiffStringRow, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts.DiffStringRow, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Value = RIGHT.Value,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Value = RIGHT.Value,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts.DiffString);
  END;

END;

  EXPORT _df_Address(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_Address L, layouts._lt_Address R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StreetNumber := (L.StreetNumber != R.StreetNumber);
    shared boolean updated_StreetPreDirection := (L.StreetPreDirection != R.StreetPreDirection);
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_StreetSuffix := (L.StreetSuffix != R.StreetSuffix);
    shared boolean updated_StreetPostDirection := (L.StreetPostDirection != R.StreetPostDirection);
    UnitDesignation_active := CASE(path + '/UnitDesignation', '/Addresses/Address/UnitDesignation' => (false), '/FAACertifications/Certification/Address/UnitDesignation' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/UnitDesignation' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/UnitDesignation' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/UnitDesignation' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/UnitDesignation' => (false), '/Drivers/Driver/Address/UnitDesignation' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/UnitDesignation' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/UnitDesignation' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/UnitDesignation' => (false), is_active);
    shared boolean updated_UnitDesignation := UnitDesignation_active AND (L.UnitDesignation != R.UnitDesignation);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    StreetAddress1_active := CASE(path + '/StreetAddress1', '/Addresses/Address/StreetAddress1' => (false), '/FAACertifications/Certification/Address/StreetAddress1' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress1' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress1' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress1' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress1' => (false), '/Drivers/Driver/Address/StreetAddress1' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress1' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress1' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress1' => (false), is_active);
    shared boolean updated_StreetAddress1 := StreetAddress1_active AND (L.StreetAddress1 != R.StreetAddress1);
    StreetAddress2_active := CASE(path + '/StreetAddress2', '/Addresses/Address/StreetAddress2' => (false), '/FAACertifications/Certification/Address/StreetAddress2' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress2' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress2' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress2' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress2' => (false), '/Drivers/Driver/Address/StreetAddress2' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress2' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress2' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress2' => (false), is_active);
    shared boolean updated_StreetAddress2 := StreetAddress2_active AND (L.StreetAddress2 != R.StreetAddress2);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);
    Zip4_active := CASE(path + '/Zip4', '/Addresses/Address/Zip4' => (false), '/FAACertifications/Certification/Address/Zip4' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Zip4' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Zip4' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Zip4' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Zip4' => (false), '/Drivers/Driver/Address/Zip4' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Zip4' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Zip4' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Zip4' => (false), is_active);
    shared boolean updated_Zip4 := Zip4_active AND (L.Zip4 != R.Zip4);
    County_active := CASE(path + '/County', '/Addresses/Address/County' => (false), '/FAACertifications/Certification/Address/County' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/County' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/County' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/County' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/County' => (false), '/Drivers/Driver/Address/County' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/County' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/County' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/County' => (false), is_active);
    shared boolean updated_County := County_active AND (L.County != R.County);
    PostalCode_active := CASE(path + '/PostalCode', '/Addresses/Address/PostalCode' => (false), '/FAACertifications/Certification/Address/PostalCode' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/PostalCode' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/PostalCode' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/PostalCode' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/PostalCode' => (false), '/Drivers/Driver/Address/PostalCode' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/PostalCode' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/PostalCode' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/PostalCode' => (false), is_active);
    shared boolean updated_PostalCode := PostalCode_active AND (L.PostalCode != R.PostalCode);
    StateCityZip_active := CASE(path + '/StateCityZip', '/Addresses/Address/StateCityZip' => (false), '/FAACertifications/Certification/Address/StateCityZip' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StateCityZip' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StateCityZip' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StateCityZip' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StateCityZip' => (false), '/Drivers/Driver/Address/StateCityZip' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StateCityZip' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StateCityZip' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StateCityZip' => (false), is_active);
    shared boolean updated_StateCityZip := StateCityZip_active AND (L.StateCityZip != R.StateCityZip);
    Latitude_active := CASE(path + '/Latitude', '/Addresses/Address/Latitude' => (false), '/FAACertifications/Certification/Address/Latitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Latitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Latitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Latitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Latitude' => (false), '/Drivers/Driver/Address/Latitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Latitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Latitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Latitude' => (false), is_active);
    shared boolean updated_Latitude := Latitude_active AND (L.Latitude != R.Latitude);
    Longitude_active := CASE(path + '/Longitude', '/Addresses/Address/Longitude' => (false), '/FAACertifications/Certification/Address/Longitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Longitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Longitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Longitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Longitude' => (false), '/Drivers/Driver/Address/Longitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Longitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Longitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Longitude' => (false), is_active);
    shared boolean updated_Longitude := Longitude_active AND (L.Longitude != R.Longitude);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetPreDirection
      OR updated_StreetName
      OR updated_StreetSuffix
      OR updated_StreetPostDirection
      OR updated_UnitDesignation
      OR updated_UnitNumber
      OR updated_StreetAddress1
      OR updated_StreetAddress2
      OR updated_City
      OR updated_State
      OR updated_Zip5
      OR updated_Zip4
      OR updated_County
      OR updated_PostalCode
      OR updated_StateCityZip
      OR updated_Latitude
      OR updated_Longitude;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetPreDirection, DATASET ([{'StreetPreDirection', R.StreetPreDirection}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_StreetSuffix, DATASET ([{'StreetSuffix', R.StreetSuffix}], layouts.DiffMetaRow))
         +  IF (updated_StreetPostDirection, DATASET ([{'StreetPostDirection', R.StreetPostDirection}], layouts.DiffMetaRow))
         +  IF (updated_UnitDesignation, DATASET ([{'UnitDesignation', R.UnitDesignation}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress1, DATASET ([{'StreetAddress1', R.StreetAddress1}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress2, DATASET ([{'StreetAddress2', R.StreetAddress2}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow))
         +  IF (updated_Zip4, DATASET ([{'Zip4', R.Zip4}], layouts.DiffMetaRow))
         +  IF (updated_County, DATASET ([{'County', R.County}], layouts.DiffMetaRow))
         +  IF (updated_PostalCode, DATASET ([{'PostalCode', R.PostalCode}], layouts.DiffMetaRow))
         +  IF (updated_StateCityZip, DATASET ([{'StateCityZip', R.StateCityZip}], layouts.DiffMetaRow))
         +  IF (updated_Latitude, DATASET ([{'Latitude', R.Latitude}], layouts.DiffMetaRow))
         +  IF (updated_Longitude, DATASET ([{'Longitude', R.Longitude}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_Address ProcessTx(layouts._lt_Address L, layouts._lt_Address R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_Address ProcessTxRow(layouts._lt_row_Address L, layouts._lt_row_Address R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_Address _new, layouts._lt_Address _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_Date(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_Date L, layouts._lt_Date R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Year := (L.Year != R.Year);
    shared boolean updated_Month := (L.Month != R.Month);
    shared boolean updated_Day := (L.Day != R.Day);

    shared is_updated := false
      OR updated_Year
      OR updated_Month
      OR updated_Day;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_Year, DATASET ([{'Year', R.Year}], layouts.DiffMetaRow))
         +  IF (updated_Month, DATASET ([{'Month', R.Month}], layouts.DiffMetaRow))
         +  IF (updated_Day, DATASET ([{'Day', R.Day}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_Date ProcessTx(layouts._lt_Date L, layouts._lt_Date R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_Date ProcessTxRow(layouts._lt_row_Date L, layouts._lt_row_Date R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_Date _new, layouts._lt_Date _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_PersonSlimReportAddress(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportAddress L, layouts._lt_PersonSlimReportAddress R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StreetNumber := (L.StreetNumber != R.StreetNumber);
    shared boolean updated_StreetPreDirection := (L.StreetPreDirection != R.StreetPreDirection);
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_StreetSuffix := (L.StreetSuffix != R.StreetSuffix);
    shared boolean updated_StreetPostDirection := (L.StreetPostDirection != R.StreetPostDirection);
    UnitDesignation_active := CASE(path + '/UnitDesignation', '/Addresses/Address/UnitDesignation' => (false), '/FAACertifications/Certification/Address/UnitDesignation' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/UnitDesignation' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/UnitDesignation' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/UnitDesignation' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/UnitDesignation' => (false), '/Drivers/Driver/Address/UnitDesignation' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/UnitDesignation' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/UnitDesignation' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/UnitDesignation' => (false), is_active);
    shared boolean updated_UnitDesignation := UnitDesignation_active AND (L.UnitDesignation != R.UnitDesignation);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    StreetAddress1_active := CASE(path + '/StreetAddress1', '/Addresses/Address/StreetAddress1' => (false), '/FAACertifications/Certification/Address/StreetAddress1' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress1' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress1' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress1' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress1' => (false), '/Drivers/Driver/Address/StreetAddress1' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress1' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress1' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress1' => (false), is_active);
    shared boolean updated_StreetAddress1 := StreetAddress1_active AND (L.StreetAddress1 != R.StreetAddress1);
    StreetAddress2_active := CASE(path + '/StreetAddress2', '/Addresses/Address/StreetAddress2' => (false), '/FAACertifications/Certification/Address/StreetAddress2' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress2' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress2' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress2' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress2' => (false), '/Drivers/Driver/Address/StreetAddress2' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress2' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress2' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress2' => (false), is_active);
    shared boolean updated_StreetAddress2 := StreetAddress2_active AND (L.StreetAddress2 != R.StreetAddress2);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);
    Zip4_active := CASE(path + '/Zip4', '/Addresses/Address/Zip4' => (false), '/FAACertifications/Certification/Address/Zip4' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Zip4' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Zip4' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Zip4' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Zip4' => (false), '/Drivers/Driver/Address/Zip4' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Zip4' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Zip4' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Zip4' => (false), is_active);
    shared boolean updated_Zip4 := Zip4_active AND (L.Zip4 != R.Zip4);
    County_active := CASE(path + '/County', '/Addresses/Address/County' => (false), '/FAACertifications/Certification/Address/County' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/County' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/County' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/County' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/County' => (false), '/Drivers/Driver/Address/County' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/County' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/County' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/County' => (false), is_active);
    shared boolean updated_County := County_active AND (L.County != R.County);
    PostalCode_active := CASE(path + '/PostalCode', '/Addresses/Address/PostalCode' => (false), '/FAACertifications/Certification/Address/PostalCode' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/PostalCode' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/PostalCode' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/PostalCode' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/PostalCode' => (false), '/Drivers/Driver/Address/PostalCode' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/PostalCode' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/PostalCode' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/PostalCode' => (false), is_active);
    shared boolean updated_PostalCode := PostalCode_active AND (L.PostalCode != R.PostalCode);
    StateCityZip_active := CASE(path + '/StateCityZip', '/Addresses/Address/StateCityZip' => (false), '/FAACertifications/Certification/Address/StateCityZip' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StateCityZip' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StateCityZip' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StateCityZip' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StateCityZip' => (false), '/Drivers/Driver/Address/StateCityZip' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StateCityZip' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StateCityZip' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StateCityZip' => (false), is_active);
    shared boolean updated_StateCityZip := StateCityZip_active AND (L.StateCityZip != R.StateCityZip);
    Latitude_active := CASE(path + '/Latitude', '/Addresses/Address/Latitude' => (false), '/FAACertifications/Certification/Address/Latitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Latitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Latitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Latitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Latitude' => (false), '/Drivers/Driver/Address/Latitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Latitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Latitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Latitude' => (false), is_active);
    shared boolean updated_Latitude := Latitude_active AND (L.Latitude != R.Latitude);
    Longitude_active := CASE(path + '/Longitude', '/Addresses/Address/Longitude' => (false), '/FAACertifications/Certification/Address/Longitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Longitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Longitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Longitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Longitude' => (false), '/Drivers/Driver/Address/Longitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Longitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Longitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Longitude' => (false), is_active);
    shared boolean updated_Longitude := Longitude_active AND (L.Longitude != R.Longitude);
    shared boolean updated_GeoBlk := (L.GeoBlk != R.GeoBlk);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetPreDirection
      OR updated_StreetName
      OR updated_StreetSuffix
      OR updated_StreetPostDirection
      OR updated_UnitDesignation
      OR updated_UnitNumber
      OR updated_StreetAddress1
      OR updated_StreetAddress2
      OR updated_City
      OR updated_State
      OR updated_Zip5
      OR updated_Zip4
      OR updated_County
      OR updated_PostalCode
      OR updated_StateCityZip
      OR updated_Latitude
      OR updated_Longitude
      OR updated_GeoBlk;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetPreDirection, DATASET ([{'StreetPreDirection', R.StreetPreDirection}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_StreetSuffix, DATASET ([{'StreetSuffix', R.StreetSuffix}], layouts.DiffMetaRow))
         +  IF (updated_StreetPostDirection, DATASET ([{'StreetPostDirection', R.StreetPostDirection}], layouts.DiffMetaRow))
         +  IF (updated_UnitDesignation, DATASET ([{'UnitDesignation', R.UnitDesignation}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress1, DATASET ([{'StreetAddress1', R.StreetAddress1}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress2, DATASET ([{'StreetAddress2', R.StreetAddress2}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow))
         +  IF (updated_Zip4, DATASET ([{'Zip4', R.Zip4}], layouts.DiffMetaRow))
         +  IF (updated_County, DATASET ([{'County', R.County}], layouts.DiffMetaRow))
         +  IF (updated_PostalCode, DATASET ([{'PostalCode', R.PostalCode}], layouts.DiffMetaRow))
         +  IF (updated_StateCityZip, DATASET ([{'StateCityZip', R.StateCityZip}], layouts.DiffMetaRow))
         +  IF (updated_Latitude, DATASET ([{'Latitude', R.Latitude}], layouts.DiffMetaRow))
         +  IF (updated_Longitude, DATASET ([{'Longitude', R.Longitude}], layouts.DiffMetaRow))+ IF (updated_GeoBlk, DATASET ([{'GeoBlk', R.GeoBlk}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_PersonSlimReportAddress ProcessTx(layouts._lt_PersonSlimReportAddress L, layouts._lt_PersonSlimReportAddress R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.DateLastSeen  := L.DateLastSeen;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportAddress ProcessTxRow(layouts._lt_row_PersonSlimReportAddress L, layouts._lt_row_PersonSlimReportAddress R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.DateLastSeen  := L.DateLastSeen;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportAddress _new, layouts._lt_PersonSlimReportAddress _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(layouts._lt_PersonSlimReportAddress L, layouts._lt_PersonSlimReportAddress R) := FUNCTION
    boolean IsInner :=  (L.StreetPreDirection = R.StreetPreDirection AND L.StreetName = R.StreetName AND L.City = R.City AND L.State = R.State AND L.UnitNumber = R.UnitNumber AND L.StreetNumber = R.StreetNumber AND L.Zip5 = R.Zip5);

    boolean IsOuterRight :=   (L.StreetPreDirection = '' AND L.StreetName = '' AND L.City = '' AND L.State = '' AND L.UnitNumber = '' AND L.StreetNumber = '' AND L.Zip5 = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5 (dataset(layouts._lt_PersonSlimReportAddress) _n, dataset(layouts._lt_PersonSlimReportAddress) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportAddress, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportAddress, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.StreetPreDirection = RIGHT.StreetPreDirection AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State AND LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.StreetPreDirection = RIGHT.StreetPreDirection AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State AND LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportAddress);
  END;
  
END;

EXPORT _df_Name(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_Name L, layouts._lt_Name R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_First := (L.First != R.First);
    shared boolean updated_Last := (L.Last != R.Last);

    shared is_updated := false
      OR updated_First
      OR updated_Last;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_First, DATASET ([{'First', R.First}], layouts.DiffMetaRow))
         +  IF (updated_Last, DATASET ([{'Last', R.Last}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_Name ProcessTx(layouts._lt_Name L, layouts._lt_Name R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_Name ProcessTxRow(layouts._lt_row_Name L, layouts._lt_row_Name R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_Name _new, layouts._lt_Name _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_BpsFAACertification(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BpsFAACertification L, layouts._lt_BpsFAACertification R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Gender := (L.Gender != R.Gender);

    shared is_updated := false
      OR updated_Gender;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_Gender, DATASET ([{'Gender', R.Gender}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BpsFAACertification ProcessTx(layouts._lt_BpsFAACertification L, layouts._lt_BpsFAACertification R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.DateCertifiedMedical  := L.DateCertifiedMedical;
      SELF.DateExpiresMedical  := L.DateExpiresMedical;
      SELF.Certificates  := L.Certificates;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_BpsFAACertification ProcessTxRow(layouts._lt_row_BpsFAACertification L, layouts._lt_row_BpsFAACertification R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.DateCertifiedMedical  := L.DateCertifiedMedical;
      SELF.DateExpiresMedical  := L.DateExpiresMedical;
      SELF.Certificates  := L.Certificates;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_BpsFAACertification _new, layouts._lt_BpsFAACertification _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_address_countyaddress_state(layouts._lt_BpsFAACertification L, layouts._lt_BpsFAACertification R) := FUNCTION
    boolean IsInner :=  (L.Address.County = R.Address.County AND L.Address.State = R.Address.State);

    boolean IsOuterRight :=   (L.Address.County = '' AND L.Address.State = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_address_countyaddress_state (dataset(layouts._lt_BpsFAACertification) _n, dataset(layouts._lt_BpsFAACertification) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_BpsFAACertification, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_BpsFAACertification, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Address.County = RIGHT.Address.County AND LEFT.Address.State = RIGHT.Address.State,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_address_countyaddress_state(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Address.County = RIGHT.Address.County AND LEFT.Address.State = RIGHT.Address.State,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_address_countyaddress_state(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_BpsFAACertification);
  END;
  
END;

EXPORT _df_AddressWithRawInfo(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AddressWithRawInfo L, layouts._lt_AddressWithRawInfo R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StreetNumber := (L.StreetNumber != R.StreetNumber);
    shared boolean updated_StreetPreDirection := (L.StreetPreDirection != R.StreetPreDirection);
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_StreetSuffix := (L.StreetSuffix != R.StreetSuffix);
    shared boolean updated_StreetPostDirection := (L.StreetPostDirection != R.StreetPostDirection);
    UnitDesignation_active := CASE(path + '/UnitDesignation', '/Addresses/Address/UnitDesignation' => (false), '/FAACertifications/Certification/Address/UnitDesignation' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/UnitDesignation' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/UnitDesignation' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/UnitDesignation' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/UnitDesignation' => (false), '/Drivers/Driver/Address/UnitDesignation' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/UnitDesignation' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/UnitDesignation' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/UnitDesignation' => (false), is_active);
    shared boolean updated_UnitDesignation := UnitDesignation_active AND (L.UnitDesignation != R.UnitDesignation);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    StreetAddress1_active := CASE(path + '/StreetAddress1', '/Addresses/Address/StreetAddress1' => (false), '/FAACertifications/Certification/Address/StreetAddress1' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress1' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress1' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress1' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress1' => (false), '/Drivers/Driver/Address/StreetAddress1' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress1' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress1' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress1' => (false), is_active);
    shared boolean updated_StreetAddress1 := StreetAddress1_active AND (L.StreetAddress1 != R.StreetAddress1);
    StreetAddress2_active := CASE(path + '/StreetAddress2', '/Addresses/Address/StreetAddress2' => (false), '/FAACertifications/Certification/Address/StreetAddress2' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress2' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress2' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress2' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress2' => (false), '/Drivers/Driver/Address/StreetAddress2' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress2' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress2' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress2' => (false), is_active);
    shared boolean updated_StreetAddress2 := StreetAddress2_active AND (L.StreetAddress2 != R.StreetAddress2);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);
    Zip4_active := CASE(path + '/Zip4', '/Addresses/Address/Zip4' => (false), '/FAACertifications/Certification/Address/Zip4' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Zip4' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Zip4' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Zip4' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Zip4' => (false), '/Drivers/Driver/Address/Zip4' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Zip4' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Zip4' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Zip4' => (false), is_active);
    shared boolean updated_Zip4 := Zip4_active AND (L.Zip4 != R.Zip4);
    County_active := CASE(path + '/County', '/Addresses/Address/County' => (false), '/FAACertifications/Certification/Address/County' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/County' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/County' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/County' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/County' => (false), '/Drivers/Driver/Address/County' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/County' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/County' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/County' => (false), is_active);
    shared boolean updated_County := County_active AND (L.County != R.County);
    PostalCode_active := CASE(path + '/PostalCode', '/Addresses/Address/PostalCode' => (false), '/FAACertifications/Certification/Address/PostalCode' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/PostalCode' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/PostalCode' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/PostalCode' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/PostalCode' => (false), '/Drivers/Driver/Address/PostalCode' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/PostalCode' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/PostalCode' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/PostalCode' => (false), is_active);
    shared boolean updated_PostalCode := PostalCode_active AND (L.PostalCode != R.PostalCode);
    StateCityZip_active := CASE(path + '/StateCityZip', '/Addresses/Address/StateCityZip' => (false), '/FAACertifications/Certification/Address/StateCityZip' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StateCityZip' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StateCityZip' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StateCityZip' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StateCityZip' => (false), '/Drivers/Driver/Address/StateCityZip' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StateCityZip' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StateCityZip' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StateCityZip' => (false), is_active);
    shared boolean updated_StateCityZip := StateCityZip_active AND (L.StateCityZip != R.StateCityZip);
    Latitude_active := CASE(path + '/Latitude', '/Addresses/Address/Latitude' => (false), '/FAACertifications/Certification/Address/Latitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Latitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Latitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Latitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Latitude' => (false), '/Drivers/Driver/Address/Latitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Latitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Latitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Latitude' => (false), is_active);
    shared boolean updated_Latitude := Latitude_active AND (L.Latitude != R.Latitude);
    Longitude_active := CASE(path + '/Longitude', '/Addresses/Address/Longitude' => (false), '/FAACertifications/Certification/Address/Longitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Longitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Longitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Longitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Longitude' => (false), '/Drivers/Driver/Address/Longitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Longitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Longitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Longitude' => (false), is_active);
    shared boolean updated_Longitude := Longitude_active AND (L.Longitude != R.Longitude);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetPreDirection
      OR updated_StreetName
      OR updated_StreetSuffix
      OR updated_StreetPostDirection
      OR updated_UnitDesignation
      OR updated_UnitNumber
      OR updated_StreetAddress1
      OR updated_StreetAddress2
      OR updated_City
      OR updated_State
      OR updated_Zip5
      OR updated_Zip4
      OR updated_County
      OR updated_PostalCode
      OR updated_StateCityZip
      OR updated_Latitude
      OR updated_Longitude;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetPreDirection, DATASET ([{'StreetPreDirection', R.StreetPreDirection}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_StreetSuffix, DATASET ([{'StreetSuffix', R.StreetSuffix}], layouts.DiffMetaRow))
         +  IF (updated_StreetPostDirection, DATASET ([{'StreetPostDirection', R.StreetPostDirection}], layouts.DiffMetaRow))
         +  IF (updated_UnitDesignation, DATASET ([{'UnitDesignation', R.UnitDesignation}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress1, DATASET ([{'StreetAddress1', R.StreetAddress1}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress2, DATASET ([{'StreetAddress2', R.StreetAddress2}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow))
         +  IF (updated_Zip4, DATASET ([{'Zip4', R.Zip4}], layouts.DiffMetaRow))
         +  IF (updated_County, DATASET ([{'County', R.County}], layouts.DiffMetaRow))
         +  IF (updated_PostalCode, DATASET ([{'PostalCode', R.PostalCode}], layouts.DiffMetaRow))
         +  IF (updated_StateCityZip, DATASET ([{'StateCityZip', R.StateCityZip}], layouts.DiffMetaRow))
         +  IF (updated_Latitude, DATASET ([{'Latitude', R.Latitude}], layouts.DiffMetaRow))
         +  IF (updated_Longitude, DATASET ([{'Longitude', R.Longitude}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_AddressWithRawInfo ProcessTx(layouts._lt_AddressWithRawInfo L, layouts._lt_AddressWithRawInfo R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_AddressWithRawInfo ProcessTxRow(layouts._lt_row_AddressWithRawInfo L, layouts._lt_row_AddressWithRawInfo R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_AddressWithRawInfo _new, layouts._lt_AddressWithRawInfo _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(layouts._lt_AddressWithRawInfo L, layouts._lt_AddressWithRawInfo R) := FUNCTION
    boolean IsInner :=  (L.StreetPreDirection = R.StreetPreDirection AND L.StreetName = R.StreetName AND L.City = R.City AND L.State = R.State AND L.UnitNumber = R.UnitNumber AND L.StreetNumber = R.StreetNumber AND L.Zip5 = R.Zip5);

    boolean IsOuterRight :=   (L.StreetPreDirection = '' AND L.StreetName = '' AND L.City = '' AND L.State = '' AND L.UnitNumber = '' AND L.StreetNumber = '' AND L.Zip5 = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5 (dataset(layouts._lt_AddressWithRawInfo) _n, dataset(layouts._lt_AddressWithRawInfo) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_AddressWithRawInfo, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_AddressWithRawInfo, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.StreetPreDirection = RIGHT.StreetPreDirection AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State AND LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.StreetPreDirection = RIGHT.StreetPreDirection AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State AND LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_AddressWithRawInfo);
  END;
  
END;

EXPORT _df_UniversalAddress(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_UniversalAddress L, layouts._lt_UniversalAddress R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StreetNumber := (L.StreetNumber != R.StreetNumber);
    shared boolean updated_StreetPreDirection := (L.StreetPreDirection != R.StreetPreDirection);
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_StreetSuffix := (L.StreetSuffix != R.StreetSuffix);
    shared boolean updated_StreetPostDirection := (L.StreetPostDirection != R.StreetPostDirection);
    UnitDesignation_active := CASE(path + '/UnitDesignation', '/Addresses/Address/UnitDesignation' => (false), '/FAACertifications/Certification/Address/UnitDesignation' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/UnitDesignation' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/UnitDesignation' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/UnitDesignation' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/UnitDesignation' => (false), '/Drivers/Driver/Address/UnitDesignation' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/UnitDesignation' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/UnitDesignation' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/UnitDesignation' => (false), is_active);
    shared boolean updated_UnitDesignation := UnitDesignation_active AND (L.UnitDesignation != R.UnitDesignation);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    StreetAddress1_active := CASE(path + '/StreetAddress1', '/Addresses/Address/StreetAddress1' => (false), '/FAACertifications/Certification/Address/StreetAddress1' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress1' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress1' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress1' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress1' => (false), '/Drivers/Driver/Address/StreetAddress1' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress1' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress1' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress1' => (false), is_active);
    shared boolean updated_StreetAddress1 := StreetAddress1_active AND (L.StreetAddress1 != R.StreetAddress1);
    StreetAddress2_active := CASE(path + '/StreetAddress2', '/Addresses/Address/StreetAddress2' => (false), '/FAACertifications/Certification/Address/StreetAddress2' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StreetAddress2' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StreetAddress2' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StreetAddress2' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StreetAddress2' => (false), '/Drivers/Driver/Address/StreetAddress2' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StreetAddress2' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StreetAddress2' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StreetAddress2' => (false), is_active);
    shared boolean updated_StreetAddress2 := StreetAddress2_active AND (L.StreetAddress2 != R.StreetAddress2);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);
    Zip4_active := CASE(path + '/Zip4', '/Addresses/Address/Zip4' => (false), '/FAACertifications/Certification/Address/Zip4' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Zip4' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Zip4' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Zip4' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Zip4' => (false), '/Drivers/Driver/Address/Zip4' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Zip4' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Zip4' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Zip4' => (false), is_active);
    shared boolean updated_Zip4 := Zip4_active AND (L.Zip4 != R.Zip4);
    County_active := CASE(path + '/County', '/Addresses/Address/County' => (false), '/FAACertifications/Certification/Address/County' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/County' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/County' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/County' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/County' => (false), '/Drivers/Driver/Address/County' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/County' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/County' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/County' => (false), is_active);
    shared boolean updated_County := County_active AND (L.County != R.County);
    PostalCode_active := CASE(path + '/PostalCode', '/Addresses/Address/PostalCode' => (false), '/FAACertifications/Certification/Address/PostalCode' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/PostalCode' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/PostalCode' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/PostalCode' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/PostalCode' => (false), '/Drivers/Driver/Address/PostalCode' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/PostalCode' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/PostalCode' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/PostalCode' => (false), is_active);
    shared boolean updated_PostalCode := PostalCode_active AND (L.PostalCode != R.PostalCode);
    StateCityZip_active := CASE(path + '/StateCityZip', '/Addresses/Address/StateCityZip' => (false), '/FAACertifications/Certification/Address/StateCityZip' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/StateCityZip' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/StateCityZip' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/StateCityZip' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/StateCityZip' => (false), '/Drivers/Driver/Address/StateCityZip' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/StateCityZip' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/StateCityZip' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/StateCityZip' => (false), is_active);
    shared boolean updated_StateCityZip := StateCityZip_active AND (L.StateCityZip != R.StateCityZip);
    Latitude_active := CASE(path + '/Latitude', '/Addresses/Address/Latitude' => (false), '/FAACertifications/Certification/Address/Latitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Latitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Latitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Latitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Latitude' => (false), '/Drivers/Driver/Address/Latitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Latitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Latitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Latitude' => (false), is_active);
    shared boolean updated_Latitude := Latitude_active AND (L.Latitude != R.Latitude);
    Longitude_active := CASE(path + '/Longitude', '/Addresses/Address/Longitude' => (false), '/FAACertifications/Certification/Address/Longitude' => (false), '/HuntingFishingLicenses/HuntingFishingLicense/Address/Longitude' => (false), '/FirearmExplosives/FirearmExplosive/PremiseAddress/Longitude' => (false), '/ControlledSubstances/ControlledSubstance/ControlledSubstancesInfo/ControlledSubstanceInfo/Address/Longitude' => (false), '/VoterRegistrations/VoterRegistration/ResidentAddress/Longitude' => (false), '/Drivers/Driver/Address/Longitude' => (false), '/Vehicles/Vehicle/Registrants/Registrant/RegistrantInfo/Address/Longitude' => (false), '/Bankruptcies/Bankruptcy/Debtors/Debtor/AddressesEx/Address/Longitude' => (false), '/LiensJudgments/LienJudgment/Debtors/Debtor/Address/Longitude' => (false), is_active);
    shared boolean updated_Longitude := Longitude_active AND (L.Longitude != R.Longitude);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetPreDirection
      OR updated_StreetName
      OR updated_StreetSuffix
      OR updated_StreetPostDirection
      OR updated_UnitDesignation
      OR updated_UnitNumber
      OR updated_StreetAddress1
      OR updated_StreetAddress2
      OR updated_City
      OR updated_State
      OR updated_Zip5
      OR updated_Zip4
      OR updated_County
      OR updated_PostalCode
      OR updated_StateCityZip
      OR updated_Latitude
      OR updated_Longitude;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetPreDirection, DATASET ([{'StreetPreDirection', R.StreetPreDirection}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_StreetSuffix, DATASET ([{'StreetSuffix', R.StreetSuffix}], layouts.DiffMetaRow))
         +  IF (updated_StreetPostDirection, DATASET ([{'StreetPostDirection', R.StreetPostDirection}], layouts.DiffMetaRow))
         +  IF (updated_UnitDesignation, DATASET ([{'UnitDesignation', R.UnitDesignation}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress1, DATASET ([{'StreetAddress1', R.StreetAddress1}], layouts.DiffMetaRow))
         +  IF (updated_StreetAddress2, DATASET ([{'StreetAddress2', R.StreetAddress2}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow))
         +  IF (updated_Zip4, DATASET ([{'Zip4', R.Zip4}], layouts.DiffMetaRow))
         +  IF (updated_County, DATASET ([{'County', R.County}], layouts.DiffMetaRow))
         +  IF (updated_PostalCode, DATASET ([{'PostalCode', R.PostalCode}], layouts.DiffMetaRow))
         +  IF (updated_StateCityZip, DATASET ([{'StateCityZip', R.StateCityZip}], layouts.DiffMetaRow))
         +  IF (updated_Latitude, DATASET ([{'Latitude', R.Latitude}], layouts.DiffMetaRow))
         +  IF (updated_Longitude, DATASET ([{'Longitude', R.Longitude}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_UniversalAddress ProcessTx(layouts._lt_UniversalAddress L, layouts._lt_UniversalAddress R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_UniversalAddress _new, layouts._lt_UniversalAddress _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_HuntFishRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_HuntFishRecord L, layouts._lt_HuntFishRecord R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_HuntFishRecord ProcessTx(layouts._lt_HuntFishRecord L, layouts._lt_HuntFishRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.MailAddress  := L.MailAddress;
      SELF.LicenseDate  := L.LicenseDate;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_HuntFishRecord ProcessTxRow(layouts._lt_row_HuntFishRecord L, layouts._lt_row_HuntFishRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.MailAddress  := L.MailAddress;
      SELF.LicenseDate  := L.LicenseDate;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_HuntFishRecord _new, layouts._lt_HuntFishRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_licensedate_yearlicensenumberlicensetype(layouts._lt_HuntFishRecord L, layouts._lt_HuntFishRecord R) := FUNCTION
    boolean IsInner :=  (L.LicenseDate.Year = R.LicenseDate.Year AND L.LicenseNumber = R.LicenseNumber AND L.LicenseType = R.LicenseType);

    boolean IsOuterRight :=   (L.LicenseDate.Year = 0 AND L.LicenseNumber = '' AND L.LicenseType = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_licensedate_yearlicensenumberlicensetype (dataset(layouts._lt_HuntFishRecord) _n, dataset(layouts._lt_HuntFishRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_HuntFishRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_HuntFishRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.LicenseDate.Year = RIGHT.LicenseDate.Year AND LEFT.LicenseNumber = RIGHT.LicenseNumber AND LEFT.LicenseType = RIGHT.LicenseType,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licensedate_yearlicensenumberlicensetype(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.LicenseDate.Year = RIGHT.LicenseDate.Year AND LEFT.LicenseNumber = RIGHT.LicenseNumber AND LEFT.LicenseType = RIGHT.LicenseType,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licensedate_yearlicensenumberlicensetype(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_HuntFishRecord);
  END;
  
END;

EXPORT _df_FirearmRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_FirearmRecord L, layouts._lt_FirearmRecord R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_FirearmRecord ProcessTx(layouts._lt_FirearmRecord L, layouts._lt_FirearmRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.LicenseExpireDate  := L.LicenseExpireDate;

      path_LicenseName := path + '/LicenseName';
    
      updated_LicenseName := _df_Name(is_active, path_LicenseName).AsRecord(L.LicenseName, R.LicenseName);
        
      checked_LicenseName := MAP (is_deleted => R.LicenseName,
                              is_added => L.LicenseName,
                              updated_LicenseName);
      SELF.LicenseName := checked_LicenseName;
      SELF.MailingAddress  := L.MailingAddress;

      path_PremiseAddress := path + '/PremiseAddress';
    
      updated_PremiseAddress := _df_Address(is_active, path_PremiseAddress).AsRecord(L.PremiseAddress, R.PremiseAddress);
        
      checked_PremiseAddress := MAP (is_deleted => R.PremiseAddress,
                              is_added => L.PremiseAddress,
                              updated_PremiseAddress);
      SELF.PremiseAddress := checked_PremiseAddress;
      SELF.LicenseNames  := L.LicenseNames;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_FirearmRecord ProcessTxRow(layouts._lt_row_FirearmRecord L, layouts._lt_row_FirearmRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.LicenseExpireDate  := L.LicenseExpireDate;

      path_LicenseName := path + '/LicenseName';
    
      updated_LicenseName := _df_Name(is_active, path_LicenseName).AsRecord(L.LicenseName, R.LicenseName);
        
      checked_LicenseName := MAP (is_deleted => R.LicenseName,
                              is_added => L.LicenseName,
                              updated_LicenseName);
      SELF.LicenseName := checked_LicenseName;
      SELF.MailingAddress  := L.MailingAddress;

      path_PremiseAddress := path + '/PremiseAddress';
    
      updated_PremiseAddress := _df_Address(is_active, path_PremiseAddress).AsRecord(L.PremiseAddress, R.PremiseAddress);
        
      checked_PremiseAddress := MAP (is_deleted => R.PremiseAddress,
                              is_added => L.PremiseAddress,
                              updated_PremiseAddress);
      SELF.PremiseAddress := checked_PremiseAddress;
      SELF.LicenseNames  := L.LicenseNames;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_FirearmRecord _new, layouts._lt_FirearmRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_licenseissuestatelicensenumber(layouts._lt_FirearmRecord L, layouts._lt_FirearmRecord R) := FUNCTION
    boolean IsInner :=  (L.LicenseIssueState = R.LicenseIssueState AND L.LicenseNumber = R.LicenseNumber);

    boolean IsOuterRight :=   (L.LicenseIssueState = '' AND L.LicenseNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_licenseissuestatelicensenumber (dataset(layouts._lt_FirearmRecord) _n, dataset(layouts._lt_FirearmRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_FirearmRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_FirearmRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.LicenseIssueState = RIGHT.LicenseIssueState AND LEFT.LicenseNumber = RIGHT.LicenseNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licenseissuestatelicensenumber(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.LicenseIssueState = RIGHT.LicenseIssueState AND LEFT.LicenseNumber = RIGHT.LicenseNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licenseissuestatelicensenumber(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_FirearmRecord);
  END;
  
END;

EXPORT _df_DEAControlledSubstanceRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_DEAControlledSubstanceRecord L, layouts._lt_DEAControlledSubstanceRecord R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_DEAControlledSubstanceRecord ProcessTx(layouts._lt_DEAControlledSubstanceRecord L, layouts._lt_DEAControlledSubstanceRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.ExpirationDate  := L.ExpirationDate;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_DEAControlledSubstanceRecord ProcessTxRow(layouts._lt_row_DEAControlledSubstanceRecord L, layouts._lt_row_DEAControlledSubstanceRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.ExpirationDate  := L.ExpirationDate;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_DEAControlledSubstanceRecord _new, layouts._lt_DEAControlledSubstanceRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_DEAControlledSubstanceSearch2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_DEAControlledSubstanceSearch2Record L, layouts._lt_DEAControlledSubstanceSearch2Record R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_DEAControlledSubstanceSearch2Record ProcessTx(layouts._lt_DEAControlledSubstanceSearch2Record L, layouts._lt_DEAControlledSubstanceSearch2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.ControlledSubstancesInfo  := L.ControlledSubstancesInfo;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_DEAControlledSubstanceSearch2Record ProcessTxRow(layouts._lt_row_DEAControlledSubstanceSearch2Record L, layouts._lt_row_DEAControlledSubstanceSearch2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.ControlledSubstancesInfo  := L.ControlledSubstancesInfo;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_DEAControlledSubstanceSearch2Record _new, layouts._lt_DEAControlledSubstanceSearch2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_registrationnumber(layouts._lt_DEAControlledSubstanceSearch2Record L, layouts._lt_DEAControlledSubstanceSearch2Record R) := FUNCTION
    boolean IsInner :=  (L.RegistrationNumber = R.RegistrationNumber);

    boolean IsOuterRight :=   (L.RegistrationNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_registrationnumber (dataset(layouts._lt_DEAControlledSubstanceSearch2Record) _n, dataset(layouts._lt_DEAControlledSubstanceSearch2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_DEAControlledSubstanceSearch2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_DEAControlledSubstanceSearch2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.RegistrationNumber = RIGHT.RegistrationNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_registrationnumber(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.RegistrationNumber = RIGHT.RegistrationNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_registrationnumber(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_DEAControlledSubstanceSearch2Record);
  END;
  
END;

EXPORT _df_VoterReport2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_VoterReport2Record L, layouts._lt_VoterReport2Record R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_VoterReport2Record ProcessTx(layouts._lt_VoterReport2Record L, layouts._lt_VoterReport2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;
      SELF.RegistrationDate  := L.RegistrationDate;
      SELF.LastVoteDate  := L.LastVoteDate;

      path_ResidentAddress := path + '/ResidentAddress';
    
      updated_ResidentAddress := _df_Address(is_active, path_ResidentAddress).AsRecord(L.ResidentAddress, R.ResidentAddress);
        
      checked_ResidentAddress := MAP (is_deleted => R.ResidentAddress,
                              is_added => L.ResidentAddress,
                              updated_ResidentAddress);
      SELF.ResidentAddress := checked_ResidentAddress;
      SELF.MailingAddress  := L.MailingAddress;
      SELF.VoterDistrictInfo  := L.VoterDistrictInfo;
      SELF.VotingHistories  := L.VotingHistories;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_VoterReport2Record ProcessTxRow(layouts._lt_row_VoterReport2Record L, layouts._lt_row_VoterReport2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;
      SELF.RegistrationDate  := L.RegistrationDate;
      SELF.LastVoteDate  := L.LastVoteDate;

      path_ResidentAddress := path + '/ResidentAddress';
    
      updated_ResidentAddress := _df_Address(is_active, path_ResidentAddress).AsRecord(L.ResidentAddress, R.ResidentAddress);
        
      checked_ResidentAddress := MAP (is_deleted => R.ResidentAddress,
                              is_added => L.ResidentAddress,
                              updated_ResidentAddress);
      SELF.ResidentAddress := checked_ResidentAddress;
      SELF.MailingAddress  := L.MailingAddress;
      SELF.VoterDistrictInfo  := L.VoterDistrictInfo;
      SELF.VotingHistories  := L.VotingHistories;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_VoterReport2Record _new, layouts._lt_VoterReport2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_registratestateresidentaddress_county(layouts._lt_VoterReport2Record L, layouts._lt_VoterReport2Record R) := FUNCTION
    boolean IsInner :=  (L.ResidentAddress.County = R.ResidentAddress.County AND L.RegistrateState = R.RegistrateState);

    boolean IsOuterRight :=   (L.ResidentAddress.County = '' AND L.RegistrateState = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_registratestateresidentaddress_county (dataset(layouts._lt_VoterReport2Record) _n, dataset(layouts._lt_VoterReport2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_VoterReport2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_VoterReport2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.ResidentAddress.County = RIGHT.ResidentAddress.County AND LEFT.RegistrateState = RIGHT.RegistrateState,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_registratestateresidentaddress_county(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.ResidentAddress.County = RIGHT.ResidentAddress.County AND LEFT.RegistrateState = RIGHT.RegistrateState,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_registratestateresidentaddress_county(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_VoterReport2Record);
  END;
  
END;

EXPORT _df_DLEmbeddedReport2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_DLEmbeddedReport2Record L, layouts._lt_DLEmbeddedReport2Record R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_DLEmbeddedReport2Record ProcessTx(layouts._lt_DLEmbeddedReport2Record L, layouts._lt_DLEmbeddedReport2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;
      SELF.DOB2  := L.DOB2;
      SELF.ExpirationDate  := L.ExpirationDate;
      SELF.IssueDate  := L.IssueDate;

      updated_RestrictionsDetail := _df_DiffString(CASE(path + '/RestrictionsDetail', '/Drivers/Driver/RestrictionsDetail' => (false), is_active), path + '/RestrictionsDetail/Restriction').AsDataset(L.RestrictionsDetail, R.RestrictionsDetail);
      checked_RestrictionsDetail := MAP (is_deleted => R.RestrictionsDetail,
                              is_added => L.RestrictionsDetail,
                              updated_RestrictionsDetail);
      SELF.RestrictionsDetail := checked_RestrictionsDetail;
    
      updated_EndorsementsDetail := _df_DiffString(CASE(path + '/EndorsementsDetail', '/Drivers/Driver/EndorsementsDetail' => (false), is_active), path + '/EndorsementsDetail/Endorsement').AsDataset(L.EndorsementsDetail, R.EndorsementsDetail);
      checked_EndorsementsDetail := MAP (is_deleted => R.EndorsementsDetail,
                              is_added => L.EndorsementsDetail,
                              updated_EndorsementsDetail);
      SELF.EndorsementsDetail := checked_EndorsementsDetail;
    
      path_Address := path + '/Address';
    
      updated_Address := _df_UniversalAddress(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.DOD  := L.DOD;
      SELF.OrigIssueDate  := L.OrigIssueDate;
      SELF.OrigExpDate  := L.OrigExpDate;
      SELF.ActiveDate  := L.ActiveDate;
      SELF.InactiveDate  := L.InactiveDate;
      SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_DLEmbeddedReport2Record ProcessTxRow(layouts._lt_row_DLEmbeddedReport2Record L, layouts._lt_row_DLEmbeddedReport2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;
      SELF.DOB2  := L.DOB2;
      SELF.ExpirationDate  := L.ExpirationDate;
      SELF.IssueDate  := L.IssueDate;

      updated_RestrictionsDetail := _df_DiffString(CASE(path + '/RestrictionsDetail', '/Drivers/Driver/RestrictionsDetail' => (false), is_active), path + '/RestrictionsDetail/Restriction').AsDataset(L.RestrictionsDetail, R.RestrictionsDetail);
      checked_RestrictionsDetail := MAP (is_deleted => R.RestrictionsDetail,
                              is_added => L.RestrictionsDetail,
                              updated_RestrictionsDetail);
      SELF.RestrictionsDetail := checked_RestrictionsDetail;
    
      updated_EndorsementsDetail := _df_DiffString(CASE(path + '/EndorsementsDetail', '/Drivers/Driver/EndorsementsDetail' => (false), is_active), path + '/EndorsementsDetail/Endorsement').AsDataset(L.EndorsementsDetail, R.EndorsementsDetail);
      checked_EndorsementsDetail := MAP (is_deleted => R.EndorsementsDetail,
                              is_added => L.EndorsementsDetail,
                              updated_EndorsementsDetail);
      SELF.EndorsementsDetail := checked_EndorsementsDetail;
    
      path_Address := path + '/Address';
    
      updated_Address := _df_UniversalAddress(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.DOD  := L.DOD;
      SELF.OrigIssueDate  := L.OrigIssueDate;
      SELF.OrigExpDate  := L.OrigExpDate;
      SELF.ActiveDate  := L.ActiveDate;
      SELF.InactiveDate  := L.InactiveDate;
      SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_DLEmbeddedReport2Record _new, layouts._lt_DLEmbeddedReport2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_driverlicenseoriginstate(layouts._lt_DLEmbeddedReport2Record L, layouts._lt_DLEmbeddedReport2Record R) := FUNCTION
    boolean IsInner :=  (L.OriginState = R.OriginState AND L.DriverLicense = R.DriverLicense);

    boolean IsOuterRight :=   (L.OriginState = '' AND L.DriverLicense = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_driverlicenseoriginstate (dataset(layouts._lt_DLEmbeddedReport2Record) _n, dataset(layouts._lt_DLEmbeddedReport2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_DLEmbeddedReport2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_DLEmbeddedReport2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.OriginState = RIGHT.OriginState AND LEFT.DriverLicense = RIGHT.DriverLicense,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_driverlicenseoriginstate(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.OriginState = RIGHT.OriginState AND LEFT.DriverLicense = RIGHT.DriverLicense,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_driverlicenseoriginstate(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_DLEmbeddedReport2Record);
  END;
  
END;

EXPORT _df_MotorVehicleReportPersonOrBusiness(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReportPersonOrBusiness L, layouts._lt_MotorVehicleReportPersonOrBusiness R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_SSN := (L.SSN != R.SSN);
    shared boolean updated_DriverLicenseNumber := (L.DriverLicenseNumber != R.DriverLicenseNumber);

    shared is_updated := false
      OR updated_SSN
      OR updated_DriverLicenseNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow))
         +  IF (updated_DriverLicenseNumber, DATASET ([{'DriverLicenseNumber', R.DriverLicenseNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_MotorVehicleReportPersonOrBusiness ProcessTx(layouts._lt_MotorVehicleReportPersonOrBusiness L, layouts._lt_MotorVehicleReportPersonOrBusiness R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_MotorVehicleReportPersonOrBusiness _new, layouts._lt_MotorVehicleReportPersonOrBusiness _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_MotorVehicleReportRegistrationInfo(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReportRegistrationInfo L, layouts._lt_MotorVehicleReportRegistrationInfo R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_TrueLicensePlate := (L.TrueLicensePlate != R.TrueLicensePlate);
    shared boolean updated_LicenseState := (L.LicenseState != R.LicenseState);

    shared is_updated := false
      OR updated_TrueLicensePlate
      OR updated_LicenseState;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_TrueLicensePlate, DATASET ([{'TrueLicensePlate', R.TrueLicensePlate}], layouts.DiffMetaRow))
         +  IF (updated_LicenseState, DATASET ([{'LicenseState', R.LicenseState}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_MotorVehicleReportRegistrationInfo ProcessTx(layouts._lt_MotorVehicleReportRegistrationInfo L, layouts._lt_MotorVehicleReportRegistrationInfo R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.FirstDate  := L.FirstDate;
      SELF.EarliestEffectiveDate  := L.EarliestEffectiveDate;
      SELF.LatestEffectiveDate  := L.LatestEffectiveDate;
      SELF.LatestExpirationDate  := L.LatestExpirationDate;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_MotorVehicleReportRegistrationInfo _new, layouts._lt_MotorVehicleReportRegistrationInfo _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_MotorVehicleReportRegistrant(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReportRegistrant L, layouts._lt_MotorVehicleReportRegistrant R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_MotorVehicleReportRegistrant ProcessTx(layouts._lt_MotorVehicleReportRegistrant L, layouts._lt_MotorVehicleReportRegistrant R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_RegistrantInfo := path + '/RegistrantInfo';
    
      updated_RegistrantInfo := _df_MotorVehicleReportPersonOrBusiness(is_active, path_RegistrantInfo).AsRecord(L.RegistrantInfo, R.RegistrantInfo);
        
      checked_RegistrantInfo := MAP (is_deleted => R.RegistrantInfo,
                              is_added => L.RegistrantInfo,
                              updated_RegistrantInfo);
      SELF.RegistrantInfo := checked_RegistrantInfo;

      path_RegistrationInfo := path + '/RegistrationInfo';
    
      updated_RegistrationInfo := _df_MotorVehicleReportRegistrationInfo(is_active, path_RegistrationInfo).AsRecord(L.RegistrationInfo, R.RegistrationInfo);
        
      checked_RegistrationInfo := MAP (is_deleted => R.RegistrationInfo,
                              is_added => L.RegistrationInfo,
                              updated_RegistrationInfo);
      SELF.RegistrationInfo := checked_RegistrationInfo;
      SELF.TitleIssueDate  := L.TitleIssueDate;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_MotorVehicleReportRegistrant ProcessTxRow(layouts._lt_row_MotorVehicleReportRegistrant L, layouts._lt_row_MotorVehicleReportRegistrant R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_RegistrantInfo := path + '/RegistrantInfo';
    
      updated_RegistrantInfo := _df_MotorVehicleReportPersonOrBusiness(is_active, path_RegistrantInfo).AsRecord(L.RegistrantInfo, R.RegistrantInfo);
        
      checked_RegistrantInfo := MAP (is_deleted => R.RegistrantInfo,
                              is_added => L.RegistrantInfo,
                              updated_RegistrantInfo);
      SELF.RegistrantInfo := checked_RegistrantInfo;

      path_RegistrationInfo := path + '/RegistrationInfo';
    
      updated_RegistrationInfo := _df_MotorVehicleReportRegistrationInfo(is_active, path_RegistrationInfo).AsRecord(L.RegistrationInfo, R.RegistrationInfo);
        
      checked_RegistrationInfo := MAP (is_deleted => R.RegistrationInfo,
                              is_added => L.RegistrationInfo,
                              updated_RegistrationInfo);
      SELF.RegistrationInfo := checked_RegistrationInfo;
      SELF.TitleIssueDate  := L.TitleIssueDate;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_MotorVehicleReportRegistrant _new, layouts._lt_MotorVehicleReportRegistrant _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_registrantinfo_uniqueid(layouts._lt_MotorVehicleReportRegistrant L, layouts._lt_MotorVehicleReportRegistrant R) := FUNCTION
    boolean IsInner :=  (L.RegistrantInfo.UniqueId = R.RegistrantInfo.UniqueId);

    boolean IsOuterRight :=   (L.RegistrantInfo.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_registrantinfo_uniqueid (dataset(layouts._lt_MotorVehicleReportRegistrant) _n, dataset(layouts._lt_MotorVehicleReportRegistrant) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_MotorVehicleReportRegistrant, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_MotorVehicleReportRegistrant, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.RegistrantInfo.UniqueId = RIGHT.RegistrantInfo.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_registrantinfo_uniqueid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.RegistrantInfo.UniqueId = RIGHT.RegistrantInfo.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_registrantinfo_uniqueid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_MotorVehicleReportRegistrant);
  END;
  
END;

EXPORT _df_MotorVehicleReport2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReport2Record L, layouts._lt_MotorVehicleReport2Record R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_MotorVehicleReport2Record ProcessTx(layouts._lt_MotorVehicleReport2Record L, layouts._lt_MotorVehicleReport2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.VehicleInfo  := L.VehicleInfo;
      SELF.VinaData  := L.VinaData;

      updated_Registrants := _df_MotorVehicleReportRegistrant(is_active, path + '/Registrants/Registrant').AsDataset_registrantinfo_uniqueid(L.Registrants, R.Registrants);
      checked_Registrants := MAP (is_deleted => R.Registrants,
                              is_added => L.Registrants,
                              updated_Registrants);
      SELF.Registrants  := checked_Registrants;
      SELF.Owners  := L.Owners;
      SELF.LienHolders  := L.LienHolders;
      SELF.Lessees  := L.Lessees;
      SELF.Lessors  := L.Lessors;
      SELF.Brands  := L.Brands;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_MotorVehicleReport2Record ProcessTxRow(layouts._lt_row_MotorVehicleReport2Record L, layouts._lt_row_MotorVehicleReport2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.VehicleInfo  := L.VehicleInfo;
      SELF.VinaData  := L.VinaData;

      updated_Registrants := _df_MotorVehicleReportRegistrant(is_active, path + '/Registrants/Registrant').AsDataset_registrantinfo_uniqueid(L.Registrants, R.Registrants);
      checked_Registrants := MAP (is_deleted => R.Registrants,
                              is_added => L.Registrants,
                              updated_Registrants);
      SELF.Registrants  := checked_Registrants;
      SELF.Owners  := L.Owners;
      SELF.LienHolders  := L.LienHolders;
      SELF.Lessees  := L.Lessees;
      SELF.Lessors  := L.Lessors;
      SELF.Brands  := L.Brands;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_MotorVehicleReport2Record _new, layouts._lt_MotorVehicleReport2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_vehicleinfo_makevehicleinfo_modelvehicleinfo_vin(layouts._lt_MotorVehicleReport2Record L, layouts._lt_MotorVehicleReport2Record R) := FUNCTION
    boolean IsInner :=  (L.VehicleInfo.VIN = R.VehicleInfo.VIN AND L.VehicleInfo.Make = R.VehicleInfo.Make AND L.VehicleInfo.Model = R.VehicleInfo.Model);

    boolean IsOuterRight :=   (L.VehicleInfo.VIN = '' AND L.VehicleInfo.Make = '' AND L.VehicleInfo.Model = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_vehicleinfo_makevehicleinfo_modelvehicleinfo_vin (dataset(layouts._lt_MotorVehicleReport2Record) _n, dataset(layouts._lt_MotorVehicleReport2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_MotorVehicleReport2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_MotorVehicleReport2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.VehicleInfo.VIN = RIGHT.VehicleInfo.VIN AND LEFT.VehicleInfo.Make = RIGHT.VehicleInfo.Make AND LEFT.VehicleInfo.Model = RIGHT.VehicleInfo.Model,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_vehicleinfo_makevehicleinfo_modelvehicleinfo_vin(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.VehicleInfo.VIN = RIGHT.VehicleInfo.VIN AND LEFT.VehicleInfo.Make = RIGHT.VehicleInfo.Make AND LEFT.VehicleInfo.Model = RIGHT.VehicleInfo.Model,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_vehicleinfo_makevehicleinfo_modelvehicleinfo_vin(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_MotorVehicleReport2Record);
  END;
  
END;

EXPORT _df_NameAndCompany(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_NameAndCompany L, layouts._lt_NameAndCompany R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_First := (L.First != R.First);
    shared boolean updated_Last := (L.Last != R.Last);

    shared is_updated := false
      OR updated_First
      OR updated_Last;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_First, DATASET ([{'First', R.First}], layouts.DiffMetaRow))
         +  IF (updated_Last, DATASET ([{'Last', R.Last}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_NameAndCompany ProcessTx(layouts._lt_NameAndCompany L, layouts._lt_NameAndCompany R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_NameAndCompany _new, layouts._lt_NameAndCompany _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_BankruptcySearch2Name(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BankruptcySearch2Name L, layouts._lt_BankruptcySearch2Name R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_First := (L.First != R.First);
    shared boolean updated_Last := (L.Last != R.Last);

    shared is_updated := false
      OR updated_First
      OR updated_Last;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_First, DATASET ([{'First', R.First}], layouts.DiffMetaRow))
         +  IF (updated_Last, DATASET ([{'Last', R.Last}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BankruptcySearch2Name ProcessTx(layouts._lt_BankruptcySearch2Name L, layouts._lt_BankruptcySearch2Name R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_BankruptcySearch2Name ProcessTxRow(layouts._lt_row_BankruptcySearch2Name L, layouts._lt_row_BankruptcySearch2Name R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_BankruptcySearch2Name _new, layouts._lt_BankruptcySearch2Name _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_firstlasttype(layouts._lt_BankruptcySearch2Name L, layouts._lt_BankruptcySearch2Name R) := FUNCTION
    boolean IsInner :=  (L.Last = R.Last AND L._Type = R._Type AND L.First = R.First);

    boolean IsOuterRight :=   (L.Last = '' AND L._Type = '' AND L.First = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_firstlasttype (dataset(layouts._lt_BankruptcySearch2Name) _n, dataset(layouts._lt_BankruptcySearch2Name) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_BankruptcySearch2Name, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_BankruptcySearch2Name, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT._Type = RIGHT._Type AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlasttype(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT._Type = RIGHT._Type AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlasttype(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_BankruptcySearch2Name);
  END;
  
END;

EXPORT _df_BankruptcyPerson2(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BankruptcyPerson2 L, layouts._lt_BankruptcyPerson2 R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BankruptcyPerson2 ProcessTx(layouts._lt_BankruptcyPerson2 L, layouts._lt_BankruptcyPerson2 R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlasttype(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;
      SELF.Addresses  := L.Addresses;

      updated_AddressesEx := _df_AddressWithRawInfo(is_active, path + '/AddressesEx/Address').AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(L.AddressesEx, R.AddressesEx);
      checked_AddressesEx := MAP (is_deleted => R.AddressesEx,
                              is_added => L.AddressesEx,
                              updated_AddressesEx);
      SELF.AddressesEx  := checked_AddressesEx;

      updated_Phones := _df_DiffString(CASE(path + '/Phones', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Phones' => (false), is_active), path + '/Phones/Phone10').AsDataset(L.Phones, R.Phones);
      checked_Phones := MAP (is_deleted => R.Phones,
                              is_added => L.Phones,
                              updated_Phones);
      SELF.Phones := checked_Phones;
          SELF.PhonesEx  := L.PhonesEx;

      updated_Emails := _df_DiffString(CASE(path + '/Emails', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Emails' => (false), is_active), path + '/Emails/Email').AsDataset(L.Emails, R.Emails);
      checked_Emails := MAP (is_deleted => R.Emails,
                              is_added => L.Emails,
                              updated_Emails);
      SELF.Emails := checked_Emails;
    

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_BankruptcyPerson2 ProcessTxRow(layouts._lt_row_BankruptcyPerson2 L, layouts._lt_row_BankruptcyPerson2 R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlasttype(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;
      SELF.Addresses  := L.Addresses;

      updated_AddressesEx := _df_AddressWithRawInfo(is_active, path + '/AddressesEx/Address').AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(L.AddressesEx, R.AddressesEx);
      checked_AddressesEx := MAP (is_deleted => R.AddressesEx,
                              is_added => L.AddressesEx,
                              updated_AddressesEx);
      SELF.AddressesEx  := checked_AddressesEx;

      updated_Phones := _df_DiffString(CASE(path + '/Phones', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Phones' => (false), is_active), path + '/Phones/Phone10').AsDataset(L.Phones, R.Phones);
      checked_Phones := MAP (is_deleted => R.Phones,
                              is_added => L.Phones,
                              updated_Phones);
      SELF.Phones := checked_Phones;
          SELF.PhonesEx  := L.PhonesEx;

      updated_Emails := _df_DiffString(CASE(path + '/Emails', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Emails' => (false), is_active), path + '/Emails/Email').AsDataset(L.Emails, R.Emails);
      checked_Emails := MAP (is_deleted => R.Emails,
                              is_added => L.Emails,
                              updated_Emails);
      SELF.Emails := checked_Emails;
    
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_BankruptcyPerson2 _new, layouts._lt_BankruptcyPerson2 _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_BankruptcyReport2Debtor(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BankruptcyReport2Debtor L, layouts._lt_BankruptcyReport2Debtor R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BankruptcyReport2Debtor ProcessTx(layouts._lt_BankruptcyReport2Debtor L, layouts._lt_BankruptcyReport2Debtor R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlasttype(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;
      SELF.Addresses  := L.Addresses;

      updated_AddressesEx := _df_AddressWithRawInfo(is_active, path + '/AddressesEx/Address').AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(L.AddressesEx, R.AddressesEx);
      checked_AddressesEx := MAP (is_deleted => R.AddressesEx,
                              is_added => L.AddressesEx,
                              updated_AddressesEx);
      SELF.AddressesEx  := checked_AddressesEx;

      updated_Phones := _df_DiffString(CASE(path + '/Phones', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Phones' => (false), is_active), path + '/Phones/Phone10').AsDataset(L.Phones, R.Phones);
      checked_Phones := MAP (is_deleted => R.Phones,
                              is_added => L.Phones,
                              updated_Phones);
      SELF.Phones := checked_Phones;
          SELF.PhonesEx  := L.PhonesEx;

      updated_Emails := _df_DiffString(CASE(path + '/Emails', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Emails' => (false), is_active), path + '/Emails/Email').AsDataset(L.Emails, R.Emails);
      checked_Emails := MAP (is_deleted => R.Emails,
                              is_added => L.Emails,
                              updated_Emails);
      SELF.Emails := checked_Emails;
          SELF.StatusDate  := L.StatusDate;
      SELF.DateVacated  := L.DateVacated;
      SELF.DateTransferred  := L.DateTransferred;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_BankruptcyReport2Debtor ProcessTxRow(layouts._lt_row_BankruptcyReport2Debtor L, layouts._lt_row_BankruptcyReport2Debtor R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlasttype(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;
      SELF.Addresses  := L.Addresses;

      updated_AddressesEx := _df_AddressWithRawInfo(is_active, path + '/AddressesEx/Address').AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(L.AddressesEx, R.AddressesEx);
      checked_AddressesEx := MAP (is_deleted => R.AddressesEx,
                              is_added => L.AddressesEx,
                              updated_AddressesEx);
      SELF.AddressesEx  := checked_AddressesEx;

      updated_Phones := _df_DiffString(CASE(path + '/Phones', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Phones' => (false), is_active), path + '/Phones/Phone10').AsDataset(L.Phones, R.Phones);
      checked_Phones := MAP (is_deleted => R.Phones,
                              is_added => L.Phones,
                              updated_Phones);
      SELF.Phones := checked_Phones;
          SELF.PhonesEx  := L.PhonesEx;

      updated_Emails := _df_DiffString(CASE(path + '/Emails', '/Bankruptcies/Bankruptcy/Debtors/Debtor/Emails' => (false), is_active), path + '/Emails/Email').AsDataset(L.Emails, R.Emails);
      checked_Emails := MAP (is_deleted => R.Emails,
                              is_added => L.Emails,
                              updated_Emails);
      SELF.Emails := checked_Emails;
          SELF.StatusDate  := L.StatusDate;
      SELF.DateVacated  := L.DateVacated;
      SELF.DateTransferred  := L.DateTransferred;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_BankruptcyReport2Debtor _new, layouts._lt_BankruptcyReport2Debtor _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_uniqueid(layouts._lt_BankruptcyReport2Debtor L, layouts._lt_BankruptcyReport2Debtor R) := FUNCTION
    boolean IsInner :=  (L.UniqueId = R.UniqueId);

    boolean IsOuterRight :=   (L.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_uniqueid (dataset(layouts._lt_BankruptcyReport2Debtor) _n, dataset(layouts._lt_BankruptcyReport2Debtor) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_BankruptcyReport2Debtor, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_BankruptcyReport2Debtor, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.UniqueId = RIGHT.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_uniqueid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.UniqueId = RIGHT.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_uniqueid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_BankruptcyReport2Debtor);
  END;
  
END;

EXPORT _df_BankruptcyReport2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BankruptcyReport2Record L, layouts._lt_BankruptcyReport2Record R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BankruptcyReport2Record ProcessTx(layouts._lt_BankruptcyReport2Record L, layouts._lt_BankruptcyReport2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.FilingDate  := L.FilingDate;
      SELF.OriginalFilingDate  := L.OriginalFilingDate;
      SELF.ClosedDate  := L.ClosedDate;
      SELF.ReopenDate  := L.ReopenDate;
      SELF.ConvertedDate  := L.ConvertedDate;
      SELF.ClaimsDeadline  := L.ClaimsDeadline;
      SELF.ComplaintDeadline  := L.ComplaintDeadline;
      SELF.DischargeDate  := L.DischargeDate;
      SELF.Meeting  := L.Meeting;
      SELF.DateReclosed  := L.DateReclosed;
      SELF.BarDate  := L.BarDate;
      SELF.StatusHistory  := L.StatusHistory;
      SELF.Comments  := L.Comments;

      updated_Debtors := _df_BankruptcyReport2Debtor(is_active, path + '/Debtors/Debtor').AsDataset_uniqueid(L.Debtors, R.Debtors);
      checked_Debtors := MAP (is_deleted => R.Debtors,
                              is_added => L.Debtors,
                              updated_Debtors);
      SELF.Debtors  := checked_Debtors;
      SELF.Attorneys  := L.Attorneys;
      SELF.Trustees  := L.Trustees;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_BankruptcyReport2Record ProcessTxRow(layouts._lt_row_BankruptcyReport2Record L, layouts._lt_row_BankruptcyReport2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.FilingDate  := L.FilingDate;
      SELF.OriginalFilingDate  := L.OriginalFilingDate;
      SELF.ClosedDate  := L.ClosedDate;
      SELF.ReopenDate  := L.ReopenDate;
      SELF.ConvertedDate  := L.ConvertedDate;
      SELF.ClaimsDeadline  := L.ClaimsDeadline;
      SELF.ComplaintDeadline  := L.ComplaintDeadline;
      SELF.DischargeDate  := L.DischargeDate;
      SELF.Meeting  := L.Meeting;
      SELF.DateReclosed  := L.DateReclosed;
      SELF.BarDate  := L.BarDate;
      SELF.StatusHistory  := L.StatusHistory;
      SELF.Comments  := L.Comments;

      updated_Debtors := _df_BankruptcyReport2Debtor(is_active, path + '/Debtors/Debtor').AsDataset_uniqueid(L.Debtors, R.Debtors);
      checked_Debtors := MAP (is_deleted => R.Debtors,
                              is_added => L.Debtors,
                              updated_Debtors);
      SELF.Debtors  := checked_Debtors;
      SELF.Attorneys  := L.Attorneys;
      SELF.Trustees  := L.Trustees;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_BankruptcyReport2Record _new, layouts._lt_BankruptcyReport2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_casenumbercasetypefilingjurisdiction(layouts._lt_BankruptcyReport2Record L, layouts._lt_BankruptcyReport2Record R) := FUNCTION
    boolean IsInner :=  (L.CaseType = R.CaseType AND L.FilingJurisdiction = R.FilingJurisdiction AND L.CaseNumber = R.CaseNumber);

    boolean IsOuterRight :=   (L.CaseType = '' AND L.FilingJurisdiction = '' AND L.CaseNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_casenumbercasetypefilingjurisdiction (dataset(layouts._lt_BankruptcyReport2Record) _n, dataset(layouts._lt_BankruptcyReport2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_BankruptcyReport2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_BankruptcyReport2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.CaseType = RIGHT.CaseType AND LEFT.FilingJurisdiction = RIGHT.FilingJurisdiction AND LEFT.CaseNumber = RIGHT.CaseNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_casenumbercasetypefilingjurisdiction(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.CaseType = RIGHT.CaseType AND LEFT.FilingJurisdiction = RIGHT.FilingJurisdiction AND LEFT.CaseNumber = RIGHT.CaseNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_casenumbercasetypefilingjurisdiction(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_BankruptcyReport2Record);
  END;
  
END;

EXPORT _df_LienJudgmentParty(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_LienJudgmentParty L, layouts._lt_LienJudgmentParty R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_LienJudgmentParty ProcessTx(layouts._lt_LienJudgmentParty L, layouts._lt_LienJudgmentParty R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_LienJudgmentParty ProcessTxRow(layouts._lt_row_LienJudgmentParty L, layouts._lt_row_LienJudgmentParty R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_LienJudgmentParty _new, layouts._lt_LienJudgmentParty _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_uniqueid(layouts._lt_LienJudgmentParty L, layouts._lt_LienJudgmentParty R) := FUNCTION
    boolean IsInner :=  (L.UniqueId = R.UniqueId);

    boolean IsOuterRight :=   (L.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_uniqueid (dataset(layouts._lt_LienJudgmentParty) _n, dataset(layouts._lt_LienJudgmentParty) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_LienJudgmentParty, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_LienJudgmentParty, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.UniqueId = RIGHT.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_uniqueid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.UniqueId = RIGHT.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_uniqueid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_LienJudgmentParty);
  END;
  
END;

EXPORT _df_LienJudgmentDebtor(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_LienJudgmentDebtor L, layouts._lt_LienJudgmentDebtor R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_LienJudgmentDebtor ProcessTx(layouts._lt_LienJudgmentDebtor L, layouts._lt_LienJudgmentDebtor R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.Addresses  := L.Addresses;
      SELF.Phones  := L.Phones;

      updated_ParsedParties := _df_LienJudgmentParty(is_active, path + '/ParsedParties/Party').AsDataset_uniqueid(L.ParsedParties, R.ParsedParties);
      checked_ParsedParties := MAP (is_deleted => R.ParsedParties,
                              is_added => L.ParsedParties,
                              updated_ParsedParties);
      SELF.ParsedParties  := checked_ParsedParties;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_LienJudgmentDebtor ProcessTxRow(layouts._lt_row_LienJudgmentDebtor L, layouts._lt_row_LienJudgmentDebtor R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.Addresses  := L.Addresses;
      SELF.Phones  := L.Phones;

      updated_ParsedParties := _df_LienJudgmentParty(is_active, path + '/ParsedParties/Party').AsDataset_uniqueid(L.ParsedParties, R.ParsedParties);
      checked_ParsedParties := MAP (is_deleted => R.ParsedParties,
                              is_added => L.ParsedParties,
                              updated_ParsedParties);
      SELF.ParsedParties  := checked_ParsedParties;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_LienJudgmentDebtor _new, layouts._lt_LienJudgmentDebtor _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_originnamessn(layouts._lt_LienJudgmentDebtor L, layouts._lt_LienJudgmentDebtor R) := FUNCTION
    boolean IsInner :=  (L.SSN = R.SSN AND L.OriginName = R.OriginName);

    boolean IsOuterRight :=   (L.SSN = '' AND L.OriginName = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_originnamessn (dataset(layouts._lt_LienJudgmentDebtor) _n, dataset(layouts._lt_LienJudgmentDebtor) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_LienJudgmentDebtor, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_LienJudgmentDebtor, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.SSN = RIGHT.SSN AND LEFT.OriginName = RIGHT.OriginName,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_originnamessn(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.SSN = RIGHT.SSN AND LEFT.OriginName = RIGHT.OriginName,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_originnamessn(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_LienJudgmentDebtor);
  END;
  
END;

EXPORT _df_LienJudgmentReportRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_LienJudgmentReportRecord L, layouts._lt_LienJudgmentReportRecord R, boolean is_deleted, boolean is_added) := MODULE

    shared is_updated := false;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=  DATASET ([], layouts.DiffMetaRow);

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_LienJudgmentReportRecord ProcessTx(layouts._lt_LienJudgmentReportRecord L, layouts._lt_LienJudgmentReportRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.MatchedParty  := L.MatchedParty;
      SELF.OriginFilingDate  := L.OriginFilingDate;
      SELF.JudgeSatisfiedDate  := L.JudgeSatisfiedDate;
      SELF.SuitDate  := L.SuitDate;
      SELF.JudgeVacatedDate  := L.JudgeVacatedDate;
      SELF.ReleaseDate  := L.ReleaseDate;

      updated_Debtors := _df_LienJudgmentDebtor(is_active, path + '/Debtors/Debtor').AsDataset_originnamessn(L.Debtors, R.Debtors);
      checked_Debtors := MAP (is_deleted => R.Debtors,
                              is_added => L.Debtors,
                              updated_Debtors);
      SELF.Debtors  := checked_Debtors;
      SELF.ThirdParties  := L.ThirdParties;
      SELF.Creditors  := L.Creditors;
      SELF.DebtorAttorneys  := L.DebtorAttorneys;
      SELF.Filings  := L.Filings;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_LienJudgmentReportRecord ProcessTxRow(layouts._lt_row_LienJudgmentReportRecord L, layouts._lt_row_LienJudgmentReportRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.MatchedParty  := L.MatchedParty;
      SELF.OriginFilingDate  := L.OriginFilingDate;
      SELF.JudgeSatisfiedDate  := L.JudgeSatisfiedDate;
      SELF.SuitDate  := L.SuitDate;
      SELF.JudgeVacatedDate  := L.JudgeVacatedDate;
      SELF.ReleaseDate  := L.ReleaseDate;

      updated_Debtors := _df_LienJudgmentDebtor(is_active, path + '/Debtors/Debtor').AsDataset_originnamessn(L.Debtors, R.Debtors);
      checked_Debtors := MAP (is_deleted => R.Debtors,
                              is_added => L.Debtors,
                              updated_Debtors);
      SELF.Debtors  := checked_Debtors;
      SELF.ThirdParties  := L.ThirdParties;
      SELF.Creditors  := L.Creditors;
      SELF.DebtorAttorneys  := L.DebtorAttorneys;
      SELF.Filings  := L.Filings;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_LienJudgmentReportRecord _new, layouts._lt_LienJudgmentReportRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_tmsid(layouts._lt_LienJudgmentReportRecord L, layouts._lt_LienJudgmentReportRecord R) := FUNCTION
    boolean IsInner :=  (L.TMSId = R.TMSId);

    boolean IsOuterRight :=   (L.TMSId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_tmsid (dataset(layouts._lt_LienJudgmentReportRecord) _n, dataset(layouts._lt_LienJudgmentReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_LienJudgmentReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_LienJudgmentReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.TMSId = RIGHT.TMSId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_tmsid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.TMSId = RIGHT.TMSId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_tmsid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_LienJudgmentReportRecord);
  END;
  
END;

EXPORT _df_PersonSlimReportResponse(boolean is_active, string path) := MODULE
  EXPORT layouts._lt_PersonSlimReportResponse ProcessTx(layouts._lt_PersonSlimReportResponse L, layouts._lt_PersonSlimReportResponse R) :=TRANSFORM

  
      SELF._Header := L._Header;
  
      SELF.UniqueId := L.UniqueId;

      SELF.Addresses  := _df_PersonSlimReportAddress(CASE(path + '/Addresses', '/Addresses' => (MonitorAddress), is_active), path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberstreetpredirectionunitnumberzip5(L.Addresses, R.Addresses);

        SELF.Phones := L.Phones;

        SELF.ProfessionalLicenses := L.ProfessionalLicenses;

        SELF.PeopleAtWorks := L.PeopleAtWorks;

        SELF.Aircrafts := L.Aircrafts;

      SELF.FAACertifications  := _df_BpsFAACertification(CASE(path + '/FAACertifications', '/FAACertifications' => (MonitorCertification), is_active), path + '/FAACertifications/Certification').AsDataset_address_countyaddress_state(L.FAACertifications, R.FAACertifications);

        SELF.WaterCrafts := L.WaterCrafts;

        SELF.UCCFilings := L.UCCFilings;

        SELF.SexualOffenses := L.SexualOffenses;

        SELF.Criminals := L.Criminals;

        SELF.WeaponPermits := L.WeaponPermits;

      SELF.HuntingFishingLicenses  := _df_HuntFishRecord(CASE(path + '/HuntingFishingLicenses', '/HuntingFishingLicenses' => (MonitorHuntingFishingLicense), is_active), path + '/HuntingFishingLicenses/HuntingFishingLicense').AsDataset_licensedate_yearlicensenumberlicensetype(L.HuntingFishingLicenses, R.HuntingFishingLicenses);

      SELF.FirearmExplosives  := _df_FirearmRecord(CASE(path + '/FirearmExplosives', '/FirearmExplosives' => (MonitorFirearmExplosive), is_active), path + '/FirearmExplosives/FirearmExplosive').AsDataset_licenseissuestatelicensenumber(L.FirearmExplosives, R.FirearmExplosives);

      SELF.ControlledSubstances  := _df_DEAControlledSubstanceSearch2Record(CASE(path + '/ControlledSubstances', '/ControlledSubstances' => (MonitorControlledSubstance), is_active), path + '/ControlledSubstances/ControlledSubstance').AsDataset_registrationnumber(L.ControlledSubstances, R.ControlledSubstances);

      SELF.VoterRegistrations  := _df_VoterReport2Record(CASE(path + '/VoterRegistrations', '/VoterRegistrations' => (MonitorVoterRegistration), is_active), path + '/VoterRegistrations/VoterRegistration').AsDataset_registratestateresidentaddress_county(L.VoterRegistrations, R.VoterRegistrations);

      SELF.Drivers  := _df_DLEmbeddedReport2Record(CASE(path + '/Drivers', '/Drivers' => (MonitorDriver), is_active), path + '/Drivers/Driver').AsDataset_driverlicenseoriginstate(L.Drivers, R.Drivers);

      SELF.Vehicles  := _df_MotorVehicleReport2Record(CASE(path + '/Vehicles', '/Vehicles' => (MonitorVehicle), is_active), path + '/Vehicles/Vehicle').AsDataset_vehicleinfo_makevehicleinfo_modelvehicleinfo_vin(L.Vehicles, R.Vehicles);

        SELF.Accidents := L.Accidents;

      SELF.Bankruptcies  := _df_BankruptcyReport2Record(CASE(path + '/Bankruptcies', '/Bankruptcies' => (MonitorBankruptcy), is_active), path + '/Bankruptcies/Bankruptcy').AsDataset_casenumbercasetypefilingjurisdiction(L.Bankruptcies, R.Bankruptcies);

      SELF.LiensJudgments  := _df_LienJudgmentReportRecord(CASE(path + '/LiensJudgments', '/LiensJudgments' => (MonitorLienJudgment), is_active), path + '/LiensJudgments/LienJudgment').AsDataset_tmsid(L.LiensJudgments, R.LiensJudgments);

        SELF.Properties := L.Properties;

        SELF.MarriageDivorces := L.MarriageDivorces;

        SELF.Educations := L.Educations;

        SELF.AKAs := L.AKAs;

        SELF.Imposters := L.Imposters;

        SELF.Deaths := L.Deaths;

        SELF.Utilities := L.Utilities;
END;

    EXPORT AsRecord (layouts._lt_PersonSlimReportResponse _new, layouts._lt_PersonSlimReportResponse _old) := FUNCTION
      RETURN ROW (ProcessTx(_new, _old));
    END;


END;
EXPORT _df_PersonSlimReportResponseEx(boolean is_active, string path) := MODULE
  EXPORT layouts._lt_PersonSlimReportResponseEx ProcessTx(layouts._lt_PersonSlimReportResponseEx L, layouts._lt_PersonSlimReportResponseEx R) :=TRANSFORM

  
      SELF.response := _df_PersonSlimReportResponse(is_active, path).AsRecord(L.response, R.response);
  END;

    EXPORT AsRecord (layouts._lt_PersonSlimReportResponseEx _new, layouts._lt_PersonSlimReportResponseEx _old) := FUNCTION
      RETURN ROW (ProcessTx(_new, _old));
    END;


END;
END;


  //Defines
  the_differenceModule := difference._df_PersonSlimReportResponse;
  the_requestLayout := request._lt_PersonSlimReportRequest;
  the_responseLayout := layouts._lt_PersonSlimReportResponse;


  //Inputs
  string csndServer := '127.0.0.1' : stored('cassandraServer', FORMAT(SEQUENCE(1)));
  string csndUser := '' : stored('cassandraUser', FORMAT(SEQUENCE(2)));
  string csndPassword := '' : stored('cassandraPassword', FORMAT(PASSWORD, SEQUENCE(3)));

  string csndKeySpaceFrom := 'monitors_a' : stored('fromKeyspace', FORMAT(SEQUENCE(4)));
  string csndKeySpaceTo := 'monitors_a' : stored('toKeyspace', FORMAT(SEQUENCE(4)));

  string monAction := 'Create' : STORED('MonAction', FORMAT(SELECT('Create,Run'), SEQUENCE(5)));
  string userId := '' : stored('UserId', FORMAT(SEQUENCE(6)));
  string serviceURL := '' : stored('QueryURL', FORMAT(SEQUENCE(7)));
  string serviceName := '' : stored('QueryName', FORMAT(SEQUENCE(8)));
  unsigned2 serviceTimeout := 1000 : stored('QueryTimeoutSecs', FORMAT(SEQUENCE(9)));
  unsigned1 serviceRetries := 3 : stored('QueryRetries', FORMAT(SEQUENCE(10)));


  string monitorIdIn := '' : stored('MonitorId', FORMAT(SEQUENCE(9)));

  requestIn := DATASET([], the_requestLayout) : STORED ('PersonSlimReportRequest', FEW, FORMAT(FIELDWIDTH(100),FIELDHEIGHT(30), sequence(100)));

  exceptionRec := RECORD
    string10 Source {xpath('Source')};
    integer2 Code {xpath('Code')};
    string100 Message {xpath('Message')};
  END;

  soapoutRec := record 
    dataset (the_responseLayout) ds {xpath('Dataset/Row')};
    
    exceptionRec Exception {xpath('Exception')};
  end;

MonSoapcall(DATASET(the_requestLayout) req) := FUNCTION

  
  // When calling roxie the actual request parameters are placed inside a dataset that is named the same as the request
  // so it looks like:
  //   ........

  in_rec := record
    DATASET (the_requestLayout) PersonSlimReportRequest {xpath('PersonSlimReportRequest/Row'), maxcount(1)};
  end;
  in_rec Format () := transform
    Self.PersonSlimReportRequest := req;
  end;

  ds_request := DATASET ([Format()]);
    


  // execute soapcall
  ar_results := SOAPCALL (ds_request,
                          serviceURL,
                          serviceName,
                          {ds_request},
                          DATASET (soapoutRec),
                          TIMEOUT(serviceTimeout), RETRY(serviceRetries), LITERAL, XPATH('*/Results/Result'));
  RETURN ar_results;
END;

  monitorStoreRec := RECORD
    string MonitorId,
    string result
  END;

// Initialize the Cassandra table, passing in the ECL dataset to provide the rows
// When not using batch mode, maxFutures controls how many simultaenous writes to Cassandra are allowed before
// we start to throttle, and maxRetries controls how many times inserts that fail because Cassandra is too busy
// will be retried.

monitorStoreRec getStoredMonitor(string id) := EMBED(cassandra : server(csndServer), user(csndUser), password(csndPassword), keyspace(csndKeySpaceFrom))
  SELECT monitorId, result from monitor WHERE monitorId=? LIMIT 1;
ENDEMBED;

updateMonitor(dataset(monitorStoreRec) values) := EMBED(cassandra : server(csndServer), user(csndUser), password(csndPassword), keyspace(csndKeySpaceTo), maxFutures(100), maxRetries(10))
  INSERT INTO monitor (monitorId, result) values (?,?);
ENDEMBED;

  MonitorResultRec := RECORD
    string id;
  
    string responseXML;
  
    dataset(the_responseLayout) report;
  END;



RunMonitor (string id, dataset(the_requestLayout) req) := MODULE
  SHARED monitorId := id;
  SHARED monitorStore := getStoredMonitor(id);
  SHARED soapOut := MonSoapCall(req)[1];
  
  SHARED responseRow := soapOut.ds[1];
    
  SHARED responseXML := '<Row>' + TOXML(responseRow) + '</Row>';

  SHARED oldResponse := FROMXML (the_responseLayout, monitorStore.result);

  SHARED diff_result := the_differenceModule(false, '').AsRecord(responseRow, oldResponse);

  EXPORT MonitorResultRec BuildMonitor() :=TRANSFORM
    SELF.id := IF (soapOut.Exception.Code=0, monitorId, ERROR(soapOut.Exception.Code, soapOut.Exception.Message));
    SELF.responseXML := (string) responseXML;
    SELF.report := diff_result;
  END;
  EXPORT Result () := FUNCTION
    RETURN ROW(BuildMonitor());
  END;
END;

  executedAction := RunMonitor(monitorIdIn, requestIn).Result();
  updateMonitor(DATASET([{executedAction.id, executedAction.responseXML}], monitorStoreRec));
  

  output(executedAction.id, NAMED('MonitorId'));
  output(executedAction.report, NAMED('Result'));


  SelectorRec := RECORD
    string monitor {xpath('@monitor')};
    boolean active {xpath('@active')};
  END;

    OUTPUT(DATASET([{'Address', difference.MonitorAddress},{'Certification', difference.MonitorCertification},{'HuntingFishingLicense', difference.MonitorHuntingFishingLicense},{'FirearmExplosive', difference.MonitorFirearmExplosive},{'ControlledSubstance', difference.MonitorControlledSubstance},{'VoterRegistration', difference.MonitorVoterRegistration},{'Driver', difference.MonitorDriver},{'Vehicle', difference.MonitorVehicle},{'Bankruptcy', difference.MonitorBankruptcy},{'LienJudgment', difference.MonitorLienJudgment}], SelectorRec), NAMED('Selected'));
  /*** Generated Code do not hand edit ***/
