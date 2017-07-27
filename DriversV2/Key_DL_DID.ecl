import Doxie_Files, doxie, Doxie_Build, Drivers;

//export Key_DL_DID := Doxie_Files.key_DL_DID;

base := dedup(DriversV2.DL_Decoded(did != 0), all);

export Key_DL_DID := index(base,
						   {did},
						   {base},
						   '~thor_data400::key::dl2::'+doxie.Version_SuperKey+'::dl_did_'+doxie_build.buildstate);
						   //'~thor_data400::key::dl2::dl_did_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);
						   