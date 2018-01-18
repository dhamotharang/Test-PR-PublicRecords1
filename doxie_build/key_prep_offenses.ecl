import doxie_build, data_services;

df := file_offenses_keybuilding;

export key_prep_offenses := index(df,
                                  {ok := df.offender_key},
                                  {df},
                                  data_services.data_location.prefix() + 'thor_Data400::key::corrections_offenses_' + doxie_build.buildstate + thorlib.wuid());