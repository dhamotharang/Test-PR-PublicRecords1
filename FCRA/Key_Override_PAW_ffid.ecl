import fcra, ut, data_services;

base_file := dataset('~thor_data400::base::override::fcra::qa::PAW',FCRA.Layout_Override_PAW,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt)(flag_file_id<>'');

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

kf_dep := FCRA.fDeprecate_Fields_PAW(kf);  //Field deprecation

export Key_Override_PAW_ffid := index(kf_dep,{flag_file_id}, {kf_dep},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::PAW::qa::ffid');