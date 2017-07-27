export civilcourt := MODULE
			
export t_CivilCourtSearchOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_CivilCourtSearchBy := record
	share.t_Name Name {xpath('Name')};
	string70 CompanyName {xpath('CompanyName')};
	string2 State {xpath('State')};
	string25 City {xpath('City')};
	string60 Jurisdiction {xpath('Jurisdiction')};
end;
		
export t_CivilCourtSearchRecord := record
	integer _Penalty {xpath('Penalty')};//hidden[ecldev]
	boolean AlsoFound {xpath('AlsoFound')};
	string175 CaseTitle {xpath('CaseTitle')};
	string60 CaseId {xpath('CaseId')};
	string60 CaseType {xpath('CaseType')};
	string30 PartyType {xpath('PartyType')};
	string80 PartyName {xpath('PartyName')};
	string25 City {xpath('City')};
	string2 State {xpath('State')};
	string25 StateOfOrigin {xpath('StateOfOrigin')};
	string60 Jurisdiction {xpath('Jurisdiction')};
	string80 PrimaryEntity {xpath('PrimaryEntity')};
	string30 EntityTypeDescription {xpath('EntityTypeDescription')};
	dataset(share.t_StringArrayItem) EntityAddresses {xpath('EntityAddresses/EntityAddress'), MAXCOUNT(iesp.constants.MAX_COUNT_CIVIL_COURT_ENTITES)};
end;
		
export t_CivilCourtSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_CivilCourtSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_CivilCourtReportBy := record
	string CaseId {xpath('CaseId')};
end;
		
export t_CivilCourtReportOption := record (share.t_BaseReportOption)
end;
		
export t_CivilCourtReportParty := record
	string20 Ruling {xpath('Ruling')};
	string30 PartyType {xpath('PartyType')};
	string80 PartyName {xpath('PartyName')};
	share.t_Address Address {xpath('Address')};
	string30 PartyType2 {xpath('PartyType2')};
	string80 PartyName2 {xpath('PartyName2')};
	share.t_Address Address2 {xpath('Address2')};
end;
		
export t_CivilCourtReportEvent := record
	share.t_Date Date {xpath('Date')};
	string EventType {xpath('EventType')};
end;
		
export t_CivilCourtReportFiling := record
	share.t_Date FilingDate {xpath('FilingDate')};
	string50 FilingManner {xpath('FilingManner')};
	share.t_Date JudgmentDate {xpath('JudgmentDate')};
	string50 JudgmentManner {xpath('JudgmentManner')};
	string65 JudgmentType {xpath('JudgmentType')};
	string65 JudgmentDisposition {xpath('JudgmentDisposition')};
	share.t_Date DispositionDate {xpath('DispositionDate')};
	string65 Disposition {xpath('Disposition')};
	string15 SuitAmount {xpath('SuitAmount')};
	string15 AwardAmount {xpath('AwardAmount')};
	string60 Cause {xpath('Cause')};
	string20 Ruling {xpath('Ruling')};
end;
		
export t_CivilCourtReportRecord := record
	string175 CaseTitle {xpath('CaseTitle')};
	string60 CaseType {xpath('CaseType')};
	string35 CaseNumber {xpath('CaseNumber')};
	string25 State {xpath('State')};
	string60 Court {xpath('Court')};
	dataset(t_CivilCourtReportParty) Parties {xpath('Parties/Party'), MAXCOUNT(iesp.constants.MAX_COUNT_CIVIL_COURT_REPORT_RESPONSE_RECORDS)};
	dataset(t_CivilCourtReportEvent) Events {xpath('Events/Event'), MAXCOUNT(iesp.constants.MAX_COUNT_CIVIL_COURT_REPORT_RESPONSE_RECORDS)};
	dataset(t_CivilCourtReportFiling) Filings {xpath('Filings/Filing'), MAXCOUNT(iesp.constants.MAX_COUNT_CIVIL_COURT_REPORT_RESPONSE_RECORDS)};
end;
		
export t_CivilCourtReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_CivilCourtReportRecord CivilCourtRecord {xpath('CivilCourtRecord')};
end;
		
export t_CivilCourtSearchRequest := record (share.t_BaseRequest)
	t_CivilCourtSearchBy SearchBy {xpath('SearchBy')};
	t_CivilCourtSearchOption Options {xpath('Options')};
end;
		
export t_CivilCourtReportRequest := record (share.t_BaseRequest)
	t_CivilCourtReportOption Options {xpath('Options')};
	t_CivilCourtReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_CivilCourtSearchResponseEx := record
	t_CivilCourtSearchResponse response {xpath('response')};
end;
		
export t_CivilCourtReportResponseEx := record
	t_CivilCourtReportResponse response {xpath('response')};
end;
		

end;

