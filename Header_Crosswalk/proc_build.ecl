IMPORT Header_Crosswalk;

EXPORT proc_build(STRING str_version, BOOLEAN should_promote = TRUE) := FUNCTION
  
  proc_lexid := PARALLEL(
    Header_Crosswalk.proc_build_lexid_seleid(str_version, should_promote);
    Header_Crosswalk.proc_build_lexid_lnpid(str_version, should_promote);
  );

  RETURN SEQUENTIAL(
    // Stage 1) Build lexid-based keys in parallel
    proc_lexid;
    // Stage 2) (lnpid,seleid) depends on updated proc_lexid
    Header_Crosswalk.proc_build_lnpid_seleid(str_version, should_promote);
  );
END;