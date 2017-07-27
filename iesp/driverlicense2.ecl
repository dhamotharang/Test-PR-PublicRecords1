/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from driverlicense2.xml. ***/
/*===================================================*/

export driverlicense2 := MODULE
			
export t_DLSearch2By := record (share.t_BaseSearchBy)
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string30 DLNumber {xpath('DLNumber')};
	string11 SSN {xpath('SSN')};
	string12 UniqueId {xpath('UniqueId')};
	string2 DLState {xpath('DLState')};
end;
		
export t_DLSearch2Options := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
	string1 IncludeHistory {xpath('IncludeHistory')}; //values['H','C','A','']
	integer PenaltyThreshold {xpath('PenaltyThreshold')};//hidden[internal]
	boolean IncludeNonDMVSources {xpath('IncludeNonDMVSources')};
end;
		
export t_DLRecord := record
	string15 DLSequenceId {xpath('DLSequenceId')};//hidden[internal]
	string12 UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_Date DOB {xpath('DOB')};
	share.t_MaskableDate DOB2 {xpath('DOB2')};
	share.t_Date ExpirationDate {xpath('ExpirationDate')};
	share.t_Date IssueDate {xpath('IssueDate')};
	string24 DriverLicense {xpath('DriverLicense')};
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
	string4 MotorCycle {xpath('MotorCycle')}; //values['','ALSO','ONLY','']
	string50 Status {xpath('Status')};
	string50 CDLStatus {xpath('CDLStatus')};
	string10 History {xpath('History')};
	string25 Attention {xpath('Attention')};
	string120 Restrictions {xpath('Restrictions')};
	string120 Endorsements {xpath('Endorsements')};
	dataset(share.t_StringArrayItem) RestrictionsDetail {xpath('RestrictionsDetail/Restriction'), MAXCOUNT(iesp.constants.DL.MaxCountRestrictions)};
	dataset(share.t_StringArrayItem) EndorsementsDetail {xpath('EndorsementsDetail/Endorsement'), MAXCOUNT(iesp.constants.DL.MaxCountEndorsements)};
end;
		
