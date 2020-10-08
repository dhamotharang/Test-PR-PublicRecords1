EXPORT best_records_bdids(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

outrec := RECORD
  UNSIGNED1 level := 0;
  doxie_cbrs.Layout_BH_Best_String;
END;

temprecs := fn_best_records(PROJECT(bdids,
  TRANSFORM(doxie_cbrs.layout_supergroup,
    SELF.group_id := 0,
    SELF := LEFT)),FALSE);

RETURN PROJECT(temprecs,outrec);
END;
