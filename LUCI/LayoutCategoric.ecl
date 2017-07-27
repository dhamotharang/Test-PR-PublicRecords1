EXPORT LayoutCategoric := RECORD(LUCI.LayoutTernary)
    EMBEDDED DATASET( { UNSIGNED4 Leg } ) Legs;
  END;