import doxie,Data_Services;

f_oshair := OSHAIR.file_out_violations_cleaned;

export Key_OSHAIR_payload_violations := index(f_oshair
                                          ,{Activity_Number}
										  ,{f_oshair}
										  ,Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::payload_violations_'+doxie.Version_SuperKey);
