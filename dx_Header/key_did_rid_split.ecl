IMPORT $;

//rec := $.layouts.i_did_rid;

EXPORT key_did_rid_split (integer data_category = 0) := 
         INDEX ({$.layouts.i_did_rid2.rid}, {$.layouts.i_did_rid2.did}, $.names().i_did_rid_split);
