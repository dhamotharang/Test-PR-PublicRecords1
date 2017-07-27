EXPORT Codes_UPIN := Module;
	Export getUPIN_USTAT(Boolean IsMissing, Boolean IsBad, Boolean UPINVerified, 
												Boolean Aug_Avail, Boolean Other_Person) := Function
			ustat_missing := IF(IsMissing,Healthcare_Shared.Constants.ustat_UPIN_Missing,0);
			ustat_badFormat := IF(IsBad,Healthcare_Shared.Constants.ustat_UPIN_BadFormat,0);
			ustat_verified := IF(UPINVerified,Healthcare_Shared.Constants.ustat_UPIN_Verified,0);
			ustat_aug_avail := IF(Aug_Avail,Healthcare_Shared.Constants.ustat_UPIN_AugAuthSource,0);
			ustat_other_person := IF(Other_Person,Healthcare_Shared.Constants.ustat_UPIN_SomeoneElse,0);
			upin_ustat := ustat_missing + ustat_badFormat + ustat_verified + ustat_aug_avail + ustat_other_person;
			return upin_ustat;
	end;
	Export getUPIN_CIC(Boolean IsMissing, Boolean IsBad, Boolean UPINVerified, 
											Boolean Aug_Avail, Boolean Other_Person) := Function
		return map(UPINVerified => Healthcare_Shared.Constants.cic_UPIN_Auth_Verified,
										Aug_Avail and IsMissing => Healthcare_Shared.Constants.cic_UPIN_Auth_Aug_NoInput,
										Aug_Avail and Other_Person => Healthcare_Shared.Constants.cic_UPIN_Auth_Aug_Other,
										Aug_Avail and not IsMissing => Healthcare_Shared.Constants.cic_UPIN_Auth_Aug_WrongInput,
										Aug_Avail and IsBad => Healthcare_Shared.Constants.cic_UPIN_Auth_Found_BadInput,
										not Aug_Avail and IsBad => Healthcare_Shared.Constants.cic_UPIN_NoAuth_BadInput,
										not Aug_Avail and IsMissing => Healthcare_Shared.Constants.cic_UPIN_NoAuth_MissingInput,
										'');
	end;
end;