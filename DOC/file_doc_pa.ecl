import ut;
file_raw := 
//DATASET(ut.foreign_prod + '~thor_data400::in::doc::pa', DOC.layout_doc_pa,
DATASET('~thor_data400::in::doc::pa', DOC.layout_doc_pa,
 CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"')) );
 
export file_doc_pa := file_raw(stringlib.stringtouppercase(Name) not in ['LNAME','LASTNAME','LAST_NAME']);
