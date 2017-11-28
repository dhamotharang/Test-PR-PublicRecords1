import Risk_Indicators, ut, LN_PropertyV2, RiskWise, Address;

EXPORT getPropOwnership(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) VOOShell, boolean fares_ok = true) := FUNCTION

// ******************************************************************************************************************************
// This function uses DID and date to search property data and returns the DID's owned and sold properties as of the input date.
// ******************************************************************************************************************************
  
	propKey := LN_PropertyV2.key_prop_address_v4;
	propDIDKey := LN_PropertyV2.key_property_did(isFCRA := FALSE);
	searchKey := LN_PropertyV2.key_search_fid(isFCRA := FALSE);

	todaysdate	:= ut.GetDate;
	
//Join VOOshell to property by DID to get all Fares IDs for the subject
	VerificationOfOccupancy.Layouts.Layout_property get_property_by_did(VOOShell le, propDIDKey ri) := transform
		SELF.property_fares_ID  	:= ri.ln_fares_id;
		SELF											:= le;
		SELF											:= [];
	end;	

	property_by_did := JOIN(VOOShell, propDIDKey,
					 (fares_ok or right.ln_fares_id[1]<>'R') and 
						LEFT.did<>0 AND 
						keyed(LEFT.did=RIGHT.s_did) and
						keyed(right.source_code_2 = 'P'),
						get_property_by_did(LEFT,RIGHT), KEEP(1000), ATMOST( keyed(LEFT.did=RIGHT.s_did) and keyed(right.source_code_2 = 'P'), RiskWise.max_atmost * 2));

//join to 'key_search_fid' to get all addresses associated with the subject's Fares IDs 
	VerificationOfOccupancy.Layouts.Layout_property getSearch_FID(property_by_did le, searchKey ri) := TRANSFORM
		fname_match := Risk_Indicators.g(Risk_Indicators.FnameScore(le.fname,ri.fname));
		lname_match := Risk_Indicators.g(Risk_Indicators.LnameScore(le.lname,ri.lname));
		person_match := (lname_match and fname_match) or le.DID = ri.DID;
		SELF.property_person_match := person_match;
		property_owned 						:= if(ri.source_code_1='O' and person_match, '1', '0');  
		SELF.property_owned 			:= property_owned;
		SELF.property_prim_range	:= ri.prim_range; 	
		SELF.property_predir			:= ri.predir;		
		SELF.property_prim_name		:= ri.prim_name;	
		SELF.property_suffix			:= ri.suffix;  
		SELF.property_postdir			:= ri.postdir;	
		SELF.property_unit_desig	:= ri.unit_desig;	
		SELF.property_sec_range		:= ri.sec_range;	
		SELF.property_city				:= ri.p_city_name;	
		SELF.property_st					:= ri.st;	
		SELF.property_zip					:= ri.zip;	
		SELF.property_lat  				:= ri.geo_lat;	
		SELF.property_long  			:= ri.geo_long;
		
		zip_score := Risk_Indicators.AddrScore.zip_score(le.z5, ri.zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.p_city_name, le.st, ri.p_city_name, ri.st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																														 ri.prim_range, ri.prim_name, ri.sec_range,
																														 zip_score, cityst_score);
		addr_match := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.prim_range = ri.prim_range;
		
		SELF.property_match  			:= addr_match;  //set boolean to indicate property address matches target address
		SELF := le;
	END;

	property_searched := JOIN(property_by_did,searchKey,
													 (fares_ok or right.ln_fares_id[1]<>'R') and
														keyed(LEFT.property_fares_id=RIGHT.ln_fares_id) AND
														wild(right.which_orig) and
														keyed(RIGHT.source_code_2='P') AND
														keyed(RIGHT.source_code_1 in ['O']) AND //we only care about owned properties so drop any other records
													 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) AND
														RIGHT.prim_name <> '' and RIGHT.zip <> '',
														getSearch_FID(LEFT,RIGHT),LEFT OUTER, keep(1000), ATMOST(
															keyed(LEFT.property_fares_ID=RIGHT.ln_fares_id) AND
															wild(right.which_orig) and
															keyed(RIGHT.source_code_2='P') AND
															keyed(RIGHT.source_code_1 in ['O']),
															RiskWise.max_atmost));

