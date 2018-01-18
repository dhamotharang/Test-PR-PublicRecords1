IMPORT doxie, crimsrch, data_services;

df := crimsrch.File_Moxie_Punishment_Dev;

EXPORT Key_Punishment_FCRA := index (df, 
                                     {ok := df.offender_key, pt := df.punishment_type}, 
                                     {df},
                                     data_services.data_location.prefix() + 'thor_200::key::criminal_punishment::fcra::'+ doxie.Version_SuperKey + '::offender_key.punishment_type');