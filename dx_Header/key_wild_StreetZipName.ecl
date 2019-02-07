IMPORT $;

EXPORT key_wild_StreetZipName (integer data_category = 0) := 
         INDEX ($.layouts.i_wild_StreetZipName, $.names().i_wild_StreetZipName);
