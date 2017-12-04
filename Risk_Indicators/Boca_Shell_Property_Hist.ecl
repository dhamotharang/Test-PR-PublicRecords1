import LN_PropertyV2, ut, RiskWise;

export Boca_Shell_Property_Hist (GROUPED DATASET(Layout_PropertyRecord) p_address,
                                 GROUPED DATASET(Layout_Boca_Shell_ids) ids, 
																 boolean includeRelatives = true,
																 boolean filter_out_fares=false) := FUNCTION											

proprec := record
	Layouts.Layout_PropertyRecordv2 - layout_overrides;
	unsigned4 purchase_date_by_did := 0;
	unsigned4 sale_date_by_did := 0;
	
	// recent property sales
	Layouts.Layout_Recent_Property_Sales;
	unsigned4 iter_seq := 1;
END;


kpd := LN_PropertyV2.key_Property_did();
kaf := LN_PropertyV2.key_addr_fid();
kfs_nonFCRA	:= LN_PropertyV2.key_search_fid();
kafid_nonFCRA	:= LN_PropertyV2.key_assessor_fid();
kdf_nonFCRA	:= LN_PropertyV2.key_deed_fid();


proprec get_property_by_addr(layout_PropertyRecord le, kaf ri) :=
TRANSFORM
	SELF.own_fares_id := ri.ln_fares_id;
	SELF.dataSrce := '0';
	SELF := le;
	SELF := [];
END;
property_by_address_all := JOIN(p_address, KAF,
						LEFT.prim_name<>'' AND
						keyed(LEFT.prim_name=RIGHT.prim_name) AND
						keyed(LEFT.prim_range=RIGHT.prim_range) AND
						keyed(LEFT.zip5=RIGHT.zip) AND
						keyed(LEFT.predir=RIGHT.predir) AND
						keyed(LEFT.postdir=RIGHT.postdir) AND
						keyed(LEFT.addr_suffix=RIGHT.suffix) AND
						keyed(LEFT.sec_range=RIGHT.sec_range) and
						keyed(right.source_code_2 = 'P'),
					   get_property_by_addr(LEFT,RIGHT), KEEP(100), LEFT OUTER,
					   ATMOST(
						   keyed(LEFT.prim_name=RIGHT.prim_name) AND
						   keyed(LEFT.prim_range=RIGHT.prim_range) AND
						   keyed(LEFT.zip5=RIGHT.zip) AND
						   keyed(LEFT.predir=RIGHT.predir) AND
						   keyed(LEFT.postdir=RIGHT.postdir) AND
						   keyed(LEFT.addr_suffix=RIGHT.suffix) AND
						   keyed(LEFT.sec_range=RIGHT.sec_range) and
						   keyed(right.source_code_2 = 'P'),
						   RiskWise.max_atmost
					   ));


property_by_address_filtered := JOIN(p_address, KAF,
						right.ln_fares_id[1]<>'R' and
						LEFT.prim_name<>'' AND
						keyed(LEFT.prim_name=RIGHT.prim_name) AND
						keyed(LEFT.prim_range=RIGHT.prim_range) AND
						keyed(LEFT.zip5=RIGHT.zip) AND
						keyed(LEFT.predir=RIGHT.predir) AND
						keyed(LEFT.postdir=RIGHT.postdir) AND
						keyed(LEFT.addr_suffix=RIGHT.suffix) AND
						keyed(LEFT.sec_range=RIGHT.sec_range) and
						keyed(right.source_code_2 = 'P'),
					   get_property_by_addr(LEFT,RIGHT), KEEP(100), LEFT OUTER,
					   ATMOST(
						   keyed(LEFT.prim_name=RIGHT.prim_name) AND
						   keyed(LEFT.prim_range=RIGHT.prim_range) AND
						   keyed(LEFT.zip5=RIGHT.zip) AND
						   keyed(LEFT.predir=RIGHT.predir) AND
						   keyed(LEFT.postdir=RIGHT.postdir) AND
						   keyed(LEFT.addr_suffix=RIGHT.suffix) AND
						   keyed(LEFT.sec_range=RIGHT.sec_range) and
						   keyed(right.source_code_2 = 'P'),
						   RiskWise.max_atmost
					   ));

