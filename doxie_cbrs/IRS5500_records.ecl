IMPORT irs5500;

EXPORT IRS5500_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  outrec := irs5500.layout_irs5500_base;
  k := irs5500.key_irs5500_BDID;

  outrec tra(k r) := TRANSFORM
    SELF := r;
  END;

  j := JOIN(bdids, k, KEYED(LEFT.bdid = RIGHT.bdid), tra(RIGHT),
            LIMIT(10000, SKIP));

  RETURN SORT(j,-form_plan_year_begin_date,RECORD);
END;
