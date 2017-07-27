export patriotsearch := MODULE
			
export t_PatriotSearchBy := record
	string CompanyName {xpath('CompanyName')};
	string VesselName {xpath('VesselName')};
	string Country {xpath('Country')};
	share.t_Name Name {xpath('Name')};
end;
		
export t_PatriotOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean OFACSearchOnly {xpath('OFACSearchOnly')};
end;
		
export t_PatriotRecord := record
	string PartyKey {xpath('PartyKey')};
	string Source {xpath('Source')};
	string PartyName {xpath('PartyName')};
	string VesselName {xpath('VesselName')};
	string CompanyName {xpath('CompanyName')};
	string Score {xpath('Score')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string OtherNames {xpath('OtherNames')};
	dataset(share.t_StringArrayItem) RawAddressData {xpath('RawAddressData/Item'), MAXCOUNT(1)};
	dataset(share.t_StringArrayItem) Remarks {xpath('Remarks/Item'), MAXCOUNT(1)};
end;
		
export t_PatriotSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_PatriotRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_PatriotSearchRequest := record (share.t_BaseRequest)
	t_PatriotOption Options {xpath('Options')};
	t_PatriotSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_PatriotSearchResponseEx := record
	t_PatriotSearchResponse response {xpath('response')};
end;
		

end;