// if filter_out_fares boolean, use the join which has the fares records filtered out
property_by_address := if(filter_out_fares, property_by_address_filtered, property_by_address_all);

proprec get_property_by_did(Layout_Boca_Shell_ids le, kpd ri) :=
TRANSFORM
	SELF.own_fares_id := ri.ln_fares_id;
	SELF := le;
	SELF.dataSrce := '9';
	SELF := [];
END;
property_by_did_all := JOIN(ids, kpd,
						LEFT.did<>0 AND 
						(includeRelatives or ~left.isrelat) and
						keyed(LEFT.did=RIGHT.s_did) and
						keyed(right.source_code_2 = 'P'),
						get_property_by_did(LEFT,RIGHT), KEEP(100), ATMOST( keyed(LEFT.did=RIGHT.s_did) and keyed(right.source_code_2 = 'P'), RiskWise.max_atmost));


property_by_did_filtered := JOIN(ids, kpd,
						LEFT.did<>0 AND 
						right.ln_fares_id[1]<>'R' and
						(includeRelatives or ~left.isrelat) and
						keyed(LEFT.did=RIGHT.s_did) and
						keyed(right.source_code_2 = 'P'),
						get_property_by_did(LEFT,RIGHT), KEEP(100), ATMOST( keyed(LEFT.did=RIGHT.s_did) and keyed(right.source_code_2 = 'P'), RiskWise.max_atmost));

// if filter_out_fares boolean, use the join which has the fares records filtered out
property_by_did := if(filter_out_fares, property_by_did_filtered, property_by_did_all);

proprec roll_property_fid(proprec le, proprec ri) :=
TRANSFORM
	SELF.isrelat := le.isrelat OR ri.isrelat;
	SELF.did := MAP(le.isrelat AND ri.isrelat	=> MIN(le.did,ri.did),	// 2 relatives, just pick one
				 le.isrelat AND (~ri.isrelat AND ri.did<>0)	=> ri.did,	// 1 relative, 1 applicant
				 (~le.isrelat AND le.did<>0) AND ri.isrelat	=> le.did,	// 1 relative, 1 applicant
				 le.isrelat OR ri.did=0					=> le.did,	// 1 relative or 1 from the address lookup
													   ri.did);

	SELF := le;
END;

pre_property_fid := group(property_by_address) + group(property_by_did);


property_fid := ROLLUP(SORT(pre_property_fid(own_fares_id != ''),
					   seq, own_fares_id, dataSrce, isRelat, prim_name, prim_range),
					LEFT.seq=RIGHT.seq AND
					LEFT.own_fares_id=RIGHT.own_fares_id AND
					(ut.NNEQ(LEFT.prim_name,RIGHT.prim_name) AND 
					ut.NNEQ(LEFT.prim_range,RIGHT.prim_range)),
				   roll_property_fid(LEFT,RIGHT));

calc_napprop(boolean f,boolean l,boolean a) :=
MAP(~f AND ~l AND ~a	=> 0,
	  ~f AND ~l AND a		=> 1,
		f AND ~l AND a		=> 2,
		~f AND l AND a		=> 3,
		f AND l AND a			=> 4, 0);


