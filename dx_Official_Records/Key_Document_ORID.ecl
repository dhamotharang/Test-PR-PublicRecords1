IMPORT $;
inFile := dx_official_records.Layouts.document;

EXPORT Key_Document_ORID	:= index({inFile.official_record_key},inFile - official_record_key,$.names().i_document);




