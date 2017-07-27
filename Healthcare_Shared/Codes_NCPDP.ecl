EXPORT Codes_NCPDP := Module
	Export getNCPDP_USTAT(boolean IsMissing, boolean Isbad, boolean isCompanionData, boolean NCPDPVerified, boolean Aug_Avail, boolean Other_Person ) := Function
			ustat_missing := IF(IsMissing,Healthcare_Shared.Constants.ustat_NCPDP_Missing,0);
			ustat_badFormat := IF(IsBad,Healthcare_Shared.Constants.ustat_NCPDP_BadFormat,0);
			ustat_verified := IF(NCPDPVerified,Healthcare_Shared.Constants.ustat_NCPDP_Verified,0);
			ustat_aug_avail := IF(Aug_Avail,Healthcare_Shared.Constants.ustat_NCPDP_AugAuthSource,0);
			ustat_other_person := IF(Other_Person,Healthcare_Shared.Constants.ustat_NCPDP_SomeoneElse,0);
			ustat_companion := IF(isCompanionData, Healthcare_Shared.Constants.ustat_NCPDP_CompanionData,0);
			ncpdp_ustat := ustat_missing + ustat_badFormat +  ustat_verified + ustat_aug_avail + ustat_other_person + ustat_companion;
			return ncpdp_ustat;
	end;
	
	Export getNCPDP_CIC	(boolean IsMissing, boolean IsBad, boolean isCompanionData, boolean NCPDPVerified, Boolean Aug_Avail, boolean Other_Person) := Function
		return map(		(isMissing or IsBad or NOT NCPDPVerified) and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_Missing_NoAug, 
									NCPDPVerified and isCompanionData => Healthcare_Shared.Constants.cic_NCPDP_Verified,
									isMissing and Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_Missing_Aug,
									Other_Person and Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_SomeoneElse_Aug,
									isBad and Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_Not_Found_Aug,
									isBad and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_Not_Found_NoAug,
									Aug_Avail and NOT isBad and NOT isMissing and NOT Other_Person and NOT NCPDPVerified => Healthcare_Shared.Constants.cic_NCPDP_Not_Verified_Aug,  ////"NOT NCPDPVerified" is implied or it would have taken the 1st statement as true.
									IsBad and Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_BadInput_Aug,
									IsBad and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_BadInput_NoAug,
									isMissing and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NCPDP_Missing_NoAug,
									'');
	end;
End;