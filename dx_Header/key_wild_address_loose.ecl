IMPORT autokey;
IMPORT $;

EXPORT key_wild_address_loose (integer data_category = 0) := 
         INDEX (autokey.layout_wild_address_loose, $.names().i_wild_address_loose);
