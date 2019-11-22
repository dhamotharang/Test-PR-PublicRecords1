﻿import std, Watchdog_V2, dx_BestRecords;

noTx := row([],Layout_GetRelationship.TransactionalFlags_layout); 

EXPORT proc_GetRelationship(DATASET(Layout_GetRelationship.DIDs_layout) DID_ds,
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
                            boolean   SecondDegreeFlag                  = FALSE,
                            boolean   ThirdDegreeFlag                   = FALSE) := MODULE

CurrentDate             := (unsigned4) stringlib.GetDateYYYYMMDD();
shared LookbackDate     := std.date.AdjustDate(CurrentDate,,-RelLookbackMonths);
shared isDefault :=  NOT(RelativeFlag OR 
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
                         txflag.POBoxFlag); 
                  
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
                  txflag.POBoxFlag;

shared relationship_key_qa           := Relationship.key_relatives_v3;
shared dWatchdogUniversalKey         := dx_BestRecords.key_watchdog();
shared relationship_Marketing_Filter := dWatchdogUniversalKey.permissions & dx_BestRecords.Constants.PERM_TYPE.marketing > 0;
shared relationship_D2C_Filter       := dWatchdogUniversalKey.permissions & dx_BestRecords.Constants.PERM_TYPE.glb_d2c_filtered > 0;
shared DID_ds_dist                   := distribute(DID_ds,hash(did));

shared layout_GetRelationship.interfaceOutputNeutral xform(DID_ds l, relationship_key_qa r) := TRANSFORM
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

