EXPORT mac_build_and_promote(ds_input, key_name, str_version, should_promote = TRUE) := FUNCTIONMACRO
  IMPORT dx_Header_Crosswalk;
  IMPORT Header_Crosswalk;

  RETURN SEQUENTIAL(
    // Stage 1) Build key_name index using @ds_input as payload
    BUILDINDEX(#EXPAND('dx_Header_Crosswalk.key_' + #TEXT(key_name)),
      ds_input, 
      Header_Crosswalk.Superfiles.fn_logical_filename(
        dx_Header_Crosswalk.Names.str_prefix, 
        str_version,
        #EXPAND('dx_Header_Crosswalk.Names.str_suffix_' + #TEXT(key_name))
      )
    );

    // Stage 2) Promote built version @str_version if necessary
    IF(should_promote, Header_Crosswalk.Superfiles.proc_promote(
      dx_Header_Crosswalk.Names.str_prefix, 
      str_version,
      #EXPAND('dx_Header_Crosswalk.Names.str_suffix_' + #TEXT(key_name))
    ));
  );
ENDMACRO;