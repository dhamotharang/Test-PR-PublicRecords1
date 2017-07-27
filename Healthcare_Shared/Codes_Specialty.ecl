EXPORT Codes_Specialty := Module
	Export getSpecialty_USTAT(boolean ui_Missing, boolean SpecialtyVerified, boolean SpecialtyVerifiedAuth, boolean Aug1Src, boolean AugAuthSrc) := Function
			ustat_Specialty_Missing  := IF(ui_Missing,Healthcare_Shared.Constants.ustat_Specialty_Missing,0);
			ustat_Specialty_Verified := IF(SpecialtyVerified,Healthcare_Shared.Constants.ustat_Specialty_Verified,0);
			ustat_Specialty_Verified_Auth := IF(SpecialtyVerified and SpecialtyVerifiedAuth,Healthcare_Shared.Constants.ustat_Specialty_Verified_Auth,0);
			ustat_Specialty_Aug_1_Source := IF(Aug1Src,Healthcare_Shared.Constants.ustat_Specialty_Aug_1_Source,0);
			ustat_Specialty_AugAuthSrc := IF(AugAuthSrc,Healthcare_Shared.Constants.ustat_Specialty_AugAuthSrc,0);
			specialty_ustat := ustat_Specialty_Missing + ustat_Specialty_Verified + ustat_Specialty_Verified_Auth +
													ustat_Specialty_Aug_1_Source + ustat_Specialty_AugAuthSrc;
			return specialty_ustat;
	end;
	Export getSpecialty_CIC(boolean ui_Missing, boolean SpecialtyVerified, boolean SpecialtyVerifiedAuth, boolean Aug1Src, boolean AugAuthSrc) := Function
		return map(SpecialtyVerified or SpecialtyVerifiedAuth => Healthcare_Shared.Constants.cic_Specialty_Auth_Verified,
									ui_Missing and (AugAuthSrc or Aug1Src) => Healthcare_Shared.Constants.cic_Specialty_Auth_Aug_NoInput,
									not ui_Missing and (AugAuthSrc or Aug1Src) => Healthcare_Shared.Constants.cic_Specialty_Auth_Aug_WrongInput,
									ui_Missing and not AugAuthSrc => Healthcare_Shared.Constants.cic_Specialty_NoAuth_MissingInput,
									'');
	end;
End;