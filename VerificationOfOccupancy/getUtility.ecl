import Risk_Indicators, Utilfile, gong, ut, RiskWise, Phone_Shell, Targus;

EXPORT getUtility(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell, integer glba, boolean isUtility) := FUNCTION

// *******************************************************************************************************************
// For attribute 'AddressUtilityHistoryIndex' - join to phone and utility by DID and indicate if hits match target addr or not 
// *******************************************************************************************************************

	VerificationOfOccupancy.Layouts.Layout_VOOShell getPhone(VOOShell l, gong.Key_History_did r) := transform
		addrmatch								:= if(trim(l.z5) = trim(r.z5) and
																	trim(l.prim_range) = trim(r.prim_range) and
																	ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
																	trim(l.prim_name) = trim(r.prim_name) and
																	trim(l.addr_suffix) = trim(r.suffix) and
																	trim(l.predir) = trim(r.predir) and
																	trim(l.postdir) = trim(r.postdir), true, false);
		self.util_source				:= 'G'; 	
		self.util_prim_range		:= r.prim_range; 	
		self.util_predir				:= r.predir;		
		self.util_prim_name			:= r.prim_name;	
		self.util_suffix				:= r.suffix;  
		self.util_postdir				:= r.postdir;		
		self.util_unit_desig		:= r.unit_desig;	
		self.util_sec_range			:= r.sec_range;	
		self.util_p_city_name		:= r.p_city_name;	
		self.util_v_city_name		:= r.v_city_name; 
		self.util_st						:= r.st;	
		self.util_z5						:= r.z5;	
		self.util_dt_first_seen	:= r.dt_first_seen;	
		self.util_dt_last_seen	:= r.dt_last_seen;	
		self.util_deletion_date	:= r.dt_last_seen;	
		self.util_target_addr		:= if(addrmatch, 1,	0);	
		self.util_other_addr 		:= if(not addrmatch, 1, 0);	
		self.util_disconnect		:= if(not addrmatch and r.deletion_date <> '', true, false); //flag if a prior/other address shows disconnected 
		self										:= l;
	end;
	
	phone_hits := JOIN(VOOShell, gong.Key_History_did, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.l_DID) AND 
																					UT.PermissionTools.GLB.OK(glba) AND   // StringLib.StringToUpperCase(TRIM(IndustryClass)) <> 'UTILI' AND
																					RIGHT.dt_first_seen <= (string)LEFT.historydate + '01', 
																							getPhone(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));

//dedup to keep only the most recent utility hit for each unique address
	dedup_phone := dedup(sort(phone_hits, seq, util_prim_range, util_predir, util_prim_name, util_suffix, util_postdir, util_sec_range, util_z5, -util_dt_last_seen, -util_dt_first_seen), 
																				seq, util_prim_range, util_predir, util_prim_name, util_suffix, util_postdir, util_sec_range, util_z5);

//Begin Targus
	VerificationOfOccupancy.Layouts.Layout_VOOShell getTargus(VOOShell l, Targus.Key_Targus_DID r) := transform
		addrmatch								:= if(trim(l.z5) = trim(r.zip) and
																	trim(l.prim_range) = trim(r.prim_range) and
																	ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
																	trim(l.prim_name) = trim(r.prim_name) and
																	trim(l.addr_suffix) = trim(r.suffix) and
																	trim(l.predir) = trim(r.predir) and
																	trim(l.postdir) = trim(r.postdir), true, false);

		self.util_source				:= 'T'; 	
		self.util_prim_range		:= r.prim_range; 	
		self.util_predir				:= r.predir;		
		self.util_prim_name			:= r.prim_name;	
		self.util_suffix				:= r.suffix;  
		self.util_postdir				:= r.postdir;		
		self.util_unit_desig		:= r.unit_desig;	
		self.util_sec_range			:= r.sec_range;	
		self.util_p_city_name		:= r.city_name;	
		self.util_v_city_name		:= r.city_name; 
		self.util_st						:= r.st;	
		self.util_z5						:= r.zip;	
		self.util_dt_first_seen	:= (string)r.dt_first_seen;	
		self.util_dt_last_seen	:= (string)r.dt_last_seen;	
		self.util_target_addr		:= if(addrmatch, 1,	0);	
		self.util_other_addr 		:= if(not addrmatch, 1, 0);	
		self										:= l;
	end;
	
	targus_hits := JOIN(VOOShell, Targus.Key_Targus_DID, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID) AND 
																					UT.PermissionTools.GLB.OK(glba) AND   // StringLib.StringToUpperCase(TRIM(IndustryClass)) <> 'UTILI' AND
																					RIGHT.dt_first_seen <= LEFT.historydate, 
																							getTargus(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));

