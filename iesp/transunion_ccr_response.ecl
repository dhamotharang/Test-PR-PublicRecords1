/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from transunion_ccr_response.xml. ***/
/*===================================================*/

import iesp;

export transunion_ccr_response := MODULE

export t_TURespAddress := record //RecordCode[AD01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 AddressQualifier {xpath('AddressQualifier')};
	string1 AddressType {xpath('AddressType')};
	string10 HouseNumber {xpath('HouseNumber')};
	string2 PreDirectional {xpath('PreDirectional')};
	string27 StreetName {xpath('StreetName')};
	string2 PostDirectional {xpath('PostDirectional')};
	string2 StreetType {xpath('StreetType')};
	string5 AptUnitNumber {xpath('AptUnitNumber')};
	string27 CityName {xpath('CityName')};
	string2 StateCode {xpath('StateCode')};
	string10 ZipCode {xpath('ZipCode')};
	string8 DateReported {xpath('DateReported')};
end;

export t_TURespExtendedAddress := record //RecordCode[AD02]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 AddressQualifier {xpath('AddressQualifier')};
	string1 AddressType {xpath('AddressType')};
	string70 StreetAddress {xpath('StreetAddress')};
	string27 City {xpath('City')};
	string2 State {xpath('State')};
	string10 ZIPCode {xpath('ZIPCode')};
	string8 DateReported {xpath('DateReported')};
end;

export t_TURespAddressAnalysis := record //RecordCode[AM01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 InputAddressIndex {xpath('InputAddressIndex')};
	string2 FileAddressIndex {xpath('FileAddressIndex')};
	string1 HouseNumberMatch {xpath('HouseNumberMatch')};
	string1 PreDirectionalMatch {xpath('PreDirectionalMatch')};
	string1 StreetNameMatch {xpath('StreetNameMatch')};
	string1 StreetTypeMatch {xpath('StreetTypeMatch')};
	string1 Filler1 {xpath('Filler1')};
	string1 CityNameMatch {xpath('CityNameMatch')};
	string1 StateCodeMatch {xpath('StateCodeMatch')};
	string1 ZipCodeMatch {xpath('ZipCodeMatch')};
	string1 Filler2 {xpath('Filler2')};
	string1 Filler3 {xpath('Filler3')};
	string1 ApartmentNumberMatch {xpath('ApartmentNumberMatch')};
end;

export t_TURespAddOnStatus := record //RecordCode[AO01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string5 ServiceCode {xpath('ServiceCode')};
	string2 ServiceStatus {xpath('ServiceStatus')};
	string3 SearchStatus {xpath('SearchStatus')};
end;

export t_TURespAttributeSegment := record //RecordCode[AR01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string8 AttributeID {xpath('AttributeID')};
	string5 AttributeIndexID {xpath('AttributeIndexID')};
	string40 AttributeValue {xpath('AttributeValue')};
end;

