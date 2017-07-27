Layout_GatewayParams := record
	string16 	TxnTransactionId {xpath('TxnTransactionId')} := '';
	integer 	BatchJobId {xpath('BatchJobId')} := 0;
	integer 	ProcessSpecId {xpath('ProcessSpecId')} := 0;
	integer 	RoyaltyCode {xpath('RoyaltyCode')} := 0;
	string50 	RoyaltyType {xpath('RoyaltyType')} := '';
	string80 	QueryName {xpath('QueryName')} := '';
	boolean	 	CheckVendorGatewayCall {xpath('CheckVendorGatewayCall')} := false;//hidden[internal]
	boolean  	MakeVendorGatewayCall {xpath('MakeVendorGatewayCall')} := false; //hidden[internal]
end;

Layout_User := RECORD
	string ReferenceCode {xpath('ReferenceCode')} := '';
	string BillingCode {xpath('BillingCode')} := ''; 
	string QueryId {xpath('QueryId')} := '';
	string GLBPurpose {xpath('GLBPurpose')} := '5';
	string DLPurpose {xpath('DLPurpose')} := '0';
END;

Layout_Date := RECORD
	unsigned2 Year {xpath('Year')} := 0;
	unsigned1 Month {xpath('Month')} := 0;
	unsigned1 Day {xpath('Day')} := 0;
END;

Layout_Person_Unicode := RECORD
	unicode FirstName {xpath('FirstName')} := U'';
	unicode MiddleName {xpath('MiddleName')} := U'';
	unicode LastName {xpath('LastName')} := U'';
	Layout_Date DOB {xpath('DOB')};
END;

Layout_Address_Unicode := RECORD
	unicode FullStreet {xpath('FullStreet')} := U'';
	unicode StreetName {xpath('StreetName')} := U'';
	unicode StreetType {xpath('StreetType')} := U'';
	unicode BuildingNumber {xpath('BuildingNumber')} := U'';
	unicode SubBuildingNumber {xpath('SubBuildingNumber')} := U'';
	unicode Aza {xpath('Aza')} := U'';
	unicode CityTown {xpath('CityTown')} := U'';
	unicode StateDistrict {xpath('StateDistrict')} := U'';
	unicode PostalCode {xpath('PostalCode')} := U'';
	string Country {xpath('Country')} := '';
	string CountryCode {xpath('CountryCode')} := '';
	unicode County {xpath('County')} := U'';
END;

Layout_SearchBy_Unicode := RECORD
	Layout_Person_Unicode Person {xpath('Person')};
	Layout_Address_Unicode Address {xpath('Address')};
	string PhoneNumber {xpath('PhoneNumber')} := '';
	string IdNumber {xpath('IdNumber')} := '';
END;

Layout_SearchOptions := RECORD
	string SubAccount {xpath('SubAccount')} := '';
	string CreditFlag {xpath('CreditFlag')} := '0';
	boolean Blind {xpath('Blind')} := false;//hidden[internal] 
END;

export Layout_GDCVerify_In_Unicode := RECORD
	Layout_GatewayParams GatewayParams {xpath('GatewayParams')};
	Layout_User User {xpath('User')};
	Layout_SearchBy_Unicode SearchBy {xpath('SearchBy')};
	Layout_SearchOptions SearchOptions {xpath('Options')};
END;
