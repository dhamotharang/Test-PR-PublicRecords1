//*** Jira# RR-15660. Function created for CCPA suppressions at key fetches.
EXPORT mac_check_access (ds_in, ds_out, mod_access) := MACRO
  IMPORT suppress;
  
  ds_out := suppress.MAC_SuppressSource (ds_in, mod_access);

ENDMACRO;
