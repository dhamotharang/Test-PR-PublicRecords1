﻿IMPORT Header, FraudShared, ut;
//1.Send main dataset to append lexid
EXPORT Append_RingID(DATASET(FraudShared.Layouts.Base.Main) FileBase) := FUNCTION
	
	// 2.Take new records w/o a lexid and join them to previous main file (AKA ringid, flexid, no match id)
	previous_base 	:= distribute(FraudShared.Files().Base.Main.built, hash32(record_id));
	building_base := distribute(FileBase, hash32(record_id));
	
	// 3.Where there is a match in #2 transfer the previous RingID over to the record w/o a lexid
	
	building_base_with_previous_ringids := join (
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
	FirstRingID := FraudGovPlatform.Constants().FirstRingID;
	LastRingID := FraudGovPlatform.Functions.LastRingID;
	
	seed:= if (LastRingID > 0 , LastRingID, FirstRingID);
	
	building_base_without_ringids := building_base_with_previous_ringids(DID=0);
	
	MAC_Sequence_Records(	building_base_without_ringids, did,	building_base_with_new_ringids, seed);	

	
	building_base_all_ringids := 	project(building_base_with_previous_ringids(DID >= FirstRingID)	,FraudShared.Layouts.Base.Main)
												+	project(building_base_with_new_ringids											,FraudShared.Layouts.Base.Main) ;

	//5.send all records with a RingID to be matched and collapsed
	mtchs:= Mod_Collisions( building_base_all_ringids ).matches;
	pairs:=table(mtchs,{new_rid,old_rid});
	Header.MAC_ApplyDid1( building_base_all_ringids  ,DID, pairs, outfile);

	//6.combine records with a real lexid and a flexid into one main base file
	building_base_RingIDs := 	project(building_base_with_previous_ringids(did > 0 and did < FirstRingID),FraudShared.Layouts.Base.Main) 
										+ project(outfile,FraudShared.Layouts.Base.Main) ;


	RETURN building_base_RingIDs;

END;

