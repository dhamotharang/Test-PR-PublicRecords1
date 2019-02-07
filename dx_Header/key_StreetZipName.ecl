IMPORT $;

EXPORT key_StreetZipName (integer data_category = 0) := 
         INDEX ({$.layouts.i_StreetZipName}, $.names().i_StreetZipName);
