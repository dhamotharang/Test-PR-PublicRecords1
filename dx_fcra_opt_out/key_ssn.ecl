// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_optout_delta_rid
// ---------------------------------------------------------------

IMPORT $;

rec := $.layouts.i_ssn;

EXPORT key_ssn := INDEX ({rec.l_ssn}, rec, $.names().i_ssn);