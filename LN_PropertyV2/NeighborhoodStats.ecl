import address, risk_indicators, ut, std;

//Hedonic Files
isFCRA := false;
Prop_Address_Prep_V4 := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);
// Prop_Address_Prep_V2 := ln_propertyv2.Key_Prop_Address_V4;  // for building in dataland

layout_Hedonics := record
	string12 geolink;
	unsigned4		ave_occupant_owned;
	unsigned4		cnt_occupant_owned;
	unsigned4 	ave_building_age;
	unsigned4 	cnt_building_age;
	unsigned4 	ave_purchase_amount;
	unsigned4 	cnt_purchase_amount;
	unsigned4 	ave_purchase_age;
	unsigned4 	cnt_purchase_age;
	unsigned4 	ave_mortgage_amount;
	unsigned4 	cnt_mortgage_amount;
	unsigned4 	ave_mortgage_age;
	unsigned4 	cnt_mortgage_age;
	unsigned4 	ave_assessed_amount;
	unsigned4 	cnt_assessed_amount;
	unsigned8 	ave_building_area;
	unsigned8 	cnt_building_area;
	unsigned8		ave_price_per_sf;
	unsigned8		cnt_price_per_sf;
	unsigned8 	ave_no_of_buildings_count;
	unsigned8 	cnt_no_of_buildings_count;
	unsigned8 	ave_no_of_stories_count;
	unsigned8 	cnt_no_of_stories_count;
	unsigned8 	ave_no_of_rooms_count;
	unsigned8 	cnt_no_of_rooms_count;
	unsigned8 	ave_no_of_bedrooms_count;
	unsigned8 	cnt_no_of_bedrooms_count;
	unsigned8 	ave_no_of_baths_count;
	unsigned8 	cnt_no_of_baths_count;
	unsigned8 	ave_no_of_partial_baths_count;
	unsigned8 	cnt_no_of_partial_baths_count;
	unsigned4		ave_parking_no_of_cars;
	unsigned4		cnt_parking_no_of_cars;
	unsigned4		total_property_count;
end;


//////////////////////////////////////////////////////////////


layout_Hedonics addNeighborhoodHedonics(Prop_Address_Prep_V4 l) := TRANSFORM
		// address := l.prim_range + l.predir + l.prim_name + l.suffix + l.postdir + l.sec_range;
		address := address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,'',l.sec_range);
		clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(address, l.p_city_name, l.st, l.zip);
		self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		self.ave_occupant_owned := if(l.occupant_owned,1,0);
		self.cnt_occupant_owned := if(l.occupant_owned,1,0);
	 	self.ave_building_age := if(l.built_date !=0,(integer)((STRING)Std.Date.Today())[1..4] - (integer)l.built_date, 0);
		self.cnt_building_age := if(l.built_date !=0,1,0);
	 	self.ave_purchase_amount := l.purchase_amount;
		self.cnt_purchase_amount := if(l.purchase_amount !=0,1,0);
		self.ave_purchase_age := if(l.purchase_date !=0,(integer)((STRING)Std.Date.Today())[1..4] - (integer)l.purchase_date, 0);
		self.cnt_purchase_age := if(l.purchase_date !=0,1,0);
		self.ave_mortgage_amount := l.mortgage_amount;
		self.cnt_mortgage_amount := if(l.mortgage_amount !=0,1,0);
		self.ave_mortgage_age := if(l.mortgage_date !=0,(integer)((STRING)Std.Date.Today())[1..4] - (integer)l.mortgage_date, 0);
		self.cnt_mortgage_age := if(l.mortgage_date !=0,1,0);
	 	self.ave_assessed_amount := l.assessed_amount;
		self.cnt_assessed_amount := if(l.assessed_amount !=0,1,0);
	 	self.ave_building_area := l.building_area;
		self.cnt_building_area := if(l.building_area !=0,1,0);
		price_per_square := if(l.purchase_amount !=0 and l.building_area !=0, l.purchase_amount DIV l.building_area, 0);
		self.ave_price_per_sf := price_per_square;
		self.cnt_price_per_sf := if(price_per_square !=0,1,0);
	 	self.ave_no_of_buildings_count := l.no_of_buildings;
		self.cnt_no_of_buildings_count := if(l.no_of_buildings !=0,1,0);
	 	self.ave_no_of_stories_count := l.no_of_stories;
		self.cnt_no_of_stories_count := if(l.no_of_stories !=0,1,0);
	 	self.ave_no_of_rooms_count := l.no_of_rooms;
		self.cnt_no_of_rooms_count := if(l.no_of_rooms !=0,1,0);
	 	self.ave_no_of_bedrooms_count := l.no_of_bedrooms;
		self.cnt_no_of_bedrooms_count := if(l.no_of_bedrooms !=0,1,0);
	 	self.ave_no_of_baths_count := l.no_of_baths;
		self.cnt_no_of_baths_count := if(l.no_of_baths !=0,1,0);
	 	self.ave_no_of_partial_baths_count := l.no_of_partial_baths;
		self.cnt_no_of_partial_baths_count := if(l.no_of_partial_baths !=0,1,0);
		self.ave_parking_no_of_cars := l.parking_no_of_cars;
		self.cnt_parking_no_of_cars := if(l.parking_no_of_cars !=0,1,0);
		self.total_property_count := if(l.prim_name !='', 1,0);
