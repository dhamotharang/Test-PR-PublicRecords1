// Reduce header recs down to targets...

import doxie;

targetRec := doxie.layout_nbr_targets;

export DATASET(targetRec) nbr_records_targets(
	DATASET(targetRec) rawHR,
	unsigned1	Max_Nbrhoods
) := FUNCTION

	// ========================================== throw out worthless header records
  decentHR := rawHR(prim_name[1..6] != 'PO BOX');
	// OUTPUT(decentHR);	// DEBUG


	// ======================================= consolidate header records by address
	
	// group by zip/prim_name/prim_range, sorted by quality & recency
	hrs := group(
		sort(
			decentHR(prim_range <> '' OR prim_name <> ''), 
			zip, prim_name, prim_range, tnt_score(tnt), -dt_last_seen
		),
		zip, prim_name, prim_range
	);

	// consolidate each group in a single record, assimilating best dates
	hrs roll_dates(hrs L, hrs R) := TRANSFORM
		SELF.dt_first_seen := IF(
			R.dt_first_seen = 0 or (L.dt_first_seen < R.dt_first_seen and L.dt_first_seen>0),
			L.dt_first_seen,
			R.dt_first_seen
		);
		SELF.dt_last_seen := IF(
			L.dt_last_seen > R.dt_last_seen,
			L.dt_last_seen,
			R.dt_last_seen
		);
		SELF := L;
	END;
	hrd := rollup(hrs,true,roll_dates(LEFT,RIGHT));

	// put it back together in an ungrouped recordset
	reducedHR1 := group(hrd);
	// OUTPUT(reducedHR1);	// DEBUG


	// ======================================= reduce header records down to targets

	// dedup by zip/prim_name/prim_range to omit bad data that are really dup records
	// reducedHR2 := dedup(
		// sort(
			// reducedHR1,
			// zip, prim_name, prim_range, tnt_score(tnt), -dt_last_seen
		// ),
		// zip, prim_name, prim_range
	// );
	
	// the N best (high quality, recent) are the target addresses
	// around which we'll be looking for neighbors
	bestHR := choosen(
		sort(
			reducedHR1,
			tnt_score(tnt), -dt_last_seen
		),
		IF(Max_Nbrhoods < 1, 6, (integer) (Max_Nbrhoods * 1.5)) // keep 50% extra to allow pruning later
	);
	// OUTPUT(bestHR); // DEBUG


	// ========================================================= add target sequence
	targetRec doSequence(bestHR L, integer c) := TRANSFORM
		SELF.seqTarget := c;
		SELF := L;
	END;
	targets := project(bestHR, doSequence(LEFT, COUNTER));
	// OUTPUT(targetHR); // DEBUG

	// and we're outta here...
	RETURN(targets);
END;