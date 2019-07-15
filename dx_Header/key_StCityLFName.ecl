IMPORT autokey;
IMPORT $;

EXPORT key_StCityLFName (integer data_category = 0) := INDEX (autokey.layout_CityStName, $.names().i_auto_StCityLFName);
