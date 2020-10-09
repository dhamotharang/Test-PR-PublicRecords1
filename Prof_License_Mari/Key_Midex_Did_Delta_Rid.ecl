IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT Key_Midex_Did_Delta_Rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_midex_did_delta_rid_super,OPT);
