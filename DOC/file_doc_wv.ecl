import ut;
file_raw := 
DATASET(ut.foreign_prod + '~thor_data400::in::doc::wv', DOC.layout_doc_wv,
 CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"')) );
 
export file_doc_wv := file_raw(stringlib.stringtouppercase(LastName) not in ['LNAME','LASTNAME','LAST_NAME', '']);
