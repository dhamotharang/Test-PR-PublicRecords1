import doxie_build, data_services;

df := file_Activity_KeyBuilding;

export Key_Prep_Activity := index(df,
                                  {ok := df.offender_key},
                                  {df},
                                  data_services.data_location.prefix() + 'thor_Data400::key::corrections_activity_' + doxie_build.buildstate + thorlib.wuid());