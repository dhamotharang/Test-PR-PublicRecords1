import _Control, gong, riskwise, address, ut, FCRA,gateway;
onThor := _Control.Environment.OnThor;

// this function will be used on Neutral roxie only
export ADL_Based_Modeling_IID_Function(DATASET (risk_indicators.layout_input) indata,
																		DATASET(Gateway.Layouts.Config) gateways,
																		unsigned1 dppa_purpose, unsigned1 glb_purpose,
																		boolean isFCRA = false,
																		integer1 bsversion=1,
																		boolean isUtility = false,
																		boolean ln_branded = false,
																		boolean ofac_only = true,
																		boolean suppressNearDups = false,
																		boolean require2ele = false,
																		boolean from_biid = false,
																		boolean excludeWatchlists = false,
																		boolean from_IT1O = false,
																		unsigned1 ofac_version = 1,
																		boolean include_ofac = true,
																		boolean include_additional_watchlists = false,
																		real watchlist_threshold = 0.84,
																		integer2 dob_radius = -1,
																		string50 DataRestriction=iid_constants.default_DataRestriction,
																		unsigned8 BSOptions=0,
																		string50 DataPermission=risk_indicators.iid_constants.default_DataPermission
																		) := function		


// ====================================================================
// step 1.  Get the DID
// ====================================================================
	append_best := 0;	// will not be appending best here
	with_DID_roxie := risk_indicators.iid_getDID_prepOutput(indata, DPPA_Purpose, GLB_Purpose, isFCRA, 2 ,DataRestriction, append_best, gateways, BSOptions);
	with_DID_thor := risk_indicators.iid_getDID_prepOutput_THOR(indata, DPPA_Purpose, GLB_Purpose, isFCRA, 2 ,DataRestriction, append_best, gateways, BSOptions); 
	
  #IF(onThor)
    with_DID := with_DID_thor;
  #ELSE
    with_DID := with_DID_roxie;
  #END

	// output(with_did);

