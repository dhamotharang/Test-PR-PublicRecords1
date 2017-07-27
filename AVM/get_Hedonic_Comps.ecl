import ut;

// does the hedonic build for 1 section of the country at a time.  6 sections, divided by the first byte of the fips_code
export get_Hedonic_Comps(string1 fc) := function

layout_comp_calcs := record
	unsigned subject_seq;
	string5 subject_zip;
	string5 subject_fips_code;
	string4 subject_land_use_code;
	
	unsigned seq;
	string12 ln_fares_id;
	string5 zip;
	string10 lat;
	string11 long;
	string11 sales_price;
 
	integer no_of_comps;
	real comp_distance;
	integer sale_date_diff;
	integer assessed_value_diff;
	integer bed_diff;
	integer bath_diff;
	integer age_diff;
	integer building_area_diff;
	integer stories_diff;
	integer rooms_diff;
	integer assessed_year_diff;
end;

hedonic_base := avm.File_AVM_Hedonic_Base(fips_code[1]=fc);

// made the comp candidates their own attribute so that they could be keyed off of fid for the query
comparable_candidates := avm.File_Hedonic_Comps(fc);

layout_geobox_base := record
	real n_Lat;
	real s_Lat;
	real w_Lon;
	real e_Lon;
	avm.File_AVM_Hedonic_Base;
end;

// radius in miles
box_radius := 5.0000;
high_population_radius := 1.0000;

// Computes the LatLon coordinates of a box bounding a circle of a
// certain radius in miles around a given LatLon coordinate	
layout_geobox_base add_box(hedonic_base le) := transform
	lat := (real)le.lat;
	lon := (real)le.long;
	radius := box_radius;
	miPerLat := 69.055;	// miles per degree of latitude (24859.82mi/360)
	miPerLong := miPerLat * cos(lon); 
	deltaLat := radius / miPerLat;
	deltaLon := radius / miPerLong;
	self.n_lat := lat + deltaLat;
	self.s_Lat := lat - deltaLat;
	self.e_Lon := lon + deltaLon;
	self.w_Lon := lon - deltaLon;
	self := le;
end;

subject_props := project(hedonic_base, add_box(left));
// output(subject_props);

comp_counts_slim := record
	unsigned seq;
	integer no_of_comps;
end;
	
	
comp_counts_slim identify_comps(subject_props le, comparable_candidates rt) := transform
	dist := ut.ll_dist((real)le.lat, (real)le.long, (real)rt.lat, (real)rt.long);
	self.no_of_comps := if(dist < high_population_radius, 1, skip);	
	self := le;
end;

temp_comps := join(subject_props, comparable_candidates, 
			left.fips_code = right.fips_code and
			left.land_use_code = right.land_use_code and
			
			( ((real)right.lat between left.s_lat and left.n_lat) and
			  ((real)right.long between left.w_lon and left.e_lon) ) and
			  
			( left.seq != right.seq ),  // exclude the subject property from the list of comp candidates
			identify_comps(left,right), many lookup);			
			
// output(temp_comps);

tc_distr := distribute(temp_comps, hash(seq));
subject_grouping := group(sort(tc_distr, seq, local), seq, local);

// table the counts,
// join the table to the original subjects

// comp_counts_table := record
	// seq := temp_comps.seq;
	// no_of_comps := count(group);
// end;

// subjects_w_comp_counts_temp := table(temp_comps, comp_counts_table, seq, few);

subjects_w_comp_counts_temp := rollup(subject_grouping, true, 
								transform(comp_counts_slim, 
										self.no_of_comps := left.no_of_comps + right.no_of_comps, 
										self := left));

comp_counts := record
	subject_props;
	integer no_of_comps;
end;

subject_details := distribute(subject_props, hash(seq));
subject_comp_counts := distribute(subjects_w_comp_counts_temp, hash(seq));

subjects_w_comp_counts1 := join(subject_details, subject_comp_counts, left.seq=right.seq,
								transform(comp_counts, self.no_of_comps := right.no_of_comps, self := left),
								left outer, local);
subjects_w_comp_counts := subjects_w_comp_counts1(no_of_comps!=0);
// output(subjects_w_comp_counts(no_of_comps!=0), named('with_comp_counts'));

