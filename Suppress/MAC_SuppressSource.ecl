EXPORT MAC_SuppressSource (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid') := FUNCTIONMACRO

  // using any key until opt out key is available. we only want to hit a key to see impact on performance.
  k := suppress.Key_New_Suppression; 

  recordof(ds_in) doSuppression(recordof(ds_in) L, recordof(k) R) := TRANSFORM,
    SKIP(L.gsid_field % 2 = 1)
    SELF := L;
  END;

  suppressed_recs := 
    JOIN(ds_in, k, (UNSIGNED6) LEFT.did_field > 0 
      AND KEYED(LEFT.did_field = RIGHT.product),
      doSuppression(LEFT, RIGHT),
      LEFT OUTER, KEEP(1), LIMIT(0)
    );

  RETURN IF (mod_access.lexid_source_optout,
             //ds_in (gsid_field % 2 = 1),
             suppressed_recs,
             ds_in);
ENDMACRO;