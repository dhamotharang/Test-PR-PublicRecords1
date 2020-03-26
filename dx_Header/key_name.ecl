IMPORT autokey;
IMPORT $;

EXPORT key_name (integer data_category = 0) := 
         INDEX (autokey.layout_name, $.names().i_auto_name);

