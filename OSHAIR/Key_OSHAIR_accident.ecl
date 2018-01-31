import doxie,Data_Services;

f_oshair := OSHAIR.file_out_accident_cleaned;

export Key_OSHAIR_accident := index(f_oshair
                                   ,{Activity_Number}
								   ,{f_oshair}
								   ,Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::accident_'+doxie.Version_SuperKey);
