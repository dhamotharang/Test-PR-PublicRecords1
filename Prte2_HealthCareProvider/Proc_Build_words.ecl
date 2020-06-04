import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_words(String pversion) := FUNCTION
words_layout:=RECORD
  string30 word;
  unsigned8 cnt;
  unsigned8 t_cnt;
  unsigned4 id;
  real8 field_specificity;
  unsigned8 __internal_fpos__;
 END;

words_Build :=  DATASET([ ],words_layout);
 words_key := INDEX(words_Build,
 {word},{words_Build},
 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::header::words'); 
 BUILDindex(words_Key);
 
 return 'Successful';
 end;
 