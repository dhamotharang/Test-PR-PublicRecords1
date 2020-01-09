import Risk_Indicators, ut, RiskWise, header_quick, MDR, suppress, drivers, std, VerificationOfOccupancy, dx_header, inquiry_acclogs, Doxie;

EXPORT getPriorResident(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell, 
																		string50 DataRestrictionMask, 
																		boolean glb_ok,
																		integer dppa,
																		boolean isUtility,
																		boolean dppa_ok,
																		boolean fares_ok = true,
                                    Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess)end) := FUNCTION

	isFCRA := false;

// ******************************************************************************************************************************
// For attribute 'PriorResidentMoveIndex' - this is using Household ID to determine prior resident
// ******************************************************************************************************************************

//get all DIDs associated with our target input address
  Key_Header_Address := dx_header.key_header_address();
  VerificationOfOccupancy_CCPA := RECORD
  VerificationOfOccupancy.Layouts.Layout_VOOShell;
  Unsigned4 Global_sid;
  end;
	VerificationOfOccupancy_CCPA getDIDs(VOOShell le, Key_Header_Address ri) := TRANSFORM
  self.Global_sid := ri.global_sid;  
  SELF.prior_res_DID 							:= ri.DID;
  SELF.prior_res_dt_first_seen 		:= ri.dt_first_seen;
  SELF.prior_res_dt_last_seen 		:= ri.dt_last_seen;
  SELF.prior_res_fname 						:= ri.fname;
  SELF.prior_res_lname 						:= ri.lname;
  SELF.prior_res_target_addrmatch := le.DID = ri.DID;  //flag records that match our input subject's DID  
  SELF 														:= le;
	END;
	
	resDIDs_unsuppressed := join(VOOShell, Key_Header_Address,
													keyed(left.prim_name = right.prim_name) and
													keyed(left.z5 = right.zip) and
													keyed(left.prim_range = right.prim_range) and
													keyed(left.sec_range = right.sec_range) and
													left.predir = right.predir and left.addr_suffix = right.suffix and left.postdir = right.postdir and 
													(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen < LEFT.h.dt_first_seen) and // Keep only recs that are prior to the earliest first seen date of our subject
													glb_ok AND
													(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
													(~mdr.Source_is_DPPA(RIGHT.src) OR 
														(dppa_ok AND drivers.state_dppa_ok(dx_header.functions.translateSource(RIGHT.src),DPPA,RIGHT.src))),
									getDIDs(LEFT,RIGHT), left outer, ATMOST(5000));
                  
    resDIDs_flagged := Suppress.MAC_FlagSuppressedSource(resDIDs_unsuppressed, mod_access);

	resDIDs := PROJECT(resDIDs_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
            SELF.prior_res_DID 							:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_res_DID);
            SELF.prior_res_dt_first_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_res_dt_first_seen);
            SELF.prior_res_dt_last_seen 		:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_res_dt_last_seen);
            SELF.prior_res_fname 						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prior_res_fname);
            SELF.prior_res_lname 						:= IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prior_res_lname);
            SELF.prior_res_target_addrmatch := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.prior_res_target_addrmatch);
			SELF := LEFT;
	));          

//no need to keep all records, keep only the most recent for each "prior resident" DID
	dedupDIDs := dedup(sort(resDIDs, seq, prior_res_DID, -prior_res_dt_last_seen, -prior_res_dt_first_seen), seq, prior_res_DID);

