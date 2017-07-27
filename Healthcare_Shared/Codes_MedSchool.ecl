EXPORT Codes_MedSchool := Module
	Export getMedschool_USTAT(boolean isMissing, boolean Verified, boolean medschoolExists, boolean hasAugAvailable) := Function
			ustat_missing := IF(isMissing,Healthcare_Shared.Constants.ustat_Medschool_Missing,0);
			ustat_verified := IF(Verified,Healthcare_Shared.Constants.ustat_Medschool_Verified,0);
			ustat_aug_avail := IF(hasAugAvailable,Healthcare_Shared.Constants.ustat_Medschool_Aug,0);
			medschool_ustat := ustat_missing + ustat_aug_avail;//Currentyl code does not return Verified flags
			return medschool_ustat;
	end;
	Export getMedschool_CIC(boolean isMissing, boolean Verified, boolean medschoolExists, boolean hasAugAvailable) := Function
		return map(Verified => Healthcare_Shared.Constants.cic_Medschool_Verified,
							 isMissing and hasAugAvailable => Healthcare_Shared.Constants.cic_Medschool_Aug,
							 not Verified and medschoolExists => Healthcare_Shared.Constants.cic_Medschool_NotVerified_Aug,
							 isMissing and not hasAugAvailable => Healthcare_Shared.Constants.cic_Medschool_MissingInput,
								'');
	end;
End;