// Keep only properties that were ever owned by the subject and keep only one record per address
	dedupProp := dedup(sort(property_searched(property_owned='1'), seq, property_prim_name, property_prim_range, property_zip)
																															 , seq, property_prim_name, property_prim_range, property_zip);

	otherFaresRec := RECORD
		VerificationOfOccupancy.Layouts.Layout_property;
		DATASET({STRING12 ln_fare_id}) property_fares;
	END;


// Search propery data by input address in case the DID search did not identify the subject as the owner of the input property.
	otherFaresRec getAddrFIDs(VOOshell le, propKey ri) := TRANSFORM
		SELF.property_fares 			:= ri.fares;
		SELF											:= le;
		SELF											:= [];
	END;
	
	addrFares := join(VOOshell, propKey,
													keyed(left.prim_range = right.prim_range) and
													keyed(left.prim_name = right.prim_name) and
													keyed(left.sec_range = right.sec_range) and
													keyed(left.z5 = right.zip) and
													keyed(left.addr_suffix = right.suffix) and
													keyed(left.predir = right.predir) and
													keyed(left.postdir = right.postdir),
										 getAddrFIDs(LEFT,RIGHT), left outer, ATMOST(100)) ;

//join to 'key_search_fid' to get all addresses associated with the subject's Fares IDs 
	VerificationOfOccupancy.Layouts.Layout_property getAddrFID(addrFares le, searchKey ri) := TRANSFORM
		fname_match := Risk_Indicators.g(Risk_Indicators.FnameScore(le.fname,ri.fname));
		lname_match := Risk_Indicators.g(Risk_Indicators.LnameScore(le.lname,ri.lname));
		person_match := (lname_match and fname_match) or (le.DID <> 0 and le.DID = ri.DID);
		SELF.property_person_match := person_match;
		property_owned 						:= if(ri.source_code_1='O' and person_match, '1', '0');  
		SELF.property_owned 			:= property_owned;
		SELF.property_prim_range	:= ri.prim_range; 	
		SELF.property_predir			:= ri.predir;		
		SELF.property_prim_name		:= ri.prim_name;	
		SELF.property_suffix			:= ri.suffix;  
		SELF.property_postdir			:= ri.postdir;	
		SELF.property_unit_desig	:= ri.unit_desig;	
		SELF.property_sec_range		:= ri.sec_range;	
		SELF.property_city				:= ri.p_city_name;	
		SELF.property_st					:= ri.st;	
		SELF.property_zip					:= ri.zip;	
		SELF.property_lat  				:= ri.geo_lat;	
		SELF.property_long  			:= ri.geo_long;
		
		zip_score := Risk_Indicators.AddrScore.zip_score(le.z5, ri.zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.p_city_name, le.st, ri.p_city_name, ri.st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																														 ri.prim_range, ri.prim_name, ri.sec_range,
																														 zip_score, cityst_score);
		addr_match := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.prim_range = ri.prim_range;
		
		SELF.property_match  			:= addr_match;  //set boolean to indicate property address matches target address
		SELF := le;
	END;

	faresByAddress := JOIN(addrFares, searchKey, COUNT(LEFT.property_fares) > 0 AND (fares_ok or RIGHT.ln_fares_id[1]<>'R') and
																													KEYED(RIGHT.ln_fares_id IN SET(LEFT.property_fares, ln_fare_id)) AND
																													WILD(RIGHT.which_orig) AND
																													KEYED(RIGHT.source_code_2='P') AND
																													KEYED(RIGHT.source_code_1 = 'O') AND 
																												 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) AND
																												 	RIGHT.prim_name <> '' and RIGHT.zip <> '',
																													getAddrFID(LEFT, RIGHT), LEFT OUTER, KEEP(1000), ATMOST(RiskWise.max_atmost * 5));

