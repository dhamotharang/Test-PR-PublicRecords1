import Risk_Indicators, ut, LN_PropertyV2, RiskWise, Address;

EXPORT getMailingAddr(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) rollHeader,
													DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) allHeader,
													boolean fares_ok = true) := FUNCTION

// ******************************************************************************************************************************
// For attribute 'AddressOwnerMailingAddressIndex' - join to Fares assessments and deeds to get the target property's most recent mailing
//																									 address and indicate whether it is the same or different than the target address
// ******************************************************************************************************************************

	propKey := LN_PropertyV2.key_prop_address_v4;
	searchKey := LN_PropertyV2.key_search_fid(isFCRA := FALSE);
	assessKey := LN_PropertyV2.key_assessor_fid();
	deedKey := LN_PropertyV2.key_deed_fid();

	faresRec := RECORD
		VerificationOfOccupancy.Layouts.Layout_VOOShell;
		DATASET({STRING12 ln_fare_id}) fares;
	END;

	faresRec getFIDs(rollHeader le, propKey ri) := TRANSFORM
		SELF.fares := ri.fares;
		SELF := le;
	END;
	
	targetFIDs := join(rollHeader(prim_name != '', z5 != ''), propKey,
													keyed(left.prim_range = right.prim_range) and
													keyed(left.prim_name = right.prim_name) and
													keyed(left.sec_range = right.sec_range) and
													keyed(left.z5 = right.zip) and
													keyed(left.addr_suffix = right.suffix) and
													keyed(left.predir = right.predir) and
													keyed(left.postdir = right.postdir),
										 getFIDs(LEFT,RIGHT), left outer, ATMOST(100)) + 
								PROJECT(rollHeader(prim_name = '' or z5 = ''), transform(faresRec, self := left, self := [])) ;


	VerificationOfOccupancy.Layouts.Layout_VOOShell getFaresSearch(targetFIDs le, searchKey ri) := TRANSFORM
		SELF.Fares_ID 						:= ri.LN_Fares_ID; 
		SELF.Fares_dt_first_seen 	:= ri.dt_first_seen; 
		SELF.Fares_dt_last_seen 	:= ri.dt_last_seen; 
		SELF := le;
	END;

	targetSearchFIDs := JOIN(targetFIDs, searchKey, COUNT(LEFT.fares) > 0 AND (fares_ok or right.ln_fares_id[1]<>'R') AND 
																														KEYED(RIGHT.ln_fares_id IN SET(LEFT.fares, ln_fare_id)) AND
																													 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) AND
																														 	RIGHT.prim_name <> '' and RIGHT.zip <> '' AND
																													 (LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND ut.NNEQ(trim(left.sec_range), trim(right.sec_range)) AND LEFT.Z5 = RIGHT.ZIP AND 
																														LEFT.Addr_Suffix = RIGHT.Suffix AND LEFT.PreDir = RIGHT.PreDir AND LEFT.PostDir = RIGHT.PostDir),																												
																														getFaresSearch(LEFT, RIGHT), LEFT OUTER, KEEP(1000), ATMOST(RiskWise.max_atmost));


	//Get the most recent Fares assessment record (2nd position of Fares ID = 'A')
	targetDedupAssess := DEDUP(SORT(targetSearchFIDs(Fares_ID[2] = 'A'), seq, -Fares_dt_last_seen, -Fares_dt_first_seen), seq);

	VerificationOfOccupancy.Layouts.Layout_VOOShell getAssessments(targetDedupAssess le, AssessKey ri) := TRANSFORM
		pos_of_comma := stringlib.stringfind(ri.mailing_city_state_zip, ',', 1);
		parsed_city := ri.mailing_city_state_zip[1..pos_of_comma-1];
		parsed_state := ri.mailing_city_state_zip[pos_of_comma+2..pos_of_comma+3];  //assumes city is followed by comma and space, then state
		filter_zip := stringlib.stringfilter(ri.mailing_city_state_zip, '0123456789');  //extract the numbers - should end up with just zip/zip+4
		parsed_zip := if(length(trim(filter_zip)) in [5,9], filter_zip[1..5], '');  //don't trust if zip length is other than 5 or 9
		
		clean_addr := if(ri.mailing_full_street_address <> '',
										 risk_indicators.MOD_AddressClean.clean_addr(ri.mailing_full_street_address, parsed_city, parsed_state, parsed_zip[1..5]),
										 '');											

		zip_score := Risk_Indicators.AddrScore.zip_score(le.z5, Address.CleanFields(clean_addr).zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.p_city_name, le.st, Address.CleanFields(clean_addr).p_city_name, Address.CleanFields(clean_addr).st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																							Address.CleanFields(clean_addr).prim_range, Address.CleanFields(clean_addr).prim_name, Address.CleanFields(clean_addr).sec_range,
																							zip_score, cityst_score);
	//if address score is >= 80 and house number matches, consider the mailing address the same as the target address
		addrmatch := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.Prim_Range = trim(Address.CleanFields(clean_addr).prim_range);

		citymatch := le.p_city_name = Address.CleanFields(clean_addr).p_city_name;	
		zipmatch 	:= le.z5 = Address.CleanFields(clean_addr).zip;	

		addr_type 	:= Address.CleanFields(clean_addr).rec_type[1];
		addr_status := Address.CleanFields(clean_addr).err_stat;
		
		SELF.Fares_mail_prim_range := Address.CleanFields(clean_addr).prim_range; 	
		SELF.Fares_mail_predir := Address.CleanFields(clean_addr).predir;		
		SELF.Fares_mail_prim_name := Address.CleanFields(clean_addr).prim_name;	
		SELF.Fares_mail_suffix := Address.CleanFields(clean_addr).addr_suffix;  
		SELF.Fares_mail_postdir := Address.CleanFields(clean_addr).postdir;		
		SELF.Fares_mail_unit_desig := Address.CleanFields(clean_addr).unit_desig;	
		SELF.Fares_mail_sec_range := Address.CleanFields(clean_addr).sec_range;	
		SELF.Fares_mail_city := Address.CleanFields(clean_addr).p_city_name;	
		SELF.Fares_mail_st := Address.CleanFields(clean_addr).st;	
		SELF.Fares_mail_zip := Address.CleanFields(clean_addr).zip;
		SELF.Fares_mail_addr_flag := map (addrmatch																		=> 6,
																			addr_type = 'P' and (citymatch or zipmatch)	=> 5,
																			addr_type = 'P'															=> 4,
																			clean_addr = ''															=> 0,
																			le.did = 0																	=> -1,
																																										 3);  //mailing addr not same as target addr and not PO
		SELF := le;
	END;

	targetAssess := JOIN(targetDedupAssess, AssessKey, KEYED(RIGHT.ln_fares_id = LEFT.Fares_ID),
																									 getAssessments(LEFT, RIGHT), LEFT OUTER, KEEP(200), ATMOST(RiskWise.max_atmost));

