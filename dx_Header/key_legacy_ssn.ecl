IMPORT $;


EXPORT key_legacy_ssn (integer data_category = 0) := 
         INDEX ($.layouts.i_legacy_ssn, $.names().i_legacy_ssn, OPT);