export t_DLSearch2Record := record (t_DLRecord)
	share.t_Address Address {xpath('Address')};
	boolean AlsoFound {xpath('AlsoFound')};
	string25 OOSPrevDLNumber {xpath('OOSPrevDLNumber')};
	string2 OOSPrevState {xpath('OOSPrevState')};
	string2 Src {xpath('Src')};//hidden[internal]
	string1 NonDMVSource {xpath('NonDMVSource')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_DLEmbeddedReport2Record := record (t_DLRecord)
	integer2 addr_no {xpath('addr_no')};//hidden[ecldev]
	share.t_UniversalAddress Address {xpath('Address')};
	share.t_Date DOD {xpath('DOD')};
	share.t_Date OrigIssueDate {xpath('OrigIssueDate')};
	share.t_Date OrigExpDate {xpath('OrigExpDate')};
	share.t_Date ActiveDate {xpath('ActiveDate')};
	share.t_Date InactiveDate {xpath('InactiveDate')};
	string1 NameChange {xpath('NameChange')};
	string8 AddressChange {xpath('AddressChange')};
	string42 RestrictionsDelimited {xpath('RestrictionsDelimited')};
	string25 OOSPrevDLNumber {xpath('OOSPrevDLNumber')};
	string2 OOSPrevState {xpath('OOSPrevState')};
	string24 OldDLNumber {xpath('OldDLNumber')};
	string2 Issuance {xpath('Issuance')};
	integer Age {xpath('Age')};
	string2 Src {xpath('Src')};//hidden[internal]
	string1 NonDMVSource {xpath('NonDMVSource')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_DLReport2Accident := record
	string _Type {xpath('Type')};
	string CountyCode {xpath('CountyCode')};
	string Jurisdiction {xpath('Jurisdiction')};
	string Severity {xpath('Severity')};
	share.t_Date AccidentDate {xpath('AccidentDate')};
	string VehicleNbr {xpath('VehicleNbr')};
	string Hazardous {xpath('Hazardous')};
	share.t_Date CreateDate {xpath('CreateDate')};
	string BmvCaseNbr1 {xpath('BmvCaseNbr1')};
	share.t_Date ExpungedDate {xpath('ExpungedDate')};
end;
		
export t_DLReport2Conviction := record
	string _Type {xpath('Type')};
	share.t_Date ViolationDate {xpath('ViolationDate')};
	string PlateNbr {xpath('PlateNbr')};
	share.t_Date ConvictionDate {xpath('ConvictionDate')};
	string CourtName {xpath('CourtName')};
	string CourtCounty {xpath('CourtCounty')};
	string CourtType {xpath('CourtType')};
	string Offense {xpath('Offense')};
	string Sentence {xpath('Sentence')};
	string Points {xpath('Points')};
	string Hazardous {xpath('Hazardous')};
	string Plea {xpath('Plea')};
	string CourtCaseNbr {xpath('CourtCaseNbr')};
	string AcdOffense {xpath('AcdOffense')};
	string VehicleNbr {xpath('VehicleNbr')};
	string Reduced {xpath('Reduced')};
	share.t_Date CreateDate {xpath('CreateDate')};
	string BmvCaseNbr1 {xpath('BmvCaseNbr1')};
	string BmvCaseNbr2 {xpath('BmvCaseNbr2')};
	string BmvCaseNbr3 {xpath('BmvCaseNbr3')};
	string HabitualCaseNbr {xpath('HabitualCaseNbr')};
	share.t_Date FiledDate {xpath('FiledDate')};
	share.t_Date ExpungedDate {xpath('ExpungedDate')};
	string Jurisdiction {xpath('Jurisdiction')};
	string SoaConviction {xpath('SoaConviction')};
	string BmvSpCaseNbr {xpath('BmvSpCaseNbr')};
	string OutOfStateDlNbr {xpath('OutOfStateDlNbr')};
	string StateOfOrigin {xpath('StateOfOrigin')};
	string County {xpath('County')};
end;
		
export t_DLReport2DRInfo := record
	string _Type {xpath('Type')};
	share.t_Date ActionDate {xpath('ActionDate')};
	string BmvCaseNbr1 {xpath('BmvCaseNbr1')};
	share.t_Date ClearDate {xpath('ClearDate')};
	string CosignersDlNbr {xpath('CosignersDlNbr')};
	string CosignersName {xpath('CosignersName')};
	string CosignersRelationship {xpath('CosignersRelationship')};
	string CourtCaseNbr {xpath('CourtCaseNbr')};
	share.t_Date CreateDate {xpath('CreateDate')};
	string DlNbr {xpath('DlNbr')};
	share.t_Date ExpungedDate {xpath('ExpungedDate')};
	share.t_Date MailedDate {xpath('MailedDate')};
	string Narrative {xpath('Narrative')};
	string OutOfStateDlNbr {xpath('OutOfStateDlNbr')};
	string RemedialRequireComp {xpath('RemedialRequireComp')};
	string RemedialRequireDenied {xpath('RemedialRequireDenied')};
	share.t_Date WarrantEffDate {xpath('WarrantEffDate')};
end;
		
export t_DLReport2FRAInsurance := record
	share.t_Date CancelPostedDate {xpath('CancelPostedDate')};
	share.t_Date CreateDate {xpath('CreateDate')};
	share.t_Date FiledDate {xpath('FiledDate')};
	share.t_Date InsCancelDate {xpath('InsCancelDate')};
	string InsPolicyNbr {xpath('InsPolicyNbr')};
	string InsuranceCompany {xpath('InsuranceCompany')};
	share.t_Date LatestProofStartDate {xpath('LatestProofStartDate')};
	share.t_Date ProofStartDate {xpath('ProofStartDate')};
	share.t_Date ProofEndDate {xpath('ProofEndDate')};
end;
		
export t_DLReport2Suspension := record
	string _Type {xpath('Type')};
	share.t_Date ViolationDate {xpath('ViolationDate')};
	share.t_Date ClearDate {xpath('ClearDate')};
	share.t_Date FiledDate {xpath('FiledDate')};
	share.t_Date ActionDate {xpath('ActionDate')};
	share.t_Date StartDate {xpath('StartDate')};
	share.t_Date EndDate {xpath('EndDate')};
	string BmvCaseNbr1 {xpath('BmvCaseNbr1')};
	string CourtCaseNbr {xpath('CourtCaseNbr')};
	string CourtNameCode {xpath('CourtNameCode')};
	string CourtName {xpath('CourtName')};
	string CourtCounty {xpath('CourtCounty')};
	string CourtType {xpath('CourtType')};
	string OffenseConviction {xpath('OffenseConviction')};
	string VehicleNbr {xpath('VehicleNbr')};
	string Hazardous {xpath('Hazardous')};
	string Jurisdiction {xpath('Jurisdiction')};
	share.t_Date FeePaidDate {xpath('FeePaidDate')};
	string PlateNbr {xpath('PlateNbr')};
	string CdlDisqReason {xpath('CdlDisqReason')};
	string CdlOfsDisqualReason {xpath('CdlOfsDisqualReason')};
	string DisqExt {xpath('DisqExt')};
	string DisqReason {xpath('DisqReason')};
	string SchoolDistNbr {xpath('SchoolDistNbr')};
	string WdClearReason {xpath('WdClearReason')};
	string NaicInsurance {xpath('NaicInsurance')};
	string InsBondFilingInd {xpath('InsBondFilingInd')};
	share.t_Date ClearedDate {xpath('ClearedDate')};
	string WdReason {xpath('WdReason')};
	share.t_Date RemedialDrvCrsDate {xpath('RemedialDrvCrsDate')};
	share.t_Date ExamDate {xpath('ExamDate')};
	string AcdOffense {xpath('AcdOffense')};
	string WdStatus {xpath('WdStatus')};
	share.t_Date ModifiedDrvDate {xpath('ModifiedDrvDate')};
	share.t_Date SettleAgreeDate {xpath('SettleAgreeDate')};
	string Restriction {xpath('Restriction')};
	share.t_Date ConvictionDate {xpath('ConvictionDate')};
	share.t_Date AppealFileDate {xpath('AppealFileDate')};
	share.t_Date AppealDenyDate {xpath('AppealDenyDate')};
	share.t_Date AppealGrantedDate {xpath('AppealGrantedDate')};
	string Plea {xpath('Plea')};
	string SuspensionRevocation {xpath('SuspensionRevocation')};
	string County {xpath('County')};
	share.t_Date ArrestDate {xpath('ArrestDate')};
	string LicenseNumber {xpath('LicenseNumber')};
	share.t_Date CreateDate {xpath('CreateDate')};
	share.t_Date LicenseRecDate {xpath('LicenseRecDate')};
	share.t_Date PlateRecDate {xpath('PlateRecDate')};
	share.t_Date FraSupStartDate {xpath('FraSupStartDate')};
	share.t_Date FraSupEndDate {xpath('FraSupEndDate')};
	share.t_Date AccidentDate {xpath('AccidentDate')};
	string RelatedBmvCaseNbr {xpath('RelatedBmvCaseNbr')};
	string Narrative {xpath('Narrative')};
	string FeeRequired {xpath('FeeRequired')};
	string VehicleOwnerInd {xpath('VehicleOwnerInd')};
	string SoaConviction {xpath('SoaConviction')};
	share.t_Date ExpungedDate {xpath('ExpungedDate')};
	share.t_Date ModifiedDrvEndDate {xpath('ModifiedDrvEndDate')};
	string AppealSupStay {xpath('AppealSupStay')};
	string WdTypeDetail {xpath('WdTypeDetail')};
	string HpLicenseCancel {xpath('HpLicenseCancel')};
	string BmvDlCaseNbr {xpath('BmvDlCaseNbr')};
	string RelatedBmvCaseNbr2 {xpath('RelatedBmvCaseNbr2')};
	share.t_Date FinePaidDate {xpath('FinePaidDate')};
	string Csea {xpath('Csea')};
	string CseaCaseNbr {xpath('CseaCaseNbr')};
	string CseaOrderNbr {xpath('CseaOrderNbr')};
	string CseaPartNbr {xpath('CseaPartNbr')};
end;
		
export t_DLReport2Record := record (t_DLEmbeddedReport2Record)
end;
		
export t_DLSearch2Response := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_DLSearch2Record) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.DL.MaxCountDL)};
	integer RecordCount {xpath('RecordCount')};
