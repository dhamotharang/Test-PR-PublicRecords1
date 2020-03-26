IMPORT autokey;
IMPORT $;

EXPORT key_wild_StCityLFName (integer data_category = 0) := 
         INDEX (autokey.layout_wild_CityStName, $.names().i_wild_StCityLFName);
