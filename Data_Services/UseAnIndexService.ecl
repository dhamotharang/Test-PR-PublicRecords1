EXPORT UseAnIndexService := MACRO
  IMPORT LiensV2;

  OUTPUT (CHOOSEN (LiensV2.key_liens_party_ID_linkids, 10), NAMED ('tmsid_rmsid_linkids'));

ENDMACRO;