export nationalsanction := MODULE
			
export t_NationalSanctionSearchBy := record (share.t_BaseSearchBy)
	string BatchNumber {xpath('BatchNumber')};
	string CaseNumber {xpath('CaseNumber')};
	string IncidentNumber {xpath('IncidentNumber')};
	share.t_Name PartyName {xpath('PartyName')};
	string CompanyName {xpath('CompanyName')};
	share.t_Date IncidentDate {xpath('IncidentDate')};
end;
		
export t_NationalSanctionSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_OrderNumberAndText := record
	integer OrderNumber {xpath('OrderNumber')};
	string Text {xpath('Text')};
end;
		
export t_Party := record
	share.t_Name PartyName {xpath('PartyName')};
	string CompanyName {xpath('CompanyName')};
	string Position {xpath('Position')};
	string Vocation {xpath('Vocation')};
	string Firm {xpath('Firm')};
	share.t_Address IncidentAddress {xpath('IncidentAddress')};
	string SSN {xpath('SSN')};
	dataset(t_OrderNumberAndText) PartiesInfo {xpath('PartiesInfo/PartyInfo'), MAXCOUNT(1)};
end;
		
export t_NationalSanctionBaseRecord := record
	string BatchNumber {xpath('BatchNumber')};
	string IncidentNumber {xpath('IncidentNumber')};
	string CaseNumber {xpath('CaseNumber')};
	share.t_Date IncidentDate {xpath('IncidentDate')};
	string Jurisdiction {xpath('Jurisdiction')};
	string SourceDocument {xpath('SourceDocument')};
	string Agency {xpath('Agency')};
	dataset(t_OrderNumberAndText) IncidentsInfo {xpath('IncidentsInfo/IncidentInfo'), MAXCOUNT(1)};
	dataset(t_Party) Parties {xpath('Parties/Party'), MAXCOUNT(1)};
end;
		
export t_NationalSanctionSearchRecord := record (t_NationalSanctionBaseRecord)
end;
		
export t_NationalSanctionSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_NationalSanctionSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_NationalSanctionSearchRequest := record (share.t_BaseRequest)
	t_NationalSanctionSearchBy SearchBy {xpath('SearchBy')};
	t_NationalSanctionSearchOption Options {xpath('Options')};
end;
		
export t_NationalSanctionSearchResponseEx := record
	t_NationalSanctionSearchResponse response {xpath('response')};
end;
		

end;

