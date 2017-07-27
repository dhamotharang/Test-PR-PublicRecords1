import doxie;

df := uccd.Joined_For_Key_BDID;

export Key_BDID := index(df,{bdid},{df},'~thor_data400::key::ucc_bdid_' + doxie.Version_SuperKey);
