import doxie_build, doxie;

dl4key := dedup(file_dl(did != 0), did, dl_number, all);

export Key_DL := index(dl4key, {unsigned6 s_did := dl4key.did}, {dl4key.dl_number,dl4key.orig_state}, '~thor_data400::key::dl_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);