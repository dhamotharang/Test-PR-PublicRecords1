import crim_common;

my_doc := crim_common.File_Moxie_Crim_Offender2_Dev(state_origin='NC' or state='NC');

export cville_doc_extract :=  my_doc : persist('persist::cville_doc_extract');