// adds in addresses on by_did records that don't have them
proprec getSearch_NONFCRA(proprec le, kfs_nonFCRA ri) :=
TRANSFORM
	fname_match := g(FnameScore(le.fname,ri.fname));
	lname_match := g(Risk_Indicators.LnameScore(le.lname,ri.lname));
	addr_match := true;
	SELF.NAProp := calc_napprop(fname_match,lname_match,addr_match);
	
	// try scoring rather than exact matching, will be using these results for ownership going forward
	SELF.family_owned := le.family_owned OR (ri.source_code_1='O' AND ~fname_match AND lname_match);
	SELF.applicant_owned := le.applicant_owned OR (ri.source_code_1='O' AND lname_match AND fname_match);
	SELF.family_sold := le.family_sold OR (ri.source_code_1='S' AND ~fname_match AND lname_match);
	SELF.applicant_sold := le.applicant_sold OR (ri.source_code_1='S' AND lname_match AND fname_match);	
									
	SELF.prim_range := IF(le.prim_range='',ri.prim_range,le.prim_range);
	SELF.prim_name :=  IF(le.prim_name='',ri.prim_name,le.prim_name);
	SELF.st :=  IF(le.st='',ri.st,le.st);
	SELF.city_name :=  IF(le.city_name='',ri.v_city_name,le.city_name);
	SELF.zip5 :=  IF(le.zip5='',ri.zip,le.zip5);
	SELF.predir :=  IF(le.predir='',ri.predir,le.predir);
	SELF.postdir :=  IF(le.postdir='',ri.postdir,le.postdir);
	SELF.addr_suffix :=  IF(le.addr_suffix='',ri.suffix,le.addr_suffix);
	SELF.sec_range :=  IF(le.sec_range='',ri.sec_range,le.sec_range);
	SELF.county :=  IF(le.county='',ri.county[3..5],le.county);
	SELF.geo_blk :=  IF(le.geo_blk='',ri.geo_blk,le.geo_blk);
	SELF := le;
END;


// filter out those fares records that came from DID lookup, 
// and have no property address even after the join tries to add one 
property_searched := group(sort(
							 JOIN(property_fid,
							  kfs_nonFCRA,
								keyed(LEFT.own_fares_id=RIGHT.ln_fares_id) AND
								wild(right.which_orig) and
								keyed(RIGHT.source_code_2='P') AND
								(LEFT.prim_name='' OR LEFT.prim_name=RIGHT.prim_name) AND
								(Left.prim_range='' OR LEFT.prim_range=RIGHT.prim_range) AND
								(LEFT.zip5='' OR LEFT.zip5=RIGHT.zip) AND
								(unsigned)(RIGHT.process_date[1..6]) < left.historydate,
							  getSearch_nonFCRA(LEFT,RIGHT),LEFT OUTER, keep(100), ATMOST(
								  keyed(LEFT.own_fares_id=RIGHT.ln_fares_id) AND
								  wild(right.which_orig) and
								  keyed(RIGHT.source_code_2='P'),
								  RiskWise.max_atmost
							   ))(prim_name<>'' AND zip5<>''),
						seq),seq);

