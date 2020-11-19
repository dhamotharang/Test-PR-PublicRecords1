IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT key_delta_rid := INDEX ({rec.record_sid}, rec, $.names().i_delta_rid,OPT);
