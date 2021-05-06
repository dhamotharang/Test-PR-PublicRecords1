
/*
  - Default release process for @str_version
*/
EXPORT proc_release(str_version) := FUNCTIONMACRO
  IMPORT Header_Crosswalk;

  RETURN SEQUENTIAL(
    // Update orbit to build @str_version
    Header_Crosswalk.mod_update.proc_update_orbit(str_version);
    // Update PR dops
    #EXPAND(Header_Crosswalk.mod_update.fn_update_dops(str_version));
  );

ENDMACRO;