proprec roll_prop_searched(proprec le, proprec ri) :=
TRANSFORM
	SELF.NAPROP := MAX(le.naprop,ri.naprop);
	SELF.AD := MAP(le.AD = '' => ri.AD,
				ri.AD = '' => le.AD,
				le.AD <> ri.AD => 'M', 
				le.AD);
	SELF.applicant_owned := le.applicant_owned OR ri.applicant_owned;
	SELF.family_owned := le.family_owned OR ri.family_owned;
	SELF.occupant_owned := le.occupant_owned OR ri.occupant_owned;
	SELF.applicant_sold := le.applicant_sold OR ri.applicant_sold;
	SELF.family_sold := le.family_sold OR ri.family_sold;
	SELF.applicant_sale_found := le.applicant_sale_found OR ri.applicant_sale_Found;
	SELF.applicant_buy_found := le.applicant_buy_found OR ri.applicant_buy_found;
	SELF.family_sale_found := le.family_sale_found OR ri.family_sale_Found;
	SELF.family_buy_found := le.family_buy_found OR ri.family_buy_found;	
	SELF.isrelat := le.isrelat OR ri.isrelat;
	
	
	// get the most recent purchase info, rather than the highest purchase info
	purchasePicker := map(le.purchase_date = ri.purchase_date => 1, // both the same, use either one
												ri.purchase_date > le.purchase_date => 2, // use the right one
												3);	// use the left one
												
	self.purchase_date := choose(purchasePicker, 	Le.purchase_date,
																								ri.purchase_date,
																								le.purchase_date);
	self.purchase_amount := choose(purchasePicker, 	MAX(Le.purchase_amount, Ri.purchase_amount),
																									ri.purchase_amount,
																									le.purchase_amount);

	
	sale1Picker := map(le.sale_date_by_did = ri.sale_date_by_did => 1,	// both the same, use either one
										 ri.sale_date_by_did > le.sale_date_by_did => 2, // use the right one
										 3);	// use the left one
										 
	
	SELF.sale_date_by_did := choose(sale1Picker, MAX(le.sale_date_by_did,ri.sale_date_by_did),
																							 ri.sale_date_by_did,
																							 le.sale_date_by_did);
	SELF.sale_date1 := choose(sale1Picker, MAX(le.sale_date1,ri.sale_date1),
																				 ri.sale_date1,
																				 le.sale_date1);
	
	self.sale_price1 := choose(sale1Picker, MAX(le.sale_price1,ri.sale_price1),
																					ri.sale_price1,
																					le.sale_price1);
	
	prevPicker := map(le.purchase_date_by_did = ri.purchase_date_by_did => 1,	// both the same, use either one
										 ri.purchase_date_by_did > le.purchase_date_by_did => 2, // use the right one
										 3);	// use the left one
	
	SELF.purchase_date_by_did := choose(prevPicker, MAX(le.purchase_date_by_did,ri.purchase_date_by_did),
																									ri.purchase_date_by_did,
																									le.purchase_date_by_did);
	SELF.prev_purch_date1 := choose(prevPicker, MAX(le.prev_purch_date1,ri.prev_purch_date1),
																							ri.prev_purch_date1,
																							le.prev_purch_date1);
										 
	self.prev_purch_price1 := choose(prevPicker, MAX(le.prev_purch_price1,ri.prev_purch_price1),
																							 ri.prev_purch_price1,
																							 le.prev_purch_price1);
	
	
		
	// get most recent mortgage info, rather than highest mortgage info
	mortgagePicker := map(le.mortgage_date = ri.mortgage_date => 1,	// both the same, use either one
												ri.mortgage_date > le.mortgage_date => 2, // use the right one
												3);	// use the left one
												
	nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
												
	SELF.mortgage_amount := choose(mortgagePicker, MAX(le.mortgage_amount,ri.mortgage_amount),
																								 ri.mortgage_amount,
																								 le.mortgage_amount);
	SELF.mortgage_date := choose(mortgagePicker, le.mortgage_date,
																							 ri.mortgage_date,
																							 le.mortgage_date);
	SELF.mortgage_type := choose(mortgagePicker, nonblank(le.mortgage_type,ri.mortgage_type),
																												ri.mortgage_type,
																												le.mortgage_type);	
	self.type_financing := choose(mortgagePicker, nonblank(le.type_financing,ri.type_financing),
																												 ri.type_financing,
																												 le.type_financing);
	self.first_td_due_date := choose(mortgagePicker, nonblank(le.first_td_due_date,ri.first_td_due_date),
																														ri.first_td_due_date,
																														le.first_td_due_date);
	
	
	SELF.did := MAP(le.isrelat AND ri.isrelat	=> MIN(le.did,ri.did),	// 2 relatives, just pick one
				 le.isrelat AND (~ri.isrelat AND ri.did<>0)	=> ri.did,	// 1 relative, 1 applicant
				 (~le.isrelat AND le.did<>0) AND ri.isrelat	=> le.did,	// 1 relative, 1 applicant
				 le.isrelat OR ri.did=0					=> le.did,	// 1 relative or 1 from the address lookup
													   ri.did);
	
	// pick the most recent assessed record we have and keep it consistent with all data
	assessPicker := map((integer)le.assessed_value_year = (integer)ri.assessed_value_year => 1,	// both the same, use either one
											(integer)ri.assessed_value_year > (integer)le.assessed_value_year => 2,	// use the right
											3);	// use the left
																				 
	self.built_date := choose(assessPicker, ut.Min2(le.built_date, ri.built_date),
																					ri.built_date,
																					le.built_date);
	
	// new property attributes stuff
	self.standardized_land_use_code := choose(assessPicker, nonblank(le.standardized_land_use_code, ri.standardized_land_use_code),
																													ri.standardized_land_use_code,
																													le.standardized_land_use_code);
	self.building_area := choose(assessPicker, 	MAX(le.building_area, ri.building_area),
																							ri.building_area,
																							le.building_area);
	self.no_of_buildings := choose(assessPicker, 	MAX(le.no_of_buildings, ri.no_of_buildings),
																								ri.no_of_buildings,
																								le.no_of_buildings);
	self.no_of_stories := choose(assessPicker, 	MAX(le.no_of_stories, ri.no_of_stories),
																							ri.no_of_stories,
																							le.no_of_stories);
	self.no_of_rooms := choose(assessPicker, 	MAX(le.no_of_rooms, ri.no_of_rooms),
																						ri.no_of_rooms,
																						le.no_of_rooms);
	self.no_of_bedrooms := choose(assessPicker, MAX(le.no_of_bedrooms, ri.no_of_bedrooms),
																							ri.no_of_bedrooms,
																							le.no_of_bedrooms);
	self.no_of_baths := choose(assessPicker, 	MAX(le.no_of_baths, ri.no_of_baths),
																						ri.no_of_baths,
																						le.no_of_baths);
	self.no_of_partial_baths := choose(assessPicker, 	MAX(le.no_of_partial_baths, ri.no_of_partial_baths),
																										ri.no_of_partial_baths,
																										le.no_of_partial_baths);
	self.garage_type_code := choose(assessPicker, nonblank(le.garage_type_code, ri.garage_type_code),
																								ri.garage_type_code,
																								le.garage_type_code);
	self.parking_no_of_cars := choose(assessPicker, MAX(le.parking_no_of_cars, ri.parking_no_of_cars),
																									ri.parking_no_of_cars,
																									le.parking_no_of_cars);
	self.style_code := choose(assessPicker, nonblank(le.style_code, ri.style_code),
																					ri.style_code,
																					le.style_code);
	self.assessed_value_year := choose(assessPicker, 	le.assessed_value_year,
																										ri.assessed_value_year,
																										le.assessed_value_year);	
	self.assessed_amount := choose(assessPicker, 	MAX(le.assessed_amount,ri.assessed_amount),
																								ri.assessed_amount,
																								le.assessed_amount);
	
	self.assessed_total_value := choose(assessPicker, 	MAX(le.assessed_total_value,ri.assessed_total_value),
																								ri.assessed_total_value,
																								le.assessed_total_value);
	SELF := le;
