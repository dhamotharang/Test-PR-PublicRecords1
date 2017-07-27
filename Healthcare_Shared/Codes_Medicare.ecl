EXPORT Codes_Medicare := Module
	Export getMedicare_USTAT(boolean ui_Missing, boolean MedicareVerified, boolean ExistsBestSource) := Function
			ustat_missing := IF(ui_Missing,Healthcare_Shared.Constants.ustat_Medicare_Missing,0);
			ustat_verified := IF(MedicareVerified,Healthcare_Shared.Constants.ustat_Medicare_Verified,0);
			ustat_aug_avail := IF(not MedicareVerified and ExistsBestSource,Healthcare_Shared.Constants.ustat_Medicare_AugAuthSource,0);
			medicare_ustat := ustat_missing + ustat_verified + ustat_aug_avail;
			return medicare_ustat;
	end;	
	Export getMedicare_CIC	(boolean is_Missing, boolean is_Bad, boolean is_Verified, boolean is_Aug_Avail) := Function
		return map(	is_Verified => Healthcare_Shared.Constants.cic_Medicare_Auth_Verified,
												is_Missing and is_Aug_Avail => Healthcare_Shared.Constants.cic_Medicare_Auth_Aug_NoInput,
												not is_Verified and is_Aug_Avail => Healthcare_Shared.Constants.cic_Medicare_Auth_Aug_WrongInput,												
												is_Missing and not is_Aug_Avail => Healthcare_Shared.Constants.cic_Medicare_NoAuth_MissingInput,												
										'');
	end;	
End;