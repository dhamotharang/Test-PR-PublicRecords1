IMPORT doxie, NCPDP, data_services;

KeyBase := NCPDP.Files().KeyBuild_base.Built(DEA_registration_id != '');

EXPORT key_DEA := INDEX(KeyBase,
												{DEA_registration_id},
												{NCPDP_provider_id},
							          Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::DEA');