IMPORT doxie, NCPDP, data_services;

KeyBase := NCPDP.Files().KeyBuild_base.Built(bdid > 0);

EXPORT key_BDID := INDEX(KeyBase,
												 {bdid},
												 {NCPDP_provider_id},
							           Data_services.data_location.prefix('DEFAULT') + 
												 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::BDID');