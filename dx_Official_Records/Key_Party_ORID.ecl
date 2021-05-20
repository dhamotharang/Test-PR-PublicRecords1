IMPORT $;

inFile := $.Layouts.party;

EXPORT Key_Party_ORID := INDEX({inFile.official_record_key}, inFile - official_record_key, $.names().i_party);
