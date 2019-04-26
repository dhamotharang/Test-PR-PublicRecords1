import fcra, ut, Watercraft;

// kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::watercraft',fcra.layout_override_watercraft,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));
kf := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::watercraft',fcra.layout_override_watercraft,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

	// DF-21844 Blank out specified fields in thor_data400::key::override::fcra::watercraft::qa::ffid
	ut.MAC_CLEAR_FIELDS(kf, kf_cleared, Watercraft.Constants.fields_to_clear_sid);

export key_override_watercraft_ffid := index(kf_cleared,{flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::watercraft::qa::ffid');