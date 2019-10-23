IMPORT autokey;
IMPORT $;

EXPORT key_wild_address (integer data_category = 0) := 
         INDEX ({autokey.layout_wild_address}, $.names().i_wild_address);
