//export cville_doc_append := 'todo';

import crim_common;

my_doc := distribute(misc.cville_doc_extract,hash(offender_key));


append_arrest_offenses := crim_common.File_In_Arrest_Offenses;
append_court_offenses := crim_common.File_In_Court_Offenses;
append_doc_offenses := crim_common.File_In_DOC_Offenses;

append_doc_punishment := crim_common.File_In_DOC_Punishment;



output(append_arrest_offenses);
output(append_court_offenses);
output(append_doc_offenses);

output(append_doc_punishment);
