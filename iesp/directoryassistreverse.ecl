export directoryassistreverse := MODULE
			
export t_ReverseSearchBy := record
	string Phone7 {xpath('Phone7')};
	string Phone10 {xpath('Phone10')};
	string State {xpath('State')};
end;
		
export t_ReverseOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_ReverseRecord := record
	string Phone10 {xpath('Phone10')};
	string TimeZone {xpath('TimeZone')};
	string CaptionText {xpath('CaptionText')};
	string CompanyName {xpath('CompanyName')};
	string ListingType {xpath('ListingType')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	dataset(share.t_StringArrayItem) ListingTypes {xpath('ListingTypes/ListingType'), MAXCOUNT(1)};
end;
		
export t_ReversePhoneRecord := record (t_ReverseRecord)
end;

export t_MessageCode := record
	string MessageNumber {xpath('MessageNumber')};
	string Description {xpath('Description')};
end;
		
export t_ReverseSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	string PhoneType {xpath('PhoneType')};
	dataset(t_ReverseRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_ReverseSearchRequest := record (share.t_BaseRequest)
	t_ReverseSearchBy SearchBy {xpath('SearchBy')};
	t_ReverseOption Options {xpath('Options')};
end;
		
export t_ReverseSearchResponseEx := record
	t_ReverseSearchResponse response {xpath('response')};
end;
		

end;

