IMPORT dx_Header_Crosswalk;
IMPORT Header_Crosswalk;

EXPORT proc_build_lnpid_seleid(STRING str_version, BOOLEAN should_promote = TRUE) := FUNCTION

  // Stage 1) Get lnpid_seleid dependencies
  ds_lexid_seleid := PULL(dx_Header_Crosswalk.key_lexid_2_seleid);
  ds_lexid_lnpid := PULL(dx_Header_Crosswalk.key_lexid_2_lnpid);

  // Stage 2) Call fn_lnpid_seleid
  ds_lnpid_seleid := Header_Crosswalk.fn_lnpid_seleid(ds_lexid_seleid, ds_lexid_lnpid) : INDEPENDENT;

  // Stage 3) Build and promote indexes
  RETURN PARALLEL(
    Header_Crosswalk.mac_build_and_promote(
      ds_lnpid_seleid,
      lnpid_2_seleid,
      str_version,
      should_promote
    );
    Header_Crosswalk.mac_build_and_promote(
      ds_lnpid_seleid,
      seleid_2_lnpid,
      str_version,
      should_promote
    );
  );

END;