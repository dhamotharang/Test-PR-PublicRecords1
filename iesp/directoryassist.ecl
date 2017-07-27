export directoryassist := MODULE
			
export t_AssistSearchBy := record
	string CompanyName {xpath('CompanyName')};
	integer Radius {xpath('Radius')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_AssistOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean ExcludeResultsInGivenCity {xpath('ExcludeResultsInGivenCity')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean IncludeResidence {xpath('IncludeResidence')};
	boolean IncludeBusiness {xpath('IncludeBusiness')};
end;
		
export t_AssistRecord := record
	string Phone10 {xpath('Phone10')};
	string TimeZone {xpath('TimeZone')};
	string CaptionText {xpath('CaptionText')};
	string CompanyName {xpath('CompanyName')};
	string ListingType {xpath('ListingType')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_AssistSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_AssistRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_AssistSearchRequest := record (share.t_BaseRequest)
	t_AssistSearchBy SearchBy {xpath('SearchBy')};
	t_AssistOption Options {xpath('Options')};
end;
		
export t_AssistSearchResponseEx := record
	t_AssistSearchResponse response {xpath('response')};
end;
		

end;

