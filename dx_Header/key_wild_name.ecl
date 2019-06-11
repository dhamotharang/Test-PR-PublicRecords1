IMPORT autokey;
IMPORT $;

EXPORT key_wild_name (integer data_category = 0) := 
         INDEX (autokey.layout_wild_name, $.names().i_wild_name);
