EXPORT functions_getRelationship := module

	shared getRelScore(ROW(Layout_GetRelationship.InterfaceOutput_new) le, string curRel) :=
		function
			outScore := case(curRel,
											 Constants.cohabit  					=> le.cohabit_score,
											 Constants.coapt 							=> le.coapt_score,
											 Constants.copobox 						=> le.copobox_score,
											 Constants.cossn 							=> le.cossn_score,
											 Constants.copolicy 					=> le.copolicy_score,
											 Constants.coclaim 						=> le.coclaim_score,
											 Constants.coproperty					=> le.coproperty_score,
											 Constants.bcoproperty 				=> le.bcoproperty_score,
											 Constants.coforeclosure 			=> le.coforeclosure_score,
											 Constants.bcoforeclosure 		=> le.bcoforeclosure_score,
											 Constants.colien 						=> le.colien_score,
											 Constants.bcolien 						=> le.bcolien_score,
											 Constants.cobankruptcy 			=> le.cobankruptcy_score,
											 Constants.bcobankruptcy 			=> le.bcobankruptcy_score,
											 Constants.covehicle 					=> le.covehicle_score,
											 Constants.coexperian 				=> le.coexperian_score,
											 Constants.cotransunion 			=> le.cotransunion_score,
											 Constants.coenclarity 				=> le.coenclarity_score,
											 Constants.coecrash 					=> le.coecrash_score,
											 Constants.bcoecrash 					=> le.bcoecrash_score,
											 Constants.cowatercraft 			=> le.cowatercraft_score,
											 Constants.coaircraft 				=> le.coaircraft_score,
											 Constants.comarriagedivorce 	=> le.comarriagedivorce_score,
											 Constants.coucc 							=> le.coucc_score,
											 Constants.coclue             => le.coclue_score,
											 Constants.cocc               => le.cocc_score,
											 ERROR('Missing relationship type')
											);
		return outScore;
	end;

	shared getRelCnt(ROW(Layout_GetRelationship.InterfaceOutput_new) le, string curRel) :=
		function
			outCnt := case(curRel,
										 Constants.cohabit  					=> le.cohabit_cnt,
										 Constants.coapt 							=> le.coapt_cnt,
										 Constants.copobox 						=> le.copobox_cnt,
										 Constants.cossn 							=> le.cossn_cnt,
										 Constants.copolicy 					=> le.copolicy_cnt,
										 Constants.coclaim 						=> le.coclaim_cnt,
										 Constants.coproperty					=> le.coproperty_cnt,
										 Constants.bcoproperty 				=> le.bcoproperty_cnt,
										 Constants.coforeclosure 			=> le.coforeclosure_cnt,
										 Constants.bcoforeclosure 		=> le.bcoforeclosure_cnt,
										 Constants.colien 						=> le.colien_cnt,
										 Constants.bcolien 						=> le.bcolien_cnt,
										 Constants.cobankruptcy 			=> le.cobankruptcy_cnt,
										 Constants.bcobankruptcy 			=> le.bcobankruptcy_cnt,
										 Constants.covehicle 					=> le.covehicle_cnt,
										 Constants.coexperian 				=> le.coexperian_cnt,
										 Constants.cotransunion 			=> le.cotransunion_cnt,
										 Constants.coenclarity 				=> le.coenclarity_cnt,
										 Constants.coecrash 					=> le.coecrash_cnt,
										 Constants.bcoecrash 					=> le.bcoecrash_cnt,
										 Constants.cowatercraft 			=> le.cowatercraft_cnt,
										 Constants.coaircraft 				=> le.coaircraft_cnt,
										 Constants.comarriagedivorce 	=> le.comarriagedivorce_cnt,
										 Constants.coucc 							=> le.coucc_cnt,
										 Constants.coclue             => le.coclue_cnt,
										 Constants.cocc               => le.cocc_cnt,
										 ERROR('Missing relationship type')
										);
		return outCnt;
	end;

	shared dataset(layout_output.normedRelTypeRec) getChildRecs(dataset(Layout_GetRelationship.InterfaceOutput_new) rel_in) :=
		function
			childrecs := normalize(rel_in, count(Constants.setRels),
														 transform(layout_output.normedRelTypeRec,
																			 curRel := Constants.setRels[counter];
																			 self.rel_type := curRel;
																			 self.score := getRelScore(left, curRel);
																			 self.cnt := getRelCnt(left, curRel);
																			 self := left;
																			));
		return childrecs(score <> 0 and cnt <> 0);
	end;

	export convertFlatToNeutral(dataset(Layout_GetRelationship.InterfaceOutput_new) rel_in) :=
		function
			childRecs := getChildRecs(rel_in);
			Layout_GetRelationship.interfaceOutputNeutral deNorm(Layout_GetRelationship.InterfaceOutput_new L, dataset(layout_output.normedRelTypeRec) R) :=
				transform
					self.rels := project(R, transform(layout_output.relTypeRec, self := left));
					self := L;
				end;
			dnormDS := denormalize(distribute(rel_in, hash32(did1)), distribute(childRecs, hash32(did1)),
														 left.did1 = right.did1
														 and left.did2 = right.did2,
														 GROUP,
														 deNorm(left, rows(right))
														);
		return dnormDS;
	 end;

	export convertNeutralToFlat(dataset(Layout_GetRelationship.interfaceOutputNeutral) rel_in) :=
		function
			relOut := project(rel_in,
												transform(Layout_GetRelationship.InterfaceOuput,
																	cohabitRec := left.rels(rel_type = Constants.cohabit)[1];
																	self.cohabit_score 						:= cohabitRec.score;
																	self.cohabit_cnt 							:= cohabitRec.cnt;
																	coaptRec := left.rels(rel_type = Constants.coapt)[1];
																	self.coapt_score 							:= coaptRec.score;
																	self.coapt_cnt 								:= coaptRec.cnt;
																	copoboxRec := left.rels(rel_type = Constants.copobox)[1];
																	self.copobox_score 						:= copoboxRec.score;
																	self.copobox_cnt 							:= copoboxRec.cnt;
																	cossnRec := left.rels(rel_type = Constants.cossn)[1];
																	self.cossn_score 							:= cossnRec.score;
																	self.cossn_cnt 								:= cossnRec.cnt;
																	copolicyRec := left.rels(rel_type = Constants.copolicy)[1];
																	self.copolicy_score 					:= copolicyRec.score;
																	self.copolicy_cnt 						:= copolicyRec.cnt;
																	coclaimRec := left.rels(rel_type = Constants.coclaim)[1];
																	self.coclaim_score 						:= coclaimRec.score;
																	self.coclaim_cnt 							:= coclaimRec.cnt;
																	copropertyRec := left.rels(rel_type = Constants.coproperty)[1];
																	self.coproperty_score 				:= copropertyRec.score;
																	self.coproperty_cnt 					:= copropertyRec.cnt;
																	bcopropertyRec := left.rels(rel_type = Constants.bcoproperty)[1];
																	self.bcoproperty_score 				:= bcopropertyRec.score;
																	self.bcoproperty_cnt 					:= bcopropertyRec.cnt;
																	coforeclosureRec := left.rels(rel_type = Constants.coforeclosure)[1];
																	self.coforeclosure_score 			:= coforeclosureRec.score;
																	self.coforeclosure_cnt 				:= coforeclosureRec.cnt;
																	bcoforeclosureRec := left.rels(rel_type = Constants.bcoforeclosure)[1];
																	self.bcoforeclosure_score 		:= bcoforeclosureRec.score;
																	self.bcoforeclosure_cnt 			:= bcoforeclosureRec.cnt;
																	colienRec := left.rels(rel_type = Constants.colien)[1];
																	self.colien_score 						:= colienRec.score;
																	self.colien_cnt 							:= colienRec.cnt;
																	bcolienRec := left.rels(rel_type = Constants.bcolien)[1];
																	self.bcolien_score 						:= bcolienRec.score;
																	self.bcolien_cnt 							:= bcolienRec.cnt;
																	cobankruptcyRec := left.rels(rel_type = Constants.cobankruptcy)[1];
																	self.cobankruptcy_score 			:= cobankruptcyRec.score;
																	self.cobankruptcy_cnt 				:= cobankruptcyRec.cnt;
																	bcobankruptcyRec := left.rels(rel_type = Constants.bcobankruptcy)[1];
																	self.bcobankruptcy_score 			:= bcobankruptcyRec.score;
																	self.bcobankruptcy_cnt 				:= bcobankruptcyRec.cnt;
																	covehicleRec := left.rels(rel_type = Constants.covehicle)[1];
																	self.covehicle_score 					:= covehicleRec.score;
																	self.covehicle_cnt 						:= covehicleRec.cnt;
																	coexperianRec := left.rels(rel_type = Constants.coexperian)[1];
																	self.coexperian_score 				:= coexperianRec.score;
																	self.coexperian_cnt 					:= coexperianRec.cnt;
																	cotransunionRec := left.rels(rel_type = Constants.cotransunion)[1];
																	self.cotransunion_score 			:= cotransunionRec.score;
																	self.cotransunion_cnt 				:= cotransunionRec.cnt;
																	coenclarityRec := left.rels(rel_type = Constants.coenclarity)[1];
																	self.coenclarity_score 				:= coenclarityRec.score;
																	self.coenclarity_cnt 					:= coenclarityRec.cnt;
																	coecrashRec := left.rels(rel_type = Constants.coecrash)[1];
																	self.coecrash_score 					:= coecrashRec.score;
																	self.coecrash_cnt 						:= coecrashRec.cnt;
																	bcoecrashRec := left.rels(rel_type = Constants.bcoecrash)[1];
																	self.bcoecrash_score 					:= bcoecrashRec.score;
																	self.bcoecrash_cnt 						:= bcoecrashRec.cnt;
																	cowatercraftRec := left.rels(rel_type = Constants.cowatercraft)[1];
																	self.cowatercraft_score 			:= cowatercraftRec.score;
																	self.cowatercraft_cnt 				:= cowatercraftRec.cnt;
																	coaircraftRec := left.rels(rel_type = Constants.coaircraft)[1];
																	self.coaircraft_score 				:= coaircraftRec.score;
																	self.coaircraft_cnt 					:= coaircraftRec.cnt;
																	comarriagedivorceRec := left.rels(rel_type = Constants.comarriagedivorce)[1];
																	self.comarriagedivorce_score  := comarriagedivorceRec.score;
																	self.comarriagedivorce_cnt 		:= comarriagedivorceRec.cnt;
																	couccRec := left.rels(rel_type = Constants.coucc)[1];
																	self.coucc_score 							:= couccRec.score;
																	self.coucc_cnt 								:= couccRec.cnt;
																	self := left;
																 ));
		return relOut;
	end;

	export convertNeutralToFlat_new(dataset(Layout_GetRelationship.interfaceOutputNeutral) rel_in) :=
		function
			relOut := project(rel_in,
												transform(Layout_GetRelationship.InterfaceOutput_new,
																	cohabitRec := left.rels(rel_type = Constants.cohabit)[1];
																	self.cohabit_score 						:= cohabitRec.score;
																	self.cohabit_cnt 							:= cohabitRec.cnt;
																	coaptRec := left.rels(rel_type = Constants.coapt)[1];
																	self.coapt_score 							:= coaptRec.score;
																	self.coapt_cnt 								:= coaptRec.cnt;
																	copoboxRec := left.rels(rel_type = Constants.copobox)[1];
																	self.copobox_score 						:= copoboxRec.score;
																	self.copobox_cnt 							:= copoboxRec.cnt;
																	cossnRec := left.rels(rel_type = Constants.cossn)[1];
																	self.cossn_score 							:= cossnRec.score;
																	self.cossn_cnt 								:= cossnRec.cnt;
																	copolicyRec := left.rels(rel_type = Constants.copolicy)[1];
																	self.copolicy_score 					:= copolicyRec.score;
																	self.copolicy_cnt 						:= copolicyRec.cnt;
																	coclaimRec := left.rels(rel_type = Constants.coclaim)[1];
																	self.coclaim_score 						:= coclaimRec.score;
																	self.coclaim_cnt 							:= coclaimRec.cnt;
																	copropertyRec := left.rels(rel_type = Constants.coproperty)[1];
																	self.coproperty_score 				:= copropertyRec.score;
																	self.coproperty_cnt 					:= copropertyRec.cnt;
																	bcopropertyRec := left.rels(rel_type = Constants.bcoproperty)[1];
																	self.bcoproperty_score 				:= bcopropertyRec.score;
																	self.bcoproperty_cnt 					:= bcopropertyRec.cnt;
																	coforeclosureRec := left.rels(rel_type = Constants.coforeclosure)[1];
																	self.coforeclosure_score 			:= coforeclosureRec.score;
																	self.coforeclosure_cnt 				:= coforeclosureRec.cnt;
																	bcoforeclosureRec := left.rels(rel_type = Constants.bcoforeclosure)[1];
																	self.bcoforeclosure_score 		:= bcoforeclosureRec.score;
																	self.bcoforeclosure_cnt 			:= bcoforeclosureRec.cnt;
																	colienRec := left.rels(rel_type = Constants.colien)[1];
																	self.colien_score 						:= colienRec.score;
																	self.colien_cnt 							:= colienRec.cnt;
																	bcolienRec := left.rels(rel_type = Constants.bcolien)[1];
																	self.bcolien_score 						:= bcolienRec.score;
																	self.bcolien_cnt 							:= bcolienRec.cnt;
																	cobankruptcyRec := left.rels(rel_type = Constants.cobankruptcy)[1];
																	self.cobankruptcy_score 			:= cobankruptcyRec.score;
																	self.cobankruptcy_cnt 				:= cobankruptcyRec.cnt;
																	bcobankruptcyRec := left.rels(rel_type = Constants.bcobankruptcy)[1];
																	self.bcobankruptcy_score 			:= bcobankruptcyRec.score;
																	self.bcobankruptcy_cnt 				:= bcobankruptcyRec.cnt;
																	covehicleRec := left.rels(rel_type = Constants.covehicle)[1];
																	self.covehicle_score 					:= covehicleRec.score;
																	self.covehicle_cnt 						:= covehicleRec.cnt;
																	coexperianRec := left.rels(rel_type = Constants.coexperian)[1];
																	self.coexperian_score 				:= coexperianRec.score;
																	self.coexperian_cnt 					:= coexperianRec.cnt;
																	cotransunionRec := left.rels(rel_type = Constants.cotransunion)[1];
																	self.cotransunion_score 			:= cotransunionRec.score;
																	self.cotransunion_cnt 				:= cotransunionRec.cnt;
																	coenclarityRec := left.rels(rel_type = Constants.coenclarity)[1];
																	self.coenclarity_score 				:= coenclarityRec.score;
																	self.coenclarity_cnt 					:= coenclarityRec.cnt;
																	coecrashRec := left.rels(rel_type = Constants.coecrash)[1];
																	self.coecrash_score 					:= coecrashRec.score;
																	self.coecrash_cnt 						:= coecrashRec.cnt;
																	bcoecrashRec := left.rels(rel_type = Constants.bcoecrash)[1];
																	self.bcoecrash_score 					:= bcoecrashRec.score;
																	self.bcoecrash_cnt 						:= bcoecrashRec.cnt;
																	cowatercraftRec := left.rels(rel_type = Constants.cowatercraft)[1];
																	self.cowatercraft_score 			:= cowatercraftRec.score;
																	self.cowatercraft_cnt 				:= cowatercraftRec.cnt;
																	coaircraftRec := left.rels(rel_type = Constants.coaircraft)[1];
																	self.coaircraft_score 				:= coaircraftRec.score;
																	self.coaircraft_cnt 					:= coaircraftRec.cnt;
																	comarriagedivorceRec := left.rels(rel_type = Constants.comarriagedivorce)[1];
																	self.comarriagedivorce_score  := comarriagedivorceRec.score;
																	self.comarriagedivorce_cnt 		:= comarriagedivorceRec.cnt;
																	couccRec := left.rels(rel_type = Constants.coucc)[1];
																	self.coucc_score 							:= couccRec.score;
																	self.coucc_cnt 								:= couccRec.cnt;
																	coclueRec := left.rels(rel_type = Constants.coclue)[1];
																	self.coclue_score 							:= coclueRec.score;
																	self.coclue_cnt 								:= coclueRec.cnt;
																	coccRec := left.rels(rel_type = Constants.cocc)[1];
																	self.cocc_score 							:= coccRec.score;
																	self.cocc_cnt 								:= coccRec.cnt;
																	self := left;
																 ));
		return relOut;
	end;

end;