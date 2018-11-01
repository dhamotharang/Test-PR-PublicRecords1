EXPORT mac_join (ds, d_field, key, use_dist, left_outer) := FUNCTIONMACRO

	LOCAL out_rec := RECORD(RECORDOF(ds))
		dx_BestRecords.layout_best _best;
	END;

	LOCAL ds_res := if (use_dist, 
		JOIN (DISTRIBUTE (ds, hash64(d_field)), DISTRIBUTE(PULL(key), hash64(did)),
			(LEFT.d_field = RIGHT.did),           
			TRANSFORM (out_rec,
				SELF._best._valid := TRUE, 
				SELF._best.age := if (RIGHT.dob = 0, 0, ut.age(RIGHT.dob)),
				SELF._best := RIGHT,
				SELF := LEFT),
			#IF (left_outer) 
				LEFT OUTER,            
			#END
			KEEP(1), LIMIT(0), LOCAL),
		JOIN (ds, key,
			KEYED(LEFT.d_field = RIGHT.did),
			TRANSFORM (out_rec,
				SELF._best._valid := TRUE, 
				SELF._best.age := if (RIGHT.dob = 0, 0, ut.age(RIGHT.dob)),
				SELF._best := RIGHT,
				SELF := LEFT),
			#IF (left_outer) 
				LEFT OUTER,            
			#END
			KEEP(1), LIMIT(0))
	);

	RETURN ds_res;

ENDMACRO;