END;

proprec add_assess_nonFCRA(proprec le, kafid_nonFCRA ri) :=
TRANSFORM
	SELF.AD := IF(ri.ln_fares_id<>'','A',le.AD);
	SELF.occupant_owned := if (ri.ln_fares_id = '', le.occupant_owned, ri.mailing_full_street_address=ri.property_full_street_address or le.occupant_owned);
	SELF.family_owned := le.family_owned;
	SELF.family_sold := le.family_sold;
	SELF.applicant_owned := le.applicant_owned;
	SELF.applicant_sold := le.applicant_sold;
	// existence means it is found if set. It is not found unless looking
	SELF.family_sale_found := le.family_sold;
	SELF.family_buy_found := le.family_owned;
	SELF.applicant_buy_found := le.applicant_owned;
	SELF.applicant_sale_found := le.applicant_sold;
	
	SELF.purchase_date := if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date);

	SELF.purchase_date_by_did := if(le.applicant_owned,		
																			if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
																	0);
	SELF.prev_purch_date1 := if(le.applicant_owned,		
																			if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
																	0);
	SELF.sale_date_by_did := if(le.applicant_sold, 	
																	if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
															0);
	SELF.sale_date1 := if(le.applicant_sold, 	
																	if((integer)ri.sale_date=0,(integer)ri.recording_date, (integer)ri.sale_date),
															0);
	
	SELF.built_date := (INTEGER)ri.year_built;
	SELF.purchase_amount := (INTEGER)ri.sales_price;
	SELF.mortgage_amount := (INTEGER)ri.mortgage_loan_amount;
	
	// remap the mortgage type field per heather and brent
	mt := trim(stringlib.stringtouppercase(ri.mortgage_loan_type_code));
	fares := le.own_fares_id[1] = 'R';	// R means Fares
	fidelity := le.own_fares_id[1] in ['O','D'];
	
	self.mortgage_type := iid_constants.mortgage_type(fidelity, fares, mt);
	
	// SELF.mortgage_date := (INTEGER)ri.fares_mortgage_date; //TODO: what happened to this?
	SELF.assessed_amount := (INTEGER)ri.market_total_value;
	SELF.assessed_total_value := (INTEGER)ri.assessed_total_value;
	
	// try adding property attributes here
	self.standardized_land_use_code := ri.standardized_land_use_code;
	self.building_area := (INTEGER)ri.building_area;
	self.no_of_buildings := (INTEGER)ri.no_of_buildings;
	self.no_of_stories := (INTEGER)ri.no_of_stories;
	self.no_of_rooms := (INTEGER)ri.no_of_rooms;
	self.no_of_bedrooms := (INTEGER)ri.no_of_bedrooms;
	self.no_of_baths := (INTEGER)ri.no_of_baths;
	self.no_of_partial_baths := (INTEGER)ri.no_of_partial_baths;
	self.garage_type_code := ri.garage_type_code;
	self.parking_no_of_cars := (INTEGER)ri.parking_no_of_cars;
	self.style_code := ri.style_code;
	self.assessed_value_year := ri.assessed_value_year;
	
	
	// distressed sale fields
	self.sale_price1 := if(le.applicant_sold, (unsigned)ri.sales_price, 0);	// if Seller Property
	self.prev_purch_price1 := if(le.applicant_owned, (unsigned)ri.sales_price, 0);	
	
	SELF := le;
