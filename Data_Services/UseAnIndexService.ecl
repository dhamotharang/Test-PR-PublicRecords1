EXPORT UseAnIndexService := MACRO
  IMPORT LiensV2,LN_PropertyV2,UCCV2;

  OUTPUT (CHOOSEN (LiensV2.key_liens_party_ID_linkids, 10), NAMED ('tmsid_rmsid_linkids'));
  OUTPUT (CHOOSEN (LN_PropertyV2.key_search_fid_linkids, 10), NAMED ('LN_PropertyV2_fid_linkids'));
  OUTPUT (CHOOSEN (UCCV2.Key_rmsid_party_linkids(), 10), NAMED ('UCCV2_rmsid_party_linkids'));

ENDMACRO;