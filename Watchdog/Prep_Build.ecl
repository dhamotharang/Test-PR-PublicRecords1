EXPORT Prep_Build := MODULE

  EXPORT prep(ds) := FUNCTIONMACRO
    import watchdog;
    return watchdog.regulatory.applyBest(ds);
  ENDMACRO;

END;