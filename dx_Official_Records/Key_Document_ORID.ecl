IMPORT $;

inFile := $.Layouts.document;

EXPORT Key_Document_ORID := INDEX({inFile.official_record_key}, inFile - official_record_key, $.names().i_document);
