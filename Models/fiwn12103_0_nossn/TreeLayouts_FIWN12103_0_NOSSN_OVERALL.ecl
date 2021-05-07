EXPORT TreeLayouts_FIWN12103_0_NOSSN_OVERALL := MODULE
  EXPORT LayoutBinary := RECORD
    UNSIGNED2 FieldNumber;
    UNSIGNED2 CompareMethod; // // 0 for terminal,
    REAL4 Number;
    UNSIGNED4 L;
    UNSIGNED4 R;
  END;
  EXPORT LayoutBinaryCont := RECORD(LayoutBinary)
    REAL4 Cont;
  END;
  EXPORT LayoutTernary := RECORD(LayoutBinary)
    UNSIGNED4 Missing;
  END;
  EXPORT LayoutTernaryCont := RECORD(LayoutTernary)
    REAL4 Cont;
  END;
END;
