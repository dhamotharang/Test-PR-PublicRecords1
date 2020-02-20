EXPORT MAC_check_access(ds_in, ds_out, mod_access) := MACRO
  IMPORT Suppress;
  //Roxie side will fill this macro out as needed. THOR can set __ds_out__ to __ds_in__.
  ds_out := Suppress.MAC_SuppressSource(ds_in, mod_access, person_q.appended_ADL, ccpa.global_sid);
ENDMACRO;