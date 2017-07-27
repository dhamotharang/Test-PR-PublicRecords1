export addressprefill := MODULE
			
export t_AddressPreFillOption := record (share.t_BaseSearchOption)
end;
		
export t_AddressPreFillBy := record
	string PhoneNumber {xpath('PhoneNumber')};
	string LastName {xpath('LastName')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_AddressPreFillRecord := record
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	share.t_Name Name {xpath('Name')};
	string CompanyName {xpath('CompanyName')};
	string PhoneNumber {xpath('PhoneNumber')};
	string AddressType {xpath('AddressType')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_StateRecordCount := record
	string State {xpath('State')};
	string StateName {xpath('StateName')};
	integer Count {xpath('Count')};
end;
		
export t_AddressPreFillResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	boolean IsMultiStateReturn {xpath('IsMultiStateReturn')};
	dataset(t_StateRecordCount) StateRecordCounts {xpath('StateRecordCounts/RecordCount'), MAXCOUNT(1)};
	dataset(t_AddressPreFillRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_AddressPreFillRequest := record (share.t_BaseRequest)
	t_AddressPreFillOption Options {xpath('Options')};
	t_AddressPreFillBy SearchBy {xpath('SearchBy')};
end;
		
export t_AddressPreFillResponseEx := record
	t_AddressPreFillResponse response {xpath('response')};
end;
		

end;

