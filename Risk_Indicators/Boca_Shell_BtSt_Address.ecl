/*
Used in the BTST shell
Bill To Ship To Identity-Business Association (st_addr_is_bt_business_addr) - whether the ship-to address is associated with a business which is associated with the bill-to identity.
Common Addrs At Least One Owns - btst_owned_addrs_in_common - Number of unique property deeds in intersection of BT property deeds and ST property deeds
Property Deed Link - btst_property_deeds_in_common -	Number of common addresses where at least one identity is on property deed
Common Address Link - btst_addrs_in_common - Number of unique addresses in intersection of BT address history and ST address history
Common Addrs Shared Lres - btst_lres_in_common - Total length of time both identities overlapped at common addresses
Common Addrs Shared Distance - btst_addr_dists_in_common - Total linear distance between all shared addresses in first-seen order
Common Addrs Unique Num States - btst_addr_states_in_common - Number of unique states found for common addresses
*/

import Risk_Indicators, dx_header, address, ut, RiskWise;

export Boca_Shell_BtSt_Address(grouped dataset(Risk_Indicators.layout_ciid_btst_Output) input,
	unsigned1 dppa, unsigned1 glb, string50 DataRestriction=Risk_Indicators.iid_constants.default_DataRestriction,
	unsigned1 BSversion = 50) := FUNCTION

	//isFCRA := false;
	input_unGrp := ungroup(input);
	AddrHist := record
		unsigned seq;
		dx_header.layouts.i_addr_hist;
		integer unverified_addr_count := 0;
		integer trusted_sources_count := 0;
		integer occupancy_status := 0;		
		boolean input_addr_match_history := false;		
		boolean current_addr_match_history := false;
		integer input_addr_match_score := 0;
		integer current_addr_match_score := 0;
		unsigned length_of_residence := 0;
		boolean utility_only := false;
		integer non_bureau_source_count := 0;
		integer btst_addrs_in_common := 0;
		string2 state;
		integer btst_addr_states_in_common := 0;
		integer btst_lres_in_common := 0;
		integer btst_addr_dists_in_common := 0;
	end;
	out_layout := record
		unsigned4 seq;
		string10 clean_pr;
		string28 clean_pn;
		string8 clean_sr;
		string5 clean_z5;
		integer btst_property_deeds_in_common;
		integer btst_addrs_in_common  ;            
		integer btst_owned_addrs_in_common;            
		integer btst_lres_in_common  ;             
		integer btst_addr_dists_in_common  ;             
		integer btst_addr_states_in_common;  
	end;

	btst_Combodeeds := Risk_Indicators.Boca_Shell_BtSt_Properties(input);
	btst_Combodeeds_grpd := group(sort(btst_Combodeeds, seq, -btst_property_deeds_in_common), seq);

	Risk_Indicators.Layout_BocaShell_BtSt.deedSlimRec rollCommonDeeds(Risk_Indicators.Layout_BocaShell_BtSt.deedSlimRec l, Risk_Indicators.Layout_BocaShell_BtSt.deedSlimRec r) := transform
		self.btst_property_deeds_in_common := l.btst_property_deeds_in_common + r.btst_property_deeds_in_common;
		self := l;
	end;
	btst_deeds_rolled := rollup(btst_Combodeeds_grpd, left.seq = right.seq, rollCommonDeeds(left, right));

	btst_deeds := join(input_unGrp, btst_deeds_rolled,
		left.Bill_To_Output.seq = right.seq,
		transform(out_layout, 
			self.seq := left.Bill_To_Output.seq;
			self.btst_property_deeds_in_common := right.btst_property_deeds_in_common;
			self := right; //save the deed parsed out address fields
			self := []), 
			atmost(riskwise.max_atmost), 
			left outer);

	//put into the correct layout
	bt_input := project(input_unGrp(Bill_To_Output.seq != 0), transform(risk_indicators.layout_output, self := left.Bill_to_Output));
	st_input := project(input_unGrp(Ship_To_Output.seq != 0), transform(risk_indicators.layout_output, self := left.Ship_To_Output));
	btst_input := group(bt_input + st_input, seq);
	
