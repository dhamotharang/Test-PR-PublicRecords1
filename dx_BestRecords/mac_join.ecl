EXPORT mac_join (ds, d_field, key, use_distributed, left_outer) := FUNCTIONMACRO

	LOCAL out_rec := RECORD(RECORDOF(ds))
		dx_BestRecords.layout_best _best;
	END;

  // RR-14697: Cast the d_field to unsigned to accomodate services outside of Roxie which can potentially 
  //   use a string for the did field
#IF (use_distributed)
	LOCAL ds_res := JOIN (DISTRIBUTE (ds, hash(d_field)), DISTRIBUTE(PULL(key), hash(did)),
		((unsigned)LEFT.d_field = RIGHT.did),           
		TRANSFORM (out_rec,
			SELF._best.age := if (RIGHT.dob = 0, 0, ut.age(RIGHT.dob)),
			SELF._best := RIGHT,
			SELF := LEFT),
		#IF (left_outer) 
			LEFT OUTER,            
		#END
		KEEP(1), LIMIT(0), LOCAL);
#ELSE
	LOCAL ds_res := JOIN (ds, key,
		KEYED((unsigned)LEFT.d_field = RIGHT.did),
		TRANSFORM (out_rec,
			SELF._best.age := if (RIGHT.dob = 0, 0, ut.age(RIGHT.dob)),
			SELF._best := RIGHT,
			SELF := LEFT),
		#IF (left_outer) 
			LEFT OUTER,            
		#END
		KEEP(1), LIMIT(0));
#END

	RETURN ds_res;

ENDMACRO;
