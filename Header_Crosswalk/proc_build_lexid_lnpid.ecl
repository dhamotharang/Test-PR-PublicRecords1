IMPORT Header_Crosswalk;

EXPORT proc_build_lexid_lnpid(STRING str_version, BOOLEAN should_promote = TRUE) := FUNCTION

  // Stage 1) Get lexid_lnpid dependencies
  ds_lnpid_segmentation_raw := DATASET(Header_Crosswalk.Constants.str_lnpid_segmentation, RECORDOF(Header_Crosswalk.Constants.str_lnpid_segmentation, Header_Crosswalk.Layouts.lnpid_segmentation, LOOKUP), THOR);

  ds_lnpid_segmentation := PROJECT(ds_lnpid_segmentation_raw, Header_Crosswalk.Layouts.lnpid_segmentation);

  // Stage 2) Call fn_lexid_lnpid
  ds_lexid_lnpid := Header_Crosswalk.fn_lexid_lnpid(ds_lnpid_segmentation) : INDEPENDENT;

  // Stage 3) Build and promote indexes
  RETURN PARALLEL(
    Header_Crosswalk.mac_build_and_promote(
      ds_lexid_lnpid,
      lexid_2_lnpid,
      str_version,
      should_promote
    );
    Header_Crosswalk.mac_build_and_promote(
      ds_lexid_lnpid,
      lnpid_2_lexid,
      str_version,
      should_promote
    );
  );

END;