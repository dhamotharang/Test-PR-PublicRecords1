/*2016-03-17T18:40:56Z (Steven Stockton)
Remove only from High Confidence parms.
*/
/*2016-03-04T04:50:49Z (Steven Stockton)
Additional flags for filtering.
*/
import ut;

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
														Layout_GetRelationship.TransactionalFlags_layout txflag = notx) := MODULE

CurrentDate             := stringlib.GetDateYYYYMMDD();
shared LookbackDate     := (unsigned4) ut.month_math(CurrentDate,-RelLookbackMonths);
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

shared relationship_key  := Relationship.key_relatives_v3;
shared relationship_flat := distribute(pull(Relationship.key_relatives_v3),hash(did1));
shared DID_ds_dist       := distribute(DID_ds,hash(did));

shared layout_GetRelationship.InterfaceOuput xform(DID_ds l, relationship_key r) := TRANSFORM
  self.title_type  := MAP(r.title between 1 and 43 => 'R',
		                      r.title = 44             => 'A',
													r.title = 45             => 'N',
													r.title = 46             => 'B',
													'O'),
  self.source_type := MAP(//r.cohabit_cnt > 0           => -3,
		                      //r.copobox_cnt > 0           => -3,
													r.coapt_cnt   > 0           => -3,
													r.covehicle_cnt > 0         => -6,
													r.coproperty_cnt > 0        => -5,
													r.bcoproperty_cnt > 0       => -4,
													r.bcoforeclosure_cnt > 0    => -4,
													r.bcolien_cnt > 0           => -4,
													r.bcobankruptcy_cnt > 0     => -4,
													r.coenclarity_cnt > 0       => -4,
													r.type = 'TRANS CLOSURE'    => -2,
													r.cossn_cnt     > 0         => -1,
													r.covehicle_cnt > 0         => -6,
													r.coproperty_cnt > 0        => -5,
													r.comarriagedivorce_cnt > 0 => -7,
													r.copolicy_cnt > 0          =>  0,
													999),
  self.isRelative  := self.title_type = 'R';
	self.isAssociate := self.title_type = 'A';
	self.isBusiness  := self.title_type = 'B';
	self := r;
END;

relsSkip         := join(DID_ds,relationship_key,keyed(left.did = right.did1),xform(left,right),LIMIT(MaxCount,SKIP));
relsFail         := join(DID_ds,relationship_key,keyed(left.did = right.did1),xform(left,right),LIMIT(MaxCount));
relsAtmost       := join(DID_ds,relationship_key,keyed(left.did = right.did1),xform(left,right),ATMOST(MaxCount));
relsAll          := join(DID_ds,relationship_key,keyed(left.did = right.did1),xform(left,right));
relsTHOR         := join(DID_ds_dist,relationship_flat,left.did = right.did1,xform(left,right),ATMOST(MaxCount),local);

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
         
shared Vehicle             := rels(covehicle_cnt > 0);
shared BankruptcyDirect    := rels(cobankruptcy_cnt > 0);
shared BankruptcyIndirect  := rels(bcobankruptcy_cnt > 0);
shared PropertyDirect      := rels(coproperty_cnt > 0);
shared PropertyIndirect    := rels(bcoproperty_cnt > 0);
shared Experian            := rels(coexperian_cnt > 0);
shared Enclarity           := rels(coenclarity_cnt > 0);
shared Transunion          := rels(cotransunion_cnt > 0);
shared ForeclosureDirect   := rels(coforeclosure_cnt > 0);
shared ForeclosureIndirect := rels(bcoforeclosure_cnt > 0);
shared LienDirect          := rels(colien_cnt > 0);
shared LienIndirect        := rels(bcolien_cnt > 0);
shared ECrashSame          := rels(coecrash_cnt > 0);
shared ECrashDifferent     := rels(bcoecrash_cnt > 0);
shared Watercraft          := rels(cowatercraft_cnt > 0);
shared Aircraft            := rels(coaircraft_cnt > 0);
shared UCC                 := rels(coucc_cnt > 0);
shared MarriageDivorce     := rels(coMarriageDivorce_cnt > 0);
shared Policy              := rels(coPolicy_cnt > 0);
shared SSN                 := rels(coSSN_cnt > 0);
shared Claim               := rels(coclaim_cnt > 0);
shared Cohabit             := rels(cohabit_cnt > 0);
shared CoApt               := rels(coApt_cnt > 0);
shared CoPOBox             := rels(coPOBox_cnt > 0);

shared RelativesOnly   := rels(title BETWEEN 1 AND 43);
shared AssociatesOnly  := rels(title = 44);

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