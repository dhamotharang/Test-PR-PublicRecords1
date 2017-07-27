import avm_v2;
EXPORT key_override_avm := module
	shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	shared keyname_prefix := '~thor_data400::key::override::fcra::';

	ds_avm_medians := dataset(fname_prefix + 'avm_medians',AVM_V2.layouts.Layout_Override_AVM_Medians,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_avm_medians := dataset(daily_prefix + 'avm_medians',AVM_V2.layouts.Layout_Override_AVM_Medians,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	kf := dedup(sort(ds_avm_medians,-flag_file_id),except flag_file_id,keep(1));
	FCRA.Mac_Replace_Records(kf,dailyds_avm_medians,geolink,replaceds);

	export avm_medians := index(replaceds,{flag_file_id}, {replaceds},
						keyname_prefix + 'avm_medians::qa::ffid');
						
	ds_avm_address := dataset(fname_prefix + 'address_data',AVM_V2.layouts.Layout_Override_AVM_Address,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_avm_address := dataset(daily_prefix + 'address_data',AVM_V2.layouts.Layout_Override_AVM_Address,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	kf := dedup(sort(ds_avm_address,-flag_file_id),except flag_file_id,keep(1));
	FCRA.Mac_Replace_Records(kf,dailyds_avm_address,did,replaceds);

	export address_data := index(replaceds,{flag_file_id}, {replaceds},
						keyname_prefix + 'address_data::qa::ffid',OPT);
end;