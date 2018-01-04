import doxie_build, data_services;

df := file_SO_offenses_keybuilding;

export key_prep_sexoffender_offenses := index(df,
                                              {string16 sspk := df.seisint_primary_key},
                                              {df},
                                              data_services.data_location.prefix() + 'thor_data400::key::sexoffender_offenses_' + doxie_build.buildstate + thorlib.wuid());