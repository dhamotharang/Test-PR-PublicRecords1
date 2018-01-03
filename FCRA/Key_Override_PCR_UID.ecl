import fcra, data_services;

kf := PCR_for_FCRA(uid<>'');

export key_override_pcr_uid := index(kf, 
                                     {uid}, 
                                     {kf}, 
                                     data_services.data_location.prefix() + 'thor_data400::key::override::fcra::pcr::qa::uid');