end;

Neighborhood_Hedonics_init := project(Prop_Address_Prep_V4, addNeighborhoodHedonics(Left));
Neighborhood_Hedonics_dist := distribute(Neighborhood_Hedonics_init, hash32(geolink));
layout_Hedonics rollHedonics( layout_Hedonics l, layout_Hedonics r ) := TRANSFORM
		self.ave_occupant_owned := l.ave_occupant_owned + r.ave_occupant_owned;
		self.cnt_occupant_owned := l.cnt_occupant_owned + r.cnt_occupant_owned;
	 	self.ave_building_age := l.ave_building_age + r.ave_building_age;
		self.cnt_building_age := l.cnt_building_age + r.cnt_building_age;
	 	self.ave_purchase_amount := l.ave_purchase_amount + r.ave_purchase_amount;
		self.cnt_purchase_amount := l.cnt_purchase_amount + r.cnt_purchase_amount;
		self.ave_purchase_age := l.ave_purchase_age + r.ave_purchase_age;
		self.cnt_purchase_age := l.cnt_purchase_age + r.cnt_purchase_age;
	 	self.ave_mortgage_amount := l.ave_mortgage_amount + r.ave_mortgage_amount;
		self.cnt_mortgage_amount := l.cnt_mortgage_amount + r.cnt_mortgage_amount;
		self.ave_mortgage_age := l.ave_mortgage_age + r.ave_mortgage_age;
		self.cnt_mortgage_age := l.cnt_mortgage_age + r.cnt_mortgage_age;
	 	self.ave_assessed_amount := l.ave_assessed_amount + r.ave_assessed_amount;		
		self.cnt_assessed_amount := l.cnt_assessed_amount + r.cnt_assessed_amount;
	 	self.ave_building_area := l.ave_building_area + r.ave_building_area;
		self.cnt_building_area := l.cnt_building_area + r.cnt_building_area;
		self.ave_price_per_sf := l.ave_price_per_sf + r.ave_price_per_sf;
		self.cnt_price_per_sf := l.cnt_price_per_sf + r.cnt_price_per_sf;
	 	self.ave_no_of_buildings_count := l.ave_no_of_buildings_count + r.ave_no_of_buildings_count;
		self.cnt_no_of_buildings_count := l.cnt_no_of_buildings_count + r.cnt_no_of_buildings_count;
	 	self.ave_no_of_stories_count := l.ave_no_of_stories_count + r.ave_no_of_stories_count;
		self.cnt_no_of_stories_count := l.cnt_no_of_stories_count + r.cnt_no_of_stories_count;
	 	self.ave_no_of_rooms_count := l.ave_no_of_rooms_count + r.ave_no_of_rooms_count;
		self.cnt_no_of_rooms_count := l.cnt_no_of_rooms_count + r.cnt_no_of_rooms_count;
	 	self.ave_no_of_bedrooms_count := l.ave_no_of_bedrooms_count + r.ave_no_of_bedrooms_count;
		self.cnt_no_of_bedrooms_count := l.cnt_no_of_bedrooms_count + r.cnt_no_of_bedrooms_count;
	 	self.ave_no_of_baths_count :=  l.ave_no_of_baths_count + r.ave_no_of_baths_count;
		self.cnt_no_of_baths_count := l.cnt_no_of_baths_count + r.cnt_no_of_baths_count;
	 	self.ave_no_of_partial_baths_count := l.ave_no_of_partial_baths_count + r.ave_no_of_partial_baths_count;
		self.cnt_no_of_partial_baths_count := l.cnt_no_of_partial_baths_count + r.cnt_no_of_partial_baths_count;
		self.ave_parking_no_of_cars := l.ave_parking_no_of_cars + r.ave_parking_no_of_cars;
		self.cnt_parking_no_of_cars := l.cnt_parking_no_of_cars + r.cnt_parking_no_of_cars;
		self.total_property_count := l.total_property_count + r.total_property_count;
		self := l;
