import doxie, nid;

file_prefix := '~thor_data400';


baserecset := Relocations.file_wdtgGong;
indexfile := file_prefix + '::key::gong_history_wdtg_' + doxie.Version_SuperKey;

// this index finds surnames showing up in the gong at a particular point in time,
// perhaps limited by further name/location details
export key_wdtgGong := index(
	baserecset,
	{	// keyed fields
		string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
		dt_first_seen,
		integer4 zip5 := (integer4)z5,
		string20 p_name_first := NID.PreferredFirstNew(name_first),
		name_last,
		name_first
	},
	{baserecset},
	indexfile
);

// Build this on the "thor400_92" cluster with...
//
// buildindex(Relocations.key_wdtgGong, OVERWRITE);