export t_TURespBusinessRecord := record //RecordCode[BR01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string8 BusinessUpdateDate {xpath('BusinessUpdateDate')};
	string16 BusinessIdentifier {xpath('BusinessIdentifier')};
	string35 BusinessName {xpath('BusinessName')};
	string10 AddressNumber {xpath('AddressNumber')};
	string2 Predirectional {xpath('Predirectional')};
	string28 StreetName {xpath('StreetName')};
	string2 Postdirectional {xpath('Postdirectional')};
	string4 StreetTypeCode {xpath('StreetTypeCode')};
	string4 UnitType {xpath('UnitType')};
	string10 UnitNumber {xpath('UnitNumber')};
	string28 City {xpath('City')};
	string2 StataeCode {xpath('StataeCode')};
	string5 ZIPCode {xpath('ZIPCode')};
	string4 ZIPExtension {xpath('ZIPExtension')};
	string16 ExecutiveID {xpath('ExecutiveID')};
	string2 DataSourceID {xpath('DataSourceID')};
	string1 TopFirmIndicator {xpath('TopFirmIndicator')};
	string1 HomeBasedIndicator {xpath('HomeBasedIndicator')};
	string1 CorporateEntityType {xpath('CorporateEntityType')};
	string1 LocationStatus {xpath('LocationStatus')};
	string1 OwnershipType {xpath('OwnershipType')};
	string4 YearCompanyEstablished {xpath('YearCompanyEstablished')};
	string2 MatchType {xpath('MatchType')};
	string3 ConfidenceScore {xpath('ConfidenceScore')};
	string8 PrimarySIC {xpath('PrimarySIC')};
	string8 SecondarySIC {xpath('SecondarySIC')};
	string8 ThirdSIC {xpath('ThirdSIC')};
	string8 FourthSIC {xpath('FourthSIC')};
	string8 FifthSIC {xpath('FifthSIC')};
	string8 SixthSIC {xpath('SixthSIC')};
	string8 SeventhSIC {xpath('SeventhSIC')};
	string12 TotalSales {xpath('TotalSales')};
	string12 SalesByLocation {xpath('SalesByLocation')};
	string12 TotalNumberOfEmployees {xpath('TotalNumberOfEmployees')};
	string12 NumberOfEmployeesByLocation {xpath('NumberOfEmployeesByLocation')};
	string6 PrimaryNAICS {xpath('PrimaryNAICS')};
	string6 SecondaryNAICS {xpath('SecondaryNAICS')};
	string6 ThirdNAICS {xpath('ThirdNAICS')};
	string1 SoleProprietorshipIndicator {xpath('SoleProprietorshipIndicator')};
	string8 RevenueGrowth {xpath('RevenueGrowth')};
	string10 ClosedDate {xpath('ClosedDate')};
end;

export t_TURespCreditCard := record //RecordCode[CC01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 CreditCardType {xpath('CreditCardType')};
	string24 CreditCardNumber {xpath('CreditCardNumber')};
	string8 ExpirationDate {xpath('ExpirationDate')};
end;

export t_TURespCustomerData := record //RecordCode[CD01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 CustomerIdentifierQualifier {xpath('CustomerIdentifierQualifier')};
	string20 CustomerIdentifier {xpath('CustomerIdentifier')};
	string4 Reserved {xpath('Reserved')};
	string8 Filler {xpath('Filler')};
end;

export t_TURespCharacteristic := record //RecordCode[CH01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string5 ServiceCode {xpath('ServiceCode')};
	string8 CharacteristicID {xpath('CharacteristicID')};
	string10 CharacteristicValue {xpath('CharacteristicValue')};
end;

export t_TURespConsumerIdentifier := record //RecordCode[CI01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string12 ConsumerIdentifier {xpath('ConsumerIdentifier')};
end;

export t_TURespCollection := record //RecordCode[CL01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 IndustryCode {xpath('IndustryCode')};
	string8 MemberCode {xpath('MemberCode')};
	string24 CollectionAgencyName {xpath('CollectionAgencyName')};
	string1 AccountType {xpath('AccountType')};
	string24 AccountNumber {xpath('AccountNumber')};
	string1 AccountDesignator {xpath('AccountDesignator')};
	string36 CreditorsName {xpath('CreditorsName')};
	string8 DateOpened {xpath('DateOpened')};
	string8 DateVerified {xpath('DateVerified')};
	string1 VerificationIndicator {xpath('VerificationIndicator')};
	string8 DateClosed {xpath('DateClosed')};
	string1 DateClosedIndicator {xpath('DateClosedIndicator')};
	string8 DatePaidOut {xpath('DatePaidOut')};
	string2 CurrentMannerOfPayment {xpath('CurrentMannerOfPayment')};
	string9 CurrentBalance {xpath('CurrentBalance')};
	string9 OriginalBalance {xpath('OriginalBalance')};
	string3 RemarksCode {xpath('RemarksCode')};
