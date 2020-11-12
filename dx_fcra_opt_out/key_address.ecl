// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_optout_delta_rid
// ---------------------------------------------------------------

IMPORT $;

rec := $.layouts.i_address;

EXPORT key_address := INDEX ({rec.z5,rec.prim_range,rec.prim_name,rec.sec_range}, rec, $.names().i_address);