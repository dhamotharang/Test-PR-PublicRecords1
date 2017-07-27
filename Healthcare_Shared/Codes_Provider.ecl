EXPORT Codes_Provider := Module
		Export getProvider_USTAT(string status = '', boolean isProviderNotFound = false, boolean isDeaRetired = false, boolean isNoActLicPracState = false, boolean isRestrictedLicPracState= false,
															boolean isSuspendedLicPracState = false, boolean isInactiveLicPracState = false,
															boolean hasExpiredLicPracState= false, boolean isRetiredLicense=false) := Function
															
			//Provider Section
			ustat_ProviderNotFound := IF(isProviderNotFound,Healthcare_Shared.Constants.ustat_Provider_NotFound,0);  // control never reaches here if there are not providers in results from search									
			ustat_Retired_R4:= IF(status = 'R4',Healthcare_Shared.Constants.ustat_Provider_Retired_R4,0); 
			ustat_Status_R1 := IF(status = 'R1',Healthcare_Shared.Constants.ustat_Provider_Retired_R1,0);
			ustat_Status_R2 := IF(status = 'R2',Healthcare_Shared.Constants.ustat_Provider_Retired_R2,0);
			ustat_Status_R1R2 := IF(status = 'R1R2',(Healthcare_Shared.Constants.ustat_Provider_Retired_R1 + Healthcare_Shared.Constants.ustat_Provider_Retired_R2),0);
			ustat_Status_R1R4 := IF(status = 'R1R4',(Healthcare_Shared.Constants.ustat_Provider_Retired_R1+Healthcare_Shared.Constants.ustat_Provider_Retired_R4),0);
			ustat_Status_R2R4 := IF(status = 'R2R4',(Healthcare_Shared.Constants.ustat_Provider_Retired_R2+Healthcare_Shared.Constants.ustat_Provider_Retired_R4),0);
			ustat_Status_R1R2R4 := IF(status = 'R1R2R4',(Healthcare_Shared.Constants.ustat_Provider_Retired_R1+Healthcare_Shared.Constants.ustat_Provider_Retired_R2+Healthcare_Shared.Constants.ustat_Provider_Retired_R4),0);
			ustat_Status_D := IF(status = 'D',Healthcare_Shared.Constants.ustat_Provider_Confirm_Deceased,0);
			ustat_Status_U := IF(status = 'U',(Healthcare_Shared.Constants.ustat_Provider_Rpt_Deceased_U + Healthcare_Shared.Constants.ustat_Provider_Rpt_Deceased_U1),0);
			ustat_Status_U1 := IF(status = 'U1',Healthcare_Shared.Constants.ustat_Provider_Rpt_Deceased_U1,0);
			//Dea Section
			ustat_Retired_DEA := IF(isDeaRetired,Healthcare_Shared.Constants.ustat_Provider_DEARetired,0);
			//Licenses Section
			ustat_isRetiredLicense := IF(isRetiredLicense,Healthcare_Shared.Constants.ustat_Provider_Retired_R,0);
			ustat_noActiveLicPracState := IF(isNoActLicPracState,Healthcare_Shared.Constants.ustat_Provider_NoActLicPracState,0);
			ustat_restrictedLicPracState := IF(isRestrictedLicPracState,Healthcare_Shared.Constants.ustat_Provider_RestrictLicPracState,0);
			ustat_suspendedLicPracState := IF(isSuspendedLicPracState,Healthcare_Shared.Constants.ustat_Provider_SuspendLicPracState,0);
			ustat_isInactiveLicPracState := IF(isInactiveLicPracState,Healthcare_Shared.Constants.ustat_Provider_InactLicPracState,0);
			ustat_hasExpiredLicPracState := IF(hasExpiredLicPracState,Healthcare_Shared.Constants.ustat_Provider_ExpLicPracState,0);
				
			ustat_Status :=  ustat_Retired_R4 +  ustat_Status_R1 + ustat_Status_R2 + ustat_Status_R1R2 + ustat_Status_R1R4 +
											 ustat_Status_R2R4 + ustat_Status_R1R2R4 + ustat_Status_D + ustat_Status_U + ustat_Status_U1 ;
			
									
			provider_ustat := ustat_ProviderNotFound + ustat_Status + ustat_Retired_DEA + ustat_isRetiredLicense + ustat_noActiveLicPracState +
										ustat_restrictedLicPracState + ustat_suspendedLicPracState + ustat_isInactiveLicPracState + 
										ustat_hasExpiredLicPracState;
										
			// output(ustat_isRetiredLicense, Named('ustat_isRetiredLicense'),overwrite);	
			// output(ustat_cooked_isRetiredLicense, Named('ustat_cooked_isRetiredLicense'),overwrite);
			// output(ustat_Status_R1R2R4, Named('ustat_Status_R1R2R4'),overwrite);
			// output(status, Named('getProviderUstat_status'),overwrite);
			return provider_ustat;
	end;
	Export getProvider_CIC(string status) := Function
					return map(	status = 'U1' => Healthcare_Shared.Constants.cic_Provider_Rpt_Deceased_U1,
									status = 'D'  => Healthcare_Shared.Constants.cic_Provider_Confirm_Deceased,
									status = 'U'  => Healthcare_Shared.Constants.cic_Provider_Rpt_Deceased_U,
									status = 'R4' => Healthcare_Shared.Constants.cic_Provider_Retired_R4,
									status in ['R1','R1R2','R1R4','R1R2R4'] => Healthcare_Shared.Constants.cic_Provider_Retired_R1,
									status in ['R2','R2R4'] => Healthcare_Shared.Constants.cic_Provider_Retired_R2,
									Healthcare_Shared.Constants.cic_Provider_Active);
	end;
End;