/*** Generated Code do not hand edit ***/

EXPORT MonitorESP_demo_PersonSlimReport() := MACRO

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
    integer NonSubjectSuppression {xpath('NonSubjectSuppression')};//hidden[ecl_only]
    integer NonSubjectSuppression2 {xpath('NonSubjectSuppression2')};//hidden[internal]
    string ProductType {xpath('ProductType')};//hidden[internal]
    string11 BatchJobId {xpath('BatchJobId')};//hidden[internal]
    string11 BatchSequenceNumber {xpath('BatchSequenceNumber')};//hidden[internal]
    boolean ArchiveOptIn {xpath('ArchiveOptIn')};//hidden[internal]
    string ProcessSpecId {xpath('ProcessSpecId')};//hidden[internal]
    string ProductCode {xpath('ProductCode')};//hidden[internal]
    boolean AllowRoamingBypass {xpath('AllowRoamingBypass')};//hidden[internal]
    string DataSource {xpath('DataSource')};//hidden[internal]
    string2 ResellerType {xpath('ResellerType')};//hidden[internal]
    unsigned6 GCID {xpath('GCID')};//hidden[internal] // Xsd type: unsigned
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
    string2 IntendedUse {xpath('IntendedUse')};//hidden[internal]
  END;

  EXPORT _lt_BaseReportOption := RECORD (_lt_BaseOption)
  END;

  EXPORT _lt_PersonSlimReportOption := RECORD (_lt_BaseReportOption)
    boolean IncludeMinors {xpath('IncludeMinors')};
    boolean IncludeFullPhonesPlus {xpath('IncludeFullPhonesPlus')};
    boolean IncludeBlankDOD {xpath('IncludeBlankDOD')};
    boolean EnableNationalAccidents {xpath('EnableNationalAccidents')};
    boolean EnableExtraAccidents {xpath('EnableExtraAccidents')};
    boolean IncludePriorProperties {xpath('IncludePriorProperties')};
    boolean IncludeNonRegulatedWatercraftSources {xpath('IncludeNonRegulatedWatercraftSources')};
    boolean IncludeNonRegulatedVehicleSources {xpath('IncludeNonRegulatedVehicleSources')};
    boolean IncludeNonRegulatedDMVSources {xpath('IncludeNonRegulatedDMVSources')};
    string RealTimePermissibleUse {xpath('RealTimePermissibleUse')};
    boolean IncludeAddresses {xpath('IncludeAddresses')};
    boolean IncludePhones {xpath('IncludePhones')};
    boolean IncludeDeaths {xpath('IncludeDeaths')};
    boolean IncludeNames {xpath('IncludeNames')};
    boolean IncludeSSNs {xpath('IncludeSSNs')};
    boolean IncludeDOBs {xpath('IncludeDOBs')};
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

  EXPORT _lt_PersonSlimReportAddress := RECORD (_lt_Address)
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

  EXPORT _lt_PersonSlimReportName := RECORD (_lt_Name)
  END;

  EXPORT _lt_row_PersonSlimReportName := RECORD  (_lt_PersonSlimReportName)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PersonSlimReportPhone := RECORD (DiffMetaRec)
    string10 Phone {xpath('Phone')};
  END;

  EXPORT _lt_row_PersonSlimReportPhone := RECORD  (_lt_PersonSlimReportPhone)
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

  EXPORT _lt_PersonSlimReportDeath := RECORD (_lt_Date)
  END;

  EXPORT _lt_row_PersonSlimReportDeath := RECORD  (_lt_PersonSlimReportDeath)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PersonSlimReportDOB := RECORD (_lt_Date)
  END;

  EXPORT _lt_row_PersonSlimReportDOB := RECORD  (_lt_PersonSlimReportDOB)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PersonSlimReportSSN := RECORD (DiffMetaRec)
    string9 SSN {xpath('SSN')};
  END;

  EXPORT _lt_row_PersonSlimReportSSN := RECORD  (_lt_PersonSlimReportSSN)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_BusinessIdentity := RECORD (DiffMetaRec)
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

  EXPORT _lt_ProfessionalLicenseRecord := RECORD (DiffMetaRec)
    _lt_BusinessIdentity BusinessIds {xpath('BusinessIds')};
    string100 IdValue {xpath('IdValue')};
    string60 LicenseType {xpath('LicenseType')};
    string20 LicenseNumber {xpath('LicenseNumber')};
    string ProviderNumber {xpath('ProviderNumber')};
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

  EXPORT _lt_row_ProfessionalLicenseRecord := RECORD  (_lt_ProfessionalLicenseRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PeopleAtWorkRecord := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_PeopleAtWorkRecord := RECORD  (_lt_PeopleAtWorkRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_AircraftReportRecordBase := RECORD (DiffMetaRec)
    string20 Status {xpath('Status')};
    string8 AircraftNumber {xpath('AircraftNumber')};
    _lt_Date DateFirstSeen {xpath('DateFirstSeen')};
    _lt_Date DateLastSeen {xpath('DateLastSeen')};
    _lt_Date LastActionDate {xpath('LastActionDate')};
    _lt_Date CertificationDate {xpath('CertificationDate')};
  END;

  EXPORT _lt_AircraftReportRegistrant := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_AircraftReportRecord := RECORD  (_lt_AircraftReportRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_BaseWaterCraftReportRecord := RECORD (DiffMetaRec)
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

  EXPORT _lt_WaterCraftOwner := RECORD (DiffMetaRec)
    _lt_Name Name {xpath('Name')};
    _lt_Address Address {xpath('Address')};
    string9 SSN {xpath('SSN')};
    _lt_Date DOB {xpath('DOB')};
    string60 CompanyName {xpath('CompanyName')};
    string12 UniqueId {xpath('UniqueId')};
  END;

  EXPORT _lt_row_WaterCraftOwner := RECORD  (_lt_WaterCraftOwner)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_WaterCraftReportRecord := RECORD (_lt_BaseWaterCraftReportRecord)
    dataset(_lt_WaterCraftOwner) Owners {xpath('Owners/Owner'), MAXCOUNT(iesp.Constants.WATERCRAFTS.MaxOwners * 2)};
  END;

  EXPORT _lt_row_WaterCraftReportRecord := RECORD  (_lt_WaterCraftReportRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_UCCParsedParty := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_UCCParsedParty := RECORD  (_lt_UCCParsedParty)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_UniversalAddress := RECORD (_lt_Address)
    string30 Country {xpath('Country')};
    string30 Province {xpath('Province')};
    boolean IsForeign {xpath('IsForeign')};
  END;

  EXPORT _lt_UniversalAndRawAddress := RECORD (_lt_Address)
    string30 Country {xpath('Country')};
    string30 Province {xpath('Province')};
    boolean IsForeign {xpath('IsForeign')};
    string OrigStreetAddress1 {xpath('OrigStreetAddress1'), maxlength(128)};
    string OrigStreetAddress2 {xpath('OrigStreetAddress2'), maxlength(128)};
  END;

  EXPORT _lt_UCCReport2Person := RECORD (DiffMetaRec)
    string120 OriginName {xpath('OriginName')};
    dataset(_lt_UCCParsedParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.UCCF.MaxPersonParsedParties * 2)};
    dataset(_lt_UniversalAndRawAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.UCCF.MaxPersonAddresses * 2)};
  END;

  EXPORT _lt_row_UCCReport2Person := RECORD  (_lt_UCCReport2Person)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_UCCReport2Record := RECORD (DiffMetaRec)
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
    dataset(_lt_UCCReport2Person) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.UCCF.MaxDebtors * 2)};
    dataset(_lt_UCCReport2Person) Debtors2 {xpath('Debtors2/Debtor'), MAXCOUNT(iesp.Constants.UCCF.MaxDebtors * 2)};
    dataset(_lt_UCCReport2Person) Creditors {xpath('Creditors/Creditor'), MAXCOUNT(iesp.Constants.UCCF.MaxCreditors * 2)};
    dataset(_lt_UCCReport2Person) Secureds {xpath('Secureds/Secured'), MAXCOUNT(iesp.Constants.UCCF.MaxSecureds * 2)};
    dataset(_lt_UCCReport2Person) Assignees {xpath('Assignees/Assignee'), MAXCOUNT(iesp.Constants.UCCF.MaxAssignees * 2)};
    dataset(_lt_UCCReport2Collateral) Collaterals {xpath('Collaterals/Collateral'), MAXCOUNT(iesp.Constants.UCCF.MaxCollaterals * 2)};
    dataset(_lt_UCCReport2Person) Creditors2 {xpath('Creditors2/Creditor'), MAXCOUNT(iesp.Constants.UCCF.MaxCreditors * 2)};
    dataset(_lt_UCCReport2Person) Secureds2 {xpath('Secureds2/Secured'), MAXCOUNT(iesp.Constants.UCCF.MaxSecureds * 2)};
    dataset(_lt_UCCReport2Person) Assignees2 {xpath('Assignees2/Assignee'), MAXCOUNT(iesp.Constants.UCCF.MaxAssignees * 2)};
    dataset(_lt_UCCReport2Collateral) Collaterals2 {xpath('Collaterals2/Collateral'), MAXCOUNT(iesp.Constants.UCCF.MaxCollaterals * 2)};
    dataset(_lt_UCCSigner) Signers {xpath('Signers/Signer'), MAXCOUNT(iesp.Constants.UCCF.MaxSigners * 2)};
    dataset(_lt_UCCReport2Filing) Filings2 {xpath('Filings2/Filing'), MAXCOUNT(iesp.Constants.UCCF.MaxFilings * 2)};
    dataset(_lt_UCCFilingOffice) FilingOffices {xpath('FilingOffices/Office'), MAXCOUNT(iesp.Constants.UCCF.MaxFilingOffices * 2)};
  END;

  EXPORT _lt_row_UCCReport2Record := RECORD  (_lt_UCCReport2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_BaseSexOffReportRecord := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_SexOffReportRecord := RECORD  (_lt_SexOffReportRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_BaseCrimReportRecord := RECORD (DiffMetaRec)
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
    string OffenseTown {xpath('OffenseTown')};
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

  EXPORT _lt_row_CrimReportRecord := RECORD  (_lt_CrimReportRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_CCWPermit := RECORD (DiffMetaRec)
    string15 PermitNumber {xpath('PermitNumber')};
    string46 PermitType {xpath('PermitType')};
    string15 WeaponType {xpath('WeaponType')};
    _lt_Date RegistrationDate {xpath('RegistrationDate')};
    _lt_Date ExpirationDate {xpath('ExpirationDate')};
  END;

  EXPORT _lt_WeaponRecord := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_WeaponRecord := RECORD  (_lt_WeaponRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_MotorVehicleReportVehicleInfo := RECORD (DiffMetaRec)
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
    string30 ReportedName {xpath('ReportedName')};
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
    string17 TitleNumber {xpath('TitleNumber')};
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

  EXPORT _lt_MotorVehicleReportOwner := RECORD (DiffMetaRec)
    string30 HistoryDescription {xpath('HistoryDescription')};
    _lt_MotorVehicleReportPersonOrBusiness OwnerInfo {xpath('OwnerInfo')};
    _lt_MotorVehicleReportTitleInfo TitleInfo {xpath('TitleInfo')};
    _lt_Date SourceDateFirstSeen {xpath('SourceDateFirstSeen')};
    _lt_Date SourceDateLastSeen {xpath('SourceDateLastSeen')};
  END;

  EXPORT _lt_row_MotorVehicleReportOwner := RECORD  (_lt_MotorVehicleReportOwner)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_AccidentReportInvestigationAgent := RECORD (DiffMetaRec)
    string15 AgentReportNumber {xpath('AgentReportNumber')};
    string25 AgentName {xpath('AgentName')};
    string15 AgentRank {xpath('AgentRank')};
    string6 AgentIdBadgeNumber {xpath('AgentIdBadgeNumber')};
    string25 AgentDepartmentName {xpath('AgentDepartmentName')};
  END;

  EXPORT _lt_AccidentReportInvestigation := RECORD (DiffMetaRec)
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

  EXPORT _lt_AccidentReportIndividualInvolved := RECORD (DiffMetaRec)
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

  EXPORT _lt_AccidentReportDriver := RECORD (DiffMetaRec)
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

  EXPORT _lt_AccidentReportVehicle := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_AccidentReportVehicle := RECORD  (_lt_AccidentReportVehicle)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_AccidentReportRecord := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_AccidentReportRecord := RECORD  (_lt_AccidentReportRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_AddressWithRawInfo := RECORD (_lt_Address)
    string OrigStreetAddress1 {xpath('OrigStreetAddress1'), maxlength(128)};
    string OrigStreetAddress2 {xpath('OrigStreetAddress2'), maxlength(128)};
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

  EXPORT _lt_row_Property2Name := RECORD  (_lt_Property2Name)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_Property2Entity := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_Property2Entity := RECORD  (_lt_Property2Entity)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PropertyReport2Record := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_PropertyReport2Record := RECORD  (_lt_PropertyReport2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_BaseMarriageSearch2Record := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_MarriageSearch2Record := RECORD  (_lt_MarriageSearch2Record)
    integer _diff_ord {xpath('@diff_ord')} := 0;
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

  EXPORT _lt_StudentRecord := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_StudentRecord := RECORD  (_lt_StudentRecord)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_SSNInfoBase := RECORD (DiffMetaRec)
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

  EXPORT _lt_Identity := RECORD (DiffMetaRec)
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
    boolean IsLimitedAccessDMF {xpath('IsLimitedAccessDMF')};//hidden[internal]
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

  EXPORT _lt_row_BpsReportIdentity := RECORD  (_lt_BpsReportIdentity)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PersonSlimReportUtility := RECORD (DiffMetaRec)
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

  EXPORT _lt_row_PersonSlimReportUtility := RECORD  (_lt_PersonSlimReportUtility)
    integer _diff_ord {xpath('@diff_ord')} := 0;
  END;

  EXPORT _lt_PersonSlimReportResponse := RECORD
    _lt_ResponseHeader _Header {xpath('Header')};
    string12 UniqueId {xpath('UniqueId')};
    dataset(_lt_PersonSlimReportAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAddresses * 2)};
    dataset(_lt_PersonSlimReportName) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.PersonSlim.MaxNames * 2)};
    dataset(_lt_PersonSlimReportPhone) Phones {xpath('Phones/Entry'), MAXCOUNT(iesp.Constants.PersonSlim.MaxPhones * 2)};
    dataset(_lt_PersonSlimReportDeath) Deaths {xpath('Deaths/Death'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDeaths * 2)};
    dataset(_lt_PersonSlimReportDOB) DOBs {xpath('DOBs/DOB'), MAXCOUNT(iesp.constants.PersonSlim.MaxDOBs * 2)};
    dataset(_lt_PersonSlimReportSSN) SSNs {xpath('SSNs/Entry'), MAXCOUNT(iesp.constants.PersonSlim.MaxSSNs * 2)};
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
    dataset(_lt_BpsReportIdentity) AKAs {xpath('AKAs/AKA'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAKA * 2)};
    dataset(_lt_BpsReportIdentity) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(iesp.Constants.PersonSlim.MaxImposters * 2)};
    dataset(_lt_PersonSlimReportUtility) Utilities {xpath('Utilities/Utility'), MAXCOUNT(iesp.Constants.PersonSlim.MaxUtilities * 2)};
  END;

  EXPORT _lt_PersonSlimReportResponseEx := RECORD
    _lt_PersonSlimReportResponse response {xpath('response')};
  END;

END;

difference := MODULE

  EXPORT boolean MonitorAddress := FALSE : STORED('Monitor_Address', FORMAT(sequence(11)));
  EXPORT boolean MonitorName := FALSE : STORED('Monitor_Name', FORMAT(sequence(12)));
  EXPORT boolean MonitorPhones := FALSE : STORED('Monitor_Phones', FORMAT(sequence(13)));
  EXPORT boolean MonitorDeath := FALSE : STORED('Monitor_Death', FORMAT(sequence(14)));
  EXPORT boolean MonitorDOB := FALSE : STORED('Monitor_DOB', FORMAT(sequence(15)));
  EXPORT boolean MonitorSSNs := FALSE : STORED('Monitor_SSNs', FORMAT(sequence(16)));
  EXPORT boolean MonitorProfessionalLicense := FALSE : STORED('Monitor_ProfessionalLicense', FORMAT(sequence(17)));
  EXPORT boolean MonitorPeopleAtWork := FALSE : STORED('Monitor_PeopleAtWork', FORMAT(sequence(18)));
  EXPORT boolean MonitorAircraft := FALSE : STORED('Monitor_Aircraft', FORMAT(sequence(19)));
  EXPORT boolean MonitorCertification := FALSE : STORED('Monitor_Certification', FORMAT(sequence(20)));
  EXPORT boolean MonitorWaterCraft := FALSE : STORED('Monitor_WaterCraft', FORMAT(sequence(21)));
  EXPORT boolean MonitorUCCFiling := FALSE : STORED('Monitor_UCCFiling', FORMAT(sequence(22)));
  EXPORT boolean MonitorSexualOffense := FALSE : STORED('Monitor_SexualOffense', FORMAT(sequence(23)));
  EXPORT boolean MonitorCriminal := FALSE : STORED('Monitor_Criminal', FORMAT(sequence(24)));
  EXPORT boolean MonitorWeaponPermit := FALSE : STORED('Monitor_WeaponPermit', FORMAT(sequence(25)));
  EXPORT boolean MonitorHuntingFishingLicense := FALSE : STORED('Monitor_HuntingFishingLicense', FORMAT(sequence(26)));
  EXPORT boolean MonitorFirearmExplosive := FALSE : STORED('Monitor_FirearmExplosive', FORMAT(sequence(27)));
  EXPORT boolean MonitorControlledSubstance := FALSE : STORED('Monitor_ControlledSubstance', FORMAT(sequence(28)));
  EXPORT boolean MonitorVoterRegistration := FALSE : STORED('Monitor_VoterRegistration', FORMAT(sequence(29)));
  EXPORT boolean MonitorDriver := FALSE : STORED('Monitor_Driver', FORMAT(sequence(30)));
  EXPORT boolean MonitorVehicle := FALSE : STORED('Monitor_Vehicle', FORMAT(sequence(31)));
  EXPORT boolean MonitorAccident := FALSE : STORED('Monitor_Accident', FORMAT(sequence(32)));
  EXPORT boolean MonitorBankruptcy := FALSE : STORED('Monitor_Bankruptcy', FORMAT(sequence(33)));
  EXPORT boolean MonitorLienJudgment := FALSE : STORED('Monitor_LienJudgment', FORMAT(sequence(34)));
  EXPORT boolean MonitorProperty := FALSE : STORED('Monitor_Property', FORMAT(sequence(35)));
  EXPORT boolean MonitorMarriageDivorce := FALSE : STORED('Monitor_MarriageDivorce', FORMAT(sequence(36)));
  EXPORT boolean MonitorEducation := FALSE : STORED('Monitor_Education', FORMAT(sequence(37)));
  EXPORT boolean MonitorAKA := FALSE : STORED('Monitor_AKA', FORMAT(sequence(38)));
  EXPORT boolean MonitorImposter := FALSE : STORED('Monitor_Imposter', FORMAT(sequence(39)));
  EXPORT boolean MonitorUtility := FALSE : STORED('Monitor_Utility', FORMAT(sequence(40)));



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
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetName
      OR updated_UnitNumber
      OR updated_City
      OR updated_State
      OR updated_Zip5;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow));

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
  
  EXPORT  integer1 CheckOuter_citystatestreetnamestreetnumberunitnumberzip5(layouts._lt_Address L, layouts._lt_Address R) := FUNCTION
    boolean IsInner :=  (L.UnitNumber = R.UnitNumber AND L.StreetNumber = R.StreetNumber AND L.Zip5 = R.Zip5 AND L.StreetName = R.StreetName AND L.City = R.City AND L.State = R.State);

    boolean IsOuterRight :=   (L.UnitNumber = '' AND L.StreetNumber = '' AND L.Zip5 = '' AND L.StreetName = '' AND L.City = '' AND L.State = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_citystatestreetnamestreetnumberunitnumberzip5 (dataset(layouts._lt_Address) _n, dataset(layouts._lt_Address) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_Address, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_Address, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5 AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberunitnumberzip5(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5 AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberunitnumberzip5(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_Address);
  END;
  
END;

EXPORT _df_PersonSlimReportAddress(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportAddress L, layouts._lt_PersonSlimReportAddress R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StreetNumber := (L.StreetNumber != R.StreetNumber);
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetName
      OR updated_UnitNumber
      OR updated_City
      OR updated_State
      OR updated_Zip5;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_PersonSlimReportAddress ProcessTx(layouts._lt_PersonSlimReportAddress L, layouts._lt_PersonSlimReportAddress R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportAddress ProcessTxRow(layouts._lt_row_PersonSlimReportAddress L, layouts._lt_row_PersonSlimReportAddress R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportAddress _new, layouts._lt_PersonSlimReportAddress _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_citystatestreetnamestreetnumberunitnumberzip5(layouts._lt_PersonSlimReportAddress L, layouts._lt_PersonSlimReportAddress R) := FUNCTION
    boolean IsInner :=  (L.UnitNumber = R.UnitNumber AND L.StreetNumber = R.StreetNumber AND L.Zip5 = R.Zip5 AND L.StreetName = R.StreetName AND L.City = R.City AND L.State = R.State);

    boolean IsOuterRight :=   (L.UnitNumber = '' AND L.StreetNumber = '' AND L.Zip5 = '' AND L.StreetName = '' AND L.City = '' AND L.State = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_citystatestreetnamestreetnumberunitnumberzip5 (dataset(layouts._lt_PersonSlimReportAddress) _n, dataset(layouts._lt_PersonSlimReportAddress) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportAddress, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportAddress, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5 AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberunitnumberzip5(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.UnitNumber = RIGHT.UnitNumber AND LEFT.StreetNumber = RIGHT.StreetNumber AND LEFT.Zip5 = RIGHT.Zip5 AND LEFT.StreetName = RIGHT.StreetName AND LEFT.City = RIGHT.City AND LEFT.State = RIGHT.State,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_citystatestreetnamestreetnumberunitnumberzip5(LEFT, RIGHT)),
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
  
  EXPORT  integer1 CheckOuter_firstlast(layouts._lt_Name L, layouts._lt_Name R) := FUNCTION
    boolean IsInner :=  (L.Last = R.Last AND L.First = R.First);

    boolean IsOuterRight :=   (L.Last = '' AND L.First = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_firstlast (dataset(layouts._lt_Name) _n, dataset(layouts._lt_Name) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_Name, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_Name, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlast(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlast(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_Name);
  END;
  
END;

EXPORT _df_PersonSlimReportName(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportName L, layouts._lt_PersonSlimReportName R, boolean is_deleted, boolean is_added) := MODULE
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

  EXPORT layouts._lt_PersonSlimReportName ProcessTx(layouts._lt_PersonSlimReportName L, layouts._lt_PersonSlimReportName R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportName ProcessTxRow(layouts._lt_row_PersonSlimReportName L, layouts._lt_row_PersonSlimReportName R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportName _new, layouts._lt_PersonSlimReportName _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_firstlast(layouts._lt_PersonSlimReportName L, layouts._lt_PersonSlimReportName R) := FUNCTION
    boolean IsInner :=  (L.Last = R.Last AND L.First = R.First);

    boolean IsOuterRight :=   (L.Last = '' AND L.First = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_firstlast (dataset(layouts._lt_PersonSlimReportName) _n, dataset(layouts._lt_PersonSlimReportName) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportName, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportName, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlast(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlast(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportName);
  END;
  
END;

EXPORT _df_PersonSlimReportPhone(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportPhone L, layouts._lt_PersonSlimReportPhone R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Phone := (L.Phone != R.Phone);

    shared is_updated := false
      OR updated_Phone;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_Phone, DATASET ([{'Phone', R.Phone}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_PersonSlimReportPhone ProcessTx(layouts._lt_PersonSlimReportPhone L, layouts._lt_PersonSlimReportPhone R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportPhone ProcessTxRow(layouts._lt_row_PersonSlimReportPhone L, layouts._lt_row_PersonSlimReportPhone R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportPhone _new, layouts._lt_PersonSlimReportPhone _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_phone(layouts._lt_PersonSlimReportPhone L, layouts._lt_PersonSlimReportPhone R) := FUNCTION
    boolean IsInner :=  (L.Phone = R.Phone);

    boolean IsOuterRight :=   (L.Phone = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_phone (dataset(layouts._lt_PersonSlimReportPhone) _n, dataset(layouts._lt_PersonSlimReportPhone) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportPhone, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportPhone, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Phone = RIGHT.Phone,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_phone(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Phone = RIGHT.Phone,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_phone(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportPhone);
  END;
  
END;

EXPORT _df_Date(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_Date L, layouts._lt_Date R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Year := (L.Year != R.Year);
    Month_active := CASE(path + '/Month', '/Accidents/Accident/AccidentDate/Month' => (false), is_active);
    shared boolean updated_Month := Month_active AND (L.Month != R.Month);
    Day_active := CASE(path + '/Day', '/Accidents/Accident/AccidentDate/Day' => (false), is_active);
    shared boolean updated_Day := Day_active AND (L.Day != R.Day);

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

EXPORT _df_PersonSlimReportDeath(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportDeath L, layouts._lt_PersonSlimReportDeath R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Year := (L.Year != R.Year);
    Month_active := CASE(path + '/Month', '/Accidents/Accident/AccidentDate/Month' => (false), is_active);
    shared boolean updated_Month := Month_active AND (L.Month != R.Month);
    Day_active := CASE(path + '/Day', '/Accidents/Accident/AccidentDate/Day' => (false), is_active);
    shared boolean updated_Day := Day_active AND (L.Day != R.Day);

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

  EXPORT layouts._lt_PersonSlimReportDeath ProcessTx(layouts._lt_PersonSlimReportDeath L, layouts._lt_PersonSlimReportDeath R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportDeath ProcessTxRow(layouts._lt_row_PersonSlimReportDeath L, layouts._lt_row_PersonSlimReportDeath R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportDeath _new, layouts._lt_PersonSlimReportDeath _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_daymonthyear(layouts._lt_PersonSlimReportDeath L, layouts._lt_PersonSlimReportDeath R) := FUNCTION
    boolean IsInner :=  (L.Year = R.Year AND L.Day = R.Day AND L.Month = R.Month);

    boolean IsOuterRight :=   (L.Year = 0 AND L.Day = 0 AND L.Month = 0);
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_daymonthyear (dataset(layouts._lt_PersonSlimReportDeath) _n, dataset(layouts._lt_PersonSlimReportDeath) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportDeath, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportDeath, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Year = RIGHT.Year AND LEFT.Day = RIGHT.Day AND LEFT.Month = RIGHT.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_daymonthyear(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Year = RIGHT.Year AND LEFT.Day = RIGHT.Day AND LEFT.Month = RIGHT.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_daymonthyear(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportDeath);
  END;
  
END;

EXPORT _df_PersonSlimReportDOB(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportDOB L, layouts._lt_PersonSlimReportDOB R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Year := (L.Year != R.Year);
    Month_active := CASE(path + '/Month', '/Accidents/Accident/AccidentDate/Month' => (false), is_active);
    shared boolean updated_Month := Month_active AND (L.Month != R.Month);
    Day_active := CASE(path + '/Day', '/Accidents/Accident/AccidentDate/Day' => (false), is_active);
    shared boolean updated_Day := Day_active AND (L.Day != R.Day);

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

  EXPORT layouts._lt_PersonSlimReportDOB ProcessTx(layouts._lt_PersonSlimReportDOB L, layouts._lt_PersonSlimReportDOB R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportDOB ProcessTxRow(layouts._lt_row_PersonSlimReportDOB L, layouts._lt_row_PersonSlimReportDOB R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportDOB _new, layouts._lt_PersonSlimReportDOB _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_daymonthyear(layouts._lt_PersonSlimReportDOB L, layouts._lt_PersonSlimReportDOB R) := FUNCTION
    boolean IsInner :=  (L.Year = R.Year AND L.Day = R.Day AND L.Month = R.Month);

    boolean IsOuterRight :=   (L.Year = 0 AND L.Day = 0 AND L.Month = 0);
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_daymonthyear (dataset(layouts._lt_PersonSlimReportDOB) _n, dataset(layouts._lt_PersonSlimReportDOB) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportDOB, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportDOB, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Year = RIGHT.Year AND LEFT.Day = RIGHT.Day AND LEFT.Month = RIGHT.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_daymonthyear(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Year = RIGHT.Year AND LEFT.Day = RIGHT.Day AND LEFT.Month = RIGHT.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_daymonthyear(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportDOB);
  END;
  
END;

EXPORT _df_PersonSlimReportSSN(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportSSN L, layouts._lt_PersonSlimReportSSN R, boolean is_deleted, boolean is_added) := MODULE
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

  EXPORT layouts._lt_PersonSlimReportSSN ProcessTx(layouts._lt_PersonSlimReportSSN L, layouts._lt_PersonSlimReportSSN R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportSSN ProcessTxRow(layouts._lt_row_PersonSlimReportSSN L, layouts._lt_row_PersonSlimReportSSN R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportSSN _new, layouts._lt_PersonSlimReportSSN _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_ssn(layouts._lt_PersonSlimReportSSN L, layouts._lt_PersonSlimReportSSN R) := FUNCTION
    boolean IsInner :=  (L.SSN = R.SSN);

    boolean IsOuterRight :=   (L.SSN = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_ssn (dataset(layouts._lt_PersonSlimReportSSN) _n, dataset(layouts._lt_PersonSlimReportSSN) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportSSN, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportSSN, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.SSN = RIGHT.SSN,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_ssn(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.SSN = RIGHT.SSN,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_ssn(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportSSN);
  END;
  
END;

EXPORT _df_BusinessIdentity(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BusinessIdentity L, layouts._lt_BusinessIdentity R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_SeleID := (L.SeleID != R.SeleID);
    shared boolean updated_OrgID := (L.OrgID != R.OrgID);
    shared boolean updated_UltID := (L.UltID != R.UltID);

    shared is_updated := false
      OR updated_SeleID
      OR updated_OrgID
      OR updated_UltID;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_SeleID, DATASET ([{'SeleID', R.SeleID}], layouts.DiffMetaRow))
         +  IF (updated_OrgID, DATASET ([{'OrgID', R.OrgID}], layouts.DiffMetaRow))
         +  IF (updated_UltID, DATASET ([{'UltID', R.UltID}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BusinessIdentity ProcessTx(layouts._lt_BusinessIdentity L, layouts._lt_BusinessIdentity R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_BusinessIdentity _new, layouts._lt_BusinessIdentity _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_ProfessionalLicenseRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_ProfessionalLicenseRecord L, layouts._lt_ProfessionalLicenseRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_LicenseNumber := (L.LicenseNumber != R.LicenseNumber);
    shared boolean updated_SourceState := (L.SourceState != R.SourceState);
    shared boolean updated_ProlicSeqId := (L.ProlicSeqId != R.ProlicSeqId);

    shared is_updated := false
      OR updated_LicenseNumber
      OR updated_SourceState
      OR updated_ProlicSeqId;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_LicenseNumber, DATASET ([{'LicenseNumber', R.LicenseNumber}], layouts.DiffMetaRow))
         +  IF (updated_SourceState, DATASET ([{'SourceState', R.SourceState}], layouts.DiffMetaRow))
         +  IF (updated_ProlicSeqId, DATASET ([{'ProlicSeqId', R.ProlicSeqId}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_ProfessionalLicenseRecord ProcessTx(layouts._lt_ProfessionalLicenseRecord L, layouts._lt_ProfessionalLicenseRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.StatusEffectiveDate  := L.StatusEffectiveDate;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;
      SELF.OriginalName  := L.OriginalName;
      SELF.AdditionalOrigName  := L.AdditionalOrigName;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.OriginalAddress  := L.OriginalAddress;
      SELF.AdditionalOrigAddress  := L.AdditionalOrigAddress;
      SELF.DOB  := L.DOB;
      SELF.IssuedDate  := L.IssuedDate;
      SELF.ExpirationDate  := L.ExpirationDate;
      SELF.LastRenewalDate  := L.LastRenewalDate;
      SELF.Action  := L.Action;
      SELF.Education1  := L.Education1;
      SELF.Education2  := L.Education2;
      SELF.Education3  := L.Education3;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_ProfessionalLicenseRecord ProcessTxRow(layouts._lt_row_ProfessionalLicenseRecord L, layouts._lt_row_ProfessionalLicenseRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.StatusEffectiveDate  := L.StatusEffectiveDate;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;
      SELF.OriginalName  := L.OriginalName;
      SELF.AdditionalOrigName  := L.AdditionalOrigName;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.OriginalAddress  := L.OriginalAddress;
      SELF.AdditionalOrigAddress  := L.AdditionalOrigAddress;
      SELF.DOB  := L.DOB;
      SELF.IssuedDate  := L.IssuedDate;
      SELF.ExpirationDate  := L.ExpirationDate;
      SELF.LastRenewalDate  := L.LastRenewalDate;
      SELF.Action  := L.Action;
      SELF.Education1  := L.Education1;
      SELF.Education2  := L.Education2;
      SELF.Education3  := L.Education3;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_ProfessionalLicenseRecord _new, layouts._lt_ProfessionalLicenseRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_licensenumbersourcestate(layouts._lt_ProfessionalLicenseRecord L, layouts._lt_ProfessionalLicenseRecord R) := FUNCTION
    boolean IsInner :=  (L.LicenseNumber = R.LicenseNumber AND L.SourceState = R.SourceState);

    boolean IsOuterRight :=   (L.LicenseNumber = '' AND L.SourceState = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_licensenumbersourcestate (dataset(layouts._lt_ProfessionalLicenseRecord) _n, dataset(layouts._lt_ProfessionalLicenseRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_ProfessionalLicenseRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_ProfessionalLicenseRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.LicenseNumber = RIGHT.LicenseNumber AND LEFT.SourceState = RIGHT.SourceState,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licensenumbersourcestate(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.LicenseNumber = RIGHT.LicenseNumber AND LEFT.SourceState = RIGHT.SourceState,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licensenumbersourcestate(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_ProfessionalLicenseRecord);
  END;
  
END;

EXPORT _df_PeopleAtWorkRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PeopleAtWorkRecord L, layouts._lt_PeopleAtWorkRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_Title := (L.Title != R.Title);
    shared boolean updated_SSN := (L.SSN != R.SSN);
    shared boolean updated_Phone10 := (L.Phone10 != R.Phone10);

    shared is_updated := false
      OR updated_Title
      OR updated_SSN
      OR updated_Phone10;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_Title, DATASET ([{'Title', R.Title}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow))
         +  IF (updated_Phone10, DATASET ([{'Phone10', R.Phone10}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_PeopleAtWorkRecord ProcessTx(layouts._lt_PeopleAtWorkRecord L, layouts._lt_PeopleAtWorkRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_BusinessIds := path + '/BusinessIds';
    
      updated_BusinessIds := _df_BusinessIdentity(is_active, path_BusinessIds).AsRecord(L.BusinessIds, R.BusinessIds);
        
      checked_BusinessIds := MAP (is_deleted => R.BusinessIds,
                              is_added => L.BusinessIds,
                              updated_BusinessIds);
      SELF.BusinessIds := checked_BusinessIds;

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
      SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PeopleAtWorkRecord ProcessTxRow(layouts._lt_row_PeopleAtWorkRecord L, layouts._lt_row_PeopleAtWorkRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_BusinessIds := path + '/BusinessIds';
    
      updated_BusinessIds := _df_BusinessIdentity(is_active, path_BusinessIds).AsRecord(L.BusinessIds, R.BusinessIds);
        
      checked_BusinessIds := MAP (is_deleted => R.BusinessIds,
                              is_added => L.BusinessIds,
                              updated_BusinessIds);
      SELF.BusinessIds := checked_BusinessIds;

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
      SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PeopleAtWorkRecord _new, layouts._lt_PeopleAtWorkRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_businessids_orgidbusinessids_seleidbusinessids_ultidcompanynametitle(layouts._lt_PeopleAtWorkRecord L, layouts._lt_PeopleAtWorkRecord R) := FUNCTION
    boolean IsInner :=  (L.BusinessIds.OrgID = R.BusinessIds.OrgID AND L.BusinessIds.SeleID = R.BusinessIds.SeleID AND L.BusinessIds.UltID = R.BusinessIds.UltID AND L.CompanyName = R.CompanyName AND L.Title = R.Title);

    boolean IsOuterRight :=   (L.BusinessIds.OrgID = 0 AND L.BusinessIds.SeleID = 0 AND L.BusinessIds.UltID = 0 AND L.CompanyName = '' AND L.Title = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_businessids_orgidbusinessids_seleidbusinessids_ultidcompanynametitle (dataset(layouts._lt_PeopleAtWorkRecord) _n, dataset(layouts._lt_PeopleAtWorkRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PeopleAtWorkRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PeopleAtWorkRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.BusinessIds.OrgID = RIGHT.BusinessIds.OrgID AND LEFT.BusinessIds.SeleID = RIGHT.BusinessIds.SeleID AND LEFT.BusinessIds.UltID = RIGHT.BusinessIds.UltID AND LEFT.CompanyName = RIGHT.CompanyName AND LEFT.Title = RIGHT.Title,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_businessids_orgidbusinessids_seleidbusinessids_ultidcompanynametitle(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.BusinessIds.OrgID = RIGHT.BusinessIds.OrgID AND LEFT.BusinessIds.SeleID = RIGHT.BusinessIds.SeleID AND LEFT.BusinessIds.UltID = RIGHT.BusinessIds.UltID AND LEFT.CompanyName = RIGHT.CompanyName AND LEFT.Title = RIGHT.Title,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_businessids_orgidbusinessids_seleidbusinessids_ultidcompanynametitle(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PeopleAtWorkRecord);
  END;
  
END;

EXPORT _df_AircraftReportRegistrant(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AircraftReportRegistrant L, layouts._lt_AircraftReportRegistrant R, boolean is_deleted, boolean is_added) := MODULE

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

  EXPORT layouts._lt_AircraftReportRegistrant ProcessTx(layouts._lt_AircraftReportRegistrant L, layouts._lt_AircraftReportRegistrant R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;
      SELF.Address  := L.Address;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_AircraftReportRegistrant _new, layouts._lt_AircraftReportRegistrant _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_AircraftReportRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AircraftReportRecord L, layouts._lt_AircraftReportRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_AircraftNumber := (L.AircraftNumber != R.AircraftNumber);

    shared is_updated := false
      OR updated_AircraftNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_AircraftNumber, DATASET ([{'AircraftNumber', R.AircraftNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_AircraftReportRecord ProcessTx(layouts._lt_AircraftReportRecord L, layouts._lt_AircraftReportRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.LastActionDate  := L.LastActionDate;
      SELF.CertificationDate  := L.CertificationDate;
      SELF.BusinessIds  := L.BusinessIds;

      path_Registrant := path + '/Registrant';
    
      updated_Registrant := _df_AircraftReportRegistrant(is_active, path_Registrant).AsRecord(L.Registrant, R.Registrant);
        
      checked_Registrant := MAP (is_deleted => R.Registrant,
                              is_added => L.Registrant,
                              updated_Registrant);
      SELF.Registrant := checked_Registrant;
      SELF.AircraftInfo  := L.AircraftInfo;
      SELF.EngineInfo  := L.EngineInfo;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_AircraftReportRecord ProcessTxRow(layouts._lt_row_AircraftReportRecord L, layouts._lt_row_AircraftReportRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.LastActionDate  := L.LastActionDate;
      SELF.CertificationDate  := L.CertificationDate;
      SELF.BusinessIds  := L.BusinessIds;

      path_Registrant := path + '/Registrant';
    
      updated_Registrant := _df_AircraftReportRegistrant(is_active, path_Registrant).AsRecord(L.Registrant, R.Registrant);
        
      checked_Registrant := MAP (is_deleted => R.Registrant,
                              is_added => L.Registrant,
                              updated_Registrant);
      SELF.Registrant := checked_Registrant;
      SELF.AircraftInfo  := L.AircraftInfo;
      SELF.EngineInfo  := L.EngineInfo;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_AircraftReportRecord _new, layouts._lt_AircraftReportRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_aircraftnumber(layouts._lt_AircraftReportRecord L, layouts._lt_AircraftReportRecord R) := FUNCTION
    boolean IsInner :=  (L.AircraftNumber = R.AircraftNumber);

    boolean IsOuterRight :=   (L.AircraftNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_aircraftnumber (dataset(layouts._lt_AircraftReportRecord) _n, dataset(layouts._lt_AircraftReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_AircraftReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_AircraftReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.AircraftNumber = RIGHT.AircraftNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_aircraftnumber(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.AircraftNumber = RIGHT.AircraftNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_aircraftnumber(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_AircraftReportRecord);
  END;
  
END;

EXPORT _df_BpsFAACertification(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BpsFAACertification L, layouts._lt_BpsFAACertification R, boolean is_deleted, boolean is_added) := MODULE

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

EXPORT _df_WaterCraftOwner(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_WaterCraftOwner L, layouts._lt_WaterCraftOwner R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);

    shared is_updated := false
      OR updated_UniqueId;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_WaterCraftOwner ProcessTx(layouts._lt_WaterCraftOwner L, layouts._lt_WaterCraftOwner R, boolean is_deleted, boolean is_added) :=TRANSFORM
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
      SELF.DOB  := L.DOB;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_WaterCraftOwner ProcessTxRow(layouts._lt_row_WaterCraftOwner L, layouts._lt_row_WaterCraftOwner R, integer1 joinRowType) :=TRANSFORM
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
      SELF.DOB  := L.DOB;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_WaterCraftOwner _new, layouts._lt_WaterCraftOwner _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_uniqueid(layouts._lt_WaterCraftOwner L, layouts._lt_WaterCraftOwner R) := FUNCTION
    boolean IsInner :=  (L.UniqueId = R.UniqueId);

    boolean IsOuterRight :=   (L.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_uniqueid (dataset(layouts._lt_WaterCraftOwner) _n, dataset(layouts._lt_WaterCraftOwner) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_WaterCraftOwner, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_WaterCraftOwner, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
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
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_WaterCraftOwner);
  END;
  
END;

EXPORT _df_WaterCraftReportRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_WaterCraftReportRecord L, layouts._lt_WaterCraftReportRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StateOfOrigin := (L.StateOfOrigin != R.StateOfOrigin);
    shared boolean updated_HullNumber := (L.HullNumber != R.HullNumber);

    shared is_updated := false
      OR updated_StateOfOrigin
      OR updated_HullNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StateOfOrigin, DATASET ([{'StateOfOrigin', R.StateOfOrigin}], layouts.DiffMetaRow))
         +  IF (updated_HullNumber, DATASET ([{'HullNumber', R.HullNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_WaterCraftReportRecord ProcessTx(layouts._lt_WaterCraftReportRecord L, layouts._lt_WaterCraftReportRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.Description  := L.Description;
      SELF.Registration  := L.Registration;
      SELF.Title  := L.Title;
      SELF.Purchase  := L.Purchase;
      SELF.Manufacture  := L.Manufacture;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.LienHolders  := L.LienHolders;
      SELF.Engines  := L.Engines;

      updated_Owners := _df_WaterCraftOwner(is_active, path + '/Owners/Owner').AsDataset_uniqueid(L.Owners, R.Owners);
      checked_Owners := MAP (is_deleted => R.Owners,
                              is_added => L.Owners,
                              updated_Owners);
      SELF.Owners  := checked_Owners;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_WaterCraftReportRecord ProcessTxRow(layouts._lt_row_WaterCraftReportRecord L, layouts._lt_row_WaterCraftReportRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.Description  := L.Description;
      SELF.Registration  := L.Registration;
      SELF.Title  := L.Title;
      SELF.Purchase  := L.Purchase;
      SELF.Manufacture  := L.Manufacture;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.LienHolders  := L.LienHolders;
      SELF.Engines  := L.Engines;

      updated_Owners := _df_WaterCraftOwner(is_active, path + '/Owners/Owner').AsDataset_uniqueid(L.Owners, R.Owners);
      checked_Owners := MAP (is_deleted => R.Owners,
                              is_added => L.Owners,
                              updated_Owners);
      SELF.Owners  := checked_Owners;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_WaterCraftReportRecord _new, layouts._lt_WaterCraftReportRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_hullnumberstateoforigin(layouts._lt_WaterCraftReportRecord L, layouts._lt_WaterCraftReportRecord R) := FUNCTION
    boolean IsInner :=  (L.HullNumber = R.HullNumber AND L.StateOfOrigin = R.StateOfOrigin);

    boolean IsOuterRight :=   (L.HullNumber = '' AND L.StateOfOrigin = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_hullnumberstateoforigin (dataset(layouts._lt_WaterCraftReportRecord) _n, dataset(layouts._lt_WaterCraftReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_WaterCraftReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_WaterCraftReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.HullNumber = RIGHT.HullNumber AND LEFT.StateOfOrigin = RIGHT.StateOfOrigin,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_hullnumberstateoforigin(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.HullNumber = RIGHT.HullNumber AND LEFT.StateOfOrigin = RIGHT.StateOfOrigin,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_hullnumberstateoforigin(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_WaterCraftReportRecord);
  END;
  
END;

EXPORT _df_UCCParsedParty(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_UCCParsedParty L, layouts._lt_UCCParsedParty R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);

    shared is_updated := false
      OR updated_UniqueId;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_UCCParsedParty ProcessTx(layouts._lt_UCCParsedParty L, layouts._lt_UCCParsedParty R, boolean is_deleted, boolean is_added) :=TRANSFORM
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


  EXPORT layouts._lt_row_UCCParsedParty ProcessTxRow(layouts._lt_row_UCCParsedParty L, layouts._lt_row_UCCParsedParty R, integer1 joinRowType) :=TRANSFORM
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


  EXPORT AsRecord (layouts._lt_UCCParsedParty _new, layouts._lt_UCCParsedParty _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_uniqueid(layouts._lt_UCCParsedParty L, layouts._lt_UCCParsedParty R) := FUNCTION
    boolean IsInner :=  (L.UniqueId = R.UniqueId);

    boolean IsOuterRight :=   (L.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_uniqueid (dataset(layouts._lt_UCCParsedParty) _n, dataset(layouts._lt_UCCParsedParty) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_UCCParsedParty, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_UCCParsedParty, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
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
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_UCCParsedParty);
  END;
  
END;

EXPORT _df_UniversalAddress(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_UniversalAddress L, layouts._lt_UniversalAddress R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StreetNumber := (L.StreetNumber != R.StreetNumber);
    shared boolean updated_StreetName := (L.StreetName != R.StreetName);
    shared boolean updated_UnitNumber := (L.UnitNumber != R.UnitNumber);
    shared boolean updated_City := (L.City != R.City);
    shared boolean updated_State := (L.State != R.State);
    shared boolean updated_Zip5 := (L.Zip5 != R.Zip5);

    shared is_updated := false
      OR updated_StreetNumber
      OR updated_StreetName
      OR updated_UnitNumber
      OR updated_City
      OR updated_State
      OR updated_Zip5;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StreetNumber, DATASET ([{'StreetNumber', R.StreetNumber}], layouts.DiffMetaRow))
         +  IF (updated_StreetName, DATASET ([{'StreetName', R.StreetName}], layouts.DiffMetaRow))
         +  IF (updated_UnitNumber, DATASET ([{'UnitNumber', R.UnitNumber}], layouts.DiffMetaRow))
         +  IF (updated_City, DATASET ([{'City', R.City}], layouts.DiffMetaRow))
         +  IF (updated_State, DATASET ([{'State', R.State}], layouts.DiffMetaRow))
         +  IF (updated_Zip5, DATASET ([{'Zip5', R.Zip5}], layouts.DiffMetaRow));

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

EXPORT _df_UCCReport2Person(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_UCCReport2Person L, layouts._lt_UCCReport2Person R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_OriginName := (L.OriginName != R.OriginName);

    shared is_updated := false
      OR updated_OriginName;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_OriginName, DATASET ([{'OriginName', R.OriginName}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_UCCReport2Person ProcessTx(layouts._lt_UCCReport2Person L, layouts._lt_UCCReport2Person R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      updated_ParsedParties := _df_UCCParsedParty(is_active, path + '/ParsedParties/Party').AsDataset_uniqueid(L.ParsedParties, R.ParsedParties);
      checked_ParsedParties := MAP (is_deleted => R.ParsedParties,
                              is_added => L.ParsedParties,
                              updated_ParsedParties);
      SELF.ParsedParties  := checked_ParsedParties;
      SELF.Addresses  := L.Addresses;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_UCCReport2Person ProcessTxRow(layouts._lt_row_UCCReport2Person L, layouts._lt_row_UCCReport2Person R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      updated_ParsedParties := _df_UCCParsedParty(is_active, path + '/ParsedParties/Party').AsDataset_uniqueid(L.ParsedParties, R.ParsedParties);
      checked_ParsedParties := MAP (is_deleted => R.ParsedParties,
                              is_added => L.ParsedParties,
                              updated_ParsedParties);
      SELF.ParsedParties  := checked_ParsedParties;
      SELF.Addresses  := L.Addresses;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_UCCReport2Person _new, layouts._lt_UCCReport2Person _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_originname(layouts._lt_UCCReport2Person L, layouts._lt_UCCReport2Person R) := FUNCTION
    boolean IsInner :=  (L.OriginName = R.OriginName);

    boolean IsOuterRight :=   (L.OriginName = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_originname (dataset(layouts._lt_UCCReport2Person) _n, dataset(layouts._lt_UCCReport2Person) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_UCCReport2Person, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_UCCReport2Person, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.OriginName = RIGHT.OriginName,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_originname(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.OriginName = RIGHT.OriginName,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_originname(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_UCCReport2Person);
  END;
  
END;

EXPORT _df_UCCReport2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_UCCReport2Record L, layouts._lt_UCCReport2Record R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_FilingJurisdiction := (L.FilingJurisdiction != R.FilingJurisdiction);
    shared boolean updated_OriginFilingNumber := (L.OriginFilingNumber != R.OriginFilingNumber);

    shared is_updated := false
      OR updated_FilingJurisdiction
      OR updated_OriginFilingNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_FilingJurisdiction, DATASET ([{'FilingJurisdiction', R.FilingJurisdiction}], layouts.DiffMetaRow))
         +  IF (updated_OriginFilingNumber, DATASET ([{'OriginFilingNumber', R.OriginFilingNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_UCCReport2Record ProcessTx(layouts._lt_UCCReport2Record L, layouts._lt_UCCReport2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.OriginFilingDate  := L.OriginFilingDate;
      SELF.CommentEffectiveDate  := L.CommentEffectiveDate;

      updated_Debtors := _df_UCCReport2Person(is_active, path + '/Debtors/Debtor').AsDataset_originname(L.Debtors, R.Debtors);
      checked_Debtors := MAP (is_deleted => R.Debtors,
                              is_added => L.Debtors,
                              updated_Debtors);
      SELF.Debtors  := checked_Debtors;

      updated_Debtors2 := _df_UCCReport2Person(is_active, path + '/Debtors2/Debtor').AsDataset_originname(L.Debtors2, R.Debtors2);
      checked_Debtors2 := MAP (is_deleted => R.Debtors2,
                              is_added => L.Debtors2,
                              updated_Debtors2);
      SELF.Debtors2  := checked_Debtors2;

      updated_Creditors := _df_UCCReport2Person(is_active, path + '/Creditors/Creditor').AsDataset_originname(L.Creditors, R.Creditors);
      checked_Creditors := MAP (is_deleted => R.Creditors,
                              is_added => L.Creditors,
                              updated_Creditors);
      SELF.Creditors  := checked_Creditors;

      updated_Secureds := _df_UCCReport2Person(is_active, path + '/Secureds/Secured').AsDataset_originname(L.Secureds, R.Secureds);
      checked_Secureds := MAP (is_deleted => R.Secureds,
                              is_added => L.Secureds,
                              updated_Secureds);
      SELF.Secureds  := checked_Secureds;

      updated_Assignees := _df_UCCReport2Person(is_active, path + '/Assignees/Assignee').AsDataset_originname(L.Assignees, R.Assignees);
      checked_Assignees := MAP (is_deleted => R.Assignees,
                              is_added => L.Assignees,
                              updated_Assignees);
      SELF.Assignees  := checked_Assignees;
      SELF.Collaterals  := L.Collaterals;

      updated_Creditors2 := _df_UCCReport2Person(is_active, path + '/Creditors2/Creditor').AsDataset_originname(L.Creditors2, R.Creditors2);
      checked_Creditors2 := MAP (is_deleted => R.Creditors2,
                              is_added => L.Creditors2,
                              updated_Creditors2);
      SELF.Creditors2  := checked_Creditors2;

      updated_Secureds2 := _df_UCCReport2Person(is_active, path + '/Secureds2/Secured').AsDataset_originname(L.Secureds2, R.Secureds2);
      checked_Secureds2 := MAP (is_deleted => R.Secureds2,
                              is_added => L.Secureds2,
                              updated_Secureds2);
      SELF.Secureds2  := checked_Secureds2;

      updated_Assignees2 := _df_UCCReport2Person(is_active, path + '/Assignees2/Assignee').AsDataset_originname(L.Assignees2, R.Assignees2);
      checked_Assignees2 := MAP (is_deleted => R.Assignees2,
                              is_added => L.Assignees2,
                              updated_Assignees2);
      SELF.Assignees2  := checked_Assignees2;
      SELF.Collaterals2  := L.Collaterals2;
      SELF.Signers  := L.Signers;
      SELF.Filings2  := L.Filings2;
      SELF.FilingOffices  := L.FilingOffices;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_UCCReport2Record ProcessTxRow(layouts._lt_row_UCCReport2Record L, layouts._lt_row_UCCReport2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.OriginFilingDate  := L.OriginFilingDate;
      SELF.CommentEffectiveDate  := L.CommentEffectiveDate;

      updated_Debtors := _df_UCCReport2Person(is_active, path + '/Debtors/Debtor').AsDataset_originname(L.Debtors, R.Debtors);
      checked_Debtors := MAP (is_deleted => R.Debtors,
                              is_added => L.Debtors,
                              updated_Debtors);
      SELF.Debtors  := checked_Debtors;

      updated_Debtors2 := _df_UCCReport2Person(is_active, path + '/Debtors2/Debtor').AsDataset_originname(L.Debtors2, R.Debtors2);
      checked_Debtors2 := MAP (is_deleted => R.Debtors2,
                              is_added => L.Debtors2,
                              updated_Debtors2);
      SELF.Debtors2  := checked_Debtors2;

      updated_Creditors := _df_UCCReport2Person(is_active, path + '/Creditors/Creditor').AsDataset_originname(L.Creditors, R.Creditors);
      checked_Creditors := MAP (is_deleted => R.Creditors,
                              is_added => L.Creditors,
                              updated_Creditors);
      SELF.Creditors  := checked_Creditors;

      updated_Secureds := _df_UCCReport2Person(is_active, path + '/Secureds/Secured').AsDataset_originname(L.Secureds, R.Secureds);
      checked_Secureds := MAP (is_deleted => R.Secureds,
                              is_added => L.Secureds,
                              updated_Secureds);
      SELF.Secureds  := checked_Secureds;

      updated_Assignees := _df_UCCReport2Person(is_active, path + '/Assignees/Assignee').AsDataset_originname(L.Assignees, R.Assignees);
      checked_Assignees := MAP (is_deleted => R.Assignees,
                              is_added => L.Assignees,
                              updated_Assignees);
      SELF.Assignees  := checked_Assignees;
      SELF.Collaterals  := L.Collaterals;

      updated_Creditors2 := _df_UCCReport2Person(is_active, path + '/Creditors2/Creditor').AsDataset_originname(L.Creditors2, R.Creditors2);
      checked_Creditors2 := MAP (is_deleted => R.Creditors2,
                              is_added => L.Creditors2,
                              updated_Creditors2);
      SELF.Creditors2  := checked_Creditors2;

      updated_Secureds2 := _df_UCCReport2Person(is_active, path + '/Secureds2/Secured').AsDataset_originname(L.Secureds2, R.Secureds2);
      checked_Secureds2 := MAP (is_deleted => R.Secureds2,
                              is_added => L.Secureds2,
                              updated_Secureds2);
      SELF.Secureds2  := checked_Secureds2;

      updated_Assignees2 := _df_UCCReport2Person(is_active, path + '/Assignees2/Assignee').AsDataset_originname(L.Assignees2, R.Assignees2);
      checked_Assignees2 := MAP (is_deleted => R.Assignees2,
                              is_added => L.Assignees2,
                              updated_Assignees2);
      SELF.Assignees2  := checked_Assignees2;
      SELF.Collaterals2  := L.Collaterals2;
      SELF.Signers  := L.Signers;
      SELF.Filings2  := L.Filings2;
      SELF.FilingOffices  := L.FilingOffices;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_UCCReport2Record _new, layouts._lt_UCCReport2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_filingjurisdictionoriginfilingnumber(layouts._lt_UCCReport2Record L, layouts._lt_UCCReport2Record R) := FUNCTION
    boolean IsInner :=  (L.FilingJurisdiction = R.FilingJurisdiction AND L.OriginFilingNumber = R.OriginFilingNumber);

    boolean IsOuterRight :=   (L.FilingJurisdiction = '' AND L.OriginFilingNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_filingjurisdictionoriginfilingnumber (dataset(layouts._lt_UCCReport2Record) _n, dataset(layouts._lt_UCCReport2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_UCCReport2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_UCCReport2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.FilingJurisdiction = RIGHT.FilingJurisdiction AND LEFT.OriginFilingNumber = RIGHT.OriginFilingNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_filingjurisdictionoriginfilingnumber(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.FilingJurisdiction = RIGHT.FilingJurisdiction AND LEFT.OriginFilingNumber = RIGHT.OriginFilingNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_filingjurisdictionoriginfilingnumber(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_UCCReport2Record);
  END;
  
END;

EXPORT _df_SexOffReportRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_SexOffReportRecord L, layouts._lt_SexOffReportRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_PrimaryKey := (L.PrimaryKey != R.PrimaryKey);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_PrimaryKey
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_PrimaryKey, DATASET ([{'PrimaryKey', R.PrimaryKey}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_SexOffReportRecord ProcessTx(layouts._lt_SexOffReportRecord L, layouts._lt_SexOffReportRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
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

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;
      SELF.DOB2  := L.DOB2;
      SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.DateOffenderLastUpdated  := L.DateOffenderLastUpdated;
      SELF.PoliceAgency  := L.PoliceAgency;
      SELF.School  := L.School;
      SELF.Employer  := L.Employer;
      SELF.Registration  := L.Registration;
      SELF.Vehicle1  := L.Vehicle1;
      SELF.Vehicle2  := L.Vehicle2;
      SELF.PhysicalCharacteristics  := L.PhysicalCharacteristics;
      SELF.IdNumbers  := L.IdNumbers;
      SELF.BestAddress  := L.BestAddress;
      SELF.AKAs  := L.AKAs;
      SELF.Convictions  := L.Convictions;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_SexOffReportRecord ProcessTxRow(layouts._lt_row_SexOffReportRecord L, layouts._lt_row_SexOffReportRecord R, integer1 joinRowType) :=TRANSFORM
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

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;
      SELF.DOB2  := L.DOB2;
      SELF.DateFirstSeen  := L.DateFirstSeen;
      SELF.DateLastSeen  := L.DateLastSeen;
      SELF.DateOffenderLastUpdated  := L.DateOffenderLastUpdated;
      SELF.PoliceAgency  := L.PoliceAgency;
      SELF.School  := L.School;
      SELF.Employer  := L.Employer;
      SELF.Registration  := L.Registration;
      SELF.Vehicle1  := L.Vehicle1;
      SELF.Vehicle2  := L.Vehicle2;
      SELF.PhysicalCharacteristics  := L.PhysicalCharacteristics;
      SELF.IdNumbers  := L.IdNumbers;
      SELF.BestAddress  := L.BestAddress;
      SELF.AKAs  := L.AKAs;
      SELF.Convictions  := L.Convictions;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_SexOffReportRecord _new, layouts._lt_SexOffReportRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_primarykey(layouts._lt_SexOffReportRecord L, layouts._lt_SexOffReportRecord R) := FUNCTION
    boolean IsInner :=  (L.PrimaryKey = R.PrimaryKey);

    boolean IsOuterRight :=   (L.PrimaryKey = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_primarykey (dataset(layouts._lt_SexOffReportRecord) _n, dataset(layouts._lt_SexOffReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_SexOffReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_SexOffReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.PrimaryKey = RIGHT.PrimaryKey,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_primarykey(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.PrimaryKey = RIGHT.PrimaryKey,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_primarykey(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_SexOffReportRecord);
  END;
  
END;

EXPORT _df_CrimReportRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_CrimReportRecord L, layouts._lt_CrimReportRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_OffenderId := (L.OffenderId != R.OffenderId);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_OffenderId
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_OffenderId, DATASET ([{'OffenderId', R.OffenderId}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_CrimReportRecord ProcessTx(layouts._lt_CrimReportRecord L, layouts._lt_CrimReportRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.CaseFilingDate  := L.CaseFilingDate;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;

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
      SELF.AKAs  := L.AKAs;
      SELF.Offenses  := L.Offenses;
      SELF.PrisonSentences  := L.PrisonSentences;
      SELF.ParoleSentences  := L.ParoleSentences;
      SELF.Activities  := L.Activities;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_CrimReportRecord ProcessTxRow(layouts._lt_row_CrimReportRecord L, layouts._lt_row_CrimReportRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.CaseFilingDate  := L.CaseFilingDate;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;

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
      SELF.AKAs  := L.AKAs;
      SELF.Offenses  := L.Offenses;
      SELF.PrisonSentences  := L.PrisonSentences;
      SELF.ParoleSentences  := L.ParoleSentences;
      SELF.Activities  := L.Activities;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_CrimReportRecord _new, layouts._lt_CrimReportRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_offenderid(layouts._lt_CrimReportRecord L, layouts._lt_CrimReportRecord R) := FUNCTION
    boolean IsInner :=  (L.OffenderId = R.OffenderId);

    boolean IsOuterRight :=   (L.OffenderId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_offenderid (dataset(layouts._lt_CrimReportRecord) _n, dataset(layouts._lt_CrimReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_CrimReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_CrimReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.OffenderId = RIGHT.OffenderId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_offenderid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.OffenderId = RIGHT.OffenderId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_offenderid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_CrimReportRecord);
  END;
  
END;

EXPORT _df_CCWPermit(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_CCWPermit L, layouts._lt_CCWPermit R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_PermitNumber := (L.PermitNumber != R.PermitNumber);
    shared boolean updated_PermitType := (L.PermitType != R.PermitType);

    shared is_updated := false
      OR updated_PermitNumber
      OR updated_PermitType;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_PermitNumber, DATASET ([{'PermitNumber', R.PermitNumber}], layouts.DiffMetaRow))
         +  IF (updated_PermitType, DATASET ([{'PermitType', R.PermitType}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_CCWPermit ProcessTx(layouts._lt_CCWPermit L, layouts._lt_CCWPermit R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.RegistrationDate  := L.RegistrationDate;
      SELF.ExpirationDate  := L.ExpirationDate;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_CCWPermit _new, layouts._lt_CCWPermit _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_WeaponRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_WeaponRecord L, layouts._lt_WeaponRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_StateCode := (L.StateCode != R.StateCode);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_StateCode
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_StateCode, DATASET ([{'StateCode', R.StateCode}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_WeaponRecord ProcessTx(layouts._lt_WeaponRecord L, layouts._lt_WeaponRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Permit := path + '/Permit';
    
      updated_Permit := _df_CCWPermit(is_active, path_Permit).AsRecord(L.Permit, R.Permit);
        
      checked_Permit := MAP (is_deleted => R.Permit,
                              is_added => L.Permit,
                              updated_Permit);
      SELF.Permit := checked_Permit;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;

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


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_WeaponRecord ProcessTxRow(layouts._lt_row_WeaponRecord L, layouts._lt_row_WeaponRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_Permit := path + '/Permit';
    
      updated_Permit := _df_CCWPermit(is_active, path_Permit).AsRecord(L.Permit, R.Permit);
        
      checked_Permit := MAP (is_deleted => R.Permit,
                              is_added => L.Permit,
                              updated_Permit);
      SELF.Permit := checked_Permit;

      path_DOB := path + '/DOB';
    
      updated_DOB := _df_Date(is_active, path_DOB).AsRecord(L.DOB, R.DOB);
        
      checked_DOB := MAP (is_deleted => R.DOB,
                              is_added => L.DOB,
                              updated_DOB);
      SELF.DOB := checked_DOB;

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

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_WeaponRecord _new, layouts._lt_WeaponRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_permit_permitnumberpermit_permittypestatecode(layouts._lt_WeaponRecord L, layouts._lt_WeaponRecord R) := FUNCTION
    boolean IsInner :=  (L.StateCode = R.StateCode AND L.Permit.PermitType = R.Permit.PermitType AND L.Permit.PermitNumber = R.Permit.PermitNumber);

    boolean IsOuterRight :=   (L.StateCode = '' AND L.Permit.PermitType = '' AND L.Permit.PermitNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_permit_permitnumberpermit_permittypestatecode (dataset(layouts._lt_WeaponRecord) _n, dataset(layouts._lt_WeaponRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_WeaponRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_WeaponRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.StateCode = RIGHT.StateCode AND LEFT.Permit.PermitType = RIGHT.Permit.PermitType AND LEFT.Permit.PermitNumber = RIGHT.Permit.PermitNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_permit_permitnumberpermit_permittypestatecode(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.StateCode = RIGHT.StateCode AND LEFT.Permit.PermitType = RIGHT.Permit.PermitType AND LEFT.Permit.PermitNumber = RIGHT.Permit.PermitNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_permit_permitnumberpermit_permittypestatecode(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_WeaponRecord);
  END;
  
END;

EXPORT _df_HuntFishRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_HuntFishRecord L, layouts._lt_HuntFishRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_LicenseNumber := (L.LicenseNumber != R.LicenseNumber);
    shared boolean updated_LicenseType := (L.LicenseType != R.LicenseType);
    shared boolean updated_LicenseState := (L.LicenseState != R.LicenseState);

    shared is_updated := false
      OR updated_LicenseNumber
      OR updated_LicenseType
      OR updated_LicenseState;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_LicenseNumber, DATASET ([{'LicenseNumber', R.LicenseNumber}], layouts.DiffMetaRow))
         +  IF (updated_LicenseType, DATASET ([{'LicenseType', R.LicenseType}], layouts.DiffMetaRow))
         +  IF (updated_LicenseState, DATASET ([{'LicenseState', R.LicenseState}], layouts.DiffMetaRow));

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

      path_MailAddress := path + '/MailAddress';
    
      updated_MailAddress := _df_Address(is_active, path_MailAddress).AsRecord(L.MailAddress, R.MailAddress);
        
      checked_MailAddress := MAP (is_deleted => R.MailAddress,
                              is_added => L.MailAddress,
                              updated_MailAddress);
      SELF.MailAddress := checked_MailAddress;
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

      path_MailAddress := path + '/MailAddress';
    
      updated_MailAddress := _df_Address(is_active, path_MailAddress).AsRecord(L.MailAddress, R.MailAddress);
        
      checked_MailAddress := MAP (is_deleted => R.MailAddress,
                              is_added => L.MailAddress,
                              updated_MailAddress);
      SELF.MailAddress := checked_MailAddress;
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
  
  EXPORT  integer1 CheckOuter_licensenumberlicensestatelicensetype(layouts._lt_HuntFishRecord L, layouts._lt_HuntFishRecord R) := FUNCTION
    boolean IsInner :=  (L.LicenseState = R.LicenseState AND L.LicenseType = R.LicenseType AND L.LicenseNumber = R.LicenseNumber);

    boolean IsOuterRight :=   (L.LicenseState = '' AND L.LicenseType = '' AND L.LicenseNumber = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_licensenumberlicensestatelicensetype (dataset(layouts._lt_HuntFishRecord) _n, dataset(layouts._lt_HuntFishRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_HuntFishRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_HuntFishRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.LicenseState = RIGHT.LicenseState AND LEFT.LicenseType = RIGHT.LicenseType AND LEFT.LicenseNumber = RIGHT.LicenseNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licensenumberlicensestatelicensetype(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.LicenseState = RIGHT.LicenseState AND LEFT.LicenseType = RIGHT.LicenseType AND LEFT.LicenseNumber = RIGHT.LicenseNumber,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_licensenumberlicensestatelicensetype(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_HuntFishRecord);
  END;
  
END;

EXPORT _df_FirearmRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_FirearmRecord L, layouts._lt_FirearmRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_LicenseIssueState := (L.LicenseIssueState != R.LicenseIssueState);
    shared boolean updated_LicenseNumber := (L.LicenseNumber != R.LicenseNumber);

    shared is_updated := false
      OR updated_LicenseIssueState
      OR updated_LicenseNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_LicenseIssueState, DATASET ([{'LicenseIssueState', R.LicenseIssueState}], layouts.DiffMetaRow))
         +  IF (updated_LicenseNumber, DATASET ([{'LicenseNumber', R.LicenseNumber}], layouts.DiffMetaRow));

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

      path_MailingAddress := path + '/MailingAddress';
    
      updated_MailingAddress := _df_Address(is_active, path_MailingAddress).AsRecord(L.MailingAddress, R.MailingAddress);
        
      checked_MailingAddress := MAP (is_deleted => R.MailingAddress,
                              is_added => L.MailingAddress,
                              updated_MailingAddress);
      SELF.MailingAddress := checked_MailingAddress;

      path_PremiseAddress := path + '/PremiseAddress';
    
      updated_PremiseAddress := _df_Address(is_active, path_PremiseAddress).AsRecord(L.PremiseAddress, R.PremiseAddress);
        
      checked_PremiseAddress := MAP (is_deleted => R.PremiseAddress,
                              is_added => L.PremiseAddress,
                              updated_PremiseAddress);
      SELF.PremiseAddress := checked_PremiseAddress;

      updated_LicenseNames := _df_Name(is_active, path + '/LicenseNames/Name').AsDataset_firstlast(L.LicenseNames, R.LicenseNames);
      checked_LicenseNames := MAP (is_deleted => R.LicenseNames,
                              is_added => L.LicenseNames,
                              updated_LicenseNames);
      SELF.LicenseNames  := checked_LicenseNames;


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

      path_MailingAddress := path + '/MailingAddress';
    
      updated_MailingAddress := _df_Address(is_active, path_MailingAddress).AsRecord(L.MailingAddress, R.MailingAddress);
        
      checked_MailingAddress := MAP (is_deleted => R.MailingAddress,
                              is_added => L.MailingAddress,
                              updated_MailingAddress);
      SELF.MailingAddress := checked_MailingAddress;

      path_PremiseAddress := path + '/PremiseAddress';
    
      updated_PremiseAddress := _df_Address(is_active, path_PremiseAddress).AsRecord(L.PremiseAddress, R.PremiseAddress);
        
      checked_PremiseAddress := MAP (is_deleted => R.PremiseAddress,
                              is_added => L.PremiseAddress,
                              updated_PremiseAddress);
      SELF.PremiseAddress := checked_PremiseAddress;

      updated_LicenseNames := _df_Name(is_active, path + '/LicenseNames/Name').AsDataset_firstlast(L.LicenseNames, R.LicenseNames);
      checked_LicenseNames := MAP (is_deleted => R.LicenseNames,
                              is_added => L.LicenseNames,
                              updated_LicenseNames);
      SELF.LicenseNames  := checked_LicenseNames;

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
  
  EXPORT  integer1 CheckOuter_ssn(layouts._lt_DEAControlledSubstanceRecord L, layouts._lt_DEAControlledSubstanceRecord R) := FUNCTION
    boolean IsInner :=  (L.SSN = R.SSN);

    boolean IsOuterRight :=   (L.SSN = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_ssn (dataset(layouts._lt_DEAControlledSubstanceRecord) _n, dataset(layouts._lt_DEAControlledSubstanceRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_DEAControlledSubstanceRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_DEAControlledSubstanceRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.SSN = RIGHT.SSN,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_ssn(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.SSN = RIGHT.SSN,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_ssn(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_DEAControlledSubstanceRecord);
  END;
  
END;

EXPORT _df_DEAControlledSubstanceSearch2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_DEAControlledSubstanceSearch2Record L, layouts._lt_DEAControlledSubstanceSearch2Record R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_RegistrationNumber := (L.RegistrationNumber != R.RegistrationNumber);

    shared is_updated := false
      OR updated_RegistrationNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_RegistrationNumber, DATASET ([{'RegistrationNumber', R.RegistrationNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_DEAControlledSubstanceSearch2Record ProcessTx(layouts._lt_DEAControlledSubstanceSearch2Record L, layouts._lt_DEAControlledSubstanceSearch2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      updated_ControlledSubstancesInfo := _df_DEAControlledSubstanceRecord(is_active, path + '/ControlledSubstancesInfo/ControlledSubstanceInfo').AsDataset_ssn(L.ControlledSubstancesInfo, R.ControlledSubstancesInfo);
      checked_ControlledSubstancesInfo := MAP (is_deleted => R.ControlledSubstancesInfo,
                              is_added => L.ControlledSubstancesInfo,
                              updated_ControlledSubstancesInfo);
      SELF.ControlledSubstancesInfo  := checked_ControlledSubstancesInfo;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_DEAControlledSubstanceSearch2Record ProcessTxRow(layouts._lt_row_DEAControlledSubstanceSearch2Record L, layouts._lt_row_DEAControlledSubstanceSearch2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;

      updated_ControlledSubstancesInfo := _df_DEAControlledSubstanceRecord(is_active, path + '/ControlledSubstancesInfo/ControlledSubstanceInfo').AsDataset_ssn(L.ControlledSubstancesInfo, R.ControlledSubstancesInfo);
      checked_ControlledSubstancesInfo := MAP (is_deleted => R.ControlledSubstancesInfo,
                              is_added => L.ControlledSubstancesInfo,
                              updated_ControlledSubstancesInfo);
      SELF.ControlledSubstancesInfo  := checked_ControlledSubstancesInfo;

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

      path_MailingAddress := path + '/MailingAddress';
    
      updated_MailingAddress := _df_Address(is_active, path_MailingAddress).AsRecord(L.MailingAddress, R.MailingAddress);
        
      checked_MailingAddress := MAP (is_deleted => R.MailingAddress,
                              is_added => L.MailingAddress,
                              updated_MailingAddress);
      SELF.MailingAddress := checked_MailingAddress;
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

      path_MailingAddress := path + '/MailingAddress';
    
      updated_MailingAddress := _df_Address(is_active, path_MailingAddress).AsRecord(L.MailingAddress, R.MailingAddress);
        
      checked_MailingAddress := MAP (is_deleted => R.MailingAddress,
                              is_added => L.MailingAddress,
                              updated_MailingAddress);
      SELF.MailingAddress := checked_MailingAddress;
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
    shared boolean updated_DriverLicense := (L.DriverLicense != R.DriverLicense);
    shared boolean updated_SSN := (L.SSN != R.SSN);
    shared boolean updated_OriginState := (L.OriginState != R.OriginState);

    shared is_updated := false
      OR updated_DriverLicense
      OR updated_SSN
      OR updated_OriginState;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_DriverLicense, DATASET ([{'DriverLicense', R.DriverLicense}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow))
         +  IF (updated_OriginState, DATASET ([{'OriginState', R.OriginState}], layouts.DiffMetaRow));

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

EXPORT _df_MotorVehicleReportVehicleInfo(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReportVehicleInfo L, layouts._lt_MotorVehicleReportVehicleInfo R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_VIN := (L.VIN != R.VIN);
    shared boolean updated_Make := (L.Make != R.Make);
    shared boolean updated_Model := (L.Model != R.Model);

    shared is_updated := false
      OR updated_VIN
      OR updated_Make
      OR updated_Model;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_VIN, DATASET ([{'VIN', R.VIN}], layouts.DiffMetaRow))
         +  IF (updated_Make, DATASET ([{'Make', R.Make}], layouts.DiffMetaRow))
         +  IF (updated_Model, DATASET ([{'Model', R.Model}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_MotorVehicleReportVehicleInfo ProcessTx(layouts._lt_MotorVehicleReportVehicleInfo L, layouts._lt_MotorVehicleReportVehicleInfo R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_MotorVehicleReportVehicleInfo _new, layouts._lt_MotorVehicleReportVehicleInfo _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_MotorVehicleReportPersonOrBusiness(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReportPersonOrBusiness L, layouts._lt_MotorVehicleReportPersonOrBusiness R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);
    shared boolean updated_SSN := (L.SSN != R.SSN);
    shared boolean updated_DriverLicenseNumber := (L.DriverLicenseNumber != R.DriverLicenseNumber);
    shared boolean updated_ReportedName := (L.ReportedName != R.ReportedName);

    shared is_updated := false
      OR updated_UniqueId
      OR updated_SSN
      OR updated_DriverLicenseNumber
      OR updated_ReportedName;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow))
         +  IF (updated_DriverLicenseNumber, DATASET ([{'DriverLicenseNumber', R.DriverLicenseNumber}], layouts.DiffMetaRow))
         +  IF (updated_ReportedName, DATASET ([{'ReportedName', R.ReportedName}], layouts.DiffMetaRow));

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
    shared boolean updated_TitleNumber := (L.TitleNumber != R.TitleNumber);

    shared is_updated := false
      OR updated_TitleNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_TitleNumber, DATASET ([{'TitleNumber', R.TitleNumber}], layouts.DiffMetaRow));

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

EXPORT _df_MotorVehicleReportOwner(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MotorVehicleReportOwner L, layouts._lt_MotorVehicleReportOwner R, boolean is_deleted, boolean is_added) := MODULE

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

  EXPORT layouts._lt_MotorVehicleReportOwner ProcessTx(layouts._lt_MotorVehicleReportOwner L, layouts._lt_MotorVehicleReportOwner R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_OwnerInfo := path + '/OwnerInfo';
    
      updated_OwnerInfo := _df_MotorVehicleReportPersonOrBusiness(is_active, path_OwnerInfo).AsRecord(L.OwnerInfo, R.OwnerInfo);
        
      checked_OwnerInfo := MAP (is_deleted => R.OwnerInfo,
                              is_added => L.OwnerInfo,
                              updated_OwnerInfo);
      SELF.OwnerInfo := checked_OwnerInfo;
      SELF.TitleInfo  := L.TitleInfo;
      SELF.SourceDateFirstSeen  := L.SourceDateFirstSeen;
      SELF.SourceDateLastSeen  := L.SourceDateLastSeen;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_MotorVehicleReportOwner ProcessTxRow(layouts._lt_row_MotorVehicleReportOwner L, layouts._lt_row_MotorVehicleReportOwner R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_OwnerInfo := path + '/OwnerInfo';
    
      updated_OwnerInfo := _df_MotorVehicleReportPersonOrBusiness(is_active, path_OwnerInfo).AsRecord(L.OwnerInfo, R.OwnerInfo);
        
      checked_OwnerInfo := MAP (is_deleted => R.OwnerInfo,
                              is_added => L.OwnerInfo,
                              updated_OwnerInfo);
      SELF.OwnerInfo := checked_OwnerInfo;
      SELF.TitleInfo  := L.TitleInfo;
      SELF.SourceDateFirstSeen  := L.SourceDateFirstSeen;
      SELF.SourceDateLastSeen  := L.SourceDateLastSeen;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_MotorVehicleReportOwner _new, layouts._lt_MotorVehicleReportOwner _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_ownerinfo_uniqueid(layouts._lt_MotorVehicleReportOwner L, layouts._lt_MotorVehicleReportOwner R) := FUNCTION
    boolean IsInner :=  (L.OwnerInfo.UniqueId = R.OwnerInfo.UniqueId);

    boolean IsOuterRight :=   (L.OwnerInfo.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_ownerinfo_uniqueid (dataset(layouts._lt_MotorVehicleReportOwner) _n, dataset(layouts._lt_MotorVehicleReportOwner) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_MotorVehicleReportOwner, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_MotorVehicleReportOwner, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.OwnerInfo.UniqueId = RIGHT.OwnerInfo.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_ownerinfo_uniqueid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.OwnerInfo.UniqueId = RIGHT.OwnerInfo.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_ownerinfo_uniqueid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_MotorVehicleReportOwner);
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

      path_VehicleInfo := path + '/VehicleInfo';
    
      updated_VehicleInfo := _df_MotorVehicleReportVehicleInfo(is_active, path_VehicleInfo).AsRecord(L.VehicleInfo, R.VehicleInfo);
        
      checked_VehicleInfo := MAP (is_deleted => R.VehicleInfo,
                              is_added => L.VehicleInfo,
                              updated_VehicleInfo);
      SELF.VehicleInfo := checked_VehicleInfo;
      SELF.VinaData  := L.VinaData;

      updated_Registrants := _df_MotorVehicleReportRegistrant(is_active, path + '/Registrants/Registrant').AsDataset_registrantinfo_uniqueid(L.Registrants, R.Registrants);
      checked_Registrants := MAP (is_deleted => R.Registrants,
                              is_added => L.Registrants,
                              updated_Registrants);
      SELF.Registrants  := checked_Registrants;

      updated_Owners := _df_MotorVehicleReportOwner(is_active, path + '/Owners/Owner').AsDataset_ownerinfo_uniqueid(L.Owners, R.Owners);
      checked_Owners := MAP (is_deleted => R.Owners,
                              is_added => L.Owners,
                              updated_Owners);
      SELF.Owners  := checked_Owners;
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

      path_VehicleInfo := path + '/VehicleInfo';
    
      updated_VehicleInfo := _df_MotorVehicleReportVehicleInfo(is_active, path_VehicleInfo).AsRecord(L.VehicleInfo, R.VehicleInfo);
        
      checked_VehicleInfo := MAP (is_deleted => R.VehicleInfo,
                              is_added => L.VehicleInfo,
                              updated_VehicleInfo);
      SELF.VehicleInfo := checked_VehicleInfo;
      SELF.VinaData  := L.VinaData;

      updated_Registrants := _df_MotorVehicleReportRegistrant(is_active, path + '/Registrants/Registrant').AsDataset_registrantinfo_uniqueid(L.Registrants, R.Registrants);
      checked_Registrants := MAP (is_deleted => R.Registrants,
                              is_added => L.Registrants,
                              updated_Registrants);
      SELF.Registrants  := checked_Registrants;

      updated_Owners := _df_MotorVehicleReportOwner(is_active, path + '/Owners/Owner').AsDataset_ownerinfo_uniqueid(L.Owners, R.Owners);
      checked_Owners := MAP (is_deleted => R.Owners,
                              is_added => L.Owners,
                              updated_Owners);
      SELF.Owners  := checked_Owners;
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

EXPORT _df_AccidentReportInvestigationAgent(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AccidentReportInvestigationAgent L, layouts._lt_AccidentReportInvestigationAgent R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_AgentReportNumber := (L.AgentReportNumber != R.AgentReportNumber);

    shared is_updated := false
      OR updated_AgentReportNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_AgentReportNumber, DATASET ([{'AgentReportNumber', R.AgentReportNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_AccidentReportInvestigationAgent ProcessTx(layouts._lt_AccidentReportInvestigationAgent L, layouts._lt_AccidentReportInvestigationAgent R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_AccidentReportInvestigationAgent _new, layouts._lt_AccidentReportInvestigationAgent _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_AccidentReportInvestigation(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AccidentReportInvestigation L, layouts._lt_AccidentReportInvestigation R, boolean is_deleted, boolean is_added) := MODULE

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

  EXPORT layouts._lt_AccidentReportInvestigation ProcessTx(layouts._lt_AccidentReportInvestigation L, layouts._lt_AccidentReportInvestigation R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_InvestigationAgent := path + '/InvestigationAgent';
    
      updated_InvestigationAgent := _df_AccidentReportInvestigationAgent(is_active, path_InvestigationAgent).AsRecord(L.InvestigationAgent, R.InvestigationAgent);
        
      checked_InvestigationAgent := MAP (is_deleted => R.InvestigationAgent,
                              is_added => L.InvestigationAgent,
                              updated_InvestigationAgent);
      SELF.InvestigationAgent := checked_InvestigationAgent;
      SELF.SearchDate  := L.SearchDate;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_AccidentReportInvestigation _new, layouts._lt_AccidentReportInvestigation _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_AccidentReportIndividualInvolved(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AccidentReportIndividualInvolved L, layouts._lt_AccidentReportIndividualInvolved R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);

    shared is_updated := false
      OR updated_UniqueId;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_AccidentReportIndividualInvolved ProcessTx(layouts._lt_AccidentReportIndividualInvolved L, layouts._lt_AccidentReportIndividualInvolved R, boolean is_deleted, boolean is_added) :=TRANSFORM
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

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;

      updated_ChargedOffenses := _df_DiffString(CASE(path + '/ChargedOffenses', '/Accidents/Accident/Vehicles/Item/Driver/Individual/ChargedOffenses' => (false), is_active), path + '/ChargedOffenses/Item').AsDataset(L.ChargedOffenses, R.ChargedOffenses);
      checked_ChargedOffenses := MAP (is_deleted => R.ChargedOffenses,
                              is_added => L.ChargedOffenses,
                              updated_ChargedOffenses);
      SELF.ChargedOffenses := checked_ChargedOffenses;
    
      updated_FRDLCharges := _df_DiffString(CASE(path + '/FRDLCharges', '/Accidents/Accident/Vehicles/Item/Driver/Individual/FRDLCharges' => (false), is_active), path + '/FRDLCharges/Item').AsDataset(L.FRDLCharges, R.FRDLCharges);
      checked_FRDLCharges := MAP (is_deleted => R.FRDLCharges,
                              is_added => L.FRDLCharges,
                              updated_FRDLCharges);
      SELF.FRDLCharges := checked_FRDLCharges;
    
      updated_Citations := _df_DiffString(CASE(path + '/Citations', '/Accidents/Accident/Vehicles/Item/Driver/Individual/Citations' => (false), is_active), path + '/Citations/Item').AsDataset(L.Citations, R.Citations);
      checked_Citations := MAP (is_deleted => R.Citations,
                              is_added => L.Citations,
                              updated_Citations);
      SELF.Citations := checked_Citations;
    

      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_AccidentReportIndividualInvolved _new, layouts._lt_AccidentReportIndividualInvolved _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_AccidentReportDriver(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AccidentReportDriver L, layouts._lt_AccidentReportDriver R, boolean is_deleted, boolean is_added) := MODULE

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

  EXPORT layouts._lt_AccidentReportDriver ProcessTx(layouts._lt_AccidentReportDriver L, layouts._lt_AccidentReportDriver R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.DriverLicense  := L.DriverLicense;

      path_Individual := path + '/Individual';
    
      updated_Individual := _df_AccidentReportIndividualInvolved(is_active, path_Individual).AsRecord(L.Individual, R.Individual);
        
      checked_Individual := MAP (is_deleted => R.Individual,
                              is_added => L.Individual,
                              updated_Individual);
      SELF.Individual := checked_Individual;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_AccidentReportDriver _new, layouts._lt_AccidentReportDriver _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_AccidentReportVehicle(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AccidentReportVehicle L, layouts._lt_AccidentReportVehicle R, boolean is_deleted, boolean is_added) := MODULE

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

  EXPORT layouts._lt_AccidentReportVehicle ProcessTx(layouts._lt_AccidentReportVehicle L, layouts._lt_AccidentReportVehicle R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.Owner  := L.Owner;
      SELF.TowedTrailer  := L.TowedTrailer;

      path_Driver := path + '/Driver';
    
      updated_Driver := _df_AccidentReportDriver(is_active, path_Driver).AsRecord(L.Driver, R.Driver);
        
      checked_Driver := MAP (is_deleted => R.Driver,
                              is_added => L.Driver,
                              updated_Driver);
      SELF.Driver := checked_Driver;
      SELF.Passengers  := L.Passengers;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_AccidentReportVehicle ProcessTxRow(layouts._lt_row_AccidentReportVehicle L, layouts._lt_row_AccidentReportVehicle R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.Owner  := L.Owner;
      SELF.TowedTrailer  := L.TowedTrailer;

      path_Driver := path + '/Driver';
    
      updated_Driver := _df_AccidentReportDriver(is_active, path_Driver).AsRecord(L.Driver, R.Driver);
        
      checked_Driver := MAP (is_deleted => R.Driver,
                              is_added => L.Driver,
                              updated_Driver);
      SELF.Driver := checked_Driver;
      SELF.Passengers  := L.Passengers;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_AccidentReportVehicle _new, layouts._lt_AccidentReportVehicle _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_driver_individual_uniqueid(layouts._lt_AccidentReportVehicle L, layouts._lt_AccidentReportVehicle R) := FUNCTION
    boolean IsInner :=  (L.Driver.Individual.UniqueId = R.Driver.Individual.UniqueId);

    boolean IsOuterRight :=   (L.Driver.Individual.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_driver_individual_uniqueid (dataset(layouts._lt_AccidentReportVehicle) _n, dataset(layouts._lt_AccidentReportVehicle) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_AccidentReportVehicle, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_AccidentReportVehicle, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Driver.Individual.UniqueId = RIGHT.Driver.Individual.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_driver_individual_uniqueid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Driver.Individual.UniqueId = RIGHT.Driver.Individual.UniqueId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_driver_individual_uniqueid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_AccidentReportVehicle);
  END;
  
END;

EXPORT _df_AccidentReportRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_AccidentReportRecord L, layouts._lt_AccidentReportRecord R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_AccidentState := (L.AccidentState != R.AccidentState);

    shared is_updated := false
      OR updated_AccidentState;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_AccidentState, DATASET ([{'AccidentState', R.AccidentState}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_AccidentReportRecord ProcessTx(layouts._lt_AccidentReportRecord L, layouts._lt_AccidentReportRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_AccidentDate := path + '/AccidentDate';
    
      updated_AccidentDate := _df_Date(is_active, path_AccidentDate).AsRecord(L.AccidentDate, R.AccidentDate);
        
      checked_AccidentDate := MAP (is_deleted => R.AccidentDate,
                              is_added => L.AccidentDate,
                              updated_AccidentDate);
      SELF.AccidentDate := checked_AccidentDate;
      SELF.AccidentLocation  := L.AccidentLocation;
      SELF.AccidentTime  := L.AccidentTime;
      SELF.DotInfo  := L.DotInfo;
      SELF.Conditions  := L.Conditions;

      path_Investigation := path + '/Investigation';
    
      updated_Investigation := _df_AccidentReportInvestigation(is_active, path_Investigation).AsRecord(L.Investigation, R.Investigation);
        
      checked_Investigation := MAP (is_deleted => R.Investigation,
                              is_added => L.Investigation,
                              updated_Investigation);
      SELF.Investigation := checked_Investigation;
      SELF.Statistics  := L.Statistics;

      updated_Vehicles := _df_AccidentReportVehicle(is_active, path + '/Vehicles/Item').AsDataset_driver_individual_uniqueid(L.Vehicles, R.Vehicles);
      checked_Vehicles := MAP (is_deleted => R.Vehicles,
                              is_added => L.Vehicles,
                              updated_Vehicles);
      SELF.Vehicles  := checked_Vehicles;
      SELF.PropertyDamages  := L.PropertyDamages;
      SELF.Pedestrians  := L.Pedestrians;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_AccidentReportRecord ProcessTxRow(layouts._lt_row_AccidentReportRecord L, layouts._lt_row_AccidentReportRecord R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      path_AccidentDate := path + '/AccidentDate';
    
      updated_AccidentDate := _df_Date(is_active, path_AccidentDate).AsRecord(L.AccidentDate, R.AccidentDate);
        
      checked_AccidentDate := MAP (is_deleted => R.AccidentDate,
                              is_added => L.AccidentDate,
                              updated_AccidentDate);
      SELF.AccidentDate := checked_AccidentDate;
      SELF.AccidentLocation  := L.AccidentLocation;
      SELF.AccidentTime  := L.AccidentTime;
      SELF.DotInfo  := L.DotInfo;
      SELF.Conditions  := L.Conditions;

      path_Investigation := path + '/Investigation';
    
      updated_Investigation := _df_AccidentReportInvestigation(is_active, path_Investigation).AsRecord(L.Investigation, R.Investigation);
        
      checked_Investigation := MAP (is_deleted => R.Investigation,
                              is_added => L.Investigation,
                              updated_Investigation);
      SELF.Investigation := checked_Investigation;
      SELF.Statistics  := L.Statistics;

      updated_Vehicles := _df_AccidentReportVehicle(is_active, path + '/Vehicles/Item').AsDataset_driver_individual_uniqueid(L.Vehicles, R.Vehicles);
      checked_Vehicles := MAP (is_deleted => R.Vehicles,
                              is_added => L.Vehicles,
                              updated_Vehicles);
      SELF.Vehicles  := checked_Vehicles;
      SELF.PropertyDamages  := L.PropertyDamages;
      SELF.Pedestrians  := L.Pedestrians;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_AccidentReportRecord _new, layouts._lt_AccidentReportRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_accidentdate_yearaccidentstateinvestigation_investigationagent_agentreportnumber(layouts._lt_AccidentReportRecord L, layouts._lt_AccidentReportRecord R) := FUNCTION
    boolean IsInner :=  (L.Investigation.InvestigationAgent.AgentReportNumber = R.Investigation.InvestigationAgent.AgentReportNumber AND L.AccidentState = R.AccidentState AND L.AccidentDate.Year = R.AccidentDate.Year);

    boolean IsOuterRight :=   (L.Investigation.InvestigationAgent.AgentReportNumber = '' AND L.AccidentState = '' AND L.AccidentDate.Year = 0);
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_accidentdate_yearaccidentstateinvestigation_investigationagent_agentreportnumber (dataset(layouts._lt_AccidentReportRecord) _n, dataset(layouts._lt_AccidentReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_AccidentReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_AccidentReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Investigation.InvestigationAgent.AgentReportNumber = RIGHT.Investigation.InvestigationAgent.AgentReportNumber AND LEFT.AccidentState = RIGHT.AccidentState AND LEFT.AccidentDate.Year = RIGHT.AccidentDate.Year,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_accidentdate_yearaccidentstateinvestigation_investigationagent_agentreportnumber(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Investigation.InvestigationAgent.AgentReportNumber = RIGHT.Investigation.InvestigationAgent.AgentReportNumber AND LEFT.AccidentState = RIGHT.AccidentState AND LEFT.AccidentDate.Year = RIGHT.AccidentDate.Year,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_accidentdate_yearaccidentstateinvestigation_investigationagent_agentreportnumber(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_AccidentReportRecord);
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
  
  EXPORT  integer1 CheckOuter_firstlast(layouts._lt_BankruptcySearch2Name L, layouts._lt_BankruptcySearch2Name R) := FUNCTION
    boolean IsInner :=  (L.Last = R.Last AND L.First = R.First);

    boolean IsOuterRight :=   (L.Last = '' AND L.First = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_firstlast (dataset(layouts._lt_BankruptcySearch2Name) _n, dataset(layouts._lt_BankruptcySearch2Name) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_BankruptcySearch2Name, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_BankruptcySearch2Name, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlast(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Last = RIGHT.Last AND LEFT.First = RIGHT.First,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_firstlast(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_BankruptcySearch2Name);
  END;
  
END;

EXPORT _df_BankruptcyPerson2(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BankruptcyPerson2 L, layouts._lt_BankruptcyPerson2 R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_UniqueId
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BankruptcyPerson2 ProcessTx(layouts._lt_BankruptcyPerson2 L, layouts._lt_BankruptcyPerson2 R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlast(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;
      SELF.AddressesEx  := L.AddressesEx;

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

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlast(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;
      SELF.AddressesEx  := L.AddressesEx;

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
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_UniqueId
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BankruptcyReport2Debtor ProcessTx(layouts._lt_BankruptcyReport2Debtor L, layouts._lt_BankruptcyReport2Debtor R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlast(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;
      SELF.AddressesEx  := L.AddressesEx;

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

      updated_Names := _df_BankruptcySearch2Name(is_active, path + '/Names/Name').AsDataset_firstlast(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;
      SELF.AddressesEx  := L.AddressesEx;

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
    shared boolean updated_FilingJurisdiction := (L.FilingJurisdiction != R.FilingJurisdiction);
    shared boolean updated_CaseType := (L.CaseType != R.CaseType);
    shared boolean updated_CaseNumber := (L.CaseNumber != R.CaseNumber);

    shared is_updated := false
      OR updated_FilingJurisdiction
      OR updated_CaseType
      OR updated_CaseNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_FilingJurisdiction, DATASET ([{'FilingJurisdiction', R.FilingJurisdiction}], layouts.DiffMetaRow))
         +  IF (updated_CaseType, DATASET ([{'CaseType', R.CaseType}], layouts.DiffMetaRow))
         +  IF (updated_CaseNumber, DATASET ([{'CaseNumber', R.CaseNumber}], layouts.DiffMetaRow));

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
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_UniqueId
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

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
    shared boolean updated_OriginName := (L.OriginName != R.OriginName);
    shared boolean updated_SSN := (L.SSN != R.SSN);

    shared is_updated := false
      OR updated_OriginName
      OR updated_SSN;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_OriginName, DATASET ([{'OriginName', R.OriginName}], layouts.DiffMetaRow))
         +  IF (updated_SSN, DATASET ([{'SSN', R.SSN}], layouts.DiffMetaRow));

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

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;
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

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;
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
    shared boolean updated_TMSId := (L.TMSId != R.TMSId);
    shared boolean updated_OriginFilingNumber := (L.OriginFilingNumber != R.OriginFilingNumber);

    shared is_updated := false
      OR updated_TMSId
      OR updated_OriginFilingNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_TMSId, DATASET ([{'TMSId', R.TMSId}], layouts.DiffMetaRow))
         +  IF (updated_OriginFilingNumber, DATASET ([{'OriginFilingNumber', R.OriginFilingNumber}], layouts.DiffMetaRow));

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
  
  EXPORT  integer1 CheckOuter_originfilingnumbertmsid(layouts._lt_LienJudgmentReportRecord L, layouts._lt_LienJudgmentReportRecord R) := FUNCTION
    boolean IsInner :=  (L.OriginFilingNumber = R.OriginFilingNumber AND L.TMSId = R.TMSId);

    boolean IsOuterRight :=   (L.OriginFilingNumber = '' AND L.TMSId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_originfilingnumbertmsid (dataset(layouts._lt_LienJudgmentReportRecord) _n, dataset(layouts._lt_LienJudgmentReportRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_LienJudgmentReportRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_LienJudgmentReportRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.OriginFilingNumber = RIGHT.OriginFilingNumber AND LEFT.TMSId = RIGHT.TMSId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_originfilingnumbertmsid(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.OriginFilingNumber = RIGHT.OriginFilingNumber AND LEFT.TMSId = RIGHT.TMSId,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_originfilingnumbertmsid(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_LienJudgmentReportRecord);
  END;
  
END;

EXPORT _df_Property2Name(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_Property2Name L, layouts._lt_Property2Name R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_First := (L.First != R.First);
    shared boolean updated_Last := (L.Last != R.Last);
    shared boolean updated_IdValue := (L.IdValue != R.IdValue);
    shared boolean updated_UniqueId := (L.UniqueId != R.UniqueId);
    shared boolean updated_BusinessId := (L.BusinessId != R.BusinessId);
    shared boolean updated_AppendedSSN := (L.AppendedSSN != R.AppendedSSN);
    shared boolean updated_LinkingWeight := (L.LinkingWeight != R.LinkingWeight);

    shared is_updated := false
      OR updated_First
      OR updated_Last
      OR updated_IdValue
      OR updated_UniqueId
      OR updated_BusinessId
      OR updated_AppendedSSN
      OR updated_LinkingWeight;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_First, DATASET ([{'First', R.First}], layouts.DiffMetaRow))
         +  IF (updated_Last, DATASET ([{'Last', R.Last}], layouts.DiffMetaRow))+ IF (updated_IdValue, DATASET ([{'IdValue', R.IdValue}], layouts.DiffMetaRow))
         +  IF (updated_UniqueId, DATASET ([{'UniqueId', R.UniqueId}], layouts.DiffMetaRow))
         +  IF (updated_BusinessId, DATASET ([{'BusinessId', R.BusinessId}], layouts.DiffMetaRow))
         +  IF (updated_AppendedSSN, DATASET ([{'AppendedSSN', R.AppendedSSN}], layouts.DiffMetaRow))
         +  IF (updated_LinkingWeight, DATASET ([{'LinkingWeight', R.LinkingWeight}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_Property2Name ProcessTx(layouts._lt_Property2Name L, layouts._lt_Property2Name R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_Property2Name ProcessTxRow(layouts._lt_row_Property2Name L, layouts._lt_row_Property2Name R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_Property2Name _new, layouts._lt_Property2Name _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_uniqueid(layouts._lt_Property2Name L, layouts._lt_Property2Name R) := FUNCTION
    boolean IsInner :=  (L.UniqueId = R.UniqueId);

    boolean IsOuterRight :=   (L.UniqueId = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_uniqueid (dataset(layouts._lt_Property2Name) _n, dataset(layouts._lt_Property2Name) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_Property2Name, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_Property2Name, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
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
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_Property2Name);
  END;
  
END;

EXPORT _df_Property2Entity(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_Property2Entity L, layouts._lt_Property2Entity R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_EntityTypeCode := (L.EntityTypeCode != R.EntityTypeCode);

    shared is_updated := false
      OR updated_EntityTypeCode;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_EntityTypeCode, DATASET ([{'EntityTypeCode', R.EntityTypeCode}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_Property2Entity ProcessTx(layouts._lt_Property2Entity L, layouts._lt_Property2Entity R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      updated_Names := _df_Property2Name(is_active, path + '/Names/Name').AsDataset_uniqueid(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;

      updated_OriginalNames := _df_DiffString(is_active, path + '/OriginalNames/Name').AsDataset(L.OriginalNames, R.OriginalNames);
      checked_OriginalNames := MAP (is_deleted => R.OriginalNames,
                              is_added => L.OriginalNames,
                              updated_OriginalNames);
      SELF.OriginalNames := checked_OriginalNames;
          SELF.OriginalNames2  := L.OriginalNames2;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.GeoLocation  := L.GeoLocation;
      SELF.Phone  := L.Phone;
      SELF.OriginalAddress  := L.OriginalAddress;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_Property2Entity ProcessTxRow(layouts._lt_row_Property2Entity L, layouts._lt_row_Property2Entity R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
   
      updated_Names := _df_Property2Name(is_active, path + '/Names/Name').AsDataset_uniqueid(L.Names, R.Names);
      checked_Names := MAP (is_deleted => R.Names,
                              is_added => L.Names,
                              updated_Names);
      SELF.Names  := checked_Names;

      updated_OriginalNames := _df_DiffString(is_active, path + '/OriginalNames/Name').AsDataset(L.OriginalNames, R.OriginalNames);
      checked_OriginalNames := MAP (is_deleted => R.OriginalNames,
                              is_added => L.OriginalNames,
                              updated_OriginalNames);
      SELF.OriginalNames := checked_OriginalNames;
          SELF.OriginalNames2  := L.OriginalNames2;

      path_Address := path + '/Address';
    
      updated_Address := _df_Address(is_active, path_Address).AsRecord(L.Address, R.Address);
        
      checked_Address := MAP (is_deleted => R.Address,
                              is_added => L.Address,
                              updated_Address);
      SELF.Address := checked_Address;
      SELF.GeoLocation  := L.GeoLocation;
      SELF.Phone  := L.Phone;
      SELF.OriginalAddress  := L.OriginalAddress;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_Property2Entity _new, layouts._lt_Property2Entity _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_entitytypecode(layouts._lt_Property2Entity L, layouts._lt_Property2Entity R) := FUNCTION
    boolean IsInner :=  (L.EntityTypeCode = R.EntityTypeCode);

    boolean IsOuterRight :=   (L.EntityTypeCode = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_entitytypecode (dataset(layouts._lt_Property2Entity) _n, dataset(layouts._lt_Property2Entity) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_Property2Entity, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_Property2Entity, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.EntityTypeCode = RIGHT.EntityTypeCode,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_entitytypecode(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.EntityTypeCode = RIGHT.EntityTypeCode,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_entitytypecode(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_Property2Entity);
  END;
  
END;

EXPORT _df_PropertyReport2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PropertyReport2Record L, layouts._lt_PropertyReport2Record R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_RecordType := (L.RecordType != R.RecordType);
    shared boolean updated_ParcelNumber := (L.ParcelNumber != R.ParcelNumber);

    shared is_updated := false
      OR updated_RecordType
      OR updated_ParcelNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_RecordType, DATASET ([{'RecordType', R.RecordType}], layouts.DiffMetaRow))
         +  IF (updated_ParcelNumber, DATASET ([{'ParcelNumber', R.ParcelNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_PropertyReport2Record ProcessTx(layouts._lt_PropertyReport2Record L, layouts._lt_PropertyReport2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.BusinessIds  := L.BusinessIds;
      SELF.Assessment  := L.Assessment;
      SELF.Deed  := L.Deed;

      updated_Entities := _df_Property2Entity(is_active, path + '/Entities/Entity').AsDataset_entitytypecode(L.Entities, R.Entities);
      checked_Entities := MAP (is_deleted => R.Entities,
                              is_added => L.Entities,
                              updated_Entities);
      SELF.Entities  := checked_Entities;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PropertyReport2Record ProcessTxRow(layouts._lt_row_PropertyReport2Record L, layouts._lt_row_PropertyReport2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.BusinessIds  := L.BusinessIds;
      SELF.Assessment  := L.Assessment;
      SELF.Deed  := L.Deed;

      updated_Entities := _df_Property2Entity(is_active, path + '/Entities/Entity').AsDataset_entitytypecode(L.Entities, R.Entities);
      checked_Entities := MAP (is_deleted => R.Entities,
                              is_added => L.Entities,
                              updated_Entities);
      SELF.Entities  := checked_Entities;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PropertyReport2Record _new, layouts._lt_PropertyReport2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_parcelnumberrecordtype(layouts._lt_PropertyReport2Record L, layouts._lt_PropertyReport2Record R) := FUNCTION
    boolean IsInner :=  (L.ParcelNumber = R.ParcelNumber AND L.RecordType = R.RecordType);

    boolean IsOuterRight :=   (L.ParcelNumber = '' AND L.RecordType = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_parcelnumberrecordtype (dataset(layouts._lt_PropertyReport2Record) _n, dataset(layouts._lt_PropertyReport2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PropertyReport2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PropertyReport2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.ParcelNumber = RIGHT.ParcelNumber AND LEFT.RecordType = RIGHT.RecordType,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_parcelnumberrecordtype(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.ParcelNumber = RIGHT.ParcelNumber AND LEFT.RecordType = RIGHT.RecordType,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_parcelnumberrecordtype(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PropertyReport2Record);
  END;
  
END;

EXPORT _df_MarriageSearch2Record(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_MarriageSearch2Record L, layouts._lt_MarriageSearch2Record R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_FilingTypeCode := (L.FilingTypeCode != R.FilingTypeCode);
    shared boolean updated_StateOrigin := (L.StateOrigin != R.StateOrigin);
    shared boolean updated_FilingNumber := (L.FilingNumber != R.FilingNumber);

    shared is_updated := false
      OR updated_FilingTypeCode
      OR updated_StateOrigin
      OR updated_FilingNumber;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_FilingTypeCode, DATASET ([{'FilingTypeCode', R.FilingTypeCode}], layouts.DiffMetaRow))
         +  IF (updated_StateOrigin, DATASET ([{'StateOrigin', R.StateOrigin}], layouts.DiffMetaRow))
         +  IF (updated_FilingNumber, DATASET ([{'FilingNumber', R.FilingNumber}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_MarriageSearch2Record ProcessTx(layouts._lt_MarriageSearch2Record L, layouts._lt_MarriageSearch2Record R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.FilingDate  := L.FilingDate;
      SELF.MarriageDate  := L.MarriageDate;
      SELF.DivorceDate  := L.DivorceDate;
      SELF.Party1  := L.Party1;
      SELF.Party2  := L.Party2;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_MarriageSearch2Record ProcessTxRow(layouts._lt_row_MarriageSearch2Record L, layouts._lt_row_MarriageSearch2Record R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.FilingDate  := L.FilingDate;
      SELF.MarriageDate  := L.MarriageDate;
      SELF.DivorceDate  := L.DivorceDate;
      SELF.Party1  := L.Party1;
      SELF.Party2  := L.Party2;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_MarriageSearch2Record _new, layouts._lt_MarriageSearch2Record _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_filingnumberfilingtypecodestateorigin(layouts._lt_MarriageSearch2Record L, layouts._lt_MarriageSearch2Record R) := FUNCTION
    boolean IsInner :=  (L.FilingNumber = R.FilingNumber AND L.FilingTypeCode = R.FilingTypeCode AND L.StateOrigin = R.StateOrigin);

    boolean IsOuterRight :=   (L.FilingNumber = '' AND L.FilingTypeCode = '' AND L.StateOrigin = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_filingnumberfilingtypecodestateorigin (dataset(layouts._lt_MarriageSearch2Record) _n, dataset(layouts._lt_MarriageSearch2Record) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_MarriageSearch2Record, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_MarriageSearch2Record, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.FilingNumber = RIGHT.FilingNumber AND LEFT.FilingTypeCode = RIGHT.FilingTypeCode AND LEFT.StateOrigin = RIGHT.StateOrigin,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_filingnumberfilingtypecodestateorigin(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.FilingNumber = RIGHT.FilingNumber AND LEFT.FilingTypeCode = RIGHT.FilingTypeCode AND LEFT.StateOrigin = RIGHT.StateOrigin,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_filingnumberfilingtypecodestateorigin(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_MarriageSearch2Record);
  END;
  
END;

EXPORT _df_StudentRecord(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_StudentRecord L, layouts._lt_StudentRecord R, boolean is_deleted, boolean is_added) := MODULE

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

  EXPORT layouts._lt_StudentRecord ProcessTx(layouts._lt_StudentRecord L, layouts._lt_StudentRecord R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_FirstReported := path + '/FirstReported';
    
      updated_FirstReported := _df_Date(is_active, path_FirstReported).AsRecord(L.FirstReported, R.FirstReported);
        
      checked_FirstReported := MAP (is_deleted => R.FirstReported,
                              is_added => L.FirstReported,
                              updated_FirstReported);
      SELF.FirstReported := checked_FirstReported;
      SELF.LastReported  := L.LastReported;

      path_AddressAtCollege := path + '/AddressAtCollege';
    
      updated_AddressAtCollege := _df_Address(is_active, path_AddressAtCollege).AsRecord(L.AddressAtCollege, R.AddressAtCollege);
        
      checked_AddressAtCollege := MAP (is_deleted => R.AddressAtCollege,
                              is_added => L.AddressAtCollege,
                              updated_AddressAtCollege);
      SELF.AddressAtCollege := checked_AddressAtCollege;
      SELF.DOB  := L.DOB;
      SELF.CollegeData  := L.CollegeData;
      SELF.StudentData  := L.StudentData;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_StudentRecord ProcessTxRow(layouts._lt_row_StudentRecord L, layouts._lt_row_StudentRecord R, integer1 joinRowType) :=TRANSFORM
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

      path_FirstReported := path + '/FirstReported';
    
      updated_FirstReported := _df_Date(is_active, path_FirstReported).AsRecord(L.FirstReported, R.FirstReported);
        
      checked_FirstReported := MAP (is_deleted => R.FirstReported,
                              is_added => L.FirstReported,
                              updated_FirstReported);
      SELF.FirstReported := checked_FirstReported;
      SELF.LastReported  := L.LastReported;

      path_AddressAtCollege := path + '/AddressAtCollege';
    
      updated_AddressAtCollege := _df_Address(is_active, path_AddressAtCollege).AsRecord(L.AddressAtCollege, R.AddressAtCollege);
        
      checked_AddressAtCollege := MAP (is_deleted => R.AddressAtCollege,
                              is_added => L.AddressAtCollege,
                              updated_AddressAtCollege);
      SELF.AddressAtCollege := checked_AddressAtCollege;
      SELF.DOB  := L.DOB;
      SELF.CollegeData  := L.CollegeData;
      SELF.StudentData  := L.StudentData;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_StudentRecord _new, layouts._lt_StudentRecord _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_addressatcollege_stateaddressatcollege_zip5firstreported_dayfirstreported_monthfirstreported_year(layouts._lt_StudentRecord L, layouts._lt_StudentRecord R) := FUNCTION
    boolean IsInner :=  (L.AddressAtCollege.Zip5 = R.AddressAtCollege.Zip5 AND L.AddressAtCollege.State = R.AddressAtCollege.State AND L.FirstReported.Year = R.FirstReported.Year AND L.FirstReported.Day = R.FirstReported.Day AND L.FirstReported.Month = R.FirstReported.Month);

    boolean IsOuterRight :=   (L.AddressAtCollege.Zip5 = '' AND L.AddressAtCollege.State = '' AND L.FirstReported.Year = 0 AND L.FirstReported.Day = 0 AND L.FirstReported.Month = 0);
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_addressatcollege_stateaddressatcollege_zip5firstreported_dayfirstreported_monthfirstreported_year (dataset(layouts._lt_StudentRecord) _n, dataset(layouts._lt_StudentRecord) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_StudentRecord, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_StudentRecord, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.AddressAtCollege.Zip5 = RIGHT.AddressAtCollege.Zip5 AND LEFT.AddressAtCollege.State = RIGHT.AddressAtCollege.State AND LEFT.FirstReported.Year = RIGHT.FirstReported.Year AND LEFT.FirstReported.Day = RIGHT.FirstReported.Day AND LEFT.FirstReported.Month = RIGHT.FirstReported.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_addressatcollege_stateaddressatcollege_zip5firstreported_dayfirstreported_monthfirstreported_year(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.AddressAtCollege.Zip5 = RIGHT.AddressAtCollege.Zip5 AND LEFT.AddressAtCollege.State = RIGHT.AddressAtCollege.State AND LEFT.FirstReported.Year = RIGHT.FirstReported.Year AND LEFT.FirstReported.Day = RIGHT.FirstReported.Day AND LEFT.FirstReported.Month = RIGHT.FirstReported.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_addressatcollege_stateaddressatcollege_zip5firstreported_dayfirstreported_monthfirstreported_year(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_StudentRecord);
  END;
  
END;

EXPORT _df_SSNInfoEx(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_SSNInfoEx L, layouts._lt_SSNInfoEx R, boolean is_deleted, boolean is_added) := MODULE
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

  EXPORT layouts._lt_SSNInfoEx ProcessTx(layouts._lt_SSNInfoEx L, layouts._lt_SSNInfoEx R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.IssuedStartDate  := L.IssuedStartDate;
      SELF.IssuedEndDate  := L.IssuedEndDate;
      SELF.HighRiskIndicators  := L.HighRiskIndicators;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT AsRecord (layouts._lt_SSNInfoEx _new, layouts._lt_SSNInfoEx _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
END;

EXPORT _df_BpsReportIdentity(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_BpsReportIdentity L, layouts._lt_BpsReportIdentity R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_IsLimitedAccessDMF := (L.IsLimitedAccessDMF != R.IsLimitedAccessDMF);

    shared is_updated := false
      OR updated_IsLimitedAccessDMF;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_IsLimitedAccessDMF, DATASET ([{'IsLimitedAccessDMF', IF(R.IsLimitedAccessDMF = true, 'true', 'false')}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_BpsReportIdentity ProcessTx(layouts._lt_BpsReportIdentity L, layouts._lt_BpsReportIdentity R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
  
      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;

      path_SSNInfoEx := path + '/SSNInfoEx';
    
      updated_SSNInfoEx := _df_SSNInfoEx(CASE(path_SSNInfoEx, '/Imposters/Imposter/SSNInfoEx' => (false), is_active), path_SSNInfoEx).AsRecord(L.SSNInfoEx, R.SSNInfoEx);
        
      checked_SSNInfoEx := MAP (is_deleted => R.SSNInfoEx,
                              is_added => L.SSNInfoEx,
                              updated_SSNInfoEx);
      SELF.SSNInfoEx := checked_SSNInfoEx;
      SELF.DOB  := L.DOB;
      SELF.DOD  := L.DOD;
      SELF.UtilityFactorDate  := L.UtilityFactorDate;
      SELF.DriverLicenses  := L.DriverLicenses;
      SELF.DriverLicenses2  := L.DriverLicenses2;
      SELF.CriminalHistories  := L.CriminalHistories;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_BpsReportIdentity ProcessTxRow(layouts._lt_row_BpsReportIdentity L, layouts._lt_row_BpsReportIdentity R, integer1 joinRowType) :=TRANSFORM
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

      path_SSNInfoEx := path + '/SSNInfoEx';
    
      updated_SSNInfoEx := _df_SSNInfoEx(CASE(path_SSNInfoEx, '/Imposters/Imposter/SSNInfoEx' => (false), is_active), path_SSNInfoEx).AsRecord(L.SSNInfoEx, R.SSNInfoEx);
        
      checked_SSNInfoEx := MAP (is_deleted => R.SSNInfoEx,
                              is_added => L.SSNInfoEx,
                              updated_SSNInfoEx);
      SELF.SSNInfoEx := checked_SSNInfoEx;
      SELF.DOB  := L.DOB;
      SELF.DOD  := L.DOD;
      SELF.UtilityFactorDate  := L.UtilityFactorDate;
      SELF.DriverLicenses  := L.DriverLicenses;
      SELF.DriverLicenses2  := L.DriverLicenses2;
      SELF.CriminalHistories  := L.CriminalHistories;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_BpsReportIdentity _new, layouts._lt_BpsReportIdentity _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_name_firstname_lastssninfoex_ssn(layouts._lt_BpsReportIdentity L, layouts._lt_BpsReportIdentity R) := FUNCTION
    boolean IsInner :=  (L.Name.Last = R.Name.Last AND L.Name.First = R.Name.First AND L.SSNInfoEx.SSN = R.SSNInfoEx.SSN);

    boolean IsOuterRight :=   (L.Name.Last = '' AND L.Name.First = '' AND L.SSNInfoEx.SSN = '');
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_name_firstname_lastssninfoex_ssn (dataset(layouts._lt_BpsReportIdentity) _n, dataset(layouts._lt_BpsReportIdentity) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_BpsReportIdentity, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_BpsReportIdentity, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.Name.Last = RIGHT.Name.Last AND LEFT.Name.First = RIGHT.Name.First AND LEFT.SSNInfoEx.SSN = RIGHT.SSNInfoEx.SSN,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_name_firstname_lastssninfoex_ssn(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.Name.Last = RIGHT.Name.Last AND LEFT.Name.First = RIGHT.Name.First AND LEFT.SSNInfoEx.SSN = RIGHT.SSNInfoEx.SSN,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_name_firstname_lastssninfoex_ssn(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_BpsReportIdentity);
  END;
  
END;

EXPORT _df_PersonSlimReportUtility(boolean is_active, string path) := MODULE

  EXPORT DiffScalars (layouts._lt_PersonSlimReportUtility L, layouts._lt_PersonSlimReportUtility R, boolean is_deleted, boolean is_added) := MODULE
    shared boolean updated_UtilType := (L.UtilType != R.UtilType);

    shared is_updated := false
      OR updated_UtilType;

    shared integer _change := MAP (is_deleted  => DiffStatus.State.DELETED,
                      is_added    => DiffStatus.State.ADDED,
                      is_updated  => DiffStatus.State.UPDATED,
                      DiffStatus.State.UNCHANGED);

    EXPORT _diff := DiffStatus.Convert (_change);
    // Get update information for all scalars
      _meta :=   IF (updated_UtilType, DATASET ([{'UtilType', R.UtilType}], layouts.DiffMetaRow));

    EXPORT _diffmeta := IF (~is_deleted AND ~is_added AND is_updated, _meta);
  END;

  EXPORT layouts._lt_PersonSlimReportUtility ProcessTx(layouts._lt_PersonSlimReportUtility L, layouts._lt_PersonSlimReportUtility R, boolean is_deleted, boolean is_added) :=TRANSFORM
      m := DiffScalars(L, R, is_deleted, is_added);

      SELF._diff := IF(is_active, m._diff, '');
      SELF._diffmeta := IF(is_active, m._diffmeta);
        SELF.ConnectDate  := L.ConnectDate;
      SELF.DateFirstSeen  := L.DateFirstSeen;

      path_RecordDate := path + '/RecordDate';
    
      updated_RecordDate := _df_Date(is_active, path_RecordDate).AsRecord(L.RecordDate, R.RecordDate);
        
      checked_RecordDate := MAP (is_deleted => R.RecordDate,
                              is_added => L.RecordDate,
                              updated_RecordDate);
      SELF.RecordDate := checked_RecordDate;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;
      SELF.DOB  := L.DOB;

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;


      SELF := IF (is_deleted, R, L);

    END;


  EXPORT layouts._lt_row_PersonSlimReportUtility ProcessTxRow(layouts._lt_row_PersonSlimReportUtility L, layouts._lt_row_PersonSlimReportUtility R, integer1 joinRowType) :=TRANSFORM
    boolean is_deleted := joinRowType = DiffStatus.JoinRowType.OuterRight;
    boolean is_added := joinRowType = DiffStatus.JoinRowType.OuterLeft;
    m := DiffScalars(L, R, is_deleted, is_added);

    SELF._diff := IF(is_active, m._diff, '');
    SELF._diffmeta := IF(is_active, m._diffmeta);
         SELF.ConnectDate  := L.ConnectDate;
      SELF.DateFirstSeen  := L.DateFirstSeen;

      path_RecordDate := path + '/RecordDate';
    
      updated_RecordDate := _df_Date(is_active, path_RecordDate).AsRecord(L.RecordDate, R.RecordDate);
        
      checked_RecordDate := MAP (is_deleted => R.RecordDate,
                              is_added => L.RecordDate,
                              updated_RecordDate);
      SELF.RecordDate := checked_RecordDate;

      path_Name := path + '/Name';
    
      updated_Name := _df_Name(is_active, path_Name).AsRecord(L.Name, R.Name);
        
      checked_Name := MAP (is_deleted => R.Name,
                              is_added => L.Name,
                              updated_Name);
      SELF.Name := checked_Name;
      SELF.DOB  := L.DOB;

      updated_Addresses := _df_Address(is_active, path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);
      checked_Addresses := MAP (is_deleted => R.Addresses,
                              is_added => L.Addresses,
                              updated_Addresses);
      SELF.Addresses  := checked_Addresses;

    SELF._diff_ord := IF (is_deleted, R._diff_ord, L._diff_ord);
    SELF := IF (is_deleted, R, L);

  END;


  EXPORT AsRecord (layouts._lt_PersonSlimReportUtility _new, layouts._lt_PersonSlimReportUtility _old) := FUNCTION
    RETURN ROW (ProcessTx(_new, _old, false, false));
  END;
  
  EXPORT  integer1 CheckOuter_recorddate_dayrecorddate_monthrecorddate_yearutiltype(layouts._lt_PersonSlimReportUtility L, layouts._lt_PersonSlimReportUtility R) := FUNCTION
    boolean IsInner :=  (L.UtilType = R.UtilType AND L.RecordDate.Year = R.RecordDate.Year AND L.RecordDate.Day = R.RecordDate.Day AND L.RecordDate.Month = R.RecordDate.Month);

    boolean IsOuterRight :=   (L.UtilType = '' AND L.RecordDate.Year = 0 AND L.RecordDate.Day = 0 AND L.RecordDate.Month = 0);
    return IF (IsInner, DiffStatus.JoinRowType.IsInner, IF (IsOuterRight, DiffStatus.JoinRowType.OuterRight, DiffStatus.JoinRowType.OuterLeft));
  END;
  EXPORT  AsDataset_recorddate_dayrecorddate_monthrecorddate_yearutiltype (dataset(layouts._lt_PersonSlimReportUtility) _n, dataset(layouts._lt_PersonSlimReportUtility) _o) := FUNCTION

    _new := PROJECT (_n, TRANSFORM (layouts._lt_row_PersonSlimReportUtility, SELF._diff_ord := COUNTER, SELF := LEFT));
    _old := PROJECT (_o, TRANSFORM (layouts._lt_row_PersonSlimReportUtility, SELF._diff_ord := 10000 + COUNTER, SELF := LEFT));
    ActiveJoin := JOIN (_new, _old,
                  LEFT.UtilType = RIGHT.UtilType AND LEFT.RecordDate.Year = RIGHT.RecordDate.Year AND LEFT.RecordDate.Day = RIGHT.RecordDate.Day AND LEFT.RecordDate.Month = RIGHT.RecordDate.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_recorddate_dayrecorddate_monthrecorddate_yearutiltype(LEFT, RIGHT)),
                  FULL OUTER,
                  LIMIT (0));
    PassiveJoin := JOIN (_new, _old,
                  LEFT.UtilType = RIGHT.UtilType AND LEFT.RecordDate.Year = RIGHT.RecordDate.Year AND LEFT.RecordDate.Day = RIGHT.RecordDate.Day AND LEFT.RecordDate.Month = RIGHT.RecordDate.Month,
                  ProcessTxRow (LEFT, RIGHT,
                  CheckOuter_recorddate_dayrecorddate_monthrecorddate_yearutiltype(LEFT, RIGHT)),
                  LEFT OUTER,
                  LIMIT (0));
    RETURN PROJECT(SORT(IF (is_active, ActiveJoin, PassiveJoin), _diff_ord), layouts._lt_PersonSlimReportUtility);
  END;
  
END;

EXPORT _df_PersonSlimReportResponse(boolean is_active, string path) := MODULE
  EXPORT layouts._lt_PersonSlimReportResponse ProcessTx(layouts._lt_PersonSlimReportResponse L, layouts._lt_PersonSlimReportResponse R) :=TRANSFORM

  
      SELF._Header := L._Header;
  
      SELF.UniqueId := L.UniqueId;

      SELF.Addresses  := _df_PersonSlimReportAddress(CASE(path + '/Addresses', '/Addresses' => (MonitorAddress), is_active), path + '/Addresses/Address').AsDataset_citystatestreetnamestreetnumberunitnumberzip5(L.Addresses, R.Addresses);

      SELF.Names  := _df_PersonSlimReportName(CASE(path + '/Names', '/Names' => (MonitorName), is_active), path + '/Names/Name').AsDataset_firstlast(L.Names, R.Names);

      SELF.Phones  := _df_PersonSlimReportPhone(CASE(path + '/Phones', '/Phones' => (MonitorPhones), is_active), path + '/Phones/Entry').AsDataset_phone(L.Phones, R.Phones);

      SELF.Deaths  := _df_PersonSlimReportDeath(CASE(path + '/Deaths', '/Deaths' => (MonitorDeath), is_active), path + '/Deaths/Death').AsDataset_daymonthyear(L.Deaths, R.Deaths);

      SELF.DOBs  := _df_PersonSlimReportDOB(CASE(path + '/DOBs', '/DOBs' => (MonitorDOB), is_active), path + '/DOBs/DOB').AsDataset_daymonthyear(L.DOBs, R.DOBs);

      SELF.SSNs  := _df_PersonSlimReportSSN(CASE(path + '/SSNs', '/SSNs' => (MonitorSSNs), is_active), path + '/SSNs/Entry').AsDataset_ssn(L.SSNs, R.SSNs);

      SELF.ProfessionalLicenses  := _df_ProfessionalLicenseRecord(CASE(path + '/ProfessionalLicenses', '/ProfessionalLicenses' => (MonitorProfessionalLicense), is_active), path + '/ProfessionalLicenses/ProfessionalLicense').AsDataset_licensenumbersourcestate(L.ProfessionalLicenses, R.ProfessionalLicenses);

      SELF.PeopleAtWorks  := _df_PeopleAtWorkRecord(CASE(path + '/PeopleAtWorks', '/PeopleAtWorks' => (MonitorPeopleAtWork), is_active), path + '/PeopleAtWorks/PeopleAtWork').AsDataset_businessids_orgidbusinessids_seleidbusinessids_ultidcompanynametitle(L.PeopleAtWorks, R.PeopleAtWorks);

      SELF.Aircrafts  := _df_AircraftReportRecord(CASE(path + '/Aircrafts', '/Aircrafts' => (MonitorAircraft), is_active), path + '/Aircrafts/Aircraft').AsDataset_aircraftnumber(L.Aircrafts, R.Aircrafts);

      SELF.FAACertifications  := _df_BpsFAACertification(CASE(path + '/FAACertifications', '/FAACertifications' => (MonitorCertification), is_active), path + '/FAACertifications/Certification').AsDataset_address_countyaddress_state(L.FAACertifications, R.FAACertifications);

      SELF.WaterCrafts  := _df_WaterCraftReportRecord(CASE(path + '/WaterCrafts', '/WaterCrafts' => (MonitorWaterCraft), is_active), path + '/WaterCrafts/WaterCraft').AsDataset_hullnumberstateoforigin(L.WaterCrafts, R.WaterCrafts);

      SELF.UCCFilings  := _df_UCCReport2Record(CASE(path + '/UCCFilings', '/UCCFilings' => (MonitorUCCFiling), is_active), path + '/UCCFilings/UCCFiling').AsDataset_filingjurisdictionoriginfilingnumber(L.UCCFilings, R.UCCFilings);

      SELF.SexualOffenses  := _df_SexOffReportRecord(CASE(path + '/SexualOffenses', '/SexualOffenses' => (MonitorSexualOffense), is_active), path + '/SexualOffenses/SexualOffense').AsDataset_primarykey(L.SexualOffenses, R.SexualOffenses);

      SELF.Criminals  := _df_CrimReportRecord(CASE(path + '/Criminals', '/Criminals' => (MonitorCriminal), is_active), path + '/Criminals/Criminal').AsDataset_offenderid(L.Criminals, R.Criminals);

      SELF.WeaponPermits  := _df_WeaponRecord(CASE(path + '/WeaponPermits', '/WeaponPermits' => (MonitorWeaponPermit), is_active), path + '/WeaponPermits/WeaponPermit').AsDataset_permit_permitnumberpermit_permittypestatecode(L.WeaponPermits, R.WeaponPermits);

      SELF.HuntingFishingLicenses  := _df_HuntFishRecord(CASE(path + '/HuntingFishingLicenses', '/HuntingFishingLicenses' => (MonitorHuntingFishingLicense), is_active), path + '/HuntingFishingLicenses/HuntingFishingLicense').AsDataset_licensenumberlicensestatelicensetype(L.HuntingFishingLicenses, R.HuntingFishingLicenses);

      SELF.FirearmExplosives  := _df_FirearmRecord(CASE(path + '/FirearmExplosives', '/FirearmExplosives' => (MonitorFirearmExplosive), is_active), path + '/FirearmExplosives/FirearmExplosive').AsDataset_licenseissuestatelicensenumber(L.FirearmExplosives, R.FirearmExplosives);

      SELF.ControlledSubstances  := _df_DEAControlledSubstanceSearch2Record(CASE(path + '/ControlledSubstances', '/ControlledSubstances' => (MonitorControlledSubstance), is_active), path + '/ControlledSubstances/ControlledSubstance').AsDataset_registrationnumber(L.ControlledSubstances, R.ControlledSubstances);

      SELF.VoterRegistrations  := _df_VoterReport2Record(CASE(path + '/VoterRegistrations', '/VoterRegistrations' => (MonitorVoterRegistration), is_active), path + '/VoterRegistrations/VoterRegistration').AsDataset_registratestateresidentaddress_county(L.VoterRegistrations, R.VoterRegistrations);

      SELF.Drivers  := _df_DLEmbeddedReport2Record(CASE(path + '/Drivers', '/Drivers' => (MonitorDriver), is_active), path + '/Drivers/Driver').AsDataset_driverlicenseoriginstate(L.Drivers, R.Drivers);

      SELF.Vehicles  := _df_MotorVehicleReport2Record(CASE(path + '/Vehicles', '/Vehicles' => (MonitorVehicle), is_active), path + '/Vehicles/Vehicle').AsDataset_vehicleinfo_makevehicleinfo_modelvehicleinfo_vin(L.Vehicles, R.Vehicles);

      SELF.Accidents  := _df_AccidentReportRecord(CASE(path + '/Accidents', '/Accidents' => (MonitorAccident), is_active), path + '/Accidents/Accident').AsDataset_accidentdate_yearaccidentstateinvestigation_investigationagent_agentreportnumber(L.Accidents, R.Accidents);

      SELF.Bankruptcies  := _df_BankruptcyReport2Record(CASE(path + '/Bankruptcies', '/Bankruptcies' => (MonitorBankruptcy), is_active), path + '/Bankruptcies/Bankruptcy').AsDataset_casenumbercasetypefilingjurisdiction(L.Bankruptcies, R.Bankruptcies);

      SELF.LiensJudgments  := _df_LienJudgmentReportRecord(CASE(path + '/LiensJudgments', '/LiensJudgments' => (MonitorLienJudgment), is_active), path + '/LiensJudgments/LienJudgment').AsDataset_originfilingnumbertmsid(L.LiensJudgments, R.LiensJudgments);

      SELF.Properties  := _df_PropertyReport2Record(CASE(path + '/Properties', '/Properties' => (MonitorProperty), is_active), path + '/Properties/Property').AsDataset_parcelnumberrecordtype(L.Properties, R.Properties);

      SELF.MarriageDivorces  := _df_MarriageSearch2Record(CASE(path + '/MarriageDivorces', '/MarriageDivorces' => (MonitorMarriageDivorce), is_active), path + '/MarriageDivorces/MarriageDivorce').AsDataset_filingnumberfilingtypecodestateorigin(L.MarriageDivorces, R.MarriageDivorces);

      SELF.Educations  := _df_StudentRecord(CASE(path + '/Educations', '/Educations' => (MonitorEducation), is_active), path + '/Educations/Education').AsDataset_addressatcollege_stateaddressatcollege_zip5firstreported_dayfirstreported_monthfirstreported_year(L.Educations, R.Educations);

      SELF.AKAs  := _df_BpsReportIdentity(CASE(path + '/AKAs', '/AKAs' => (MonitorAKA), is_active), path + '/AKAs/AKA').AsDataset_name_firstname_lastssninfoex_ssn(L.AKAs, R.AKAs);

      SELF.Imposters  := _df_BpsReportIdentity(CASE(path + '/Imposters', '/Imposters' => (MonitorImposter), is_active), path + '/Imposters/Imposter').AsDataset_name_firstname_lastssninfoex_ssn(L.Imposters, R.Imposters);

      SELF.Utilities  := _df_PersonSlimReportUtility(CASE(path + '/Utilities', '/Utilities' => (MonitorUtility), is_active), path + '/Utilities/Utility').AsDataset_recorddate_dayrecorddate_monthrecorddate_yearutiltype(L.Utilities, R.Utilities);
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
  the_differenceModule := difference._df_PersonSlimReportResponseEx;
  the_requestLayout := request._lt_PersonSlimReportRequest;
  the_responseLayout := layouts._lt_PersonSlimReportResponseEx;


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

  soapoutRec := record (the_responseLayout)
    
    exceptionRec Exception {xpath('Exception')};
  end;

MonSoapcall(DATASET(the_requestLayout) req) := FUNCTION

  
  //ESP uses the request layout as is
  ds_request := req;

    


  // execute soapcall
  ar_results := SOAPCALL (ds_request,
                          serviceURL,
                          serviceName,
                          {ds_request},
                          DATASET (soapoutRec),
                          TIMEOUT(serviceTimeout), RETRY(serviceRetries), LITERAL, XPATH('*'));
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
  
    dataset(the_responseLayout) report;
  END;



DemoMonitor (string id, ROW(the_responseLayout) changedRow) := MODULE
  SHARED monitorId := id;
  SHARED monitorStore := getStoredMonitor(id);

  SHARED oldResponse := FROMXML (the_responseLayout, monitorStore.result);

  SHARED diff_result := the_differenceModule(false, '').AsRecord(changedRow, oldResponse);

  EXPORT MonitorResultRec BuildMonitor() :=TRANSFORM
    SELF.id := monitorId;
    SELF.report := diff_result;
  END;
  EXPORT Result () := FUNCTION
    RETURN ROW(BuildMonitor());
  END;
END;

  STRING changedXML := '' : STORED ('changed', FORMAT(FIELDWIDTH(100), FIELDHEIGHT(30), sequence(1002)));
  changedRow := FROMXML (the_responseLayout, changedXML);
  executedAction := DemoMonitor(monitorIdIn, changedRow).Result();
  

  output(executedAction.id, NAMED('MonitorId'));
  output(executedAction.report[1].response, NAMED('Result'));


  SelectorRec := RECORD
    string monitor {xpath('@monitor')};
    boolean active {xpath('@active')};
  END;

    OUTPUT(DATASET([{'Address', difference.MonitorAddress},{'Name', difference.MonitorName},{'Phones', difference.MonitorPhones},{'Death', difference.MonitorDeath},{'DOB', difference.MonitorDOB},{'SSNs', difference.MonitorSSNs},{'ProfessionalLicense', difference.MonitorProfessionalLicense},{'PeopleAtWork', difference.MonitorPeopleAtWork},{'Aircraft', difference.MonitorAircraft},{'Certification', difference.MonitorCertification},{'WaterCraft', difference.MonitorWaterCraft},{'UCCFiling', difference.MonitorUCCFiling},{'SexualOffense', difference.MonitorSexualOffense},{'Criminal', difference.MonitorCriminal},{'WeaponPermit', difference.MonitorWeaponPermit},{'HuntingFishingLicense', difference.MonitorHuntingFishingLicense},{'FirearmExplosive', difference.MonitorFirearmExplosive},{'ControlledSubstance', difference.MonitorControlledSubstance},{'VoterRegistration', difference.MonitorVoterRegistration},{'Driver', difference.MonitorDriver},{'Vehicle', difference.MonitorVehicle},{'Accident', difference.MonitorAccident},{'Bankruptcy', difference.MonitorBankruptcy},{'LienJudgment', difference.MonitorLienJudgment},{'Property', difference.MonitorProperty},{'MarriageDivorce', difference.MonitorMarriageDivorce},{'Education', difference.MonitorEducation},{'AKA', difference.MonitorAKA},{'Imposter', difference.MonitorImposter},{'Utility', difference.MonitorUtility}], SelectorRec), NAMED('Selected'));
  
ENDMACRO;
/*** Generated Code do not hand edit ***/
