import  doxie;

df := file_proflicense_keybuilt((integer)bdid != 0);

export key_proflic_bdid := index(df,{unsigned6 bd := (integer)df.bdid},{df},'~thor_data400::key::proflic_bdid_' + doxie.Version_SuperKey);
