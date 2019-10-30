//This FM supports key: dx_BestRecords.key_watchdog() and returns results based on a permissions bitmask.
EXPORT mac_join_V2 (ds, d_field, key, use_distributed, left_outer, permission_type) := FUNCTIONMACRO
  IMPORT ut;

  LOCAL out_rec := RECORD(RECORDOF(ds))
    dx_BestRecords.layout_best _best;
  END;

  out_rec _xform(RECORDOF(ds) L, RECORDOF(key) R):= TRANSFORM
    SELF._best.age := IF(R.dob = 0, 0, ut.age(R.dob));
    SELF._best := R;
    SELF := L;
  END;

  //RR-14697: Cast the d_field to unsigned to accomodate services outside of Roxie which can potentially
  //use a string for the did field
  #IF (use_distributed)
    LOCAL ds_res := JOIN (DISTRIBUTE (ds, hash(d_field)), DISTRIBUTE(PULL(key), hash(did)),
      ((unsigned)LEFT.d_field = RIGHT.did) AND
      ((RIGHT.permissions & permission_type) > 0),
      _xform(LEFT, RIGHT),
      #IF (left_outer)
        LEFT OUTER,
      #END
      KEEP(1), LIMIT(0), LOCAL);
  #ELSE
    LOCAL ds_res := JOIN (ds, key,
      KEYED((unsigned)LEFT.d_field = RIGHT.did)
      AND ((RIGHT.permissions & permission_type) > 0),
      _xform(LEFT, RIGHT),
      #IF (left_outer)
        LEFT OUTER,
      #END
      KEEP(1), LIMIT(0));
  #END

  RETURN ds_res;

ENDMACRO;
