IMPORT $;


EXPORT key_minors (integer data_category = 0) := 
         INDEX ({$.layouts.i_minors.did}, {$.layouts.i_minors.dob}, $.names().i_minors);
