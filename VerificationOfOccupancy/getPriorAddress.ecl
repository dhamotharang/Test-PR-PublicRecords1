	import Risk_Indicators, RiskWise, MDR, Doxie, Suppress, drivers, dx_header, VerificationOfOccupancy;

EXPORT getPriorAddress(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell, 
													 DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) allHeader, 
																		string50 DataRestrictionMask, 
																		boolean glb_ok,
																		integer dppa,
																		boolean isUtility,
																		boolean dppa_ok,
																		boolean fares_ok = true,
                                                                        doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
                                    

// ******************************************************************************************************************************
// For attribute 'PriorAddressMoveIndex' - 
// ******************************************************************************************************************************
	isFCRA := false;
	headerKey := dx_header.key_addr_hist();
	dk := choosen(dx_header.key_max_dt_last_seen(), 1);
	hdrBuildDate01 := ((string)dk[1].max_date_last_seen)[1..6];
   
//first dedup the allHeader file by seq and address to keep only one record per address for the subject
	dedupHeader := dedup(sort(allHeader, seq, h.prim_range, h.predir, h.prim_name, h.suffix, h.postdir, h.sec_range, h.zip),  
																			 seq, h.prim_range, h.predir, h.prim_name, h.suffix, h.postdir, h.sec_range, h.zip);
	 																	 
//join our target DID's header records to the address hierarchy key to append address history sequence number
	VerificationOfOccupancy.Layouts.Layout_VOOShell getAddrSeqs(dedupHeader le, headerKey ri) := TRANSFORM

		address_history_seq := map( ri.address_history_seq  in [0,91,92,93,94,95,96,97,98,99] or ri.addresstype='BUS' => 255,
																// le.addr_type ='P' => 255,
																le.h.prim_name[1..6] ='PO BOX' => 255,  //exclude PO Box addresses
																le.zip4='' => 255,
																ri.source_count=1 and ri.insurance_source_count=0 and ri.property_source_count=0 and 
																ri.utility_source_count=0 and ri.vehicle_source_count=0 and ri.dl_source_count=0 and ri.voter_source_count=0 => 255,													
																ri.source_count=1 and le.h.src in 
																[mdr.sourcetools.src_Equifax,	mdr.sourcetools.src_Experian_Credit_Header,	mdr.sourcetools.src_TransUnion,
																mdr.sourcetools.src_TUCS_Ptrack, mdr.sourcetools.src_TU_CreditHeader,	mdr.sourcetools.src_Lexis_Trans_Union] => 255,
																ri.address_history_seq);	  // leave it as is by default	

		SELF.prior_addr_address_history_seq	:= address_history_seq;
		SELF 																:= le;
	END;
	
	allAddrSeqs := join(dedupHeader, headerKey,
													keyed(left.DID = right.s_did) and
													left.h.zip <> '' and left.h.prim_name <> '' and
													left.h.prim_range = right.prim_range and
													left.h.predir = right.predir and
													left.h.prim_name = right.prim_name and
													left.h.suffix = right.suffix and
													left.h.postdir = right.postdir and
													left.h.sec_range = right.sec_range and
													left.h.zip = right.zip and
													right.addresstype <> 'BUS',
									 getAddrSeqs(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost));

//each unique address now has assigned sequence. drop any bad addresses (0 or 9x), sort by seq / address seq and keep only first two.
	dedupAddrs := dedup(sort(allAddrSeqs(prior_addr_address_history_seq <> 255), seq, prior_addr_address_history_seq), 

 
																																																							seq, keep(2));
//reassign the sequence number in case there are holes (eg - change 1,3,4... to 1,2,3...) 
	groupAddrs := group(dedupAddrs, seq);
	reseqAddrs := iterate(groupAddrs, transform(VerificationOfOccupancy.Layouts.Layout_VOOShell, self.prior_addr_address_history_reseq := counter, self := right));

//the record with "re-sequenced" value of '2' will be the subject's prior address (will exist in the header portion of the VOO layout)
	priorAddrs := reseqAddrs(prior_addr_address_history_reseq = 2);

