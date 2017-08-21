import ut;
file_raw := 
//DATASET(ut.foreign_prod + '~thor_data400::in::doc::ri', DOC.layout_doc_ri,
DATASET('~thor_data400::in::doc::ri', DOC.layout_doc_ri,
 CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"')) );
 
export file_doc_ri := file_raw(stringlib.stringtouppercase(LastName) not in ['LNAME','LASTNAME','LAST_NAME']);
