import doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_hazardous_substance_cleaned;

export Key_OSHAIR_hazardous_substance := index(f_oshair
                                              ,{Activity_Number}
											  ,{f_oshair}
											  ,'~thor_data400::key::oshair::hazardous_substance_'+doxie.Version_SuperKey);
