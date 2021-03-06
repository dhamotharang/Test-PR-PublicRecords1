/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from dmxmlsearch.xml. ***/
/*===================================================*/

export dmxmlsearch := MODULE
			
export t_DMXMLSearchOptions := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	string DataPackageEnhancement {xpath('DataPackageEnhancement')}; //values['A','B','C','D','']
end;
		
export t_DMXMLSearchBy := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DOB {xpath('DOB')};
	string10 Phone {xpath('Phone')};
end;
		
export t_BestInfo := record
	integer AddressScore {xpath('AddressScore')};
	share.t_Address Address {xpath('Address')};
	integer NameScore {xpath('NameScore')};
	share.t_Name Name {xpath('Name')};
	integer PhoneScore {xpath('PhoneScore')};
	string Phone {xpath('Phone')};
	share.t_Date AddrDate {xpath('AddrDate')};
	share.t_Date AddrDateFirstSeen {xpath('AddrDateFirstSeen')};
end;
		
export t_DimensionHousehold := record
	boolean Outdoors {xpath('Outdoors')};
	boolean Athletic {xpath('Athletic')};
	boolean Fitness {xpath('Fitness')};
	boolean Domestic {xpath('Domestic')};
	boolean GoodLife {xpath('GoodLife')};
	boolean Cultural {xpath('Cultural')};
	boolean BlueChip {xpath('BlueChip')};
	boolean DoItYourself {xpath('DoItYourself')};
	boolean Technology {xpath('Technology')};
end;
		
export t_CreditCardUsage := record
	boolean Miscellaneous {xpath('Miscellaneous')};
	boolean StandardRetail {xpath('StandardRetail')};
	boolean StandardSpecialtyCard {xpath('StandardSpecialtyCard')};
	boolean UpscaleRetail {xpath('UpscaleRetail')};
	boolean UpscaleSpecRetail {xpath('UpscaleSpecRetail')};
	boolean BankCard {xpath('BankCard')};
	boolean OilGasCard {xpath('OilGasCard')};
	boolean FinanceCoCard {xpath('FinanceCoCard')};
	boolean TravelEntertainment {xpath('TravelEntertainment')};
end;
		
export t_ScoreInfo := record
	integer Score {xpath('Score')};
	integer AnySSN {xpath('AnySSN')};
	integer AnyAddress {xpath('AnyAddress')};
	integer AnyDOB {xpath('AnyDOB')};
	integer AnyPhone {xpath('AnyPhone')};
	integer AnyFuzzy {xpath('AnyFuzzy')};
end;
		
export t_DMXMLSearchRecord := record
	string Source {xpath('Source')};
	string UniqueID {xpath('UniqueID')};
	string HouseholdID {xpath('HouseholdID')};
	t_BestInfo BestInfo {xpath('BestInfo')};
	integer NumHeaderRecs {xpath('NumHeaderRecs')};
	share.t_Date EDAConnect {xpath('EDAConnect')};
	share.t_Date EDADisconnect {xpath('EDADisconnect')};
	t_ScoreInfo ScoreInfo {xpath('ScoreInfo')};
	integer Age {xpath('Age')};
	string Gender {xpath('Gender')};
	string MaritalStatus {xpath('MaritalStatus')};
	integer NumOfAdultsInHousehold {xpath('NumOfAdultsInHousehold')};
	integer NumOfChildrenInHousehold {xpath('NumOfChildrenInHousehold')};
	string DwellingType {xpath('DwellingType')};
	string HomeOwnerRenterCode {xpath('HomeOwnerRenterCode')};
	string HouseholdIncomeIdentifier {xpath('HouseholdIncomeIdentifier')};
	string HouseholdOccupation {xpath('HouseholdOccupation')};
	string LengthOfResidence {xpath('LengthOfResidence')};
	string MailResponsiveDonorIndicator {xpath('MailResponsiveDonorIndicator')};
	string MailResponsiveBuyerIndicator {xpath('MailResponsiveBuyerIndicator')};
	string Telephone {xpath('Telephone')};
	t_DimensionHousehold DimensionHousehold {xpath('DimensionHousehold')};
	t_CreditCardUsage CreditCardUsage {xpath('CreditCardUsage')};
end;
		
export t_DMXMLSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_DMXMLSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_DMXMLSearchRequest := record (share.t_BaseRequest)
	t_DMXMLSearchOptions Options {xpath('Options')};
	t_DMXMLSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_DMXMLSearchResponseEx := record
	t_DMXMLSearchResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from dmxmlsearch.xml. ***/
/*===================================================*/

