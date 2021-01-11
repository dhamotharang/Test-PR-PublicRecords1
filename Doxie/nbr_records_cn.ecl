import doxie, dx_header, ut, header, Suppress;

// ================================================================== handshake

// input record type
targetRec := doxie.layout_nbr_targets;

// we'll look for neighbors here...
key1 := dx_header.key_nbr_headers();
key2 := dx_header.key_nbr_headers_uid();

// output record type
cnRec := doxie.layout_nbr_records_cn;

cnRec_Layout_sids := RECORD
  doxie.layout_nbr_records_cn;
  UNSIGNED4 global_sid;
  UNSIGNED8 record_sid;
END;

// ============================================================== main function

export DATASET(cnRec) nbr_records_cn(
  DATASET(targetRec) targetHR,
  unsigned1 proximity_radius = 10,
  boolean checkRNA = true,
  string1 mode, // or part of results for the subject.
  unsigned1 Neighbor_Recency,
  doxie.IDataAccess mod_access
) := FUNCTION

  // how many addrs do we want on each side of each target?
  num_cn_addrs := proximity_radius;
  keep_recs:=ut.Min2(num_cn_addrs*20,500);
  // Use the first key to widen the targets to identify their uid,
  // plus the surrounding uids that we'll be looking for...

  uidTargetRec := RECORD
     unsigned6 uid;
    unsigned6 cnUidLo;
    unsigned6 cnUidHi;
    targetHR;
  END;

  uidTargetRec getUID(targetHR L, key1 R) := TRANSFORM
    SELF.uid := R.uid;
    SELF.cnUidLo := MAX((R.uid - num_cn_addrs), 0);
    SELF.cnUidHi := R.uid + num_cn_addrs;
    SELF := L;
  END;

  uidTargetHR := JOIN(
    targetHR, key1,
      keyed(LEFT.zip = RIGHT.zip) and
      keyed(LEFT.prim_name = RIGHT.prim_name) and
      keyed(LEFT.suffix = RIGHT.suffix) and
      keyed(LEFT.predir = RIGHT.predir) and
      keyed(LEFT.postdir = RIGHT.postdir) and
      keyed(LEFT.prim_range = RIGHT.prim_range) and
      keyed(LEFT.sec_range = RIGHT.sec_range),
    getUID(LEFT, RIGHT),
    keep(1)
  );

  // Use the second key to retrieve the candidate neighbors,
  // based on the uids we identified above...

  cnRec_Layout_sids getCN(uidTargetHR L, key2 R) := TRANSFORM
    SELF.seqtarget := L.seqtarget;
    SELF.base_did := L.did;
    SELF := R;
  END;

  cn2_all := JOIN(
    uidTargetHR, key2,
     keyed(LEFT.zip = RIGHT.zip) and
      keyed(LEFT.prim_name = RIGHT.prim_name) and
      keyed(LEFT.suffix = RIGHT.suffix) and
      keyed(LEFT.predir = RIGHT.predir) and
      keyed(LEFT.postdir = RIGHT.postdir) and
      keyed(LEFT.uid != RIGHT.uid) and
      keyed(RIGHT.uid between LEFT.cnUidLo and LEFT.cnUidHi),
    getCN(LEFT, RIGHT),
    limit(20000, skip),
    keep(keep_recs)
  );

  // Suppression below is applied against neighbor's did, not the subject (base_sid)
  cn2:= Suppress.MAC_SuppressSource(cn2_all, mod_access, did);

  //filter out the historical neighbors so that we do not look up the header records

  widenedCN := doxie.nbr_records_affinity(
    PROJECT(cn2, doxie.layout_nbr_records_cn),
    targetHR,
    mode,
    Neighbor_Recency
  );


  cn3 := project(widenedCN,cnRec);

  headerNbrForAddr := join(cn3, dx_header.key_header(),
    keyed(left.did = right.s_did)
    and left.prim_name = right.prim_name
    and left.prim_range = right.prim_range
    and left.sec_range = right.sec_range
    and left.zip = right.zip,
    transform(dx_header.layout_key_header, self := right),
    LIMIT(ut.limits.DID_PER_PERSON, SKIP));

  // add the other components of the address
  // should we go to the best file to get the best name for the neighbors ?
  // clean the records when it still have the src and dates
  header.MAC_GlbClean_Header(headerNbrForAddr, headerNbrForAddr_clean, , , mod_access, checkRNA);

  // rollup records
  df3:= group(
    sort(headerNbrForAddr_clean , zip, prim_name, suffix, predir, postdir,
      (unsigned5)prim_range, prim_range, sec_range, did, doxie.tnt_score(tnt),  -dt_last_seen
    ),
    zip, prim_name, suffix, predir, postdir // group
    ); //dt_first_seen,

  df3 roll_dates(df3 L, df3 R) := transform
    ut.mac_roll_DFS(dt_first_seen);
    ut.mac_roll_DLS(dt_last_seen);
    self := l;
  end;

  df4 := rollup(df3,
    LEFT.prim_range = RIGHT.prim_range AND
    LEFT.sec_range = RIGHT.sec_range AND
    LEFT.did = RIGHT.did,
    roll_dates(LEFT,RIGHT)
  );

  cn3 jtrans(cn3 l, df4 r) := transform
    self.dt_first_seen := r.dt_first_seen;
    self.dt_last_seen := r.dt_last_seen;
    self:=l;
  end;

  df5:= join(cn3,df4,
    left.did = right.did
    and left.prim_range = right.prim_range
    and left.sec_range = right.sec_range,
    jtrans(left,right),
    keep(1), limit (0));

  RETURN(df5);

END;
