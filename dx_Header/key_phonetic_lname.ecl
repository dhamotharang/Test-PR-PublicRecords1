IMPORT $;

keyed_fields := RECORD
   $.layouts.i_phonetic_lname.dph_lname;
END;

EXPORT key_phonetic_lname (integer data_category = 0) := 
         INDEX (keyed_fields, $.layouts.i_phonetic_lname, $.names().i_phonetic_lname);
