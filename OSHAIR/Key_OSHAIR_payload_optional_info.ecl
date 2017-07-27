import doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_optional_info_cleaned;

export Key_OSHAIR_payload_optional_info := index(f_oshair
                                          ,{Activity_Number}
										  ,{f_oshair}
										  ,'~thor_data400::key::oshair::payload_optional_info_'+doxie.Version_SuperKey);