// ====================================================================
// step 2.  append most recent address and when available, populate blank ssn and dob																								
// ====================================================================

	with_header := risk_indicators.iid_getHeader(with_DID, DPPA_Purpose, GLB_Purpose, isFCRA, ln_branded, bsversion := BSversion, dataRestriction:=DataRestriction);
	// output(with_header, named('with_header'));

	DoAddressAppend := Risk_Indicators.iid_constants.CheckBSOptionFlag(Risk_Indicators.iid_constants.BSOptions.IncludeAddressAppend, BSOptions);

	// For batch, assuming that if 1 record is LexID only on input that all records are LexID only on input
	LexIDOnlyOnInput := indata[1].DID > 0 AND indata[1].SSN = '' AND indata[1].dob = '' AND indata[1].phone10 = '' AND indata[1].wphone10 = '' AND 
											indata[1].fname = '' AND indata[1].lname = '' AND indata[1].in_streetAddress = '' AND indata[1].z5 = '' AND indata[1].dl_number = '';
	// For shell 5.0 FCRA and higher, only append the SSN, not the other elements like address, dob, phone										
	SSNAppend_Only := bsversion >= 50 and Risk_Indicators.iid_constants.CheckBSOptionFlag(risk_indicators.iid_constants.BSOptions.IncludePreScreen, BSOptions) and not LexIDOnlyOnInput;
	
	
	temp := record
		// ADL based modeling shell fields
		risk_indicators.iid_constants.adl_based_modeling_flags;
		
		// original input data
		risk_indicators.layout_input;
		
		// fields retaining the ADL search results
		string10 chronoprim_range := '';
		string2  chronopredir:= '';
		string28 chronoprim_name:= '';
		string4  chronosuffix:= '';
		string2  chronopostdir:= '';
		string10 chronounit_desig:= '';
		string8  chronosec_range:= '';
		STRING30 chronocity := '';
		STRING2 chronostate := '';
		STRING5 chronozip := '';
		UNSIGNED3 chronodate_first := 0;
		UNSIGNED3 chronodate_last := 0;
		UNSIGNED1	chronoaddrscore := 0;
		STRING9 versocs := '';
		UNSIGNED1 socsscore := 0;
		STRING8 verdob := '';
		UNSIGNED1 dobscore := 0;
		string10 verhphone := '';
		unsigned1 hphonescore := 0;
		string10 gong_phone10 := '';
		unsigned1 gong_phonescore := 0;
		boolean gong_current_flag := false;
		string8 gong_dt_first_seen := '';
		string8 gong_dt_last_seen := '';
		SET OF STRING20 gong_correct_ffid {maxlength(2100)} := [];
		SET OF STRING38 gong_correct_record_id {maxlength(3900)} := [];
		// Address Append BSOption flags
		UNSIGNED1 AddressMatchLevel := 0;
	end;


	// set flags from header search
	slim := project(with_header, transform(temp, 
		in_addrpop := if(left.in_streetaddress<>'', 1, 0);  
		in_hphnpop := if(left.phone10<>'', 1, 0);	
		in_ssnpop := if(left.ssn<>'', 1, 0);		
		in_dobpop := if(left.dob<>'', 1, 0);		
		
		self.in_addrpop := in_addrpop;  
		self.in_hphnpop := in_hphnpop;
		self.in_ssnpop := in_ssnpop;		
		self.in_dobpop := in_dobpop;		
		
		self.adl_addr := map(left.chronoprim_name='' => 0,
												 in_addrpop=0 and left.chronoprim_name<>'' => 1,
												 risk_indicators.iid_constants.ga(left.chronoaddrscore) => 2,
												 3);
		self.in_addrpop_found := if(risk_indicators.iid_constants.ga(left.chronoaddrscore), 1, 0) ;	
		
		self.adl_ssn := map(left.versocs='' OR DoAddressAppend = TRUE => 0,  // nothing found
												 in_ssnpop=0 and left.versocs<>'' => 1, // replaced blank
												 risk_indicators.iid_constants.gn(left.socsscore) => 2, // matches input
												 3);
												 
		self.adl_dob := map(left.verdob in ['', '0'] OR DoAddressAppend = TRUE => 0,  // nothing found
												 in_dobpop=0 => 1,  // replaced blank
												 risk_indicators.iid_constants.gn(left.dobscore) => 2, // matches input
												 3);
											 
									 
		self.in_hphnpop_found := if(risk_indicators.iid_constants.gn(left.hphonescore), 1, 0) ;	
		self.adl_hphn := map(length(trim(left.verhphone))<>10 OR DoAddressAppend = TRUE => 0,  // nothing found
												 in_hphnpop=0 => 1,  // replaced blank
												 risk_indicators.iid_constants.gn(left.hphonescore) => 2, // matches input
												 3);
		// Because the address cleaner chokes when you just pass in a house number for street address, we need to attempt to figure out if just prim_range was input into the StreetAddress field
		Prim_Name := TRIM(LEFT.Prim_Name, LEFT, RIGHT);

		Prim_Range_From_Prim_Name := IF(TRIM(LEFT.Prim_Range) = '' AND // If Prim_Range isn't populated AND 
																		TRIM(Prim_Name) <> '' AND // Prim_Name IS populated AND
																		LENGTH(StringLib.StringFilter(Prim_Name, '0123456789')) = LENGTH(Prim_Name) AND // Prim_Name is all numeric AND
																		StringLib.StringFind(Prim_Name, ' ', 1) <= 0, // Prim_Name contains no spaces, we can assume that just the house number was passed in and the address cleaner just didn't handle it properly
																Prim_Name, // Pretend the all numeric Prim_Name is really Prim_Range
																LEFT.Prim_Range); // Otherwise just keep whatever the address cleaner came up with for Prim_Range
		Prim_Range := IF(DoAddressAppend = FALSE, LEFT.Prim_Range, Prim_Range_From_Prim_Name); // This isn't an address append, use whatever the address cleaner came up with for Prim_Range
		SELF.AddressMatchLevel := MAP(DoAddressAppend = FALSE 																				=> Risk_Indicators.iid_constants.AddressAppendMatchLevel.NoMatch,						// Not running AddressAppend, use the standard sorted slim fields (All records will have a 0 for this field)
																	TRIM(LEFT.chronoprim_range) != '' AND TRIM(LEFT.chronozip) != '' AND 
																	Prim_Range = LEFT.chronoprim_range AND LEFT.Z5 = LEFT.chronozip	=> Risk_Indicators.iid_constants.AddressAppendMatchLevel.StreetNumAndZip5,	// Zip5 AND Street Number (Prim_Range) matched
																	TRIM(LEFT.chronozip) != '' AND LEFT.Z5 = LEFT.chronozip					=> Risk_Indicators.iid_constants.AddressAppendMatchLevel.JustZip5,					// Just Zip5 matched
																																																		 Risk_Indicators.iid_constants.AddressAppendMatchLevel.NoMatch);					// Nothing matched
	self := left));
	// output(slim, named('slim'));


	sortedslim := group(sort(slim, seq, -AddressMatchLevel, -chronodate_last, -chronodate_first, 
												-chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, -chronosec_range, -chronounit_desig, -chronocity, -chronostate), seq);
	// output(sortedslim, named('sortedslim'));


	// rollup, keep left adl_addr and left chronoaddress because that's the most recent.  use choosers for the other elements	
	temp roll_header(temp le, temp rt) := transform

		// always keep the left, most recent address
		self.adl_addr := le.adl_addr;  
		self.in_addrpop_found := if(le.in_addrpop_found>=rt.in_addrpop_found, le.in_addrpop_found, rt.in_addrpop_found);	

		self.chronoprim_range := le.chronoprim_range ;
		self.chronopredir := le.chronopredir ;
		self.chronoprim_name:= le.chronoprim_name;
		self.chronosuffix:= le.chronosuffix;
		self.chronopostdir:= le.chronopostdir;
		self.chronounit_desig:= le.chronounit_desig;
		self.chronosec_range:= le.chronosec_range;
		self.chronocity := le.chronocity ;
		self.chronostate := le.chronostate ;
		self.chronozip := le.chronozip ;
		self.chronodate_first := le.chronodate_first ;
		self.chronodate_last := le.chronodate_last ;
		self.chronoaddrscore := le.chronoaddrscore ;
		
		dob_chooser := (le.adl_dob<>0 and le.dobscore>=rt.dobscore) or rt.adl_dob=0;
		self.adl_dob := if(dob_chooser, le.adl_dob, rt.adl_dob);
		self.verdob := if(dob_chooser, le.verdob, rt.verdob);
		self.dobscore := if(dob_chooser, le.dobscore, rt.dobscore);
		
		ssn_chooser := (le.adl_ssn<>0 and le.socsscore>=rt.socsscore) or rt.adl_ssn=0;
		self.adl_ssn := if(ssn_chooser, le.adl_ssn, rt.adl_ssn);
		self.versocs:= if(ssn_chooser, le.versocs, rt.versocs);
		self.socsscore := if(ssn_chooser, le.socsscore, rt.socsscore);
		
		// select the most recent phone number instead of the highest scoring 
		phone_chooser := (le.adl_hphn<>0 and le.chronodate_last>=rt.chronodate_last) or rt.adl_hphn=0;
		self.in_hphnpop_found := if(le.in_hphnpop_found>=rt.in_hphnpop_found, le.in_hphnpop_found, rt.in_hphnpop_found);	
		self.adl_hphn := if(phone_chooser, le.adl_hphn, rt.adl_hphn);
		self.verhphone := if(phone_chooser, le.verhphone, rt.verhphone);
		self.hphonescore := if(phone_chooser, le.hphonescore, rt.hphonescore);
		
		// If more than 1 address matches on Street Number and Zip5 or just Zip5 - use whatever is on the Address Hierarchy key instead, to do that set AddressMatchLevel to 0
		multipleAddrsMatch := IF(le.AddressMatchLevel = rt.AddressMatchLevel AND (le.chronozip != rt.chronozip OR le.chronoprim_range != rt.chronoprim_range), TRUE, FALSE);
		SELF.AddressMatchLevel := IF(multipleAddrsMatch, 0, le.AddressMatchLevel);

		self := rt;
	end;

	best_of_header_slim := rollup(sortedslim, true, roll_header(left,right));
	// output(best_of_header, named('best_of_header'));
	
	// Only if we are running the Address Append do we want to access the Address Hierarchy key/logic. Passing in 5.0 for the BSVersion to ensure that this continues to work for RiskView V3.
	Address_Hierarchy_Results := IF(DoAddressAppend = FALSE, 
					DATASET([], Risk_indicators.iid_constants.layout_outx), // Need to add GROUP here to avoid an error with the different branches having different grouping conditions
					UNGROUP(Risk_Indicators.IID_Append_Address_Hierarchy(with_header, isFCRA, 50))); 
	
	Address_Hierarchy := ROLLUP(SORT(Address_Hierarchy_Results, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT)); // We just care about the best address fields from this layout - and the best address is the same for all records belonging to input seq, so just rollup and keep the first record per result
	
	temp doAddressHierarchyAppend(temp le, Risk_indicators.iid_constants.layout_outx ri) := TRANSFORM
		// We matched a header record by StreetNumber and Zip5 or just Zip5 - keep that over whatever was in the address hierarchy search
		keepLeft := IF(le.AddressMatchLevel > 0, TRUE, FALSE);
		
		SELF.AddressMatchLevel := IF(keepLeft, le.AddressMatchLevel, Risk_Indicators.iid_constants.AddressAppendMatchLevel.AddressHierarchyResult);
		
		SELF.chronoprim_range := IF(keepLeft, le.chronoprim_range, ri.Addr_Hierarchy_Best_Prim_Range);
		SELF.chronopredir := IF(keepLeft, le.chronopredir, ri.Addr_Hierarchy_Best_Predir);
		SELF.chronoprim_name := IF(keepLeft, le.chronoprim_name, ri.Addr_Hierarchy_Best_Prim_Name);
		SELF.chronosuffix := IF(keepLeft, le.chronosuffix, ri.Addr_Hierarchy_Best_Suffix);
		SELF.chronopostdir := IF(keepLeft, le.chronopostdir, ri.Addr_Hierarchy_Best_Postdir);
		SELF.chronounit_desig := IF(keepLeft, le.chronounit_desig, ri.Addr_Hierarchy_Best_Unit_Desig);
		SELF.chronosec_range := IF(keepLeft, le.chronosec_range, ri.Addr_Hierarchy_Best_Sec_Range);
		SELF.chronocity := IF(keepLeft, le.chronocity, ri.Addr_Hierarchy_Best_City);
		SELF.chronostate := IF(keepLeft, le.chronostate, ri.Addr_Hierarchy_Best_State);
		SELF.chronozip := IF(keepLeft, le.chronozip, ri.Addr_Hierarchy_Best_ZIP);
		SELF.chronodate_first := IF(keepLeft, le.chronodate_first, ri.H.dt_first_seen);
		SELF.chronodate_last := IF(keepLeft, le.chronodate_last, ri.H.dt_last_seen);
		
		SELF := le;
	END;
	
	best_of_address_hierarchy := JOIN(best_of_header_slim, Address_Hierarchy, LEFT.Seq = RIGHT.Seq, 
																	doAddressHierarchyAppend(LEFT, RIGHT), 
																	LEFT OUTER, KEEP(1), ATMOST(100));

	// If you aren't running the Address Append BSOption, don't even both searching the address hierarchy key
	best_of_header := IF(DoAddressAppend = FALSE,
					GROUP(SORT(best_of_header_slim, Seq), Seq),
					GROUP(SORT(best_of_address_hierarchy, Seq), Seq));

