import doxie, doxie_build, data_services;

dl4key := dedup(
doxie_files.DL_Decoded(false)
(did != 0), all);

export key_DL_DID := index(dl4key, 
     {dl4key.did}, 
     {dl4key}, 
     data_services.data_location.prefix() + 'thor_data400::key::dl_did_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);