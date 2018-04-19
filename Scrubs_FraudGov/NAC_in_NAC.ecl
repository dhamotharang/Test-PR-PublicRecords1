import FraudGovPlatform;
f0 :=	FraudGovPlatform.Files().Input.IdentityData.Sprayed(regexfind('NAC',source_input,nocase)) +
			FraudGovPlatform.Files().Input.ByPassed_IdentityData.Sprayed(regexfind('NAC',Source_input,nocase));
export NAC_In_NAC := f0;