//apply HouseHold ID (HHID) to each of the header records we found above so we can link household members
	key_header := dx_header.key_header();
	 VerificationOfOccupancy_CCPA getHHIDs(dedupDIDs le, key_header ri) := TRANSFORM
		SELF.prior_res_HHID 	:= ri.HHID;
        self.Global_sid := ri.global_sid;		
        SELF 										:= le;
	END;
	
	resHHIDs_unsuppressed := join(dedupDIDs, key_header,
									keyed(left.prior_res_DID = right.s_DID) and 
									left.prim_name = right.prim_name and
									left.z5 = right.zip and
									left.prim_range = right.prim_range and
									left.sec_range = right.sec_range and
									left.predir = right.predir and left.addr_suffix = right.suffix and left.postdir = right.postdir and
									right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) AND
									(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
									glb_ok AND
									(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
									(~mdr.Source_is_DPPA(RIGHT.src) OR 
										(dppa_ok AND drivers.state_dppa_ok(dx_header.functions.translateSource(RIGHT.src),DPPA,RIGHT.src))),
									getHHIDs(LEFT,RIGHT), left outer, KEEP(1), ATMOST(riskwise.max_atmost));  //just apply HHID to the 1 record we are joining
                  
    resHHIDs_flagged := Suppress.MAC_FlagSuppressedSource(resHHIDs_unsuppressed, mod_access);

	resHHIDs := PROJECT(resHHIDs_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
            SELF.prior_res_HHID 	:= IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.prior_res_HHID);
			SELF := LEFT;
	));     
//of all prior residents at this address, keep just the most recent
	dedupHHIDs := dedup(sort(resHHIDs, seq, -prior_res_dt_last_seen, -prior_res_dt_first_seen), seq);

//join most recent prior resident to all prior residents by HHID.  This will be our prior resident's household members.
	VerificationOfOccupancy.Layouts.Layout_VOOShell getPriorHH(dedupHHIDs le, resHHIDs ri) := TRANSFORM
		SELF 									:= ri;
	END;
	
	priorHH := join(dedupHHIDs, resHHIDs,
									left.seq = right.seq and left.prior_res_HHID = right.prior_res_HHID,
									getPriorHH(LEFT,RIGHT), left outer);  

//need to move the prior resident DID and name to the input fields before calling the property ownership function
	priorHHProject := project(priorHH, transform( VerificationOfOccupancy.Layouts.Layout_VOOShell, 
			self.DID 		:= left.prior_res_DID, 
			self.fname 	:= left.prior_res_fname, 
			self.lname 	:= left.prior_res_lname, 
			self 				:= left));

//go get owned properties for all prior residents
	propsOwned	:= VerificationOfOccupancy.getPropOwnership(ungroup(priorHHProject), fares_ok); 

//join the owned properties and pick up the owned/sold indicators
	VerificationOfOccupancy.Layouts.Layout_VOOShell getOwnedProps(priorHH le, propsOwned ri) := TRANSFORM
		SELF.prior_res_target_addrmatch	:= ri.property_match; 	
		SELF.prior_res_owned_target			:= if(ri.property_match, ri.property_owned, '0');
		SELF.prior_res_sold_target			:= if(ri.property_match, ri.property_sold, '0');		
		SELF.prior_res_owned_other			:= if(~ri.property_match, ri.property_owned, '0');
		SELF.prior_res_sold_other				:= if(~ri.property_match, ri.property_sold, '0');
		SELF.prior_res_prim_range				:= ri.property_prim_range; 	
		SELF.prior_res_predir						:= ri.property_predir;		
		SELF.prior_res_prim_name				:= ri.property_prim_name;	
		SELF.prior_res_addr_suffix			:= ri.property_suffix;  
		SELF.prior_res_postdir					:= ri.property_postdir;		
		SELF.prior_res_unit_desig				:= ri.property_unit_desig;	
		SELF.prior_res_sec_range				:= ri.property_sec_range;	
		SELF.prior_res_city							:= ri.property_city;	
		SELF.prior_res_st								:= ri.property_st;	
		SELF.prior_res_zip							:= ri.property_zip;
		SELF.prior_res_Fares_target_dt_first_seen	:= if(self.prior_res_owned_target='1', ri.property_dt_first_seen, 0);
		SELF.prior_res_Fares_other_dt_first_seen	:= if(self.prior_res_owned_other='1', ri.property_dt_first_seen, 0);
		SELF														:= le;
	END;	

	with_Owned := join(priorHH, propsOwned,  //join back to the file before the project was done to move prior res DID to the subject's DID
				left.seq = right.seq and 
				left.prior_res_DID = right.DID,  	 //the DID coming back is the prior resident's DID
				getOwnedProps(left,right),left outer, ATMOST(riskwise.max_atmost));
				

	sortProperty := sort(with_Owned, seq, prior_res_DID, -prior_res_target_addrmatch);

