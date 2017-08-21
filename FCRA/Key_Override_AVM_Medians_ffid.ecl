import fcra, ut, data_services; 
export Key_Override_AVM_Medians_ffid := MODULE

shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
shared keyname_prefix := '~thor_data400::key::override::fcra::';

ds_avm_medians := dataset(fname_prefix + 'avm_medians',FCRA.Layout_Override_AVM_Medians,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
dailyds_avm_medians := dataset(daily_prefix + 'avm_medians',FCRA.Layout_Override_AVM_Medians,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
kf := dedup(sort(ds_avm_medians,-flag_file_id),except flag_file_id,keep(1));
FCRA.Mac_Replace_Records(kf,dailyds_avm_medians,geolink,replaceds);

export avm_medians := index(replaceds,{flag_file_id}, {replaceds},
data_services.data_location.prefix('fcra_overrides')+keyname_prefix + 'avm_medians::qa::ffid', OPT);
END;

