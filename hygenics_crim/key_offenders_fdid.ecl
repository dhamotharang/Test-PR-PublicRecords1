Import Data_Services, doxie_build,doxie,Data_Services;

df := File_Offenders;

export key_offenders_fdid := index(df,{sdid := (unsigned6)df.did},{offender_key},Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections_fdid_'+ doxie_build.buildstate+'_'+doxie.Version_SuperKey);