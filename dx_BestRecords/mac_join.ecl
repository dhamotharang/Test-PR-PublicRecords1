EXPORT mac_join (ds, d_field, key, use_distributed, left_outer) := FUNCTIONMACRO

	LOCAL out_rec := RECORD(RECORDOF(ds))
		dx_BestRecords.layout_best _best;
	END;

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
