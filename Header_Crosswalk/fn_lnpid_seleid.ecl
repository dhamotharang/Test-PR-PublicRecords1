IMPORT dx_Header_Crosswalk;

EXPORT DATASET(dx_Header_Crosswalk.Layouts.lnpid_2_seleid) fn_lnpid_seleid(
  DATASET(dx_Header_Crosswalk.Layouts.lexid_2_seleid) ds_lexid_seleid,
  DATASET(dx_Header_Crosswalk.Layouts.lexid_2_lnpid) ds_lexid_lnpid
) := FUNCTION

  // (lexid,seleid) has a 1:Many relationship, while (lexid,lnpid) has a 1:1 relationship. Therefore, (lnpid,seleid) will have a 1:Many relationship
  RETURN JOIN(ds_lexid_seleid, ds_lexid_lnpid, LEFT.lexid = RIGHT.lexid, TRANSFORM(dx_Header_Crosswalk.Layouts.lnpid_2_seleid,
    SELF.lnpid := RIGHT.lnpid;
    SELF.seleid := LEFT.seleid;
  ), HASH);

END;