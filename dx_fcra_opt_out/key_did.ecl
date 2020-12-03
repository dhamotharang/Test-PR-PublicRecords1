// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_optout_delta_rid
// ---------------------------------------------------------------

IMPORT $;

rec := $.layouts.i_did;

EXPORT key_did := INDEX ({rec.l_did}, rec, $.names().i_did);