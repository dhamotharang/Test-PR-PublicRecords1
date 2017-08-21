import ut, doxie, risk_indicators;

export File_Prop_Address_Prep_v4(boolean isFCRA, boolean filter_fares=false) := function

unsigned2 MAX_EMBEDDED := 100;

layout_name := record
	qstring20	fname;
	qstring20	lname;
end;

layout_fares := RECORD
  string12 ln_fare_id;
END;

myrec := record
	unsigned1	roll_count;
	string1	AD;
	boolean	occupant_owned;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	
	string5   mortgage_type;	
	string4   type_financing;		
	string8   first_td_due_date;	
	
	UNSIGNED4 assessed_amount;
	UNSIGNED4 assessed_total_value;
	
	UNSIGNED1 property_count;
	UNSIGNED1 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	
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
	
	string12	ln_fares_id;
	string10 	prim_range ;
	string2  	predir ;
	string28 	prim_name ;
	string4  	suffix ;
	string2  	postdir ;
	string10 	unit_desig ;
	string8  	sec_range ;
	string25 	p_city_name ;
	string2  	st ;
	string5  	zip;
	string4	zip4;
	string3 	county;
	string7 	geo_blk;
	dataset(layout_name) buyers {MAXCOUNT (MAX_EMBEDDED)};
	dataset(layout_name) sellers {MAXCOUNT (MAX_EMBEDDED)};
  DATASET (layout_fares) fares {MAXCOUNT (MAX_EMBEDDED)};
end;

// source_code[2]='P' - property 
// ln_fares_id[1] != 'R' - FCRA compliant data
// Use FCRA boolean or filter_fares boolean to determine if FARES records need to be filtered out
fdf := LN_PropertyV2.file_search_building (source_code[2] = 'P', prim_name != '', zip != '');
no_fares_df := fdf(ln_fares_id[1] != 'R');
df := if(isFCRA or filter_fares, no_fares_df, fdf);

df2 := dedup(sort(distribute(df,hash(ln_fares_id)),
				 ln_fares_id, prim_range, prim_name, sec_range, zip, predir, postdir, suffix, lname, fname, local),
			 ln_fares_id, prim_range, prim_name, sec_range, zip, predir, postdir, suffix, lname, fname, local);
		
myrec into_myrec(df L) := transform
	self.buyers := if (L.source_code[1] = 'O', dataset([{L.fname, l.lname}],layout_name));
	self.sellers := if (L.source_code[1] = 'S', dataset([{L.fname, l.lname}],layout_name));
	self := L;
	self.roll_count := 1;
  self.fares := DATASET ([{L.ln_fares_id}], layout_fares);
	self := [];
end;

df3 := project(df2, into_myrec(LEFT));

df3 get_assessors(df3 L, ln_propertyv2.File_Assessment R) := transform
	SELF.occupant_owned 	:= r.ln_fares_id != '' and r.mailing_full_street_address=r.property_full_street_address;
	SELF.purchase_date 		:= if((integer)r.sale_date=0,(integer)r.recording_date, (integer)r.sale_date);		
	
	SELF.built_date 		:= (INTEGER)r.year_built;
	SELF.purchase_amount 	:= (INTEGER)r.sales_price;
	SELF.mortgage_amount 	:= (INTEGER)r.mortgage_loan_amount;
	// remap the mortgage type field per heather and brent
	mt := trim(stringlib.stringtouppercase(r.mortgage_loan_type_code));
	fares := l.ln_fares_id[1] = 'R';	// R means Fares
	fidelity := l.ln_fares_id[1] in ['O','D'];
	
	self.mortgage_type := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);
	
	SELF.assessed_amount 	:= (INTEGER)r.market_total_value;
	SELF.assessed_total_value 	:= (INTEGER)r.assessed_total_value;
	
	self.standardized_land_use_code := r.standardized_land_use_code;
	self.building_area := (INTEGER)r.building_area;
	self.no_of_buildings := (INTEGER)r.no_of_buildings;
	self.no_of_stories := (INTEGER)r.no_of_stories;
	self.no_of_rooms := (INTEGER)r.no_of_rooms;
	self.no_of_bedrooms := (INTEGER)r.no_of_bedrooms;
	self.no_of_baths := (INTEGER)r.no_of_baths;
	self.no_of_partial_baths := (INTEGER)r.no_of_partial_baths;
	self.garage_type_code := r.garage_type_code;
	self.parking_no_of_cars := (INTEGER)r.parking_no_of_cars;
	self.style_code := r.style_code;
	self.assessed_value_year := r.assessed_value_year;
	
	self.AD 				:= if (R.ln_fares_id != '', 'A', '');
	self := L;
