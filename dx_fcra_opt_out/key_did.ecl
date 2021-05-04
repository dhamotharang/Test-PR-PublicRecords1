// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_optout_delta_rid
// ---------------------------------------------------------------

IMPORT $, _Control;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

rec := $.layouts.i_did;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT key_did := vault.fcra_opt_out.key_did;
#ELSE
EXPORT key_did := INDEX ({rec.l_did}, rec, $.names().i_did);
#END;