END;


pre_Assessments_added := JOIN (property_searched, kafid_nonFCRA,
							keyed(LEFT.own_fares_id=RIGHT.ln_fares_id) and
							(
								(unsigned)right.tax_year <= (unsigned)(((string)left.historydate)[1..4])
								AND (unsigned)right.assessed_value_year <= (unsigned)(((string)left.historydate)[1..4])
								AND (unsigned)right.market_value_year <= (unsigned)(((string)left.historydate)[1..4]) 
								AND (unsigned)right.sale_date[1..6] <= (unsigned)left.historydate
								AND (unsigned)right.recording_date[1..6] <= (unsigned)left.historydate
							) 
							and	// see that all of these dates are less than history date
							LEFT.own_fares_id[2]='A', 
						add_assess_NonFCRA(LEFT,RIGHT), LEFT OUTER, keep(100), ATMOST(keyed(LEFT.own_fares_id=RIGHT.ln_fares_id), RiskWise.max_atmost));

assessments_added := rollup(sort(pre_assessments_added, own_fares_id, isRelat, prim_name, prim_range, zip5, sec_range, dataSrce), roll_prop_searched(LEFT,RIGHT), own_fares_id, prim_name, prim_range, zip5, sec_range);

proprec add_deeds_NonFCRA(proprec le, kdf_NonFCRA ri) :=
TRANSFORM
	SELF.AD := IF(ri.ln_fares_id<>'',if (Le.AD = 'A', 'M', 'D'),le.AD);
	SELF.occupant_owned := if (ri.ln_fares_id = '', le.occupant_owned, ri.mailing_street=ri.property_full_street_address or le.occupant_owned);
	
	// get the most recent purchase info, rather than the highest purchase info
	deedPurchaseDate := if((integer)ri.contract_date=0,(integer)ri.recording_date, (integer)ri.contract_date);
	
	purchasePicker := map(le.purchase_date = deedPurchaseDate => 1, // both the same, use either one
												deedPurchaseDate > le.purchase_date => 2, // use the right one
												3);	// use the left one
												
	self.purchase_date := choose(purchasePicker, 	le.purchase_date,
																								deedPurchaseDate,
																								le.purchase_date);
	self.purchase_amount := choose(purchasePicker, 	MAX(le.purchase_amount, (unsigned)ri.sales_price),
																									(unsigned)ri.sales_price,
																									le.purchase_amount);
	
	
	SELF.purchase_date_by_did := if(le.applicant_owned,		 
																			choose(purchasePicker, 	le.purchase_date_by_did, 
																															deedPurchaseDate,
																															le.purchase_date_by_did),
																			le.purchase_date_by_did);
	SELF.prev_purch_date1 := if(le.applicant_owned,		 
																	choose(purchasePicker, 	le.prev_purch_date1,
																													deedPurchaseDate,
																													le.prev_purch_date1),
																	le.prev_purch_date1);
																
	// needed a sale date per DID rather than the last address sale date, use recording date if contract date is blank
	SELF.sale_date_by_did := if(le.applicant_sold,		
																	choose(purchasePicker, 	le.sale_date_by_did,		// purchasePicker should be the same as a salePicker here
																													deedPurchaseDate,
																													le.sale_date_by_did),
																	le.sale_date_by_did);
	SELF.sale_date1 := if(le.applicant_sold,		
																choose(purchasePicker, 	le.sale_date1,
																												deedPurchaseDate,
																												le.sale_date1),
																le.sale_date1);
															
	// pick the newest mortgage info, we are assuming the recording/sale date from assessment is the mortgage date as that is the best we can go on
	deedMortgageDate := IF(ri.ln_fares_id[2]='M', 
														IF(ri.contract_date='', 
															(INTEGER) ri.recording_date,
															(INTEGER) ri.contract_date)
															,0);
															
	mortgagePicker := map(le.purchase_date = deedMortgageDate => 1,	// both the same, use either one
												deedMortgageDate > le.purchase_date => 2, // use the right one
												3);	// use the left one												
	
	SELF.mortgage_date := choose(mortgagePicker, 	MAX(deedMortgageDate, le.purchase_date),	// choosing between recording/sale date from assessment and recording/contract date from deed.... taking the most recent
																								deedMortgageDate,
																								le.purchase_date);		
	
	
	SELF.mortgage_amount := choose(mortgagePicker, 	MAX(le.mortgage_amount,(INTEGER)ri.first_td_loan_amount),
																									(INTEGER)ri.first_td_loan_amount,
																									le.mortgage_amount);
																									
	// remap the mortgage type field per heather and brent-------- FCRA should not have fares data in it
	mt := trim(stringlib.stringtouppercase(ri.first_td_loan_type_code));
	fares := le.own_fares_id[1] = 'R';	// R means Fares
	fidelity := le.own_fares_id[1] in ['O','D'];
	
	deedMortgageType := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);
	
	nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
													
	self.mortgage_type := choose(mortgagePicker, 	nonblank(le.mortgage_type, deedMortgageType),
																								deedMortgageType,
																								le.mortgage_type);
	
	// try here to remap the finance type per heather and brent ----- 
	ft := trim(stringlib.stringtouppercase(ri.type_financing));
	self.type_financing := risk_indicators.iid_constants.type_financing(fidelity, fares, ft);
	
	self.first_td_due_date := ri.first_td_due_date;	
	
	// distressed sale fields
	self.sale_price1 := if(le.applicant_sold, choose(purchasePicker, 	MAX(le.sale_price1,(unsigned)ri.sales_price),
																																		(unsigned)ri.sales_price,
																																		le.sale_price1),
																						le.sale_price1);	// if Seller Property
	self.prev_purch_price1 := if(le.applicant_owned, choose(purchasePicker, MAX(le.prev_purch_price1,(unsigned)ri.sales_price),
																																					(unsigned)ri.sales_price,
																																					le.prev_purch_price1),
																										le.prev_purch_price1);
	
	SELF := le;