doJoin(relKey, joinOptions) := functionmacro
  out := join(DID_ds, relKey, keyed(left.did=right.did1), xform(left,right),#EXPAND(joinOptions));
  return out;
endmacro;
doJoinThor(relKey, joinOptions) := functionmacro
  relKeyJ := distribute(pull(relKey),hash(did1));
  out := join(DID_ds_dist, relKeyJ, left.did=right.did1, xform(left,right),#EXPAND(joinOptions), local);
  return out;
endmacro;

doFilteredJoin(relFilter, joinOptions) := functionmacro
  filteredOut := join(dWatchdogUniversalKey(relFilter), DID_ds, left.did=right.did, TRANSFORM(RIGHT));
  out := join(filteredOut, relationship_key_qa, keyed(left.did=right.did1), xform(left,right),#EXPAND(joinOptions));
  return out;
endmacro;
doFilteredJoinThor(relFilter, joinOptions) := functionmacro
  relFilteredKeyJ := distribute(pull(dWatchdogUniversalKey)(relFilter),hash(did));
  filteredOut := join(relFilteredKeyJ, DID_ds_dist, left.did=right.did, TRANSFORM(RIGHT), local);
  fullFilteredKey := distribute(pull(relationship_key_qa),hash(did1));
  out := join(filteredOut, fullFilteredKey, left.did=right.did1, xform(left,right),#EXPAND(joinOptions), local);
  return out;
endmacro;

skipOption   := 'LIMIT(MaxCount,SKIP)';
failOption   := 'LIMIT(MaxCount)';
atmostOption := 'ATMOST(MaxCount)';
allOption    := 'KEEP(20000),LIMIT(0)';
thorOption   := atmostOption;
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

relsNew := functions_getRelationship.convertNeutralToFlat(rels);
shared relsFlat := relsNew(cohabit_score>0 or coapt_score>0 or copobox_score>0 or cossn_score>0 or copolicy_score>0
                           or coclaim_score>0 or coproperty_score>0 or bcoproperty_score>0 or coforeclosure_score>0
                           or bcoforeclosure_score>0 or colien_score>0 or bcolien_score>0 or cobankruptcy_score>0
                           or bcobankruptcy_score>0 or covehicle_score>0 or coexperian_score>0 or cotransunion_score>0
                           or coenclarity_score>0 or coecrash_score>0 or bcoecrash_score>0 or cowatercraft_score>0
                           or coaircraft_score>0 or comarriagedivorce_score>0 or coucc_score>0 or type='TRANS CLOSURE');

shared txonly := relsFlat(type NOT IN ['PERSONAL','TRANS CLOSURE']);
         
shared Vehicle             := relsFlat(covehicle_cnt > 0);
shared BankruptcyDirect    := relsFlat(cobankruptcy_cnt > 0);
shared BankruptcyIndirect  := relsFlat(bcobankruptcy_cnt > 0);
shared PropertyDirect      := relsFlat(coproperty_cnt > 0);
shared PropertyIndirect    := relsFlat(bcoproperty_cnt > 0);
shared Experian            := relsFlat(coexperian_cnt > 0);
shared Enclarity           := relsFlat(coenclarity_cnt > 0);
shared Transunion          := relsFlat(cotransunion_cnt > 0);
shared ForeclosureDirect   := relsFlat(coforeclosure_cnt > 0);
shared ForeclosureIndirect := relsFlat(bcoforeclosure_cnt > 0);
shared LienDirect          := relsFlat(colien_cnt > 0);
shared LienIndirect        := relsFlat(bcolien_cnt > 0);
shared ECrashSame          := relsFlat(coecrash_cnt > 0);
shared ECrashDifferent     := relsFlat(bcoecrash_cnt > 0);
shared Watercraft          := relsFlat(cowatercraft_cnt > 0);
shared Aircraft            := relsFlat(coaircraft_cnt > 0);
shared UCC                 := relsFlat(coucc_cnt > 0);
shared MarriageDivorce     := relsFlat(coMarriageDivorce_cnt > 0);
shared Policy              := relsFlat(coPolicy_cnt > 0);
shared SSN                 := relsFlat(coSSN_cnt > 0);
shared Claim               := relsFlat(coclaim_cnt > 0);
shared Cohabit             := relsFlat(cohabit_cnt > 0);
shared CoApt               := relsFlat(coApt_cnt > 0);
shared CoPOBox             := relsFlat(coPOBox_cnt > 0);

shared RelativesOnly   := relsFlat(title BETWEEN 1 AND 43);
shared AssociatesOnly  := relsFlat(title = 44);

rel_title_layout := RECORD
   unsigned1 title;
   unsigned8 permissions;
END;
  
old_key_layout := record
    unsigned5 person1;
    boolean   same_lname;
    unsigned2 number_cohabits,
    integer3  recent_cohabit,
    unsigned5 person2;
    integer2  prim_range;
    DATASET(rel_title_layout) rel_title;
end;

shared old_key_layout legacy_format (recordof(RelativesOnly) l) := TRANSFORM
    self.person1         := l.did1;
    self.person2         := l.did2;
    self.same_lname      := l.isanylnamematch;
    self.number_cohabits := MAX(l.total_score / 5, 6);
    self.recent_cohabit  := l.rel_dt_last_seen / 100;
    self.prim_range      := l.source_type;
    self.rel_title       := DATASET([{l.title,0}],rel_title_layout),    
    self := l;
END;

shared OldRelativesOnly  := project(RelativesOnly,legacy_format(left));
shared OldAssociatesOnly := project(AssociatesOnly,legacy_format(left));

shared selected := MAP(AllFlag => relsFlat,
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
											 IF(txflag.POBoxFlag,CoPOBox));

shared old_selected := MAP(RelativeFlag  => OldRelativesOnly,
                           AssociateFlag => OldAssociatesOnly,
                           OldRelativesOnly + OldAssociatesOnly);

shared old_selected_dist := IF(doTHOR,distribute(old_selected,hash(person1)),old_selected);

shared interimResult := sort(dedup(sort(selected,did1,did2),did1,did2),did1,-total_score,did2);
shared interimLegacy := sort(dedup(sort(old_selected_dist,person1,person2,local),person1,person2,local),person1,-number_cohabits,person2,local);

export result := IF(TopNCount>0,ungroup(topN(group(sort(interimResult,did1),did1),TopNCount,-total_score)),interimResult);
export legacy := IF(TopNCount>0,ungroup(topN(group(sort(interimLegacy,person1),person1),TopNCount,-number_cohabits)),interimLegacy);

END;