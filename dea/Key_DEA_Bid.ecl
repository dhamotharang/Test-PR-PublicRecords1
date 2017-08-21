import doxie;

df := dea.File_DEA_bid((integer)bdid != 0);

export Key_DEA_Bid := index(df,{unsigned6 bd := (integer)bdid},{df},'~thor_data400::key::dea::' + doxie.Version_SuperKey + '::bid');
