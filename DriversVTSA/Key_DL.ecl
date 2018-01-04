import doxie, data_services;

dl4key := dedup(File_DL_Search(did != 0), did, dl_number, all);

export Key_DL := index(dl4key, 
                       {unsigned6 s_did := dl4key.did}, 
                       {dl4key.dl_number,dl4key.orig_state},
                       data_services.data_location.prefix() + 'thor400_92::key::dl_VTSA::'+doxie.Version_SuperKey+'::dl');