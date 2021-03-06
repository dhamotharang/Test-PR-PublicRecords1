/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from mergedcreditreport_fcra.xml. ***/
/*===================================================*/

import iesp;

export mergedcreditreport_fcra := MODULE

export t_AccountInfo := record
  string CustomerNumber {xpath('CustomerNumber')};
  string SecurityCode {xpath('SecurityCode')};
end;

export t_VendorContactInfo := record (iesp.share.t_EndUserInfo)
  string UserId {xpath('UserId')};
  string VendorId {xpath('VendorId')};
end;

export t_CreditSubject := record
  string UniqueId {xpath('UniqueId')};//hidden[internal]
  string SSN {xpath('SSN')};
  iesp.share.t_Name Name {xpath('Name')};
  iesp.share.t_Address Address {xpath('Address')};
  iesp.share.t_Date DOB {xpath('DOB')};
end;

export t_BorrowerInfo := record
  string SSN {xpath('SSN')};
  iesp.share.t_Name Name {xpath('Name')};
  iesp.share.t_Address Address {xpath('Address')};
end;

export t_ErrorInfo := record
  string ErrorMessage {xpath('ErrorMessage')};
end;

export t_MergedCreditOptions := record (iesp.share_fcra.t_FcraReportOption)
  boolean IncludeEquifax {xpath('IncludeEquifax')};
  boolean IncludeExperian {xpath('IncludeExperian')};
  boolean IncludeTransunion {xpath('IncludeTransunion')};
end;

export t_MergedCreditReportBy := record
  t_AccountInfo AccountInfo {xpath('AccountInfo')};
  t_VendorContactInfo VendorInfo {xpath('VendorInfo')};
  string LoanNumber {xpath('LoanNumber')};
  t_CreditSubject Consumer {xpath('Consumer')};
end;

export t_CreditReportRecord := record
  string SourceBureau {xpath('SourceBureau')};
  t_BorrowerInfo BureauBorrower {xpath('BureauBorrower')};
  string CreditScore {xpath('CreditScore')};
  dataset(iesp.share.t_StringArrayItem) Alerts {xpath('Alerts/Alert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
end;

export t_FcraMergedCreditReportResponse := record (iesp.share.t_BaseResponse)
  t_ErrorInfo ErrorInfo {xpath('ErrorInfo')};
  t_BorrowerInfo BorrowerInputEcho {xpath('BorrowerInputEcho')};
  string PdfReport {xpath('PdfReport')};
  dataset(t_CreditReportRecord) MergedCreditReport {xpath('MergedCreditReport/CreditReport'), MAXCOUNT(3)};
  dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
  dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
  iesp.share.t_CodeMap Validation {xpath('Validation')};
  iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};//hidden[__inq_hist_logging__]
end;

export t_FcraMergedCreditReportRequest := record (iesp.share.t_BaseRequest)
  t_MergedCreditOptions Options {xpath('Options')};
  t_MergedCreditReportBy ReportBy {xpath('ReportBy')};
end;

export t_FcraMergedCreditReportResponseEx := record
  t_FcraMergedCreditReportResponse response {xpath('response')};
end;


end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from mergedcreditreport_fcra.xml. ***/
/*===================================================*/

