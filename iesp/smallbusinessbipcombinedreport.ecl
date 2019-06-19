﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from smallbusinessbipcombinedreport.xml. ***/
/*===================================================*/

import iesp;

export smallbusinessbipcombinedreport := MODULE
			
export t_SmallBusinessBipCombinedReportOption := record (iesp.share.t_BaseReportOption)
	dataset(iesp.share.t_StringArrayItem) AttributesVersionRequest {xpath('AttributesVersionRequest/Name'), MAXCOUNT(iesp.constants.SBAnalytics.MaxAttributeVersionCount)};
	iesp.smallbusinessanalytics.t_SBAModels IncludeModels {xpath('IncludeModels')};
	boolean IncludeCreditReport {xpath('IncludeCreditReport')};
	string BusinessCreditReportType {xpath('BusinessCreditReportType')}; //values['0','1','2','3','']
	boolean LimitPaymentHistory24Months {xpath('LimitPaymentHistory24Months')}; 	
end;
		
export t_SmallBusinessBipCombinedReportSearchBy := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	iesp.smallbusinessanalytics.t_SBACompany Company {xpath('Company')};
	unsigned2 Radius {xpath('Radius')};
	string100 URL {xpath('URL')};
	string100 Email {xpath('Email')};
	iesp.smallbusinessanalytics.t_SBAAuthRep AuthorizedRep1 {xpath('AuthorizedRep1')};
	iesp.smallbusinessanalytics.t_SBAAuthRep AuthorizedRep2 {xpath('AuthorizedRep2')};
	iesp.smallbusinessanalytics.t_SBAAuthRep AuthorizedRep3 {xpath('AuthorizedRep3')};
end;
		
export t_SmallBusinessAnalyticsIDsModelsAttributes := record
	iesp.share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};//hidden[ecldev]
	dataset(iesp.smallbusinessanalytics.t_SBAModelHRI) Models {xpath('Models/Model'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
	dataset(iesp.smallbusinessanalytics.t_SBAAttributesGroup) AttributesGroups {xpath('AttributesGroups/AttributesGroup'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};
end;
		
export t_SmallBusinessBipCombinedReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	UNSIGNED1 BillingHit {xpath('BillingHit')}; // hidden[ecl _sbfe]
	t_SmallBusinessBipCombinedReportSearchBy InputEcho {xpath('InputEcho')};
	t_SmallBusinessAnalyticsIDsModelsAttributes SmallBusinessAnalyticsResults {xpath('SmallBusinessAnalyticsResults')};
	dataset(iesp.businesscreditreport.t_BusinessCreditReportRecord) CreditReportRecords {xpath('CreditReportRecords/Record'), MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_REPORT_RESPONSE_RECORDS)};
end;
		
export t_SmallBusinessBipCombinedReportRequest := record (iesp.share.t_BaseRequest)
	t_SmallBusinessBipCombinedReportOption Options {xpath('Options')};
	t_SmallBusinessBipCombinedReportSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SmallBusinessBipCombinedReportResponseEx := record
	t_SmallBusinessBipCombinedReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from smallbusinessbipcombinedreport.xml. ***/
/*===================================================*/