//Get the most recent Fares deed record (2nd position of Fares ID = 'D')
	targetDedupDeeds := DEDUP(SORT(targetSearchFIDs(Fares_ID[2] = 'D'), seq, -Fares_dt_last_seen, -Fares_dt_first_seen), seq);
	
	VerificationOfOccupancy.Layouts.Layout_VOOShell getDeeds(targetDedupDeeds le, deedKey ri) := TRANSFORM
		pos_of_comma := stringlib.stringfind(ri.mailing_csz, ',', 1);
		parsed_city := ri.mailing_csz[1..pos_of_comma-1];
		parsed_state := ri.mailing_csz[pos_of_comma+2..pos_of_comma+3];  //assumes city is followed by comma and space, then state
		filter_zip := stringlib.stringfilter(ri.mailing_csz, '0123456789');  //extract the numbers - should end up with just zip/zip+4
		parsed_zip := if(length(trim(filter_zip)) in [5,9], filter_zip[1..5], '');  //don't trust if zip length is other than 5 or 9
		
		clean_addr := if(ri.mailing_street <> '',
										 risk_indicators.MOD_AddressClean.clean_addr(ri.mailing_street, parsed_city, parsed_state, parsed_zip[1..5]),
										 '');											

		zip_score := Risk_Indicators.AddrScore.zip_score(le.z5, Address.CleanFields(clean_addr).zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.p_city_name, le.st, Address.CleanFields(clean_addr).p_city_name, Address.CleanFields(clean_addr).st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																							Address.CleanFields(clean_addr).prim_range, Address.CleanFields(clean_addr).prim_name, Address.CleanFields(clean_addr).sec_range,
																							zip_score, cityst_score);
	//if address score is >= 80 and house number matches, consider the mailing address the same as the target address
		addrmatch := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.Prim_Range = trim(Address.CleanFields(clean_addr).prim_range);

		citymatch := le.p_city_name = Address.CleanFields(clean_addr).p_city_name;	
		zipmatch 	:= le.z5 = Address.CleanFields(clean_addr).zip;	

		addr_type 	:= Address.CleanFields(clean_addr).rec_type[1];
		addr_status := Address.CleanFields(clean_addr).err_stat;
		
		SELF.Fares_mail_prim_range := Address.CleanFields(clean_addr).prim_range; 	
		SELF.Fares_mail_predir := Address.CleanFields(clean_addr).predir;		
		SELF.Fares_mail_prim_name := Address.CleanFields(clean_addr).prim_name;	
		SELF.Fares_mail_suffix := Address.CleanFields(clean_addr).addr_suffix;  
		SELF.Fares_mail_postdir := Address.CleanFields(clean_addr).postdir;		
		SELF.Fares_mail_unit_desig := Address.CleanFields(clean_addr).unit_desig;	
		SELF.Fares_mail_sec_range := Address.CleanFields(clean_addr).sec_range;	
		SELF.Fares_mail_city := Address.CleanFields(clean_addr).p_city_name;	
		SELF.Fares_mail_st := Address.CleanFields(clean_addr).st;	
		SELF.Fares_mail_zip := Address.CleanFields(clean_addr).zip;
		SELF.Fares_mail_addr_flag := map (le.did = 0																	=> -1,
																			clean_addr = ''															=> 0,
																			addrmatch																		=> 6,
																			addr_type = 'P' and (citymatch or zipmatch)	=> 5,
																			addr_type = 'P'															=> 4,
																																										 3);  //mailing addr not same as target addr and not PO
		SELF := le;
	END;

	targetDeed := JOIN(targetDedupDeeds, deedKey, KEYED(RIGHT.ln_fares_id = LEFT.Fares_ID),
																									 getDeeds(LEFT, RIGHT), LEFT OUTER, KEEP(200), ATMOST(RiskWise.max_atmost));

	targetFinal := dedup(sort(ungroup(targetAssess) & ungroup(targetDeed), seq, -Fares_dt_last_seen, -Fares_dt_first_seen, Fares_mail_addr_flag), seq);
	