// ====================================================================
// step 3.  append phone from gong data
// ====================================================================

// check corrections
temp add_gong_corr(temp le, FCRA.Key_Override_Gong_FFID rt) := transform
	self.gong_phone10 := rt.phone10;
	self.gong_current_flag := rt.current_flag;
	gong_phonescore := risk_indicators.PhoneScore(le.phone10, rt.phone10);
	self.gong_phonescore := gong_phonescore;
	
	self.in_hphnpop_found := map(le.in_hphnpop_found=1 => 1, // if found already, let it stay that way
															 risk_indicators.iid_constants.gn(gong_phonescore) => 1,
															 0) ;	
															 
	self.adl_hphn := map(le.adl_hphn=0 and rt.phone10='' => 0,  // nothing found
											 le.in_hphnpop=0 => 1,  // replaced blank
											 risk_indicators.iid_constants.gn(gong_phonescore) => 2, // matches input
											 3);
											 							 
	self.gong_dt_first_seen := rt.dt_first_seen;
	self.gong_dt_last_seen := rt.dt_last_seen;
	self := le;
end;
gong_correct_roxie := join(best_of_header, FCRA.Key_Override_Gong_FFID,
												keyed(right.flag_file_id in left.gong_correct_ffid),
												add_gong_corr(left, right), atmost(right.flag_file_id in left.gong_correct_ffid, 100));

