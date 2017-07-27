EXPORT Codes_DEA := Module
	Export getDEA_USTAT(boolean IsMissing, boolean IsbadFormat, boolean IsVerified, boolean isAug_Avail,  boolean is_Expired, boolean is_Retired,boolean isOther_Person, boolean is_CompanionData) := Function
			ustat_missing := IF(isMissing,Healthcare_Shared.Constants.ustat_DEA_Missing,0);
			ustat_badFormat := IF(isBadFormat,Healthcare_Shared.Constants.ustat_DEA_BadFormat,0);
			ustat_verified := IF(isVerified,Healthcare_Shared.Constants.ustat_DEA_Verified,0);
			ustat_aug_avail := IF(isAug_Avail,Healthcare_Shared.Constants.ustat_DEA_AugAuthSource,0);
			ustat_other_person := IF(isOther_Person,Healthcare_Shared.Constants.ustat_DEA_SomeoneElse,0);
			ustat_expired	:= IF(is_Expired, Healthcare_Shared.Constants.ustat_DEA_Expired,0);
			ustat_inactive	:= IF(is_Retired, Healthcare_Shared.Constants.ustat_DEA_InActive,0);
			ustat_companion := IF(is_CompanionData, Healthcare_Shared.Constants.ustat_DEA_CompanionData,0);
			dea_ustat := ustat_missing + ustat_badFormat + ustat_verified + ustat_aug_avail + ustat_other_person + ustat_expired + ustat_inactive + ustat_companion;
			return dea_ustat;
	end;
	
	Export getDEA_CIC	(boolean Is_Missing, boolean Is_Bad, boolean is_Verified, Boolean is_Aug_Avail, boolean is_Other_Person, boolean is_Retired) := Function
		return map(		is_Aug_Avail and is_Verified and NOT is_Other_Person and is_Retired => Healthcare_Shared.Constants.cic_DEA_Auth_Aug_Retired,
									NOT is_Aug_Avail and is_Verified and is_Retired => Healthcare_Shared.Constants.cic_DEA_Auth_NoAug_Retired,
									is_Other_Person and is_Aug_Avail and is_Verified => Healthcare_Shared.Constants.cic_DEA_Auth_Aug_Other,
									Is_Bad and is_Verified and is_Aug_Avail => Healthcare_Shared.Constants.cic_DEA_Auth_Aug_WrongInput,
									is_Missing and is_Aug_Avail and is_Verified => Healthcare_Shared.Constants.cic_DEA_Auth_Aug_NoInput,
									Is_Bad and is_Verified and NOT is_Other_Person => Healthcare_Shared.Constants.cic_DEA_Auth_Found_BadInput,
									NOT is_Verified and is_Bad => Healthcare_Shared.Constants.cic_DEA_NoAuth_BadInput,
									NOT is_Aug_Avail and is_Other_Person => Healthcare_Shared.Constants.cic_DEA_NoAug_Other,
									Is_Missing and NOT is_Verified => Healthcare_Shared.Constants.cic_DEA_NoAuth_MissingInput,
									is_Verified => Healthcare_Shared.Constants.cic_DEA_Verified,
									'');
	end;
End;