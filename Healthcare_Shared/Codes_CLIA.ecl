EXPORT Codes_CLIA := Module
	Export getCLIA_USTAT(Boolean IsMissing, Boolean IsBad, boolean CLIAVerified, boolean ExpiredInGracePeriod, 
												boolean WrongPracticeState, boolean CLIASuppliedExists, boolean hasCompanionData, boolean hasAugAvailable) := Function
			ustat_missing := IF(IsMissing,Healthcare_Shared.Constants.ustat_CLIA_Missing,0);
			ustat_badFormat := IF(IsBad,Healthcare_Shared.Constants.ustat_CLIA_BadFormat,0);
			ustat_verified := IF(CLIAVerified,Healthcare_Shared.Constants.ustat_CLIA_Verified,0);
			ustat_expired := IF(ExpiredInGracePeriod,Healthcare_Shared.Constants.ustat_CLIA_ExpiredInGrace,0);
			ustat_nonpracstate := IF(WrongPracticeState,Healthcare_Shared.Constants.ustat_CLIA_NonPracState,0);
			ustat_aug_avail := IF(hasAugAvailable,Healthcare_Shared.Constants.ustat_CLIA_AugAuthSource,0);
			ustat_companionData := IF(hasCompanionData,Healthcare_Shared.Constants.ustat_CLIA_CompanionData,0);
			clia_ustat := ustat_missing + ustat_badFormat + ustat_verified + ustat_expired + ustat_nonpracstate + ustat_aug_avail + ustat_companionData;
			return clia_ustat;
	end;
	Export getCLIA_CIC(Boolean IsMissing, Boolean IsBad, boolean CLIAVerified, boolean ExpiredInGracePeriod, 
											boolean WrongPracticeState, boolean CLIASuppliedExists, boolean hasCompanionData, boolean hasAugAvailable) := Function
		return map(ExpiredInGracePeriod and not hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_ExpiredWithinGrace_noAug,
						 ExpiredInGracePeriod and hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_ExpiredWithinGrace_Aug,
						 IsMissing and hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_Auth_Aug_NoInput,
						 not CLIAVerified and not IsBad and not WrongPracticeState and hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_Auth_Aug_WrongInput,
						 IsBad and hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_Auth_Found_BadInput,
						 IsBad and not hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_NoAuth_BadInput,
						 WrongPracticeState and hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_NonPracState_Aug,
						 WrongPracticeState and not hasAugAvailable => Healthcare_Shared.Constants.cic_CLIA_NonPracState_NoAug,
						 CLIAVerified or hasCompanionData => Healthcare_Shared.Constants.cic_CLIA_Auth_Verified,
						 '');
	end;
End;