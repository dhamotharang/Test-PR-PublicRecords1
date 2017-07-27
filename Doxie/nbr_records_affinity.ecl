//
// Compute affinity and other value-added neighbor fields
//

import ut;


// ========================================================= handshake

// input record types
targetRec := doxie.layout_nbr_targets;
cnRec			:= doxie.layout_nbr_records_cn;

// output record type
affinityRec := record
	string1		mode;
	
	cnRec;
	
	boolean		isCurrent;
	boolean		isHistoric;
	unsigned2	distance;
	unsigned2	overlap;
	unsigned2	affinity;
	unsigned2	base_prim_range;
	string8		base_sec_range;
	
	unsigned2	minOverlap  := 0;
	unsigned2	maxOverlap  := 0;
	unsigned2	minDistance := 0;
	unsigned2	maxDistance := 0;
end;


// ========================================================= helper funcs

// this is to clear out leading 0's from prim_ranges and sec_ranges
// which you can only do if the field is a pure number, no letters.
string clean_field(string f) := trim(
	if (
		f != '' and stringlib.stringfilterout(f,'0123456789') = '',
		(string)((integer)f),
		f
	),
	left,
	right
);

// affinity ranks neighbors of a given target, weighting distance
// and overlap.  a greater affinity represents a "better neighbor".
affinityRec calcAffinity(affinityRec L) := TRANSFORM
	// minOverlap => 0, maxOverlap => 9999
	normOverlap := ((unsigned4)L.overlap - (unsigned4)L.minOverlap)
		* (unsigned4)9999
		/ ((unsigned4)L.maxOverlap - (unsigned4)L.minOverlap);

	// maxDistance => 0, minDistance => 9999
	normDistance := ((unsigned4)L.maxDistance - (unsigned4)L.distance)
		* (unsigned4)9999
		/ ((unsigned4)L.maxDistance - (unsigned4)L.minDistance);
	
	// assume distance is 3x as important as overlap
	weight := (normOverlap + (3 * normDistance)) / 4;
	
	SELF.affinity := weight;
	SELF := L;
END;



// ========================================================= heavy lifting

export DATASET(affinityRec) nbr_records_affinity(
	DATASET(cnRec)			reducedCN,
	DATASET(targetRec)	targetHR,
	string1							mode,
	unsigned1						Neighbor_Recency
) := FUNCTION

	// define how many months old is still "current"
  currentMonths := IF(Neighbor_Recency > 0, Neighbor_Recency, 3);

	// split apartment numbers into components
	TOKEN aptDigit := PATTERN('[0-9]+');
	TOKEN aptAlpha := PATTERN('[a-z]+');
	TOKEN aptSpace := PATTERN('[^0-9a-z]+');
	RULE aptFrags := OPT(aptDigit) OPT(aptSpace) OPT(aptAlpha) OPT(aptSpace) OPT(aptDigit);

	cnRec_apt := RECORD
		reducedCN;
		aptAlpha := MATCHTEXT( aptAlpha );
		aptDigit := MATCHTEXT( aptDigit );
	END;
	reducedCN_apt := PARSE(reducedCN, sec_range, aptFrags, cnRec_apt, BEST, NOCASE);

	targetRec_apt := RECORD
		targetHR;
		aptAlpha := MATCHTEXT( aptAlpha );
		aptDigit := MATCHTEXT( aptDigit );
	END;
	targetHR_apt := PARSE(targetHR, sec_range, aptFrags, targetRec_apt, BEST, NOCASE);
	
	// output(reducedCN_apt, named('reducedCN_apt')); // DEBUG
	// output(targetHR_apt, named('targetHR_apt')); // DEBUG
	
	
	// we'll use these repeatedly below
	unsigned2 calc_distance_apt(string10 aptAlpha, string10 aptDigit, string10 aptAlpha_HR, string10 aptDigit_HR) := IF(
			aptAlpha = aptAlpha_HR,
			abs( (unsigned4)aptDigit - (unsigned4)aptDigit_HR ),
			1000
	);
	unsigned2 calc_distance(cnRec_apt L, targetRec_apt R) := IF(
		(integer8)L.prim_range = (integer8)R.prim_range,
		calc_distance_apt(L.aptAlpha, L.aptDigit, R.aptAlpha, R.aptDigit),
		abs((integer8)L.prim_range-(integer8)R.prim_range)
	);
	

	affinityRec computeFields(cnRec_apt L, targetRec_apt R) := transform
		// set dates
		self.dt_first_seen := L.dt_first_seen;
		self.dt_last_seen := L.dt_last_seen;
		
		// set the distance
		self.distance := calc_distance(L,R);
		
		// we want to get rid of 0 dates before computing overlap...
		// if last = 0, set to first.  if first = 0, set to last.
		tru_dt_first_seen := if(L.dt_first_seen != 0, L.dt_first_seen, L.dt_last_seen);
		tru_dt_last_seen := if(L.dt_last_seen != 0, L.dt_last_seen, L.dt_first_seen);

		// compute overlap in months
		myOverlap := ut.date_overlap(
			tru_dt_first_seen,
			tru_dt_last_seen,
			R.dt_first_seen,
			R.dt_last_seen
		);
		self.overlap := myOverlap;

		// compute isCurrent/isHistoric, and skip records we don't care about
		isCurrent := doxie.isrecent((STRING6)L.dt_last_seen, currentMonths);
		isHistoric := (myOverlap > 0);
		self.isCurrent := IF(
			(mode = 'C') and not isCurrent,
			skip,
			isCurrent
		);
		self.isHistoric := IF(
			(mode = 'H') and not isHistoric,
			skip,
			isHistoric
		);
		self.mode := mode;

		// set a placeholder for affinity
		self.affinity := 0;
		
		// another way to remember what the target was
		self.base_prim_range := (integer)R.prim_Range;
		self.base_sec_range  := R.sec_Range;

		self.prim_range := clean_field(L.prim_range);
		self.sec_range := clean_field(L.sec_range);
		
		self := L;
	end;

	// fill in the first block of computed fields
	outf1 := join(
		reducedCN_apt,
		targetHR_apt,
		left.seqTarget = right.seqTarget,
		computeFields(left, right)
	);
	// OUTPUT(outf1, named('outf1')); // DEBUG
	
	// set min/max values for each target
	xtabRec := RECORD
		outf1.seqTarget;
		minOverlap  := MIN(GROUP, outf1.overlap);
		maxOverlap  := MAX(GROUP, outf1.overlap);
		minDistance := MIN(GROUP, outf1.distance);
		maxDistance := MAX(GROUP, outf1.distance);
	END;
	xtab := TABLE(outf1, xtabRec, seqTarget);
	outf1 setMinMax(outf1 L, xtab R) := TRANSFORM
		SELF := R;
		SELF := L;
	END;
	outf1b := join(
		outf1, xtab, 
		LEFT.seqTarget = RIGHT.seqTarget,
		setMinMax(LEFT, RIGHT),
		LOOKUP
	);
	// OUTPUT(xtab); // DEBUG
	// OUTPUT(outf1b); // DEBUG

	// compute neighbor affinity within each target group
	outf2 := PROJECT(outf1b, calcAffinity(LEFT));
	// output(outf2, named('outf2')); // DEBUG
	
	RETURN(outf2);
END;
