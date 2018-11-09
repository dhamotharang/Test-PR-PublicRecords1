import ut, ln_propertyv2, riskwise;

export Boca_Shell_Property (GROUPED DATASET(layout_PropertyRecord) p_address,
                            GROUPED DATASET(Layout_Boca_Shell_ids) ids, 
                            boolean includeRelatives = true, 
									 boolean filter_out_fares=false) := function


layout_PropertyRecordPlus := RECORD
	risk_indicators.Layouts.layout_PropertyRecordv2;
	unsigned4 purchase_date_by_did := 0;
	unsigned4 sale_date_by_did := 0;
	risk_indicators.Layouts.Layout_Recent_Property_Sales;
	unsigned4 iter_seq := 1;
END;


kpa := ln_propertyv2.key_prop_address_v4;
kpanf := ln_propertyv2.key_prop_address_v4_no_fares;
kpo := ln_propertyv2.key_prop_ownership_v4;	
kponf := LN_PropertyV2.Key_Prop_Ownership_V4_No_Fares;


calc_napprop(boolean f,boolean l,boolean a) :=
MAP(~f AND ~l AND ~a	=> 0,
	  ~f AND ~l AND a		=> 1,
		f AND ~l AND a		=> 2,
		~f AND l AND a		=> 3,
		f AND l AND a			=> 4, 0);

layout_name := record
	qstring20	fname;
	qstring20	lname;
end;

matchrec := record
	boolean	match;
end;

matchrec fname_match(layout_name L, string20 fname) := transform
	self.match := g(FnameScore(l.fname, fname));
end;

matchrec lname_match(layout_name L, string20 lname) := transform
	self.match := g(LnameScore(L.lname, lname));
end;
	
layout_PropertyRecordPlus join_address(p_address L, KPA R) := transform
	buyer_fname_match := count(project(R.buyers, fname_match(LEFT, L.fname))(match)) > 0;
	buyer_lname_match := count(project(R.buyers, lname_match(LEFT, l.lname))(match)) > 0;
	seller_fname_match := count(Project(R.sellers, fname_match(LEFT,L.fname))(match)) > 0;
	seller_lname_match := count(project(R.sellers, lname_match(LEFT, L.lname))(match)) > 0;
	self.occupant_owned := R.occupant_owned;
	self.applicant_owned := buyer_fname_match and buyer_lname_match;
	self.applicant_sold :=  seller_lname_match and seller_fname_match;
	self.family_owned := buyer_lname_match and ~buyer_fname_match;
	self.family_sold := seller_lname_match and ~seller_fname_match;
	self.family_sale_found := self.family_sold;
	self.family_buy_found := self.family_owned;
	self.applicant_sale_found := self.applicant_sold;
	self.applicant_buy_found := self.applicant_owned;
	// naprop should be 0 on outer side of join.
	self.naprop := if (R.prim_name = '', 0, MAX(calc_napprop(buyer_fname_match, buyer_lname_match, true), calc_napprop(seller_fname_match, seller_lname_match, true))); 
	self.AD := R.AD;
	self.purchase_date := R.purchase_date;
	self.built_date := R.built_date;
	self.purchase_amount := R.purchase_amount;
	self.mortgage_amount := R.mortgage_amount;
	self.mortgage_date := R.mortgage_date;
	self.assessed_amount := R.assessed_amount;
	self.assessed_total_value := R.assessed_total_value;  
	self.date_first_seen := R.date_first_seen;
	self.date_last_seen := R.date_last_seen;
	self.datasrce := '0';
	self.county := if (l.county = '', R.county, L.county);
	self.geo_blk := if (L.geo_blk = '', R.geo_blk, L.geo_blk);
	
	// new fields for bs 3
	self.mortgage_type := R.mortgage_type;		
	self.type_financing := R.type_financing;		
	self.first_td_due_date := R.first_td_due_date;
	self.standardized_land_use_code := R.standardized_land_use_code;
	self.building_area  := R.building_area;
	self.no_of_buildings  := R.no_of_buildings;
	self.no_of_stories  := R.no_of_stories;
	self.no_of_rooms  := R.no_of_rooms;
	self.no_of_bedrooms  := R.no_of_bedrooms;
	self.no_of_baths := R.no_of_baths;
	self.no_of_partial_baths  := R.no_of_partial_baths;
	self.garage_type_code := R.garage_type_code;
	self.parking_no_of_cars := R.parking_no_of_cars;
	self.style_code := R.style_code;
	self.assessed_value_year := R.assessed_value_year;	
	
	self := L;
	SELF := [];
end;

