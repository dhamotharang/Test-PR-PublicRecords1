import ut, doxie, doxie_Raw, Relationship;

inrec := doxie_Raw.Layout_RelativeRawBatchInput;
outrec := inrec;
relativeLayout := Relationship.layout_GetRelationship.InterfaceOutput_new;

export Relative_Raw_batch(
  grouped dataset(inrec) inputs, // by sequence
  doxie.IDataAccess mod_access,
  unsigned1 input_relative_depth = 0,
  boolean   incl_relatives = true,
  boolean   incl_associates = true,
  unsigned max_relatives = 0,  // means "not passed in" -- treated as "unlimited" in the upper levels
  unsigned max_associates = 0  // ...
) :=
FUNCTION

relMod := Relationship.IParams.getParams();

// RELATIVES_PER_PERSON has a different semantics, but we still have to set up a threshold
// to avoid potential exponential growth of number of relatives.
maxRelatives := if (max_relatives = 0, ut.limits.RELATIVES_PER_PERSON, max_relatives);
maxAssociates := if (max_associates = 0, ut.limits.RELATIVES_PER_PERSON, max_associates);

dids := inputs(input.did > 0);

outrec take_r(dids le, relativeLayout ri,unsigned1 d) := transform
  self.srcDID := le.input.DID;
  self.depth := d;
  self.titleNo := ri.title;
  self.person1 := ri.did1;
  self.person2 := ri.did2;
  self.same_lname := ri.isanylnamematch;
  self.rel_prim_range := ri.source_type;
  self.recent_cohabit := (ri.rel_dt_last_seen/100); // Removing day from date.
  self.number_cohabits := ri.total_score;
  self := ri;
  self := le.input;
  self := le;
  end;

outrec enumerate(outrec le, unsigned2 cnt) := transform
  self.p2_sort := cnt;
  self := le;
  end;

outrec enumerate3(outrec le, unsigned2 cnt) := transform
  self.p3_sort := cnt;
  self := le;
  end;

outrec enumerate4(outrec le, unsigned2 cnt) := transform
  self.p4_sort := cnt;
  self := le;
  end;

outrec take_rr(outrec le, relativeLayout ri,unsigned1 d) := transform
  self.depth := d;
  self.titleNo := Doxie_Raw.Constants.GetSecondDegRelation(le.titleNo,ri.title);
  self.person1 := ri.did1;
  self.person2 := ri.did2;
  self.same_lname := ri.isanylnamematch;
  self.rel_prim_range := ri.source_type;
  self.recent_cohabit := (ri.rel_dt_last_seen/100); // Remove day from date since v2 version only had year/month
  self.number_cohabits := ri.total_score;
  self.p2_sort := le.p2_sort;
  self.p3_sort := le.p3_sort;
  self.p4_sort := le.p4_sort;
  self := ri;
  self := le;
  end;

outrec take_l(outrec le) := transform
  self := le;
  end;

// ----------[ All associates--we care only about first generation ]----------
rel_dids := ungroup(project(dids,transform(Relationship.Layout_GetRelationship.DIDs_layout,self.did := left.input.did)));

Relkey := MAP(mod_access.isDirectMarketing() => Relationship.constants.RelKeyFlag.DM,
              mod_access.isConsumer() => Relationship.constants.RelKeyFlag.D2C,
              '');

rel_1_pre_neutral := Relationship.proc_GetRelationshipNeutral(rel_dids,
  RelativeFlag:=TRUE,
  AssociateFlag:=TRUE,
  MaxCount:=Doxie_Raw.Constants.RelativeAssociate_Limit, // Increased limit since relatives and associates are returned together
  doSkip:=TRUE,
  HighConfidenceRelatives:=relMod.relationship_highConfidenceRelatives,
  HighConfidenceAssociates:=relMod.relationship_highConfidenceAssociates,
  RelLookbackMonths:=relMod.relationship_relLookbackMonths,
  txflag:=Relationship.Functions.getTransAssocFlgs(relMod.relationship_transAssocMask),
  RelKeyFlag := Relkey).result;