layout_comp_calcs add_distances(subjects_w_comp_counts le, comparable_candidates rt) := transform

	//mile_selection(le.fips_code, le.land_use_code, le.n_lat, le.s_lat, le.w_lon, le.e_lon, comp_count)	
	self.no_of_comps := le.no_of_comps;
	
	// if the comp count is less than 25 for a single property, expand the radius
	dist_limit := if(le.no_of_comps < 25, box_radius, high_population_radius);
	
	dist := ut.ll_dist((real)le.lat, (real)le.long, (real)rt.lat, (real)rt.long);
	self.comp_distance := if(dist < dist_limit, dist, skip);
	
	self.sale_date_diff := abs((integer)rt.recording_date - (integer)le.recording_date);
	self.assessed_value_diff := map((integer)le.assessed_total_value!=0 and (integer)rt.assessed_total_value!=0 =>
									abs((integer)le.assessed_total_value - (integer)rt.assessed_total_value),
								
									(integer)le.market_total_value!=0 and (integer)rt.market_total_value!=0 =>
									abs((integer)le.market_total_value - (integer)rt.market_total_value),
									
									-1) ;
									
	self.bed_diff := if((integer)le.no_of_bedrooms=0 or (integer)rt.no_of_bedrooms=0, -1,
						 abs((integer)le.no_of_bedrooms - (integer)rt.no_of_bedrooms)) ;
	self.bath_diff := if((integer)le.no_of_baths=0 or (integer)rt.no_of_baths=0, -1,
						 abs((integer)le.no_of_baths - (integer)rt.no_of_baths)) ;
	self.age_diff := if((integer)le.year_built=0 or (integer)rt.year_built=0, -1,
						 abs((integer)le.year_built - (integer)rt.year_built)) ;
	self.building_area_diff := if((integer)le.building_area=0 or (integer)rt.building_area=0, -1,
									abs((integer)le.building_area - (integer)rt.building_area)) ;  
	self.stories_diff := if((integer)le.no_of_stories=0 or (integer)rt.no_of_stories=0, -1,
						 abs((integer)le.no_of_stories - (integer)rt.no_of_stories)) ;
	self.rooms_diff := if((integer)le.no_of_rooms=0 or (integer)rt.no_of_rooms=0, -1,
						 abs((integer)le.no_of_rooms - (integer)rt.no_of_rooms)) ;
	self.assessed_year_diff := if((integer)le.assessed_value_year=0 or (integer)rt.assessed_value_year=0, -1,
						 abs((integer)le.assessed_value_year - (integer)rt.assessed_value_year)) ;
		
	self.subject_seq := le.seq ;
	self.subject_zip := le.zip ;
	self.subject_fips_code := le.fips_code ;
	self.subject_land_use_code := le.land_use_code ;
		
	self := rt;
	self := [];
end;

// use many lookup if the # of property records stays somewhere below 4 million
with_dist := join(subjects_w_comp_counts , comparable_candidates, 
			left.fips_code = right.fips_code and
			left.land_use_code = right.land_use_code and
		
			( ((real)right.lat between left.s_lat and left.n_lat) and
			  ((real)right.long between left.w_lon and left.e_lon) ) and
			  
			( left.seq != right.seq ),  // exclude the subject property from the list of comp candidates
			add_distances(left,right), many lookup);	

// output(with_dist, named('with_dist'));

layout_hedonic_vars := record
	unsigned integer8 subject_seq;
	string5 subject_zip;
	string5 subject_fips_code;
	string4 subject_land_use_code;
	integer no_of_comps;
	// start of comp details
	unsigned integer8 seq;
	string12 ln_fares_id;
	integer sales_price;
	real comp_distance;
	integer sale_date_diff;
	integer assessed_value_diff;
	integer bed_diff;
	integer bath_diff;
	integer age_diff;
	integer building_area_diff;
	integer stories_diff;
	integer rooms_diff;
	integer assessed_year_diff;
	boolean same_zip;
	real standard_deviation_asrtotalvalue;
	real standard_deviation_bed;
	real standard_deviation_bath;
	real standard_deviation_age;
	real standard_deviation_buildingarea;
	real standard_deviation_stories;
	real standard_deviation_room;
	real standard_deviation_assessedyear;
	boolean zip_level_weights;
	real weight_asrtotalvalue;
	real weight_bed;
	real weight_bath;
	real weight_age;
	real weight_buildingarea;
	real weight_stories;
	real weight_room;
	real weight_time;
	real weight_physicaldistance;
	real weight_assessedyear;
	real hedonic_distance;
end;		
			
