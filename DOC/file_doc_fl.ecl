import ut;

input := 
DATASET('~thor_data400::in::doc::fl', DOC.layout_doc_fl,
 CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(7000)));

export file_doc_fl := input;