// If the address search did find the owner as the input subject, narrow down to keep just that one record
	dedupPropAddr := dedup(sort(faresByAddress(property_person_match=true), seq, property_prim_name, property_prim_range, property_zip),
																																					seq, property_prim_name, property_prim_range, property_zip);

// Add on the results of the address search only if the DID search didn't already identify the subject as the input prop owner
	dedupProps := if(exists(dedupProp(property_match = true)), dedupProp, dedupProp + dedupPropAddr); 
  
// Join all of the subject's owned properties (addresses) to 'key_prop_address_v4' to get all Fares IDs associated with those properties
	otherFaresRec getFIDs(dedupProps le, propKey ri) := TRANSFORM
		SELF.property_fares := ri.fares;
		SELF := le;
	END;
	
	otherFares := join(dedupProps(property_prim_name != '', property_zip != ''), propKey,
													keyed(left.property_prim_range = right.prim_range) and
													keyed(left.property_prim_name = right.prim_name) and
													keyed(left.property_sec_range = right.sec_range) and
													keyed(left.property_zip = right.zip) and
													keyed(left.property_suffix = right.suffix) and
													keyed(left.property_predir = right.predir) and
													keyed(left.property_postdir = right.postdir),
										 getFIDs(LEFT,RIGHT), left outer, ATMOST(100)) ;
															
//join all fares IDs of our subject's owned properties back to 'key_search_fid' to get all people who have ever owned those properties   
	VerificationOfOccupancy.Layouts.Layout_property getSearch_FID2(otherFares le, searchKey ri) := TRANSFORM
		fname_match := Risk_Indicators.g(Risk_Indicators.FnameScore(le.fname,ri.fname));
		lname_match := Risk_Indicators.g(Risk_Indicators.LnameScore(le.lname,ri.lname));
		person_match := (lname_match and fname_match) or le.DID = ri.DID;
		SELF.property_person_match 		:= person_match;
		property_owned 								:= if(ri.source_code_1='O' and person_match, '1', '0');
		SELF.property_owned 					:= property_owned;
		SELF.property_fares_ID  			:= ri.ln_fares_id;
		SELF.property_dt_first_seen  	:= ri.dt_first_seen;
		SELF.property_dt_last_seen  	:= ri.dt_last_seen;
		SELF.property_prim_range			:= ri.prim_range; 	
		SELF.property_predir					:= ri.predir;		
		SELF.property_prim_name				:= ri.prim_name;	
		SELF.property_suffix					:= ri.suffix;  
		SELF.property_postdir					:= ri.postdir;		
		SELF.property_unit_desig			:= ri.unit_desig;	
		SELF.property_sec_range				:= ri.sec_range;	
		SELF.property_city						:= ri.p_city_name;	
		SELF.property_st							:= ri.st;	
		SELF.property_zip							:= ri.zip;	
		SELF.property_lat  						:= ri.geo_lat;	
		SELF.property_long  					:= ri.geo_long;
		SELF.property_date						:= (STRING)ri.process_date; // Contains the purchase or sale date

		zip_score := Risk_Indicators.AddrScore.zip_score(le.z5, ri.zip);
		cityst_score := Risk_Indicators.AddrScore.citystate_score(le.p_city_name, le.st, ri.p_city_name, ri.st, '1');
		addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																														 ri.prim_range, ri.prim_name, ri.sec_range,
																														 zip_score, cityst_score);
		addr_match := Risk_Indicators.iid_constants.ga(addrmatchscore) and le.prim_range = ri.prim_range;
		
		SELF.property_match  			:= addr_match;  //set boolean to indicate property address matches target address
		SELF.other_prox_distance  := if(~addr_match, ut.LL_Dist((real)le.lat, (real)le.long, (real)ri.geo_lat, (real)ri.geo_long), 9999999);									

		SELF := le;
	END;

	property_searched2 := JOIN(otherFares, searchKey, COUNT(LEFT.property_fares) > 0 AND (fares_ok or RIGHT.ln_fares_id[1]<>'R') and
																													KEYED(RIGHT.ln_fares_id IN SET(LEFT.property_fares, ln_fare_id)) AND
																													WILD(RIGHT.which_orig) AND
																													KEYED(RIGHT.source_code_2='P') AND
																													KEYED(RIGHT.source_code_1 = 'O') AND 
																												 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) AND
																												 	RIGHT.prim_name <> '' and RIGHT.zip <> '',
																													getSearch_FID2(LEFT, RIGHT), LEFT OUTER, KEEP(1000), ATMOST(RiskWise.max_atmost * 5));