by_addr_filtered := join(p_address(prim_name != '', zip5 != ''), KPANF,
														keyed(left.prim_range = right.prim_range) and
														keyed(left.prim_name = right.prim_name) and
														keyed(left.sec_range = right.sec_range) and
														keyed(left.zip5 = right.zip) and
														keyed(left.addr_suffix = right.suffix) and
														keyed(left.predir = right.predir) and
														keyed(left.postdir = right.postdir),
								join_address(LEFT,RIGHT), left outer, ATMOST(100)) + PROJECT(p_address(prim_name = '' or zip5 = ''), transform(layout_PropertyRecordPlus, self := left, self := [])) ;


by_addr_all := join(p_address(prim_name != '', zip5 != ''), KPA,
												keyed(left.prim_range = right.prim_range) and
												keyed(left.prim_name = right.prim_name) and
												keyed(left.sec_range = right.sec_range) and
												keyed(left.zip5 = right.zip) and
												keyed(left.addr_suffix = right.suffix) and
												keyed(left.predir = right.predir) and
												keyed(left.postdir = right.postdir),
						join_address(LEFT,RIGHT), left outer, ATMOST(100)) + PROJECT(p_address(prim_name = '' or zip5 = ''), transform(layout_PropertyRecordPlus, self := left, self := [])) ;

 
by_addr := if(filter_out_fares, by_addr_filtered, by_addr_all);




layout_PropertyRecordPlus join_did(ids L, kponf R) := transform
	self.own_fares_id := '';
	self.occupant_owned := R.occupant_owned;
	self.applicant_owned := if (L.isrelat, false, R.applicant_owned);
	self.applicant_sold := if (L.isrelat, false, R.applicant_sold);
	self.family_owned := if (L.isrelat, R.applicant_owned, false);
	self.family_sold := if (L.isrelat, R.applicant_sold, false);
	self.family_sale_found := self.family_sold;
	self.family_buy_found := self.family_owned;
	self.applicant_sale_found := self.applicant_sold;
	self.applicant_buy_found := self.applicant_owned;
	fname_match := g(FnameScore(l.fname,r.fname));
	lname_match := g(Risk_Indicators.LnameScore(l.lname,r.lname));
	self.naprop := calc_napprop(fname_match,lname_match,true);
	self.datasrce := '9';
	
	// new bs 3 stuff
	self.mortgage_type := R.mortgage_type;			
	self.type_financing := R.type_financing;		
	self.first_td_due_date := R.first_td_due_date;
	self.standardized_land_use_code := R.standardized_land_use_code;
	self.building_area  := R.building_area;
	self.no_of_buildings  := R.no_of_buildings;
	self.no_of_stories  := R.no_of_stories;
	self.no_of_rooms  := R.no_of_rooms;
	self.no_of_bedrooms  := R.no_of_bedrooms;
	self.no_of_baths := R.no_of_baths;
	self.no_of_partial_baths  := R.no_of_partial_baths;
	self.garage_type_code := R.garage_type_code;
	self.parking_no_of_cars := R.parking_no_of_cars;
	self.style_code := R.style_code;
	self.assessed_value_year := R.assessed_value_year;	
	
	self.sale_price1 := R.sale_price1;
	self.sale_date1 := R.sale_date1;	
	self.prev_purch_price1 := R.prev_purch_price1;
	self.prev_purch_date1 := R.prev_purch_date1;
	self.sale_price2 := R.sale_price2;
	self.sale_date2 := R.sale_date2;
	self.prev_purch_price2 := R.prev_purch_price2;
	self.prev_purch_date2 := R.prev_purch_date2;
	
	self := L;
	self := R;
	self := [];
end;

by_did1 := join(ids, KPONF,
										left.did != 0 and
										keyed(left.did = right.did),
									join_did(LEFT,RIGHT), ATMOST(riskwise.max_atmost), KEEP(500));

