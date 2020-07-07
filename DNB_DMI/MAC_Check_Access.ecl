//*** Jira# CCPA-823. Function created for CCPA suppressions at key fetches.
EXPORT MAC_Check_Access (ds_in, ds_out, mod_access) := MACRO

  ds_out := ds_in(mod_access.use_DnB());

ENDMACRO;
