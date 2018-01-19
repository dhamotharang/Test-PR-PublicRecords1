import doxie,Data_Services;

df := file_party_base(bdid != 0);

export key_officialrecs_party_bdid := index(df,{bdid},{official_record_key},Data_Services.Data_location.Prefix()+'thor_data400::key::official_recs_party_bdid_' + doxie.Version_SuperKey);
