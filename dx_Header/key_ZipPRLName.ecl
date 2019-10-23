IMPORT autokey;
IMPORT $;

EXPORT key_ZipPRLName (integer data_category = 0) := 
         INDEX (autokey.Layout_ZipPRLName, $.names().i_auto_ZipPRLName);
