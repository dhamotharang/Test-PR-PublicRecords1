IMPORT bbb;

EXPORT BBB_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

k := bbb.Key_BBB_BDID;

k tra(k r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(bdids, k, KEYED(LEFT.bdid = RIGHT.bdid), tra(RIGHT),
            LIMIT(10000, SKIP));

END;
