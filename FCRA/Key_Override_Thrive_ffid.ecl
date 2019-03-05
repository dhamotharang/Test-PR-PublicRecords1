import fcra, ut, data_services; 
export Key_Override_Thrive_ffid := MODULE

shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';

ds_thrive := dataset(fname_prefix + 'thrive',FCRA.Layout_Override_thrive,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
dailyds_thrive := dataset(daily_prefix + 'thrive',FCRA.Layout_Override_thrive,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
kf := dedup(sort(ds_thrive,-flag_file_id),except flag_file_id,keep(1));
FCRA.Mac_Replace_Records(kf,dailyds_thrive,persistent_record_id,replaceds);

replaceds_dep := FCRA.fDeprecate_Fields_Thrive(replaceds);  //Field deprecation 

export thrive := index(replaceds_dep,{flag_file_id}, {replaceds_dep},
// export thrive := index(replaceds,{flag_file_id}, {replaceds_dep},
	keyname_prefix + 'Thrive::qa::ffid', OPT);
END;
