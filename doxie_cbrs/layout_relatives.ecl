EXPORT layout_relatives := RECORD
  UNSIGNED6 inBDID;
  doxie_cbrs.Layout_BH_Best_String;
  UNSIGNED6 match_bdid;
  doxie_cbrs.layout_relative_booleans;
  UNSIGNED1 relationships := 0;
END;