//If Fares_mail_addr_flag = 3 (mailing addr is different than target), do additional lookups to see if mailing addr is reported/owned by input subject
	mailingDiffs := targetFinal(Fares_mail_addr_flag = 3);

//Join to header records from earlier to see if mailing address is currently being reported for the subject
	VerificationOfOccupancy.Layouts.Layout_VOOShell get_mailing_hdr(mailingDiffs l, allHeader r) := transform
		addrmatch							:= if(trim(l.Fares_mail_zip) = trim(r.h.zip) and
																trim(l.Fares_mail_prim_range) = trim(r.h.prim_range) and
																ut.NNEQ(trim(l.Fares_mail_sec_range), trim(r.h.sec_range)) and
																trim(l.Fares_mail_prim_name) = trim(r.h.prim_name) and
																trim(l.Fares_mail_suffix) = trim(r.h.suffix) and
																trim(l.Fares_mail_predir) = trim(r.h.predir) and
																trim(l.Fares_mail_postdir) = trim(r.h.postdir), true, false);
		self.Fares_mail_addr_flag	:= if(addrmatch, 2, 3);		//return attribute level of 2 if found, else keep as 3
		self											:= l;
	end;	

	mailingHdrs := join(mailingDiffs, allHeader, 
						left.seq = right.seq, 
						get_mailing_hdr(left, right),
						left outer, atmost(riskwise.max_atmost * 5));	

