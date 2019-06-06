import prof_license_mari, data_services;

EXPORT Key_Override_Proflic_Mari_ffid := module

shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
shared keyname_prefix := data_services.data_location.prefix() + 'thor_data400::key::override::fcra::';


// Professional License MARI record
  proflic_mari_rec := RECORD
    //CCPA-110 Exclude new CCPA fields from override MARI key
    recordof(Prof_License_Mari.key_did(true)) - [global_sid,record_sid];
    string20 flag_file_id;
  end;

  ds_proflic_mari := dataset (fname_prefix + 'proflic_mari', proflic_mari_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_proflic_mari := dataset (daily_prefix + 'proflic_mari', proflic_mari_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_proflic_mari, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_proflic_mari,persistent_record_id,replaceds);
  export proflic_mari := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'proflic_mari::qa::ffid', OPT);

END;