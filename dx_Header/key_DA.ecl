IMPORT $;

EXPORT key_DA (integer data_category = 0) := 
         INDEX ({$.layouts.i_DA}, $.names().i_DA, OPT);
