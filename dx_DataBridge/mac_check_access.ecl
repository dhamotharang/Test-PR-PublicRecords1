//*** Jira# RR-15660. Function created for CCPA suppressions at key fetches.
EXPORT mac_check_access (ds_in, ds_out, mod_access) := MACRO
  // query team will fill in the actual content, if needed for “this” data-type.
  ds_out := ds_in;
ENDMACRO;