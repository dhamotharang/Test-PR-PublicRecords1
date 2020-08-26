IMPORT bbb2;

EXPORT BBBMember_member_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

indexedBDIDs := bbb2.Key_BBB_BDID;

// RQ-15799 REMOVING CCPA RELATED FIELDS FROM QUERY OUTPUT
// DEFINING LAYOUT USING ACTUAL LAYOUT INSTEAD OF THE DATASET
indexedBDIDs_layout:= RECORD
  BBB2.Layouts_Files.Base.Member -[global_sid, record_sid];
END;


indexedBDIDs_layout xf_indexedBDIDs(indexedBDIDs r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(bdids, indexedBDIDs, KEYED(LEFT.bdid = RIGHT.bdid),
                   xf_indexedBDIDs(RIGHT), LIMIT(10000, SKIP));
END;