gong_correct_thor := join(best_of_header(gong_correct_ffid<>[]), pull(FCRA.Key_Override_Gong_FFID),
												(right.flag_file_id in left.gong_correct_ffid),
												add_gong_corr(left, right), LOCAL, ALL);
												
#IF(onThor)
	gong_correct := gong_correct_thor;
#ELSE
	gong_correct := gong_correct_roxie;
#END

// search gong file for phones we may not have found on header search
temp add_gong(temp le, gong.Key_History_did rt) := transform
	self.gong_phone10 := rt.phone10;
	self.gong_current_flag := rt.current_flag;
	gong_phonescore := risk_indicators.PhoneScore(le.phone10, rt.phone10);
	self.gong_phonescore := gong_phonescore;
	
	self.in_hphnpop_found := map(le.in_hphnpop_found=1 => 1, // if found already, let it stay that way
															 risk_indicators.iid_constants.gn(gong_phonescore) => 1,
															 0) ;	
															 
	self.adl_hphn := map(le.adl_hphn=0 and rt.phone10='' => 0,  // nothing found
											 le.in_hphnpop=0 => 1,  // replaced blank
											 risk_indicators.iid_constants.gn(gong_phonescore) => 2, // matches input
											 3);
											 							 
	self.gong_dt_first_seen := rt.dt_first_seen;
	self.gong_dt_last_seen := rt.dt_last_seen;
	self := le;
