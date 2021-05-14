import Nid, Std, Address, did_add, BIPV2, business_header, business_header_ss, ut;


EXPORT proc_createExecutives(dataset(Cortera.Layout_Header_Out) hdr) := FUNCTION

		Cortera.Layout_Executives xNames(Cortera.Layout_Header_Out src, integer n)  := TRANSFORM,
			skip(n = 1 and trim(src.EXECUTIVE_NAME1) = '' or
					 n = 2 and trim(src.EXECUTIVE_NAME2) = '' or
					 n = 3 and trim(src.EXECUTIVE_NAME3) = '' or
					 n = 4 and trim(src.EXECUTIVE_NAME4) = '' or
					 n = 5 and trim(src.EXECUTIVE_NAME5) = '' or
					 n = 6 and trim(src.EXECUTIVE_NAME6) = '' or
					 n = 7 and trim(src.EXECUTIVE_NAME7) = '' or
					 n = 8 and trim(src.EXECUTIVE_NAME8) = '' or
					 n = 9 and trim(src.EXECUTIVE_NAME9) = '' or
					 n = 10 and trim(src.EXECUTIVE_NAME10) = ''
					)
			pname := Std.Str.ToUpperCase(CHOOSE(n,
																					src.EXECUTIVE_NAME1,
																					src.EXECUTIVE_NAME2,
																					src.EXECUTIVE_NAME3,
																					src.EXECUTIVE_NAME4,
																					src.EXECUTIVE_NAME5,
																					src.EXECUTIVE_NAME6,
																					src.EXECUTIVE_NAME7,
																					src.EXECUTIVE_NAME8,
																					src.EXECUTIVE_NAME9,
																					src.EXECUTIVE_NAME10)
																	);

			self.EXECUTIVE_NAME := pname;
			self.EXEC_TITLE := CHOOSE(n,
																src.TITLE1,
																src.TITLE2,
																src.TITLE3,
																src.TITLE4,
																src.TITLE5,
																src.TITLE6,
																src.TITLE7,
																src.TITLE8,
																src.TITLE9,
																src.TITLE10);
			self.cnt := n;
			self.persistent_record_id := ((unsigned8)src.link_id << 32) | HASH32(src.name, pname);
			self := SRC;
		END;

		names := NORMALIZE(hdr, 10, xNames(left, COUNTER)) : INDEPENDENT;
		
		cleanable := names(EXECUTIVE_NAME<>'');

		clean := Nid.fn_CleanFullNames(cleanable, EXECUTIVE_NAME, useV2 := true) : INDEPENDENT;

		matchset := ['A', 'P', 'Z'];

		linkable := PROJECT(clean(cln_fname<>'', cln_lname<>''), Cortera.Layout_Executives); 

		did_add.MAC_Match_Flex
			(linkable, matchset,
			 '', '', cln_fname, cln_mname, cln_lname, cln_suffix, 
			 prim_range, prim_name, sec_range, zip, st, clean_phone, 
			 LexId, Cortera.Layout_Executives, true, LexId_Score,
			 75, linked);
			 
		return  linked + names(EXECUTIVE_NAME='') + PROJECT(clean(cln_fname='' OR cln_lname=''), Cortera.Layout_Executives);
    
END;