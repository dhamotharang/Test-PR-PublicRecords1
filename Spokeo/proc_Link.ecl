import did_add;



matchset := ['A', 'P', 'Z', 'D'];
matchset2 := ['A', 'P', 'Z'];
EXPORT proc_Link(dataset(Spokeo.Layout_temp) basein) := FUNCTION

			linkable := basein(nametype in ['P','D']);

			did_add.MAC_Match_Flex
				(linkable, matchset,
				 '', dob, fname, mname, lname, name_suffix, 
				 prim_range, prim_name, sec_range, zip, st, phone, 
				 LexId, Spokeo.Layout_temp, true, score,
				 75, withDid);

			noid := withDid(LexId=0);

			did_add.MAC_Match_Flex
				(noid, matchset,
				 '', dob, fname, mname, lname, name_suffix, 
				 prim_range, prim_name, sec_range, zip, st, phone, 
				 LexId, Spokeo.Layout_temp, true, score,
				 75, lowDid, distance := 0);

			noid2 := lowDid(LexId=0);

			did_add.MAC_Match_Flex
				(noid2, matchset2,			// try without DOB
				 '', dob, fname, mname, lname, name_suffix, 
				 prim_range, prim_name, sec_range, zip, st, phone, 
				 LexId, Spokeo.Layout_temp, true, score,
				 75, nodob, distance := 0);

				 
			linked := PROJECT(nodob, transform(Spokeo.Layout_temp,
									self.Lexid_score := if(left.LexId=0,'','LOW');
									self := left;))
							+ 
					PROJECT(lowDid(LexId<>0), transform(Spokeo.Layout_temp,
									self.Lexid_score := if(left.LexId=0,'','LOW');
									self := left;))
							+
					PROJECT(withDid(LexId<>0), transform(Spokeo.Layout_temp,
									self.Lexid_score := if(left.LexId=0,'',Intformat(left.score,3,1));
									self := left;)) +
					basein(nametype not in ['P','D']);
									
//			didville.MAC_HHID_Append_By_Address(
//					linked, result, hhid, lname,
//					prim_range, prim_name, sec_range, st, zip);	

			result := Spokeo.Fn_Append_HHId(linked);
			
		return result;

END;