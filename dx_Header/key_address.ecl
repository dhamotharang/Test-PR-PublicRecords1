IMPORT autokey;
IMPORT $;

//TODO: cannot use this because of the way autokey.* indices are defined
//EXPORT key_address (integer data_category = 0) := autokey.key_address ($.names.i_auto_address);

EXPORT key_address (integer data_category = 0) := INDEX ({autokey.layout_address}, $.names().i_auto_address);

