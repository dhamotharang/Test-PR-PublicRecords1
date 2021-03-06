/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from frauddefensemanager.xml. ***/
/*===================================================*/

export frauddefensemanager := MODULE
			
export t_FraudDefenseManagerSearchBy := record
	string UniqueID {xpath('UniqueID')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string SSN {xpath('SSN')};
	string Phone {xpath('Phone')};
	string IPAddress {xpath('IPAddress')};
	string Email {xpath('Email')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string DriverLicenseState {xpath('DriverLicenseState')};
	string DeviceID {xpath('DeviceID')};
end;
		
export t_FraudDefenseManagerSearchOption := record (share.t_BaseOption)
end;
		
export t_USPISHotList := record
	string Reason {xpath('Reason')};
	share.t_Date DateAdded {xpath('DateAdded')};
end;
		
export t_FraudDefenseManagerData := record
	string1 Hit {xpath('Hit')};
	string HitResponse {xpath('HitResponse')};
	string DataSource {xpath('DataSource')}; //values['Internal','Customer','Third Party','']//hidden[internal]
	dataset(share.t_RiskIndicator) RiskIndicators {xpath('RiskIndicators/RiskIndicator'), MAXCOUNT(iesp.Constants.IDFraudNetwork.MaxRiskIndicators)};
	share.t_Date DateFirstSeenInFile {xpath('DateFirstSeenInFile')};
	integer InquiryCount {xpath('InquiryCount')};
	integer InquiryCountHour {xpath('InquiryCountHour')};
	integer InquiryCountToday {xpath('InquiryCountToday')};
	integer InquiryCountWeek {xpath('InquiryCountWeek')};
	integer InquiryCountMonth {xpath('InquiryCountMonth')};
	integer InquiryCountYear {xpath('InquiryCountYear')};
end;
		
export t_FraudDefenseManagerAddressData := record (t_FraudDefenseManagerData)
	dataset(t_USPISHotList) USPISHotListRecords {xpath('USPISHotListRecords/USPISHotListRecord'), MAXCOUNT(iesp.Constants.IDFraudNetwork.MaxUSPISHotList)};
end;
		
export t_FraudDefenseManagerResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_FraudDefenseManagerSearchBy InputEcho {xpath('InputEcho')};
	t_FraudDefenseManagerData SSNReturn {xpath('SSNReturn')};
	t_FraudDefenseManagerAddressData AddressReturn {xpath('AddressReturn')};
	t_FraudDefenseManagerData EmailReturn {xpath('EmailReturn')};
	t_FraudDefenseManagerData IPAddressReturn {xpath('IPAddressReturn')};
	t_FraudDefenseManagerData NameReturn {xpath('NameReturn')};
	t_FraudDefenseManagerData PhoneReturn {xpath('PhoneReturn')};
	t_FraudDefenseManagerData CombinationReturn {xpath('CombinationReturn')};
end;
		
export t_FraudDefenseManagerRequest := record (share.t_BaseRequest)
	t_FraudDefenseManagerSearchBy SearchBy {xpath('SearchBy')};
	t_FraudDefenseManagerSearchOption Options {xpath('Options')};
end;
		
export t_FraudDefenseManagerResponseEx := record
	t_FraudDefenseManagerResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from frauddefensemanager.xml. ***/
/*===================================================*/

