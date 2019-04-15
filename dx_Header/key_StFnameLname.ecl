IMPORT autokey;
IMPORT $;

EXPORT key_StFnameLname (integer data_category = 0) := 
         INDEX (autokey.layout_StName, $.names().i_auto_StFnameLname);
