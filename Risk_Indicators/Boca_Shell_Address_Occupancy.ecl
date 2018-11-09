import header, riskwise, address, ut;

EXPORT Boca_Shell_Address_Occupancy(GROUPED DATASET (Layout_Boca_Shell) clam, boolean isFCRA, boolean onThor = false) := function

	temp := record
		unsigned seq;
		recordof(header.key_addr_hist(isFCRA));
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
		integer	bus_addr_only_curr;
		integer	bus_addr_only;
	end;
	
	AddrHistKey := header.key_addr_hist(isFCRA);
	temp getAddrHistory(clam le, AddrHistKey ri) := TRANSFORM
		self.seq := le.seq;
		addr1 := address.Addr1FromComponents(ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,ri.unit_desig,ri.sec_range);
		// override the sequence number in the hierarchy table for records which are PO Boxes, blank zip4, 
		// single sourced bureau inquiry records, or addresses which don't have insurance/utility/vehicle/voter/dl/property footprint
		
		po_box := risk_indicators.iid_constants.override_addr_type(addr1, '','')='P';
		single_sourced_untrusted := ri.source_count=1 and ri.insurance_source_count=0 and ri.property_source_count=0 and 
										  ri.vehicle_source_count=0 and ri.dl_source_count=0 and ri.voter_source_count=0;
		bureau_inquiry_only := ri.source_count=1 and ri.bureau_source_count=1;
		same_dates := ri.date_first_seen=ri.date_last_seen;
		
		trusted_sources_count := ri.insurance_source_count + 
														ri.property_source_count + 
														ri.vehicle_source_count + 
														ri.dl_source_count + 
														ri.voter_source_count;
		self.trusted_sources_count := trusted_sources_count;
		

		//temporary solution to flag addresses that are found on only 1 record across the board.
		// testing this out to see if it helps.  
		// if we like this, we'll consider adding a new field to the address hiearchy layout next year instead of using position 5 of addressstatus
		single_instance_address := ri.addressstatus[5]='S';
		
		address_history_seq := map(
																		po_box => 255,
																		single_sourced_untrusted and (bureau_inquiry_only or same_dates or single_instance_address) => 255,													
																		ri.address_history_seq  // leave it as is by default
																		);	
		self.address_history_seq := address_history_seq;
		
		self.unverified_addr_count := if(single_sourced_untrusted or bureau_inquiry_only, 1, 0);

	// compare the address scores to see if we have matches
	input_addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.shell_input.prim_range, le.shell_input.prim_name, le.shell_input.sec_range, 
																						ri.prim_range, ri.prim_name, ri.sec_range);		
		
		self.input_addr_match_history := risk_indicators.ga(input_addrmatchscore);
		self.input_addr_match_score := input_addrmatchscore;
		
	current_addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.address_verification.address_history_1.prim_range, le.address_verification.address_history_1.prim_name, le.address_verification.address_history_1.sec_range, 
																						ri.prim_range, ri.prim_name, ri.sec_range);		
		self.current_addr_match_history := risk_indicators.ga(current_addrmatchscore);
		self.current_addr_match_score := current_addrmatchscore;
		self.occupancy_status := map(address_history_seq=255 => 0, 
																	ri.date_last_seen >= le.historydate => 1, // in history mode, if last seen date greater than history date, then still consider it occupancy candidate
																	ri.date_last_seen >= le.header_summary.header_build_date => 1, // in current mode, any date greater than build date is a candidate
																	0);  
		self.length_of_residence := round((ut.DaysApart((string)ri.date_first_seen, 
																												(string)ri.date_last_seen)) / 30);
																												
		self.utility_only := ri.utility_source_count>0 and ri.source_count=1;
		self.non_bureau_source_count := ri.source_count - ri.bureau_source_count;
		
		self.date_last_seen := if(ri.date_last_seen > le.historydate, le.historydate, ri.date_last_seen);
		
		self.bus_addr_only_curr := map(self.occupancy_status = 1 and ri.addresstype = 'BUS'		=>	1,		//this is a current business address
																	 self.occupancy_status = 1 and ri.addresstype <> 'BUS'	=>	0,		//this is a current non-business address
																																															-2);	//not a current address	
		self.bus_addr_only			:= map(ri.addresstype = 'BUS'	and address_history_seq <> 255	=>	1,		//this is a business address
																	 ri.addresstype <> 'BUS' and address_history_seq <> 255	=>	0,		//this is a non-business address
																																															-2);	//not a valid address
		self := ri;
	END;
	
	with_addr_history_roxie := join(clam, AddrHistKey, 
	left.did<>0 and 
	right.address_history_seq<>0 and  // ignore the bad fragments with address_history_seq=0
	keyed(left.did=right.s_did) and right.date_first_seen < left.historydate, 
	getAddrHistory(LEFT,RIGHT), atmost(riskwise.max_atmost), keep(100));

	with_addr_history_thor:= join(distribute(clam(did<>0), hash64(did)), 
	distribute(pull(AddrHistKey(address_history_seq<>0)), hash64(s_did)), // ignore the bad fragments with address_history_seq=0
	(left.did=right.s_did) and right.date_first_seen < left.historydate, 
	getAddrHistory(LEFT,RIGHT), atmost(left.did=right.s_did, riskwise.max_atmost), keep(100), LOCAL);
	
	with_addr_history := if(onThor, group(sort(with_addr_history_thor, seq), seq), with_addr_history_roxie);
	
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
	
	iterated_addresses := iterate(occupancy_sorted, transform(temp, 		
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
		transform(temp, 
			self.unverified_addr_count := min(left.unverified_addr_count + right.unverified_addr_count, 255), // cap it at 255 just in case
			self.input_addr_match_history := left.input_addr_match_history or right.input_addr_match_history;
			self.current_addr_match_history := left.current_addr_match_history or right.current_addr_match_history;
			self.occupancy_status := left.occupancy_status;
			self.bus_addr_only_curr := map(left.bus_addr_only_curr = -2 and right.bus_addr_only_curr = -2			=> 	-2,																												//neither address is valid
																		 left.bus_addr_only_curr >= 0 and right.bus_addr_only_curr >= 0			=> 	min(left.bus_addr_only_curr, right.bus_addr_only_curr), 	//if any current addr is not a business, return 0
																																																						max(left.bus_addr_only_curr, right.bus_addr_only_curr));	//keep the valid addr over the non valid addr
			self.bus_addr_only 			:= map(left.bus_addr_only = -2 and right.bus_addr_only = -2								=> 	-2,																												//neither address is valid
																		 left.bus_addr_only >= 0 and right.bus_addr_only >= 0								=> 	min(left.bus_addr_only, right.bus_addr_only),							//if any addr is not a business, return 0
																																																						max(left.bus_addr_only, right.bus_addr_only));						//keep the valid addr over the non valid addr
			self := left;
			) );

	with_occupancy := join(clam, occupied_address, left.seq=right.seq,
		transform(risk_indicators.Layout_Boca_Shell,
	
	self.address_verification.inputAddr_dirty := left.shell_input.z5<>'' and left.shell_input.zip4='';
	self.address_verification.inputAddr_not_verified := left.shell_input.z5<>'' and ~right.input_addr_match_history and right.address_history_seq <> 255;
	self.address_verification.inputAddr_occupancy_index := 
	map((left.shell_input.prim_name='' or left.shell_input.z5='') => 0,
			 left.shell_input.addr_type='P' and right.input_addr_match_history and right.occupancy_status=1 => 5,
			 left.shell_input.addr_type='P' and right.input_addr_match_history and right.occupancy_status<>1 => 6, 
			 left.shell_input.addr_type='P' and ~right.input_addr_match_history and right.occupancy_status=1 => 7,
			 left.shell_input.addr_type='P' and ~right.input_addr_match_history and right.occupancy_status<>1 => 8, 
			 risk_indicators.ga(right.input_addr_match_score) and right.occupancy_status=1 => 1,
			 right.input_addr_match_history and right.occupancy_status=0 => 3,
			 right.input_addr_match_history and right.occupancy_status=2 => 2,  // ambiguous occupancy_status
			 right.input_addr_match_history and ~risk_indicators.ga(right.input_addr_match_score) => 3,  
			 right.seq<>0 and right.input_addr_match_history=false => 4,
			 0);  
			 
	self.address_verification.currAddr_occupancy_index := 	
	map((left.address_verification.address_history_1.prim_name='' or left.address_verification.address_history_1.zip5='') => 0,
			 risk_indicators.ga(right.current_addr_match_score) and right.occupancy_status=1 => 1,
			 right.occupancy_status = 2 => 2,  // ambiguous occupancy_status
			 right.current_addr_match_history => 3,
			 0);  
			 
	self.address_verification.unverified_addr_count := right.unverified_addr_count;
	self.address_verification.inputAddr_owned_not_occupied := left.address_verification.input_address_information.applicant_owned and
																														self.address_verification.inputaddr_occupancy_index = 3;
 	
	current_nonrelative_didcount :=	if(left.relatives.relatives_at_input_address>left.velocity_counters.adls_per_addr_current,
			left.velocity_counters.adls_per_addr_current,
			// don't include the input individual in this count, per bug 164873
			left.velocity_counters.adls_per_addr_current - left.relatives.relatives_at_input_address - left.iid.didcount);
 	inputAddr_non_relative_DID_count := if(current_nonrelative_didcount < 0, 0, current_nonrelative_didcount);  // lower cap on this to 0		
	self.address_verification.inputAddr_non_relative_DID_count := if(~isFCRA, 
		min(125, inputAddr_non_relative_DID_count),  // cap this at 125 since we defined the field to be integer1
		0);  // don't populate this field in FCRA

	self.address_verification.bus_addr_only_curr 	:= map(left.DID = 0 or left.truedid = false 		=> -1,
																											 left.seq <> right.seq 										=> -2, 
																																																	 right.bus_addr_only_curr);
	self.address_verification.bus_addr_only 			:= map(left.DID = 0 or left.truedid = false			=> -1,
																											 left.seq <> right.seq 										=> -2, 
																																																	 right.bus_addr_only);
		
	self := left;
	), 
	left outer, keep(1));
	
	
	// keep only the 4 most recent valid addresses per transaction (address_history_seq<>255)
	mostRecent4 := dedup(sort(with_addr_history(address_history_seq<>255), seq, address_history_seq), seq, keep(4));
	
	lres_stats := table(mostRecent4, {seq,
		address_count := count(group),
		max_lres := max(group, length_of_residence),
		avg_lres := ave(group, length_of_residence)
		}, seq);
	
	with_length_of_residence := join(with_occupancy, lres_stats, left.seq=right.seq,
		transform(risk_indicators.Layout_Boca_Shell,

	SELF.Other_Address_Info.max_lres := right.max_lres;
	SELF.Other_Address_Info.avg_lres := (integer)right.avg_lres;

			self := left), left outer, keep(1));

	// output(with_addr_history, named('with_addr_history'));
	// output(occupancy_sorted, named('occupancy_sorted'));
	// output(iterated_addresses, named('iterated_addresses'));
	// output(occupied_address, named('occupied_address'));
	// output(with_occupancy, named('with_occupancy'));

	// output(mostRecent4, named('mostRecent4'));
	// output(lres_stats, named('lres_stats'));
	// output(with_addr_history, named('with_addr_history'));
	// output(iterated_addresses, named('iterated_addresses'));
	// output(occupied_address, named('occupied_address'));
	// output(with_occupancy, named('with_occupancy'));
	// output(choosen(occupied_address(bus_addr_only_curr = 1), 10), named('bus_addr_only_curr'));
	// output(choosen(occupied_address(bus_addr_only = 1), 10), named('bus_addr_only'));
	
	return with_length_of_residence;
	
end;

// Occupancy Index: 
// 	0 – No address given or No addresses available on header

// 	1 - Currently Occupied
// Input/Current address matches the “Occupied Address” found when applying Occupancy Logic.

// 	2 - Occupancy Unclear (Current Occupancy Shown at 2+ addresses)
// After applying the Occupancy Logic, 2 or more addresses still appear tied and the input/current address matches one of them.

// 	3 - Unoccupied Associated Address
// After applying the Occupancy Logic, the input/current address does not match the Occupied Address, but does match another address in the Address History as defined using the Address History Logic

// 	4 - Unoccupied and No Association with LexID
// After applying the Occupancy Logic, the input address does not match the Occupied Address, and also does not appear in the LexIDs address history

// 	5 - Verified PO Box – alternative street address currently occupied 
// Input address is a PO Box that is associated with the LexID AND a street address is found to be currently occupied

// 	6 - Verified PO Box – no street address currently listed 
// Input address is a PO Box that is associated with the LexID AND there is no street address currently occupied

// 	7 - Unverified PO Box – alternative street address currently occupied
// Input address is  PO Box that is NOT found with the LexID AND a street address is found to be currently occupied

// 	8 - Unverified PO Box – no street address currently listed
// Input address is a PO Box that is NOT found with the LexID AND there is no street address currently occupied

