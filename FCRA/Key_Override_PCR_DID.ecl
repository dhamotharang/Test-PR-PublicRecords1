import fcra, data_services;

kf := PCR_for_FCRA((unsigned)did<>0);

export key_override_pcr_did := index(kf,
			                               {unsigned6 s_did := (unsigned)did}, 
			                               {kf}, 
			                               data_services.data_location.prefix() + 'thor_data400::key::override::fcra::pcr::qa::did');