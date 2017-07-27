layout_in := record 
string3 ngram; 
string20  name; 
string10 _count; 
string1  colon; 
string16 fpos; 
string1  lf; 
end; 
export file_lname_ngram := dataset('~thor_data400::in::names::lnames.ngram.name.count.key.data',layout_in,flat); 