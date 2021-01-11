IMPORT doxie, LiensV2_Services;

EXPORT layout_ids := RECORD
  LiensV2_Services.layout_TMSID; //acctno, TMSID
  doxie.layout_references; //did
END;
