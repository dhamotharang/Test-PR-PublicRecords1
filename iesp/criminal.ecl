﻿// Note to ECL Developers:
// 
// On 07/09/2019 for the 2019 Criminal Records Report Enhancement (add offense town) Project; 
// when 1 new OffenseTown field was to be added to the t_CrimReportOffense record of the ESDL 
// version of the 'criminal' member by Joel Luzadas in ESP and then the ESDL to ECL generated   
// iesp.criminal attribute was created, the updated version was noticed to be out of sync 
// with the one below in the ECL repository.  
// During a meeting on 07/11/19 with Dave Wright and Joel & Kannan Sivasankaran (in ESP), 
// it was discovered that certain fields were added to the ESDL 'criminal' version for use 
// by Distrix and others (the 'Pdf' fields) were accidentally added by Vlad Florentino without
// the 'ecl_hide' parm. 
// So I (Dave Wright) used the ESDL to ECL generated version named 'criminla2.txt' that was 
// attached to JIRA ESDL-101, BUT commented out the differences (except for the 1 new 
// OffenseTown field); so the at least the differences are noted below and will not be 
// lost or forgotten about. 

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from criminal.xml. ***/
/*===================================================*/

import iesp;

export criminal := MODULE
			
export t_CrimSearchOption := record (iesp.share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean GroupSelectCrimesAgainstPersons {xpath('GroupSelectCrimesAgainstPersons')};
	boolean GroupSelectCrimesAgainstProperty {xpath('GroupSelectCrimesAgainstProperty')};
	boolean GroupSelectDrugAlcoholOffenses {xpath('GroupSelectDrugAlcoholOffenses')};
	boolean GroupSelectFraudOffenses {xpath('GroupSelectFraudOffenses')};
	boolean GroupSelectDomesticPersonalOffenses {xpath('GroupSelectDomesticPersonalOffenses')};
	boolean GroupSelectSexualOffenses {xpath('GroupSelectSexualOffenses')};
	boolean IncludeArson {xpath('IncludeArson')};
	boolean IncludeAssaultAggravated {xpath('IncludeAssaultAggravated')};
	boolean IncludeAssaultOther {xpath('IncludeAssaultOther')};
	boolean IncludeBribery {xpath('IncludeBribery')};
	boolean IncludeBurglaryResidential {xpath('IncludeBurglaryResidential')};
	boolean IncludeBurglaryCommercial {xpath('IncludeBurglaryCommercial')};
	boolean IncludeBurglaryMotorVehicle {xpath('IncludeBurglaryMotorVehicle')};
	boolean IncludeCounterfeitingForgery {xpath('IncludeCounterfeitingForgery')};
	boolean IncludeDestructionDamageVandalism {xpath('IncludeDestructionDamageVandalism')};
	boolean IncludeDrugNarcotic {xpath('IncludeDrugNarcotic')};
	boolean IncludeFraud {xpath('IncludeFraud')};
	boolean IncludeGambling {xpath('IncludeGambling')};
	boolean IncludeHomicide {xpath('IncludeHomicide')};
	boolean IncludeKidnappingAbduction {xpath('IncludeKidnappingAbduction')};
	boolean IncludeTheft {xpath('IncludeTheft')};
	boolean IncludeShoplifting {xpath('IncludeShoplifting')};
	boolean IncludeMotorVehicleTheft {xpath('IncludeMotorVehicleTheft')};
	boolean IncludePornographyObsceneMaterial {xpath('IncludePornographyObsceneMaterial')};
	boolean IncludeProstitution {xpath('IncludeProstitution')};
	boolean IncludeRobberyResidential {xpath('IncludeRobberyResidential')};
	boolean IncludeRobberyCommercial {xpath('IncludeRobberyCommercial')};
	boolean IncludeSexOffensesForcible {xpath('IncludeSexOffensesForcible')};
	boolean IncludeSexOffensesNonForcible {xpath('IncludeSexOffensesNonForcible')};
	boolean IncludeStolenPropertyOffensesFence {xpath('IncludeStolenPropertyOffensesFence')};
	boolean IncludeWeaponLawViolations {xpath('IncludeWeaponLawViolations')};
	boolean IncludeIdentityTheft {xpath('IncludeIdentityTheft')};
	boolean IncludeComputerCrimes {xpath('IncludeComputerCrimes')};
	boolean IncludeHumanTrafficking {xpath('IncludeHumanTrafficking')};
	boolean IncludeTerroristThreats {xpath('IncludeTerroristThreats')};
	boolean IncludeRestrainingOrderViolations {xpath('IncludeRestrainingOrderViolations')};
	boolean IncludeTraffic {xpath('IncludeTraffic')};
	boolean IncludeBadchecks {xpath('IncludeBadchecks')};
	boolean IncludeCurfewLoiteringVagrancy {xpath('IncludeCurfewLoiteringVagrancy')};
	boolean IncludeDisorderlyConduct {xpath('IncludeDisorderlyConduct')};
	boolean IncludeDrivingUnderTheInfluence {xpath('IncludeDrivingUnderTheInfluence')};
	boolean IncludeDrunkenness {xpath('IncludeDrunkenness')};
	boolean IncludeFamilyOffenses {xpath('IncludeFamilyOffenses')};
	boolean IncludeLiquorLawViolations {xpath('IncludeLiquorLawViolations')};
	boolean IncludeTrespassOfRealProperty {xpath('IncludeTrespassOfRealProperty')};
	boolean IncludePeepingTom {xpath('IncludePeepingTom')};
	boolean IncludeOther {xpath('IncludeOther')};
	boolean IncludeCannotClassify {xpath('IncludeCannotClassify')};
	boolean IncludeWarrantFugitive {xpath('IncludeWarrantFugitive')};
	boolean IncludeObstructResist {xpath('IncludeObstructResist')};
end;
		
export t_CrimSearchBy := record
	string11 SSN {xpath('SSN')};
	string12 UniqueId {xpath('UniqueId')};
	string10 DOCNumber {xpath('DOCNumber')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string99 FilingJurisdiction {xpath('FilingJurisdiction')};
	string2 FilingJurisdictionState {xpath('FilingJurisdictionState')};
	string50 CaseNumber {xpath('CaseNumber')};
	iesp.share.t_DateRange CaseFilingDateRange {xpath('CaseFilingDateRange')};
end;
		
export t_OffenseClassifications := record
	dataset(iesp.share.t_StringArrayItem) Groups {xpath('Groups/Group'), MAXCOUNT(iesp.constants.CRIM.MaxOffenses)};
	dataset(iesp.share.t_StringArrayItem) Categories {xpath('Categories/Category'), MAXCOUNT(iesp.constants.CRIM.MaxOffenses)};
end;

export t_CrimSearchRecord := record
	integer _Penalty {xpath('Penalty')};//hidden[ecldev]
	boolean AlsoFound {xpath('AlsoFound')};
	string45 DataSource {xpath('DataSource')};
	string60 OffenderId {xpath('OffenderId')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string25 StateOfOrigin {xpath('StateOfOrigin')};
	string25 StateOfBirth {xpath('StateOfBirth')};
	string12 UniqueId {xpath('UniqueId')};
	string30 CountyOfOrigin {xpath('CountyOfOrigin')};
	string35 CaseNumber {xpath('CaseNumber')};
	string10 DOCNumber {xpath('DOCNumber')};
	iesp.share.t_Date CaseFilingDate {xpath('CaseFilingDate')};
	iesp.share.t_Date DateLastSeen {xpath('DateLastSeen')};
	t_OffenseClassifications OffenseClassifications {xpath('OffenseClassifications')};
end;
		
export t_CrimSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_CrimSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.CRIM.MaxSearchRecords)};
	//string Pdf {xpath('Pdf')}; 
	//^--- Per Vlad Florentino on 07/11/19, this field was accidentally created because 
	// the 'ecl_hide' attribute is missing on it in the ECM definition of that field.  
	//So he created JIRA ESPBS-985 to fix it and any others like it.  
end;
		
export t_CrimReportBy := record
	iesp.share.t_Name Name {xpath('Name')};
	string60 OffenderId {xpath('OffenderId')};
	string12 UniqueId {xpath('UniqueId')};//hidden[internal]
end;
		
export t_CrimReportOption := record (iesp.share.t_BaseReportOption)
	boolean IncludeSexualOffenses {xpath('IncludeSexualOffenses')};//hidden[internal]
	boolean IncludeAllCriminalRecords {xpath('IncludeAllCriminalRecords')};
end;
		
export t_CrimReportEvent := record
	iesp.share.t_Date Date {xpath('Date')};
	string101 Description {xpath('Description')};
end;
		
export t_CrimReportAppeal := record
	iesp.share.t_Date Date {xpath('Date')};
	string40 Disposition {xpath('Disposition')};
	string40 FinalDisposition {xpath('FinalDisposition')};
end;
		
export t_CrimReportArrest := record
	string50 Agency {xpath('Agency')};
	string35 CaseNumber {xpath('CaseNumber')};
	iesp.share.t_Date Date {xpath('Date')};
	string125 Disposition {xpath('Disposition')};
	iesp.share.t_Date DispositionDate {xpath('DispositionDate')};
	string35 Level {xpath('Level')};
	string125 Offense {xpath('Offense')};
	string70 Statute {xpath('Statute')};
	string30 _Type {xpath('Type')};
end;
		
export t_CrimReportCourt := record
	string35 CaseNumber {xpath('CaseNumber')};
	string8 Costs {xpath('Costs')};
	string40 Description {xpath('Description')};
	string80 Disposition {xpath('Disposition')};
	iesp.share.t_Date DispositionDate {xpath('DispositionDate')};
	string9 Fine {xpath('Fine')};
	string35 Level {xpath('Level')};
	string125 Offense {xpath('Offense')};
	string30 Plea {xpath('Plea')};
	string70 Statute {xpath('Statute')};
	string9 SuspendedFine {xpath('SuspendedFine')};
end;
		
export t_CrimReportCourtSentence := record
	string50 Jail {xpath('Jail')};
	string50 Probation {xpath('Probation')};
	string50 Suspended {xpath('Suspended')};
end;
		
export t_CrimReportOffense := record
	string1 AdjudicationWithheld {xpath('AdjudicationWithheld')};
	string35 CaseNumber {xpath('CaseNumber')};
	string99 CaseType {xpath('CaseType')};
	string99 CaseTypeDescription {xpath('CaseTypeDescription')};
	string99 Count {xpath('Count')};
	string30 County {xpath('County')};
	string40 OffenseTown {xpath('OffenseTown')};
	string99 Description {xpath('Description')};
	string35 MaximumTerm {xpath('MaximumTerm')};
	string35 MinimumTerm {xpath('MinimumTerm')};
	string3 NumberCounts {xpath('NumberCounts')};
	iesp.share.t_Date OffenseDate {xpath('OffenseDate')};
	string1 OffenseType {xpath('OffenseType')};
	string99 Sentence {xpath('Sentence')};
	string50 SentenceLengthDescription {xpath('SentenceLengthDescription')};
	iesp.share.t_Date SentenceDate {xpath('SentenceDate')};
	iesp.share.t_Date IncarcerationDate {xpath('IncarcerationDate')};
	t_CrimReportAppeal Appeal {xpath('Appeal')};
	t_CrimReportArrest Arrest {xpath('Arrest')};
	t_CrimReportCourt Court {xpath('Court')};
	t_CrimReportCourtSentence CourtSentence {xpath('CourtSentence')};
end;
		
export t_CrimReportParoleOffense := record
	iesp.share.t_Date SentenceDate {xpath('SentenceDate')};
	integer Length {xpath('Length')};
	string13 OffenseCounty {xpath('OffenseCounty')};
	string35 CauseNo {xpath('CauseNo')};
	string20 NCICCode {xpath('NCICCode')};
	integer OffenseCount {xpath('OffenseCount')};
	iesp.share.t_Date OffenseDate {xpath('OffenseDate')};
end;
		
export t_CrimReportParole := record
	iesp.share.t_Date ActualEndDate {xpath('ActualEndDate')};
	string18 County {xpath('County')};
	string50 CurrentStatus {xpath('CurrentStatus')};
	string60 Length {xpath('Length')};
	iesp.share.t_Date ScheduledEndDate {xpath('ScheduledEndDate')};
	iesp.share.t_Date StartDate {xpath('StartDate')};
end;
		
export t_CrimReportParoleEx := record (t_CrimReportParole)
	iesp.share.t_Date DateReported {xpath('DateReported')};
	string10 PubicSaftyId {xpath('PubicSaftyId')};
	string10 InmateId {xpath('InmateId')};
	string15 ParoleInAbsentiaId {xpath('ParoleInAbsentiaId')};
	iesp.share.t_Name Name {xpath('Name')};
	string1 Race {xpath('Race')};
	string1 Gender {xpath('Gender')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string13 CountyOfBirth {xpath('CountyOfBirth')};
	string25 StateOfBirth {xpath('StateOfBirth')};
	integer HeightFeet {xpath('HeightFeet')};
	integer HeightInches {xpath('HeightInches')};
	integer WeightInPounds {xpath('WeightInPounds')};
	string3 HairColor {xpath('HairColor')};
	string3 SkinColor {xpath('SkinColor')};
	string3 EyeColor {xpath('EyeColor')};
	dataset(iesp.share.t_StringArrayItem) ScarsMarksTattoos {xpath('ScarsMarksTattoos/SMT'), MAXCOUNT(iesp.Constants.crim.MaxScarsMarksTattoos)};
	string2 PrisonFacilityType {xpath('PrisonFacilityType')};
	string15 PrisonFacilityName {xpath('PrisonFacilityName')};
	iesp.share.t_Date AdmittedDate {xpath('AdmittedDate')};
	string1 PrisonStatus {xpath('PrisonStatus')};
	string2 LastReceiveOrDepartCode {xpath('LastReceiveOrDepartCode')};
	iesp.share.t_Date LastReceiveOrDepartCDate {xpath('LastReceiveOrDepartCDate')};
	iesp.share.t_TimeStamp RecordCreatedTimeStamp {xpath('RecordCreatedTimeStamp')};
	string1 CurrentStatusFlag {xpath('CurrentStatusFlag')};
	iesp.share.t_Date CurrentStatusEffectiveDate {xpath('CurrentStatusEffectiveDate')};
	string2 ParoleRegion {xpath('ParoleRegion')};
	string30 SupervisingOffice {xpath('SupervisingOffice')};
	string30 SupervisingOfficerName {xpath('SupervisingOfficerName')};
	string14 SupervisingOfficerPhone {xpath('SupervisingOfficerPhone')};
	iesp.share.t_Address LastKnownResidence {xpath('LastKnownResidence')};
	iesp.share.t_Date ReleaseArrivalDate {xpath('ReleaseArrivalDate')};
	string4 ReleaseType {xpath('ReleaseType')};
	string13 ReleaseCounty {xpath('ReleaseCounty')};
	string13 LegalResidenceCounty {xpath('LegalResidenceCounty')};
	iesp.share.t_Date LastParoleReviewDate {xpath('LastParoleReviewDate')};
	integer OffenseCount {xpath('OffenseCount')};
	boolean Is3GOffender {xpath('Is3GOffender')};
	boolean IsViolentOffender {xpath('IsViolentOffender')};
	boolean IsSexOffender {xpath('IsSexOffender')};
	boolean IsOnViolentOffenderProgram {xpath('IsOnViolentOffenderProgram')};
	iesp.share.t_Duration LongestTimeToServe {xpath('LongestTimeToServe')};
	string50 LongestTimeToServeDescription {xpath('LongestTimeToServeDescription')};
	iesp.share.t_Date DischargeDate {xpath('DischargeDate')};
	dataset(t_CrimReportParoleOffense) Offenses {xpath('Offenses/Offense'), MAXCOUNT(iesp.Constants.crim.MaxParOffenses)};
end;
		
export t_CrimReportPrison := record
	iesp.share.t_Date AdmittedDate {xpath('AdmittedDate')};
	string50 CurrentStatus {xpath('CurrentStatus')};
	string99 CustodyType {xpath('CustodyType')};
	iesp.share.t_Date CustodyTypeChangeDate {xpath('CustodyTypeChangeDate')};
	string3 GainTimeGranted {xpath('GainTimeGranted')};
	iesp.share.t_Date LastGainTime {xpath('LastGainTime')};
	string99 Location {xpath('Location')};
	iesp.share.t_Date ScheduledReleaseDate {xpath('ScheduledReleaseDate')};
	string60 Sentence {xpath('Sentence')};
end;
		
export t_BaseCrimReportRecord := record
	string OffenderId {xpath('OffenderId')};
	string35 CaseNumber {xpath('CaseNumber')};
	string30 CountyOfOrigin {xpath('CountyOfOrigin')};
	string10 DOCNumber {xpath('DOCNumber')};
	iesp.share.t_Date CaseFilingDate {xpath('CaseFilingDate')};
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
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Date DOB {xpath('DOB')};
	boolean isImageAvailable {xpath('isImageAvailable')};//hidden[internal]
	string99 CaseTypeDescription {xpath('CaseTypeDescription')};
	dataset(iesp.share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(iesp.constants.CRIM.MaxAKAs)};
end;
		
export t_CrimReportRecord := record (t_BaseCrimReportRecord)
	dataset(t_CrimReportOffense) Offenses {xpath('Offenses/Offense'), MAXCOUNT(iesp.constants.CRIM.MaxOffenses)};
	dataset(t_CrimReportPrison) PrisonSentences {xpath('PrisonSentences/PrisonSentence'), MAXCOUNT(iesp.constants.CRIM.MaxPrisons)};
	// v--- the 2 lines below v--- are being kept from the ECL only version prior to the 07/09/19 ESDL changes
	dataset(t_CrimReportParole) ParoleSentences {xpath('ParoleSentences/ParoleSentence'), MAXCOUNT(iesp.constants.CRIM.MaxParoles)};
	dataset(t_CrimReportParoleEx) ParoleSentencesEx {xpath('ParoleSentencesEx/ParoleSentence'), MAXCOUNT(iesp.constants.CRIM.MaxParoles)};
	// v--- the 1 line below was in the 07/09/19 ESDL to ECL generated version, but not in the previous ECL version
	//dataset(t_CrimReportParoleEx) ParoleSentences {xpath('ParoleSentences/ParoleSentence'), MAXCOUNT(iesp.constants.CRIM.MaxParoles)};
	dataset(t_CrimReportEvent) Activities {xpath('Activities/Activity'), MAXCOUNT(iesp.constants.CRIM.MaxEvents)};
	//boolean IsAccurintData {xpath('IsAccurintData')};//hidden[internal]  //For Distrix use only?
end;
		
export t_CrimReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_CrimReportRecord) CriminalRecords {xpath('CriminalRecords/CriminalRecord'), MAXCOUNT(iesp.constants.CRIM.MaxReportRecords)};
	dataset(iesp.sexualoffender.t_SexOffReportRecord) SexualOffenses {xpath('SexualOffenses/SexualOffense'), MAXCOUNT(iesp.Constants.SEXOFF_MAX_COUNT_REPORT_RESPONSE_RECORDS)};//hidden[internal]
	//string Pdf {xpath('Pdf')}; 
	//^--- Per Vlad Florentino on 07/11/19, this field was accidentally created because 
	// the 'ecl_hide' attribute is missing on it in the ECM definition of that field.  
	//So he created JIRA ESPBS-985 to fix it and any others like it.  
end;
		
export t_CrimSearchRequest := record (iesp.share.t_BaseRequest)
	t_CrimSearchBy SearchBy {xpath('SearchBy')};
	t_CrimSearchOption Options {xpath('Options')};
end;
		
export t_CrimReportRequest := record (iesp.share.t_BaseRequest)
	t_CrimReportOption Options {xpath('Options')};
	t_CrimReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_CrimSearchResponseEx := record
	t_CrimSearchResponse response {xpath('response')};
end;
		
export t_CrimReportResponseEx := record
	t_CrimReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from criminal.xml. ***/
/*===================================================*/
