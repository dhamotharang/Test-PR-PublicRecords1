import doxie_build;

df := file_offenders_keybuilding(doc_num <> '');

export key_prep_offenders_docnum := index(df,{string10 docnum := df.doc_num, string2 state := df.st},{df},'~thor_data400::key::Corrections_Offenders_docnum_' + doxie_build.buildstate + thorlib.wuid());