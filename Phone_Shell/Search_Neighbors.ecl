/* ************************************************************************
 * This function searches Neighbors by:																		*
 * - Address :: Source: NE																								*
 **************************************************************************
 * This code is directly adapted from progressive_phone.mac_get_type_h    *
 ************************************************************************ */

IMPORT Address, Doxie, Gong, NID, Phone_Shell, Progressive_Phone, RiskWise, UT;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Neighbors (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 PhoneRestrictionMask, STRING50 DataRestrictionMask, UNSIGNED1 GLBPurpose, UNSIGNED1 DPPAPurpose, UNSIGNED3 Max_Neighborhoods = 0, Neighbors_Per_NA = 6, Neighbor_Recency = 3, BOOLEAN probation_override_value = FALSE, BOOLEAN no_scrub = FALSE, STRING ssn_mask_value = '', STRING industry_class_value = '') := FUNCTION
	Subj_Best_Rec := RECORD
		UNSIGNED4 seq := 0;
		Doxie.Layout_Best;
	END;
	
	glb_ok := ut.glb_ok(GLBPurpose);
	dppa_ok := ut.dppa_ok(DPPAPurpose);
	
	ds_InputFiltered := Input(Clean_Input.DID <> 0);
	doxie.mac_best_records(ds_InputFiltered,
												 did,
												 outfile,
												 dppa_ok,
												 glb_ok, 
												 ,
												 DataRestrictionMask);

	Subj_Best_Rec get_Subj_Best_All(Input le, outfile ri) := TRANSFORM
		SELF.seq := le.Clean_Input.Seq;
		SELF.DID := le.Clean_Input.DID;
		SELF := ri;
		SELF := [];
	END;
	
	subj_Best := JOIN(ds_InputFiltered, outfile,
														LEFT.Clean_Input.DID = RIGHT.DID,
											get_Subj_Best_All(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	
	Doxie.layout_nbr_targets get_neighbor_best_init(subj_Best le) := TRANSFORM
		SELF.seqTarget := le.seq;
		SELF.dt_last_seen := le.addr_dt_last_seen;
		SELF := le;
		SELF := [];
	END;
	
	best_neighbor_init := PROJECT(subj_best, get_neighbor_best_init(LEFT)) (TRIM(prim_name) <> '');
	
	Doxie.layout_nbr_targets get_neighbor_in_init(Input le) := TRANSFORM
		SELF.seqTarget := le.Clean_Input.seq;
		SELF.prim_range := le.Clean_Input.prim_range;
		SELF.predir := le.Clean_Input.predir;
		SELF.prim_name := le.Clean_Input.Prim_Name;
		SELF.suffix := le.Clean_Input.Addr_Suffix;
		SELF.postdir := le.Clean_Input.Postdir;
		SELF.Sec_Range := le.Clean_Input.Sec_Range;
		SELF.zip := le.Clean_Input.Zip5;
		
		SELF := le;
		SELF := [];
	END;
	in_neighbor_init := PROJECT(Input, get_neighbor_in_init(LEFT)) (TRIM(prim_name) <> '');
	
	Doxie.Layout_nbr_Targets get_in_only(in_neighbor_init le) := TRANSFORM
		SELF := le;
	END;
	
	both_neighbor_init := JOIN(in_neighbor_init, best_neighbor_init,
																				LEFT.seqTarget = RIGHT.seqTarget,
																	get_in_only(LEFT), LEFT ONLY) + best_neighbor_init;
																	
	neighbors_raw := Doxie.nbr_records(both_neighbor_init,
																			'C', // Mode
																			Max_Neighborhoods,
																			10, // NPA
																			Neighbors_Per_NA,
																			Neighbor_Recency,
																			Industry_Class_Value,
																			GLBPurpose,
																			DPPAPurpose,
																			Probation_Override_Value,
																			no_scrub,
																			glb_ok,
																			dppa_ok,
																			SSN_Mask_Value,
																			FALSE, // Use_Max_Neighborhoods
																			FALSE, // Switch_TargetSeq
																			10, // Proximity_Radius
																			FALSE); // Check RNA
																			// Treat as subject because the header rows are only being used to look up phone rows and it will not be returned otherwise

	neighbor_with_rank_rec := RECORD
		Doxie.Layout_nbr_records;
		UNSIGNED8 nbr_rank := 0;
	END;
	
	neighbor_with_rank_rec get_neighbor_rank(neighbors_raw le, UNSIGNED8 cnt) := TRANSFORM
		SELF.nbr_rank := cnt;
		SELF := le;
	END;
	
	neighbors_with_rank := PROJECT(neighbors_raw, get_neighbor_rank(LEFT, COUNTER));
	
	neighbors_ready := GROUP(SORT(neighbors_with_rank, seqTarget, nbr_rank), seqTarget);
	
	neighbors := TOPN(neighbors_ready, 100, nbr_rank);
	
	Progressive_Phone.Layout_Progressive_Batch_Out_With_DID by_addr_lastname(neighbors le, Gong.key_Address_current ri) := TRANSFORM
		SELF.AcctNo := (STRING20)le.seqTarget;
		SELF.Subj_First := le.fname;
		SELF.Subj_Middle := le.mname;
		SELF.Subj_Last := le.lname;
		SELF.Subj_Suffix := le.name_suffix;
		SELF.Subj_Phone10 := ri.phone10;
		SELF.Subj_Name_Dual := ri.listed_name;
		SELF.Subj_Phone_Type := '8';
		SELF.Subj_Date_First := (STRING8)le.dt_first_seen;
		SELF.Subj_Date_Last := (STRING8)le.dt_last_seen;
		SELF.Subj_Phone_Date_Last := '';
		// Note that generally phone can have more than one type:
		SELF.Phpl_Phones_Plus_Type := MAP(ri.listing_type & Gong.Constants.PTYPE.RESIDENTIAL = Gong.Constants.PTYPE.RESIDENTIAL	=> 'R',
                                      ri.listing_type & Gong.Constants.PTYPE.BUSINESS    = Gong.Constants.PTYPE.BUSINESS		=> 'B',
                                      ri.listing_type & Gong.Constants.PTYPE.GOVERNMENT  = Gong.Constants.PTYPE.GOVERNMENT	=> 'G',
																																																																'');
		SELF.did := le.did;
		SELF.Sort_Order_Internal := le.nbr_rank;
		STRING182 addr := ri.prim_range + ' ' + ri.predir + ' ' + ri.prim_name + ' ' + ri.suffix + ' ' + ri.sec_range;
		clean := Address.CleanAddressFieldsFips(Address.CleanAddress182(addr, ri.z5));
		SELF.prim_range := clean.prim_range;
		SELF.predir := clean.predir;
		SELF.prim_name := clean.prim_name;
		SELF.addr_suffix := clean.addr_suffix;
		SELF.postdir := clean.postdir;
		SELF.unit_desig := clean.unit_desig;
		SELF.sec_range := clean.sec_range;
		SELF.p_city_name := clean.p_city_name;
		SELF.v_city_name := clean.v_city_name;
		SELF.st := clean.st;
		SELF.zip5 := clean.zip;
		SELF.sub_rule_number := 81;
		SELF := [];
	END;
	
	neighbor_out_ready := JOIN(neighbors, Gong.key_Address_current,
																							KEYED(LEFT.prim_name = RIGHT.prim_name) AND
																							KEYED(LEFT.st = RIGHT.st) AND
																							KEYED(LEFT.zip = RIGHT.z5) AND
																							KEYED(LEFT.prim_range = RIGHT.prim_range) AND
																							TRIM(RIGHT.phone10) <> '' AND
																							(LEFT.lname = RIGHT.lname OR
																							(LENGTH(TRIM(LEFT.lname)) > 6 and LENGTH(TRIM(RIGHT.lname)) > 6 AND 
																							StringLib.EditDistance(LEFT.lname, RIGHT.lname) < 2) OR
																							(LENGTH(TRIM(LEFT.lname)) > 4 AND 
																							LEFT.lname = RIGHT.listed_name[1..LENGTH(TRIM(LEFT.lname))]) OR 
																							(StringLib.StringFind(RIGHT.lname, '-' + TRIM(LEFT.lname), 1) > 0 OR 
																							StringLib.StringFind(RIGHT.lname, TRIM(LEFT.lname) + '-', 1) > 0) OR  
																							LEFT.fname = RIGHT.fname AND 
																							(StringLib.EditDistance(LEFT.lname, RIGHT.lname) < 2 OR
																							LENGTH(TRIM(LEFT.lname)) > 5 AND 
																							StringLib.EditDistance(LEFT.lname, RIGHT.lname) < 3)) AND
																							(LEFT.sec_range = '' OR LEFT.sec_range = RIGHT.sec_range OR
																							NID.mod_PFirstTools.PFLeqPFR(LEFT.fname, RIGHT.fname) OR 
																							LENGTH(TRIM(RIGHT.fname)) = 1 AND LEFT.fname[1] = RIGHT.fname),					          
		                         by_addr_lastname(LEFT, RIGHT), LIMIT(ut.limits.PHONE_PER_PERSON, SKIP));
														 
	neighbor_out_dedup := UNGROUP(DEDUP(SORT(neighbor_out_ready, AcctNo, Subj_Phone10, -subj_date_last, -subj_date_first),
																															 AcctNo, Subj_Phone10));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSkipTrace(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Progressive_Phone.layout_progressive_batch_out_with_did ri) := TRANSFORM
	
		SELF.Gathered_Phone := ri.subj_phone10;
		
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.Subj_First,						ri.Subj_Last, 						'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.P_City_Name,			ri.St,								ri.Zip5,						 '',												 ri.SSN,						 ri.DID, ri.subj_phone10);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.Subj_Last), 'NE', '');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_first);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_last);
		
		// The neighbor level should always be a Lead To Subject
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject;
	
		SELF.Sources.Source_Owner_Name_First := ri.subj_first;
		SELF.Sources.Source_Owner_Name_Middle	:= ri.subj_middle;
		SELF.Sources.Source_Owner_Name_Last := ri.subj_last;
		SELF.Sources.Source_Owner_Name_Suffix := ri.subj_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		// Neighbor search... only results in neighbors
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := 'Neighbor';

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;

		SELF := le;
	END;
	withNeighbors := JOIN(Input, neighbor_out_dedup, (STRING)LEFT.Clean_Input.seq = RIGHT.AcctNo, getSkipTrace(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');
	
	final := DEDUP(SORT(withNeighbors, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), 
																		 Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	RETURN(final);
END;