end;
		
export t_DLReport2By := record
	string UniqueId {xpath('UniqueId')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string DLSequenceId {xpath('DLSequenceId')};//hidden[internal]
end;
		
export t_DLReport2Options := record (share.t_BaseOption)
	boolean IncludeEverything {xpath('IncludeEverything')};
	boolean IncludeConvictions {xpath('IncludeConvictions')};
	boolean IncludeAccidents {xpath('IncludeAccidents')};
	boolean IncludeDRInfo {xpath('IncludeDRInfo')};
	boolean IncludeFRAInsurance {xpath('IncludeFRAInsurance')};
	boolean IncludeSuspensions {xpath('IncludeSuspensions')};
	boolean IncludeNonDMVSources {xpath('IncludeNonDMVSources')};
end;
		
export t_DLReport2DLConvictionPoint := record
	dataset(t_DLReport2Record) DriverLicenses {xpath('DriverLicenses/DriverLicense'), MAXCOUNT(1)};
	dataset(t_DLReport2Accident) Accidents {xpath('Accidents/Accident'), MAXCOUNT(1)};
	dataset(t_DLReport2Conviction) Convictions {xpath('Convictions/Conviction'), MAXCOUNT(1)};
	dataset(t_DLReport2DRInfo) DRInfo {xpath('DRInfo/DRInfoRec'), MAXCOUNT(1)};
	dataset(t_DLReport2FRAInsurance) FRAInsurances {xpath('FRAInsurances/FRAInsurance'), MAXCOUNT(1)};
	dataset(t_DLReport2Suspension) Suspensions {xpath('Suspensions/Suspension'), MAXCOUNT(1)};
end;
		
export t_DLReport2Response := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_DLReport2DLConvictionPoint) DLConvictionPoints {xpath('DLConvictionPoints/DLConvictionPoint'), MAXCOUNT(iesp.constants.DL.MaxCountDL)};
	integer RecordCount {xpath('RecordCount')};