end;

// Use FCRA boolean or filter_fares boolean to determine if FARES records need to be filtered out
assessments := ln_propertyv2.File_Assessment;
no_fares_assessments := assessments(ln_fares_id[1] != 'R');
assessment_file :=  if(isFCRA or filter_fares, no_fares_assessments, assessments);

with_assess := join(df3, 
		  distribute(assessment_file, hash(ln_Fares_id)),
			left.ln_fares_id = right.ln_fares_id,
		  get_assessors(LEFT,RIGHT), left outer, local);


with_assess get_deeds(with_assess L, ln_propertyv2.File_Deed R) := transform
	SELF.occupant_owned := if (r.ln_fares_id = '', l.occupant_owned, r.mailing_street=r.property_full_street_address or l.occupant_owned);
	
	// get the most recent purchase info, rather than the highest purchase info
	deedPurchaseDate := if((integer)r.contract_date=0,(integer)r.recording_date, (integer)r.contract_date);

	purchasePicker := map(l.purchase_date = deedPurchaseDate => 1, // both the same, use either one
												deedPurchaseDate > l.purchase_date => 2, // use the right one
												3);	// use the left one
												
	self.purchase_date := choose(purchasePicker, 	L.purchase_date,
																								deedPurchaseDate,
																								l.purchase_date);
	self.purchase_amount := choose(purchasePicker, 	max(L.purchase_amount, (unsigned)r.sales_price),
																									(unsigned)r.sales_price,
																									l.purchase_amount);

	
	// pick the newest mortgage info, we are assuming the recording/sale date from assessment is the mortgage date as that is the best we can go on
	deedMortgageDate := IF(r.ln_fares_id[2]='M', 
														IF(r.contract_date='', 
															(INTEGER) r.recording_date,
															(INTEGER) r.contract_date)
															,0);
															
	mortgagePicker := map(l.purchase_date = deedMortgageDate => 1,	// both the same, use either one
												deedMortgageDate > l.purchase_date => 2, // use the right one
												3);	// use the left one												
	
	SELF.mortgage_date := choose(mortgagePicker, 	max(deedMortgageDate, l.purchase_date),	// choosing between recording/sale date from assessment and recording/contract date from deed.... taking the most recent
																								deedMortgageDate,
																								l.purchase_date);		
	
	
	SELF.mortgage_amount := choose(mortgagePicker, 	max(l.mortgage_amount,(INTEGER)r.first_td_loan_amount),
																									(INTEGER)r.first_td_loan_amount,
																									l.mortgage_amount);
																									
	// remap the mortgage type field per heather and brent-------- FCRA should not have fares data in it
	mt := trim(stringlib.stringtouppercase(r.first_td_loan_type_code));
	fares := l.ln_fares_id[1] = 'R';	// R means Fares
	fidelity := l.ln_fares_id[1] in ['O','D'];
	
	deedMortgageType := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);

	
	nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
													
	self.mortgage_type := choose(mortgagePicker, 	nonblank(l.mortgage_type, deedMortgageType),
																								deedMortgageType,
																								l.mortgage_type);
	
	// remap the finance type per heather and brent ----- 
	ft := trim(stringlib.stringtouppercase(r.type_financing));
	self.type_financing := risk_indicators.iid_constants.type_financing(fidelity, fares, ft);
	
	self.first_td_due_date := r.first_td_due_date;	
	
	self.AD	:= if (R.ln_fares_id != '',	if (L.AD = 'A', 'M', 'D'),L.AD);
	self := L;
end;

