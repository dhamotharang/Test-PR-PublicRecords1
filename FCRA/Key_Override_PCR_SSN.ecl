import fcra, data_services, vault, _control;

kf := PCR_for_FCRA(ssn<>'');

#IF(_Control.Environment.onVault) 
export key_override_pcr_ssn := vault.FCRA.Key_Override_PCR_SSN;
#ELSE
export key_override_pcr_ssn := index(kf,
			                               {ssn},
			                               {kf}, 
			                               data_services.data_location.prefix() + 'thor_data400::key::override::fcra::pcr::qa::ssn');
#END;