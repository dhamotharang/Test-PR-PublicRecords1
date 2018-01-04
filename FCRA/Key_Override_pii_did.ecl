import fcra, data_services;

kf := Pii_for_FCRA ((unsigned)did<>0);

export Key_Override_pii_did := index(kf,
			                               {unsigned6 s_did := (unsigned)did}, 
			                               {kf}, 
			                               data_services.data_location.prefix() + 'thor_data400::key::override::pii::qa::did');