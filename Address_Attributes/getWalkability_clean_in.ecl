import address_attributes, addrfraud, Business_Header, LN_PropertyV2, property, Risk_Indicators, ut;

//layouts
layout_Business_geolink := record
	unsigned6		rcid											:= 0		;
  unsigned6		bdid											:= 0		; // Seisint Business Identifier
  string2  		source														; // Source file type
  qstring34		source_group							:= ''		; // Source group identifier for merging of records only within source and group
  string3  		pflag 										:= ''		; // Internal processing flags
  unsigned6		group1_id									:= 0		; // Group identifier (temporary) for matching groups of records pre-linked
  qstring34 	vendor_id									:= ''		; // Vendor key
  unsigned4 	dt_first_seen											; // Date record first seen at Seisint
  unsigned4 	dt_last_seen											; // Date record last (most recently seen) at Seisint
  unsigned4 	dt_vendor_first_reported					;
  unsigned4 	dt_vendor_last_reported						;
  qstring120 	company_name											;
  qstring10 	prim_range												;
  string2   	predir														;
  qstring28 	prim_name													;
  qstring4  	addr_suffix												;
  string2   	postdir														;
  qstring5  	unit_desig												;
  qstring8  	sec_range													;
  qstring25 	city															;
  string2   	state															;
  unsigned3 	zip																;
  unsigned2 	zip4															;
  string3   	county														;
  string4   	msa																;
  qstring10 	geo_lat														;
  qstring11 	geo_long													;
  unsigned6 	phone															;
  unsigned2 	phone_score								:= 0		; // Score captioned listings for display ranking
  unsigned4 	fein 											:= 0		; // Federal Tax ID
  boolean   	current														; // Current/Historical indicator
  boolean	  	dppa 											:= false; // DPPA restricted record (Vehicles and Watercraft)
	string7			geo_blk;
	string12		geolink;
	string1			geo_match;
end;

layout_businesses := record
	integer8	seq;
	string12	target_geolink;
	real4	distance_to_target;
	integer4 sic_code;
	layout_Business_geolink;
end;
layout_geolinks := record
	integer8	seq;
	string12	geolink;
	string12	geolink2;
	real4	distance;
end;

//
export getWalkability_clean_in(DATASET(address_attributes.Layouts.in_clean) indata) := FUNCTION
		
//walkability constant
		walkable_distance := .5;
		nearby_geolinks 	:= 10;	
			
//get top 5 geolinks
		layout_geolinks findGeolinks(indata l, addrfraud.key_geolinkdistance_geolink r) := transform
			self.seq := l.seq;
			self.geolink := l.geolink;
			self.geolink2 := r.geolink2;
			self.distance := r.dist_100th;
		end;

		target_geolinks := join(indata, addrfraud.key_geolinkdistance_geolink,
			keyed(left.geolink = right.geolink1),
			findGeolinks(left, right), keep(nearby_geolinks));

//get businesses by surrounding geolinks
		layout_Businesses findBusinesses(target_geolinks l, Address_Attributes.key_businesses_geolink r) := transform
			self.seq := l.seq;
			self.target_geolink := l.geolink;
			self := r;
			self := [];
		end;

		target_area_businesses := join(target_geolinks, Address_Attributes.key_businesses_geolink,
			keyed(left.geolink2 = right.geolink),
			findBusinesses(left, right), keep(3000));

//get businesses in target geolink
		target_geolink := dedup(sort(target_geolinks, geolink, seq), geolink, seq);
		layout_Businesses findLocalBusinesses(target_geolink l, Address_Attributes.key_businesses_geolink r) := transform
			self.seq := l.seq;
			self.target_geolink := l.geolink;
			self := r;
			self := [];
		end;

		target_local_businesses := join(target_geolink, Address_Attributes.key_businesses_geolink,
			keyed(left.geolink = right.geolink),
			findLocalBusinesses(left, right), keep(3000));

		all_businesses := target_area_businesses + target_local_businesses;
		all_business_sort := dedup(sort(all_businesses, bdid, -dt_last_seen), bdid);

//calculate distance of businesses and keep all within walkable distance constant above
		layout_Businesses calcDistance(indata l, all_business_sort r) := transform
			self.seq := l.seq;
			self.distance_to_target := AddrFraud.Functions.GeoDist((real)l.geo_lat, (real)l.geo_long, (real)r.geo_lat, (real)r.geo_long);
			self := r;
			self := [];
		end;

		target_to_business := join(indata, all_business_sort,
			left.seq = right.seq,
			calcDistance(left, right), left outer);
		
		walkable_businesses := target_to_business(distance_to_target <= walkable_distance);

//get SICs
		layout_Businesses getSIC(walkable_businesses l, Business_Header.Key_SIC_Code r) := transform
				self.seq := l.seq;
				self.sic_code := (integer)r.sic_code[1..4];
				self := l;
		end;
		
		walkables_with_SIC := join(walkable_businesses, Business_Header.Key_SIC_Code,
				keyed(left.bdid = right.bdid),
				getSIC(left, right),Left Outer, keep(5));
		
		walkables_with_SIC_dedup := dedup(sort(walkables_with_SIC(sic_code in address_attributes.functions.walkablityCodes), seq, bdid, sic_code), seq, bdid, sic_code);
	
