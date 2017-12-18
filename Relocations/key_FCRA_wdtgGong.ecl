import  NID,data_services;

file_prefix := data_services.data_location.prefix() + 'thor_data400';


baserecset := Relocations.file_wdtgGong;
indexfile := file_prefix + '::key::gong_history::fcra::qa::wdtg';

// this index finds surnames showing up in the gong at a particular point in time,
// perhaps limited by further name/location details
export key_FCRA_wdtgGong := index(
	baserecset,
	{	// keyed fields
		string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
		dt_first_seen,
		integer4 zip5 := (integer4)z5,
		string20 p_name_first := NID.PreferredFirstVersionedStr(name_first, NID.version),
		name_last,
		name_first
	},
	{baserecset},
	indexfile
);

// Build this on the "400way" cluster with...
//
// buildindex(Relocations.key_wdtgGong, OVERWRITE);
