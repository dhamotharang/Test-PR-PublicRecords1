EXPORT mac_check_access (ds_in, ds_out, mod_access) := MACRO
IMPORT Suppress;

   ds_out := Suppress.MAC_SuppressSource(ds_in, mod_access, contact_did);

ENDMACRO;