end;
		
export t_RandDLSearch2By := record
	string State {xpath('State')};
	string Gender {xpath('Gender')};
	string Race {xpath('Race')};
	share.t_IntRange AgeRange {xpath('AgeRange')};
end;
		
export t_RandDLSearch2Option := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean IncludeNonDMVSources {xpath('IncludeNonDMVSources')};
end;
		
export t_RandDLSearch2Response := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_DLSearch2Record) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.DL.MaxCountDL)};
end;
		
export t_DLSearch2Request := record (share.t_BaseRequest)
	t_DLSearch2Options Options {xpath('Options')};
	t_DLSearch2By SearchBy {xpath('SearchBy')};
end;
		
export t_DLReport2Request := record (share.t_BaseRequest)
	t_DLReport2Options Options {xpath('Options')};
	t_DLReport2By ReportBy {xpath('ReportBy')};
end;
		
export t_RandDLSearch2Request := record (share.t_BaseRequest)
	t_RandDLSearch2By SearchBy {xpath('SearchBy')};
	t_RandDLSearch2Option Options {xpath('Options')};
end;
		
export t_DLSearch2ResponseEx := record
	t_DLSearch2Response response {xpath('response')};
end;
		
export t_DLReport2ResponseEx := record
	t_DLReport2Response response {xpath('response')};
end;
		
export t_RandDLSearch2ResponseEx := record
	t_RandDLSearch2Response response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from driverlicense2.xml. ***/
/*===================================================*/

