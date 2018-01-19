import doxie,Data_Services;

df := prof_license.file_keybase((integer)bdid != 0);

export key_proflic_bdid := index(df,{unsigned6 bd := (integer)df.bdid},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::proflic_bdid_' + doxie.Version_SuperKey);
