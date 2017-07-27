import fcra, ut;

kf := PCR_for_FCRA(uid<>'');

export key_override_pcr_uid := 
index(kf, {uid}, {kf}, '~thor_data400::key::override::fcra::pcr::qa::uid');