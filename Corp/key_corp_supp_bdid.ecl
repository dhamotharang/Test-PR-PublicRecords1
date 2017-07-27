import doxie;

df1 := corp.File_Corp_Supp_Base(bdid != 0);

df2 := dedup(sort(distribute(df1,hash(bdid)),bdid,corp_key,local),bdid,corp_key,local);

export key_corp_supp_bdid := index(df2,{bdid},{corp_key},'~thor_data400::key::corp_supp_bdid_' + doxie.Version_SuperKey);
