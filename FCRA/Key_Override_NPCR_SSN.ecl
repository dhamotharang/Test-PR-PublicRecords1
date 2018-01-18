import fcra, data_services;

kf := PCR_for_FCRA(ssn<>'');

export key_override_npcr_ssn := index(kf,
			                                {ssn},
			                                {kf}, 
			                                data_services.data_location.prefix() + 'thor_data400::key::override::pcr::qa::ssn');