end;

export t_TURespCORR := record //RecordCode[CORR]
	string4 RecordCode {xpath('RecordCode')};
	string1 VersionSwitch {xpath('VersionSwitch')};
	string24 UserReferenceNumber {xpath('UserReferenceNumber')};
	string1 FirstOrSecondInquiryError {xpath('FirstOrSecondInquiryError')};
	string3 FirstErrorCondition {xpath('FirstErrorCondition')};
	string3 SecondErrorCondition {xpath('SecondErrorCondition')};
	string3 ThirdErrorCondition {xpath('ThirdErrorCondition')};
	string3 FourthErrorCondition {xpath('FourthErrorCondition')};
	string3 FifthErrorCondition {xpath('FifthErrorCondition')};
end;

export t_CountyInfo := record //RecordCode[CO01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 SourceQualifier {xpath('SourceQualifier')};
	string28 CityName {xpath('CityName')};
	string2 StateCode {xpath('StateCode')};
	string25 County {xpath('County')};
	string1 CountyType {xpath('CountyType')};
end;

export t_Compliance := record //RecordCode[CP01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 InfoType {xpath('InfoType')};
	string24 SubscriberOrSourceName {xpath('SubscriberOrSourceName')};
	string24 AccountOrDocketNumber {xpath('AccountOrDocketNumber')};
	string3 RecordTypeCode {xpath('RecordTypeCode')};
	string36 Remarks {xpath('Remarks')};
end;

export t_ContactResult := record //RecordCode[CR01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string3 ListingIndicator {xpath('ListingIndicator')};
	string2 ListingType {xpath('ListingType')};
	string2 MatchCode {xpath('MatchCode')};
	string3 PhoneStatusCode {xpath('PhoneStatusCode')};
	string8 ListingCreateDate {xpath('ListingCreateDate')};
	string1 PhoneAvailabilityIndicator {xpath('PhoneAvailabilityIndicator')};
end;

export t_TURespConsumerStatement := record //RecordCode[CS01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 ContentType {xpath('ContentType')};
	string100 Info {xpath('Info')};
end;

export t_TURespDataAnalysis := record //RecordCode[DA01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 IdOrCustomerNumber {xpath('IdOrCustomerNumber')};
	string2 InvalidFormat {xpath('InvalidFormat')};
	string1 SoundexCheck {xpath('SoundexCheck')};
	string1 LastNameCheck {xpath('LastNameCheck')};
	string1 FirstNameCheck {xpath('FirstNameCheck')};
	string1 MiddleNameCheck {xpath('MiddleNameCheck')};
	string1 SSNCheck {xpath('SSNCheck')};
	string1 DOBCheck {xpath('DOBCheck')};
	string1 GenderCheck {xpath('GenderCheck')};
	string1 EyeColorCheck {xpath('EyeColorCheck')};
	string1 ExpirationDateCheck {xpath('ExpirationDateCheck')};
	string2 MatchEvaluation {xpath('MatchEvaluation')};
end;

export t_TURespDecisionSystemsCustomerBranch := record //RecordCode[DB01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string10 BranchID {xpath('BranchID')};
	string2 BranchType {xpath('BranchType')};
	string20 ClientUse1 {xpath('ClientUse1')};
	string20 ClientUse2 {xpath('ClientUse2')};
end;

export t_TURespDeceasedInfo := record //RecordCode[DC01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string6 MessageCode {xpath('MessageCode')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string15 LastName {xpath('LastName')};
	string15 FirstName {xpath('FirstName')};
	string27 CityLastResidency {xpath('CityLastResidency')};
	string2 StateLastResidency {xpath('StateLastResidency')};
	string10 ZIPCodeLastResidency {xpath('ZIPCodeLastResidency')};
	string27 CityLocationOfPayments {xpath('CityLocationOfPayments')};
	string2 StateLocationOfPayments {xpath('StateLocationOfPayments')};
	string10 ZIPLocationOfPayments {xpath('ZIPLocationOfPayments')};
	string8 DateOfBirthOfDeceased {xpath('DateOfBirthOfDeceased')};
	string8 DateOfDeath {xpath('DateOfDeath')};
	string1 DeceasedInfoFileSearched {xpath('DeceasedInfoFileSearched')};
