EXPORT mac_join (ds, d_field, key, use_dist, appendd) := FUNCTIONMACRO
    // IMPORT section omitted on purpose 

    local out_rec := RECORD (RECORDOF(ds))
      dx_BestRecords.layout_best _best;
    END;

    local ds_res := IF (use_dist, 
        JOIN (DISTRIBUTE (ds, hash64(d_field)), DISTRIBUTE(PULL(key), hash64(did)),
              (LEFT.d_field = RIGHT.did),
              #IF (appendd)            
                  TRANSFORM (out_rec,
                             SELF._best.age := IF (RIGHT.dob = 0, 0, ut.age(RIGHT.dob)),
                             SELF._best := RIGHT,
                             SELF := LEFT),
                  LEFT OUTER,            
              #ELSE
                  TRANSFORM (RIGHT),
              #END
              KEEP(1), LIMIT(0), LOCAL),
        JOIN (ds, key,
              KEYED(LEFT.d_field = RIGHT.did),
              #IF (appendd)            
                  TRANSFORM (out_rec,
                             SELF._best.age := IF (RIGHT.dob = 0, 0, ut.age(RIGHT.dob)),
                             SELF._best := RIGHT,
                             SELF := LEFT),
                  LEFT OUTER,            
              #ELSE
                  TRANSFORM (RIGHT),
              #END
              KEEP(1), LIMIT(0), LOCAL)
    );

    RETURN ds_res;

ENDMACRO;