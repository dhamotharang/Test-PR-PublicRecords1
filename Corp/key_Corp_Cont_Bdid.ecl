import doxie;

df1 := corp.File_Corp_Cont_Base(bdid != 0);

df2 := dedup(sort(distribute(df1,hash(bdid)),bdid,corp_key,local),bdid,corp_key,local);

export key_Corp_Cont_Bdid := index(df2,{bdid},{corp_key},'~thor_data400::key::corp_cont_bdid_' + doxie.Version_SuperKey);

