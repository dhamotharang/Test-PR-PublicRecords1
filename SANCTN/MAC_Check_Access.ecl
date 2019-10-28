//*** Jira# CCPA-818. Function created for CCPA suppressions at key fetches.
EXPORT MAC_Check_Access (ds_in, ds_out, mod_access) := MACRO
  // CCPA Source Suppression not needed here.
  ds_out := ds_in;
ENDMACRO;