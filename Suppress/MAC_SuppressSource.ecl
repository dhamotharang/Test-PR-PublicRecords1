EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid') := FUNCTIONMACRO
  RETURN IF (mod_access.lexid_source_optout,
             ds_in (gsid_field % 2 = 1),
             ds_in);
ENDMACRO;
