Layout_User := RECORD
	string ReferenceCode {xpath('ReferenceCode')} := '';
	string BillingCode {xpath('BillingCode')} := '';
	string QueryId {xpath('QueryId')} := '';
	string GLBPurpose {xpath('GLBPurpose')} := '5';
	string DLPurpose {xpath('DLPurpose')} := '0';
	// unsigned1 MaxWaitSeconds {xpath('MaxWaitSeconds')} := 0;
END;

Layout_Request_Details := RECORD
	string Profile {xpath('Profile')} := '';
	string SuccessCriteria {xpath('SuccessCriteria')} := '';
END;

Layout_Date := RECORD
	unsigned2 Year {xpath('Year')} := 0;
	unsigned1 Month {xpath('Month')} := 0;
	unsigned1 Day {xpath('Day')} := 0;
END;

Layout_GBPerson := RECORD
	string Title {xpath('Title')} := '';	
	string FirstName {xpath('FirstName')} := '';
	string MiddleName {xpath('MiddleName')} := '';
	string LastName {xpath('LastName')} := '';
	string Gender {xpath('Gender')} := '';	
	Layout_Date DOB {xpath('DOB')};
	string MothersMaidenName {xpath('MothersMaidenName')} := '';
END;

Layout_Address := RECORD
	string AddressLayout {xpath('AddressLayout')} := '';
	string FFAddress1 {xpath('FFAddress1')} := '';
	string FFAddress2 {xpath('FFAddress2')} := '';
	string FFAddress3 {xpath('FFAddress3')} := '';
	string FFAddress4 {xpath('FFAddress4')} := '';
	string POBox {xpath('POBox')} := '';
	string BuildingNumber {xpath('BuildingNumber')} := '';
	string SubBuildingNumber {xpath('SubBuildingNumber')} := '';
	string Company {xpath('Company')} := '';
	string Department {xpath('Department')} := '';
	string Premise {xpath('Premise')} := '';
	string SubStreet {xpath('SubStreet')} := '';
	string Street {xpath('Street')} := '';
	string SubCity {xpath('SubCity')} := '';
	string CityTown {xpath('CityTown')} := '';
	string StateDistrict {xpath('StateDistrict')} := '';
	string Region {xpath('Region')} := '';
	string Principality {xpath('Principality')} := '';
	string Cedex {xpath('Cedex')} := '';
	string Country {xpath('Country')} := '';
	string ZipPCode {xpath('ZipPCode')} := '';
	Layout_Date StartDate {xpath('StartDate')};
	Layout_Date EndDate {xpath('EndDate')};
END;

Layout_Addresses := RECORD
	Layout_Address Address1 {xpath('Address1')};
	Layout_Address Address2 {xpath('Address2')};
	Layout_Address Address3 {xpath('Address3')};
END;

Layout_Phone := RECORD
	string Number {xpath('Number')} := '';
	boolean Published {xpath('Published')} := false;
END;

Layout_Telephones := RECORD
	Layout_Phone HomeTelephone {xpath('HomeTelephone')};
	Layout_Phone WorkTelephone {xpath('WorkTelephone')};
	Layout_Phone MobileTelephone {xpath('MobileTelephone')};
END;

Layout_USDrivingLicense := RECORD
	string Number {xpath('Number')} := '';
	string State {xpath('State')} := '';
END;

Layout_Passport := RECORD
	Layout_Date ExpiryDate {xpath('ExpiryDate')};
	string Number {xpath('Number')} := '';
	string CountryOfOrigin {xpath('CountryOfOrigin')} := '';
END;

Layout_Identity := RECORD
	string Type {xpath('Type')} := '';
	string Number {xpath('Number')} := '';
	string Location {xpath('Location')} := '';
	string QuovaIP {xpath('QuovaIP')} := '';
	string QuovaCountry {xpath('QuovaCountry')} := '';
	string QuovaUSState {xpath('QuovaUSState')} := '';
	string QuovaCCard {xpath('QuovaCCard')} := '';
	string IDCountry {xpath('IDCountry')} := '';
	string IDCardNumber {xpath('IDCardNumber')} := '';
END;

Layout_SearchBy := RECORD
	Layout_Request_Details RequestDetails {xpath('RequestDetails')};
	Layout_GBPerson Person {xpath('Person')};
	Layout_Addresses Addresses {xpath('Addresses')};
	Layout_Telephones Telephones {xpath('Telephones')};
	Layout_USDrivingLicense USDrivingLicense {xpath('USDrivingLicense')};
	Layout_Passport Passport {xpath('Passport')};
	Layout_Identity Identity {xpath('Identity')};
END;


export Layout_GBID3_In := RECORD
	Layout_User User {xpath('User')};
	Layout_SearchBy SearchBy {xpath('SearchBy')};
END;