END;


pre_Deeds_added := JOIN(assessments_added,kdf_NonFCRA,
                                                RIGHT.proc_date<>0 AND // make sure we have a proc_date
                                                keyed(LEFT.own_fares_id=RIGHT.ln_fares_id) AND
                                                keyed(RIGHT.proc_date < left.historydate) AND
                                                LEFT.own_fares_id[2] IN ['D','M'], 
                                             add_deeds_NonFCRA(LEFT,RIGHT), LEFT OUTER, keep(100), 
                                             ATMOST(keyed(LEFT.own_fares_id=RIGHT.ln_fares_id) AND 
                                             keyed(RIGHT.proc_date < left.historydate), RiskWise.max_atmost));

deeds_added := rollup(sort(pre_deeds_added,prim_name,prim_range,zip5,sec_range, dataSrce),roll_prop_searched(LEFT,RIGHT),prim_name,prim_range,zip5,sec_range);

// distressed sale sorting and picking 2 most recent
dd := deeds_added(applicant_sold);
sd := sort(dd, seq, did, -sale_date1, -prev_purch_date1);

sd iter( sd le, sd ri ) := TRANSFORM
	self.iter_seq := if( le.did=ri.did, le.iter_seq+1, 1 );
	self := ri;
END;
itera := iterate( sd, iter(left,right) );	// add a seq number to each record of a DID, will keep only records 1 and 2




