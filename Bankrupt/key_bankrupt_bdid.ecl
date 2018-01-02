import doxie, data_services;

df1 := bankrupt.file_bk_search((integer)bdid != 0);

dis_df1 := distribute(df1,hash(bdid,seq_number,court_code,case_number));

df2 := sort(dis_df1,bdid,seq_number,court_code,case_number,local);

df := dedup(df2,bdid,seq_number,court_code,case_number,local);

export key_bankrupt_bdid := index(df,{unsigned6 bd := (integer)bdid},{seq_number,court_code,case_number},data_services.data_location.prefix('bankruptcy') + 'thor_data400::key::bankrupt_bdid_' + doxie.Version_SuperKey);
