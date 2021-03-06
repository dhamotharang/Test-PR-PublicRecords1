/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from riskviewreport.xml. ***/
/*===================================================*/

import iesp;

export riskviewreport := MODULE
			
export t_RvReportSummaryRecord := record
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string9 SSN {xpath('SSN')};
	string10 Phone {xpath('Phone')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string1 AddressStability {xpath('AddressStability')};
	boolean InquiriesRestricted {xpath('InquiriesRestricted')};
	string12 UniqueId {xpath('UniqueId')};
end;
		
export t_RvReportAddressHistoryRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date From {xpath('From')};
	iesp.share.t_Date To {xpath('To')};
	string32 Characteristics {xpath('Characteristics')};
	string120 LandUse {xpath('LandUse')};
	string8 AssessedValue {xpath('AssessedValue')};
	iesp.share.t_Date AssessedDate {xpath('AssessedDate')};
end;
		
export t_RvReportRealPropertyRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Address Address {xpath('Address')};
	string16 Status {xpath('Status')};
	iesp.share.t_Date PurchaseDate {xpath('PurchaseDate')};
	string8 PurchasePrice {xpath('PurchasePrice')};
	iesp.share.t_Date SaleDate {xpath('SaleDate')};
	string8 SalePrice {xpath('SalePrice')};
	string8 AssessedValue {xpath('AssessedValue')};
	iesp.share.t_Date AssessedDate {xpath('AssessedDate')};
end;
		
export t_RvReportPersonalPropertyRecord := record
	string2 Seq {xpath('Seq')};
	string16 _Type {xpath('Type')};
	string32 Description {xpath('Description')};
	string16 Id {xpath('Id')};
	iesp.share.t_Date RegistrationDate {xpath('RegistrationDate')};
	string2 RegistrationState {xpath('RegistrationState')};
end;
		
export t_RvReportFilingRecord := record
	string2 Seq {xpath('Seq')};
	string16 RecordType {xpath('RecordType')};
	string32 Description {xpath('Description')};
	string16 Status {xpath('Status')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date LastActionDate {xpath('LastActionDate')};
end;
		
export t_RvReportBankruptcyRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Name Name {xpath('Name')};
	string7 CaseNumber {xpath('CaseNumber')};
	string3 Chapter {xpath('Chapter')};
	string50 CourtName {xpath('CourtName')};
	string40 CourtLocation {xpath('CourtLocation')};
	string35 Disposition {xpath('Disposition')};
	iesp.share.t_Date FilingDate {xpath('FilingDate')};
	iesp.share.t_Date LastActionDate {xpath('LastActionDate')};
end;
		
export t_RvReportCriminalRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string9 SSN {xpath('SSN')};
	string16 State {xpath('State')};
	string35 CaseNumber {xpath('CaseNumber')};
	iesp.share.t_Date OffenseDate {xpath('OffenseDate')};
	string35 Charge {xpath('Charge')};
	string32 LevelDegree {xpath('LevelDegree')};
	string16 _Type {xpath('Type')};
end;
		
export t_RvReportEducationRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string32 SchoolCode {xpath('SchoolCode')};
	string32 SchoolType {xpath('SchoolType')};
	string50 SchoolName {xpath('SchoolName')};
	string64 FieldOfStudy {xpath('FieldOfStudy')};
end;
		
export t_RvReportLicenseRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string60 _Type {xpath('Type')};
	iesp.share.t_Date LastReported {xpath('LastReported')};
	string60 Source {xpath('Source')};
end;
		
export t_RvReportBusinessAssociationRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	string35 Title {xpath('Title')};
	string120 Company {xpath('Company')};
	iesp.share.t_Address CompanyAddress {xpath('CompanyAddress')};
	string10 Status {xpath('Status')};
	iesp.share.t_Date FirstReport {xpath('FirstReport')};
	iesp.share.t_Date LastReport {xpath('LastReport')};
end;
		
export t_RvReportLoanOfferRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date Date {xpath('Date')};
end;
		
export t_RvReportCreditInquiryRecord := record
	string2 Seq {xpath('Seq')};
	iesp.share.t_Date Date {xpath('Date')};
	string32 _Type {xpath('Type')};
	string32 Industry {xpath('Industry')};
end;
		
export t_RiskViewReport := record
	t_RvReportSummaryRecord Summary {xpath('Summary')};
	dataset(t_RvReportAddressHistoryRecord) AddressHistories {xpath('AddressHistories/AddressHistory'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportRealPropertyRecord) RealProperties {xpath('RealProperties/RealProperty'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportPersonalPropertyRecord) PersonalProperties {xpath('PersonalProperties/PersonalProperty'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportFilingRecord) FilingRecords {xpath('FilingRecords/FilingRecord'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportBankruptcyRecord) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportCriminalRecord) CriminalRecords {xpath('CriminalRecords/Criminal'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportEducationRecord) EducationRecords {xpath('EducationRecords/Education'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportLicenseRecord) Licenses {xpath('Licenses/License'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportBusinessAssociationRecord) BusinessAssociations {xpath('BusinessAssociations/BusinessAssociation'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportLoanOfferRecord) LoanOffers {xpath('LoanOffers/LoanOffer'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	dataset(t_RvReportCreditInquiryRecord) CreditInquiries {xpath('CreditInquiries/CreditInquiry'), MAXCOUNT(iesp.constants.riskview_report.MaxRecords)};
	string8 EstimatedIncome {xpath('EstimatedIncome')};
	string2000 ConsumerStatement {xpath('ConsumerStatement')};
end;
		
export t_RiskViewReportOptions := record (iesp.share.t_BaseOption)
	iesp.riskview_share.t_RiskViewModels IncludeModels {xpath('IncludeModels')};
	string50 IntendedPurpose {xpath('IntendedPurpose')}; //values['Application','Prescreening','Portfolio Review','Insurance Application','Insurance Portfolio Review','Disclosure','Government','Collections','Tenant Screening','Healthcare Credit Transaction','Healthcare Legitimate Business Need','Rental Car Loss Damage Waiver','Employee or Volunteer Screening','Written Consent Prequalification','Rental Car','Written Consent','Child Support','Demand Deposit','Written Consent Direct to Consumer','Credit Application','']
	string30 DaytonRiskViewSubscriptionNumber {xpath('DaytonRiskViewSubscriptionNumber')};//hidden[internal]
	string20 FFDOptionsMask {xpath('FFDOptionsMask')};//hidden[ecl_only]
end;
		
export t_RiskViewReportSearchBy := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	integer Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string4 SSNLast4 {xpath('SSNLast4')};
	string15 DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string45 IPAddress {xpath('IPAddress')};
	string10 HomePhone {xpath('HomePhone')};
	string10 WorkPhone {xpath('WorkPhone')};
end;
		
export t_RvReportScoreHRI := record
	string16 _Type {xpath('Type')};
	integer Value {xpath('Value')};
	dataset(iesp.share.t_SequencedRiskIndicator) HighRiskIndicators {xpath('HighRiskIndicators/HighRiskIndicator'), MAXCOUNT(8)};
end;
		
export t_RvReportModelHRI := record
	string16 Name {xpath('Name')};
	dataset(t_RvReportScoreHRI) Scores {xpath('Scores/Score'), MAXCOUNT(3)};
end;
		
export t_RiskViewReportResult := record
	t_RiskViewReportSearchBy InputEcho {xpath('InputEcho')};
	dataset(t_RvReportModelHRI) Models {xpath('Models/Model'), MAXCOUNT(iesp.constants.riskview_report.MaxModels)};
	t_RiskViewReport Report {xpath('Report')};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
	iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};//hidden[ecl_only]
end;
		
export t_RiskViewReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_RiskViewReportResult Result {xpath('Result')};
end;
		
export t_RiskViewReportRequest := record (iesp.share.t_BaseRequest)
	t_RiskViewReportOptions Options {xpath('Options')};
	t_RiskViewReportSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_RiskViewReportResponseEx := record
	t_RiskViewReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from riskviewreport.xml. ***/
/*===================================================*/

