export globalwatchlist := MODULE
			
export t_GlobalWatchListSearchBy := record
	share.t_Name Name {xpath('Name')};
	string Country {xpath('Country')};
	share.t_Date DOB {xpath('DOB')};
	integer BirthYearRadius {xpath('BirthYearRadius')};
end;
		
export t_GlobalWatchListSearchOption := record (share.t_BaseSearchOption)
	real8 Threshold {xpath('Threshold')};
	boolean OFACOnly {xpath('OFACOnly')};
	string SearchType {xpath('SearchType')};
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_GlobalWatchListSearchAddress := record
	string100 Country {xpath('Country')};
	dataset(share.t_StringArrayItem) AddressLines {xpath('AddressLines/Line'), MAXCOUNT(constants.Patriot.MaxAddressLines)};
end;
		
export t_GlobalWatchListSearchAKA := record
	string350 PartyName {xpath('PartyName')};
	real8 MatchScore {xpath('MatchScore')};
end;
		
export t_GlobalWatchListSearchRecord := record
	string1 RecordType {xpath('RecordType')};
	real8 MaxMatchScore {xpath('MaxMatchScore')};
	string60 DataSource {xpath('DataSource')};
	string20 PartyKey {xpath('PartyKey')};
	string350 PartyName {xpath('PartyName')};
	string100 BlockedCountry {xpath('BlockedCountry')};
	dataset(t_GlobalWatchListSearchAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(constants.Patriot.MaxAddresses)};
	dataset(t_GlobalWatchListSearchAKA) AKAs {xpath('AKAs/AKA'), MAXCOUNT(constants.Patriot.MaxAkas)};
	dataset(share.t_StringArrayItem) Remarks {xpath('Remarks/Remark'), MAXCOUNT(constants.Patriot.MaxRemarks)};
end;
		
export t_GlobalWatchListSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_GlobalWatchListSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_GlobalWatchListSearchRequest := record (share.t_BaseRequest)
	t_GlobalWatchListSearchOption Options {xpath('Options')};
	t_GlobalWatchListSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_GlobalWatchListSearchResponseEx := record
	t_GlobalWatchListSearchResponse response {xpath('response')};
end;
		

end;

