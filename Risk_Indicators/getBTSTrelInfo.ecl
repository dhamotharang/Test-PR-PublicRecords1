/*
Used in the BTST shell
returns information about the relative that is within the other*/

import doxie, riskwise, relationship;

export getBTSTrelInfo(grouped DATASET(Layout_CIID_BtSt_Output) indata) := FUNCTION

	Layout_CBD_Relatives := RECORD
		unsigned4 seq;
		unsigned bill_to_output_did;
		unsigned ship_to_output_did;
		dataset(doxie.layout_references) bt_relatives;
		dataset(doxie.layout_references) st_relatives;
		dataset(doxie.layout_references) common_relatives;
		boolean billto_shipto_are_relative;
		boolean billto_shipto_share_common_relatives;
		unsigned1 btst_closest_association := 0;
		Risk_Indicators.Layout_BocaShell_BtSt.relative_rec;
		boolean isRelative;
	END;

	rellyLayout := record
		unsigned4 seq;
		unsigned6 did1;
		unsigned6 did2;
		string15 type;
		boolean   isRelative;
		boolean   isAssociate;
		string10 confidence;
		Relationship.layout_GetRelationship.InterfaceOutput_new;
	end;

	max_relatives := 15;

	indata_ungrpd:=ungroup(indata);
	//bill to
	indata_ungrpd_bt := dedup(sort(indata_ungrpd,bill_to_output.did), bill_to_output.did);
	justBTDids := PROJECT(indata_ungrpd_bt(bill_to_output.did<>0), 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.did := LEFT.bill_to_output.DID));
	rellyids := Relationship.proc_GetRelationshipNeutral(justBTDids,TopNCount:=100,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result; 
	//gets relatives for the bill to did
	bt_rel := join(indata, rellyids, 
									left.bill_to_output.did<>0 and 
									right.did1=left.bill_to_output.did,
							transform(Layout_CBD_Relatives,	
													self.seq := left.bill_to_output.seq,
													self.bt_relatives := dataset([right.did2],doxie.layout_references);
													self.bill_to_output_did := left.bill_to_output.did,
													self.ship_to_output_did := left.ship_to_output.did,
													self := left,
													self := []), left outer);

	//ship to
	indata_ungrpd_st := dedup(sort(indata_ungrpd,ship_to_output.did), ship_to_output.did);											
	justSTDids := PROJECT(indata_ungrpd_st(ship_to_output.did<>0), 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.did := LEFT.ship_to_output.DID));
	rellyids_st_neutral := Relationship.proc_GetRelationshipNeutral(justSTDids,TopNCount:=100,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result; 	
	rellyids_st := Relationship.functions_getRelationship.convertNeutralToFlat_new(rellyids_st_neutral);
	//gets the relatives for the ship to did
	st_rel := join(indata, rellyids_st, 
									left.ship_to_output.did<>0 and 
									right.did1=left.ship_to_output.did,
							transform(Layout_CBD_Relatives,	
													self.seq := left.bill_to_output.seq,
													self.st_relatives := dataset([right.did2],doxie.layout_references);
													self := left,
													self := []), left outer);
 //gets the ship to relatives
	st_rel2 := join(indata, rellyids_st, 
									left.ship_to_output.did<>0 and 
									right.did1=left.ship_to_output.did,
							transform(rellyLayout,	
													self.seq := left.bill_to_output.seq,
													self.did1 := left.ship_to_output.did,
													self := right;
													self := []), left outer);
//get the info where the bt info is in the st relative info
	bt_TypeOfRelly := join(bt_rel, st_rel2,
		left.seq = right.seq and left.bill_to_output_did = right.did2,
		transform(Layout_CBD_Relatives,	
				self.btst_association_type := right.type;
				self.btst_association_confidence := right.confidence;
				self.btst_cohabit_cnt := right.cohabit_cnt;
				self.btst_overlap_mths := right.overlap_months;
				self.btst_any_lname_match := right.isanylnamematch;
				self.btst_any_phone_match := right.isanyphonematch;
				self.btst_early_lname_match := right.isearlylnamematch;
				self.btst_curr_lname_match := right.iscurrlnamematch;
				self.btst_mixed_lname_match := right.ismixedlnamematch;
				self.btst_personal_association := right.personal;
				self.btst_business_association := right.business;
				self.btst_other_association := right.other;
				self.btst_st_relation_to_bt := right.title;
				self.btst_st_associate_or_relative := right.title_type;
				self.btst_st_isbusiness := right.isbusiness;
				self.isrelative := right.isrelative;
				self := left;),
			left outer);

	Layout_CBD_Relatives cat_relatives(Layout_CBD_Relatives le, Layout_CBD_Relatives rt) := transform
		self.bt_relatives := le.bt_relatives + rt.bt_relatives;
		self.st_relatives := le.st_relatives + rt.st_relatives;
		self.btst_association_type := le.btst_association_type;
		self.btst_association_confidence := le.btst_association_confidence;
		self.btst_cohabit_cnt := le.btst_cohabit_cnt;
		self.btst_overlap_mths := le.btst_overlap_mths;
		self.btst_any_lname_match := le.btst_any_lname_match;
		self.btst_any_phone_match := le.btst_any_phone_match;
		self.btst_early_lname_match := le.btst_early_lname_match;
		self.btst_curr_lname_match := le.btst_curr_lname_match;
		self.btst_mixed_lname_match := le.btst_mixed_lname_match;
		self.btst_personal_association := le.btst_personal_association;
		self.btst_business_association := le.btst_business_association;
		self.btst_other_association := le.btst_other_association;
		self.btst_st_relation_to_bt := le.btst_st_relation_to_bt;
		self.btst_st_associate_or_relative := le.btst_st_associate_or_relative;
		self.btst_st_isbusiness := le.btst_st_isbusiness;	
		self.isrelative := le.isrelative;
		self := le;
	end;

	bt_TypeOfRelly_srtd := SORT(bt_TypeOfRelly, seq, bill_to_output_did, isrelative, 
		MAP(btst_association_type = 'PERSONAL'=> 1, 
				btst_association_type = 'MEDIUM' => 2,
				btst_association_type = 'TRANS CLOSURE' => 3,
				4));
	rolled_bt := rollup(bt_TypeOfRelly_srtd, left.seq = right.seq, cat_relatives(left, right));
	rolled_st := rollup(st_rel, left.seq = right.seq, cat_relatives(left, right));

	j := join(rolled_bt, rolled_st, 
				left.seq=right.seq,
					transform(Layout_CBD_Relatives,
											self.billto_shipto_are_relative := LEFT.ship_to_output_did <> 0 AND 
											left.ship_to_output_did in set(left.bt_relatives, did);
											common_rels := join(left.bt_relatives, right.st_relatives, 
												LEFT.did <> 0 AND left.did=right.did,
											transform(doxie.layout_references, self.did := left.did));
												self.billto_shipto_share_common_relatives := count(common_rels) > 0;
												self.bt_relatives := left.bt_relatives;
												self.st_relatives := right.st_relatives;
												self.common_relatives := common_rels;
												self.btst_closest_association := left.btst_closest_association;
												self.btst_association_confidence := left.btst_association_confidence;
												self.btst_cohabit_cnt := left.btst_cohabit_cnt;
												self.btst_overlap_mths := left.btst_overlap_mths;
												self.btst_any_lname_match := left.btst_any_lname_match;
												self.btst_any_phone_match := left.btst_any_phone_match;
												self.btst_early_lname_match := left.btst_early_lname_match;
												self.btst_curr_lname_match := left.btst_curr_lname_match;
												self.btst_mixed_lname_match := left.btst_mixed_lname_match;
												self.btst_personal_association := left.btst_personal_association;
												self.btst_business_association := left.btst_business_association;
												self.btst_other_association := left.btst_other_association;
												self.btst_st_relation_to_bt := left.btst_st_relation_to_bt;
												self.btst_st_associate_or_relative := left.btst_st_associate_or_relative;
												self.btst_st_isbusiness := left.btst_st_isbusiness;	
												self := left
											), left outer);
		//output debugs
		// output(st_rel2, named('st_rel2'));
		// output(st_rel, named('st_rel'));
		// output(bt_rel, named('bt_rel'));
		// output(bt_TypeOfRelly, named('bt_TypeOfRelly'));
		// output(rolled_bt, named('rolled_bt'));
	  // output(rolled_st, named('rolled_st'));
		// output(j, named('j'));
		// output(rellyids_st, named('rellyids_st'));
		// output(bt_TypeOfRelly_srtd, named('bt_TypeOfRelly_srtd'));
		// output(rellyids_st);
return j;

END;