EXPORT Codes_Taxonomy := Module
	Export getTaxonomy_USTAT(boolean IsMissing, boolean Isbad,boolean verifiedTypeClass, boolean corroborated,
												 boolean verifiedExact,boolean TypoCorrection, boolean HighConfCorrection, boolean AugAuthSrc,boolean discrepancy) := Function
												 ustat_missing := IF(IsMissing,Healthcare_Shared.Constants.ustat_Taxonomy_Missing,0);
												 ustat_badFormat := IF(IsBad,Healthcare_Shared.Constants.ustat_Taxonomy_BadFormat,0);
												 ustat_verified := IF(verifiedTypeClass,Healthcare_Shared.Constants.ustat_Taxonomy_Verified_Multiple,0);
												 ustat_verified_exact := IF(verifiedExact,Healthcare_Shared.Constants.ustat_Taxonomy_Verified_Auth,0);
												 ustat_typo_Corr := IF(TypoCorrection,Healthcare_Shared.Constants.ustat_Taxonomy_TypeCorrection,0);
												 ustat_HC_Corr := IF(HighConfCorrection,Healthcare_Shared.Constants.ustat_Taxonomy_CallBasedHCCorrection,0);
												 ustat_aug_auth_src := IF(AugAuthSrc,Healthcare_Shared.Constants.ustat_Taxonomy_AugAuthoritySrc,0);
												 ustat_corroborated := IF(corroborated,Healthcare_Shared.Constants.ustat_TIN_Verified_1_Source,0); // add this identical stat to taxonomy
												 ustat_discrepancy:=   IF(discrepancy,Healthcare_Shared.Constants.ustat_Taxonomy_SomeoneElse,0); // add this identical stat to taxonomy
												 taxonomy_ustat := ustat_missing + ustat_badFormat + ustat_verified + ustat_verified_exact + ustat_typo_Corr + ustat_HC_Corr + ustat_aug_auth_src + ustat_corroborated+ustat_discrepancy;
												 return taxonomy_ustat;
										 
	end;
	Export getTaxonomy_CIC(boolean IsMissing, boolean Isbad,boolean verifiedTypeClass, 
												 boolean verifiedExact,boolean TypoCorrection, boolean HighConfCorrection, boolean AugAuthSrc) := Function
				 return map(verifiedTypeClass=>Healthcare_Shared.Constants.cic_Taxonomy_TypeClassVerified,
										TypoCorrection=>Healthcare_Shared.Constants.cic_Taxonomy_TypeCorrection,
										HighConfCorrection=> Healthcare_Shared.Constants.cic_Taxonomy_HighConfCorrection,
										 AugAuthSrc and IsMissing => Healthcare_Shared.Constants.cic_Taxonomy_Auth_Aug_NoInput,
										AugAuthSrc and isBad  => Healthcare_Shared.Constants.cic_Taxonomy_Auth_Found_BadInput,
										AugAuthSrc and not verifiedTypeClass and not isMissing => Healthcare_Shared.Constants.cic_Taxonomy_Auth_Aug_WrongInput,
										Not AugAuthSrc and isMissing => Healthcare_Shared.Constants.cic_Taxonomy_NoAuth_MissingInput,
										Not AugAuthSrc and  isBad  => Healthcare_Shared.Constants.cic_Taxonomy_NoAuth_BadInput,
										'');
	end;
End;