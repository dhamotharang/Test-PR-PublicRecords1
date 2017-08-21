import didville;

export Fn_Append_HHId(DATASET(Spokeo.Layout_temp) src) := function

		r1 := RECORD
			Spokeo.Layout_temp;
			unsigned6	did;
		END;

		src1 := PROJECT(src, TRANSFORM(r1,
						self.did := left.LexId;
						self.hhid := 0;
						self := left;));

		//----Append HHID for recs with and without did
		with_did 		:= src1(did <> 0);
		without_did	:= src1(did = 0);


		didville.MAC_HHID_Append(with_did, 
									'HHID_RELATIVES', 
									Append_HHID2,
									true);

		didville.MAC_HHID_Append_By_Address(
									without_did, 
									Append_HHID1, 
									hhid, 
									lname,
									prim_range, 
									prim_name, 
									sec_range, 
									st, 
									zip);
									
		result := PROJECT(Append_HHID1+Append_HHID2, spokeo.Layout_Temp);
		return result;
END;