//dedup to keep only the most recent utility hit for each unique address
	dedup_Targus := dedup(sort(targus_hits, seq, util_prim_range, util_predir, util_prim_name, util_suffix, util_postdir, util_sec_range, util_z5, -util_dt_last_seen, -util_dt_first_seen), 
																					seq, util_prim_range, util_predir, util_prim_name, util_suffix, util_postdir, util_sec_range, util_z5);

//End Targus

	VerificationOfOccupancy.Layouts.Layout_VOOShell getUtility(VOOShell l, Utilfile.Key_DID r) := transform
		addrmatch								:= if(trim(l.z5) = trim(r.zip) and
																	trim(l.prim_range) = trim(r.prim_range) and
																	ut.NNEQ(trim(l.sec_range), trim(r.sec_range)) and
																	trim(l.prim_name) = trim(r.prim_name) and
																	trim(l.addr_suffix) = trim(r.addr_suffix) and
																	trim(l.predir) = trim(r.predir) and
																	trim(l.postdir) = trim(r.postdir), true, false);
		self.util_source				:= 'U'; 	
		self.util_prim_range		:= r.prim_range; 	
		self.util_predir				:= r.predir;		
		self.util_prim_name			:= r.prim_name;	
		self.util_suffix				:= r.addr_suffix;  
		self.util_postdir				:= r.postdir;		
		self.util_unit_desig		:= r.unit_desig;	
		self.util_sec_range			:= r.sec_range;	
		self.util_p_city_name		:= r.p_city_name;	
		self.util_v_city_name		:= r.v_city_name; 
		self.util_st						:= r.st;	
		self.util_z5						:= r.zip;	
		self.util_dt_first_seen	:= r.date_first_seen;	
		self.util_target_addr		:= if(addrmatch, 1,	0);	
		self.util_other_addr 		:= if(not addrmatch, 1, 0);	
		self										:= l;
	end;
	
	util_hits := JOIN(VOOShell, Utilfile.Key_DID, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.s_DID) AND 
																					UT.PermissionTools.GLB.OK(glba) AND 
																					~isUtility AND RIGHT.util_type <> 'Z' AND RIGHT.addr_type <> 'B' AND
																					RIGHT.date_first_seen <= (string)LEFT.historydate + '01', 
																							getUtility(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));

	sorted_util := sort(ungroup(dedup_phone) & ungroup(dedup_Targus) & ungroup(util_hits), seq);

// Rollup utility records by seq to get a summary of utility hits by target address and other addresses  

  VerificationOfOccupancy.Layouts.Layout_VOOShell roll_utility(sorted_util l, sorted_util r) := transform
		self.util_target_addr	:= l.util_target_addr + r.util_target_addr;	
		self.util_other_addr 	:= l.util_other_addr + r.util_other_addr;	
		self.util_disconnect	:= if(r.util_disconnect > l.util_disconnect, r.util_disconnect, l.util_disconnect); 
		self									:= l;
	end;
	
  rolled_utility := rollup(sorted_util, roll_utility(left,right), seq);

  // output(phone_hits, named('phone_hits'));
  // output(dedup_phone, named('dedup_phone'));
  // output(util_hits, named('util_hits'));
  // output(sorted_util, named('sorted_util'));
  // output(rolled_utility, named('rolled_utility'));

	return rolled_utility;	
	
END;