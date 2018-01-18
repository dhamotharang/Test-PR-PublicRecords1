import doxie_build, data_services;

df := file_offenders_keybuilding;

export key_prep_offenders_docnum := index(df,
                                          {string10 docnum := df.doc_num, string2 state := df.st},
                                          {df},
                                          data_services.data_location.prefix() + 'thor_data400::key::Corrections_Offenders_docnum_' + doxie_build.buildstate + thorlib.wuid());