end;

gong_key := if(isFCRA, gong.Key_FCRA_History_did, gong.Key_History_did);
with_gong_did1_roxie := join(best_of_header, gong_key, 
									left.did!=0 and keyed(right.l_did=left.did) and 
									// check date first seen before history date.  per Brent, don't need to check if phone was current at the time
									((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) and
									trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in left.gong_correct_record_id	// old way - prior to 11/13/2012
									and trim((string)right.persistent_record_id) not in left.gong_correct_record_id, // new way - using persistent_record_id
									add_gong(left, right), left outer, atmost(riskwise.max_atmost), keep(100));


with_gong_did1_thor := join(distribute(best_of_header, hash64(did)), 
									distribute(pull(gong_key), hash64(did)), 
									left.did!=0 and (right.l_did=left.did) and 
									// check date first seen before history date.  per Brent, don't need to check if phone was current at the time
									((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) and
									trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in left.gong_correct_record_id	// old way - prior to 11/13/2012
									and trim((string)right.persistent_record_id) not in left.gong_correct_record_id, // new way - using persistent_record_id
									add_gong(left, right), left outer, atmost(right.l_did=left.did, riskwise.max_atmost), keep(100), LOCAL);

#IF(onThor)
	with_gong_did1 := with_gong_did1_thor;
#ELSE
	with_gong_did1 := with_gong_did1_roxie;
#END

with_gong_did := if(isFCRA, gong_correct + with_gong_did1, with_gong_did1);
									
// output(with_gong_did, named('with_gong_did'));	

sorted_gong := group(sort(with_gong_did, seq, -gong_current_flag, -gong_dt_last_seen, -gong_dt_first_seen, -gong_phonescore), seq);
// output(sorted_gong, named('sorted_gong'));

// abbreviated best of both gong and did as BOB :-)
bob := dedup(sorted_gong, seq);
// output(bob, named('bob'));	


// ====================================================================
// step 4.  replace original input data with ADL search results
// ====================================================================

// replace original input address and phone with ADL search results if it's more recent than original input or input was blank
// append ssn and dob from ADL search results if the input was blank
risk_indicators.layout_input map_bob(temp le) := transform
	
	// in FCRA always overwrite the input with what we have on file, bug 40366
	// in non-fcra, only update the address if we found something different than input
	// Or update with whatever was found doing the special Address Append logic, but only if we actually found something to replace with otherwise just keep what was input
	update_address := ~SSNAppend_Only and 
					(isFCRA or le.adl_addr in [1,3] OR (DoAddressAppend = TRUE AND le.AddressMatchLevel != Risk_Indicators.iid_constants.AddressAppendMatchLevel.NoMatch));
													   
	newstreet := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range,le.chronopredir,le.chronoprim_name,le.chronosuffix,
																					 le.chronopostdir,le.chronounit_desig,le.chronosec_range);
	newcity := le.chronocity;
	newstate := le.chronostate;
	newzip := le.chronozip;	
	
	clean_a2 := if(update_address, Risk_Indicators.MOD_AddressClean.clean_addr(newstreet, newcity, newstate, newzip), '');
	

	SELF.in_streetAddress := if(update_address, newstreet, le.in_streetaddress);
	SELF.in_city := if(update_address, newcity, le.in_city);
	SELF.in_state := if(update_address, newstate, le.in_state);
	SELF.in_zipCode := if(update_address, newzip, le.in_zipcode);
	self.prim_range := if(update_address, clean_a2[1..10], le.prim_range);
	self.predir := if(update_address, clean_a2[11..12], le.predir);
	self.prim_name := if(update_address, clean_a2[13..40], le.prim_name);
	self.addr_suffix := if(update_address, clean_a2[41..44], le.addr_suffix);
	self.postdir := if(update_address, clean_a2[45..46], le.postdir);
	self.unit_desig := if(update_address, clean_a2[47..56], le.unit_desig);
	self.sec_range := if(update_address, clean_a2[57..65], le.sec_range);
	self.p_city_name := if(update_address, clean_a2[90..114], le.p_city_name);
	self.st := if(update_address, clean_a2[115..116], le.st);
	self.z5 := if(update_address, clean_a2[117..121], le.z5);
	self.zip4 := if(update_address, clean_a2[122..125], le.zip4);
	self.lat := if(update_address, clean_a2[146..155], le.lat);
	self.long := if(update_address, clean_a2[156..166], le.long);
	self.addr_type := if(update_address, clean_a2[139], le.addr_type);
	self.addr_status := if(update_address, clean_a2[179..182], le.addr_status);
	self.county := if(update_address, clean_a2[143..145], le.county);
	self.geo_blk := if(update_address, clean_a2[171..177], le.geo_blk);
	
								// for riskview 5.0 prescreen, only append the SSN if it was blank on input (adl_ssn=1)
	update_ssn := ((SSNAppend_Only and le.adl_ssn=1) or 
								// Don't append anything other than Address when DoAddressAppend is set to TRUE
								((bsVersion < 50 and (isFCRA or le.adl_ssn=1)) AND DoAddressAppend = FALSE) or  
								(~isFCRA and le.adl_ssn=1) AND DoAddressAppend = FALSE);  
	self.ssn := if(update_ssn, le.versocs, le.ssn);  // append ssn from adl search if original ssn was blank
	
	update_dob := ~SSNAppend_Only and
		(isFCRA or le.adl_dob=1) AND DoAddressAppend = FALSE;  // leave the logic as is for non-fcra, always overwrite the DOB for Riskview prescreen score, bug 40366
	dob := if(update_dob, le.verdob, le.dob); 				// append dob from adl search if original dob was blank
	self.dob := dob;
	self.age := if ((integer)le.age=0 and (integer)dob != 0, (STRING3)ut.Age((integer)dob), le.age);
	
	// when updating the phone, could have come from gong or header,
	// use the gong phone number first.  if that's empty, return the phone found on the header record.
	update_phone := ~SSNAppend_Only and
		(isFCRA or le.adl_hphn in [1,3]) AND DoAddressAppend = FALSE; // leave the logic as is for non-fcra, always overwrite the phone for Riskview prescreen score, bug 40366
	self.phone10 := if(update_phone, if(le.gong_phone10='', le.verhphone, le.gong_phone10), le.phone10);	
	self := le;
	self := [];
end;

iid_prep := ungroup( project(bob, map_bob(left)) );
													
iid_results := risk_indicators.InstantID_Function(iid_prep, 
										gateways, 
										dppa_purpose, 
										glb_purpose, 
										isUtility, 
										ln_branded, 	
										ofac_only, 
										suppressNearDups, 
										require2ele, 
										from_biid,
										isFCRA,
										excludeWatchLists,
										from_IT1O,
										ofac_version,
										include_ofac,
										include_additional_watchlists,
										watchlist_threshold,
										dob_radius,
										bsversion,
										in_DataRestriction := DataRestriction,
										in_BSOptions := BSOptions);


iid_results_with_flags := group( sort(
			join(iid_results, bob, left.seq=right.seq,
					transform(risk_indicators.iid_constants.adl_based_Layout_Output, 
						self.in_addrpop	 := right.in_addrpop	 ;
						self.in_hphnpop	 := right.in_hphnpop	 ;
						self.in_ssnpop	 := right.in_ssnpop	 ;
						self.in_dobpop	 := right.in_dobpop	 ;
						self.adl_addr	 := IF(DoAddressAppend = FALSE, RIGHT.adl_addr, RIGHT.AddressMatchLevel); // One of the Address Append attributes needs to know what was appended, keep the AddressMatchLevel around in place of a library layout change
						self.adl_hphn	 := right.adl_hphn	 ;
						self.adl_ssn	 := right.adl_ssn	 ;
						self.adl_dob	 := right.adl_dob	 ;
						self.in_addrpop_found	 := right.in_addrpop_found	 ;
						self.in_hphnpop_found	 := right.in_hphnpop_found	 ;
						self := left	)), seq), seq);

// output(SSNAppend_Only, named('SSNAppend_Only'));
return iid_results_with_flags;
end;
