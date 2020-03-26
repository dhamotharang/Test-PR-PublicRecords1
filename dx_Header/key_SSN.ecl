IMPORT autokey;
IMPORT $;

EXPORT key_SSN (integer data_category = 0) := INDEX (autokey.layout_SSN, $.names().i_auto_SSN);
