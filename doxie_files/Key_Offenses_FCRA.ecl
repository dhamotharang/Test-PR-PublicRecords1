Import Data_Services, doxie_build,doxie,crimsrch, ut,Life_EIR;

df := Life_EIR.File_FCRA_Criminal.offenses;

EXPORT Key_Offenses_FCRA := index (df, {ok := df.offender_key}, {df},
  Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_200::key::criminal_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key');
