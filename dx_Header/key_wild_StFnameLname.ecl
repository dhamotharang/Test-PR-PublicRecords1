IMPORT autokey;
IMPORT $;

EXPORT key_wild_StFnameLname (integer data_category = 0) := 
         INDEX (autokey.layout_wild_StName, $.names().i_wild_StFnameLname);