layout_PropertyRecordPlus join_did2(ids L, kpo R) := transform
	self.own_fares_id := '';
	self.occupant_owned := R.occupant_owned;
	self.applicant_owned := if (L.isrelat, false, R.applicant_owned);
	self.applicant_sold := if (L.isrelat, false, R.applicant_sold);
	self.family_owned := if (L.isrelat, R.applicant_owned, false);
	self.family_sold := if (L.isrelat, R.applicant_sold, false);
	self.family_sale_found := self.family_sold;
	self.family_buy_found := self.family_owned;
	self.applicant_sale_found := self.applicant_sold;
	self.applicant_buy_found := self.applicant_owned;
	fname_match := g(FnameScore(l.fname,r.fname));
	lname_match := g(Risk_Indicators.LnameScore(l.lname,r.lname));
	self.naprop := calc_napprop(fname_match,lname_match,true);
	self.datasrce := '9';
	
	// new bs 3 stuff
	self.mortgage_type := R.mortgage_type;			
	self.type_financing := R.type_financing;		
	self.first_td_due_date := R.first_td_due_date;
	self.standardized_land_use_code := R.standardized_land_use_code;
	self.building_area  := R.building_area;
	self.no_of_buildings  := R.no_of_buildings;
	self.no_of_stories  := R.no_of_stories;
	self.no_of_rooms  := R.no_of_rooms;
	self.no_of_bedrooms  := R.no_of_bedrooms;
	self.no_of_baths := R.no_of_baths;
	self.no_of_partial_baths  := R.no_of_partial_baths;
	self.garage_type_code := R.garage_type_code;
	self.parking_no_of_cars := R.parking_no_of_cars;
	self.style_code := R.style_code;
	self.assessed_value_year := R.assessed_value_year;	
	
	self.sale_price1 := R.sale_price1;
	self.sale_date1 := R.sale_date1;	
	self.prev_purch_price1 := R.prev_purch_price1;
	self.prev_purch_date1 := R.prev_purch_date1;
	self.sale_price2 := R.sale_price2;
	self.sale_date2 := R.sale_date2;
	self.prev_purch_price2 := R.prev_purch_price2;
	self.prev_purch_date2 := R.prev_purch_date2;
	
	self := L;
	self := R;
	self := [];
end;


by_did2 := join(ids, KPO,
								left.did != 0 and
								keyed(left.did = right.did),
							join_did2(LEFT,RIGHT), atmost(riskwise.max_atmost), KEEP(500));
							
							
by_did := if(filter_out_fares, by_did1, by_did2);							
	
			

together := group(sort(ungroup(by_addr + by_did), seq, prim_range, prim_name, sec_range, zip5, datasrce),seq);


together roll_result(together Le, together Ri) := transform
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
	
	// change the way these 2 fields roll - take the one that is not the relative
	pick := map(~le.isrelat => 1,
							~ri.isrelat => 2,
							3);
	SELF.isrelat := choose(pick, 	le.isrelat,
																ri.isrelat,
																le.isrelat);
	SELF.did := choose(pick, 	le.did,
														ri.did,
														le.did);
	
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
	
	
	
	self.county := if (le.county = '', Ri.county, Le.county);
	self.geo_blk := if (Le.geo_blk = '', Ri.geo_blk, Le.geo_blk);
	
	
	// get most recent sale info, rather than highest sale info
	sale1Picker := map(~le.isrelat and ri.isrelat => 3,	// use left one
										 le.isrelat and ~ri.isrelat => 2,	// use the right one
										 le.isrelat and ri.isrelat => 4,	// don't use any
										 le.sale_date_by_did = ri.sale_date_by_did => 1,	// use either one, they are the same
										 ri.sale_date_by_did > le.sale_date_by_did => 2, 	// use the right one
										 3);	// use the left one
										 
	
	SELF.sale_date_by_did := choose(sale1Picker, 	le.sale_date_by_did,
																								ri.sale_date_by_did,
																								le.sale_date_by_did,
																								0);
																								
																								
	prevPicker := map(~le.isrelat and ri.isrelat => 3,	// use left one
										 le.isrelat and ~ri.isrelat => 2,	// use the right one
										 le.isrelat and ri.isrelat => 4,	// don't use any
										 le.purchase_date_by_did = ri.purchase_date_by_did => 1,	// both the same, use either one
										 ri.purchase_date_by_did > le.purchase_date_by_did => 2, // use the right one
										 3);	// use the left one
	
	SELF.purchase_date_by_did := choose(prevPicker, le.purchase_date_by_did,
																									ri.purchase_date_by_did,
																									le.purchase_date_by_did,
																									0);																							
		
																							
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

All_Added :=  rollup(together, roll_result(LEFT,RIGHT), prim_range, prim_name, sec_range, zip5);	


// rollup by did here, all_added is rolling up by address - then join them together, populate addr fields from all_added and did fields from the did rollup
applicantByDidRecs := group(sort(by_did(~isrelat), seq),seq);

