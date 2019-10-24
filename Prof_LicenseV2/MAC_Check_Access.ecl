//*** Jira# CCPA-816. Function created for CCPA suppressions at key fetches.
EXPORT MAC_Check_Access (ds_in, ds_out, mod_access) := MACRO
IMPORT Suppress;
  // query team will fill in the actual content, if needed for “this” data-type.
  ds_out := Suppress.MAC_SuppressSource(ds_in, mod_access);
ENDMACRO;