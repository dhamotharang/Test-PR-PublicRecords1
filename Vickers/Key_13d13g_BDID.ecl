import doxie;

df := file_13d13g_base(bdid != 0);

export Key_13d13g_BDID := index(df,{bdid},{df},'~thor_data400::key::vickers_13d13g_bdid_' + doxie.Version_SuperKey);