end;

export t_TURespDecisionSystemsCustomInfo := record //RecordCode[DI01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 InputType {xpath('InputType')};
	string24 CustomInput {xpath('CustomInput')};
end;

export t_TURespDecisionSystemsResponse := record //RecordCode[DR01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string12 ReferenceNumber {xpath('ReferenceNumber')};
	string1 DecisionClass {xpath('DecisionClass')};
	string10 DecisionText {xpath('DecisionText')};
	string2 Level {xpath('Level')};
	string1 LevelCode {xpath('LevelCode')};
	string14 Timestamp {xpath('Timestamp')};
	string2 MaximumLevel {xpath('MaximumLevel')};
	string44 LevelReasons {xpath('LevelReasons')};
	string44 DSReasons {xpath('DSReasons')};
	string9 CreditLimit {xpath('CreditLimit')};
	string1 BureauID {xpath('BureauID')};
	string3 CreditBureauErrorCode {xpath('CreditBureauErrorCode')};
	string1 AddressMismatchAlert {xpath('AddressMismatchAlert')};
	string1 FraudAlert {xpath('FraudAlert')};
	string1 CreditDataStatus {xpath('CreditDataStatus')};
	string24 AccountNumber {xpath('AccountNumber')};
	string6 CriteriaName {xpath('CriteriaName')};
	string10 SpecialUse {xpath('SpecialUse')};
end;

export t_TURespEdit := record //RecordCode[ED01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SubjectIdentifier {xpath('SubjectIdentifier')};
	string50 OriginalValue {xpath('OriginalValue')};
	string3 EditCodeNumber {xpath('EditCodeNumber')};
end;

export t_TURespExtendedFields := record //RecordCode[EF01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string3 ListingIndicator {xpath('ListingIndicator')};
	string2 DeliveryPoint {xpath('DeliveryPoint')};
	string1 CheckDigit {xpath('CheckDigit')};
	string12 Latitude {xpath('Latitude')};
	string12 Longitude {xpath('Longitude')};
	string2 CongressionalDistrict {xpath('CongressionalDistrict')};
	string4 CarrierRoute {xpath('CarrierRoute')};
	string1 SortZone {xpath('SortZone')};
	string5 FIPS {xpath('FIPS')};
	string2 LineType {xpath('LineType')};
	string5 MSAOrMDCoder {xpath('MSAOrMDCoder')};
	string5 CMSA {xpath('CMSA')};
end;

export t_TURespEmployment := record //RecordCode[EM01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string35 EmployerName {xpath('EmployerName')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string22 Occupation {xpath('Occupation')};
	string8 DateHired {xpath('DateHired')};
	string8 DateSeparated {xpath('DateSeparated')};
	string8 DateVerifiedOrReported {xpath('DateVerifiedOrReported')};
	string1 DateVerifiedReportedCode {xpath('DateVerifiedReportedCode')};
	string9 Income {xpath('Income')};
	string1 PayBasis {xpath('PayBasis')};
end;

export t_TURespEnds := record //RecordCode[ENDS]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string3 TotalNumberOfSegments {xpath('TotalNumberOfSegments')};
end;

export t_TURespErrorCode := record //RecordCode[ERRC]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SubjectIdentifier {xpath('SubjectIdentifier')};
	string3 ErrorCodeNumber {xpath('ErrorCodeNumber')};
end;

export t_TURespErrorText := record //RecordCode[ERRT]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SubjectIdentifier {xpath('SubjectIdentifier')};
	string3 ErrorCodeNumber {xpath('ErrorCodeNumber')};
	string79 ErrorDescription {xpath('ErrorDescription')};
