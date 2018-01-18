import doxie_build, data_services;

df := file_offenders_keybuilding;

export key_prep_offenders := index(df((integer)did != 0),
                                   {unsigned6 sdid := (integer)df.did},{df},
                                   data_services.data_location.prefix() + 'thor_data400::key::corrections_Offenders_' + doxie_build.buildstate + thorlib.wuid());