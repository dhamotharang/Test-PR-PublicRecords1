IMPORT autokey;
IMPORT $;

EXPORT key_wild_address_EN (integer data_category = 0) := 
         INDEX ({autokey.layout_wild_address_en}, $.names().i_wild_address_en);
				 