Import Data_Services, doxie, doxie_files, Data_services;

base := DriversV2.File_DL_Search_Extended;				   

export Key_DL_Seq := index(base,
						   {dl_seq},
						   {base},
						   Data_Services.Data_location.Prefix('DLS') +'thor_data400::key::dl2::'+doxie.Version_SuperKey+'::DL_Seq');