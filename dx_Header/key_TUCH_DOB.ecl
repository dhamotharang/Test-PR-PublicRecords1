IMPORT $;

EXPORT key_TUCH_DOB (integer data_category = 0) := 
         INDEX ({$.layouts.i_tuch_dob.rid}, $.layouts.i_tuch_dob, $.names().i_TUCH_DOB, OPT);
