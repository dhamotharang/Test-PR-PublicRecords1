﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from net_wise_share.xml. ***/
/*===================================================*/

import iesp;

export net_wise_share := MODULE
			
export t_NetWiseOptions := record (iesp.share.t_BaseOption)
end;
		
export t_NetWiseRequestParams := record
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
	string CurrentCity {xpath('CurrentCity')};
	string CurrentState {xpath('CurrentState')};
	dataset(iesp.share.t_StringArrayItem) EmailRecords {xpath('EmailRecords/Email'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_EMAIL_RECORDS)};
	dataset(iesp.share.t_StringArrayItem) PhoneRecords {xpath('PhoneRecords/Phone'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_PHONE_RECORDS)};
	dataset(t_NetWiseAddress) AddressRecords {xpath('AddressRecords/Address'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_ADDRESS_RECORDS)};
end;
		
export t_NetWiseWork := record
	string CompanyName {xpath('CompanyName')};
	string Domain {xpath('Domain')};
	string Email {xpath('Email')};
	string Title {xpath('Title')};
	string Seniority {xpath('Seniority')};
	string Level {xpath('Level')};
	string FunctionalArea {xpath('FunctionalArea')};
	string SubFunctionalArea {xpath('SubFunctionalArea')};
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
		
export t_NetWiseOptionalFieldMatches := record
	boolean EmailMatch {xpath('EmailMatch')};
	boolean PhoneMatch {xpath('PhoneMatch')};
	boolean AgeMatch {xpath('AgeMatch')};
	boolean ZipMatch {xpath('ZipMatch')};
	boolean CityMatch {xpath('CityMatch')};
end;
		
export t_NetWiseTransaction := record
	string Id {xpath('Id')};
	string Version {xpath('Version')};
	string ResponseCode {xpath('ResponseCode')};
end;
		
export t_NetWiseResult := record
	string Email {xpath('Email')};
	string PersonId {xpath('PersonId')};
	string FullName {xpath('FullName')};
	string LinkedInProfileUrl {xpath('LinkedInProfileUrl')};
	string LinkedInProfileImageUrl {xpath('LinkedInProfileImageUrl')};
	string FirstName {xpath('FirstName')};
	string LastName {xpath('LastName')};
	string Age {xpath('Age')};
	t_NetWisePersonalContactInfo PersonalContactInfo {xpath('PersonalContactInfo')};
	dataset(t_NetWiseWork) WorkRecords {xpath('WorkRecords/Work'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_WORK_RECORDS)};
	dataset(t_NetWiseEducation) EducationRecords {xpath('EducationRecords/Education'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_EDUCATION_RECORDS)};
	t_NetWiseBio Bio {xpath('Bio')};
	dataset(iesp.share.t_StringArrayItem) NameRecords {xpath('NameRecords/Name'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_NAME_RECORDS)};
	t_NetWiseName Name {xpath('Name')};
	dataset(t_NetWiseUrl) ImageRecords {xpath('ImageRecords/Image'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_IMAGE_RECORDS)};
	dataset(t_NetWiseUrl) PlaceRecords {xpath('PlaceRecords/Place'), MAXCOUNT(iesp.Constants.NETWISE.MAX_COUNT_PLACE_RECORDS)};
	t_NetWiseOptionalFieldMatches OptionalFieldMatches {xpath('OptionalFieldMatches')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from net_wise_share.xml. ***/
/*===================================================*/

