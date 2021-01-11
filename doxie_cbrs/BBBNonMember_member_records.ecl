
IMPORT bbb2;

EXPORT BBBNonMember_member_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  indexedBDIDs := bbb2.Key_BBB_Non_Member_BDID;

  doxie_cbrs.layouts.bbb_nonmember_record xf_indexedBDIDs(indexedBDIDs r) := TRANSFORM
    SELF := r;
  END;

  RETURN JOIN(bdids, indexedBDIDs, KEYED(LEFT.bdid = RIGHT.bdid),
    xf_indexedBDIDs(RIGHT), LIMIT(10000, SKIP));
END;
