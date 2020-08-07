EXPORT Layout_BH_Best_String := RECORD
  UNSIGNED6 bdid; // i know, not a string.
  STRING8 dt_last_seen := '';
  QSTRING120 company_name := '';
  QSTRING10 prim_range := '';
  STRING2 predir := '';
  QSTRING28 prim_name := '';
  QSTRING4 addr_suffix := '';
  STRING2 postdir := '';
  QSTRING5 unit_desig := '';
  QSTRING8 sec_range := '';
  QSTRING25 city := '';
  STRING2 state := '';
  STRING5 zip := '';
  STRING4 zip4 := '';
  STRING10 phone := '';
  STRING10 fein := '';
  UNSIGNED1 best_flags := 0; // also ok not a string
END;
