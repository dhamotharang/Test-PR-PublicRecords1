IMPORT $;
inFile := dx_official_records.Layouts.party;

EXPORT Key_Party_ORID	:= index({inFile.official_record_key},inFile - official_record_key,$.names().i_party);