//count verticals and aggregate score
Address_Attributes.Layouts.rWalkability_Out addBusinessVerticals(walkables_with_SIC_dedup l) := TRANSFORM
		self.seq := l.seq;
		self.public_trans := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'PT' ,1,0);
		self.grocery_food := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'GF' ,1,0);
		self.restaurant_food := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'RF' ,1,0);
		self.personal_care := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'PC' ,1,0);
		self.drugs_pharmacy := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'DR' ,1,0);
		self.medical_care := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'MD' ,1,0);
		self.retail_goods := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'RG' ,1,0);
		self.church := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'CH' ,1,0);
		self.entertainment := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'EN' ,1,0);
		self.schools := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'SC' ,1,0);
		self.banking := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'BK' ,1,0);
		self.daycare := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'DC' ,1,0);
		self.repair_shops := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'RE' ,1,0);
		self.public_service := if(Address_Attributes.functions.getWalkabilitySIC(l.sic_code) = 'PS' ,1,0);
		self.walkability_score := 0;
end;

Business_Count_init := project(walkables_with_SIC_dedup, addBusinessVerticals(Left));

Address_Attributes.Layouts.rWalkability_Out rollBusinesses(Address_Attributes.Layouts.rWalkability_Out l, Address_Attributes.Layouts.rWalkability_Out r) := TRANSFORM
		self.seq := l.seq;		
		self.public_trans := l.public_trans + r.public_trans;
		self.grocery_food := l.grocery_food + r.grocery_food;
		self.restaurant_food := l.restaurant_food + r.restaurant_food;
		self.personal_care := l.personal_care + r.personal_care;	
		self.drugs_pharmacy := l.drugs_pharmacy + r.drugs_pharmacy;
		self.medical_care := l.medical_care + r.medical_care;
		self.retail_goods := l.retail_goods + r.retail_goods;
		self.church := l.church + r.church;
		self.entertainment := l.entertainment + r.entertainment;
		self.schools := l.schools + r.schools;
		self.banking := l.banking + r.banking;
		self.daycare := l.daycare + r.daycare;
		self.repair_shops := l.repair_shops + r.repair_shops;
		self.public_service := l.public_service + r.public_service;
		self.walkability_score := l.walkability_score;
		self := l;
END;
		
Business_counts := rollup(sort(Business_Count_init, seq), rollBusinesses(left,right), seq);		

Address_Attributes.Layouts.rWalkability_Out calcTargetWalkability(Business_counts l) := transform
		
		//set max values
		public_trans_cnt 		:= if(l.public_trans 		> 0, 1, 0);
		grocery_food_cnt 		:= if(l.grocery_food 		> 3, 3, l.grocery_food);
		restaurant_food_cnt := if(l.restaurant_food > 3, 3, l.restaurant_food);
		personal_care_cnt 	:= if(l.personal_care 	> 2, 2, l.personal_care);
		drugs_pharmacy_cnt 	:= if(l.drugs_pharmacy 	> 2, 2, l.drugs_pharmacy);
		medical_care_cnt 		:= if(l.medical_care 		> 2, 2, l.medical_care);
		retail_goods_cnt 		:= if(l.retail_goods 		> 4, 4, l.retail_goods);
		church_cnt 					:= if(l.church 					> 2, 2, l.church);
		entertainment_cnt 	:= if(l.entertainment 	> 5, 5, l.entertainment);
		schools_cnt 				:= if(l.schools 				> 2, 2, l.schools);
		banking_cnt 				:= if(l.banking 				> 2, 2, l.banking);
		daycare_cnt 				:= if(l.daycare 				> 2, 2, l.daycare);
		repair_shops_cnt 		:= if(l.repair_shops 		> 2, 2, l.repair_shops);
		public_service_cnt 	:= if(l.public_service 	> 2, 2, l.public_service);
		
		w_score := public_trans_cnt * 8 + 
							  if(grocery_food_cnt 		>= 1, 8 + (grocery_food_cnt - 1) 		* 2, 0)  +
							  if(restaurant_food_cnt 	>= 1, 8 + (restaurant_food_cnt - 1) * 2, 0)  +
							  if(personal_care_cnt 		>= 1, 5 + (personal_care_cnt - 1) 	* 2, 0)  +
							  if(drugs_pharmacy_cnt 	>= 1, 4 + (drugs_pharmacy_cnt - 1) 	* 1, 0)  +
							  if(medical_care_cnt 		>= 1, 4 + (medical_care_cnt - 1) 		* 1, 0)  +
							  if(retail_goods_cnt 		>= 1, 4 + (retail_goods_cnt - 1) 		* 1, 0)  +
							  if(church_cnt 					>= 1, 5 + (church_cnt - 1) 					*.5, 0)  +
							  if(entertainment_cnt 		>= 1, 5 + (entertainment_cnt - 1) 	* 2, 0)  +
							  if(schools_cnt 					>= 1, 2 + (schools_cnt - 1) 				*.5, 0)  +
							  if(banking_cnt 					>= 1, 2 + (banking_cnt - 1) 				*.5, 0)  +
							  if(daycare_cnt 					>= 1, 2 + (daycare_cnt - 1) 				*.5, 0)  +
							  if(repair_shops_cnt 		>= 1, 1 + (repair_shops_cnt - 1) 		*.5, 0)  +
							  if(public_service_cnt 	>= 1, 2 + (public_service_cnt - 1) 	*.5, 0);
	
		self.seq := l.seq;
		self.walkability_score := w_score;
		self := l;
end;

target_walkability_score := project(Business_counts, calcTargetWalkability(left));


Return target_walkability_score;

END;