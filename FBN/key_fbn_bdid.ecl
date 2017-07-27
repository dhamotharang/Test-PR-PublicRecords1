import doxie;

df := fbn.File_FBN(bdid != 0);

export key_fbn_bdid := index(df,{bdid},{df},'~thor_Data400::key::fbn_bdid_' + doxie.Version_SuperKey, OPT);
