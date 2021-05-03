  EXPORT CandidatesForKey(field_list, incremental = FALSE) := FUNCTIONMACRO
    IMPORT InsuranceHeader_xLink;
    dsCurrent := InsuranceHeader_xLink.Process_xIDL_Layouts(incremental).PayloadCand;
    dsNew     := InsuranceHeader_xLink.Process_xIDL_Layouts(incremental).IncCand(DT_EFFECTIVE_LAST = 0);
    IncLinkpathRecs := DISTRIBUTE(SALT311.MAC_PoisonRecords(dsCurrent,dsNew,field_list,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST,'YYYYMMDD'), HASH(DID));
    sc := IF(incremental, IncLinkpathRecs, InsuranceHeader_xLink.Process_xIDL_Layouts(incremental).FullCand);
    RETURN sc;
  ENDMACRO;
