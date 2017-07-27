export changeofaddress := MODULE
			
export t_ChangeOfAddressBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_ChangeOfAddressOption := record (share.t_BaseOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_COAAddress := record
	share.t_Address Address {xpath('Address')};
	share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_AddressChange := record
	share.t_Name Name {xpath('Name')};
	t_COAAddress PreviousAddress {xpath('PreviousAddress')};
	t_COAAddress CurrentAddress {xpath('CurrentAddress')};
end;
		
export t_ChangeOfAddressResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	share.t_Name InputName {xpath('InputName')};
	t_COAAddress InputAddress {xpath('InputAddress')};
	dataset(t_AddressChange) AddressChanges {xpath('AddressChanges/AddressChange'), MAXCOUNT(iesp.constants.COA_MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
end;
		
export t_ChangeOfAddressRequest := record (share.t_BaseRequest)
	t_ChangeOfAddressBy SearchBy {xpath('SearchBy')};
	t_ChangeOfAddressOption Options {xpath('Options')};
end;
		
export t_ChangeOfAddressResponseEx := record
	t_ChangeOfAddressResponse response {xpath('response')};
end;
		

end;

