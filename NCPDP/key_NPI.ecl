IMPORT doxie, NCPDP, data_services;

KeyBase := NCPDP.Files().KeyBuild_base.Built(national_provider_id != '');

EXPORT key_NPI := INDEX(KeyBase,
												{national_provider_id},
											  {NCPDP_provider_id},
							          Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::NPI');