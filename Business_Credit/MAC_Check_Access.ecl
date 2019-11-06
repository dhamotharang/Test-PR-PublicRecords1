 //*** Jira# DF-26179. Function created for CCPA suppressions at key fetches.
EXPORT MAC_Check_Access (ds_in, ds_out, mod_access) := MACRO
 IMPORT suppress;
   ds_out := Suppress.MAC_SuppressSource(ds_in, mod_access, did);
ENDMACRO;
