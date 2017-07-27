IMPORT doxie_build,doxie,crimsrch, ut;

df := hygenics_search.File_Moxie_Offenses_Dev;

EXPORT Key_Offenses_FCRA := index (df, {ok := df.offender_key}, {df},
  '~thor_200::key::criminal_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key');
