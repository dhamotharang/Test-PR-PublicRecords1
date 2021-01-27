import std, dx_BestRecords;

noTx := row([],Layout_GetRelationship.TransactionalFlags_layout);

EXPORT proc_GetRelationshipNeutral(DATASET(Layout_GetRelationship.DIDs_layout) DID_ds,
                                   boolean   RelativeFlag                      = FALSE,
                                   boolean   AssociateFlag                     = FALSE,
                                   boolean   AllFlag                           = FALSE,
                                   boolean   TransactionalOnlyFlag             = FALSE,
                                   unsigned2 MaxCount                          = 500,
                                   unsigned2 TopNCount                         = 100,
                                   boolean   doSkip                            = FALSE,
                                   boolean   doFail                            = FALSE,
                                   boolean   doAtmost                          = FALSE,
                                   boolean   sameLname                         = FALSE,
                                   unsigned2 minScore                          = 0,
                                   unsigned4 recentRelative                    = 0,
                                   unsigned8 person2                           = 0,
                                   boolean   excludeTransClosure2              = FALSE,
                                   boolean   excludeInactives                  = FALSE,
                                   boolean   doTHOR                            = FALSE,
                                   boolean   HighConfidenceRelatives           = FALSE,
                                   boolean   HighConfidenceAssociates          = FALSE,
                                   unsigned2 RelLookbackMonths                 = 0,
                                   Layout_GetRelationship.TransactionalFlags_layout txflag = notx,
                                   string    RelKeyFlag                        = '',
                                   boolean addNthDegree = FALSE) := MODULE

CurrentDate             := (unsigned4) stringlib.GetDateYYYYMMDD();
shared LookbackDate     := std.date.AdjustDate(CurrentDate,,-RelLookbackMonths);
shared isDefault := NOT(RelativeFlag OR
                        AssociateFlag OR
                        AllFlag OR
                        TransactionalOnlyFlag OR
                        txflag.VehicleFlag OR
                        txflag.BankruptcyDirectRelationshipFlag OR
                        txflag.BankruptcyIndirectRelationshipFlag OR
                        txflag.PropertyDirectRelationshipFlag OR
                        txflag.PropertyIndirectRelationshipFlag OR
                        txflag.ExperianFlag OR
                        txflag.EnclarityFlag OR
                        txflag.TransunionFlag OR
                        txflag.ForeclosureDirectRelationshipFlag OR
                        txflag.ForeclosureIndirectRelationshipFlag OR
                        txflag.LienDirectRelationshipFlag OR
                        txflag.LienIndirectRelationshipFlag OR
                        txflag.ECrashSameVehicleFlag OR
                        txflag.ECrashDifferentVehicleFlag OR
                        txflag.WatercraftFlag OR
                        txflag.AircraftFlag OR
                        txflag.UCCFlag OR
                        txflag.MarriageDivorceFlag OR
                        txflag.PolicyFlag OR
                        txflag.SSNFlag OR
                        txflag.ClaimFlag OR
                        txflag.CohabitFlag OR
                        txflag.AptFlag OR
                        txflag.POBoxFlag OR
                        txflag.CCFlag OR
                        txflag.CLUEFlag);

shared isTx   :=  txflag.VehicleFlag OR
                  txflag.BankruptcyDirectRelationshipFlag OR
                  txflag.BankruptcyIndirectRelationshipFlag OR
                  txflag.PropertyDirectRelationshipFlag OR
                  txflag.PropertyIndirectRelationshipFlag OR
                  txflag.ExperianFlag OR
                  txflag.EnclarityFlag OR
                  txflag.TransunionFlag OR
                  txflag.ForeclosureDirectRelationshipFlag OR
                  txflag.ForeclosureIndirectRelationshipFlag OR
                  txflag.LienDirectRelationshipFlag OR
                  txflag.LienIndirectRelationshipFlag OR
                  txflag.ECrashSameVehicleFlag OR
                  txflag.ECrashDifferentVehicleFlag OR
                  txflag.WatercraftFlag OR
                  txflag.AircraftFlag OR
                  txflag.UCCFlag OR
                  txflag.MarriageDivorceFlag OR
                  txflag.PolicyFlag OR
                  txflag.SSNFlag OR
                  txflag.ClaimFlag OR
                  txflag.CohabitFlag OR
                  txflag.AptFlag OR
                  txflag.POBoxFlag OR
                  txflag.CCFlag OR
                  txflag.CLUEFlag;

