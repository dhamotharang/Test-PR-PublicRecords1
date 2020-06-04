export mac_flag_optout(ds_in, ds_out, mod_access) := MACRO
  import Suppress;
  ds_out := Suppress.MAC_FlagSuppressedSource(ds_in, mod_access, did);
ENDMACRO;
