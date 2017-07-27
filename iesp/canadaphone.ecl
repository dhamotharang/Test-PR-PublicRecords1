export canadaphone := MODULE
			
export t_CanadianPhoneSearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string PhoneNumber {xpath('PhoneNumber')};
end;
		
export t_CanadianPhoneSearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean UsePhonetics {xpath('UsePhonetics')};
end;
		
export t_CanadianPhoneSearchRecord := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string PhoneNumber {xpath('PhoneNumber')};
end;
		
export t_CanadianPhoneSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_CanadianPhoneSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_CanadianPhoneSearchRequest := record (share.t_BaseRequest)
	t_CanadianPhoneSearchOption Options {xpath('Options')};
	t_CanadianPhoneSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_CanadianPhoneSearchResponseEx := record
	t_CanadianPhoneSearchResponse response {xpath('response')};
end;
		

end;