// Use FCRA boolean or filter_fares boolean to determine if FARES records need to be filtered out
deeds := Ln_propertyv2.file_deed;
no_fares_deeds := deeds(ln_fares_id[1] != 'R');
deed_file := if(isFCRA or filter_fares, no_fares_deeds, deeds);

with_deeds := join(with_assess, 
		  distribute(deed_file, hash(Ln_fares_id)),
			left.ln_fares_id = right.ln_fares_id,
		  get_deeds(LEFT,RIGHT), left outer, local);
				
			

ready_to_roll := group(sort(distribute(with_deeds, hash(prim_range, prim_name, sec_range, zip, suffix)),
						prim_range, prim_name, sec_range, zip, suffix, predir, postdir, ln_fares_id/*, -sale_date1, -prev_purch_date1*/, local),
					prim_range, prim_name, sec_Range, zip, suffix, predir, postdir, local);
					
					
ready_to_roll_appcnt := record
ready_to_roll;
unsigned4 cntGroup;
end;

ready_to_roll_appcnt tAppendCnt( ready_to_roll L,integer cnt) := transform
self.cntGroup := (cnt-1) DIV MAX_EMBEDDED;
self := L;
end;

ready_to_roll_new := project(ready_to_roll,tAppendCnt(left,counter));
			

ready_to_roll_new pre_proc(ready_to_roll_new L) := transform
  self.ln_fares_id := L.ln_fares_id;
	SELF.property_count := 1;
	SELF.property_total := 1;
	SELF.property_owned_purchase_total := IF(L.purchase_amount < 1000, 0,
												L.purchase_amount);
	SELF.property_owned_purchase_count := (INTEGER)(l.purchase_amount >= 1000);
	SELF.property_owned_assessed_total := IF(l.assessed_amount < 1000, 0,
												l.assessed_amount);
	SELF.property_owned_assessed_count := (INTEGER)(l.assessed_amount >= 1000);
	self := L;
end;

really_ready_to_roll := project(ready_to_roll_new, pre_proc(LEFT));



