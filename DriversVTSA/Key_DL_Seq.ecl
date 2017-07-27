import doxie, doxie_files,ut;

base := DriversVTSA.File_DL_Search;				   

export Key_DL_Seq := index(base,
						   {dl_seq},
						   {base},
					   constants.cluster + 'key::dl_VTSA::'+doxie.Version_SuperKey+'::dl_seq');
