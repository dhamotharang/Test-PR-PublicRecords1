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

Layout_Person := RECORD
	string FirstName {xpath('FirstName')} := '';
	string MiddleName {xpath('MiddleName')} := '';
	string LastName {xpath('LastName')} := '';
	Layout_Date DOB {xpath('DOB')};
END;

Layout_Address := RECORD
	string FullStreet {xpath('FullStreet')} := '';
	string StreetName {xpath('StreetName')} := '';
	string StreetType {xpath('StreetType')} := '';
	string BuildingNumber {xpath('BuildingNumber')} := '';
	string SubBuildingNumber {xpath('SubBuildingNumber')} := '';
	string CityTown {xpath('CityTown')} := '';
	string StateDistrict {xpath('StateDistrict')} := '';
	string PostalCode {xpath('PostalCode')} := '';
	string Country {xpath('Country')} := '';
	string CountryCode {xpath('CountryCode')} := '';
	string County {xpath('County')} := '';
END;

Layout_SearchBy := RECORD
	Layout_Person Person {xpath('Person')};
	Layout_Address Address {xpath('Address')};
	string PhoneNumber {xpath('PhoneNumber')} := '';
	string IdNumber {xpath('IdNumber')} := '';
END;

Layout_SearchOptions := RECORD
	string SubAccount {xpath('SubAccount')} := '';
	string CreditFlag {xpath('CreditFlag')} := '0';
END;

export Layout_GDCVerify_In := RECORD
	Layout_User User {xpath('User')};
	Layout_SearchBy SearchBy {xpath('SearchBy')};
	Layout_SearchOptions SearchOptions {xpath('Options')};
END;