//rollup by seq to set the owned/sold flags for the target address
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollProperty(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.prior_res_owned_target 				:= if(l.prior_res_owned_target='1' or r.prior_res_owned_target='1', '1', '0');
		self.prior_res_sold_target 					:= if(l.prior_res_sold_target='1' or r.prior_res_sold_target='1', '1', '0');
		self.prior_res_owned_other 					:= if(l.prior_res_owned_other='1' or r.prior_res_owned_other='1', '1', '0');
		self.prior_res_sold_other 					:= if(l.prior_res_sold_other='1' or r.prior_res_sold_other='1', '1', '0');
		self.prior_res_Fares_target_dt_first_seen	:= map( r.prior_res_Fares_target_dt_first_seen = 0																				=> l.prior_res_Fares_target_dt_first_seen,
																											l.prior_res_Fares_target_dt_first_seen = 0																				=> r.prior_res_Fares_target_dt_first_seen,
																											r.prior_res_Fares_target_dt_first_seen < l.prior_res_Fares_target_dt_first_seen		=> r.prior_res_Fares_target_dt_first_seen, //we want the earliest first seen date
																																																																					 l.prior_res_Fares_target_dt_first_seen);
		self.prior_res_Fares_other_dt_first_seen	:= map( r.prior_res_Fares_other_dt_first_seen = 0																					=> l.prior_res_Fares_other_dt_first_seen,
																											l.prior_res_Fares_other_dt_first_seen = 0																					=> r.prior_res_Fares_other_dt_first_seen,
																											r.prior_res_Fares_other_dt_first_seen < l.prior_res_Fares_other_dt_first_seen			=> r.prior_res_Fares_other_dt_first_seen, //we want the earliest first seen date
																																																																					 l.prior_res_Fares_other_dt_first_seen);
		self																:= l;
	end;
	
  rolled_Property := rollup(sortProperty, rollProperty(left,right), seq, prior_res_DID);

// Join prior resident DIDs to header and determine if any address is being reported for them that is newer than the target address
	dk := choosen(dx_header.key_max_dt_last_seen(), 1);
	hdrBuildDate01 := dk[1].max_date_last_seen[1..6];
	
headerMacro(transformName, keyName) := MACRO
	VerificationOfOccupancy_CCPA transformName(VerificationOfOccupancy.Layouts.Layout_VOOShell l, keyName r) := transform
		self.Global_sid := r.global_sid;
    self.prior_res_new_addr 	:= r.DID <> 0; //we found a header record for this DID that has a newer address than the target address
		self											:= l;
	end;
endmacro;

	// Initialize the full header and quick header transforms
	headerMacro(getHeader, key_header);
	headerMacro(getQHeader, header_quick.key_DID);

	newerHeader_unsuppressed := join(rolled_Property, key_header,	
									LEFT.prior_res_DID <> 0 AND
									keyed(left.prior_res_DID = right.s_DID) and
									// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
									right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) AND
									(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) AND // Check the history date
									glb_ok AND
									(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
									(~mdr.Source_is_DPPA(RIGHT.src) OR 
										(dppa_ok AND drivers.state_dppa_ok(dx_header.functions.translateSource(RIGHT.src),DPPA,RIGHT.src))) AND
									(RIGHT.dt_last_seen > LEFT.prior_res_dt_last_seen) AND  //we only want addresses newer than the target address
									(left.prim_name <> right.prim_name or  //if address matches the target address, skip it - we only want if newer
									 left.z5 <> right.zip or
									 left.prim_range <> right.prim_range or
									 left.sec_range <> right.sec_range or
									 left.predir <> right.predir or 
									 left.addr_suffix <> right.suffix or 
									 left.postdir <> right.postdir), 
									getHeader(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));
                  
    newerHeader_flagged := Suppress.MAC_FlagSuppressedSource(newerHeader_unsuppressed, mod_access);

	newerHeader := PROJECT(newerHeader_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
            SELF.prior_res_new_addr 	:= IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.prior_res_new_addr);
			SELF := LEFT;
	));     
  
	newerQHeader_unsuppressed := join(rolled_Property, header_quick.key_DID,		
									LEFT.prior_res_DID <> 0 AND
									keyed(left.prior_res_DID = right.DID) and
									// trim((string)right.dt_last_seen) >= hdrBuildDate01 and
									right.src not in risk_indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) + 
									// If we have an Equifax data restriction, restrict the QH and WH sources (This isn't caught in the masked_header_source)
									IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = '1', [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], []) AND
									(RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) AND // Check the history date
									glb_ok AND
									(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
									(~mdr.Source_is_DPPA(RIGHT.src) OR 
										(dppa_ok AND drivers.state_dppa_ok(dx_header.functions.translateSource(RIGHT.src),DPPA,RIGHT.src))) AND
									(RIGHT.dt_last_seen > LEFT.prior_res_dt_last_seen) AND  //we only want addresses newer than the target address
									(left.prim_name <> right.prim_name or  //skip the target address
									 left.z5 <> right.zip or
									 left.prim_range <> right.prim_range or
									 left.sec_range <> right.sec_range or
									 left.predir <> right.predir or 
									 left.addr_suffix <> right.suffix or 
									 left.postdir <> right.postdir),  
									getQHeader(left, right), keep(200), ATMOST(RiskWise.max_atmost));
                  
	newerQHeader_flagged := Suppress.MAC_FlagSuppressedSource(newerQHeader_unsuppressed, mod_access);

	newerQHeader := PROJECT(newerQHeader_flagged, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
            SELF.prior_res_new_addr 	:= IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.prior_res_new_addr);
			SELF := LEFT;
	)); 
