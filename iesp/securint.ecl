export securint := MODULE
			
export t_SecurintUser := record (share.t_User)
	string FCRAPurpose {xpath('FCRAPurpose')};
end;
		
export t_ApplicantVerifyBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Name AKA {xpath('AKA')};
	share.t_Address Address {xpath('Address')};
	share.t_Address PreviousAddress {xpath('PreviousAddress')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
end;
		
export t_ApplicantVerifyOption := record (share.t_BaseSearchOption)
end;
		
export t_ApplicantVerifyAddress := record
	share.t_Address Address {xpath('Address')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
end;
		
export t_ApplicantVerifySubmitted := record
	boolean NameValidated {xpath('NameValidated')};
	share.t_Name Name {xpath('Name')};
	boolean AKAValidated {xpath('AKAValidated')};
	share.t_Name AKA {xpath('AKA')};
	boolean SSNValidated {xpath('SSNValidated')};
	boolean SSNDeceased {xpath('SSNDeceased')};
	string ActualSSN {xpath('ActualSSN')};
	share.t_SSNInfo SSNInfo {xpath('SSNInfo')};
	boolean AddressValidated {xpath('AddressValidated')};
	share.t_Address Address {xpath('Address')};
	boolean PreviousAddressValidated {xpath('PreviousAddressValidated')};
	share.t_Address PreviousAddress {xpath('PreviousAddress')};
	boolean DOBValidated {xpath('DOBValidated')};
	share.t_Date DOB {xpath('DOB')};
	share.t_Date ActualDOB {xpath('ActualDOB')};
end;
		
export t_ApplicantVerifyResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_ApplicantVerifySubmitted Submitted {xpath('Submitted')};
	string UniqueId {xpath('UniqueId')};
	dataset(t_ApplicantVerifyAddress) Addresses {xpath('Addresses/Item'), MAXCOUNT(1)};
	dataset(share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(1)};
	dataset(share.t_Name) OthersWithSameSSN {xpath('OthersWithSameSSN/Name'), MAXCOUNT(1)};
end;
		
export t_NationalCrimOption := record (share.t_BaseReportOption)
	string UseState {xpath('UseState')};
	boolean IncludeSexualOffenses {xpath('IncludeSexualOffenses')};
	boolean IncludeCriminalOffenses {xpath('IncludeCriminalOffenses')};
end;
		
export t_NationalCrimSearchBy := record
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Name AKA {xpath('AKA')};
	share.t_Address Address {xpath('Address')};
	share.t_Address PreviousAddress {xpath('PreviousAddress')};
	share.t_Date DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
end;
		
export t_NationalCrimContact := record
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_NationalCrimCoverage := record
	dataset(share.t_StringArrayItem) CriminalStates {xpath('CriminalStates/State'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) CriminalCounties {xpath('CriminalCounties/County'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) SexualOffenderStates {xpath('SexualOffenderStates/State'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) ArrestCounties {xpath('ArrestCounties/County'), MAXCOUNT(1)};
end;
		
export t_NatioanlCrimPhysicalCharacteristics := record
	string Race {xpath('Race')};
	string Sex {xpath('Sex')};
	string EyeColor {xpath('EyeColor')};
	string HairColor {xpath('HairColor')};
	string SkinColor {xpath('SkinColor')};
	string Height {xpath('Height')};
	string Weight {xpath('Weight')};
	string ScarsMarksTattoos {xpath('ScarsMarksTattoos')};
end;
		
export t_NationalCrimOffense := record
	string CaseNumber {xpath('CaseNumber')};
	string CaseType {xpath('CaseType')};
	string CourtDescription {xpath('CourtDescription')};
	string OffenseDescription {xpath('OffenseDescription')};
	string ArrestingAgency {xpath('ArrestingAgency')};
	string ArrestLevel {xpath('ArrestLevel')};
	string ArrestStatute {xpath('ArrestStatute')};
	share.t_Date OffenseDate {xpath('OffenseDate')};
	share.t_Date ArrestDate {xpath('ArrestDate')};
	share.t_Date DispositionDate {xpath('DispositionDate')};
	string Disposition {xpath('Disposition')};
	string County {xpath('County')};
	share.t_Date SentenceDate {xpath('SentenceDate')};
	string SentenceLength {xpath('SentenceLength')};
	string GenderOfVictim {xpath('GenderOfVictim')};
	boolean VictimIsMinor {xpath('VictimIsMinor')};
	share.t_Date ConvictionDate {xpath('ConvictionDate')};
	string ConvictionPlace {xpath('ConvictionPlace')};
	share.t_Date OtherDate1 {xpath('OtherDate1')};
	string OtherDateType1 {xpath('OtherDateType1')};
	share.t_Date OtherDate2 {xpath('OtherDate2')};
	string OtherDateType2 {xpath('OtherDateType2')};
	share.t_Date OtherDate3 {xpath('OtherDate3')};
	string OtherDateType3 {xpath('OtherDateType3')};
end;
		
export t_NationalCrimProbationParole := record
	share.t_Date StartDate {xpath('StartDate')};
	share.t_Date ScheduledEndDate {xpath('ScheduledEndDate')};
	share.t_Date ActualEndDate {xpath('ActualEndDate')};
	string CurrentStatus {xpath('CurrentStatus')};
	string County {xpath('County')};
end;
		
export t_NationalCrimPrison := record
	share.t_Date AdmittedDate {xpath('AdmittedDate')};
	string SentenceLength {xpath('SentenceLength')};
	share.t_Date ScheduledReleaseDate {xpath('ScheduledReleaseDate')};
	string CurrentStatus {xpath('CurrentStatus')};
end;
		
export t_NationalCrimAKA := record
	share.t_Name Name {xpath('Name')};
	boolean AKAMatch {xpath('AKAMatch')};
end;
		
export t_NationalCrimRecord := record
	string ReferenceId {xpath('ReferenceId')};
	boolean InDispute {xpath('InDispute')};
	string ConsumerStatement {xpath('ConsumerStatement')};
	string StateOfOrigin {xpath('StateOfOrigin')};
	string CountyOfOrigin {xpath('CountyOfOrigin')};
	string CaseType {xpath('CaseType')};
	string DataTypeCode {xpath('DataTypeCode')};
	string CaseNumber {xpath('CaseNumber')};
	share.t_Date CaseFilingDate {xpath('CaseFilingDate')};
	share.t_Name Name {xpath('Name')};
	boolean NameMatch {xpath('NameMatch')};
	share.t_Address Address {xpath('Address')};
	boolean AddressMatch {xpath('AddressMatch')};
	string SSN {xpath('SSN')};
	boolean SSNMatch {xpath('SSNMatch')};
	share.t_Date DOB {xpath('DOB')};
	boolean DOBMatch {xpath('DOBMatch')};
	string StateOfBirth {xpath('StateOfBirth')};
	string OffenderStatus {xpath('OffenderStatus')};
	t_NatioanlCrimPhysicalCharacteristics PhysicalCharacteristics {xpath('PhysicalCharacteristics')};
	string IdNumber1 {xpath('IdNumber1')};
	string IdType1 {xpath('IdType1')};
	string IdNumber2 {xpath('IdNumber2')};
	string IdType2 {xpath('IdType2')};
	dataset(t_NationalCrimAKA) AKAs {xpath('AKAs/AKA'), MAXCOUNT(1)};
	dataset(t_NationalCrimOffense) Offenses {xpath('Offenses/Offense'), MAXCOUNT(1)};
	dataset(t_NationalCrimProbationParole) ProbationParoles {xpath('ProbationParoles/Sentence'), MAXCOUNT(1)};
	dataset(t_NationalCrimPrison) PrisonRecords {xpath('PrisonRecords/Sentence'), MAXCOUNT(1)};
end;
		
export t_NationalCrimResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_NationalCrimCoverage Coverage {xpath('Coverage')};
	dataset(t_NationalCrimRecord) CriminalRecords {xpath('CriminalRecords/Record'), MAXCOUNT(1)};
end;
		
export t_ApplicantVerifyRequest := record
	t_SecurintUser User {xpath('User')};
	t_ApplicantVerifyOption Options {xpath('Options')};
	t_ApplicantVerifyBy SearchBy {xpath('SearchBy')};
end;
		
export t_NationalCrimRequest := record
	t_SecurintUser User {xpath('User')};
	t_NationalCrimOption Options {xpath('Options')};
	t_NationalCrimSearchBy SearchBy {xpath('SearchBy')};
	t_NationalCrimContact Contact {xpath('Contact')};
end;
		
export t_ApplicantVerifyResponseEx := record
	t_ApplicantVerifyResponse response {xpath('response')};
end;
		
export t_NationalCrimResponseEx := record
	t_NationalCrimResponse response {xpath('response')};
end;
		

end;

