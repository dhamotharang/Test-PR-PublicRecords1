temp_rec := record 
string20 name ; 
string10 _count ; 
string1 colon ; 
string16 fpos ; 
string1 lf ; 
end ; 
export file_Phonetic_equivs_fname := dataset('~thor_data400::in::names::fname.data',temp_rec , flat); 
