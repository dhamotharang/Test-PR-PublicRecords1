import doxie;

df := property.File_Fares_Search_DID((integer)bdid != 0);

export Key_Search_BDID := index(df,{unsigned6 bd := (integer)bdid},{df},'~thor_data400::key::property_bdid_' + doxie.Version_SuperKey);
