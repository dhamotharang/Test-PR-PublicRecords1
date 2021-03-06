/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from nac2_search.xml. ***/
/*===================================================*/

import iesp;

export nac2_search := MODULE
			
export t_NAC2SearchOptions := record (iesp.share.t_BaseOption)
	boolean InvestigativePurpose {xpath('InvestigativePurpose')};
	boolean IncludeEligibilityHistory {xpath('IncludeEligibilityHistory')};
	boolean IncludeInterstateAllPrograms {xpath('IncludeInterstateAllPrograms')};
	boolean IsOnline {xpath('IsOnline')};//hidden[internal]
	string ProdDataTestMode {xpath('ProdDataTestMode')};//hidden[internal]
end;
		
export t_NAC2EndUser := record
	string LoginId {xpath('LoginId')};
	string IP {xpath('IP')};
	string UserName {xpath('UserName')};
end;
		
export t_NAC2Name := record
	string30 LastName {xpath('LastName')};
	string25 FirstName {xpath('FirstName')};
	string25 MiddleName {xpath('MiddleName')};
	string5 SuffixName {xpath('SuffixName')};
end;
		
export t_NAC2Address := record
	string200 StreetAddress1 {xpath('StreetAddress1')};
	string200 StreetAddress2 {xpath('StreetAddress2')};
	string30 City {xpath('City')};
	string2 State {xpath('State')};
	string9 Zip {xpath('Zip')};
end;
		
export t_NAC2Identity := record (t_NAC2Name)
	string62 FullName {xpath('FullName')};
	t_NAC2Address Address1 {xpath('Address1')};
	t_NAC2Address Address2 {xpath('Address2')};
	string9 SSN {xpath('SSN')};
	string8 DOB {xpath('DOB')};
	string1 ProgramCode {xpath('ProgramCode')};
	string1 EligibilityRangeType {xpath('EligibilityRangeType')};
	string8 EligibilityStart {xpath('EligibilityStart')};
	string8 EligibilityEnd {xpath('EligibilityEnd')};
	string20 CaseIdentifier {xpath('CaseIdentifier')};
	string20 ClientIdentifier {xpath('ClientIdentifier')};
end;
		
export t_NAC2Investigative := record
	string2 ProgramState {xpath('ProgramState')};
	string1 EligibilityStatus {xpath('EligibilityStatus')};
end;
		
export t_NAC2Search := record
	string2 SourceState {xpath('SourceState')};//hidden[internal]
	string32 ProgramsAllowedSearch {xpath('ProgramsAllowedSearch')};//hidden[internal]
	string32 ProgramsAllowedReturned {xpath('ProgramsAllowedReturned')};//hidden[internal]
	string4 NacGroupId {xpath('NacGroupId')};//hidden[internal]
	t_NAC2Identity Identity {xpath('Identity')};
	t_NAC2Investigative InvestigativeFields {xpath('InvestigativeFields')};
	unsigned PenaltThreshold {xpath('PenaltThreshold')};//hidden[ecldev]
end;
		
export t_NAC2AddressOut := record (t_NAC2Address)
	string1 AddressCategory {xpath('AddressCategory')};
end;
		
export t_NAC2Case := record (t_NAC2Name)
	string20 CaseIdentifier {xpath('CaseIdentifier')};
	string2 ProgramState {xpath('ProgramState')};
	string1 ProgramCode {xpath('ProgramCode')};
	string10 Phone1 {xpath('Phone1')};
	string10 Phone2 {xpath('Phone2')};
	string256 Email {xpath('Email')};
	t_NAC2AddressOut PhysicalAddress {xpath('PhysicalAddress')};
	t_NAC2AddressOut MailingAddress {xpath('MailingAddress')};
	string3 CountyParishCode {xpath('CountyParishCode')};
	string25 CountyParishName {xpath('CountyParishName')};
	string10 MonthlyAllotment {xpath('MonthlyAllotment')};
	string3 RegionCode {xpath('RegionCode')};
end;
		
export t_NAC2Exception := record
	string3 ReasonCode {xpath('ReasonCode')};
	string50 Comment {xpath('Comment')};
end;
		
