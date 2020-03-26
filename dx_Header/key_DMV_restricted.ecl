IMPORT doxie;
IMPORT $;

EXPORT key_DMV_restricted (integer data_category = 0) := 
         INDEX ({$.layouts.i_DMV_restricted.rid}, $.layouts.i_DMV_restricted, $.names().i_DMV_restricted);
