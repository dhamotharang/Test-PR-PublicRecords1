import fcra, ut;

kf := PCR_for_FCRA(ssn<>'');

export key_override_npcr_ssn := 
index(kf,
			{ssn},{kf}, '~thor_data400::key::override::pcr::qa::ssn');