end;

export t_TURespFutureAddress := record //RecordCode[FA01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 AddressQualifier {xpath('AddressQualifier')};
	string1 Filler1 {xpath('Filler1')};
	string10 HouseNumber {xpath('HouseNumber')};
	string2 Predirectional {xpath('Predirectional')};
	string27 StreetName {xpath('StreetName')};
	string2 Postdirectional {xpath('Postdirectional')};
	string2 StreetType {xpath('StreetType')};
	string5 ApartmentNumber {xpath('ApartmentNumber')};
	string27 City {xpath('City')};
	string2 State {xpath('State')};
	string10 ZIPCode {xpath('ZIPCode')};
	string8 DateReported {xpath('DateReported')};
end;

export t_TURespCollectionCreditReportSpecialIndicators := record //RecordCode[FI01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SubjectDeceased {xpath('SubjectDeceased')};
	string1 LastActivityType {xpath('LastActivityType')};
	string8 DateOfLastActivity {xpath('DateOfLastActivity')};
	string3 NumberOfTrades {xpath('NumberOfTrades')};
	string3 NumberOfInquiries {xpath('NumberOfInquiries')};
end;

export t_TURespCollectionCreditReport := record //RecordCode[FT01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string12 SubscriberShortName {xpath('SubscriberShortName')};
	string3 SubscriberAreaCode {xpath('SubscriberAreaCode')};
	string7 SubscriberPhoneNumber {xpath('SubscriberPhoneNumber')};
	string1 AccountType {xpath('AccountType')};
	string30 AccountNumber {xpath('AccountNumber')};
	string8 DateOfLastActivity {xpath('DateOfLastActivity')};
	string3 TradeStatus {xpath('TradeStatus')};
	string9 AvailableCredit {xpath('AvailableCredit')};
	string1 NewTradeIndicator {xpath('NewTradeIndicator')};
	string3 DebtCounselingIndicator {xpath('DebtCounselingIndicator')};
end;

export t_TURespGEOCode := record //RecordCode[GC01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 AddressIndicator {xpath('AddressIndicator')};
	string9 ZIPCode {xpath('ZIPCode')};
	string2 GEOStatus {xpath('GEOStatus')};
	string2 Filler {xpath('Filler')};
	string5 MSAOrMDCode {xpath('MSAOrMDCode')};
	string2 StateCode {xpath('StateCode')};
	string3 CountyCode {xpath('CountyCode')};
	string4 CensusTractCode {xpath('CensusTractCode')};
	string2 CensusTractSuffix {xpath('CensusTractSuffix')};
	string1 BlockCode {xpath('BlockCode')};
	string8 Latitude {xpath('Latitude')};
	string8 Longitude {xpath('Longitude')};
end;

export t_TURespIdentification := record //RecordCode[ID01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 IDType {xpath('IDType')};
	string30 IDNumber {xpath('IDNumber')};
	string8 DateOfExpiration {xpath('DateOfExpiration')};
	string2 StateOfIssuance {xpath('StateOfIssuance')};
end;

export t_TURespInquiry := record //RecordCode[IN01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 BureauMarket {xpath('BureauMarket')};
	string2 BureauSubmarket {xpath('BureauSubmarket')};
	string2 IndustryCode {xpath('IndustryCode')};
	string8 MemberCode {xpath('MemberCode')};
	string24 SubscriberName {xpath('SubscriberName')};
	string1 InquiryType {xpath('InquiryType')};
	string2 LoanType {xpath('LoanType')};
	string9 LoanAmount {xpath('LoanAmount')};
	string8 DateOfInquiry {xpath('DateOfInquiry')};
end;