//go get all of our input subject's owned properties
	propsOwned	:= VerificationOfOccupancy.getPropOwnership(mailingDiffs, fares_ok); 

//join the mailing address to the DID's owned properties and pick up the owned/sold indicators
	VerificationOfOccupancy.Layouts.Layout_VOOShell getOwnedProps(mailingDiffs le, propsOwned ri) := TRANSFORM
		zip_score := Risk_Indicators.AddrScore.zip_score(le.Fares_mail_zip, ri.property_zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.Fares_mail_city, le.Fares_mail_st, ri.property_city, ri.property_st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.Fares_mail_prim_range, le.Fares_mail_prim_name, le.Fares_mail_sec_range, 
																														 ri.property_prim_range, ri.property_prim_name, ri.property_sec_range,
																														 zip_score, cityst_score);
		addr_match := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.Fares_mail_prim_range = ri.property_prim_range;

		SELF.Fares_mail_addr_owned 	:= if(addr_match, ri.property_owned, '0');
		SELF.Fares_mail_addr_sold		:= if(addr_match, ri.property_sold, '0');
		self.Fares_mail_addr_flag		:= if(self.Fares_mail_addr_owned='1' and self.Fares_mail_addr_sold<>'1', 1, 3);		//return '1' if owned and not sold, else keep as '3'
		SELF 												:= le;
	END;	

	with_PropsOwned := join(mailingDiffs, propsOwned, 
				left.seq = right.seq,
				getOwnedProps(left,right),left outer, ATMOST(riskwise.max_atmost));
	
	sortProperty := sort(with_PropsOwned(Fares_mail_addr_owned = '1' or Fares_mail_addr_sold = '1'), seq);

//rollup by seq to set the owned/sold flags for the target address
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollProperty(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.Fares_mail_addr_owned 				:= if(r.Fares_mail_addr_owned='1', r.Fares_mail_addr_owned, l.Fares_mail_addr_owned);
		self.Fares_mail_addr_sold 				:= if(r.Fares_mail_addr_sold='1', r.Fares_mail_addr_sold, l.Fares_mail_addr_sold);
		self.Fares_mail_addr_flag					:= min(l.Fares_mail_addr_flag, r.Fares_mail_addr_flag);		
		self															:= l;
	end;
	
  rolled_Property := rollup(sortProperty, rollProperty(left,right), seq);

//merge records with different mailing address back in and retain the lowest value set (1 = found on ownership, 2 = found on header, 3 = not found on either)
	final := dedup(sort(ungroup(mailingHdrs) & ungroup(rolled_Property) & ungroup(targetFinal), seq, Fares_mail_addr_flag), seq);

  // output(targetFIDs, named('targetFIDs'));
  // output(targetSearchFIDs, named('targetSearchFIDs'));
  // output(targetDedupAssess, named('targetDedupAssess'));
  // output(targetAssess, named('targetAssess'));
  // output(targetDedupDeeds, named('targetDedupDeeds'));
  // output(targetDeed, named('targetDeed'));
  // output(targetFinal, named('targetFinal'));
  // output(mailingDiffs, named('mailingDiffs'));
  // output(mailingHdrs, named('mailingHdrs'));
  // output(propsOwned, named('propsOwned'));
  // output(with_PropsOwned, named('with_PropsOwned'));
  // output(sortProperty, named('sortProperty'));
  // output(rolled_Property, named('rolled_Property'));
  // output(final, named('final'));

	return final;	
	
END;