export t_NAC2Client := record (t_NAC2Name)
	string20 ClientIdentifier {xpath('ClientIdentifier')};
	string1 Gender {xpath('Gender')};
	string1 Race {xpath('Race')};
	string1 Ethnicity {xpath('Ethnicity')};
	string10 Phone {xpath('Phone')};
	string256 Email {xpath('Email')};
	string9 SSN {xpath('SSN')};
	string1 SsnTypeIndicator {xpath('SsnTypeIndicator')};
	string8 DOB {xpath('DOB')};
	string1 DobTypeIndicator {xpath('DobTypeIndicator')};
	string10 MonthlyAllotment {xpath('MonthlyAllotment')};
	string1 HohIndicator {xpath('HohIndicator')};
	string1 AbawdIndicator {xpath('AbawdIndicator')};
	string1 RelationshipIndicator {xpath('RelationshipIndicator')};
	string20 CertificateIdType {xpath('CertificateIdType')};
	string5 HistoricalBenefitCount {xpath('HistoricalBenefitCount')};
	t_NAC2Exception Exception {xpath('Exception')};
end;
		
export t_NAC2StateContact := record
	string50 Name {xpath('Name')};
	string10 Phone {xpath('Phone')};
	string10 PhoneExtension {xpath('PhoneExtension')};
	string256 Email {xpath('Email')};
end;
		
export t_NAC2Eligibility := record
	string1 StatusIndicator {xpath('StatusIndicator')};
	string8 StatusDate {xpath('StatusDate')};
	string1 PeriodType {xpath('PeriodType')};
	string8 PeriodStart {xpath('PeriodStart')};
	string8 PeriodEnd {xpath('PeriodEnd')};
	string6 PeriodCountDays {xpath('PeriodCountDays')};
	string4 PeriodCountMonths {xpath('PeriodCountMonths')};
end;
		
export t_NAC2MatchInnerHistory := record
	string20 CaseIdentifier {xpath('CaseIdentifier')};
	string1 StatusIndicator {xpath('StatusIndicator')};
	string8 PeriodStart {xpath('PeriodStart')};
	string8 PeriodEnd {xpath('PeriodEnd')};
	string6 PeriodCountDays {xpath('PeriodCountDays')};
	string4 PeriodCountMonths {xpath('PeriodCountMonths')};
	string10 Matchcode {xpath('Matchcode')};
	string4 LexIdScore {xpath('LexIdScore')};
end;
		
export t_NAC2MatchHistory := record
	string6 TotalEligiblePeriodCountDays {xpath('TotalEligiblePeriodCountDays')};
	string4 TotalEligiblePeriodCountMonths {xpath('TotalEligiblePeriodCountMonths')};
	dataset(t_NAC2MatchInnerHistory) MatchInnerHistories {xpath('MatchInnerHistories/MatchInnerHistory'), MAXCOUNT(60)};
end;
		
export t_NAC2InvestigativeHistory := record
	string8 EarliestStart {xpath('EarliestStart')};
	string8 LatestEnd {xpath('LatestEnd')};
	string5 TotalRecords {xpath('TotalRecords')};
end;
		
export t_NAC2Record := record
	string4 NacGroupId {xpath('NacGroupId')};
	t_NAC2Case Case {xpath('Case')};
	t_NAC2Client Client {xpath('Client')};
	t_NAC2StateContact StateContact {xpath('StateContact')};
	t_NAC2Eligibility Eligibility {xpath('Eligibility')};
	t_NAC2InvestigativeHistory InvestigativeHistory {xpath('InvestigativeHistory')};
	t_NAC2MatchHistory MatchHistory {xpath('MatchHistory')};
end;
		
export t_NAC2SearchResultRecord := record
	t_NAC2Record NAC2Record {xpath('NAC2Record')};
	string10 MatchCode {xpath('MatchCode')};
	unsigned2 LexIdScore {xpath('LexIdScore')};
	unsigned4 SequenceNumber {xpath('SequenceNumber')};
	unsigned6 LexId {xpath('LexId')};//hidden[ecldev]
	unsigned2 _Penalty {xpath('Penalty')};//hidden[ecldev]
end;
		
export t_NAC2SearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_NAC2SearchResultRecord) Records {xpath('Records/Record'), MAXCOUNT(60)};
end;
		
export t_NAC2SearchRequest := record (iesp.share.t_BaseRequest)
	t_NAC2SearchOptions Options {xpath('Options')};
	t_NAC2EndUser EndUser {xpath('EndUser')};
	t_NAC2Search SearchBy {xpath('SearchBy')};
end;
		
export t_NAC2SearchResponseEx := record
	t_NAC2SearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from nac2_search.xml. ***/
/*===================================================*/

