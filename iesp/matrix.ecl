export matrix := MODULE
			
export t_MatrixCrimSearchOption := record
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean Blind {xpath('Blind')};//hidden[internal]
end;
		
export t_MatrixCrimSearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	integer Radius {xpath('Radius')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string SID {xpath('SID')};
end;
		
export t_MatrixCrimSearchRecord := record
	string DataSource {xpath('DataSource')};
	string OffenderId {xpath('OffenderId')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string DOCNumber {xpath('DOCNumber')};
	string DLENumber {xpath('DLENumber')};
	string StateOfOrigin {xpath('StateOfOrigin')};
	string StateOfOriginName {xpath('StateOfOriginName')};
	string StateOfBirth {xpath('StateOfBirth')};
	string UniqueId {xpath('UniqueId')};
end;
		
export t_MatrixCrimSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_MatrixCrimSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportBy := record
	share.t_Name Name {xpath('Name')};
	string OffenderId {xpath('OffenderId')};
	string UniqueId {xpath('UniqueId')};
	string State {xpath('State')};
	string SID {xpath('SID')};
end;
		
export t_MatrixCrimReportOption := record
	boolean Blind {xpath('Blind')};//hidden[internal]
end;
		
export t_MatrixCrimReportAgency := record
	string AgencyId {xpath('AgencyId')};
	string AgencyIdCode {xpath('AgencyIdCode')};
	string AgencyCaseNumber {xpath('AgencyCaseNumber')};
end;
		
export t_MatrixCrimReportOffenseCharge := record
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
end;
		
export t_PlaceOfBirth := record
	string CountryCode {xpath('CountryCode')};
	string CountyCode {xpath('CountyCode')};
	string StateCode {xpath('StateCode')};
	string CityCode {xpath('CityCode')};
	string FullDescription {xpath('FullDescription')};
end;
		
export t_AdditionalNumber := record
	string TypeCode {xpath('TypeCode')};
	string Type {xpath('Type')};
	string LocationCode {xpath('LocationCode')};
	string Location {xpath('Location')};
	string Number {xpath('Number')};
end;
		
export t_MatrixCrimReportAppend := record
	share.t_Date ProcessDate {xpath('ProcessDate')};
	string Vendor {xpath('Vendor')};
	string StateOrigin {xpath('StateOrigin')};
	string OffenderId {xpath('OffenderId')};
	string SequenceNumber {xpath('SequenceNumber')};
	string Occupation {xpath('Occupation')};
	string Employer {xpath('Employer')};
	string Fingerprints {xpath('Fingerprints')};
	string LeftFingerprintCodes {xpath('LeftFingerprintCodes')};
	string RightFingerprintCodes {xpath('RightFingerprintCodes')};
	t_PlaceOfBirth PlaceOfBirth {xpath('PlaceOfBirth')};
	string StateSpecificFields {xpath('StateSpecificFields')};
	dataset(share.t_StringArrayItem) ScarMarkTattoos {xpath('ScarMarkTattoos/ScarMarkTattoo'), MAXCOUNT(1)};
	dataset(share.t_Date) DOBs {xpath('DOBs/DOB'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) SSNs {xpath('SSNs/SSN'), MAXCOUNT(1)};
	dataset(t_AdditionalNumber) AdditionalNumbers {xpath('AdditionalNumbers/AdditionalNumber'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportCharge := record
	string StateSpecificChargeFields {xpath('StateSpecificChargeFields')};
	string ChargeNumber {xpath('ChargeNumber')};
	share.t_Date OffenseDate {xpath('OffenseDate')};
	t_MatrixCrimReportOffenseCharge OffenseCharge {xpath('OffenseCharge')};
	string NoFingerprintClass {xpath('NoFingerprintClass')};
	share.t_Date EntryDate {xpath('EntryDate')};
	share.t_Date LastUpdateDate {xpath('LastUpdateDate')};
	string ModifyCount {xpath('ModifyCount')};
	string VictimType {xpath('VictimType')};
	boolean DomesticViolenceFlag {xpath('DomesticViolenceFlag')};
	share.t_Date DispositionDate {xpath('DispositionDate')};
	dataset(share.t_StringArrayItem) DispositionCodes {xpath('DispositionCodes/DispositionCode'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Dispositions {xpath('Dispositions/Disposition'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportJudicialCharge := record
	string ArrestChargeNumber {xpath('ArrestChargeNumber')};
	string ArrestChargeStatus {xpath('ArrestChargeStatus')};
	string ArrestChargeLevelDegree {xpath('ArrestChargeLevelDegree')};
	string StateSpecificFields {xpath('StateSpecificFields')};
	t_MatrixCrimReportOffenseCharge ProsecutionCharge {xpath('ProsecutionCharge')};
	string ProsecutionDispositionCode {xpath('ProsecutionDispositionCode')};
	share.t_Date ProsecutionDispositionDate {xpath('ProsecutionDispositionDate')};
	t_MatrixCrimReportOffenseCharge CourtCharge {xpath('CourtCharge')};
	string CourtDispositionCode {xpath('CourtDispositionCode')};
	share.t_Date CourtDispositionDate {xpath('CourtDispositionDate')};
	share.t_Date SentenceDate {xpath('SentenceDate')};
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
	share.t_Date EntryDate {xpath('EntryDate')};
	share.t_Date LastUpdateDate {xpath('LastUpdateDate')};
	share.t_Date JudicialAppealDate {xpath('JudicialAppealDate')};
	integer ModifyCount {xpath('ModifyCount')};
	boolean DomesticViolenceFlag {xpath('DomesticViolenceFlag')};
	string FillerToBeKnown {xpath('FillerToBeKnown')};
	string NoFingerprintClass {xpath('NoFingerprintClass')};
	dataset(share.t_StringArrayItem) CourtProvisionCodes {xpath('CourtProvisionCodes/CourtProvisionCode'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportJudicial := record
	share.t_Date ProcessDate {xpath('ProcessDate')};
	string OffenderId {xpath('OffenderId')};
	string Vendor {xpath('Vendor')};
	string StateOrigin {xpath('StateOrigin')};
	string DLENumber {xpath('DLENumber')};
	string StateSpecificFields {xpath('StateSpecificFields')};
	string ArrestTrackingNumber {xpath('ArrestTrackingNumber')};
	share.t_Date ArrestDate {xpath('ArrestDate')};
	string ArrestSequenceCode {xpath('ArrestSequenceCode')};
	t_MatrixCrimReportAgency JudicialAgency {xpath('JudicialAgency')};
	string JudicialSequenceNumber {xpath('JudicialSequenceNumber')};
	dataset(t_MatrixCrimReportJudicialCharge) JudicialCharges {xpath('JudicialCharges/JudicialCharge'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportEvent := record
	share.t_Date SortDate {xpath('SortDate')};
	share.t_Date ArrestDate {xpath('ArrestDate')};
	share.t_Date StatusStartDate {xpath('StatusStartDate')};
	share.t_Date ScheduledEndDate {xpath('ScheduledEndDate')};
	share.t_Date ActualEndDate {xpath('ActualEndDate')};
	share.t_Date EntryDate {xpath('EntryDate')};
	share.t_Date LastUpdateDate {xpath('LastUpdateDate')};
	string EventType {xpath('EventType')};
	string StateSpecificFields {xpath('StateSpecificFields')};
	string ArrestTrackingNumber {xpath('ArrestTrackingNumber')};
	string RestrictedService {xpath('RestrictedService')};
	string StatusChange {xpath('StatusChange')};
	string SuspendedStatus {xpath('SuspendedStatus')};
	t_MatrixCrimReportAgency Agency {xpath('Agency')};
	string Status1 {xpath('Status1')};
	string Status2 {xpath('Status2')};
	string NoFingerprintClass {xpath('NoFingerprintClass')};
	integer ModifyCount {xpath('ModifyCount')};
end;
		
export t_MatrixCrimReportArrest := record
	share.t_Date ProcessDate {xpath('ProcessDate')};
	string OffenderId {xpath('OffenderId')};
	string Vendor {xpath('Vendor')};
	string StateOrigin {xpath('StateOrigin')};
	string DLENumber {xpath('DLENumber')};
	string StateSpecificFields {xpath('StateSpecificFields')};
	string ArrestTrackingNumber {xpath('ArrestTrackingNumber')};
	share.t_Date ArrestDate {xpath('ArrestDate')};
	integer ArrestCount {xpath('ArrestCount')};
	string SequenceCode {xpath('SequenceCode')};
	dataset(t_MatrixCrimReportAgency) ArrestAgencies {xpath('ArrestAgencies/ArrestAgency'), MAXCOUNT(1)};
	dataset(t_MatrixCrimReportCharge) ArrestCharges {xpath('ArrestCharges/ArrestCharge'), MAXCOUNT(1)};
	dataset(t_MatrixCrimReportJudicial) Judicials {xpath('Judicials/Judicial'), MAXCOUNT(1)};
	dataset(t_MatrixCrimReportEvent) Events {xpath('Events/Event'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportIdentity := record
	string StateOriginName {xpath('StateOriginName')};
	string StateOriginCode {xpath('StateOriginCode')};
	string DataType {xpath('DataType')};
	string SourceFile {xpath('SourceFile')};
	string CaseNumber {xpath('CaseNumber')};
	string CaseCourt {xpath('CaseCourt')};
	string CaseName {xpath('CaseName')};
	string CaseTypeCode {xpath('CaseTypeCode')};
	string CaseType {xpath('CaseType')};
	share.t_Date CaseFilingDate {xpath('CaseFilingDate')};
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
	share.t_Name NameOrigin {xpath('NameOrigin')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
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
	dataset(share.t_StringArrayItem) RawAddress {xpath('RawAddress/AddressLine'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportRecord := record
	dataset(t_MatrixCrimReportAppend) Appends {xpath('Appends/Append'), MAXCOUNT(1)};
	dataset(t_MatrixCrimReportIdentity) Identities {xpath('Identities/Identity'), MAXCOUNT(1)};
	dataset(t_MatrixCrimReportArrest) Arrests {xpath('Arrests/Arrest'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_MatrixCrimReportRecord) CriminalHistories {xpath('CriminalHistories/CriminalHistory'), MAXCOUNT(1)};
end;
		
export t_MatrixCrimSearchRequest := record (share.t_BaseRequest)
	t_MatrixCrimSearchBy SearchBy {xpath('SearchBy')};
	t_MatrixCrimSearchOption Options {xpath('Options')};
end;
		
export t_MatrixCrimReportRequest := record (share.t_BaseRequest)
	t_MatrixCrimReportOption Options {xpath('Options')};
	t_MatrixCrimReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_MatrixCrimSearchResponseEx := record
	t_MatrixCrimSearchResponse response {xpath('response')};
end;
		
export t_MatrixCrimReportResponseEx := record
	t_MatrixCrimReportResponse response {xpath('response')};
end;
		

end;

