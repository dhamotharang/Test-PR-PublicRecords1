/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from smallbusinessanalytics.xml. ***/
/*===================================================*/

import iesp;
export smallbusinessanalytics := MODULE
			
export t_SBACompany := record
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
		
export t_SBAAuthRep := record
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
		
export t_SBASearchBy := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	t_SBACompany Company {xpath('Company')};
	t_SBAAuthRep AuthorizedRep1 {xpath('AuthorizedRep1')};
	t_SBAAuthRep AuthorizedRep2 {xpath('AuthorizedRep2')};
	t_SBAAuthRep AuthorizedRep3 {xpath('AuthorizedRep3')};
end;
		
export t_SBAModelOption := record
	string64 OptionName {xpath('OptionName')};
	string64 OptionValue {xpath('OptionValue')};
end;
		
export t_SBAModels := record
	dataset(iesp.share.t_StringArrayItem) Names {xpath('Names/Name'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
	dataset(t_SBAModelOption) ModelOptions {xpath('ModelOptions/ModelOption'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelOptionCount)};
end;
		
export t_SBAOptions := record (iesp.share.t_BaseOption)
	dataset(iesp.share.t_StringArrayItem) AttributesVersionRequest {xpath('AttributesVersionRequest/Name'), MAXCOUNT(iesp.constants.SBAnalytics.MaxAttributeVersionCount)};
	t_SBAModels IncludeModels {xpath('IncludeModels')};
end;
		
export t_SBAAttributesGroup := record
	string32 Name {xpath('Name')};
	dataset(iesp.share.t_NameValuePair) Attributes {xpath('Attributes/Attribute'), MAXCOUNT(iesp.constants.SBAnalytics.MaxAttributes)};
end;
		
export t_SBARiskIndicator := record
	integer Sequence {xpath('Sequence')};
	string5 ReasonCode {xpath('ReasonCode')};
	string150 Description {xpath('Description')};
end;
		
export t_SBAScoreHRI := record
	string _Type {xpath('Type')};
	integer Value {xpath('Value')};
	dataset(t_SBARiskIndicator) ScoreReasons {xpath('ScoreReasons/ScoreReason'), MAXCOUNT(iesp.constants.SBAnalytics.MaxHRICount)};
end;
		
export t_SBAModelHRI := record
	string Name {xpath('Name')};
	dataset(t_SBAScoreHRI) Scores {xpath('Scores/Score'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
end;
		
export t_SmallBusinessAnalyticsResult := record
	UNSIGNED1 BillingHit {xpath('BillingHit')};
	t_SBASearchBy InputEcho {xpath('InputEcho')};
	iesp.share.t_BusinessIdentity BusinessID {xpath('BusinessID')};//hidden[ecldev]
	dataset(t_SBAModelHRI) Models {xpath('Models/Model'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
	dataset(t_SBAAttributesGroup) AttributeGroups {xpath('AttributeGroups/AttributesGroup'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
end;
		
export t_SmallBusinessAnalyticsResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_SmallBusinessAnalyticsResult Result {xpath('Result')};
end;
		
export t_SmallBusinessAnalyticsRequest := record (iesp.share.t_BaseRequest)
	t_SBAOptions Options {xpath('Options')};
	t_SBASearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SmallBusinessAnalyticsResponseEx := record
	t_SmallBusinessAnalyticsResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from smallbusinessanalytics.xml. ***/
/*===================================================*/