//rollup by sequence to set the ownership flags for all prior residents as though they are one entity.  I.E. - if any DID within the 
//	prior resident "household" has any of the owned/sold/new_addr/acct_open flags set, set it on for the record being returned.
  VerificationOfOccupancy.Layouts.Layout_VOOShell rollHeader(VerificationOfOccupancy.Layouts.Layout_VOOShell l, VerificationOfOccupancy.Layouts.Layout_VOOShell r) := transform
		self.prior_res_target_addrmatch := l.prior_res_target_addrmatch or r.prior_res_target_addrmatch;
		self.prior_res_owned_target 		:= if(l.prior_res_owned_target='1' or r.prior_res_owned_target='1', '1', '0');
		self.prior_res_sold_target 			:= if(l.prior_res_sold_target='1' or r.prior_res_sold_target='1', '1', '0');
		self.prior_res_owned_other 			:= if(l.prior_res_owned_other='1' or r.prior_res_owned_other='1', '1', '0');
		self.prior_res_sold_other 			:= if(l.prior_res_sold_other='1' or r.prior_res_sold_other='1', '1', '0');
		self.prior_res_Fares_target_dt_first_seen	:= map( r.prior_res_Fares_target_dt_first_seen = 0																				=> l.prior_res_Fares_target_dt_first_seen,
																											l.prior_res_Fares_target_dt_first_seen = 0																				=> r.prior_res_Fares_target_dt_first_seen,
																											r.prior_res_Fares_target_dt_first_seen < l.prior_res_Fares_target_dt_first_seen		=> r.prior_res_Fares_target_dt_first_seen, //we want the earliest first seen date
																																																																					 l.prior_res_Fares_target_dt_first_seen);
		self.prior_res_Fares_other_dt_first_seen	:= map( r.prior_res_Fares_other_dt_first_seen = 0																					=> l.prior_res_Fares_other_dt_first_seen,
																											l.prior_res_Fares_other_dt_first_seen = 0																					=> r.prior_res_Fares_other_dt_first_seen,
																											r.prior_res_Fares_other_dt_first_seen < l.prior_res_Fares_other_dt_first_seen			=> r.prior_res_Fares_other_dt_first_seen, //we want the earliest first seen date
																																																																					 l.prior_res_Fares_other_dt_first_seen);
		self.prior_res_new_addr 				:= l.prior_res_new_addr or r.prior_res_new_addr;
		self														:= l;
	end;
	
  rolledHeader := rollup(sort(ungroup(newerHeader) & ungroup(newerQHeader), seq), rollHeader(left,right), seq);

