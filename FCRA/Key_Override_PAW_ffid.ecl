import fcra, ut, data_services, Overrides;

//CCPA-1052 - Add CCPA fields to Override PAW key
base_file0 := dataset('~thor_data400::base::override::fcra::qa::PAW',FCRA.Layout_Override_PAW_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt)(flag_file_id<>'');
base_file  := PROJECT(base_file0, $.Layout_Override_PAW);

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

kf_dep := FCRA.fDeprecate_Fields_PAW(kf);  //Field deprecation

Overrides.mac_filter_orphanrecords(kf_dep
																	,flag_file_id
																	,flag_file_id
																	,FCRA.FILE_ID.PAW
																	,r_dOrphanFiltered);

export Key_Override_PAW_ffid := index(r_dOrphanFiltered,{flag_file_id}, {kf_dep},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::PAW::qa::ffid');