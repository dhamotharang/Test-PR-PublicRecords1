//former: Gong_Neustar.key_history_bdid
IMPORT $;

rec := $.layouts.i_history_bdid;

EXPORT key_history_bdid (integer data_category = 0) := 
         INDEX ({rec.bdid}, rec, $.names().i_history_bdid);