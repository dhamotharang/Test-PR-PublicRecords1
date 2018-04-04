import FraudGovPlatform;
f0 :=	FraudGovPlatform.Files().Input.IdentityData.Sprayed(regexfind('InquiryLogs',source_input,nocase)) +
			FraudGovPlatform.Files().Input.ByPassed_IdentityData.Sprayed(regexfind('InquiryLogs',Source_input,nocase));
export InquiryLogs_In_InquiryLogs := f0;