layout_hedonic_vars add_weights(with_dist le, avm.File_Hedonic_Weights_Table rt) := transform
	self.same_zip := le.subject_zip=le.zip;  // this one is used at the end for final selection of 7 comps
	self.zip_level_weights := rt.zipcode!='';  // this one is used in deduping the weights table join
	self.standard_deviation_asrtotalvalue := rt.standard_deviation_asrtotalvalue;
	self.standard_deviation_bed := rt.standard_deviation_bed;
	self.standard_deviation_bath := rt.standard_deviation_bath;
	self.standard_deviation_age := rt.standard_deviation_age;
	self.standard_deviation_buildingarea := rt.standard_deviation_buildingarea;
	self.standard_deviation_stories := rt.standard_deviation_stories;
	self.standard_deviation_room := rt.standard_deviation_room;
	self.standard_deviation_assessedyear := rt.standard_deviation_assessedyear;
	self.weight_asrtotalvalue := rt.weight_asrtotalvalue;
	self.weight_bed := rt.weight_bed;
	self.weight_bath := rt.weight_bath;
	self.weight_age := rt.weight_age;
	self.weight_buildingarea := rt.weight_buildingarea;
	self.weight_stories := rt.weight_stories;
	self.weight_room := rt.weight_room;
	self.weight_time := rt.weight_time;
	self.weight_physicaldistance := rt.weight_physicaldistance;
	self.weight_assessedyear := rt.weight_assessedyear;
		
	assessed_val := if(le.assessed_value_diff = -1, rt.standard_deviation_asrtotalvalue, le.assessed_value_diff);
	bed_val := if(le.bed_diff = -1, rt.standard_deviation_bed, le.bed_diff); 
	bath_val := if(le.bath_diff = -1, rt.standard_deviation_bath, le.bath_diff);
	age_val := if(le.age_diff = -1, rt.standard_deviation_age, le.age_diff);
	building_val := if(le.building_area_diff = -1, rt.standard_deviation_buildingarea, le.building_area_diff);
	stories_val := if(le.stories_diff = -1, rt.standard_deviation_stories, le.stories_diff);
	rooms_val := if(le.rooms_diff = -1, rt.standard_deviation_room, le.rooms_diff);
	assessed_year_val := if(le.assessed_year_diff = -1, rt.standard_deviation_assessedyear, le.assessed_year_diff);
	
	self.hedonic_distance := (assessed_val * rt.weight_asrtotalvalue) +
							 (bed_val * rt.weight_bed) +
							 (bath_val * rt.weight_bath) +
							 (age_val * rt.weight_age) +
							 (building_val * rt.weight_buildingarea) +
							 (rooms_val * rt.weight_room) +
							 (le.comp_distance * rt.weight_physicaldistance);
							 
							 
							 // try it without the weighting on time and physical distance 
							 // since those aren't truly property characteristics, we might 
							 // get more accurate this way
							 							 
							 //	(assessed_year_val * rt.weight_assessedyear) +						 
							 // (le.sale_date_diff * rt.weight_time) +
							 
							 
							 // try it also without number of stories since the data in that field isn't always numeric,
							 // could be throwing off the calculation and causing different comps to be selected
							  // (stories_val * rt.weight_stories) +
							 
	
	self.sales_price := (integer)le.sales_price;
	self := le;
	self := [];
end;


with_all_weights := join(with_dist, avm.File_Hedonic_Weights_Table,
					 left.subject_fips_code=right.fips_code and 
						left.subject_land_use_code=right.land_use and
						ut.NNEQ(left.subject_zip, right.zipcode),
						add_weights(left,right), many lookup);


with_all_weights_d := distribute(with_all_weights, hash(subject_seq, seq));
weights_deduped := dedup(sort(with_all_weights_d, subject_seq, seq, -zip_level_weights, local), subject_seq, seq, local);

weights_deduped_dist := distribute(weights_deduped, hash(subject_seq));

best_hedonics := sort(weights_deduped_dist, subject_seq, -same_zip, hedonic_distance, local);

// output(best_hedonics, named('best_hedonics'));

hv_layout_w_comps := record
	hedonic_base;
	layout_hedonic_vars comps;
	integer hedonic_valuation;
	string12 comp1;
	string12 comp2;
	string12 comp3;
	string12 comp4;
	string12 comp5;
	integer comp_sequence;
end;


subj_distr:= distribute(subject_props, hash(seq));
best_hedonics_distr := distribute(best_hedonics, hash(subject_seq));

hv_layout_w_comps add_comps(subject_props le, best_hedonics rt) := transform
	self.comps := rt;
	self := le;
	self := [];
end;

// keep the best 7 comps to select the median sale price from
with_comps := join(subj_distr, best_hedonics_distr, left.seq=right.subject_seq,
					add_comps(left, right), keep(7), local);
					

// sort all property comps selected by their sales_prices, and select seq #4 as the median
with_comps_distr := distribute(with_comps, hash(seq));
props := group(sort(with_comps_distr, seq, comps.sales_price, local), seq, local);

hv_layout_w_comps add_comp_seq(props le, props rt, integer C) := transform
	// added middle comp logic just in case we get less than 7 comps, wouldn't want to just take seq #4 as our default	
	middle_comp := if(le.comps.no_of_comps < 7, round(le.comps.no_of_comps/2), 4);
	self.hedonic_valuation := if(c=middle_comp, (integer)rt.comps.sales_price, le.hedonic_valuation);
	// self.hedonic_valuation := if(c=4, (integer)rt.comps.sales_price, le.hedonic_valuation);
	self.comp_sequence := c;
	self.comp1 := if(c=1, rt.comps.ln_fares_id, rt.comp1);
	self.comp2 := if(c=2, rt.comps.ln_fares_id, rt.comp2);
	self.comp3 := if(c=3, rt.comps.ln_fares_id, rt.comp3);
	self.comp4 := if(c=4, rt.comps.ln_fares_id, rt.comp4);
	self.comp5 := if(c=5, rt.comps.ln_fares_id, rt.comp5);
	self := rt;
