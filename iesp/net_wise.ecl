﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from net_wise.xml. ***/
/*===================================================*/

import iesp;

export net_wise := MODULE
			
export t_NetWiseQueryOptions := record (iesp.share.t_BaseOption)
end;
		
export t_NetWiseQueryParams := record
	string AppId {xpath('AppId')};
	string Email1 {xpath('Email1')};
	string Email2 {xpath('Email2')};
	string Email3 {xpath('Email3')};
	string Email4 {xpath('Email4')};
	string Email5 {xpath('Email5')};
end;
		
export t_NetWiseAddress := record
	string Address1 {xpath('Address1')};
	string Address2 {xpath('Address2')};
	string City {xpath('City')};
	string State {xpath('State')};
	string Zip {xpath('Zip')};
end;
		
export t_NetWisePersonalContactInfo := record
	dataset(iesp.share.t_StringArrayItem) EmailRecords {xpath('EmailRecords/Email'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_EMAIL_RECORDS)};
	dataset(iesp.share.t_StringArrayItem) PhoneRecords {xpath('PhoneRecords/Phone'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_PHONE_RECORDS)};
	dataset(t_NetWiseAddress) AddressRecords {xpath('AddressRecords/Address'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_ADDRESS_RECORDS)};
end;
		
export t_NetWiseWork := record
	string CompanyName {xpath('CompanyName')};
	string Domain {xpath('Domain')};
	string Email {xpath('Email')};
	string Title {xpath('Title')};
	string Level {xpath('Level')};
	string FunctionalArea {xpath('FunctionalArea')};
	string StartYear {xpath('StartYear')};
	string EndYear {xpath('EndYear')};
	string Phone {xpath('Phone')};
	t_NetWiseAddress Address {xpath('Address')};
end;
		
export t_NetWiseEducation := record
	string InstitutionName {xpath('InstitutionName')};
	string Level {xpath('Level')};
	string EndYear {xpath('EndYear')};
	string StartYear {xpath('StartYear')};
end;
		
export t_NetWiseBio := record
	string Gender {xpath('Gender')};
	string Age {xpath('Age')};
end;
		
export t_NetWiseName := record
	string Text {xpath('Text')};
end;
		
export t_NetWiseUrl := record
	string Url {xpath('Url')};
end;
		
export t_NetWiseTransaction := record
	string Id {xpath('Id')};
	string Version {xpath('Version')};
	string ResponseCode {xpath('ResponseCode')};
end;
		
export t_NetWiseQueryResult := record
	string Email {xpath('Email')};
	string LinkedInProfileUrl {xpath('LinkedInProfileUrl')};
	string LinkedInProfileImageUrl {xpath('LinkedInProfileImageUrl')};
	string Age {xpath('Age')};
	t_NetWisePersonalContactInfo PersonalContactInfo {xpath('PersonalContactInfo')};
	dataset(t_NetWiseWork) WorkRecords {xpath('WorkRecords/Work'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_WORK_RECORDS)};
	dataset(t_NetWiseEducation) EducationRecords {xpath('EducationRecords/Education'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_EDUCATION_RECORDS)};
	t_NetWiseBio Bio {xpath('Bio')};
	dataset(iesp.share.t_StringArrayItem) NameRecords {xpath('NameRecords/Name'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_NAME_RECORDS)};
	t_NetWiseName Name {xpath('Name')};
	dataset(t_NetWiseUrl) ImageRecords {xpath('ImageRecords/Image'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_IMAGE_RECORDS)};
	dataset(t_NetWiseUrl) PlaceRecords {xpath('PlaceRecords/Place'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_PLACE_RECORDS)};
end;
		
export t_NetWiseQueryResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_NetWiseTransaction Transaction {xpath('Transaction')};
	dataset(t_NetWiseQueryResult) Results {xpath('Results/Result'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_RESULTS_RECORDS)};
end;
		
export t_NetWiseQueryRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_NetWiseQueryOptions Options {xpath('Options')};
	t_NetWiseQueryParams SearchBy {xpath('SearchBy')};
end;
		
export t_NetWiseQueryResponseEx := record
	t_NetWiseQueryResponse Response {xpath('Response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from net_wise.xml. ***/
/*===================================================*/

