import fcra, ut, data_services, Advo;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::ADVO',FCRA.Layout_Override_ADVO,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));
// kf := dedup(sort(dataset(data_services.foreign_prod+'thor_data400::base::override::fcra::qa::ADVO',FCRA.Layout_Override_ADVO,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

// DF-22458 deprecate specified fields in thor_data400::key::override::fcra::advo::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, ADVO.Constants.fields_to_clear);

// kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

export Key_Override_ADVO_ffid := index(kf_cleared,{flag_file_id}, {kf_cleared},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::ADVO::qa::ffid');