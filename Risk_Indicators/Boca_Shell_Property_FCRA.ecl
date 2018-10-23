IMPORT _Control, FCRA, ut, RiskWise, ln_propertyv2;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_Property_FCRA (GROUPED DATASET(layout_PropertyRecord) addresses,
                                 GROUPED DATASET(Layout_Boca_Shell_ids) ids) := FUNCTION

calc_napprop (boolean f,boolean l,boolean a) :=
  MAP (~a	=> 0, ~f AND ~l => 1, f AND ~l => 2, ~f AND l => 3, 4);

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

layout_PropertyRecordPlus := RECORD
	Layouts.layout_PropertyRecordv2;
	unsigned4 purchase_date_by_did := 0;
	unsigned4 sale_date_by_did := 0;
	Layouts.Layout_Recent_Property_Sales;
	unsigned4 iter_seq := 1;
END;
	
// Get overrides: daraset addresses has a placeholder for overrides, but initially it's empty 
layout_PropertyRecordPlus GetCorrections (layout_PropertyRecord Le, Layout_Boca_Shell_ids Ri) := TRANSFORM
  SELF.prop_correct_lnfare := Ri.prop_correct_lnfare;
	SELF.prop_correct_ffid   := Ri.prop_correct_ffid; //? don't really need those?
  SELF := Le;
	self := [];
END;

p_address := JOIN (addresses, ids,
                   (Left.seq = Right.seq) AND
                   (Left.did = Right.did),
                   GetCorrections (Left, Right));
									 

layout_PropertyRecordPlus join_address(layout_PropertyRecordPlus L, ln_propertyv2.key_prop_address_FCRA_V4 R) := transform
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
end;

by_addr_roxie := join(p_address(prim_name != '', zip5 != ''), ln_propertyv2.key_prop_address_FCRA_V4,
				keyed(left.prim_range = right.prim_range) and
				keyed(left.prim_name = right.prim_name) and
				keyed(left.sec_range = right.sec_range) and
				keyed(left.zip5 = right.zip) and
				keyed(left.addr_suffix = right.suffix) and
				keyed(left.predir = right.predir) and
				keyed(left.postdir = right.postdir) AND
        // don't get data from records whose ln_fares_id are among corrections' fares_id;
        NOT EXISTS (Right.fares (ln_fare_id IN Left.prop_correct_lnfare)),
			join_address(LEFT,RIGHT), left outer,
			ATMOST(
				keyed(left.prim_range = right.prim_range) and
				keyed(left.prim_name = right.prim_name) and
				keyed(left.sec_range = right.sec_range) and
				keyed(left.zip5 = right.zip) and
				keyed(left.addr_suffix = right.suffix) and
				keyed(left.predir = right.predir) and
				keyed(left.postdir = right.postdir),
				100
			      )
	       );

by_addr_thor := join(distribute(p_address(prim_name != '', zip5 != ''), hash64(prim_range, prim_name, sec_range, zip5, addr_suffix, predir, postdir)), 
        distribute(pull(ln_propertyv2.key_prop_address_FCRA_V4), hash64(prim_range, prim_name, sec_range, zip, suffix, predir, postdir)),
				(left.prim_range = right.prim_range) and
				(left.prim_name = right.prim_name) and
				(left.sec_range = right.sec_range) and
				(left.zip5 = right.zip) and
				(left.addr_suffix = right.suffix) and
				(left.predir = right.predir) and
				(left.postdir = right.postdir) AND
        // don't get data from records whose ln_fares_id are among corrections' fares_id;
        NOT EXISTS (Right.fares (ln_fare_id IN Left.prop_correct_lnfare)),
			join_address(LEFT,RIGHT), left outer,
			ATMOST(
				(left.prim_range = right.prim_range) and
				(left.prim_name = right.prim_name) and
				(left.sec_range = right.sec_range) and
				(left.zip5 = right.zip) and
				(left.addr_suffix = right.suffix) and
				(left.predir = right.predir) and
				(left.postdir = right.postdir),
				100
			      ), LOCAL
	       );
         
#IF(onThor)
	by_addr := by_addr_thor + p_address(prim_name = '' or zip5 = '');
#ELSE
	by_addr := by_addr_roxie + p_address(prim_name = '' or zip5 = '');
#END
  
