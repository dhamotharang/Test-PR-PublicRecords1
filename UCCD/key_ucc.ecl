import doxie;

df := uccd.Joined_For_Key_UCCKey;

export key_ucc := index(df,{ucc_key},{df},'~thor_data400::key::ucc_key_' + doxie.Version_SuperKey);