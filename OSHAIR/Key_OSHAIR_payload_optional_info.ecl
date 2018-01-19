import doxie,Data_Services;

f_oshair := OSHAIR.file_out_optional_info_cleaned;

export Key_OSHAIR_payload_optional_info := index(f_oshair
                                          ,{Activity_Number}
										  ,{f_oshair}
										  ,Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::payload_optional_info_'+doxie.Version_SuperKey);
