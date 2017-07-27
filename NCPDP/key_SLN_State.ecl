IMPORT doxie, NCPDP, data_services;

KeyBase := NCPDP.Files().KeyBuild_base.Built(state_license_number != '' AND Phys_state != '');
																				
EXPORT key_SLN_State := INDEX(KeyBase,
												      {state_license_number, Phys_state},
												      {NCPDP_provider_id},
							                Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' + doxie.Version_SuperKey + '::SLN_State');