IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT key_disciplinary_actions_delta_rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.names().i_regulatory_actions_delta_rid_super, OPT);
