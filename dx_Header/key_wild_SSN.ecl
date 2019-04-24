IMPORT autokey;
IMPORT $;

EXPORT key_wild_ssn (integer data_category = 0) := 
         INDEX (autokey.Layout_Wild_SSN, $.names().i_wild_ssn, OPT); //TODO: OPT?
  
