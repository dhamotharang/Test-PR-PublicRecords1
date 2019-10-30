import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_refs(String pversion) := FUNCTION
Refs_layout:=RECORD
  unsigned4 word_id;
  unsigned2 field;
  unsigned6 uid;
  unsigned8 __internal_fpos__;
 END;

 refs_Build :=  DATASET([ ],refs_layout);
 refs_key := INDEX(refs_Build,
 {word_id,field,uid},{refs_Build},
 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::header::refs'); 
 
 BUILDindex(refs_Key);
 
 return 'Successful';
 end;
 