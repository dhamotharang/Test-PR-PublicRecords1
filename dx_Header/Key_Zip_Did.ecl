IMPORT $;

EXPORT key_zip_did (integer data_category = 0) := 
         INDEX ($.layouts.i_zip_did, $.names().i_zip_did);
