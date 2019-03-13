IMPORT autokey;
IMPORT $;

EXPORT key_piz (integer data_category = 0) := INDEX (autokey.layout_piz, $.names().i_auto_piz, OPT);
