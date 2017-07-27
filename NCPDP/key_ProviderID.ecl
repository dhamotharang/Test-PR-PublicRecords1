IMPORT doxie, NCPDP, data_services;

KeyBase := project(NCPDP.Files().KeyBuild_base.Built(NCPDP_provider_id != ''),NCPDP.Layouts.Keybuild_OLD);

EXPORT key_ProviderID :=
         INDEX(KeyBase,
					     {NCPDP_provider_id},
							 {KeyBase},
							 Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::NCPDP_ID');