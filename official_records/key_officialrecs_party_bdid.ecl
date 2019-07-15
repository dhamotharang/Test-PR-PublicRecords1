import doxie;

df := file_party_base(bdid != 0);

export key_officialrecs_party_bdid := index(df,{bdid},{official_record_key},'~thor_Data400::key::official_recs_party_bdid_' + doxie.Version_SuperKey);
