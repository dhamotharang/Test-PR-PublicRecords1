import data_services,prof_license_mari, ut;

EXPORT Key_Override_Proflic_Mari_ffid := module

shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';

// Professional License MARI record
  export proflic_mari_rec := RECORD
    recordof(Prof_License_Mari.key_did(true));
    string20 flag_file_id;
  end;

	ds_proflic_mari := dataset (fname_prefix + 'proflic_mari', proflic_mari_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_proflic_mari := dataset (daily_prefix + 'proflic_mari', proflic_mari_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	kf := dedup (sort (ds_proflic_mari, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_proflic_mari,persistent_record_id,replaceds);
	// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::proflic_mari::qa::ffid
	ut.MAC_CLEAR_FIELDS(replaceds, replaceds_cleared, Prof_License_Mari.constants.fields_to_clear);
	
  export proflic_mari := index (replaceds_cleared, {flag_file_id}, {replaceds_cleared}, keyname_prefix + 'proflic_mari::qa::ffid', OPT);

END;