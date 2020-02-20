//former: Gong_Neustar.key_hhid
IMPORT $;

rec := $.layouts.i_hhid;

EXPORT key_hhid (integer data_category = 0) := INDEX ({rec.s_hhid}, rec, $.names().i_hhid);
