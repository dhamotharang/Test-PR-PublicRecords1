IMPORT $;

EXPORT key_DTS_StreetZipName (integer data_category = 0) :=  
         INDEX ($.layouts.i_DTS_StreetZipName, $.names().i_DTS_StreetZipName);
