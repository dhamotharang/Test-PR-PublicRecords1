/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from businesscontactcardreport.xml. ***/
/*===================================================*/

export businesscontactcardreport := MODULE
			
export t_BCCReportOption := record (share.t_BaseReportOption)
	boolean IncludePhonesPlus {xpath('IncludePhonesPlus')};
	boolean IncludePhonesFeedback {xpath('IncludePhonesFeedback')};//hidden[internal]
	string1 BusinessReportFetchLevel {xpath('BusinessReportFetchLevel')}; //values['S','D','E','W','P','O','U','','']
end;
		
export t_BCCReportBy := record
	string BusinessId {xpath('BusinessId')};
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
end;
		
export t_BCCPhoneInfoWithFeedback := record (share.t_PhoneInfo)
	phonesfeedback.t_PhonesFeedback PhonesFeedback {xpath('PhonesFeedback')};//hidden[internal]
end;
		
export t_BCCSubject := record
	string BusinessId {xpath('BusinessId')};
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string CompanyName {xpath('CompanyName')};
	string FEIN {xpath('FEIN')};
	share.t_Address Address {xpath('Address')};
	dataset(share.t_PhoneInfo) Phones {xpath('Phones/PhoneInfo'), MAXCOUNT(iesp.constants.BR.MaxPhones)};
	string Status {xpath('Status')};
end;
		
export t_BCCPhonesPlusRecordWithFeedback := record (dirassistwireless.t_PhonesPlusRecord)
	phonesfeedback.t_PhonesFeedback PhoneFeedback {xpath('PhoneFeedback')};//hidden[internal]
end;
		
export t_BCCExecs := record
	string UniqueId {xpath('UniqueId')};
	share.t_Name Name {xpath('Name')};
	share.t_SSNInfoEx SSNInfo {xpath('SSNInfo')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	boolean IsExecutiveOwner {xpath('IsExecutiveOwner')};
	string Title {xpath('Title')};
	share.t_Address Address {xpath('Address')};
	t_BCCPhoneInfoWithFeedback PhoneInfo {xpath('PhoneInfo')};
	dataset(t_BCCPhonesPlusRecordWithFeedback) PhonesPluses {xpath('PhonesPluses/PhonesPlus'), MAXCOUNT(iesp.constants.BR.MaxPhonesPlus)};
end;
		
export t_BCCParent := record
	string BusinessId {xpath('BusinessId')};
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string CompanyName {xpath('CompanyName')};
	string FEIN {xpath('FEIN')};
	share.t_Address Address {xpath('Address')};
	share.t_PhoneInfo PhoneInfo {xpath('PhoneInfo')};
end;
		
export t_BCCReport := record
	t_BCCSubject CompanyInfo {xpath('CompanyInfo')};
	dataset(t_BCCExecs) ExecutivesAssociates {xpath('ExecutivesAssociates/Identity'), MAXCOUNT(iesp.constants.BR.MaxPeopleAtWork)};
	t_BCCParent ParentCompanyInfo {xpath('ParentCompanyInfo')};
end;
		
export t_BCCReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_BCCReport BusinessContactCard {xpath('BusinessContactCard')};
end;
		
export t_BCCReportRequest := record (share.t_BaseRequest)
	t_BCCReportOption Options {xpath('Options')};
	t_BCCReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_BCCReportResponseEx := record
	t_BCCReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from businesscontactcardreport.xml. ***/
/*===================================================*/

