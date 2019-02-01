IMPORT $;

EXPORT key_DOBName (integer data_category = 0) := 
         INDEX ($.layouts.i_DOBName, $.names().i_DOBName, OPT);