really_ready_to_roll roll_props(really_ready_to_roll L, really_ready_to_roll R) := transform
	self.roll_count := L.roll_count + R.roll_count;
	self.buyers := L.buyers +  R.buyers;
	self.sellers := L.sellers + R.sellers;
	self.AD	:= if (L.AD = '', R.AD,
                 if (R.AD = '', L.AD,	if (L.AD != R.AD, 'M', L.AD)));
	self.occupant_owned := l.occupant_owned or R.occupant_owned;
	
	// get the most recent purchase info, rather than the highest purchase info
	purchasePicker := map(l.purchase_date = r.purchase_date => 1, // both the same, use either one
												r.purchase_date > l.purchase_date => 2, // use the right one
												3);	// use the left one
												
	self.purchase_date := choose(purchasePicker, 	L.purchase_date,
																								r.purchase_date,
																								l.purchase_date);
	self.purchase_amount := choose(purchasePicker, 	max(L.purchase_amount, R.purchase_amount),
																									r.purchase_amount,
																									l.purchase_amount);
	
	
	
	// get most recent mortgage info, rather than highest mortgage info
	mortgagePicker := map(l.mortgage_date = r.mortgage_date => 1,	// both the same, use either one
												r.mortgage_date > l.mortgage_date => 2, // use the right one
												3);	// use the left one
												
	nonblank(string a, string b) := if(b='', a, b);	// return the populated one, or if both populated then the right one
												
	SELF.mortgage_amount := choose(mortgagePicker, max(l.mortgage_amount,r.mortgage_amount),
																								 r.mortgage_amount,
																								 l.mortgage_amount);
	SELF.mortgage_date := choose(mortgagePicker, l.mortgage_date,
																							 r.mortgage_date,
																							 l.mortgage_date);
	SELF.mortgage_type := choose(mortgagePicker, nonblank(l.mortgage_type,r.mortgage_type),		
																												r.mortgage_type,
																												l.mortgage_type);	
	self.type_financing := choose(mortgagePicker, nonblank(l.type_financing,r.type_financing),
																												 r.type_financing,
																												 l.type_financing);
	self.first_td_due_date := choose(mortgagePicker, nonblank(l.first_td_due_date,r.first_td_due_date),
																														r.first_td_due_date,
																														l.first_td_due_date);
	
	// pick the most recent assessed record we have and keep it consistent with all data
	assessPicker := map((integer)l.assessed_value_year = (integer)r.assessed_value_year => 1,	// both the same, use either one
											(integer)r.assessed_value_year > (integer)l.assessed_value_year => 2,	// use the right
											3);	// use the left
																				 
	self.built_date := choose(assessPicker, ut.min2(L.built_date, R.built_date),
																					r.built_date,
																					l.built_date);
	
	// new property attributes stuff
	self.standardized_land_use_code := choose(assessPicker, nonblank(l.standardized_land_use_code, r.standardized_land_use_code),
																													r.standardized_land_use_code,
																													l.standardized_land_use_code);
	self.building_area := choose(assessPicker, 	max(l.building_area, r.building_area),
																							r.building_area,
																							l.building_area);
	self.no_of_buildings := choose(assessPicker, 	max(l.no_of_buildings, r.no_of_buildings),
																								r.no_of_buildings,
																								l.no_of_buildings);
	self.no_of_stories := choose(assessPicker, 	max(l.no_of_stories, r.no_of_stories),
																							r.no_of_stories,
																							l.no_of_stories);
	self.no_of_rooms := choose(assessPicker, 	max(l.no_of_rooms, r.no_of_rooms),
																						r.no_of_rooms,
																						l.no_of_rooms);
	self.no_of_bedrooms := choose(assessPicker, max(l.no_of_bedrooms, r.no_of_bedrooms),
																							r.no_of_bedrooms,
																							l.no_of_bedrooms);
	self.no_of_baths := choose(assessPicker, 	max(l.no_of_baths, r.no_of_baths),
																						r.no_of_baths,
																						l.no_of_baths);
	self.no_of_partial_baths := choose(assessPicker, 	max(l.no_of_partial_baths, r.no_of_partial_baths),
																										r.no_of_partial_baths,
																										l.no_of_partial_baths);
	self.garage_type_code := choose(assessPicker, nonblank(l.garage_type_code, r.garage_type_code),
																								r.garage_type_code,
																								l.garage_type_code);
	self.parking_no_of_cars := choose(assessPicker, max(l.parking_no_of_cars, r.parking_no_of_cars),
																									r.parking_no_of_cars,
																									l.parking_no_of_cars);
	self.style_code := choose(assessPicker, nonblank(l.style_code, r.style_code),
																					r.style_code,
																					l.style_code);
	self.assessed_value_year := choose(assessPicker, 	l.assessed_value_year,
																										r.assessed_value_year,
																										l.assessed_value_year);	
	self.assessed_amount := choose(assessPicker, 	max(l.assessed_amount,r.assessed_amount),
																								r.assessed_amount,
																								l.assessed_amount);	
	
	self.assessed_total_value := choose(assessPicker, 	max(l.assessed_total_value,r.assessed_total_value),
																								r.assessed_total_value,
																								l.assessed_total_value);	
																								
	SELF.property_count := 1;
	SELF.property_total := 1;
	SELF.property_owned_purchase_total := IF(self.purchase_amount < 1000, 0,
												self.purchase_amount);
	SELF.property_owned_purchase_count := (INTEGER)(self.purchase_amount >= 1000);
	SELF.property_owned_assessed_total := IF(self.assessed_amount < 1000, 0,
												self.assessed_amount);
	SELF.property_owned_assessed_count := (INTEGER)(self.assessed_amount >= 1000);
  
	self.ln_fares_id := R.ln_fares_id;
  self.fares := IF (L.ln_fares_id != R.ln_fares_id, L.fares + R.fares, L.fares);
	self := L;
end;

rolled := rollup(really_ready_to_roll, left.cntGroup = right.cntGroup, roll_props(LEFT,RIGHT));
rolled_props := PROJECT (rolled, transform (myrec, SELF.ln_fares_id := ''; SELF := Left));

return rolled_props;

end;