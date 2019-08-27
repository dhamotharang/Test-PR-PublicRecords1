//*** Jira# RR-15660. Function created for CCPA suppressions at key fetches.
EXPORT mac_check_access (ds_in, ds_out, mod_access) := MACRO
  import  suppress;
  ds_out := Suppress.MAC_SuppressSource(ds_in,mod_access,append_did);
ENDMACRO;
