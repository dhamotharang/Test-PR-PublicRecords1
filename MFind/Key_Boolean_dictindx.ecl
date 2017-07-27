import liensv2;


tmsid_rec 
:= RECORD
  string20 word;
  unsigned integer4 nominal;
  unsigned integer3 suffix;
  unsigned integer8 freq;
  unsigned integer8 docfreq;
  unsigned integer8 fpos;
 END;



tmsid_table := dataset([],tmsid_rec);

export key_boolean_dictindx := index(tmsid_table,{word,nominal,suffix,freq,docfreq,fpos},'~thor_data400::key::mfind::qa::dictindx');





