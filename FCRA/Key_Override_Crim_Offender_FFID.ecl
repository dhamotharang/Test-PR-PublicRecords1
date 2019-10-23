import fcra, CrimSrch, ut, data_services;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::crim_offender',fcra.layout_override_crim_offender,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt)(offender_key <> ''),-flag_file_id),except flag_file_id,keep(1));

export key_override_crim_offender_FFID := index (kf, {flag_file_id}, {kf},
  data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::criminal_offender::qa::ffid');