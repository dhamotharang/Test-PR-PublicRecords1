EXPORT Codes_StateLicense := Module
	Export getLicense_USTAT(boolean isMissing, boolean hasCompanionData, boolean LicenseVerified, boolean LicenceVerifiedState, boolean LicenseSuppliedExists,
														boolean LicenseSuspended, boolean LicenseInactive, boolean LicenseExpiredWithinGrace,
														boolean LicenseRestricted, boolean LicenseAuthSingle, boolean LicenseAuthMultiple,
														boolean LicenseAuthPracState, boolean LicenseAuthNonPracState) := Function
			ustat_missing := IF(isMissing,Healthcare_Shared.Constants.ustat_License_Missing,0);
			ustat_verified := IF(LicenseVerified,Healthcare_Shared.Constants.ustat_License_Verified,0);
			ustat_verified_Lic_State := IF(LicenceVerifiedState,Healthcare_Shared.Constants.ustat_License_Verified_Lic_State,0);
			ustat_companionData := IF(hasCompanionData,Healthcare_Shared.Constants.ustat_License_CompanionData,0);
			ustat_other_person := IF(Not LicenseVerified and LicenseSuppliedExists,Healthcare_Shared.Constants.ustat_License_SomeoneElse,0);
			ustat_suspended := IF(LicenseSuspended,Healthcare_Shared.Constants.ustat_License_Suspended,0);
			ustat_expired := IF(LicenseInactive,Healthcare_Shared.Constants.ustat_License_Inactive,0);
			ustat_expired_grace := IF(LicenseExpiredWithinGrace,Healthcare_Shared.Constants.ustat_License_ExpiredWithinGrace,0);
			ustat_restricted := IF(LicenseRestricted,Healthcare_Shared.Constants.ustat_License_PracRestricted,0); 
			ustat_auth_Single := 0;//IF(LicenseAuthSingle,Healthcare_Shared.Constants.ustat_Aug_AuthSrc_SingleSrc,0); //not used in 6.4
			ustat_auth_Multiple := 0;//IF(LicenseAuthMultiple,Healthcare_Shared.Constants.ustat_Aug_AuthSrc_MultipleSrc,0); //not used in 6.4
			ustat_auth_PracState := IF(LicenseAuthPracState,Healthcare_Shared.Constants.ustat_Aug_AuthSrc_PracState,0);
			ustat_auth_NonPracState := IF(LicenseAuthNonPracState,Healthcare_Shared.Constants.ustat_Aug_AuthSrc_NonPracState,0);
			ustat_auth := IF(LicenseAuthSingle or LicenseAuthMultiple or LicenseAuthPracState or LicenseAuthNonPracState,Healthcare_Shared.Constants.ustat_Aug_AuthSrc,0);
			license_ustat := ustat_missing + ustat_verified + ustat_verified_Lic_State + ustat_companionData + ustat_other_person + ustat_suspended + ustat_expired + 
												ustat_expired_grace + ustat_restricted + ustat_auth_Single + ustat_auth_Multiple + 
												ustat_auth_PracState + ustat_auth_NonPracState + ustat_auth;
			return license_ustat;
	end;
	Export getLicense_CIC(boolean isMissing, boolean isSuspended, boolean LicenseInactive, boolean isExpiredWithinGrace, boolean hasAuthNonPracState,
														boolean hasAuthPracState, boolean isSomeoneElse, boolean isPracRestricted,
														boolean hasAuth, boolean hasAuthSingleSrc, boolean hasAuthMultipleSrc,
														boolean hasCompanionData, boolean restrictedLicPracState, boolean provider_noActiveLicPracState) := Function
				return map(isSuspended => Healthcare_Shared.Constants.cic_License_Suspended,
									 isExpiredWithinGrace and 
											not hasAuthNonPracState and not hasAuthPracState => Healthcare_Shared.Constants.cic_License_Expired_NoAug,
									 isExpiredWithinGrace and 
											hasAuthPracState => Healthcare_Shared.Constants.cic_License_Expired_Aug,
									 (not hasCompanionData and not isMissing and isSomeoneElse and
											not isSuspended and not LicenseInactive and not isExpiredWithinGrace and
											not isPracRestricted and hasAuthPracState and restrictedLicPracState) or
									 (isMissing and hasAuthPracState and restrictedLicPracState) => Healthcare_Shared.Constants.cic_License_Verified_Restricted,
									 not hasCompanionData and not isMissing and isSomeoneElse and
											not isSuspended and not LicenseInactive and not isExpiredWithinGrace and
											not isPracRestricted and hasAuthPracState => Healthcare_Shared.Constants.cic_License_WrongInput_Aug,
									 isMissing and hasAuthPracState => Healthcare_Shared.Constants.cic_License_Missing_Aug,
									 isExpiredWithinGrace and 
											hasAuthNonPracState and not hasAuthPracState and 
											provider_noActiveLicPracState => Healthcare_Shared.Constants.cic_License_Expired_Aug_Other_State,
									 not hasCompanionData and not isMissing and isSomeoneElse and
											not isSuspended and not isExpiredWithinGrace and
											not isPracRestricted and hasAuthNonPracState and 
											not hasAuthPracState => Healthcare_Shared.Constants.cic_License_WrongInput_Aug_Other_State,
									 isMissing and hasAuthNonPracState and not hasAuthPracState => Healthcare_Shared.Constants.cic_License_Missing_Aug_Other_State,
									 isMissing and not hasAuthSingleSrc and not hasAuthMultipleSrc and
											not hasAuthNonPracState and not hasAuthPracState and 
											not hasAuth => Healthcare_Shared.Constants.cic_License_Missing_NoAug,
									 // isSomeoneElse and hasAuthSingleSrc and hasAuthMultipleSrc and
											// hasAuth and (integer)inputlic <> (integer)resultslicnumber=> Healthcare_Shared.Constants.cic_License_SomeoneElse,
									 isSomeoneElse and hasAuthSingleSrc and hasAuthMultipleSrc and
											hasAuth => Healthcare_Shared.Constants.cic_License_SomeoneElse,
									 isPracRestricted => Healthcare_Shared.Constants.cic_License_WrongInput_Restricted,
									 // (what is 2,4,and 8? and hasCompanionData) or (isSomeoneElse and hasAuthSingleSrc and hasAuthMultipleSrc and
											// hasAuth) => Healthcare_Shared.Constants.cic_License_Verified_Aug,
									 (hasCompanionData) or (isSomeoneElse and hasAuthSingleSrc and hasAuthMultipleSrc and
											hasAuth) => Healthcare_Shared.Constants.cic_License_Verified_Aug,
										'');
	end;
End;