//start: modified version of Risk_Indicators.Boca_Shell_Address_Occupancy code was copied here and modified for BTST
// only use this variable in realtime mode to simulate the header build date rather than todays date
	// dk := choosen(dx_header.key_max_dt_last_seen(), 1);
	// hdrBuildDate01 := dk[1].max_date_last_seen[1..6]+'01';
	// header_build_date := (unsigned)(dk[1].max_date_last_seen[1..6]);
	
	with_addr_history := join(btst_input, 
	dx_header.key_addr_hist(), 
	left.did<>0 and 
	right.address_history_seq<>0 and  // ignore the bad fragments with address_history_seq=0
	keyed(left.did=right.s_did) and right.date_first_seen < left.historydate, 
	transform(AddrHist,
		self.seq := left.seq;
		addr1 := address.Addr1FromComponents(right.prim_range,right.predir,right.prim_name,right.suffix,right.postdir,right.unit_desig,right.sec_range);
		// override the sequence number in the hierarchy table for records which are PO Boxes, blank zip4, 
		// single sourced bureau inquiry records, or addresses which don't have insurance/utility/vehicle/voter/dl/property footprint
		
		po_box := risk_indicators.iid_constants.override_addr_type(addr1, '','')='P';
		single_sourced_untrusted := right.source_count=1 and right.insurance_source_count=0 and right.property_source_count=0 and 
										  right.vehicle_source_count=0 and right.dl_source_count=0 and right.voter_source_count=0;
		bureau_inquiry_only := right.source_count=1 and right.bureau_source_count=1;
		same_dates := right.date_first_seen=right.date_last_seen;
		
		trusted_sources_count := right.insurance_source_count + 
														right.property_source_count + 
														right.vehicle_source_count + 
														right.dl_source_count + 
														right.voter_source_count;
		self.trusted_sources_count := trusted_sources_count;
		

		//temporary solution to flag addresses that are found on only 1 record across the board.
		// testing this out to see if it helps.  
		// if we like this, we'll consider adding a new field to the address hiearchy layout next year instead of using position 5 of addressstatus
		single_instance_address := right.addressstatus[5]='S';
		
		address_history_seq := map(
																		po_box => 255,
																		single_sourced_untrusted and (bureau_inquiry_only or same_dates or single_instance_address) => 255,													
																		right.address_history_seq  // leave it as is by default
																		);	
		self.address_history_seq := address_history_seq;
		
		self.unverified_addr_count := if(single_sourced_untrusted or bureau_inquiry_only, 1, 0);

// compare the address scores to see if we have matches
	input_addrmatchscore := Risk_Indicators.AddrScore.AddressScore(left.prim_range, left.prim_name, left.sec_range, 
																						right.prim_range, right.prim_name, right.sec_range);		
		
		self.input_addr_match_history := risk_indicators.ga(input_addrmatchscore);
		self.input_addr_match_score := input_addrmatchscore;
		//just using input address as current address
		current_addrmatchscore := Risk_Indicators.AddrScore.AddressScore(left.prim_range, left.prim_name, left.sec_range, 
																						right.prim_range, right.prim_name, right.sec_range);		
		self.current_addr_match_history := risk_indicators.ga(current_addrmatchscore);
		self.current_addr_match_score := current_addrmatchscore;
		self.occupancy_status := map(address_history_seq=255 => 0, 
																	right.date_last_seen >= left.historydate => 1, // in history mode, if last seen date greater than history date, then still consider it occupancy candidate		
																//	right.date_last_seen >= header_build_date => 1, // in current mode, any date greater than build date is a candidate
																	right.date_last_seen >= left.header_summary.header_build_date => 1, // in current mode, any date greater than build date is a candidate
																	0);  
		self.length_of_residence := round((ut.DaysApart((string)right.date_first_seen, 
																												(string)right.date_last_seen)) / 30);
																												
		self.utility_only := right.utility_source_count>0 and right.source_count=1;
		self.non_bureau_source_count := right.source_count - right.bureau_source_count;
		
		self.date_last_seen := if(right.date_last_seen > left.historydate, left.historydate, right.date_last_seen);
		derivedState := RiskWise.Key_CityStZip(zip5 = right.zip);
		deemedState := derivedState[1].state;
		self.state := deemedState; // as not in addrhistory key
		self := right), atmost(riskwise.max_atmost), keep(100));

	// waterfall logic for selecting the occupied address
	occupancy_sorted := group(
		sort(with_addr_history, seq, 
		  if(occupancy_status=0, 99, occupancy_status),  // select a occupied address over the un-occupied
			utility_only,   					// demote anything with utility only
			-trusted_sources_count, 	// select the record with the highest number of trusted sources
			-non_bureau_source_count, // select the record with the most nonbureau sources
			-source_count, 						// select the record with the overall highest count of sources
			-bureau_source_count,
			occupancy_status ), 
	seq);
	
	iterated_addresses := iterate(occupancy_sorted, transform(AddrHist, 		
		self.occupancy_status := 
		// if there is still a tie between first row and second row, set occupancy_status=2 so we know occupancy is ambiguous
		if(
			COUNTER=2 AND RIGHT.OCCUPANCY_STATUS=1 and
			left.utility_only=right.utility_only and
			left.trusted_sources_count=right.trusted_sources_count and
			left.non_bureau_source_count=right.non_bureau_source_count and
			left.source_count=right.source_count and
			left.bureau_source_count=right.bureau_source_count, 
			2, right.occupancy_status),
		self := right) );

	potential_occupied_candidates := iterated_addresses;

	// get down to 1 record per transaction that we believe to be the occupied address
	occupied_address := rollup(potential_occupied_candidates, left.seq=right.seq,
		transform(AddrHist, 
			self.unverified_addr_count := min(left.unverified_addr_count + right.unverified_addr_count, 255), // cap it at 255 just in case
			self.input_addr_match_history := left.input_addr_match_history or right.input_addr_match_history;
			self.current_addr_match_history := left.current_addr_match_history or right.current_addr_match_history;
			self.occupancy_status := left.occupancy_status;
			self := left;
			) );

	// keep only the 100 most recent valid addresses per transaction (address_history_seq<>255)
	mostRecent := dedup(sort(with_addr_history(address_history_seq<>255), seq, address_history_seq), seq, keep(100));
