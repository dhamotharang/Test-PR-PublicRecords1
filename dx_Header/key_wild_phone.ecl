IMPORT autokey;
IMPORT $;

EXPORT key_wild_phone (integer data_category = 0) := 
         INDEX (autokey.layout_wild_phone, $.names().i_wild_phone);
