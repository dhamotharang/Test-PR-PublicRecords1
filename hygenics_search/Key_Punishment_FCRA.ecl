IMPORT doxie_build,doxie,crimsrch, Data_Services;

df := hygenics_search.File_Moxie_Punishment_Dev;

EXPORT Key_Punishment_FCRA := index (df, {ok := df.offender_key, pt := df.punishment_type}, {df},
  Data_Services.Data_Location.Prefix('Provider')+'thor_200::key::criminal_punishment::fcra::'+ doxie.Version_SuperKey + '::offender_key.punishment_type');
