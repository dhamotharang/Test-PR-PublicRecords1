import models;

//{ string5 zip, string50 msa, unsigned8 __internal_fpos__ };

layout_key_out := RECORD
string5 zip;
string50 msa;
//unsigned8 __internal_fpos__
END;

key_in := models.Key_MSA_Zip_Lookup(true);

 //transform statement
layout_key_out makerecord (key_in L) := transform
self.zip := L.zip;
self.msa := L.msa;
//unsigned8__internal_fpos__  
END;


EXPORT file_Key_MSA_Zip_Lookup := project(key_in,makerecord(left));