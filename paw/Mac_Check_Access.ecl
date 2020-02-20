//*** Jira# RR-15825. Function created for CCPA suppressions at key fetches.
EXPORT Mac_Check_Access (ds_in, ds_out, mod_access) := MACRO
 import suppress;  
  ds_out := suppress.MAC_SuppressSource(ds_in, mod_access);
ENDMACRO;