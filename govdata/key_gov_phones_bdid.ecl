import doxie;

df := govdata.File_Gov_Phones_Base(bdid != 0);

export key_gov_phones_bdid := index(df,{bdid},{df},'~thor_data400::key::gov_phones_bdid_' + doxie.Version_SuperKey);
