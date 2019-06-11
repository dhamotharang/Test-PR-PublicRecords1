IMPORT autokey;
IMPORT $;

EXPORT key_wild_SSN_EN (integer data_category = 0) := 
         INDEX (autokey.layout_Wild_SSN_EN, $.names().i_wild_ssn_en, OPT); //TODO: OPT?
