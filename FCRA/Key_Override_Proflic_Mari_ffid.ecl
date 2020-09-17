import data_services,prof_license_mari, ut;

EXPORT Key_Override_Proflic_Mari_ffid := module

//Map data to intended layout
// this layout is used in Overrides.reDID
export Layout_Override_Proflic_Mari := RECORD
	$.Layout_Override_Proflic_Mari_In - [__internal_fpos__];
END;

shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';

//DF-26605 - use layout definition for Proflic Mari input file
ds_proflic_mari := dataset (fname_prefix + 'proflic_mari', FCRA.Layout_Override_Proflic_Mari_In, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
dailyds_proflic_mari := dataset (daily_prefix + 'proflic_mari', FCRA.Layout_Override_Proflic_Mari_In, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
//DF-28168 - filter out records with blank flag_file_id
kf := dedup (sort (ds_proflic_mari(flag_file_id<>''), -flag_file_id), except flag_file_id);
FCRA.Mac_Replace_Records(kf,dailyds_proflic_mari,persistent_record_id,replaceds);
// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::proflic_mari::qa::ffid
ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, Prof_License_Mari.constants.fields_to_clear);
//CCPA-1047 - use layout defined for this key
final_ds := PROJECT(replaceds_cleared,$.Layout_Override_Proflic_Mari);
export proflic_mari := index (final_ds, {flag_file_id}, {final_ds}, keyname_prefix + 'proflic_mari::qa::ffid', OPT);

END;