IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT Key_Search_Delta_Rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_search_delta_rid_super,OPT);
