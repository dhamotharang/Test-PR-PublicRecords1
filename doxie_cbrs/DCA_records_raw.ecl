IMPORT dca;

EXPORT DCA_records_raw(DATASET(doxie_cbrs.layout_references) bdids = DATASET([], doxie_cbrs.layout_references))
  := FUNCTION

k := DCA.Key_DCA_BDID;

k tra(k r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(bdids, k, KEYED(LEFT.bdid = RIGHT.bdid), 
  tra(RIGHT),
  LIMIT(10000, SKIP));
END;
