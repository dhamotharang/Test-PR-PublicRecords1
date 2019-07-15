IMPORT autokey;
IMPORT $;

EXPORT key_phone (integer data_category = 0) := INDEX (autokey.layout_phone, $.names().i_auto_phone);