applicantByDidRecs roll_didResult(applicantByDidRecs Le, applicantByDidRecs Ri) := transform
	// get most recent sale info, rather than highest sale info
	sale1Picker := map(le.sale_date_by_did = ri.sale_date_by_did => 1,	// both the same, use either one
										 ri.sale_date_by_did > le.sale_date_by_did => 2, // use the right one
										 3);	// use the left one
										 
	
	// SELF.sale_date_by_did := calculated in the address rollup, the did checking is done in getallbocashelldata
	
	SELF.sale_date1 := choose(sale1Picker, 	MAX(le.sale_date1,ri.sale_date1),
																					ri.sale_date1,
																					le.sale_date1);
	
	self.sale_price1 := choose(sale1Picker, MAX(le.sale_price1,ri.sale_price1),
																					ri.sale_price1,
																					le.sale_price1);
		
	prevPicker := map(le.purchase_date_by_did = ri.purchase_date_by_did => 1,	// both the same, use either one
										 ri.purchase_date_by_did > le.purchase_date_by_did => 2, // use the right one
										 3);	// use the left one
	
	// SELF.purchase_date_by_did := calculated in the address rollup, the did checking is done in getallbocashelldata
	
	SELF.prev_purch_date1 := choose(prevPicker, MAX(le.prev_purch_date1,ri.prev_purch_date1),
																							ri.prev_purch_date1,
																							le.prev_purch_date1);
										 
	self.prev_purch_price1 := choose(prevPicker, MAX(le.prev_purch_price1,ri.prev_purch_price1),
																							 ri.prev_purch_price1,
																							 le.prev_purch_price1);
																					
																					
																					
	sale2Picker := map(le.sale_date2= ri.sale_date2 => 1,	// both the same, use either one
										 ri.sale_date2 > le.sale_date2 => 2, // use the right one
										 3);	// use the left one			
										 
	SELF.sale_date2 := choose(sale2Picker, 	MAX(le.sale_date2,ri.sale_date2),
																					ri.sale_date2,
																					le.sale_date2);
	self.sale_price2 := choose(sale2Picker, MAX(le.sale_price2, ri.sale_price2),
																					ri.sale_price2,
																					le.sale_price2);
																					
	prevPicker2 := map(le.prev_purch_date2 = ri.prev_purch_date2 => 1,	// both the same, use either one
										 ri.prev_purch_date2 > le.prev_purch_date2 => 2, // use the right one
										 3);	// use the left one																				
	
	SELF.prev_purch_date2 := choose(prevPicker2, 	MAX(le.prev_purch_date2,ri.prev_purch_date2),
																								ri.prev_purch_date2,
																								le.prev_purch_date2); 
	self.prev_purch_price2 := choose(prevPicker2, MAX(le.prev_purch_price2,ri.prev_purch_price2),
																								ri.prev_purch_price2,
																								le.prev_purch_price2);																						 
																							 
	self.did := le.did;
	self.isrelat := le.isrelat;
	self.seq := le.seq;
	self := [];																						 
end;
did_rolled := rollup(applicantByDidRecs, true, roll_didResult(LEFT,RIGHT));



// join them
layout_PropertyRecordPlus addrDidJoin(all_added le, did_rolled ri) := transform
	SELF.sale_date1 := ri.sale_date1;
	self.sale_price1 := ri.sale_price1;
		
	SELF.prev_purch_date1 := ri.prev_purch_date1; 
	self.prev_purch_price1 := ri.prev_purch_price1;
	
	SELF.sale_date2 := ri.sale_date2;
	self.sale_price2 := ri.sale_price2;
	
	SELF.prev_purch_date2 := ri.prev_purch_date2; 
	self.prev_purch_price2 := ri.prev_purch_price2;
	
	self := le;
end;
addDidtoAddr := group(sort(join(all_added, did_rolled, left.seq=right.seq and left.did=right.did, addrDidJoin(LEFT,RIGHT), left outer), seq), seq);



layout_out := RECORD
	layout_relat_prop_plus;
	string5   mortgage_type;	
	string4   type_financing;	
	string8   first_td_due_date;	
	string standardized_land_use_code;
	unsigned building_area ;
	unsigned no_of_buildings ;
	unsigned no_of_stories ;
	unsigned no_of_rooms ;
	unsigned no_of_bedrooms ;
	unsigned no_of_baths;
	unsigned no_of_partial_baths ;
	string garage_type_code;
	unsigned parking_no_of_cars;
	string style_code;
	string4	assessed_value_year;
END;

Layouts.Layout_Relat_Prop_Plus_BusInd to_relat_prop(addDidtoAddr le) :=
TRANSFORM
	SELF.isrelat := le.isrelat;
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.property_status_applicant := MAP(le.applicant_owned AND le.applicant_sold => 'A',
								   le.applicant_sale_found => 'S',
								   le.applicant_buy_found  => 'O',
								   ' ');
	SELF.property_status_family := MAP(le.family_owned AND le.family_sold => 'A',
								le.family_sale_found => 'S',
								le.family_buy_found  => 'O',
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
Property := PROJECT(addDidtoAddr, to_relat_prop(LEFT));


Single_Property := SORT(Property,prim_name,prim_range,zip5,sec_range,census_loose, dataSrce); 

return single_property;

end;