end;

with_valuation := iterate(props,add_comp_seq(left,right,counter));

hv_layout_slim := record
	hedonic_base;
	integer hedonic_valuation;
	string12 comp1;
	string12 comp2;
	string12 comp3;
	string12 comp4;
	string12 comp5;
	integer no_of_comps;  // overall number of hedonic comp_candidates at 1 mile
    real sum_hedonic_distance; // sum of the comps' hedonic distance
	real sum_physical_distance; // sum of the comps' physical distance to the subject property
end;

slim_recs := project(with_valuation(comps.no_of_comps >= 7), transform(hv_layout_slim, 	
																		self.no_of_comps := left.comps.no_of_comps,
																		self.sum_hedonic_distance := left.comps.hedonic_distance,
																		self.sum_physical_distance := left.comps.comp_distance,
																		self := left));

hv_layout_slim roll_comps(hv_layout_slim le, hv_layout_slim rt) := transform
	self.hedonic_valuation := if(le.hedonic_valuation=0,rt.hedonic_valuation,le.hedonic_valuation);
	self.sum_hedonic_distance := le.sum_hedonic_distance + rt.sum_hedonic_distance;
	self.sum_physical_distance := le.sum_physical_distance + rt.sum_physical_distance;
	self.comp1 := if(le.comp1<>'', le.comp1, rt.comp1);
	self.comp2 := if(le.comp2<>'', le.comp2, rt.comp2);
	self.comp3 := if(le.comp3<>'', le.comp3, rt.comp3);
	self.comp4 := if(le.comp4<>'', le.comp4, rt.comp4);
	self.comp5 := if(le.comp5<>'', le.comp5, rt.comp5);
	self := rt;
end;

rolled_comps := rollup( slim_recs , true, roll_comps(left,right));
// output(rolled_comps, named('rolled_comps'));


// now do almost the same thing to select the nearby properties
// sort all the comps by comp_distance first to get the 5 closest properties in the join

with_dist_distr := distribute(with_dist, hash(subject_seq));
closest_nearby := sort(with_dist_distr, subject_seq, comp_distance, local);

rolled_comps_distr:= distribute(rolled_comps, hash(seq));
closest_nearby_distr := distribute(closest_nearby, hash(subject_seq));

hv_layout_final := record
	hv_layout_slim;
	string12 nearby_fares_id;
	string12 nearby1;
	string12 nearby2;
	string12 nearby3;
	string12 nearby4;
	string12 nearby5;
end;
			
hv_layout_final add_nearby_prop(rolled_comps_distr le, closest_nearby_distr rt) := transform
	self.nearby_fares_id := rt.ln_fares_id;
	self := le;
	self := [];
end;

// keep the best 5 closest properties as the nearby properties
with_nearby := join(rolled_comps_distr, closest_nearby_distr, left.seq=right.subject_seq,
					add_nearby_prop(left, right), keep(5), local);


// with_nearby_distr := distribute(with_nearby, hash(seq));
with_nearby_grouped := group(sort(with_nearby, seq, local), seq, local);
	
hv_layout_final pop_nearby_ids(hv_layout_final le, hv_layout_final rt, integer c) := transform	
	self.nearby1 := if(c=1, rt.nearby_fares_id, rt.nearby1);
	self.nearby2 := if(c=2, rt.nearby_fares_id, rt.nearby2);
	self.nearby3 := if(c=3, rt.nearby_fares_id, rt.nearby3);
	self.nearby4 := if(c=4, rt.nearby_fares_id, rt.nearby4);
	self.nearby5 := if(c=5, rt.nearby_fares_id, rt.nearby5);
	self := rt;
end;

with_nearby2 := iterate(with_nearby_grouped,pop_nearby_ids(left,right,counter));

hv_layout_final roll_nearby(hv_layout_final le, hv_layout_final rt) := transform
	self.nearby1 := if(le.nearby1<>'', le.nearby1, rt.nearby1);
	self.nearby2 := if(le.nearby2<>'', le.nearby2, rt.nearby2);
	self.nearby3 := if(le.nearby3<>'', le.nearby3, rt.nearby3);
	self.nearby4 := if(le.nearby4<>'', le.nearby4, rt.nearby4);
	self.nearby5 := if(le.nearby5<>'', le.nearby5, rt.nearby5);
	self := rt;
end;

rolled_nearby := rollup( with_nearby2 , true, roll_nearby(left,right));

return rolled_nearby;

end;