shared relationship_key_qa           := Relationship.key_relatives_v3;
shared nthDegree_Key                 := Relationship.key_relatives_Nth();
shared relationship_Marketing_Filter := dx_BestRecords.Constants.PERM_TYPE.marketing;
shared relationship_D2C_Filter       := dx_BestRecords.Constants.PERM_TYPE.glb_d2c_filtered;
shared DID_ds_dist                   := distribute(DID_ds,hash(did));

shared layout_GetRelationship.interfaceOutputNeutral xform(relationship_key_qa r) := TRANSFORM
  self.title_type  := MAP(r.title between 1 and 43 => 'R',
                          r.title = 44             => 'A',
                          r.title = 45             => 'N',
                          r.title = 46             => 'B',
                          'O'),
  self.source_type := MAP(//r.rels(rel_type = Constants.cohabit) > 0                => -3
                          //r.rels(rel_type = Constants.copobox) > 0                => -3
                          r.rels(rel_type = Constants.coapt)[1].cnt   > 0           => -3,
                          r.rels(rel_type = Constants.covehicle)[1].cnt >0          => -6,
                          r.rels(rel_type = Constants.coproperty)[1].cnt > 0        => -5,
                          r.rels(rel_type = Constants.bcoproperty)[1].cnt > 0       => -4,
                          r.rels(rel_type = Constants.bcoforeclosure)[1].cnt > 0    => -4,
                          r.rels(rel_type = Constants.bcolien)[1].cnt > 0           => -4,
                          r.rels(rel_type = Constants.bcobankruptcy)[1].cnt > 0     => -4,
                          r.rels(rel_type = Constants.coenclarity)[1].cnt > 0       => -4,
                          r.type = Constants.TransClosure                           => -2,
                          r.rels(rel_type = Constants.cossn)[1].cnt > 0             => -1,
                          r.rels(rel_type = Constants.covehicle)[1].cnt > 0         => -6,
                          r.rels(rel_type = Constants.coproperty)[1].cnt > 0        => -5,
                          r.rels(rel_type = Constants.comarriagedivorce)[1].cnt > 0 => -7,
                          r.rels(rel_type = Constants.copolicy)[1].cnt > 0          =>  0,
                          999),
  self.isRelative  := self.title_type = 'R';
  self.isAssociate := self.title_type = 'A';
  self.isBusiness  := self.title_type = 'B';
  self := r;
END;

