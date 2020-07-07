// This receives a batch of header records for a given person, and
// turns them into an ordered list of neighbors.


// To test this code, see doxie_crs.nbr_records

import doxie, Suppress;

export DATASET(doxie.layout_nbr_records) nbr_records(
  DATASET(doxie.layout_nbr_targets) targetHR,
  string1		mode,
  unsigned1	Max_Nbrhoods,
  unsigned1	NPA,
  unsigned1	Neighbors_Per_NA,
  unsigned1	Neighbor_Recency,
  boolean   use_Max_Nbrhoods = true,
  boolean   switch_Targetseq = true,
  unsigned1 proximity_radius = 10, // defines proximity in terms of "unitrs": houses, appartments, and alike
  boolean checkRNA = true,
  doxie.IDataAccess mod_access
) := FUNCTION

    // ================================================= generate candidate neighbors
  cn_raw := doxie.nbr_records_cn(targetHR, proximity_radius,
  checkRNA,
  mode,
  Neighbor_Recency,
  mod_access);

  // process candidates for privacy -- this may SKIP records so it needs
  // to be done before we get into selection and sequencing down below
  suppress.MAC_Mask(cn_raw, cn, ssn, foo, true, false,, true, , mod_access.ssn_mask);


  // ============================================================== add computed fields
  widenedCN := doxie.nbr_records_affinity(
    PROJECT(cn, doxie.layout_nbr_records_cn),
    targetHR,
    mode,
    Neighbor_Recency
  );


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


  // ======================================================= return records to final sort order
  reducedRecs := sort(
    bestCN_reduced,
    seqTarget, seqNPA, seqNbr
  );

  // ======================================================== look for marketing restrictions
  reducedRecs_marketing := If(mod_access.isDirectMarketing(), reducedRecs(doxie.compliance.isMarketingAllowed(src,st)), reducedRecs);

  // ==================================================== final transform, and we're outta here
  finalRecs := PROJECT(reducedRecs_marketing, doxie.layout_nbr_records);

  RETURN(finalRecs);
END;