export t_TURespCollectionCreditReportInquiry := record //RecordCode[IN02]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string24 SubscriberName {xpath('SubscriberName')};
	string3 SubscriberAreaCode {xpath('SubscriberAreaCode')};
	string7 SubscriberPhoneNumber {xpath('SubscriberPhoneNumber')};
	string5 Extension {xpath('Extension')};
	string2 LoanType {xpath('LoanType')};
	string8 DateOfInquiry {xpath('DateOfInquiry')};
end;

export t_TURespCreditorContactInfo := record //RecordCode[LK01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 SegmentDecoded {xpath('SegmentDecoded')};
	string2 BureauMarket {xpath('BureauMarket')};
	string2 BureauSubmarket {xpath('BureauSubmarket')};
	string2 IndustryCode {xpath('IndustryCode')};
	string8 MemberCode {xpath('MemberCode')};
	string24 SubscriberName {xpath('SubscriberName')};
	string1 MethodOfContact {xpath('MethodOfContact')};
end;

export t_TURespLocatorService := record //RecordCode[LS01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 SearchType {xpath('SearchType')};
	string3 SearchResult {xpath('SearchResult')};
	string2 RecordCount {xpath('RecordCount')};
end;

export t_TURespMessageCode := record //RecordCode[MC01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string6 MessageCode {xpath('MessageCode')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 AddressMatchFlag {xpath('AddressMatchFlag')};
	string1 NumberIndicator {xpath('NumberIndicator')};
	string10 Number {xpath('Number')};
	string3 ThresholdNumber {xpath('ThresholdNumber')};
end;

export t_TURespMiscStatement := record //RecordCode[MI01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string70 Info {xpath('Info')};
end;

export t_TURespMileage := record //RecordCode[ML01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string8 MaxMileage {xpath('MaxMileage')};
	string1 MaxMileageIndicator {xpath('MaxMileageIndicator')};
	string8 MinMileage {xpath('MinMileage')};
	string1 MinMileageIndicator {xpath('MinMileageIndicator')};
end;

export t_TURespMileage2 := record //RecordCode[ML02]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string8 HomeVsBusinessPhoneMileage {xpath('HomeVsBusinessPhoneMileage')};
	string8 HomePhoneVsBusinessZIPCodeMileage {xpath('HomePhoneVsBusinessZIPCodeMileage')};
	string8 HomeZIPCodeVsBusinessPhoneMileage {xpath('HomeZIPCodeVsBusinessPhoneMileage')};
	string8 HomeVsBusinessZIPCodeMileage {xpath('HomeVsBusinessZIPCodeMileage')};
end;

export t_TURespMessageText := record //RecordCode[MT01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string6 MessageCode {xpath('MessageCode')};
	string3 ActualMessageLength {xpath('ActualMessageLength')};
	string1 CurrentSegmentNumber {xpath('CurrentSegmentNumber')};
	string1 TotalSegmentNumber {xpath('TotalSegmentNumber')};
	string3 ThresholdNumber {xpath('ThresholdNumber')};
	string150 MessageText {xpath('MessageText')};
end;

export t_TURespUnparsedName := record //RecordCode[NM01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 NameIndicator {xpath('NameIndicator')};
	string61 UnparsedName {xpath('UnparsedName')};
end;

export t_TURespName := record //RecordCode[NM01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 NameIndicator {xpath('NameIndicator')};
	string25 LastName {xpath('LastName')};
	string15 FirstName {xpath('FirstName')};
	string15 MiddleName {xpath('MiddleName')};
	string3 Prefix {xpath('Prefix')};
	string3 Suffix {xpath('Suffix')};
end;

export t_TURespNumberOf := record //RecordCode[NU01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 NumberType {xpath('NumberType')};
	string3 Number {xpath('Number')};
end;

export t_TURespOwningBureauIdentification := record //RecordCode[OB01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string50 BureauName {xpath('BureauName')};
	string40 BureauAddress {xpath('BureauAddress')};
	string29 BureauCityStateZIP {xpath('BureauCityStateZIP')};
	string22 BureauTelephoneNumber {xpath('BureauTelephoneNumber')};
