IMPORT $;

rec := $.layouts.i_did_rid;

EXPORT key_did_rid (integer data_category = 0) := 
         INDEX ({rec.rid}, {rec.did, rec.stable}, $.names().i_did_rid);
