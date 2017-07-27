import doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_inspection_cleaned;

export Key_OSHAIR_payload_inspection := index(f_oshair
                                            ,{Activity_Number}
										    ,{f_oshair}
										    ,'~thor_data400::key::oshair::payload_inspection_'+doxie.Version_SuperKey);
