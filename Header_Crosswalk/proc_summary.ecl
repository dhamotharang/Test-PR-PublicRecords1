IMPORT dx_Header_Crosswalk;
IMPORT Header_Crosswalk;

EXPORT proc_summary(STRING str_version) := FUNCTION

  // Stage 1) Declare dependencies
  ds_lexid_seleid := PULL(dx_Header_Crosswalk.key_lexid_2_seleid);
  ds_lexid_lnpid := PULL(dx_Header_Crosswalk.key_lexid_2_lnpid);
  ds_lnpid_seleid := PULL(dx_Header_Crosswalk.key_lnpid_2_seleid);

  ds_summary := Header_Crosswalk.fn_summary(
    str_version,
    ds_lexid_seleid,
    ds_lexid_lnpid,
    ds_lnpid_seleid
  );

  // Stage 2) Declare summary filename
  str_new_filename := Header_Crosswalk.Superfiles.fn_logical_filename(
    Header_Crosswalk.Constants.str_build_summary_sf,
    '::' + str_version
  );

  // Stage 3) Ouput and Add to superfile
  RETURN SEQUENTIAL(
    OUTPUT(ds_summary, , str_new_filename, COMPRESSED, NAMED('summary'));
    Header_Crosswalk.Superfiles.fn_add_superfile(
      Header_Crosswalk.Constants.str_build_summary_sf,
      str_new_filename
    );
  );

END;