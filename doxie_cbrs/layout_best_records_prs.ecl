EXPORT layout_best_records_prs := RECORD
  doxie_cbrs.Layout_BH_Best_String;
  BOOLEAN isCurrent := FALSE;
  BOOLEAN hasBBB := FALSE;
  BOOLEAN hasBBB_NM := FALSE;
  UNSIGNED1 level := 0;
END;
