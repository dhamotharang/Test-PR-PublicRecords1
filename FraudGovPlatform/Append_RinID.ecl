IMPORT Header, FraudShared, ut;
//1.Send main dataset to append lexid
EXPORT Append_RinID(DATASET(FraudShared.Layouts.Base.Main) FileBase) := FUNCTION
	
	// 2.Take new records w/o a lexid and join them to previous main file (AKA rinid, flexid, no match id)
	Previous_Build := FraudShared.Files().Base.Main.built;
	
	previous_base 	:= distribute(pull(Previous_Build), hash32(record_id)) ;
	building_base := distribute(pull(FileBase), hash32(record_id));
	
	// 3.Where there is a match in #2 transfer the previous RinID over to the record w/o a lexid
	
	building_base_with_previous_rinids := join (
		previous_base,
		building_base,
		left.record_id = right.record_id,
		transform(FraudShared.Layouts.Base.Main,
			self.did:= if(left.record_id=right.record_id, left.did, right.did);
			self.did_score:= if(left.record_id=right.record_id, left.did_score, right.did_score);
			self := right),
		RIGHT OUTER,
		LOCAL
	);
	
	//4.sequence those records in #2 that did not match anything in #3
	FirstRinID := FraudGovPlatform.Constants().FirstRinID;
	LastRinID := FraudGovPlatform.Functions.LastRinID;

	seed:= if (LastRinID > 0 , LastRinID+1, FirstRinID);
	
	building_base_without_rinids := building_base_with_previous_rinids(DID=0);
	
	MAC_Sequence_Records(	building_base_without_rinids, did,	building_base_with_new_rinids, seed);
	
	building_base_all_rinids := 	building_base_with_previous_rinids(DID >= FirstRinID)												
												+	project(building_base_with_new_rinids,FraudShared.Layouts.Base.Main);
	
	//5.send all records with a RinID to be matched and collapsed
	mtchs:= Mod_Collisions( building_base_all_rinids ).matches;
  	//output(breakdown matchset)
	pairs:=table(mtchs,{new_rid,old_rid});
	Header.MAC_ApplyDid1( building_base_all_rinids  ,DID, pairs, outfile);

	//6.combine records with a real lexid and a flexid into one main base file
	building_base_RinIDs := 	building_base_with_previous_rinids(did > 0 and did < FirstRinID)
										+ outfile ;

	RETURN building_base_RinIDs;

END;

