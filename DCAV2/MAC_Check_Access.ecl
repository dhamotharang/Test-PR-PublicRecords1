//*** Jira# CCPA-822. Function created for CCPA suppressions at key fetches.
EXPORT MAC_Check_Access (ds_in, ds_out, mod_access) := MACRO
  // DCA suppression in-scope for phase 2 only.
  ds_out := ds_in;
ENDMACRO;