// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_optout_delta_rid
// ---------------------------------------------------------------

IMPORT $, _Control;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

rec := $.layouts.i_address;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT key_address := vault.fcra_opt_out.key_address;
#ELSE
EXPORT key_address := INDEX ({rec.z5,rec.prim_range,rec.prim_name,rec.sec_range}, rec, $.names().i_address);
#END;
