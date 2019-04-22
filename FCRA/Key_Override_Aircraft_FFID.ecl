import fcra, ut, data_services, FAA;

kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::aircraft',fcra.layout_override_aircraft,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

// DF-22458 deprecate specified fields in thor_data400::key::override::fcra::aircrafts::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, FAA.Constants.fields_to_clear_aircraft);

export key_override_aircraft_ffid := index(kf_cleared,{flag_file_id}, {kf_cleared},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::aircraft::qa::ffid');