END;
		
Neighborhood_Pre_Hedonics := rollup(sort(Neighborhood_Hedonics_dist, geolink, local), rollHedonics(left,right), geolink, local);		
layout_Hedonics calcNeighborhoodHedonics(Neighborhood_Pre_Hedonics l) := transform
		self.geolink := l.geolink;
		self.ave_occupant_owned := l.ave_occupant_owned / l.total_property_count;
		self.cnt_occupant_owned := l.cnt_occupant_owned;
	 	self.ave_building_age := l.ave_building_age / l.cnt_building_age;
	 	self.cnt_building_age := l.cnt_building_age;
	 	self.ave_purchase_amount := l.ave_purchase_amount / l.cnt_purchase_amount;
	 	self.cnt_purchase_amount := l.cnt_purchase_amount;
		self.ave_purchase_age := l.ave_purchase_age / l.cnt_purchase_age;
		self.cnt_purchase_age := l.cnt_purchase_age;
	 	self.ave_mortgage_amount := l.ave_mortgage_amount / l.cnt_mortgage_amount;
	 	self.cnt_mortgage_amount := l.cnt_mortgage_amount;
		self.ave_mortgage_age := l.ave_mortgage_age / l.cnt_mortgage_age;
		self.cnt_mortgage_age := l.cnt_mortgage_age;
	 	self.ave_assessed_amount := l.ave_assessed_amount / l.cnt_assessed_amount;
	 	self.cnt_assessed_amount := l.cnt_assessed_amount;
	 	self.ave_building_area := l.ave_building_area / l.cnt_building_area;
	 	self.cnt_building_area := l.cnt_building_area;
		self.ave_price_per_sf := l.ave_price_per_sf / l.cnt_price_per_sf;
		self.cnt_price_per_sf := l.cnt_price_per_sf;
	 	self.ave_no_of_buildings_count := l.ave_no_of_buildings_count / l.cnt_no_of_buildings_count;
	 	self.cnt_no_of_buildings_count := l.cnt_no_of_buildings_count;
	 	self.ave_no_of_stories_count := l.ave_no_of_stories_count / l.cnt_no_of_stories_count;
	 	self.cnt_no_of_stories_count := l.cnt_no_of_stories_count;
	 	self.ave_no_of_rooms_count := l.ave_no_of_rooms_count / l.cnt_no_of_rooms_count;
	 	self.cnt_no_of_rooms_count := l.cnt_no_of_rooms_count;
	 	self.ave_no_of_bedrooms_count := l.ave_no_of_bedrooms_count / l.cnt_no_of_bedrooms_count;
	 	self.cnt_no_of_bedrooms_count := l.cnt_no_of_bedrooms_count;
	 	self.ave_no_of_baths_count :=  l.ave_no_of_baths_count / l.cnt_no_of_baths_count;
	 	self.cnt_no_of_baths_count :=  l.cnt_no_of_baths_count;
	 	self.ave_no_of_partial_baths_count := l.ave_no_of_partial_baths_count / l.cnt_no_of_partial_baths_count;
	 	self.cnt_no_of_partial_baths_count := l.cnt_no_of_partial_baths_count;
		self.ave_parking_no_of_cars := l.ave_parking_no_of_cars / l.cnt_parking_no_of_cars;
		self.cnt_parking_no_of_cars := l.cnt_parking_no_of_cars;
		self.total_property_count := l.total_property_count;
end;

Neighborhood_Hedonics := project(Neighborhood_Pre_Hedonics, 
																calcNeighborhoodHedonics(left), local) : persist('temp::ln_propertyv2_neighborhood_stats');	

export NeighborhoodStats := Neighborhood_Hedonics;