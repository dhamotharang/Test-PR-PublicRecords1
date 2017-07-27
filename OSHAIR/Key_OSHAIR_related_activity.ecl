import doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_related_activity_cleaned;

export Key_OSHAIR_related_activity := index(f_oshair
                                           ,{Activity_Number}
										   ,{f_oshair}
										   ,'~thor_data400::key::oshair::related_activity_'+doxie.Version_SuperKey);
