export officialrecord := MODULE
			
export t_OfficialRecSearchBy := record
	string2 State {xpath('State')};
	string30 County {xpath('County')};
	string80 CompanyName {xpath('CompanyName')};
	share.t_Name Name {xpath('Name')};
	share.t_DateRange FilingDateRange {xpath('FilingDateRange')};
end;
		
export t_OfficialRecOption := record (share.t_BaseSearchOptionEx)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_OfficialRecParty := record
	string50 PartyType {xpath('PartyType')};
	string80 Name {xpath('Name')};
end;
		
export t_OfficialRecRecord := record
	string60 OfficialRecordId {xpath('OfficialRecordId')};
	string60 DocumentType {xpath('DocumentType')};
	string2 State {xpath('State')};
	string30 County {xpath('County')};
	share.t_Date FilingDate {xpath('FilingDate')};
	dataset(t_OfficialRecParty) Parties {xpath('Parties/Party'), MAXCOUNT(iesp.Constants.OFFRECS_MAX_COUNT_PARTIES)};
end;
		
export t_OfficialRecSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_OfficialRecRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.OFFRECS_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_OfficialRecReportBy := record
	string60 OfficialRecordId {xpath('OfficialRecordId')};
end;
		
export t_OfficialRecReportOption := record (share.t_BaseReportOption)
end;
		
export t_OfficialRecReportRecord := record
	share.t_Date FilingDate {xpath('FilingDate')};
	string30 County {xpath('County')};
	string2 State {xpath('State')};
	string15 StateName {xpath('StateName')};
	string25 InstrumentFilingNumber {xpath('InstrumentFilingNumber')};
	string60 Description {xpath('Description')};
	string60 DocumentType {xpath('DocumentType')};
	string6 DocumentPages {xpath('DocumentPages')};
	string60 BookType {xpath('BookType')};
	string60 BookNumber {xpath('BookNumber')};
	string10 PageNumber {xpath('PageNumber')};
	string25 ConsiderationAmount {xpath('ConsiderationAmount')};
	string10 TransferAmount {xpath('TransferAmount')};
	string10 MortgageAmount {xpath('MortgageAmount')};
	string10 IntangibleTaxAmount {xpath('IntangibleTaxAmount')};
	share.t_Date ExecutionDate {xpath('ExecutionDate')};
	string30 Amendment {xpath('Amendment')};
	string25 PriorDocumentNumber {xpath('PriorDocumentNumber')};
	string60 PriorDocumentType {xpath('PriorDocumentType')};
	string10 PriorBookNumber {xpath('PriorBookNumber')};
	string60 PriorBookType {xpath('PriorBookType')};
	string10 PriorPageNumber {xpath('PriorPageNumber')};
	dataset(t_OfficialRecParty) Parties {xpath('Parties/Party'), MAXCOUNT(iesp.Constants.OFFRECS_MAX_COUNT_PARTIES)};
end;
		
export t_OfficialRecReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_OfficialRecReportRecord) OfficialRecords {xpath('OfficialRecords/OfficialRecord'), MAXCOUNT(iesp.Constants.OFFRECS_MAX_COUNT_REPORT_RESPONSE_RECORDS)};
end;
		
export t_OfficialRecSearchRequest := record (share.t_BaseRequest)
	t_OfficialRecSearchBy SearchBy {xpath('SearchBy')};
	t_OfficialRecOption Options {xpath('Options')};
end;
		
export t_OfficialRecReportRequest := record (share.t_BaseRequest)
	t_OfficialRecReportBy ReportBy {xpath('ReportBy')};
	t_OfficialRecReportOption Options {xpath('Options')};
end;
		
export t_OfficialRecSearchResponseEx := record
	t_OfficialRecSearchResponse response {xpath('response')};
end;
		
export t_OfficialRecReportResponseEx := record
	t_OfficialRecReportResponse response {xpath('response')};
end;
		

end;

