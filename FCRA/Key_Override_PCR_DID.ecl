import fcra, ut;

kf := PCR_for_FCRA((unsigned)did<>0);

export key_override_pcr_did := 
index(kf,
			{unsigned6 s_did := (unsigned)did}, {kf}, '~thor_data400::key::override::fcra::pcr::qa::did');