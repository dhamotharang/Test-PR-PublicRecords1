IMPORT $;

rec := $.layouts.i_did_rid;

EXPORT key_did_rid2 (integer data_category = 0) := 
         INDEX ({rec.rid}, {rec.did}, $.names().i_did_rid2);