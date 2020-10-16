IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT key_individual_detail_delta_rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_individual_detail_delta_rid_super,OPT);
