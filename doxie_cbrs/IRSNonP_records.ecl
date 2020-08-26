IMPORT govdata;

EXPORT IRSNonP_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

k := govdata.Key_IRS_NonProfit_BDID;

k tra(k r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(bdids, k, KEYED(LEFT.bdid = RIGHT.bdid), tra(RIGHT),
          LIMIT(10000, SKIP));
END;
