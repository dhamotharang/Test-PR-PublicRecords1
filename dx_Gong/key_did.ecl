//former: Gong_Neustar.key_did
IMPORT $;

rec := $.layouts.i_did;

EXPORT key_did (integer data_category = 0) := INDEX ({rec.l_did}, rec, $.names().i_did);