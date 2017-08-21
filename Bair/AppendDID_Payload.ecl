import did_add,bair_composite;

EXPORT AppendDID_Payload (string version = '', boolean pUseProd = false, boolean pDelta = false) := module
	
	shared NewHeader 	:= Bair.HeaderInfo.IsNew;
	
	r := bair.layouts.rCompositeBase;

	// shared dsLexId_ := distribute(if(pDelta, dataset('~thor400_data::base::composite_public_safety_data_curr_delta', r, flat), bair_composite.Files(pUseProd,false).composite_base), hash(eid));
	shared dsLexId_ := distribute(bair_composite.Files(pUseProd,pDelta).composite_base, hash(eid));
	shared dsLexId 	:= dsLexId_(lexid <> 0);
	
	shared cfs 	:= Bair.Update_Base(version, pUseProd, pDelta).CFS_base;
	shared per	:= Bair.Update_Base(version, pUseProd, pDelta).PERSONS_base;
	shared cra	:= bair.Update_Base(version, pUseProd, pDelta).CRASH_base;
	shared off	:= bair.Update_Base(version, pUseProd, pDelta).OFFENDERS_base;
	
	shared const_mod	:= Bair._Constant;
	
	JoinCfs := join(
							distribute(cfs, hash(eid))
							,dsLexId(Prepped_rec_type in [const_mod.CFS_caller_addr,const_mod.CFS_complainant_addr,const_mod.CFS_Incident_addr])
							,left.eid = right.eid
							,transform({cfs}
								,self.eid 						:= left.eid
								,self.lexid 					:= right.lexid
								,self.lexid_score 		:= right.lexid_score
								,self.xadl2_Weight 		:= right.xadl2_Weight
								,self.xadl2_Score 		:= right.xadl2_Score
								,self.xadl2_keys_used := right.xadl2_keys_used
								,self.xadl2_distance 	:= right.xadl2_distance
								,self.xadl2_matches 	:= right.xadl2_matches
								,self.bdid 						:= right.bdid
								,self.bdid_score 			:= right.bdid_score
								,self.DotID						:= right.DotID
								,self.DotScore				:= right.DotScore
								,self.DotWeight				:= right.DotWeight
								,self.EmpID						:= right.EmpID
								,self.EmpScore				:= right.EmpScore
								,self.EmpWeight				:= right.EmpWeight
								,self.POWID						:= right.POWID
								,self.POWScore				:= right.POWScore
								,self.POWWeight				:= right.POWWeight
								,self.ProxID					:= right.ProxID
								,self.ProxScore				:= right.ProxScore
								,self.ProxWeight			:= right.ProxWeight
								,self.SELEID					:= right.SELEID
								,self.SELEScore				:= right.SELEScore
								,self.SELEWeight			:= right.SELEWeight
								,self.OrgID						:= right.OrgID
								,self.OrgScore				:= right.OrgScore
								,self.OrgWeight				:= right.OrgWeight
								,self.UltID						:= right.UltID
								,self.UltScore				:= right.UltScore
								,self.UltWeight				:= right.UltWeight															
								,self := left)
							,left outer
							,keep(1)
							,local
							);
														
	EXPORT cfs_w_lexid := dedup(JoinCfs, record, all);
	
	// if(not NewHeader and not pDelta
													// ,cfs
													// ,dedup(JoinCfs, record, all)
												// );	
	JoinPer := join(
							distribute(per, hash(eid))
							,dsLexId(Prepped_rec_type = const_mod.Events_Persons_persons_address)
							,left.eid = right.eid and left.recordid_raids = right.recordid_raids
							,transform({per}
								,self.eid 						:= left.eid
								,self.lexid 					:= right.lexid
								,self.lexid_score 		:= right.lexid_score
								,self.xadl2_Weight 		:= right.xadl2_Weight
								,self.xadl2_Score 		:= right.xadl2_Score
								,self.xadl2_keys_used := right.xadl2_keys_used
								,self.xadl2_distance 	:= right.xadl2_distance
								,self.xadl2_matches 	:= right.xadl2_matches
								,self.bdid 						:= right.bdid
								,self.bdid_score 			:= right.bdid_score
								,self.DotID						:= right.DotID
								,self.DotScore				:= right.DotScore
								,self.DotWeight				:= right.DotWeight
								,self.EmpID						:= right.EmpID
								,self.EmpScore				:= right.EmpScore
								,self.EmpWeight				:= right.EmpWeight
								,self.POWID						:= right.POWID
								,self.POWScore				:= right.POWScore
								,self.POWWeight				:= right.POWWeight
								,self.ProxID					:= right.ProxID
								,self.ProxScore				:= right.ProxScore
								,self.ProxWeight			:= right.ProxWeight
								,self.SELEID					:= right.SELEID
								,self.SELEScore				:= right.SELEScore
								,self.SELEWeight			:= right.SELEWeight
								,self.OrgID						:= right.OrgID
								,self.OrgScore				:= right.OrgScore
								,self.OrgWeight				:= right.OrgWeight
								,self.UltID						:= right.UltID
								,self.UltScore				:= right.UltScore
								,self.UltWeight				:= right.UltWeight								
								,self := left)
							,left outer
							,keep(1)
							,local
							);
																
	EXPORT per_w_lexid 		:= JoinPer;
	
	// if(not NewHeader and not pDelta
															// ,per
															// ,JoinPer
															// );	
	JoinCra := join(
							distribute(cra, hash(eid))
							,dsLexId(Prepped_rec_type in [const_mod.Crash_Incident, const_mod.Crash_Person, const_mod.Crash_Vehicle])
							,left.eid = right.eid and left.per_id = right.per_id
							,transform({cra}
								,self.eid 						:= left.eid
								,self.lexid 					:= right.lexid
								,self.lexid_score 		:= right.lexid_score
								,self.xadl2_Weight 		:= right.xadl2_Weight
								,self.xadl2_Score 		:= right.xadl2_Score
								,self.xadl2_keys_used := right.xadl2_keys_used
								,self.xadl2_distance 	:= right.xadl2_distance
								,self.xadl2_matches 	:= right.xadl2_matches
								,self.bdid 						:= right.bdid
								,self.bdid_score 			:= right.bdid_score
								,self.DotID						:= right.DotID
								,self.DotScore				:= right.DotScore
								,self.DotWeight				:= right.DotWeight
								,self.EmpID						:= right.EmpID
								,self.EmpScore				:= right.EmpScore
								,self.EmpWeight				:= right.EmpWeight
								,self.POWID						:= right.POWID
								,self.POWScore				:= right.POWScore
								,self.POWWeight				:= right.POWWeight
								,self.ProxID					:= right.ProxID
								,self.ProxScore				:= right.ProxScore
								,self.ProxWeight			:= right.ProxWeight
								,self.SELEID					:= right.SELEID
								,self.SELEScore				:= right.SELEScore
								,self.SELEWeight			:= right.SELEWeight
								,self.OrgID						:= right.OrgID
								,self.OrgScore				:= right.OrgScore
								,self.OrgWeight				:= right.OrgWeight
								,self.UltID						:= right.UltID
								,self.UltScore				:= right.UltScore
								,self.UltWeight				:= right.UltWeight									
								,self := left)
							,left outer
							,keep(1)
							,local
							);
																
	EXPORT crash_w_lexid 	:= dedup(JoinCra,record,all);
	
	// if(not NewHeader and not pDelta
															// ,cra
															// ,dedup(JoinCra,record,all)
															// );
	JoinOff := join(
							distribute(off, hash(eid))
							,dsLexId(Prepped_rec_type = const_mod.Offenders_)
							,left.eid = right.eid
							,transform({off}
								,self.eid 						:= left.eid
								,self.lexid 					:= right.lexid
								,self.lexid_score 		:= right.lexid_score
								,self.xadl2_Weight 		:= right.xadl2_Weight
								,self.xadl2_Score 		:= right.xadl2_Score
								,self.xadl2_keys_used := right.xadl2_keys_used
								,self.xadl2_distance 	:= right.xadl2_distance
								,self.xadl2_matches 	:= right.xadl2_matches
								,self.bdid 						:= right.bdid
								,self.bdid_score 			:= right.bdid_score
								,self.DotID						:= right.DotID
								,self.DotScore				:= right.DotScore
								,self.DotWeight				:= right.DotWeight
								,self.EmpID						:= right.EmpID
								,self.EmpScore				:= right.EmpScore
								,self.EmpWeight				:= right.EmpWeight
								,self.POWID						:= right.POWID
								,self.POWScore				:= right.POWScore
								,self.POWWeight				:= right.POWWeight
								,self.ProxID					:= right.ProxID
								,self.ProxScore				:= right.ProxScore
								,self.ProxWeight			:= right.ProxWeight
								,self.SELEID					:= right.SELEID
								,self.SELEScore				:= right.SELEScore
								,self.SELEWeight			:= right.SELEWeight
								,self.OrgID						:= right.OrgID
								,self.OrgScore				:= right.OrgScore
								,self.OrgWeight				:= right.OrgWeight
								,self.UltID						:= right.UltID
								,self.UltScore				:= right.UltScore
								,self.UltWeight				:= right.UltWeight					
								,self := left)
							,left outer
							,keep(1)
							,local
							);
																
	EXPORT off_w_lexid 		:= dedup(JoinOff,record,all);
	
	// if(not NewHeader and not pDelta
														// ,off
														// ,dedup(JoinOff,record,all)
														// );	
END;