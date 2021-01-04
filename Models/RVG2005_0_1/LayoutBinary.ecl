EXPORT LayoutBinary := RECORD
  UNSIGNED2 FieldNumber;
  UNSIGNED2 CompareMethod; // 0 for terminal,
  REAL Number;
  UNSIGNED4 L;
  UNSIGNED4 R;
END;