rel_1_pre := Relationship.Functions_getRelationship.convertNeutralToFlat_new(rel_1_pre_neutral);

assoc_1_us := join(dids,rel_1_pre,
                    (unsigned6)left.input.did = right.did1 and not right.isRelative,
                    take_r(left, right, 1),
                    limit(ut.limits.RELATIVES_PER_PERSON,skip));

assoc_1 :=
  project(
    sort( assoc_1_us, -number_cohabits, -recent_cohabit, -isRelative, person1 ),
    enumerate(left,counter)
  );

associates := TOPN( assoc_1, maxAssociates, seq );

// ----------[ All first generation relatives ]----------
relas_1_us := join(dids,rel_1_pre,
                    (unsigned6)left.input.did = right.did1 and right.isRelative,
                    take_r(left, right, 1),
                    limit(ut.limits.RELATIVES_PER_PERSON,skip));

relas_1 :=
  group(project(
    sort( relas_1_us, -number_cohabits, -recent_cohabit, -isRelative, person1 ),
    enumerate(left,counter)),seq
  );

// Checking if we need more relatives
relas_1_look_for_more := HAVING(relas_1(input_Relative_Depth > 1 and isRelative), COUNT(ROWS(LEFT)) < maxRelatives);

// ----------[ All the second generation relatives ]----------

sgen_dids := ungroup(project(relas_1_look_for_more,transform(Relationship.Layout_GetRelationship.DIDs_layout,self.did := left.person2)));

relas_2_rels_neutral := Relationship.proc_GetRelationshipNeutral(sgen_dids,
  RelativeFlag:=TRUE,
  AssociateFlag:=TRUE,
  MaxCount:=Doxie_Raw.Constants.RelativeAssociate_Limit,  // Increased limit since relatives and associates are returned together
  doSkip:=TRUE,
  HighConfidenceRelatives:=relMod.relationship_highConfidenceRelatives,
  HighConfidenceAssociates:=relMod.relationship_highConfidenceAssociates,
  RelLookbackMonths:=relMod.relationship_relLookbackMonths,
  txflag:=Relationship.Functions.getTransAssocFlgs(relMod.relationship_transAssocMask),
  RelKeyFlag := Relkey).result;

relas_2_rels := Relationship.Functions_getRelationship.convertNeutralToFlat_new(relas_2_rels_neutral);

relas_2_pre := JOIN(relas_1_look_for_more,relas_2_rels,
                    left.person2 = right.did1 and right.isRelative,
                    take_rr(left, right, 2),
                    limit(ut.limits.RELATIVES_PER_PERSON,skip));

// Dedup siblings of second generation relatives
relas_2_bj := dedup( sort( relas_2_pre, seq, person2, -number_cohabits, -recent_cohabit, person1 ),seq, person2);

// Remove first generation relatives that are also second generation, but don't mix separate accounts(seq)
relas_2_bj1 := join( relas_2_bj, relas_1, left.person2=right.person2 and left.seq=right.seq, take_l(left), left only );

// Remove self from list of second generation relatives, but don't mix separate accounts(seq)
relas_2 := join( relas_2_bj1, dids, left.person2=right.input.did and left.seq=right.input.seq, take_l(left), left only );

// enumerate grouped dataset in sorting order
relas_2_enum := project(group(sort(relas_2,seq,-number_cohabits, -recent_cohabit,person1),seq),enumerate3(left,counter));

// Checking if we need more relatives should be for total from depth=1 and depth=2:
relas_2_grpd := GROUP( SORT( UNGROUP(relas_1+relas_2_enum), seq,depth ), seq );

