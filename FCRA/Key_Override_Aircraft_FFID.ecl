import fcra, data_services;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::aircraft',
                         fcra.layout_override_aircraft,
                         csv(separator('\t'),
                         quote('\"'),
                         terminator('\r\n')),
                         opt),
                         -flag_file_id),except flag_file_id,keep(1));

export key_override_aircraft_ffid := index(kf,
                                           {flag_file_id}, 
                                           {kf},
                                           data_services.data_location.prefix() + 'thor_data400::key::override::fcra::aircraft::qa::ffid');