//start: modified version of Risk_Indicators.Boca_Shell_Address_Occupancy code
	
	bt_addrs := join(bt_input, mostRecent,
		left.seq = right.seq,
		transform(right), atmost(riskwise.max_atmost));
	
	st_addrs := join(st_input, mostRecent,
		left.seq = right.seq,
		transform(right), atmost(riskwise.max_atmost));
		
	AddrHist comboAddrs(AddrHist l, AddrHist r) := transform		
		self.seq := l.seq;
		sameAddress := l.prim_range = r.prim_range and 
					((l.prim_range <>'' and r.prim_range <>'') OR (l.prim_name <>'' and r.prim_name <>'')) and
					l.prim_name = r.prim_name and 
					l.sec_range = r.sec_range and 
					l.zip = r.zip;	
		self.btst_addrs_in_common := if(sameAddress, 1, 0); 
		//determine the overlap between addresses
		minLastSeen := if(sameAddress, min(l.date_last_seen, r.date_last_seen), 0);
		maxFirstSeen := if(sameAddress, max(l.date_first_seen, r.date_first_seen), 0);
	//can't use ut.MonthsApart as they don't want ABS done on it
		lres := ((integer)((STRING)minLastSeen)[1..4] - (integer)((STRING)maxFirstSeen)[1..4]) * 12 + 
							((integer)((STRING)minLastSeen)[5..6] - (integer)((STRING)maxFirstSeen)[5..6]);			
		self.btst_lres_in_common := if(sameAddress and (integer) minLastSeen > 0 and 
			(integer) maxFirstSeen > 0 and lres > 0, lres, 0);	
		self := l;
	end;	
		
	btst_Combo_addrs := join(bt_addrs, st_addrs,
		left.seq = right.seq -1,
		comboAddrs(left, right), atmost(riskwise.max_atmost));
	bstst_Combo_hits := btst_Combo_addrs(btst_addrs_in_common>0);
	//date first seen for the distance calculation below
	btst_Combo_grpd := group(sort(bstst_Combo_hits, seq, date_first_seen, -btst_addrs_in_common, -btst_addr_states_in_common), seq);

	AddrHist rollCommonAddrs(AddrHist l, AddrHist r) := transform
		zipNoMatch := if(l.zip != '' and r.zip != '' and l.zip != r.zip, true, false);
		distance := if(zipNoMatch, (INTEGER) ut.zip_Dist(l.zip,	r.zip), 0);
		self.btst_addr_dists_in_common := l.btst_addr_dists_in_common + distance;//distOfZips;
		self.zip := r.zip;
		self.btst_addrs_in_common := l.btst_addrs_in_common + r.btst_addrs_in_common;
		self.btst_lres_in_common := l.btst_lres_in_common + r.btst_lres_in_common;
		self := l;
	end;
	btst_addrs_rolled := rollup(btst_Combo_grpd, left.seq = right.seq, rollCommonAddrs(left, right));

	out_layout comboDeedsAtAddrs(Risk_Indicators.Layout_BocaShell_BtSt.deedSlimRec l, AddrHist r) := transform		
		self.seq := l.seq;
		SameAddress := l.clean_pr = r.prim_range and 
					((l.clean_pr <>'' and r.prim_range <>'') OR 
						(l.clean_pn <>'' and r.prim_name <>'')) and
					l.clean_pn = r.prim_name and 
					//l.clean_sr = r.sec_range and //properties don't have sec ranges populated
					l.clean_z5 = r.zip;	
		self.btst_owned_addrs_in_common := if(SameAddress, 1, 0); 
		self := [];
	end;	
	
	btst_deedsAtComboAddrs := join(btst_Combodeeds, bstst_Combo_hits,
		left.seq = right.seq,
		comboDeedsAtAddrs(left, right), atmost(riskwise.max_atmost));
	
	btst_deedsAtComboAddrs_grpd := group(sort(btst_deedsAtComboAddrs, seq, -btst_owned_addrs_in_common), seq);

	out_layout rollCommonDeedsAtAddrs(out_layout l, out_layout r) := transform
		self.btst_owned_addrs_in_common := l.btst_owned_addrs_in_common + r.btst_owned_addrs_in_common;
		self := l;
	end;
	btst_deedsAtAddrs_rolled := rollup(btst_deedsAtComboAddrs_grpd, left.seq = right.seq, rollCommonDeedsAtAddrs(left, right));

	btst_deedsAtAddrs := join(btst_deeds, btst_deedsAtAddrs_rolled,
			left.seq = right.seq,
			transform(out_layout, 
				self.seq := left.seq;
				self.btst_owned_addrs_in_common := right.btst_owned_addrs_in_common;
				self.btst_property_deeds_in_common := left.btst_property_deeds_in_common;
				self := [];),atmost(riskwise.max_atmost),
				left outer);
	
	btst_deeds_addrs := join(btst_deedsAtAddrs, btst_addrs_rolled,
		left.seq = right.seq,
			transform(out_layout, 
				self.seq := left.seq;
				self.btst_owned_addrs_in_common := left.btst_owned_addrs_in_common;
				self.btst_property_deeds_in_common := left.btst_property_deeds_in_common;
				self.btst_addrs_in_common := right.btst_addrs_in_common;
				self.btst_lres_in_common := right.btst_lres_in_common;
				self.btst_addr_dists_in_common := right.btst_addr_dists_in_common;
				self := []), atmost(riskwise.max_atmost), left outer);

	btst_Combo4States := dedup(sort(bstst_Combo_hits, seq, state), seq, state);
	tbl_state_cnts := table(btst_Combo4States, {seq, state_cnt:=count(group)}, seq); 	
	
	btst_info_tmp := join(btst_deeds_addrs, tbl_state_cnts, 
		left.seq = right.seq,
			transform(out_layout, 
				self.seq := left.seq;
				self.btst_owned_addrs_in_common := left.btst_owned_addrs_in_common;
				self.btst_property_deeds_in_common := left.btst_property_deeds_in_common;
				self.btst_addrs_in_common := left.btst_addrs_in_common;
				self.btst_lres_in_common := left.btst_lres_in_common;
				self.btst_addr_dists_in_common := left.btst_addr_dists_in_common;
				self.btst_addr_states_in_common := right.state_cnt;
				self := []), atmost(riskwise.max_atmost), left outer);
	
	btst_info := group(btst_info_tmp, seq);
	// output debugs
		// output(btst_Combodeeds, named('btst_Combodeeds'));
		// output(btst_Combodeeds_grpd, named('btst_Combodeeds_grpd'));
		// output(btst_deeds_rolled, named('btst_deeds_rolled'));
		// output(bt_input, named('bt_input'));
		// output(st_input, named('st_input'));
		// output(btst_input, named('btst_input'));
		//	  output(with_addr_history, named('with_addr_history'));
		// output(occupancy_sorted, named('occupancy_sorted'));
		// output(iterated_addresses, named('iterated_addresses'));
		// output(potential_occupied_candidates, named('potential_occupied_candidates'));
		// output(occupied_address, named('occupied_addres'));
		// output(mostRecent, named('mostRecent'));
		// output(bt_addrs, named('bt_addrs'));
		// output(st_addrs, named('st_addrs'));
		// output(btst_Combo_addrs, named('btst_Combo_addrs'));
		// output(bstst_Combo_hits, named('bstst_Combo_hits'));
		// output(btst_Combo_grpd, named('btst_Combo_grpd'));
		// output(btst_addrs_rolled, named('btst_addrs_rolled'));
		// output(btst_deedsAtComboAddrs, named('btst_deedsAtComboAddrs'));
		// output(btst_deedsAtComboAddrs_grpd, named('btst_deedsAtComboAddrs_grpd'));
		// output(btst_deedsAtAddrs_rolled, named('btst_deedsAtAddrs_rolled'));
		// output(btst_deedsAtAddrs, named('btst_deedsAtAddrs'));
		// output(btst_deeds_addrs, named('tst_deeds_addrs'));
		// output(btst_Combo4States, named('btst_Combo4States'));
		// output(tbl_state_cnts, named('tbl_state_cnts'));
		// output(btst_info, named('btst_info'));
		// output(btst_Combodeeds, named('btst_Combodeeds'));

	return btst_info;

end;
