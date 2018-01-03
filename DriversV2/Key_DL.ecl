import doxie_build, doxie, data_services;

dl4key := dedup(Driversv2.file_dl_search(did != 0), did, dl_number, all);

export Key_DL := index(dl4key, 
                       {unsigned6 s_did := dl4key.did}, 
                       {dl4key.dl_number,dl4key.orig_state}, 
                       data_services.data_location.prefix() + 'thor_data400::key::dl2::'+ doxie.Version_SuperKey +'::dl_'+doxie_build.buildstate);