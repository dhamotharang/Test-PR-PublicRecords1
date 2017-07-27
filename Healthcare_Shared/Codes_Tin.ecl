EXPORT Codes_Tin := Module
	Export getTIN_USTAT(boolean ui_Missing =false, boolean ui_badFormat=false, boolean TINVerified=false,
												boolean TypeCorrection=false, boolean CallCorrection=false, boolean ActiveLicAuthSrc=false, boolean discrepancy=false, boolean Tin_Aug_Other=false, 
												boolean Tin_Aug_Mult_Other=false, boolean ver_Other=false, boolean ver_Multi_Other=false, boolean IsInDMF=false) := Function
			ustat_missing := IF(ui_Missing,Healthcare_Shared.Constants.ustat_TIN_Missing,0);
			ustat_badFormat := IF(ui_badFormat,Healthcare_Shared.Constants.ustat_TIN_BadFormat,0);
			ustat_verified := IF(TINVerified,Healthcare_Shared.Constants.ustat_TIN_Verified_Auth,0);
			ustat_type_Corr := IF(TypeCorrection,Healthcare_Shared.Constants.ustat_TIN_TypeCorrection,0);
			ustat_call_Corr := IF(CallCorrection,Healthcare_Shared.Constants.ustat_TIN_CallBasedHCCorrection,0);
			ustat_activeLic := IF(ActiveLicAuthSrc,Healthcare_Shared.Constants.ustat_TIN_hasActiveLicAuthSrcNotPracState,0);
			ustat_discrepancy := IF(discrepancy,Healthcare_Shared.Constants.ustat_TIN_Discrepancy ,0);
			ustat_aug_other := IF(Tin_Aug_Other,Healthcare_Shared.Constants.ustat_TIN_Aug_Other ,0);
			ustat_aug_other_multi := IF(Tin_Aug_Mult_Other,Healthcare_Shared.Constants.ustat_TIN_Aug_Other_Multi ,0);
			ustat_ver_Other := IF(ver_Other, Healthcare_Shared.Constants.ustat_TIN_Verified_1_Source, 0);
			ustat_ver_Multi_Other := IF(ver_Multi_Other, Healthcare_Shared.Constants.ustat_TIN_Verified_Multiple, 0);
			ustat_is_in_dmf := IF(IsInDMF, Healthcare_Shared.Constants.ustat_TIN_Is_In_DMF, 0);
			tin_ustat := ustat_missing + ustat_badFormat + ustat_verified + ustat_type_Corr + ustat_call_Corr + ustat_activeLic + ustat_discrepancy + ustat_aug_other + ustat_aug_other_multi + ustat_ver_Other + ustat_ver_Multi_Other + ustat_is_in_dmf;
			return tin_ustat;
	end;
	Export getTIN_CIC(boolean ui_Missing, boolean ui_badFormat, boolean TINVerified, boolean TypeCorrection, boolean CallCorrection, boolean ActiveLicAuthSrc) := Function
		return map(TypeCorrection => Healthcare_Shared.Constants.cic_TIN_TypeCorrection,
									CallCorrection => Healthcare_Shared.Constants.cic_TIN_CallBasedHCCorrection,
									TINVerified => Healthcare_Shared.Constants.cic_TIN_Auth_Verified,
									ActiveLicAuthSrc and ui_Missing => Healthcare_Shared.Constants.cic_TIN_Auth_Aug_NoInput,
									ActiveLicAuthSrc and not TINVerified and not ui_Missing and not ui_badFormat => Healthcare_Shared.Constants.cic_TIN_Auth_Aug_WrongInput,
									ActiveLicAuthSrc and ui_badFormat => Healthcare_Shared.Constants.cic_TIN_Auth_Found_BadInput,
									not ActiveLicAuthSrc and ui_badFormat => Healthcare_Shared.Constants.cic_TIN_Auth_Found_BadInput,
									not ActiveLicAuthSrc and ui_Missing => Healthcare_Shared.Constants.cic_TIN_NoAuth_MissingInput,
									'');
	end;
End;