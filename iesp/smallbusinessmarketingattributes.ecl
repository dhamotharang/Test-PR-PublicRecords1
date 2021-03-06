/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from smallbusinessmarketingattributes.xml. ***/
/*===================================================*/

import iesp;

export smallbusinessmarketingattributes := MODULE
			
export t_SBMCompany := record
	string100 CompanyName {xpath('CompanyName')};
	string100 AlternateCompanyName {xpath('AlternateCompanyName')};
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	iesp.share.t_Address Address {xpath('Address')};
	string15 Phone {xpath('Phone')};
	string15 FaxNumber {xpath('FaxNumber')};
	string11 FEIN {xpath('FEIN')};
	string8 SICCode {xpath('SICCode')};
	string8 NAICCode {xpath('NAICCode')};
	string32 BusinessStructure {xpath('BusinessStructure')};
	string3 YearsInBusiness {xpath('YearsInBusiness')};
	iesp.share.t_Date BusinessStartDate {xpath('BusinessStartDate')};
	string12 YearlyRevenue {xpath('YearlyRevenue')};
end;
		
export t_SBMAuthRep := record
	iesp.share.t_Name Name {xpath('Name')};
	string20 FormerLastName {xpath('FormerLastName')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string3 Age {xpath('Age')};
	string11 SSN {xpath('SSN')};
	string10 Phone {xpath('Phone')};
	string64 DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string64 BusinessTitle {xpath('BusinessTitle')};
end;
		
export t_SBMSearchBy := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	t_SBMCompany Company {xpath('Company')};
	t_SBMAuthRep AuthorizedRep1 {xpath('AuthorizedRep1')};
	t_SBMAuthRep AuthorizedRep2 {xpath('AuthorizedRep2')};
	t_SBMAuthRep AuthorizedRep3 {xpath('AuthorizedRep3')};
end;
		
export t_SBMModelOption := record
	string64 OptionName {xpath('OptionName')};
	string64 OptionValue {xpath('OptionValue')};
end;
		
export t_SBMModels := record
	dataset(iesp.share.t_StringArrayItem) Names {xpath('Names/Name'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
	dataset(t_SBMModelOption) ModelOptions {xpath('ModelOptions/ModelOption'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelOptionCount)};
end;
		
export t_SBMOptions := record (iesp.share.t_BaseOption)
	dataset(iesp.share.t_StringArrayItem) AttributesVersionRequest {xpath('AttributesVersionRequest/Name'), MAXCOUNT(iesp.constants.SBAnalytics.MaxAttributeVersionCount)};
	t_SBMModels IncludeModels {xpath('IncludeModels')};
end;
		
export t_SBMAttributesGroup := record
	string32 Name {xpath('Name')};
	dataset(iesp.share.t_NameValuePair) Attributes {xpath('Attributes/Attribute'), MAXCOUNT(iesp.constants.SBAnalytics.MaxAttributes)};
end;
		
export t_SBMRiskIndicator := record
	integer Sequence {xpath('Sequence')};
	string4 ReasonCode {xpath('ReasonCode')};
	string150 Description {xpath('Description')};
end;
		
export t_SBMScoreHRI := record
	string _Type {xpath('Type')};
	integer Value {xpath('Value')};
	dataset(t_SBMRiskIndicator) ScoreReasons {xpath('ScoreReasons/ScoreReason'), MAXCOUNT(iesp.constants.SBAnalytics.MaxHRICount)};
end;
		
export t_SBMModelHRI := record
	string Name {xpath('Name')};
	dataset(t_SBMScoreHRI) Scores {xpath('Scores/Score'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
end;
		
export t_SmallBusinessMarketingAttributesResult := record
	string1 HitOnBusinessInputName {xpath('HitOnBusinessInputName')};//hidden[ecl_only]
	t_SBMSearchBy InputEcho {xpath('InputEcho')};
	iesp.share.t_BusinessIdentity BusinessID {xpath('BusinessID')};
	dataset(t_SBMModelHRI) Models {xpath('Models/Model'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
	dataset(t_SBMAttributesGroup) AttributeGroups {xpath('AttributeGroups/AttributesGroup'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
end;
		
export t_SmallBusinessMarketingResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_SmallBusinessMarketingAttributesResult Result {xpath('Result')};
end;
		
export t_SmallBusinessMarketingRequest := record (iesp.share.t_BaseRequest)
	t_SBMOptions Options {xpath('Options')};
	t_SBMSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SmallBusinessMarketingResponseEx := record
	t_SmallBusinessMarketingResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from smallbusinessmarketingattributes.xml. ***/
/*===================================================*/

