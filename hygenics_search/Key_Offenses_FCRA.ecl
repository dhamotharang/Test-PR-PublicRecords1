IMPORT doxie,data_services;

df := hygenics_search.File_Moxie_Offenses_Dev;

EXPORT Key_Offenses_FCRA := index (df, {ok := df.offender_key}, {df},
  data_services.data_location.prefix() + 'thor_200::key::criminal_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key');