layout_PropertyRecordPlus join_did(ids L, ln_propertyv2.key_prop_ownership_FCRA_V4 R) := transform
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

by_did_roxie := UNGROUP(JOIN (ids, ln_propertyv2.key_prop_ownership_FCRA_V4,
                left.did != 0 and
                keyed (left.did = right.did) AND
                // don't get data from records whose ln_fares_id are among corrections' fares_id
                NOT EXISTS (Right.fares (ln_fare_id IN Left.prop_correct_lnfare)),
                join_did (LEFT,RIGHT), KEEP(500), ATMOST(keyed (left.did = right.did), RiskWise.max_atmost)));

by_did_thor := JOIN (distribute(ids(did!=0), hash64(did)), 
                distribute(pull(ln_propertyv2.key_prop_ownership_FCRA_V4), hash64(did)),
                (left.did = right.did) AND
                // don't get data from records whose ln_fares_id are among corrections' fares_id
                NOT EXISTS (Right.fares (ln_fare_id IN Left.prop_correct_lnfare)),
                join_did (LEFT,RIGHT), KEEP(500), ATMOST((left.did = right.did), RiskWise.max_atmost), LOCAL);

#IF(onThor)
	by_did := by_did_thor;
#ELSE
	by_did := by_did_roxie;
#END

all_props := UNGROUP (by_addr + by_did);

// Now we have to add corrections - they're "right and complete" by definition.
// We could have the same keys (by-address, by-did) as used above, 
// the problem here is that override by-address isn't linked to input 'addresses'
// in any way, since it can (and, probably, almost always will) have different addresses:
// new properties, changed address, etc.

// Here's the trick: it seems that for properties' override the following is ALWAYS true:
//   1) by-did-key has all possible deeds/assessments/mortgages for given person
//      (including those that would be in override by-address-key);
//   2) by-did-key never contains d/a/m which customer wants to delete from base records
//   3) all records in override's by-did-key have valid did;
// Thus we can use d/a/m from by-did-key ONLY

layout_PropertyRecordPlus GetCorrected (Layout_Boca_Shell_ids L,
                                    FCRA.key_override_property.ownership R) := TRANSFORM
  SELF.seq := L.seq;
  SELF.own_fares_id := ''; //this is aggregation
	self.family_owned := if (R.isrelat, R.applicant_owned, false);
	self.family_sold := if (R.isrelat, R.applicant_sold, false);
	self.family_buy_found := self.family_owned;
	self.family_sale_found := self.family_sold;
	self.applicant_sale_found := R.applicant_sold;
	self.applicant_buy_found := R.applicant_owned;
  //? don't really need to calculate those: the record came from correction, so the score should be highest
	fname_match := g(FnameScore(l.fname,r.fname));
	lname_match := g(LnameScore(l.lname,r.lname));
	self.naprop := calc_napprop(fname_match,lname_match,true);
	self.datasrce := 'C'; // corrections. clarify
	
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
	
	self := R;
	self := L; //actually, overrides only, can be made blank (or ignored) here.
END;

new_props_roxie := JOIN (ids, FCRA.key_override_property.ownership,	
                   Left.did != 0 AND keyed (Left.did = Right.did),
                   GetCorrected (Left, Right), ATMOST(keyed (Left.did = Right.did), RiskWise.max_atmost));

new_props_thor := GROUP(SORT(JOIN (distribute(ids(did!=0), hash64(did)), 
                   distribute(pull(FCRA.key_override_property.ownership), hash64(did)),	
                   (Left.did = Right.did),
                   GetCorrected (Left, Right), ATMOST((Left.did = Right.did), RiskWise.max_atmost), LOCAL), seq),seq);

#IF(onThor)
	new_props := new_props_thor;
#ELSE
	new_props := new_props_roxie;
#END

all_corrected :=  new_props + all_props;

together := GROUP (SORT (all_corrected, seq, prim_range, prim_name, sec_range, zip5, datasrce), seq);

