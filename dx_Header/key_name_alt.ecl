IMPORT autokey;
IMPORT $;

EXPORT key_name_alt (integer data_category = 0) := 
         INDEX (autokey.layout_Name2, $.names().i_auto_name_alt);

