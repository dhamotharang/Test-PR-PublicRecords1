IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT Key_Base_Delta_Rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_base_delta_rid_super,OPT);