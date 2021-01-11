EXPORT LayoutCategoric := RECORD(LayoutTernary)
  EMBEDDED DATASET({ UNSIGNED4 Leg }) Legs;
END;