//TODO: data source 'C' means override; it might be used for calculation left-right priority
together roll_result(together Le, together Ri) := TRANSFORM
  // 0- either both left and right from corretions both or none;
  // 1- left from corrections;
  // 2 - right from corrections;
  unsigned1 take := IF (Le.datasrce = 'C', 
                        IF (Ri.datasrce = 'C', 0, 1),
                        IF (Ri.datasrce = 'C', 2, 0));
	SELF.NAPROP := MAP (take = 1 => le.naprop,
                      take = 2 => ri.naprop,
                      MAX(le.naprop,ri.naprop));
	SELF.AD :=  MAP (take = 1 => le.AD,
                   take = 2 => ri.AD,
                   MAP (le.AD = '' => ri.AD,
                        ri.AD = '' => le.AD,
                        le.AD <> ri.AD => 'M', 
                        le.AD));
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
	
	SELF.did := MAP (take = 1 => le.did, take = 2 => ri.did, ut.Min2(le.did,ri.did));
	self.county := if (le.county = '', Ri.county, Le.county);
	self.geo_blk := if (Le.geo_blk = '', Ri.geo_blk, Le.geo_blk);
	
		// get the most recent purchase info, rather than the highest purchase info
	purchasePicker := map(take = 1 => 3,	// left is correction, use the left
												take = 2 => 2,	// right is correction, use the right
												le.purchase_date = ri.purchase_date => 1, // both the same, use either one
												ri.purchase_date > le.purchase_date => 2, // use the right one
												3);	// use the left one
												
	self.purchase_date := choose(purchasePicker, 	Le.purchase_date,
																								ri.purchase_date,
																								le.purchase_date);
	self.purchase_amount := choose(purchasePicker, 	MAX(Le.purchase_amount, Ri.purchase_amount),
																									ri.purchase_amount,
																									le.purchase_amount);
	

	// get most recent sale info, rather than highest sale info
	sale1Picker := map(	take = 1 => 3,	// left is correction, use the left
											take = 2 => 2,	// right is correction, use the right
											le.sale_date_by_did = ri.sale_date_by_did => 1,	// both the same, use either one
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
		
	prevPicker := map(take = 1 => 3,	// left is correction, use the left
										take = 2 => 2,	// right is correction, use the right
										le.purchase_date_by_did = ri.purchase_date_by_did => 1,	// both the same, use either one
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
	mortgagePicker := map(take = 1 => 3,	// left is correction record, use left
												take = 2 => 2,	// right is correction record, use right
												le.mortgage_date = ri.mortgage_date => 1,	// both the same, use either one
												ri.mortgage_date > le.mortgage_date => 2, // use the right one
												3);	// use the left one
												
	SELF.mortgage_amount := choose(mortgagePicker, 	MAX(le.mortgage_amount,ri.mortgage_amount),
																									ri.mortgage_amount,
																									le.mortgage_amount);
	SELF.mortgage_date := choose(mortgagePicker, 	le.mortgage_date,
																								ri.mortgage_date,
																								le.mortgage_date);
	
	nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
	
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
	assessPicker := map(take = 1 => 3,	// left is correction, use the left
											take = 2 => 2,	// right is correction, use the right
											(integer)le.assessed_value_year = (integer)ri.assessed_value_year => 1,	// both the same, use either one
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


// distressed sale sorting and picking 2 most recent
dd := All_Added(applicant_sold);
sd := sort(dd, did, -sale_date1, -prev_purch_date1);

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
	
	self.sale_price2 := ri.sale_price2;
	self.sale_date2 := ri.sale_date2;
	self.prev_purch_price2 := ri.prev_purch_price2;
	self.prev_purch_date2 := ri.prev_purch_date2;
															
	self := le;
end;
distressed := rollup(itera(iter_seq<3), left.did=right.did and left.seq=right.seq, into2sales(left,right));		// already have 2 records per did and applicant sold recs

//join so we have 3 records with all info

All_Added fillall(All_Added le, All_Added ri) := transform
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
wDistressed := group(sort( join(All_Added, distressed, left.did=right.did and left.seq=right.seq, fillall(left,right), left outer), seq), seq);





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

Layouts.Layout_Relat_Prop_Plus_BusInd to_relat_prop(all_added le) := TRANSFORM
	SELF.isrelat := le.isrelat;
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.property_status_applicant := MAP(le.applicant_owned AND le.applicant_sold => 'A',// historical does this differently
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
Property := PROJECT(wDistressed, to_relat_prop(LEFT));

// earlier rollups should have resulted in single property already at this point.	
Single_Property := SORT(Property,prim_name,prim_range,zip5,sec_range,census_loose, dataSrce);

return single_property;

end;

