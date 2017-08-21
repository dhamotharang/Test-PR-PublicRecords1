import fcra, ut, data_services;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::ADVO',FCRA.Layout_Override_ADVO,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

// kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

export Key_Override_ADVO_ffid := index(kf,{flag_file_id}, {kf},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::ADVO::qa::ffid');