//go get all of our input subject's owned properties
	propsOwned	:= VerificationOfOccupancy.getPropOwnership(ungroup(priorAddrs), fares_ok); 

//join the prior address to the DID's owned properties and pick up the owned/sold indicators
	VerificationOfOccupancy.Layouts.Layout_VOOShell getOwnedProps(priorAddrs le, propsOwned ri) := TRANSFORM
		zip_score := Risk_Indicators.AddrScore.zip_score(le.h.zip, ri.property_zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.h.city_name, le.h.st, ri.property_city, ri.property_st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.h.prim_range, le.h.prim_name, le.h.sec_range, 
																														 ri.property_prim_range, ri.property_prim_name, ri.property_sec_range,
																														 zip_score, cityst_score);
		addr_match := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.h.prim_range = ri.property_prim_range;

		SELF.prior_addr_match 	:= addr_match;
		SELF.prior_addr_owned 	:= if(addr_match, ri.property_owned, '0');
		SELF.prior_addr_sold		:= if(addr_match, ri.property_sold, '0');
		SELF 										:= le;
	END;	

	with_PriorOwned := join(priorAddrs, propsOwned, 
				left.seq = right.seq,
				getOwnedProps(left,right),left outer, ATMOST(riskwise.max_atmost));
				
	sortProperty := sort(with_PriorOwned, seq, -prior_addr_match);

	// sortProperty := sort(priorAddrs, seq);

//rollup by seq to set owned/sold flags for subject's prior address.   
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollProperty(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.prior_addr_owned 						:= if(r.prior_addr_match and r.prior_addr_owned='1', r.prior_addr_owned, l.prior_addr_owned);
		self.prior_addr_sold 							:= if(r.prior_addr_match and r.prior_addr_sold='1', r.prior_addr_sold, l.prior_addr_sold);
		self															:= l;
	end;
	
  rolled_Property := rollup(sortProperty, rollProperty(left,right), seq);
 VerificationOfOccupancy_CCPA := RECORD
	 VerificationOfOccupancy.Layouts.Layout_VOOShell;
	 Unsigned4 Global_sid;
   end;
//get DIDs associated with the prior address 
  Key_Header_Address := dx_header.key_header_address();
	 VerificationOfOccupancy_CCPA getPriorDIDs(rolled_Property le, Key_Header_Address ri) := TRANSFORM
		SELF.prior_addr_current				:= trim((string)ri.dt_last_seen) >= hdrBuildDate01 OR ri.dt_last_seen >= le.historydate; //within 1 yr
		SELF.prior_addr_DID 					:= ri.DID;
    SELF.Global_Sid := ri.Global_Sid;
		SELF.prior_addr_dt_first_seen := ri.dt_first_seen;
		SELF.prior_addr_dt_last_seen 	:= ri.dt_last_seen;
		SELF 													:= le;
	END;
	
	priorAddrDIDs_unsuppressed := join(rolled_Property, Key_Header_Address,
												keyed(left.h.prim_name = right.prim_name) and
												keyed(left.h.zip = right.zip) and
												keyed(left.h.prim_range = right.prim_range) and
												keyed(left.h.sec_range = right.sec_range) and
												left.h.predir = right.predir and left.h.suffix = right.suffix and left.h.postdir = right.postdir and  
												right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) and
												(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
												glb_ok AND
												(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
												(~mdr.Source_is_DPPA(RIGHT.src) OR 
													(dppa_ok AND drivers.state_dppa_ok(dx_header.functions.translateSource(RIGHT.src),DPPA,RIGHT.src))),
									 getPriorDIDs(LEFT,RIGHT), left outer, ATMOST(RiskWise.max_atmost));           
                   
    priorAddrDIDs_flagged := Suppress.MAC_FlagSuppressedSource(priorAddrDIDs_unsuppressed, mod_access);

	priorAddrDIDs := PROJECT(priorAddrDIDs_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
		SELF.prior_addr_current				:= IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.prior_addr_current);
		SELF.prior_addr_DID 					:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_addr_DID);
		SELF.prior_addr_dt_first_seen      := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_addr_dt_first_seen);
		SELF.prior_addr_dt_last_seen 	    := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_addr_dt_last_seen);
		SELF := LEFT;
	)); 
