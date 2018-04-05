  // sc := scaled_candidates(File_BizHead);
  // layout := {sc, UNSIGNED4 EFR_BMap;};
 // EXPORT CandidatesForKey := JOIN(sc,Config.efr,LEFT.ultid = RIGHT.ultid AND LEFT.orgid = RIGHT.orgid AND LEFT.seleid = RIGHT.seleid AND LEFT.proxid = RIGHT.proxid, TRANSFORM(layout,SELF.EFR_BMap:=RIGHT.ChildID_BMap, SELF:=LEFT),HASH,LEFT OUTER);  // Append external file bitmap

EXPORT CandidatesForKey := scaled_candidates(File_BizHead);