itera into2sales(itera le, itera ri) := transform
	self.sale_price1 := le.sale_price1;
	self.sale_date1 := le.sale_date1;
	self.prev_purch_price1 := le.prev_purch_price1;
	self.prev_purch_date1 := le.prev_purch_date1;
	
	self.sale_price2 := ri.sale_price1;
	self.sale_date2 := ri.sale_date1;
	self.prev_purch_price2 := ri.prev_purch_price1;
	self.prev_purch_date2 := ri.prev_purch_date1;
															
	self := le;
end;


distressed := rollup(itera(iter_seq<3), left.did=right.did and left.seq=right.seq, into2sales(left,right));		// already have 2 records per did and applicant sold recs

//join test to deeds_added so we have 3 records with all info

proprec fillall(deeds_added le, distressed ri) := transform
	self.sale_price1 := ri.sale_price1;
	self.sale_date1 := ri.sale_date1;
	self.prev_purch_price1 := ri.prev_purch_price1;
	self.prev_purch_date1 := ri.prev_purch_date1;
	
	self.sale_price2 := ri.sale_price2;
	self.sale_date2 := ri.sale_date2;
	self.prev_purch_price2 := ri.prev_purch_price2;
	self.prev_purch_date2 := ri.prev_purch_date2;
	
	self := le;
end;
wDistressed := join(deeds_added, distressed, left.did=right.did and left.seq = right.seq, fillall(left,right), left outer);


All_Added := UNGROUP(wDistressed+pre_property_fid(own_fares_id=''));



Layouts.Layout_Relat_Prop_Plus_BusInd to_relat_prop(Deeds_added le) :=
TRANSFORM
	SELF.isrelat := le.isrelat;
	SELF.seq := le.seq;
	SELF.did := le.did;
		
	SELF.property_status_applicant := MAP(le.applicant_sale_found => 'S',
								   le.applicant_buy_found  => 'O',
								   //le.applicant_owned OR le.applicant_sold => 'A',
								   ' ');
	SELF.property_status_family := MAP(le.family_sale_found => 'S',
								le.family_buy_found  => 'O',
								//le.family_owned OR le.family_sold => 'A',
								' ');
	SELF.property_count := 1;
	SELF.property_total := 1;
	SELF.property_owned_purchase_total := IF(le.purchase_amount < 1000, 0,
												le.purchase_amount);
	SELF.property_owned_purchase_count := (INTEGER)(le.purchase_amount >= 1000);
	SELF.property_owned_assessed_total := IF(le.assessed_amount < 1000, 0,
												le.assessed_amount);
	SELF.property_owned_assessed_count := (INTEGER)(le.assessed_amount >= 1000);
	SELF.prim_name := le.prim_name;
	SELF.prim_range := le.prim_range;
	SELF.sec_range := le.sec_range;
	SELF.zip5 := le.zip5;
	SELF.st := le.st;
	SELF.county := le.county;
	SELF.geo_blk := le.geo_blk;
	SELF.census_loose := true;
	SELF.Residential_or_Business_Ind  := '';
	SELF.historydate  := 0;
	SELF := le;
END;
Property := PROJECT(All_added, to_relat_prop(LEFT));

// earlier rollups should have resulted in single property already
// at this point.	

Single_Property := SORT(group(sort(Property,seq),seq),prim_name,prim_range,zip5,sec_range,census_loose, dataSrce);
//					was ROLLUP....get_max_prices(LEFT,RIGHT),prim_name,prim_range,zip5,sec_range);

// output(pre_property_fid, named('pre_property_fid'));
// output(property_fid, named('property_fid'));
// output(deeds_added, named('deeds_added'));
// output(itera, named('itera'));
// output(distressed, named('distressed'));
// output(wDistressed, named('wDistressed'));
// output(All_Added, named('All_Added'));

RETURN Single_Property;

END;

