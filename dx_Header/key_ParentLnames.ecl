IMPORT $;


EXPORT key_ParentLnames (integer data_category = 0) := 
         INDEX ({$.layouts.i_ParentLnames.did}, $.layouts.i_ParentLnames, $.names().i_ParentLnames);
