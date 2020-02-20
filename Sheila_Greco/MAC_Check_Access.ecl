//*** Jira# CCPA-821. Function created for CCPA suppressions at key fetches.
EXPORT MAC_Check_Access (ds_in, ds_out, mod_access) := MACRO
  // Suppression for this dataset not in-scope for phase 1.
  ds_out := ds_in;
ENDMACRO;