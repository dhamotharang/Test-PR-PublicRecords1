import address,did_add, ut, header_slimsort,didville;

did_regression.layout_common bdids(did_regression.layout_common l) := transform
	self.did := 0;
	self.did_score := 0;
	self := l;
end;

common_in := project(did_regression.common_prep, bdids(left));

matchset := ['S','D','A','P','4','G','Z'];

did_add.MAC_Match_Flex
	(common_in, matchset,						
	 ssn, dob, fname, mname, lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10,
	 DID,   			
	 did_regression.layout_common, 
	 true, DID_Score, 	
	 0,	
	 common_wdid,
	 true, true, did_score_address, did_score_dob, did_score_ssn, did_score_phone,did_score_fuzzy,
	 true)

export common_did := common_wdid; //persist('~common_did', '400way');