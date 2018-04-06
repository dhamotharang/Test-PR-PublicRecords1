﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from employment_verification_fcra.xml. ***/
/*===================================================*/

import iesp;

export employment_verification_fcra := MODULE
			
export t_FcraVerificationOfEmploymentReportReportBy := record (iesp.employment_verification.t_VerificationOfEmploymentReportBy)
end;
		
export t_FcraVerificationOfEmploymentReportOption := record (iesp.share_fcra.t_FcraReportOption)
	boolean GeneratePDF {xpath('GeneratePDF')};
	boolean IncludeIncome {xpath('IncludeIncome')};
	string1 FilterType {xpath('FilterType')}; //values['N','S','C','']//hidden[internal]
end;
		
export t_FcraVerificationOfEmploymentReportRecord := record (iesp.employment_verification.t_VerificationOfEmploymentReportRecord)
end;
		
export t_FcraVerificationOfEmploymentReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	iesp.share.t_CodeMap Validation {xpath('Validation')};
	t_FcraVerificationOfEmploymentReportRecord VerificationOfEmploymentReportRecord {xpath('VerificationOfEmploymentReportRecord')};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
	dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
end;
		
export t_FcraVerificationOfEmploymentReportRequest := record (iesp.share.t_BaseRequest)
	iesp.employment_verification.t_VendorSignOnReq SignonReq {xpath('SignonReq')};//hidden[internal]
	iesp.employment_verification.t_TransactionReq TransactionReq {xpath('TransactionReq')};
	t_FcraVerificationOfEmploymentReportReportBy ReportBy {xpath('ReportBy')};
	t_FcraVerificationOfEmploymentReportOption Options {xpath('Options')};
end;
		
export t_FcraVerificationOfEmploymentReportResponseEx := record
	t_FcraVerificationOfEmploymentReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from employment_verification_fcra.xml. ***/
/*===================================================*/