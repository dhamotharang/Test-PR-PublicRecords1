import doxie,dea,ut;

df := dea.File_DEA_bid((integer)did != 0);

export key_DEA_did_bid := index(df,{unsigned6 my_did :=(integer)did},{df},'~thor_data400::key::dea::' + doxie.Version_SuperKey + '::bid::did');
