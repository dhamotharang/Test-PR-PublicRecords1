IMPORT autokey;
IMPORT $;

EXPORT key_wild_zip (integer data_category = 0) := 
         INDEX (autokey.layout_wild_zip, $.names().i_wild_zip);