// Join prior resident DIDs to inquiries to see if any account opening searches exist within the last year for an address other than the target address
	layout_inq := record
		unsigned4 seq;
		unsigned6 s_did;
    
    
		inquiry_acclogs.Layout.common_indexes;
	end;

  VerificationOfOccupancy_CCPA_E := RECORD
	 layout_inq;
   Unsigned4 Global_sid;
   Unsigned6 did;  
     end;
		VerificationOfOccupancy_CCPA_E get_inquiry(rolled_Property le, Inquiry_AccLogs.Key_Inquiry_DID ri) := TRANSFORM
		SELF.Global_Sid := ri.ccpa.Global_Sid;
		Self.did := ri.s_did;
    self.seq 	:= le.seq;
		self 			:= ri;
	END;	

	inquiry_Recs := join(rolled_Property, Inquiry_AccLogs.Key_Inquiry_DID, 
						left.prior_res_DID<>0 and keyed(left.prior_res_DID=right.s_did) and
						right.search_info.datetime <> '' and
						(unsigned)right.search_info.datetime[1..6] <= left.historydate and
						(unsigned)right.search_info.datetime[1..6] >= left.historydate - 100 and  //keep inquiries within 1 year of input date
						trim(right.bus_intel.use) = '' and  
						trim(right.search_info.product_code) in Inquiry_AccLogs.shell_constants.valid_product_codes and   
						trim(right.search_info.function_description) in Inquiry_AccLogs.shell_constants.VOO_search_functions and
						//filter out 'collections' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isCollection)
						trim(STD.Str.ToUpperCase(right.bus_intel.vertical)) not IN Inquiry_AccLogs.shell_constants.collections_vertical_set and 
						trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.collection_industry and
						STD.Str.Find(STD.Str.ToUpperCase(trim(STD.Str.ToUpperCase(right.bus_intel.sub_market))),'FIRST PARTY', 1) < 1 and 
						//filter out 'highriskcredit' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isHighRiskCredit)
						trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
						get_inquiry(left, right),
						inner, atmost(riskwise.max_atmost * 5));	
	 get_inquiry_VerificationOfOccupancy_CCPA_E := Suppress.Suppress_ReturnOldLayout(inquiry_Recs, mod_access, layout_inq);


	VerificationOfOccupancy_CCPA_E get_inquiry_update(rolled_Property le, Inquiry_AccLogs.Key_Inquiry_DID_Update ri) := TRANSFORM
		
    self.seq 	:= le.seq; 
    SELF.Global_Sid := ri.ccpa.Global_Sid;
		Self.did := ri.s_did;
		self 			:= ri;
	END;
						
	inquiry_update_Recs := join(rolled_Property, Inquiry_AccLogs.Key_Inquiry_DID_Update, 
						left.did<>0 and keyed(left.did=right.s_did) and
						right.search_info.datetime <> '' and
						(unsigned)right.search_info.datetime[1..6] <= left.historydate and
						(unsigned)right.search_info.datetime[1..6] >= left.historydate - 100 and  //keep inquiries within 1 year of input date
						trim(right.bus_intel.use) = '' and  
						trim(right.search_info.product_code) in Inquiry_AccLogs.shell_constants.valid_product_codes and   
						trim(right.search_info.function_description) in Inquiry_AccLogs.shell_constants.VOO_search_functions and
						// filter out 'collections' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isCollection)
						trim(STD.Str.ToUpperCase(right.bus_intel.vertical)) not in Inquiry_AccLogs.shell_constants.collections_vertical_set and 
						trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.collection_industry and
						STD.Str.Find(STD.Str.ToUpperCase(trim(STD.Str.ToUpperCase(right.bus_intel.sub_market))),'FIRST PARTY', 1) < 1 and 
						// filter out 'highriskcredit' to coincide with Shell 5 (mimic Risk_Indicators.Boca_Shell_Inquiries.isHighRiskCredit)
						trim(STD.Str.ToUpperCase(right.bus_intel.industry)) not IN Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5,
						get_inquiry_update(left, right),
						inner, atmost(riskwise.max_atmost * 5));	
	 get_inquiry__update_VerificationOfOccupancy_CCPA_E := Suppress.Suppress_ReturnOldLayout(inquiry_update_Recs, mod_access, layout_inq);

