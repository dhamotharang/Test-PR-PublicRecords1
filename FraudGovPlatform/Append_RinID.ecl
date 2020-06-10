﻿IMPORT Header, FraudShared, ut, STD,FraudGovPlatform_Validation,_Validate;
//1.Send main dataset to append lexid
EXPORT Append_RinID(
	dataset(FraudShared.Layouts.Base.Main) FileBase
    ,dataset(FraudShared.Layouts.Base.Main) Previous_Build = FraudShared.Files().Base.Main.QA 
) := FUNCTION

	FirstRinID := FraudGovPlatform.Constants().FirstRinID;
	LastRinID := FraudGovPlatform.Functions.LastRinID;

	// 2.Take new records w/o a lexid and join them to previous main file (AKA rinid, flexid, no match id)
	
	previous_base := distribute(pull(Previous_Build), hash32(record_id)) ;
	building_base := distribute(pull(FileBase), hash32(record_id));

	// 3.Where there is a match in #2 transfer the previous RinID over to the record w/o a lexid
	
	J_previous_did := join (
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

	without_did 	:= J_previous_did(DID=0);	
	with_lexid 		:= J_previous_did(DID > 0 and DID < FirstRinID);
	with_rinid 	:= J_previous_did(DID >= FirstRinID);

	shared with_pii := without_did
		(   
			(raw_first_name !='' and raw_last_name !='' and 
				_Validate.Date.fIsValid(dob) and (unsigned)dob <= (unsigned)(STRING8)Std.Date.Today() and	dob != '' and dob != '00000000' and
				(length(STD.Str.CleanSpaces(ssn))=9 and regexfind('^[0-9]*$',STD.Str.CleanSpaces(ssn)) =true ))
				
			or

		(
			(raw_first_name !='' and raw_last_name !='' and
				_Validate.Date.fIsValid(dob) and (unsigned)dob <= (unsigned)(STRING8)Std.Date.Today() and	dob != '' and dob != '00000000' and clean_address.prim_range != '' and clean_address.prim_name != '') and 
				(
					(clean_address.v_city_name != '' and clean_address.st != '')
					or
					(clean_address.zip != '')
				)
		));

	//4.sequence those records in #2 with pii that did not match anything in #3
	seed:= if (LastRinID > 0 , LastRinID+1, FirstRinID);
	MAC_Sequence_Records(	with_pii, did,	new_rinid_sequences, seed);
	
	all_rinids := 	with_rinid	+	project(new_rinid_sequences,FraudShared.Layouts.Base.Main);
	
	//5.send all records with a RinID to be matched and collapsed
	mtchs:= Mod_Collisions( all_rinids ).matches;
  	//output(breakdown matchset)
	pairs:=table(mtchs,{new_rid,old_rid});
	Header.MAC_ApplyDid1( all_rinids  ,DID, pairs, new_rinids);


	without_pii 
		:= join(
				without_did,
				with_pii,
				left.record_id = right.record_id,
				only left,
				local
		);
	
	//6.combine records with a real lexid and a flexid into one main base file
	RinIDs :=	with_lexid + 
				without_pii + 
				new_rinids;

	RETURN RinIDs;

END;