//Dedup to just a list of DIDs associated with prior address - if any are currently updating, save that one for the DID
	dedupAddrDIDs := dedup(sort(priorAddrDIDs, seq, prior_addr_DID, -prior_addr_current), seq, prior_addr_DID);  

//apply HouseHold ID to each DID found at the prior address and flag subject and/or prior DIDs if currently updating at that address
  key_header := dx_header.key_header();
	 VerificationOfOccupancy_CCPA getHHIDs(dedupAddrDIDs le, key_header ri) := TRANSFORM
		SELF.prior_addr_HHID 						:= ri.HHID;
		SELF.Global_Sid := ri.Global_Sid;
    SELF.prior_addr_rpting_subject 	:= le.h.HHID = ri.HHID and le.prior_addr_current;  //target subject is still being reported at their prior address
		SELF.prior_addr_rpting_newID 		:= le.h.HHID <> ri.HHID and le.prior_addr_current; //other people are currently being reported at the subject's prior address
		SELF 														:= le;
	END;
	
	priorAddrHHIDs_unsuppressed := join(dedupAddrDIDs, key_header,
									keyed(left.prior_addr_DID = right.s_DID) and 
									left.h.prim_name = right.prim_name and
									left.h.zip = right.zip and
									left.h.prim_range = right.prim_range and
									left.h.sec_range = right.sec_range and
									left.h.predir = right.predir and left.h.suffix = right.suffix and left.h.postdir = right.postdir and
									(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
									right.hhid <> 0,
									getHHIDs(LEFT,RIGHT), left outer, KEEP(1), ATMOST(100));  //just apply HHID to the 1 record we are joining
                  
    priorAddrHHIDs_flagged := Suppress.MAC_FlagSuppressedSource(priorAddrHHIDs_unsuppressed, mod_access);

	priorAddrHHIDs := PROJECT(priorAddrHHIDs_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
		SELF.prior_addr_HHID 						:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_addr_HHID);
        SELF.prior_addr_rpting_subject 	    := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.prior_addr_rpting_subject);
		SELF.prior_addr_rpting_newID 		:= IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.prior_addr_rpting_newID);
		SELF := LEFT;
	)); 
  
//rollup by sequence to set the updating status flags for the subject's prior address
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollPriorHHIDs(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.prior_addr_current 				:= if(r.prior_addr_current, r.prior_addr_current, l.prior_addr_current);
		self.prior_addr_rpting_subject 	:= if(r.prior_addr_rpting_subject, r.prior_addr_rpting_subject, l.prior_addr_rpting_subject);
		self.prior_addr_rpting_newID 		:= if(r.prior_addr_rpting_newID, r.prior_addr_rpting_newID, l.prior_addr_rpting_newID);
		self														:= l;
	end;
	
  rolled_PriorHHIDs := rollup(priorAddrHHIDs, rollPriorHHIDs(left,right), seq);

  // output(allHeader, named('allHeader'));
  // output(dedupHeader, named('dedupHeader'));
  // output(allAddrSeqs, named('allAddrSeqs'));
  // output(dedupAddrs, named('dedupAddrs'));
  // output(reseqAddrs, named('reseqAddrs'));
  // output(priorAddrs, named('priorAddrs'));
  // output(propsOwned, named('propsOwned'));
  // output(with_PriorOwned, named('with_PriorOwned'));
  // output(sortProperty, named('sortProperty'));
  // output(rolled_Property, named('rolled_Property'));
  // output(priorAddrDIDs, named('priorAddrDIDs'));
  // output(dedupAddrDIDs, named('dedupAddrDIDs'));
  // output(priorAddrHHIDs, named('priorAddrHHIDs'));
  // output(rolled_PriorHHIDs, named('rolled_PriorHHIDs'));

	return rolled_PriorHHIDs;	
	
END;