// Identify records with input depth=3 having total number of relatives from previous steps less than maximum requested
// and prepare a list of 2nd generation relatives to be used for 3rd generation calculations
relas_2_look_for_more := HAVING(relas_2_grpd(input_Relative_Depth > 2 and isRelative), COUNT(ROWS(LEFT)) < maxRelatives)(depth=2);

// ----------[ All the third generation relatives ]----------
tgen_dids := ungroup(project(relas_2_look_for_more,transform(Relationship.Layout_GetRelationship.DIDs_layout,self.did := left.person2)));
// Proc params set to only return relatives and not associates.
relas_3_rels_neutral := Relationship.proc_GetRelationshipNeutral(tgen_dids,
  RelativeFlag:=TRUE,
  AssociateFlag:=TRUE,
  MaxCount:=Doxie_Raw.Constants.RelativeAssociate_Limit,  // Increased limit since relatives and associates are returned together
  doSkip:=TRUE,
  HighConfidenceRelatives:=relMod.relationship_highConfidenceRelatives,
  HighConfidenceAssociates:=relMod.relationship_highConfidenceAssociates,
  RelLookbackMonths:=relMod.relationship_relLookbackMonths,
  txflag:=Relationship.Functions.getTransAssocFlgs(relMod.relationship_transAssocMask),
  RelKeyFlag := Relkey).result;

relas_3_rels := Relationship.Functions_getRelationship.convertNeutralToFlat_new(relas_3_rels_neutral);

relas_3_pre := JOIN(relas_2_look_for_more,relas_3_rels,
                    left.person2 = right.did1 and right.isRelative,
                    take_rr(left, right, 3),
                    limit(ut.limits.RELATIVES_PER_PERSON,skip));

// Dedup siblings of third generation relatives
// dataset is grouped by seq, so dedup will be within group
relas_3_bj := dedup( sort( relas_3_pre, seq, person2, -number_cohabits, -recent_cohabit, person1 ), seq, person2 );

// Remove first generation relatives that are also third generation, but don't mix separate accounts(seq)
relas_3_bj1 := join( relas_3_bj, relas_1, left.person2=right.person2 and left.seq=right.seq, take_l(left), left only );

// Remove second generation relatives that are also third generation, but don't mix separate accounts(seq)
relas_3_bj2 := join( relas_3_bj1, relas_2, left.person2=right.person2 and left.seq=right.seq, take_l(left), left only );

// Remove self from list of third generation relatives, but don't mix separate accounts(seq)
relas_3 := join( relas_3_bj2, dids, left.person2=right.input.did and left.seq=right.input.seq, take_l(left), left only );

// enumerate grouped dataset in sorting order
relas_3_enum := project(group(sort(relas_3,-number_cohabits, -recent_cohabit,person1),seq), enumerate4(left,counter));

// Union
relatives_all := UNGROUP(relas_1 + relas_2_enum + relas_3_enum);

// There is a chance that the same person is listed twice - once as associate and another as 2nd or 3rd degree relative.
// It can  be addressed leaving only one of 2 records. Which one is a proper record to keep?

// Limit results by max value for each seq; then decide whether to output relatives and/or associates.
relatives_grpd := GROUP(SORT(relatives_all,seq),seq);
relatives := TOPN(relatives_grpd, MaxRelatives, seq,depth,-number_cohabits, -recent_cohabit, person1 );

results_unsorted := IF( incl_relatives, relatives ) + IF( incl_associates, associates );


// Return misses in output also.
outrec tramisses(inputs l) := transform
    self.srcDID := l.input.did;
    self.input := l.input;
    self := [];
end;

misses := join(inputs(input.seq > 0), results_unsorted, left.input.seq = right.seq, tramisses(left), left only);

results_plus_misses := results_unsorted + misses;

results := GROUP( SORT(results_plus_misses, seq, depth, -number_cohabits, -recent_cohabit, -isRelative, person1), seq );

ut.MAC_Slim_Back(results, outrec, results_slim)

return results_slim;

END;
