IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT Key_Individual_Detail_Delta_Rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_individual_detail_delta_rid_super,OPT);
