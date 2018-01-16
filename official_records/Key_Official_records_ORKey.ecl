import doxie,Data_Services;

df := official_records.file_party_Base(official_record_key != '');

export Key_Official_records_ORKey := index(df,{ork := official_record_key},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::official_recs_ork_' + doxie.Version_SuperKey);
