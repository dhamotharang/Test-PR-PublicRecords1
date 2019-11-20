// Jira# CCPA-22. Function created for CCPA suppressions at key fetches.
EXPORT mac_check_access(ds_in, ds_out, mod_access) := MACRO
  IMPORT Suppress;
  ds_in_optout := Suppress.MAC_SuppressSource(ds_in, mod_access);
  ds_out := ds_in_optout;
ENDMACRO;