end;

export t_TURespOwningBureauIdentification2 := record //RecordCode[OB02]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string50 BureauName {xpath('BureauName')};
	string40 BureauAddress {xpath('BureauAddress')};
	string29 BureauCityStateZIP {xpath('BureauCityStateZIP')};
	string22 BureauTelephoneNumber {xpath('BureauTelephoneNumber')};
	string50 AdverseActionURL {xpath('AdverseActionURL')};
end;

export t_TURespPropertyData := record //RecordCode[PD01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string50 APN {xpath('APN')};
	string5 FIPSCode {xpath('FIPSCode')};
	string11 SalePrice {xpath('SalePrice')};
	string8 SaleDate {xpath('SaleDate')};
	string8 RecordedDate {xpath('RecordedDate')};
	string11 CalculatedValue {xpath('CalculatedValue')};
end;

export t_TURespServiceHeader := record //RecordCode[PH01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string5 ServiceCode {xpath('ServiceCode')};
end;

export t_TURespServiceHeader2 := record //RecordCode[PH02]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string5 ServiceCode {xpath('ServiceCode')};
	string3 ServiceResults {xpath('ServiceResults')};
end;

export t_TURespServiceHeader3 := record //RecordCode[PH03]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string5 ServiceCode {xpath('ServiceCode')};
	string1 ServiceResult1PhoneStatus {xpath('ServiceResult1PhoneStatus')};
	string1 ServiceResult2AddressStatus {xpath('ServiceResult2AddressStatus')};
	string1 ServiceResult3AddressType {xpath('ServiceResult3AddressType')};
end;

export t_TURespServiceHeader4 := record //RecordCode[PH04]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string5 ServiceCode {xpath('ServiceCode')};
	string3 TotalListingsReturned {xpath('TotalListingsReturned')};
	string3 TotalListingsFound {xpath('TotalListingsFound')};
end;

export t_TURespPersonalInfo := record //RecordCode[PI01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string9 SocialSecurityNumber {xpath('SocialSecurityNumber')};
	string8 DateOfBirth {xpath('DateOfBirth')};
	string3 Age {xpath('Age')};
	string1 Gender {xpath('Gender')};
end;

export t_TURespPhoneNumber := record //RecordCode[PN01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string1 SourceIndicator {xpath('SourceIndicator')};
	string1 PhoneQualifier {xpath('PhoneQualifier')};
	string2 PhoneType {xpath('PhoneType')};
	string1 AvailabilityIndicator {xpath('AvailabilityIndicator')};
	string3 AreaCode {xpath('AreaCode')};
	string7 TelephoneNumber {xpath('TelephoneNumber')};
	string5 Extension {xpath('Extension')};
end;

export t_TURespPublicRecord := record //RecordCode[PR01]
	string4 RecordCode {xpath('RecordCode')};
	string3 Length {xpath('Length')};
	string2 IndustryCode {xpath('IndustryCode')};
	string8 MemberCode {xpath('MemberCode')};
	string2 PublicRecordType {xpath('PublicRecordType')};
	string11 DocketNumber {xpath('DocketNumber')};
	string36 Attorney {xpath('Attorney')};
	string36 Plaintiff {xpath('Plaintiff')};
	string8 DateFiled {xpath('DateFiled')};
	string8 DatePaid {xpath('DatePaid')};
	string9 Assets {xpath('Assets')};
	string9 LiabilitiesAmount {xpath('LiabilitiesAmount')};
	string1 AccountDesignator {xpath('AccountDesignator')};
	string2 CourtType {xpath('CourtType')};
	string27 CourtLocationCity {xpath('CourtLocationCity')};
	string2 CourtLocationState {xpath('CourtLocationState')};
end;


end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from transunion_ccr_response.xml. ***/
/*===================================================*/

