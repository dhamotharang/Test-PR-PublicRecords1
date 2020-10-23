//DF-28226 Add new delta rid key to PatriotKeys dataset
IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT key_patriot_delta_rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_patriot_file_delta_rid,OPT);