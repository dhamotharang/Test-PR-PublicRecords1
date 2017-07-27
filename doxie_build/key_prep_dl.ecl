dl4key := dedup(file_dl_keybuilding(did != 0), did, dl_number, all);

export key_prep_dl := index(dl4key, {unsigned6 s_did := dl4key.did}, {dl4key.dl_number}, '~thor_data400::key::dl_'+doxie_build.buildstate + thorlib.wuid());