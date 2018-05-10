/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from equifax_ems.xml. ***/
/*===================================================*/

import iesp;

export equifax_ems := MODULE

export t_RequestorInfo := record
	string UserId {xpath('UserId')};
	string VendorId {xpath('VendorId')};
	string CompanyName {xpath('CompanyName')};
end;

export t_ConsumerInfo := record
	string SSN {xpath('SSN')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
end;

export t_ErrorInfo := record
	string ErrorMessage {xpath('ErrorMessage')};
end;

export t_BorrowerInfo := record
	string SSN {xpath('SSN')};
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
end;

export t_CreditReportRecord := record
	string SourceBureau {xpath('SourceBureau')}; //values['Equifax','Experian','Transunion','']
	string CreditScore {xpath('CreditScore')};
	dataset(iesp.share.t_StringArrayItem) Alerts {xpath('Alerts/Alert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
end;

export t_EmsOptions := record (iesp.share_fcra.t_FcraReportOption)
end;

export t_EmsSearch := record
	t_RequestorInfo Requestor {xpath('Requestor')};
	string LoanNumber {xpath('LoanNumber')};
	t_ConsumerInfo Consumer {xpath('Consumer')};
	boolean IncludeEquifax {xpath('IncludeEquifax')};
	boolean IncludeExperian {xpath('IncludeExperian')};
	boolean IncludeTransunion {xpath('IncludeTransunion')};
end;

export t_EmsResponse := record
	t_ErrorInfo ErrorInfo {xpath('ErrorInfo')};
	t_BorrowerInfo Borrower {xpath('Borrower')};
	DATASET(t_CreditReportRecord) CreditReports {xpath('CreditReports/CreditReport'), MAXCOUNT(3)};
	string PdfReport {xpath('PdfReport')};
end;

export t_EquifaxEmsResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_EmsResponse EmsResponse {xpath('EmsResponse')};
end;

export t_EquifaxEmsRequest := record (iesp.share.t_BaseRequest)
	iesp.share.t_GatewayParams GatewayParams {xpath('GatewayParams')};
	t_EmsOptions Options {xpath('Options')};
	t_EmsSearch SearchBy {xpath('SearchBy')};
end;

export t_EquifaxEmsException := RECORD
	string Source {xpath('Source'), maxlength(64)};
	iesp.share.t_WsException.Code;
	iesp.share.t_WsException.Message;
	string Audience {xpath('Audience'), maxlength(64)};
END;

export t_EquifaxEmsResponseEx := record
	t_EquifaxEmsResponse response {xpath('response')};
	DATASET(t_EquifaxEmsException) exceptions {xpath('Exceptions/Exception')};
end;


end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from equifax_ems.xml. ***/
/*===================================================*/

