/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from duediligenceshared.xml. ***/
/*===================================================*/

import iesp;

export duediligenceshared := MODULE
			
export t_DDRPersonNameWithLexID := record
	iesp.share.t_Name Name {xpath('Name')};
	string LexID {xpath('LexID')};
end;
		
export t_DDRYearMakeModel := record
	string4 Year {xpath('Year')};
	string Make {xpath('Make')};
	string Model {xpath('Model')};
end;
		
export t_DDRVINNumber := record
	string VIN {xpath('VIN')};
end;
		
export t_DDRAdditionalDetails := record
	string DetailType {xpath('DetailType')};
end;
		
export t_DDRTitleInfo := record
	string2 State {xpath('State')};
	iesp.share.t_Date Date {xpath('Date')};
end;
		
export t_DDRRegistration := record
	string2 State {xpath('State')};
	iesp.share.t_Date Date {xpath('Date')};
end;
		
export t_DDRMotorVehicle := record
	t_DDRYearMakeModel Vehicle {xpath('Vehicle')};
	t_DDRAdditionalDetails LicensePlateType {xpath('LicensePlateType')};
	t_DDRAdditionalDetails ClassType {xpath('ClassType')};
	integer3 BasePrice {xpath('BasePrice')};
	t_DDRVINNumber MotorVehicle {xpath('MotorVehicle')};
	t_DDRTitleInfo Title {xpath('Title')};
	t_DDRRegistration Registration {xpath('Registration')};
end;
		
export t_DDRAreaRisk := record
	boolean Hifca {xpath('Hifca')};
	boolean Hidta {xpath('Hidta')};
	string CrimeIndex {xpath('CrimeIndex')};
end;
		
export t_DDRCountyCityRisk := record
	string CountyName {xpath('CountyName')};
	boolean BordersForeignJurisdiction {xpath('BordersForeignJurisdiction')};
	boolean BordersOceanWithin150ForeignJurisdiction {xpath('BordersOceanWithin150ForeignJurisdiction')};
	boolean AccessThroughBorderStation {xpath('AccessThroughBorderStation')};
	boolean AccessThroughRailCrossing {xpath('AccessThroughRailCrossing')};
	boolean AccessThroughFerryCrossing {xpath('AccessThroughFerryCrossing')};
end;
		
export t_DDROwnershipDetails := record
	iesp.share.t_Date PurchaseDate {xpath('PurchaseDate')};
	integer2 LengthofOwnership {xpath('LengthofOwnership')};
	integer8 PurchasePrice {xpath('PurchasePrice')};
end;
		
export t_DDRTaxAssessmentValues := record
	iesp.share.t_Date TaxYear {xpath('TaxYear')};
	integer8 TaxPrice {xpath('TaxPrice')};
end;
		
