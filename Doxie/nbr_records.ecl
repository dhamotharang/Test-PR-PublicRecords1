// doxie_crs.nbr_records
//
// This receives a batch of header records for a given person, and
// turns them into an ordered list of neighbors.

 
// To test this code, see doxie_crs.nbr_records

import doxie, header, suppress;

export DATASET(doxie.layout_nbr_records) nbr_records(
	DATASET(doxie.layout_nbr_targets) targetHR,
	string1		mode,
	unsigned1	Max_Nbrhoods,
	unsigned1	NPA,
	unsigned1	Neighbors_Per_NA,
	unsigned1	Neighbor_Recency,
	string5		industry_class_value, // for MAC_GlbClean_Header
	unsigned1 GLB_Purpose,
	unsigned1	DPPA_Purpose,
	boolean		probation_override_value, // for MAC_GlbClean_Header
	boolean		no_scrub, // for MAC_GlbClean_Header
	boolean		glb_ok, //not used, delete, if refactoring
	boolean		dppa_ok,  //not used, delete, if refactoring
	string6		ssn_mask,
	boolean   use_Max_Nbrhoods = true,
	boolean   switch_Targetseq = true,
  unsigned1 proximity_radius = 10, // defines proximity in terms of "unitrs": houses, appartments, and alike
	boolean checkRNA = true
) := FUNCTION

  //get missing access parameters from global
  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT unsigned1 glb := GLB_Purpose;
    EXPORT unsigned1 dppa := DPPA_Purpose;
    EXPORT boolean probation_override := probation_override_value;
    EXPORT string5 industry_class := industry_class_value;
    EXPORT boolean no_scrub := ^.no_scrub;
    EXPORT string ssn_mask := ^.ssn_mask;
  END;  
  
  	// ================================================= generate candidate neighbors
	cn_raw := doxie.nbr_records_cn(targetHR, proximity_radius, 
	checkRNA,
	mode,
	Neighbor_Recency,
	mod_access);
	// OUTPUT(cn_raw, named('cn_raw')); // DEBUG
	
	// process candidates for privacy -- this may SKIP records so it needs
	// to be done before we get into selection and sequencing down below
	//header.MAC_GlbClean_Header(cn_raw, cn_glb);
	suppress.MAC_Mask(cn_raw, cn, ssn, foo, true, false,, true, , mod_access.ssn_mask);
	// OUTPUT(cn, named('cn')); // DEBUG


	// ============================================================== add computed fields
	widenedCN := doxie.nbr_records_affinity(
		PROJECT(cn, doxie.layout_nbr_records_cn),
		targetHR,
		mode,
		Neighbor_Recency
	);
	
	// OUTPUT(widenedCN, named('widenedCN')); // DEBUG


	// ========================================= determine the best neighboring addresses
	// in this context, best just means the closest
	wCN_d := group(
		dedup(
			sort(
				widenedCN,
				seqTarget, distance, zip, prim_name, prim_range, sec_range
			),
			seqTarget, distance, zip, prim_name, prim_range, sec_range
		),
		seqTarget
	);
	
	recNPA := record
		widenedCN.seqTarget;
		widenedCN.seqNPA;
		widenedCN.distance;
		widenedCN.zip;
		widenedCN.prim_name;
		widenedCN.prim_range;
		widenedCN.sec_range;
	end;
	recNPA doSeqNPA(recNPA L, recNPA R) := TRANSFORM
		SELF.seqNPA := IF(
			L.seqNPA = NPA,
			SKIP,
			L.seqNPA+1
		);
		SELF := R;
	END;
	wCN_NPA := PROJECT(wCN_d, recNPA);
	bestNPA_g := iterate(wCN_NPA, doSeqNPA(LEFT, RIGHT));
	bestNPA := ungroup(bestNPA_g);
	// OUTPUT(bestNPA, named('bestNPA')); // DEBUG
	
	
	// ====================================== narrow to best neighboring addresses
	widenedCN transNPA(widenedCN L, bestNPA R) := transform
		self.seqNPA := R.seqNPA;
		self := L;
	end;
	bestCN := join(
		widenedCN, bestNPA,
		LEFT.seqTarget = RIGHT.seqTarget AND
			LEFT.distance = RIGHT.distance AND
			LEFT.zip = RIGHT.zip AND
			LEFT.prim_name = RIGHT.prim_name AND
			LEFT.prim_range = RIGHT.prim_range AND
			LEFT.sec_range = RIGHT.sec_range,
		transNPA(LEFT, RIGHT)
	);
	// OUTPUT(bestNPA, named('bestNPA')); // DEBUG
	// OUTPUT(bestCN, named('bestCN')); // DEBUG


	// ========================= narrow to best neighbors and final sort/sequencing
	bestCN_srt := sort(
		bestCN,
		seqTarget, seqNPA, -affinity, -(integer)dt_last_seen
	);
	bestCN_grp := group(bestCN_srt, seqTarget, seqNPA);
      
	bestCN sequenceCN(
		bestCN L, integer cnt
	) := TRANSFORM
		self.seqNbr := IF(
			cnt > Neighbors_Per_NA,
			SKIP,
			cnt
		);
		self := L;
	END;

	bestCN_seq_grp := project(
		bestCN_grp, 
		sequenceCN(LEFT, COUNTER)
	);

	bestCN_seq := ungroup(bestCN_seq_grp);
	// OUTPUT(bestCN_seq, named('bestCN_seq')); // DEBUG


	// ================================================== reduce to final number of neighborhoods
	seqXtab_rec := record
		bestCN_seq.seqTarget;
		unsigned2 new_seqTarget := 0;
	end;
  seqXtab_rec seqXtab_fn(bestCN_seq L, integer C) := transform
		self.new_seqTarget := if(
			(C > IF(Max_Nbrhoods < 1, 4, Max_Nbrhoods)) and use_Max_Nbrhoods,
			skip,
			C
		);
		self := L;
	end;
	seqXtab := project(
		dedup(
			sort(
				bestCN_seq,
				seqTarget
			),
			seqTarget
		),
		seqXtab_fn(LEFT,COUNTER)
	);
	
	bestCN_seq resetSeq(bestCN_seq L, seqXtab R) := transform
		self.seqTarget := if(switch_Targetseq, R.new_seqTarget, L.seqTarget);
		self := L;
	end;
	bestCN_reduced := join(bestCN_seq, seqXtab,
		                     left.seqTarget = right.seqTarget,
		                     resetSeq(left, right),lookup);
						 
	// OUTPUT(bestCN_reduced, named('bestCN_reduced')); // DEBUG


	// ======================================================= return records to final sort order
  reducedRecs := sort(
		bestCN_reduced,
		seqTarget, seqNPA, seqNbr
	);
	// OUTPUT(reducedRecs, named('reducedRecs')); // DEBUG
	

	// ==================================================== final transform, and we're outta here
	finalRecs := PROJECT(reducedRecs, doxie.layout_nbr_records);
	// OUTPUT(finalRecs, named('finalRecs')); // DEBUG
	
	RETURN(finalRecs);
END;
