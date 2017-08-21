import ut;
file_raw := 
DATASET(ut.foreign_prod + '~thor_data400::in::doc::co', DOC.layout_doc_co,
 CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"')) );
 
export file_doc_co := file_raw(stringlib.stringtouppercase(LastName) not in ['LNAME','LASTNAME','LAST_NAME']);
