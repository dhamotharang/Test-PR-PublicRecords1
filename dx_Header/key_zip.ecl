IMPORT autokey;
IMPORT $;

EXPORT key_zip (integer data_category = 0) := INDEX (autokey.layout_zip, $.names().i_auto_zip);
