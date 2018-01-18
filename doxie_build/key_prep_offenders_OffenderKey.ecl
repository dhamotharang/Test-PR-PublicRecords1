import doxie_build, data_services;

df := file_offenders_keybuilding;

export key_prep_offenders_OffenderKey := index(df,
                                               {string60 ofk := df.offender_key},
                                               {df},
                                               data_services.data_location.prefix() + 'thor_data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate + thorlib.wuid());