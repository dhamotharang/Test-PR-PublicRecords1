// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.key_optout_delta_rid
// ---------------------------------------------------------------

IMPORT $, _Control;
#IF(_Control.Environment.onVault) IMPORT vault; #END;

rec := $.layouts.i_ssn;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT key_ssn := vault.fcra_opt_out.key_ssn;
#ELSE
EXPORT key_ssn := INDEX ({rec.l_ssn}, rec, $.names().i_ssn);
#END;