//sort the most recent property records first. If multiple for the most recent date, sort our subject's record (property_owned will be 'true') to the top
	sortAddress := sort(property_searched2, seq, property_zip, property_prim_name, property_prim_range, -property_dt_last_seen, -property_owned);

//rollup by unique address to set the owned/sold flags for each of the subject's owned addresses
  VerificationOfOccupancy.Layouts.Layout_property rollOtherAddr(VerificationOfOccupancy.Layouts.Layout_property l, VerificationOfOccupancy.Layouts.Layout_property r) := transform
		self.property_owned 						:= if(r.property_owned = '1', r.property_owned, l.property_owned);
		self.property_sold 							:= map(l.property_sold <> ''	=> l.property_sold,  //the first rec for an address sets the sold flag, so once it's set leave it alone
																					 l.property_owned	= '1'	=> '0', 	//if first rec (most recent) for an address is owned by the subject, flag it as "not sold"
																																		 '1'); 	//if first rec (most recent) for an address is not owned by the subject, flag it as "sold"
		//the records coming into this rollup include all persons who have owned the property and the most recent last seen date tells
		//us who the most recent owner is.  but the file returned from here should contain first/last seen dates of when our input
		//subject owned the property and so we determine that by using dates from only property records that match our subject.
		self.property_person_match			:= MAX(l.property_person_match, r.property_person_match);
		SELF.property_dt_first_seen  		:= MAP(r.property_person_match and l.property_person_match 			=> min(l.property_dt_first_seen, r.property_dt_first_seen),
																					 r.property_person_match and ~l.property_person_match 		=> r.property_dt_first_seen,
																					 ~r.property_person_match and l.property_person_match 		=> l.property_dt_first_seen,
																																																			 0);
		SELF.property_dt_last_seen  		:= MAP(r.property_person_match and l.property_person_match 			=> max(l.property_dt_last_seen, r.property_dt_last_seen),
																					 r.property_person_match and ~l.property_person_match 		=> r.property_dt_last_seen,
																					 ~r.property_person_match and l.property_person_match 		=> l.property_dt_last_seen,
																																																			 0);
		self.property_date							:= MAP((INTEGER)l.property_date <= 0 => r.property_date,
																					 (INTEGER)r.property_date <= 0 => l.property_date,
																																						(STRING)MIN((INTEGER)l.property_date, (INTEGER)r.property_date)); // Get the first process date for this subject/address
		self														:= l;
	end;
	
  rolled_OwnedAddr := rollup(sortAddress, rollOtherAddr(left,right), seq, property_zip, property_prim_name, property_prim_range);

  // output(VOOShell, named('VOOShell'));
  // output(property_by_did, named('property_by_did'));
  // output(property_searched, named('property_searched'));
  // output(dedupProp, named('dedupProp'));
  // output(addrFares, named('addrFares'));
  // output(faresByAddress, named('faresByAddress'));
  // output(dedupPropAddr, named('dedupPropAddr'));
  // output(dedupProps, named('dedupProps'));
  // output(otherFares, named('otherFares'));
  // output(property_searched2, named('property_searched2'));
  // output(sortAddress, named('sortAddress'));
  // output(rolled_OwnedAddr, named('rolled_OwnedAddr'));
	return rolled_OwnedAddr;	
	
END;