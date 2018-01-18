import data_services;

df := File_Punishment_Keybuilding;

export key_prep_punishment := index(df,
                                    {ok := df.offender_key, pt := df.punishment_type},
                                    {df},
                                    data_services.data_location.prefix() + 'thor_data400::key::corrections_punishment_' + doxie_build.buildstate + thorlib.wuid());