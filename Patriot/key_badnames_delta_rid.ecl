IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT key_badnames_delta_rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.names().i_annotated_names_delta_rid,OPT);
