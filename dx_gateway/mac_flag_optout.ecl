// -------------------------------------------------------------------------
// This macro is called by the parser and it is part of the interface between 
// thor and roxie.
// -------------------------------------------------------------------------
EXPORT mac_flag_optout(ds_in, ds_out, mod_access) := MACRO
  IMPORT Suppress;
  // Note: Call to suppress expected to use different options (e.g. use_distributed) in ThorProd.
  ds_out := Suppress.MAC_FlagSuppressedSource(ds_in, mod_access, did);
ENDMACRO;