shared doJoin(relKey, joinOptions) := functionmacro
  out := join(DID_ds, relKey, keyed(left.did=right.did1), xform(right),#EXPAND(joinOptions));
  return out;
endmacro;
shared doJoinThor(relKey, joinOptions) := functionmacro
  relKeyJ := distribute(pull(relKey),hash(did1));
  out := join(DID_ds_dist, relKeyJ, left.did=right.did1, xform(right),#EXPAND(joinOptions), local);
  return out;
endmacro;

shared doFilteredJoin(relFilter, joinOptions) := functionmacro
  // Remove DID1s that need to be filtered
  filteredOutDID1 := dx_BestRecords.get(DID_ds,did,relFilter,Layout_GetRelationship.DIDs_layout); 
  // Get DID1 & DID2 pairs
  getDID2 := JOIN(filteredOutDID1, relationship_key_qa, keyed(left.did=right.did1), xform(right),#EXPAND(joinOptions));
  dDID2 := PROJECT(getDID2,TRANSFORM(Layout_GetRelationship.DIDs_layout,SELF.did:=LEFT.did2));
  // Remove DID2s that should also be filtered
  filteredOutDID2 := dx_BestRecords.get(dDID2,did,relFilter,Layout_GetRelationship.DIDs_layout);
  out := JOIN(filteredOutDID2, getDID2, left.did=right.did2, TRANSFORM(RIGHT));
  return out;
endmacro;
shared doFilteredJoinThor(relFilter, joinOptions) := functionmacro
  // Remove DID1s that need to be filtered
  filteredOutDID1 := dx_BestRecords.get(DID_ds,did,relFilter,Layout_GetRelationship.DIDs_layout,TRUE);
  fullFilteredKey := distribute(pull(relationship_key_qa),hash(did1));
  // Get DID1 & DID2 pairs
  getDID2 := join(DISTRIBUTED(filteredOutDID1,HASH(did)), fullFilteredKey, left.did=right.did1, xform(right),#EXPAND(joinOptions), local);
  dDID2   :=  PROJECT(getDID2,TRANSFORM(Layout_GetRelationship.DIDs_layout,SELF.did:=LEFT.did2));
  // Remove DID2s that should also be filtered
  filteredOutDID2 := dx_BestRecords.get(dDID2,did,relFilter,Layout_GetRelationship.DIDs_layout,TRUE);
  out :=  JOIN(DISTRIBUTED(filteredOutDID2,HASH(did)), DISTRIBUTED(getDID2,HASH(did2)), left.did=right.did2, TRANSFORM(RIGHT),LOCAL);
  return out;
endmacro;

shared skipOption   := 'LIMIT(MaxCount,SKIP)';
shared failOption   := 'LIMIT(MaxCount)';
shared atmostOption := 'ATMOST(MaxCount)';
shared allOption    := 'KEEP(20000),LIMIT(0)';
shared thorOption   := atmostOption;
relsSkip         := MAP(RelKeyFlag='D2C'       => doFilteredJoin(relationship_D2C_Filter, skipOption),
                        RelKeyFlag='MARKETING' => doFilteredJoin(relationship_Marketing_Filter, skipOption),
                        doJoin(relationship_key_qa, skipOption));
relsFail         := MAP(RelKeyFlag='D2C'       => doFilteredJoin(relationship_D2C_Filter, failOption),
                        RelKeyFlag='MARKETING' => doFilteredJoin(relationship_Marketing_Filter, failOption),
                        doJoin(relationship_key_qa, failOption));
relsAtmost       := MAP(RelKeyFlag='D2C'       => doFilteredJoin(relationship_D2C_Filter, atmostOption),
                        RelKeyFlag='MARKETING' => doFilteredJoin(relationship_Marketing_Filter, atmostOption),
                        doJoin(relationship_key_qa, atmostOption));
relsAll0         := MAP(RelKeyFlag='D2C'       => doFilteredJoin(relationship_D2C_Filter, allOption),
                        RelKeyFlag='MARKETING' => doFilteredJoin(relationship_Marketing_Filter, allOption),
                        doJoin(relationship_key_qa, allOption));
relsAll          := TOPN(relsAll0, 10000, -total_score, -total_cnt);
relsTHOR         := MAP(RelKeyFlag='D2C'       => doFilteredJoinThor(relationship_D2C_Filter, thorOption),
                        RelKeyFlag='MARKETING' => doFilteredJoinThor(relationship_Marketing_Filter, thorOption),
                        doJoinThor(relationship_key_qa, thorOption));

shared rels      := MAP(doThor                       => relsThor,
                        doSkip                       => relsSkip,
                        doFail                       => relsFail,
                        doAtMost                     => relsAtmost,
                        relsAll)
                       (IF(sameLname,isanylnamematch,TRUE) AND
                        IF(minScore>0,total_score>=minScore,TRUE) AND
                        IF(recentRelative>0,
                           MAP(recentRelative between 1000   and 9999   => rel_dt_last_seen/10000 >= recentRelative,
                               recentRelative between 100000 and 999999 => rel_dt_last_seen/100   >= recentRelative,
                               rel_dt_last_seen >= recentRelative),
                           TRUE) AND
                        IF(person2>0,did2=person2,TRUE) AND
                        IF(excludeInactives,cluster<>'INACTIVE',TRUE) AND
                        IF(excludeTransClosure2,not(type = 'TRANS CLOSURE' AND confidence = 'MEDIUM'),TRUE) AND
                        IF(HighConfidenceRelatives,type<>'TRANS CLOSURE',TRUE) AND
                        IF(HighConfidenceAssociates AND title=44,total_score>=79,TRUE) AND
                        IF(RelLookbackMonths>0 AND rel_dt_last_seen>0,rel_dt_last_seen>LookbackDate,TRUE));

shared txonly := rels(type NOT IN ['PERSONAL','TRANS CLOSURE']);

shared relsFlat := functions_getRelationship.convertNeutralToFlat_new(rels);
shared Vehicle             := functions_getRelationship.convertFlatToNeutral(relsFlat(covehicle_cnt > 0));
shared BankruptcyDirect    := functions_getRelationship.convertFlatToNeutral(relsFlat(cobankruptcy_cnt > 0));
shared BankruptcyIndirect  := functions_getRelationship.convertFlatToNeutral(relsFlat(bcobankruptcy_cnt > 0));
shared PropertyDirect      := functions_getRelationship.convertFlatToNeutral(relsFlat(coproperty_cnt > 0));
shared PropertyIndirect    := functions_getRelationship.convertFlatToNeutral(relsFlat(bcoproperty_cnt > 0));
shared Experian            := functions_getRelationship.convertFlatToNeutral(relsFlat(coexperian_cnt > 0));
shared Enclarity           := functions_getRelationship.convertFlatToNeutral(relsFlat(coenclarity_cnt > 0));
shared Transunion          := functions_getRelationship.convertFlatToNeutral(relsFlat(cotransunion_cnt > 0));
shared ForeclosureDirect   := functions_getRelationship.convertFlatToNeutral(relsFlat(coforeclosure_cnt > 0));
shared ForeclosureIndirect := functions_getRelationship.convertFlatToNeutral(relsFlat(bcoforeclosure_cnt > 0));
shared LienDirect          := functions_getRelationship.convertFlatToNeutral(relsFlat(colien_cnt > 0));
shared LienIndirect        := functions_getRelationship.convertFlatToNeutral(relsFlat(bcolien_cnt > 0));
shared ECrashSame          := functions_getRelationship.convertFlatToNeutral(relsFlat(coecrash_cnt > 0));
shared ECrashDifferent     := functions_getRelationship.convertFlatToNeutral(relsFlat(bcoecrash_cnt > 0));
shared Watercraft          := functions_getRelationship.convertFlatToNeutral(relsFlat(cowatercraft_cnt > 0));
shared Aircraft            := functions_getRelationship.convertFlatToNeutral(relsFlat(coaircraft_cnt > 0));
shared UCC                 := functions_getRelationship.convertFlatToNeutral(relsFlat(coucc_cnt > 0));
shared MarriageDivorce     := functions_getRelationship.convertFlatToNeutral(relsFlat(coMarriageDivorce_cnt > 0));
shared Policy              := functions_getRelationship.convertFlatToNeutral(relsFlat(coPolicy_cnt > 0));
shared SSN                 := functions_getRelationship.convertFlatToNeutral(relsFlat(coSSN_cnt > 0));
shared Claim               := functions_getRelationship.convertFlatToNeutral(relsFlat(coclaim_cnt > 0));
shared Cohabit             := functions_getRelationship.convertFlatToNeutral(relsFlat(cohabit_cnt > 0));
shared CoApt               := functions_getRelationship.convertFlatToNeutral(relsFlat(coApt_cnt > 0));
shared CoPOBox             := functions_getRelationship.convertFlatToNeutral(relsFlat(coPOBox_cnt > 0));
shared CoCC                := functions_getRelationship.convertFlatToNeutral(relsFlat(coCC_cnt > 0));
shared CoCLUE              := functions_getRelationship.convertFlatToNeutral(relsFlat(coCLUE_cnt > 0));

shared RelativesOnly   := rels(title BETWEEN 1 AND 43);
shared AssociatesOnly  := rels(title = 44);

rel_title_layout := RECORD
   unsigned1 title;
   unsigned8 permissions;
  END;

shared selected := MAP(AllFlag => rels,
                       isDefault  => RelativesOnly + AssociatesOnly,
                       IF(RelativeFlag,RelativesOnly) +
                       IF(AssociateFlag,AssociatesOnly) +
                       //IF(TransactionalOnlyFlag,txOnly) +
                       IF(isTx AND NOT (TransactionalOnlyFlag OR RelativeFlag OR AssociateFlag),RelativesOnly + AssociatesOnly) +
                       IF(txflag.VehicleFlag,Vehicle) +
                       IF(txflag.BankruptcyDirectRelationshipFlag,BankruptcyDirect) +
                       IF(txflag.BankruptcyIndirectRelationshipFlag,BankruptcyIndirect) +
                       IF(txflag.PropertyDirectRelationshipFlag,PropertyDirect) +
                       IF(txflag.PropertyIndirectRelationshipFlag,PropertyIndirect) +
                       IF(txflag.ExperianFlag,Experian) +
                       IF(txflag.EnclarityFlag,Enclarity) +
                       IF(txflag.TransunionFlag,Transunion) +
                       IF(txflag.ForeclosureDirectRelationshipFlag,ForeclosureDirect) +
                       IF(txflag.ForeclosureIndirectRelationshipFlag,ForeclosureIndirect) +
                       IF(txflag.LienDirectRelationshipFlag,LienDirect) +
                       IF(txflag.LienIndirectRelationshipFlag,LienIndirect) +
                       IF(txflag.ECrashSameVehicleFlag,ECrashSame) +
                       IF(txflag.ECrashDifferentVehicleFlag,ECrashDifferent) +
                       IF(txflag.WatercraftFlag,Watercraft) +
                       IF(txflag.AircraftFlag,Aircraft) +
                       IF(txflag.UCCFlag,UCC) +
                       IF(txflag.MarriageDivorceFlag,MarriageDivorce) +
                       IF(txflag.SSNFlag,SSN) +
                       IF(txflag.PolicyFlag,Policy) +
                       IF(txflag.ClaimFlag,Claim) +
                       IF(txflag.CohabitFlag,Cohabit) +
                       IF(txflag.AptFlag,CoApt) +
                       IF(txflag.POBoxFlag,CoPOBox) +
                       IF(txflag.CCFlag, CoCC) +
                       IF(txflag.CLUEFlag, CoCLUE));

 relsNthDegreeSkip			:= doJoin(nthDegree_Key, skipOption);
 relsNthDegreeFail			:= doJoin(nthDegree_Key,failOption);
 relsNthDegreeAtmost		:= doJoin(nthDegree_Key,atmostOption);
 relsNthDegreeAll0			:= doJoin(nthDegree_Key,allOption);
 relsNthDegreeAll			  := TOPN(relsNthDegreeAll0, 10000, -total_score, -total_cnt);
 relsNthDegreeTHOR			:= doJoinThor(nthDegree_Key, thorOption);

 shared relsNthDegree	:= MAP(doThor                  => relsNthDegreeTHOR,
                         doSkip                       => relsNthDegreeSkip,
                         doFail                       => relsNthDegreeFail,
                         doAtMost                     => relsNthDegreeAtmost,
                         relsNthDegreeAll);

removedSuppressed := Relationship.proc_suppressKey(selected).run;
shared interimResult := sort(dedup(sort(removedSuppressed,did1,did2),did1,did2),did1,-total_score,did2);

nthRemovedSuppressed := Relationship.proc_suppressKey(relsNthDegree).run;
shared interimNthResult := IF(addNthDegree, nthRemovedSuppressed, dataset([], layout_GetRelationship.interfaceOutputNeutral));

// output(rels, named('rels'));
// output(selected, named('selected'));
// output(SecondDegreeFlag, named('SecondDegreeFlag'));
// output(ThirdDegreeFlag, named('ThirdDegreeFlag'));
// output(nthFilter, named('nthFilter'));
// output(relsNthDegree, named('relsNthDegree'));

export result := IF(TopNCount>0,ungroup(topN(group(sort(interimResult,did1),did1),TopNCount,-total_score)) &
                  ungroup(topN(group(sort(interimNthResult,did1),did1),TopNCount,-total_score)),
                    interimResult & sort(interimNthResult, -total_score, did1, did2));
END;