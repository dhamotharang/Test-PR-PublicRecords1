IMPORT doxie, NCPDP, data_services;

KeyBase := NCPDP.Files().KeyBuild_base.Built(federal_tax_id != '');

EXPORT key_FEIN := INDEX(KeyBase,
												 {federal_tax_id},
												 {NCPDP_provider_id},
							           Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::FEIN');