//keep only one inquiry record per unique address
	dedup_inquiries := dedup(sort(ungroup(get_inquiry_VerificationOfOccupancy_CCPA_E) & ungroup(get_inquiry__update_VerificationOfOccupancy_CCPA_E), seq, s_did, person_q.zip5, person_q.prim_range, person_q.sec_range, person_q.prim_name, person_q.addr_suffix, person_q.predir, person_q.postdir), 
																																											seq, s_did, person_q.zip5, person_q.prim_range, person_q.sec_range, person_q.prim_name, person_q.addr_suffix, person_q.predir, person_q.postdir
													 ); 

	VerificationOfOccupancy.Layouts.Layout_VOOShell get_inq_hdr(rolledHeader l, dedup_inquiries r) := transform
		addrmatch									:= if(trim(l.z5) = trim(r.person_q.zip5) and
																		trim(l.prim_range) = trim(r.person_q.prim_range) and
																		ut.NNEQ(trim(l.sec_range), trim(r.person_q.sec_range)) and
																		trim(l.prim_name) = trim(r.person_q.prim_name) and
																		trim(l.addr_suffix) = trim(r.person_q.addr_suffix) and
																		trim(l.predir) = trim(r.person_q.predir) and
																		trim(l.postdir) = trim(r.person_q.postdir), true, false);
		self.prior_res_acct_open	:= if(trim(r.person_q.zip5) <> '' and trim(r.person_q.prim_range) <> '' and trim(r.person_q.prim_name) <> '' and not addrmatch, true, false);	//address is different than target and inquiry is within 1 year	
		self											:= l;
	end;	

	inq_hdr_recs := join(rolledHeader, dedup_inquiries,
						left.seq = right.seq, 
						get_inq_hdr(left, right),
						left outer, atmost(5000));

// Rollup by seq and indicate if any prior residents had account opening searches in the last year at a different address than target 
  VerificationOfOccupancy.Layouts.Layout_VOOShell roll_inqHdr(inq_hdr_recs l, inq_hdr_recs r) := transform
		self.prior_res_acct_open 	:= l.prior_res_acct_open or r.prior_res_acct_open;
		self											:= l;
	end;
	
  rolled_inqHdr := rollup(inq_hdr_recs, roll_inqHdr(left,right), seq);

  // output(resDIDs, named('resDIDs'));
  // output(dedupDIDs, named('dedupDIDs'));
  // output(resHHIDs, named('resHHIDs'));
  // output(targetHHIDs, named('targetHHIDs'));
  // output(priorHHIDs, named('priorHHIDs'));
  // output(dedupHHIDs, named('dedupHHIDs'));
  // output(priorHH, named('priorHH'));
  // output(propsOwned, named('propsOwned'));
  // output(with_Owned, named('with_Owned'));
  // output(property_by_did, named('property_by_did'));
  // output(property_searched, named('property_searched'));
  // output(sortProperty, named('sortProperty'));
  // output(rolled_Property, named('rolled_Property'));
  // output(rolledHeader, named('rolledHeader'));
  // output(inquiry_Recs, named('inquiry_Recs'));
  // output(dedup_inquiries, named('dedup_inquiries'));
  // output(inq_hdr_recs, named('inq_hdr_recs'));
  // output(rolled_inqHdr, named('rolled_inqHdr'));

	return rolled_inqHdr;	
	
END;
