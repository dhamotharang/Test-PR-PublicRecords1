IMPORT $;


EXPORT key_minors_hash (integer data_category = 0) := 
         INDEX ({$.layouts.i_minors.hash32_did, $.layouts.i_minors.did}, {$.layouts.i_minors.dob}, $.names().i_minors_hash);
