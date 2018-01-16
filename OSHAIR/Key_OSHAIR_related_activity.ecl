import doxie,Data_Services;

f_oshair := OSHAIR.file_out_related_activity_cleaned;

export Key_OSHAIR_related_activity := index(f_oshair
                                           ,{Activity_Number}
										   ,{f_oshair}
										   ,Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::related_activity_'+doxie.Version_SuperKey);