export t_DDRTenant := record
	string LexID {xpath('LexID')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DateOfBirth {xpath('DateOfBirth')};
end;
		
export t_DDRProperty := record
	iesp.share.t_Address Address {xpath('Address')};
	string45 BusinessAddressType {xpath('BusinessAddressType')};
	iesp.share.t_Name OwnerName {xpath('OwnerName')};
	string1 OwnerOccupied {xpath('OwnerOccupied')};
	t_DDROwnershipDetails Ownership {xpath('Ownership')};
	t_DDRTaxAssessmentValues Assessment {xpath('Assessment')};
	t_DDRAreaRisk AreaRisk {xpath('AreaRisk')};
	t_DDRCountyCityRisk CountyCityRisk {xpath('CountyCityRisk')};
	dataset(t_DDRTenant) ResidentTenants {xpath('ResidentTenants/ResidentTenant'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxTenants)};
end;
		
export t_DDRAircraft := record
	t_DDRYearMakeModel YearMakeModel {xpath('YearMakeModel')};
	t_DDRAdditionalDetails AdditionalDetails {xpath('AdditionalDetails')};
	integer1 NumberOfEngines {xpath('NumberOfEngines')};
	string50 TailNumber {xpath('TailNumber')};
	t_DDRVINNumber Aircraft {xpath('Aircraft')};
	iesp.share.t_Date RegistrationDate {xpath('RegistrationDate')};
end;
		
export t_DDRWatercraft := record
	t_DDRYearMakeModel YearMakeModel {xpath('YearMakeModel')};
	t_DDRAdditionalDetails VesselType {xpath('VesselType')};
	t_DDRTitleInfo Title {xpath('Title')};
	t_DDRRegistration Registration {xpath('Registration')};
	integer2 LengthInches {xpath('LengthInches')};
	integer2 LengthFeet {xpath('LengthFeet')};
	t_DDRVINNumber VINNumber {xpath('VINNumber')};
	string25 Propulsion {xpath('Propulsion')};
end;
		
export t_DDRLegalEventIndividual := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string LexID {xpath('LexID')};
end;
		
export t_DDRLegalEventCriminal := record
	string LegalEventType {xpath('LegalEventType')};
	string1 Conviction {xpath('Conviction')};
	string1 TrafficRelated {xpath('TrafficRelated')};
	string CaseNumber {xpath('CaseNumber')};
	string CourtType {xpath('CourtType')};
	string CaseTypeDescription {xpath('CaseTypeDescription')};
	string1 OffenseScore {xpath('OffenseScore')};
	string OffenseScoreDescription {xpath('OffenseScoreDescription')};
	string OffenseLevel {xpath('OffenseLevel')};
	string OffenseLevelDescription {xpath('OffenseLevelDescription')};
	string ArrestLevelDescription {xpath('ArrestLevelDescription')};
	string CourtStatute {xpath('CourtStatute')};
	string CourtStatuteDescription {xpath('CourtStatuteDescription')};
	string Charge {xpath('Charge')};
	string3 NumberOfCounts {xpath('NumberOfCounts')};
	string DispositionDescription1 {xpath('DispositionDescription1')};
	string DispositionDescription2 {xpath('DispositionDescription2')};
	string ProbationSentence {xpath('ProbationSentence')};
	boolean Incarceration {xpath('Incarceration')};
	boolean CurrentIncarceration {xpath('CurrentIncarceration')};
	boolean CurrentParole {xpath('CurrentParole')};
	boolean CurrentProbation {xpath('CurrentProbation')};
	iesp.share.t_Date EarliestOffenseDate {xpath('EarliestOffenseDate')};
	iesp.share.t_Date OffenseDate {xpath('OffenseDate')};
	iesp.share.t_Date ArrestDate {xpath('ArrestDate')};
	iesp.share.t_Date CourtDispositionDate {xpath('CourtDispositionDate')};
	iesp.share.t_Date SentenceDate {xpath('SentenceDate')};
	iesp.share.t_Date AppealDate {xpath('AppealDate')};
	iesp.share.t_Date IncarcerationDate {xpath('IncarcerationDate')};
	iesp.share.t_Date IncarcerationReleaseDate {xpath('IncarcerationReleaseDate')};
	string50 AgencyDescription {xpath('AgencyDescription')};
	string2 StateOrigin {xpath('StateOrigin')};
	string30 CountyOfOrigin {xpath('CountyOfOrigin')};
	string40 CourtCounty {xpath('CourtCounty')};
	string40 OffenseTown {xpath('OffenseTown')};
	string2 Citizenship {xpath('Citizenship')};
	string30 RaceDescription {xpath('RaceDescription')};
	string7 Sex {xpath('Sex')};
	string15 HairColor {xpath('HairColor')};
	string15 EyeColor {xpath('EyeColor')};
	string3 Height {xpath('Height')};
	string3 Weight {xpath('Weight')};
	string10 FederalOrState {xpath('FederalOrState')};
	string CaseType {xpath('CaseType')};
	string ArrestLevel {xpath('ArrestLevel')};
	string Agency {xpath('Agency')};
	string30 Race {xpath('Race')};
	string50 OffenseState {xpath('OffenseState')};
	string30 OffenseCounty {xpath('OffenseCounty')};
	string40 OffenseCity {xpath('OffenseCity')};
	boolean TrafficRelatedOffense {xpath('TrafficRelatedOffense')};
end;
		
export t_DDRLegalSummary := record
	integer2 NumberOfFelonyArrests {xpath('NumberOfFelonyArrests')};
	integer2 NumberOfMisdemeanorArrests {xpath('NumberOfMisdemeanorArrests')};
	integer2 NumberOfTrafficArrests {xpath('NumberOfTrafficArrests')};
	integer2 NumberOfInfractionArrests {xpath('NumberOfInfractionArrests')};
	integer2 NumberOfUnknownArrests {xpath('NumberOfUnknownArrests')};
	integer2 NumberOfFelonyConvictions {xpath('NumberOfFelonyConvictions')};
	integer2 NumberOfFelonyNonConvictions {xpath('NumberOfFelonyNonConvictions')};
	integer2 NumberOfMisdemeanorConvictions {xpath('NumberOfMisdemeanorConvictions')};
	integer2 NumberOfMisdemeanorNonConcivtions {xpath('NumberOfMisdemeanorNonConcivtions')};
	integer2 NumberOfTrafficConvictions {xpath('NumberOfTrafficConvictions')};
	integer2 NumberOfTrafficNonConvictions {xpath('NumberOfTrafficNonConvictions')};
	integer2 NumberOfInfractionConvictions {xpath('NumberOfInfractionConvictions')};
	integer2 NumberOfInfractionNonConvictions {xpath('NumberOfInfractionNonConvictions')};
	integer2 NumberOfUnknownConvictions {xpath('NumberOfUnknownConvictions')};
	integer2 NumberOfUnknownNonConvictions {xpath('NumberOfUnknownNonConvictions')};
	integer2 NumberOfJudgmentsLiens {xpath('NumberOfJudgmentsLiens')};
	integer2 NumberOfEvictions {xpath('NumberOfEvictions')};
end;
		
export t_DDRCreditorDebtor := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string TaxID {xpath('TaxID')};
end;
		
export t_DDRLiensJudgmentsEvictions := record
	string FilingType {xpath('FilingType')};
	integer8 FilingAmount {xpath('FilingAmount')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	string FilingNumber {xpath('FilingNumber')};
	string FilingJurisdiction {xpath('FilingJurisdiction')};
	iesp.share.t_Date ReleaseDate {xpath('ReleaseDate')};
	boolean Eviction {xpath('Eviction')};
	string Agency {xpath('Agency')};
	string2 AgencyState {xpath('AgencyState')};
	string AgencyCounty {xpath('AgencyCounty')};
	dataset(t_DDRCreditorDebtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxDebtors)};
	dataset(t_DDRCreditorDebtor) Creditors {xpath('Creditors/Creditor'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxCreditors)};
end;
		
export t_DDRProfessionalLicenses := record
	string License {xpath('License')};
	string Status {xpath('Status')};
	string IssuingAgency {xpath('IssuingAgency')};
	iesp.share.t_Date IssueDate {xpath('IssueDate')};
	iesp.share.t_Date ExpirationDate {xpath('ExpirationDate')};
	boolean LawAccounting {xpath('LawAccounting')};
	boolean FinanceRealEstate {xpath('FinanceRealEstate')};
	boolean MedicalDoctor {xpath('MedicalDoctor')};
	boolean PilotMarinePilotHarborPilotExplosives {xpath('PilotMarinePilotHarborPilotExplosives')};
end;
		
export t_DDRPositionTitles := record
	string Title {xpath('Title')};
	iesp.share.t_Date FirstReported {xpath('FirstReported')};
	iesp.share.t_Date LastReported {xpath('LastReported')};
end;
		
export t_DDRAttributesBase := record
	string LexID {xpath('LexID')};
	string15 Phone {xpath('Phone')};
	iesp.share.t_Address Address {xpath('Address')};
end;
		
export t_DDRAttributesPerson := record (t_DDRAttributesBase)
	string11 SSN {xpath('SSN')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
end;
		
export t_DDRAttributesBusiness := record (t_DDRAttributesBase)
	string CompanyName {xpath('CompanyName')};
	string AlternateCompanyName {xpath('AlternateCompanyName')};
	string FEIN {xpath('FEIN')};
end;
		
export t_DDRAttributesOptions := record (iesp.share.t_BaseOption)
	string32 AttributesVersionRequest {xpath('AttributesVersionRequest')};
	iesp.share.t_Date HistoryDate {xpath('HistoryDate')};
	boolean IncludeNews {xpath('IncludeNews')};
	boolean DisplayText {xpath('DisplayText')};
	string IncludeSpecialAttributes {xpath('IncludeSpecialAttributes')}; //values['None','Online','Batch','']//hidden[internal]
end;
		
export t_DDRAttributeGroup := record
	string32 Name {xpath('Name')};
	dataset(iesp.share.t_NameValuePair) Attributes {xpath('Attributes/Attribute'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxAttributes)};
	dataset(iesp.share.t_NameValuePair) AttributeLevelHits {xpath('AttributeLevelHits/Attribute'), MAXCOUNT(iesp.constants.DDRAttributesConst.MaxAttributes)};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from duediligenceshared.xml. ***/
/*===================================================*/

