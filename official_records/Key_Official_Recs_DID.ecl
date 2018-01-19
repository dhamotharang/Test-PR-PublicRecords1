import doxie,Data_Services;

df := official_records.file_party_base(did != 0);

export Key_Official_Recs_DID := index(df,{did},{official_record_key},Data_Services.Data_location.Prefix()+'thor_data400::key::official_recs_did_' + doxie.Version_SuperKey);
