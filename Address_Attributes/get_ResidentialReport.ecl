import address_attributes, avm_v2, easi, iesp, LN_PropertyV2, Risk_Indicators, ut;

export get_ResidentialReport(DATASET(Address_Attributes.Layouts.address_in) indata) := FUNCTION

//Constants
		boolean goodTransaction := if(indata[1].street_address <> '' and  indata[1].city <> '' and  indata[1].state <> '' and  indata[1].zip <> '', true, false);		
		nearby_geolinks := 10;
		walkabilityscore_low := 0;
		walkabilityscore_high := 100;
		
//Data Sources
		File_Property 		:= LN_PropertyV2.Key_Prop_Address_V4;
		File_Assessor 		:= LN_PropertyV2.Key_Assessor_FID();
		File_AVM 					:= AVM_V2.Key_AVM_Address;
		File_Census				:= Easi.Key_Easi_Census;
		
//Clean Addresses
		Address_Attributes.Layouts.in_clean AddressClean(indata l, integer c) := TRANSFORM
				self.seq := c;
				self.street_address_in := l.street_address;
				self.apt_in := l.apt;
				self.city_in := l.city;
				self.state_in := l.state;
				self.zip_in := l.zip;
				self.zip4_in := l.zip4;
				clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(l.street_address, l.city, l.state, l.zip);
				self.prim_range := clean_address [1..10];
				self.predir := clean_address [11..12];
				self.prim_name := clean_address [13..40];
				self.suffix := clean_address [41..44];
				self.postdir := clean_address [45..46];
				self.unit_desig := clean_address [47..56];
				// self.sec_range := clean_address [57..65];
				self.sec_range := l.apt;
				self.p_city_name := clean_address [90..114];
				self.st := clean_address [115..116];
				self.zip := clean_address [117..121];
				self.zip4 := clean_address[122..125];
				self.county := clean_address[143..145];
				self.geo_lat := clean_address[146..155];
				self.geo_long := clean_address[156..166];
				self.msa := clean_address[167..170];
				self.geo_blk := clean_address[171..177];
				self.geo_match := clean_address[178];
				//build geolink
				self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		end;

		cleaned := project(indata, AddressClean(Left, COUNTER));

//Get Geolink based data
		Address_Attributes.Layouts.rNeigbhorhood_Report getGeolinkData(cleaned l) := TRANSFORM
			self.seq := l.seq;
			self.PublicSafety  := choosen(Address_Attributes.get_Data.Public_Safety(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)), iesp.Constants.NeighborSafety.MaxPublicSafety);
			self.Correctional  := choosen(Address_Attributes.get_Data.Correctional(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)), iesp.Constants.NeighborSafety.MaxCorrecFacility);
			self.School 			 := choosen(Address_Attributes.get_Data.Schools(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)), iesp.Constants.NeighborSafety.MaxSchools);
			self.College 		   := choosen(Address_Attributes.get_Data.Colleges(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)), iesp.Constants.NeighborSafety.MaxColleges);
			self.Neighborhood	 := Address_Attributes.get_Data.Neighborhood_Stats(Address_Attributes.functions.getGeolinks(l.geolink, 0));
			self := l;
			self := [];
		end;
		
		geolink_data := project(cleaned, getGeolinkData(left));

//Get Walkability Score		
		Walkability := address_attributes.getWalkability_clean_in(cleaned);	
		
//Append Walkability To Geolink data
		Address_Attributes.Layouts.rNeigbhorhood_Report addWalkability(geolink_data l, Walkability r) := transform
			self.seq := l.seq;
			self := r;
			self := l;
		end;
		base_Walkability := join(geolink_data, Walkability,
			left.seq = right.seq,
			addWalkability(left, right), Left Outer, keep(1));

//Get Assessor and Deed data	
		Address_Attributes.Layouts.rNeigbhorhood_Report addProperty(base_Walkability l, File_Property r) := TRANSFORM
			self.seq := l.seq;
			self.occupant_owned := r.occupant_owned;
			self.purchase_date := r.purchase_date;
			self.built_date := r.built_date;
			self.purchase_amount := r.purchase_amount;
			self.mortgage_amount := r.mortgage_amount;
			self.mortgage_date := r.mortgage_date;
			self.mortgage_type := r.mortgage_type;
			self.type_financing	:= r.type_financing;
			self.assessed_amount := r.assessed_amount;
			self.property_count	:= r.property_count;
			self.property_total	:= r.property_total;
			self.property_owned_purchase_total := r.property_owned_purchase_total;
			self.property_owned_purchase_count := r.property_owned_purchase_count;
			self.property_owned_assessed_total := r.property_owned_assessed_total;
			self.property_owned_assessed_count := r.property_owned_assessed_count;
			self.date_first_seen := (string)r.date_first_seen;
			self.date_last_seen := (string)r.date_last_seen;
			self.standardized_land_use_code := r.standardized_land_use_code;
			self.building_area := r.building_area;
			self.no_of_buildings := r.no_of_buildings;
			self.no_of_stories := r.no_of_stories;
			self.no_of_rooms := r.no_of_rooms;
			self.no_of_bedrooms := r.no_of_bedrooms;
			self.no_of_baths := r.no_of_baths;
			self.no_of_partial_baths := r.no_of_partial_baths;
			self.garage_type_code	:= r.garage_type_code;
			self.parking_no_of_cars	:= r.parking_no_of_cars;
			self.style_code	:= r.style_code;
			self.ln_fares_id := r.ln_fares_id;
			self := l;
		end;

		base_Property := join(base_Walkability, File_Property,
			left.zip!='' and left.st != '' and left.prim_name!='' and left.prim_range != '' and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.sec_range = right.sec_range) and
			keyed(left.zip = right.zip) and
			keyed(left.suffix = right.suffix) and
			keyed(left.predir = right.predir) and
			keyed(left.postdir = right.postdir),
			addProperty(left, right),Left Outer, keep(1), atmost(100));

		Address_Attributes.Layouts.rNeigbhorhood_Report addWaterExposure(base_Property l, File_Assessor r) := transform
			self.seq := l.seq;
			self.water_adjacent := if(r.site_influence1_code ='W' or r.site_influence2_code ='W' or r.site_influence3_code ='W' or r.site_influence4_code ='W' or r.site_influence5_code ='W' or
																r.site_influence1_code ='B' or r.site_influence2_code ='B' or r.site_influence3_code ='B' or r.site_influence4_code ='B' or r.site_influence5_code ='B' or
																r.site_influence1_code ='Z' or r.site_influence2_code ='Z' or r.site_influence3_code ='Z' or r.site_influence4_code ='Z' or r.site_influence5_code ='Z',1,0);	
			self.water_view :=		 if(r.site_influence1_code ='L' or r.site_influence2_code ='L' or r.site_influence3_code ='L' or r.site_influence4_code ='L' or r.site_influence5_code ='L' or
																r.site_influence1_code ='O' or r.site_influence2_code ='O' or r.site_influence3_code ='O' or r.site_influence4_code ='O' or r.site_influence5_code ='O' or
																r.site_influence1_code ='N' or r.site_influence2_code ='N' or r.site_influence3_code ='N' or r.site_influence4_code ='N' or r.site_influence5_code ='N' or
																r.site_influence1_code ='U' or r.site_influence2_code ='U' or r.site_influence3_code ='U' or r.site_influence4_code ='U' or r.site_influence5_code ='U',1,0);
			self.topograpy_code := r.topograpy_code;
			self.building_class_code := r.building_class_code;
			self.building_quality_code := r.building_quality_code;
			self.building_condition_code := r.building_condition_code;
			self := l;
		end;
		base_Assessor := join(base_Property, File_Assessor,
			left.ln_fares_id!='' and
			keyed(left.ln_fares_id = right.ln_fares_id),
			addWaterExposure(left, right), Left Outer, keep(1), atmost(100));

//Get AVM Data
		Address_Attributes.Layouts.rNeigbhorhood_Report getAVM(base_Assessor l, File_AVM r) := transform
			self.seq := l.seq;
			self.history_date := r.history_date;
			self.unformatted_apn := r.unformatted_apn;
			self.fips_code := r.fips_code;
			self.land_use := r.land_use;
			self.assessed_value_year := r.assessed_value_year;
			self.sales_price := r.sales_price;
			self.assessed_total_value := r.assessed_total_value;
			self.market_total_value := r.market_total_value;
			self.tax_assessment_valuation := r.tax_assessment_valuation;
			self.price_index_valuation := r.price_index_valuation;
			self.hedonic_valuation := r.hedonic_valuation;
			self.automated_valuation := r.automated_valuation;
			self.confidence_score := r.confidence_score;
			self := l;
		end;

		multi_AVM := join(base_Assessor, File_AVM,
			left.zip!='' and left.st != '' and left.prim_name!='' and left.prim_range != '' and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.st = right.st) and
			keyed(left.zip = right.zip) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.sec_range = right.sec_range),
			getAVM(left, right),Left Outer, keep(5), atmost(100));

//Append AVM Data
		best_avm := dedup(sort(multi_AVM, seq, -prim_name, -history_date, -assessed_value_year, -confidence_score), seq, prim_name);
		Address_Attributes.Layouts.rNeigbhorhood_Report addAVM(base_Assessor l, best_avm r) := transform
			self.seq := l.seq;
			self.history_date := r.history_date;
			self.unformatted_apn := r.unformatted_apn;
			self.fips_code := r.fips_code;
			self.land_use := r.land_use;
			self.assessed_value_year := r.assessed_value_year;
			self.sales_price := r.sales_price;
			self.assessed_total_value := r.assessed_total_value;
			self.market_total_value := r.market_total_value;
			self.tax_assessment_valuation := r.tax_assessment_valuation;
			self.price_index_valuation := r.price_index_valuation;
			self.hedonic_valuation := r.hedonic_valuation;
			self.automated_valuation := r.automated_valuation;
			self.confidence_score := r.confidence_score;
			self := l;
		end;
		base_AVM := join(base_Assessor, best_AVM,
			left.seq = right.seq,
			addAVM(left,right), Left Outer, keep(1), atmost(100));

//Get Census data
		Address_Attributes.Layouts.rNeigbhorhood_Report addEASI(base_AVM l, File_Census r) := transform
			self.seq := l.seq;
			self := r;
			self := l;
		end;
		final_data := join(base_AVM, File_Census,
			left.geolink != '' and 
			keyed(left.geolink = right.geolink),
			addEASI(left, right),Left Outer, keep(1), atmost(100));

//Map Results to ESDL
	//public safety
	iesp.neighborhood_safety.t_PublicSafetyFacility toPS_ESDL(Address_Attributes.Layouts.rPublicSafety l):=transform
		self.Name									:= l.Name;
		self.Institution					:= l.Institution;
		self.Distance							:= l.Distance;
		self.BID									:= l.BDID;
		self.Officers							:= l.Officers;
		self.PopulationPerOfficer	:= l.Pop_per_Cop;
		self.Website							:= l.Website;
		self.Phone								:= l.Phone10;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.addr_suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;
	
	//correctional facilities
	iesp.neighborhood_safety.t_Facility toCF_ESDL(Address_Attributes.Layouts.rCorrectional l):=transform
		self.Name					:= l.institution;
		self.Institution	:= l.institution;
		self.Distance			:= l.distance;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.addr_suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;
	
	//schools
	iesp.residential_quality.t_EducationalFacility toSchool_ESDL(Address_Attributes.Layouts.rSchools l):=transform
		self.unitid :=l.unitid;
		self.Name :=l.school_name;
		self.Institution := l.school_name;
		self.InstitutionType := l.Inst_type;
		self.Distance :=l.distance;
		self.MSA := l.msa;
		self.geoBlock := l.geo_blk;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;
	
	//colleges
	iesp.residential_quality.t_EducationalFacility toCollege_ESDL(Address_Attributes.Layouts.rColleges l):=transform
		self.unitid :=l.unitid;
		self.Name :=l.college_name;
		self.Institution := l.college_name;
		self.InstitutionType := l.Inst_type;
		self.Distance :=l.distance;
		self.MSA := l.msa;
		self.geoBlock := l.geo_blk;
		self.Phone := l.phone;
		self.website := l.webaddr;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;

	//main payload
	iesp.residential_quality.t_ResidentialQualityReportResponse toESDL(final_data l) := TRANSFORM
		// Header
		self._Header.Status												:= if(goodTransaction,1,0);
		self._Header.Message											:= if(goodTransaction,'', 'Results may be incomplete.  Input requirements not met.');
		// self._Header.QueryID																				:= '';
		// self._Header.TransactionID																	:= trans_id;

		//Walkability Range
		self.Report.Walkability.WalkabilityScoresRange.low := walkabilityscore_low;
		self.Report.Walkability.WalkabilityScoresRange.high := walkabilityscore_high;

		//Walkability
		self.Report.Walkability.PublicTransportation := l.public_trans;
		self.Report.Walkability.Grocery := l.grocery_food;
		self.Report.Walkability.Restaurant := l.restaurant_food;
		self.Report.Walkability.PersonalCare := l.personal_care;
		self.Report.Walkability.DrugsPharmacy := l.drugs_pharmacy;
		self.Report.Walkability.MedicalCare := l.medical_care;
		self.Report.Walkability.RetailGoods := l.retail_goods;
		self.Report.Walkability.Church := l.church;
		self.Report.Walkability.Entertainment := l.entertainment;
		self.Report.Walkability.Schools := l.schools;
		self.Report.Walkability.Banking := l.banking;
		self.Report.Walkability.Daycare := l.daycare;
		self.Report.Walkability.RepairShops := l.repair_shops;
		self.Report.Walkability.PublicService := l.public_service;
		self.Report.Walkability.WalkabilityScore := if(l.walkability_score > 100, walkabilityscore_high, if(l.walkability_score = 0, -1, l.walkability_score));

		//Property
		self.Report.Property.OccupantOwned := l.occupant_owned;
		self.Report.Property.PurchaseDate.Year := (integer)((string)l.purchase_date)[1..4];
		self.Report.Property.PurchaseDate.Month := (integer)((string)l.purchase_date)[5..6];
		self.Report.Property.PurchaseDate.Day := (integer)((string)l.purchase_date)[7..8];
		self.Report.Property.BuiltDate.Year := (integer)((string)l.built_date)[1..4];
		self.Report.Property.BuiltDate.Month := (integer)((string)l.built_date)[5..6];
		self.Report.Property.BuiltDate.Day := (integer)((string)l.built_date)[7..8];
		self.Report.Property.PurchaseAmount := l.purchase_amount;
		self.Report.Property.MortgageAmount := l.mortgage_amount;
		self.Report.Property.MortgageDate.Year := (integer)((string)l.mortgage_date)[1..4];
		self.Report.Property.MortgageDate.Month := (integer)((string)l.mortgage_date)[5..6];
		self.Report.Property.MortgageDate.Day := (integer)((string)l.mortgage_date)[7..8];
		self.Report.Property.MortgageType := l.mortgage_type;
		self.Report.Property.Financingtype := l.type_financing;
		self.Report.Property.AssessedAmount := l.assessed_amount;
		self.Report.Property.PropertyCount := l.property_count;
		self.Report.Property.PropertyTotal := l.property_total;
		self.Report.Property.OwnedPurchaseTotal := l.property_owned_purchase_total;
		self.Report.Property.OwnedPurchaseCount := l.property_owned_purchase_count;
		self.Report.Property.OwnedAssessedTotal := l.property_owned_assessed_total;
		self.Report.Property.OwnedAssessedCount := l.property_owned_assessed_count;
		self.Report.Property.DateFirstSeen.Year := (integer)l.date_first_seen[1..4];
		self.Report.Property.DateFirstSeen.Month := (integer)l.date_first_seen[5..6];
		self.Report.Property.DateFirstSeen.Day := (integer)l.date_first_seen[7..8];
		self.Report.Property.DateLastSeen.Year := (integer)l.date_last_seen[1..4];
		self.Report.Property.DateLastSeen.Month := (integer)l.date_last_seen[5..6];
		self.Report.Property.DateLastSeen.Day := (integer)l.date_last_seen[7..8];
		self.Report.Property.LandUseCode := l.standardized_land_use_code;
		self.Report.Property.BuildingArea := l.building_area;
		self.Report.Property.NumberOfBuildings := l.no_of_buildings;
		self.Report.Property.NumberOfStories := l.no_of_stories;
		self.Report.Property.NumberOfRooms := l.no_of_rooms;
		self.Report.Property.NumberOfBaths := l.no_of_baths;
		self.Report.Property.NumberOfBedrooms := l.no_of_bedrooms;
		self.Report.Property.NumberOfPartialBaths := l.no_of_partial_baths;
		self.Report.Property.GarageTypeCode := l.garage_type_code;
		self.Report.Property.NumberOfCarsParking := l.parking_no_of_cars;
		self.Report.Property.StyleCode := l.style_code;
		self.Report.Property.LnFaresId := l.ln_fares_id;
		self.Report.Property.WaterAdjacent := l.water_adjacent;
		self.Report.Property.WaterView := l.water_view;
		self.Report.Property.TopograpyCode := l.topograpy_code;
		self.Report.Property.BuildingClassCode := l.building_class_code;
		self.Report.Property.BuildingQualityCode := l.building_quality_code;
		self.Report.Property.BuildingConditionCode := l.building_condition_code;
		
		//Property valuation
		self.Report.PropertyValuation.HistoryDate.Year := (integer)l.history_date[1..4];
		self.Report.PropertyValuation.HistoryDate.Month := (integer)l.history_date[5..6];
		self.Report.PropertyValuation.HistoryDate.Day := (integer)l.history_date[7..8];
		self.Report.PropertyValuation.ParcelId := l.unformatted_apn;
		self.Report.PropertyValuation.FipsCode := l.fips_code;
		self.Report.PropertyValuation.LandUse := l.land_use;
		self.Report.PropertyValuation.AssessedValueYear := (integer)l.assessed_value_year;
		self.Report.PropertyValuation.SalesPrice := (integer)l.sales_price;
		self.Report.PropertyValuation.AssessedTotalValue := (integer)l.assessed_total_value;
		self.Report.PropertyValuation.TotalMarketValue := (integer)l.market_total_value;
		self.Report.PropertyValuation.TaxAssessmentValuation := (integer)l.assessed_total_value;
		self.Report.PropertyValuation.PriceIndexValuation := (integer)l.price_index_valuation;
		self.Report.PropertyValuation.HedonicValuation := (integer)l.hedonic_valuation;
		self.Report.PropertyValuation.AutomatedValuation := (integer)l.automated_valuation;
		self.Report.PropertyValuation.ConfidenceScore := (integer)l.confidence_score;

		//Census
		self.Report.Demographics.Population := l.POP00;
		self.Report.Demographics.Families := l.FAMILIES;
		self.Report.Demographics.HouseHold := l.HH00;
		self.Report.Demographics.HouseHoldSize := l.HHSIZE;
		self.Report.Demographics.MedianAge := l.MED_AGE;
		self.Report.Demographics.MedianRent := l.MED_RENT;
		self.Report.Demographics.MedianHouseValue := l.MED_HVAL;
		self.Report.Demographics.MedianYearBuilt := l.MED_YEARBLT;
		self.Report.Demographics.MedianHouseHoldIncome := l.MED_HHINC;
		self.Report.Demographics.UrbanPercent := l.URBAN_P;
		self.Report.Demographics.RuralPercent := l.RURAL_P;
		self.Report.Demographics.MarriedFamiliesPercent := l.FAMMAR_P;
		self.Report.Demographics.Families18YearsPercent := l.FAMMAR18_P;
		self.Report.Demographics.Families18YearsNotLivingAtHomePercent := l.FAMOTF18_P;
		self.Report.Demographics.Child := l.CHILD;
		self.Report.Demographics.Young := l.YOUNG;
		self.Report.Demographics.Retired := l.RETIRED;
		self.Report.Demographics.DivorcedFamiliesPercent := l.FEMDIV_P;
		self.Report.Demographics.VacantPercent := l.VACANT_P;
		self.Report.Demographics.OccupiedUnitPercent := l.OCCUNIT_P;
		self.Report.Demographics.OwnerOccupied := l.OWNOCP;
		self.Report.Demographics.RentOccupied := l.RENTOCP;
		self.Report.Demographics.SingleFamilyDetachedUnitPercent := l.SFDU_P;
		self.Report.Demographics.BigApartmentPercent := l.BIGAPT_P;
		self.Report.Demographics.TrailerPercent := l.TRAILER_P;
		self.Report.Demographics.HigherRent := l.HIGHRENT;
		self.Report.Demographics.LowerRent := l.LOWRENT;
		self.Report.Demographics.LowerHouseValue := l.LOW_HVAL;
		self.Report.Demographics.HigherHouseValue := l.HIGH_HVAL;
		self.Report.Demographics.NewHouses := l.NEWHOUSE;
		self.Report.Demographics.OldHouses := l.OLDHOUSE;
		self.Report.Demographics.LowIncome := l.LOWINC;
		self.Report.Demographics.HighIncome := l.HIGHINC;
		self.Report.Demographics.PopulationOver25 := l.POPOVER25;
		self.Report.Demographics.PopulationOver18 := l.POPOVER18;
		self.Report.Demographics.LowEducation := l.LOW_ED;
		self.Report.Demographics.HighEducation := l.HIGH_ED;
		self.Report.Demographics.InCollege := l.INCOLLEGE;
		self.Report.Demographics.Unemployed := l.UNEMP;
		self.Report.Demographics.CivilEmployed := l.CIV_EMP;
		self.Report.Demographics.MilitaryEmployed := l.MIL_EMP;
		self.Report.Demographics.WhiteCollar := l.WHITE_COL;
		self.Report.Demographics.BlueCollar := l.BLUE_COL;
		self.Report.Demographics.Murders := l.MURDERS;
		self.Report.Demographics.Rape := l.RAPE;
		self.Report.Demographics.Robbery := l.ROBBERY;
		self.Report.Demographics.Assault := l.ASSAULT;
		self.Report.Demographics.Burglary := l.BURGLARY;
		self.Report.Demographics.Larceny := l.LARCENY;
		self.Report.Demographics.CarTheft := l.CARTHEFT;
		self.Report.Demographics.TotalCrime := l.TOTCRIME; //EASI Total Crime Index (US Avg=100; A=High)
		self.Report.Demographics.EasiqScore := l.EASIQLIFE; //EASI Quality of Life Index (US Avg=100) 


		//Neighborhood Statistics
		self.Report.NeighborhoodStats.VacantProperties 			:= l.Neighborhood[1].neighborhood_vacant_properties;
		self.Report.NeighborhoodStats.Business				 			:= l.Neighborhood[1].neighborhood_business_count;
		self.Report.NeighborhoodStats.SingleFamilyDwelling	:= l.Neighborhood[1].neighborhood_sfd_count;
		self.Report.NeighborhoodStats.MultiFamilyDwelling		:= l.Neighborhood[1].neighborhood_mfd_count;
		self.Report.NeighborhoodStats.CollegeAddress				:= l.Neighborhood[1].neighborhood_collegeaddr_count;
		self.Report.NeighborhoodStats.SeasonalAddress				:= l.Neighborhood[1].neighborhood_seasonaladdr_count;
		self.Report.NeighborhoodStats.POBOX									:= l.Neighborhood[1].neighborhood_pobox_count;
		self.Report.NeighborhoodStats.NoticeOfDefault				:= l.Neighborhood[1].nod;
		self.Report.NeighborhoodStats.NoticeOfDefault1Year	:= l.Neighborhood[1].nod_1yr;
		self.Report.NeighborhoodStats.NoticeOfDefault2Year	:= l.Neighborhood[1].nod_2yr;
		self.Report.NeighborhoodStats.NoticeOfDefault3Year	:= l.Neighborhood[1].nod_3yr;
		self.Report.NeighborhoodStats.NoticeOfDefault4Year	:= l.Neighborhood[1].nod_4yr;
		self.Report.NeighborhoodStats.NoticeOfDefault5Year	:= l.Neighborhood[1].nod_5yr;
		self.Report.NeighborhoodStats.Foreclosures					:= l.Neighborhood[1].foreclosures;
		self.Report.NeighborhoodStats.Foreclosures1Year			:= l.Neighborhood[1].foreclosures_1yr;
		self.Report.NeighborhoodStats.Foreclosures2Year			:= l.Neighborhood[1].foreclosures_2yr;
		self.Report.NeighborhoodStats.Foreclosures3Year			:= l.Neighborhood[1].foreclosures_3yr;
		self.Report.NeighborhoodStats.Foreclosures4Year			:= l.Neighborhood[1].foreclosures_4yr;
		self.Report.NeighborhoodStats.Foreclosures5Year			:= l.Neighborhood[1].foreclosures_5yr;
		self.Report.NeighborhoodStats.DeedTransfers					:= l.Neighborhood[1].deed_transfers;
		self.Report.NeighborhoodStats.DeedTransfers1Year		:= l.Neighborhood[1].deed_transfers_1yr;
		self.Report.NeighborhoodStats.DeedTransfers2Year		:= l.Neighborhood[1].deed_transfers_2yr;
		self.Report.NeighborhoodStats.DeedTransfers3Year		:= l.Neighborhood[1].deed_transfers_3yr;
		self.Report.NeighborhoodStats.DeedTransfers4Year		:= l.Neighborhood[1].deed_transfers_4yr;
		self.Report.NeighborhoodStats.DeedTransfers5Year		:= l.Neighborhood[1].deed_transfers_5yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens			:= l.Neighborhood[1].release_lis_pendens;
		self.Report.NeighborhoodStats.ReleaseLisPendens1Year	:= l.Neighborhood[1].release_lis_pendens_1yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens2Year	:= l.Neighborhood[1].release_lis_pendens_2yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens3Year	:= l.Neighborhood[1].release_lis_pendens_3yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens4Year	:= l.Neighborhood[1].release_lis_pendens_4yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens5Year	:= l.Neighborhood[1].release_lis_pendens_5yr;
		self.Report.NeighborhoodStats.LiensRecentUnreleased		:= l.Neighborhood[1].liens_recent_unreleased_count;
		self.Report.NeighborhoodStats.LiensHistoricalUnreleased	:= l.Neighborhood[1].liens_historical_unreleased_count;
		self.Report.NeighborhoodStats.LiensRecentReleased				:= l.Neighborhood[1].liens_recent_released_count;
		self.Report.NeighborhoodStats.LiensHistoricalReleased		:= l.Neighborhood[1].liens_historical_released_count;
		self.Report.NeighborhoodStats.EvictionRecentUnreleased	:= l.Neighborhood[1].eviction_recent_unreleased_count;
		self.Report.NeighborhoodStats.EvictionHistoricalUnreleased	:= l.Neighborhood[1].eviction_historical_unreleased_count;
		self.Report.NeighborhoodStats.EvictionRecentReleased				:= l.Neighborhood[1].eviction_recent_released_count;
		self.Report.NeighborhoodStats.EvictionHistoricalReleased		:= l.Neighborhood[1].eviction_historical_released_count;
		self.Report.NeighborhoodStats.OccupantOwned				:= l.Neighborhood[1].occupant_owned_count;
		self.Report.NeighborhoodStats.BuildingAgeRecords	:= l.Neighborhood[1].cnt_building_age;
		self.Report.NeighborhoodStats.AverageBuildingAge	:= l.Neighborhood[1].ave_building_age;
		self.Report.NeighborhoodStats.PurchaseAmountRecords	:= l.Neighborhood[1].cnt_purchase_amount;
		self.Report.NeighborhoodStats.AveragePurchaseAmount	:= l.Neighborhood[1].ave_purchase_amount;
		self.Report.NeighborhoodStats.MortgageAmountRecords	:= l.Neighborhood[1].cnt_mortgage_amount;
		self.Report.NeighborhoodStats.AverageMortgageAmount	:= l.Neighborhood[1].ave_mortgage_amount;
		self.Report.NeighborhoodStats.AssessedAmountRecords	:= l.Neighborhood[1].cnt_assessed_amount;
		self.Report.NeighborhoodStats.AverageAssessedAmount	:= l.Neighborhood[1].ave_assessed_amount;
		self.Report.NeighborhoodStats.BuildingAreaRecords	:= l.Neighborhood[1].cnt_building_area;
		self.Report.NeighborhoodStats.AverageBuildingArea	:= l.Neighborhood[1].ave_building_area;
		self.Report.NeighborhoodStats.PricePerSquareFootRecords	:= l.Neighborhood[1].cnt_price_per_sf;
		self.Report.NeighborhoodStats.AveragePricePerSquareFoot	:= l.Neighborhood[1].ave_price_per_sf;
		self.Report.NeighborhoodStats.NumberOfBuildingsRecords	:= l.Neighborhood[1].cnt_no_of_buildings_count;
		self.Report.NeighborhoodStats.AverageNumberOfBuildings	:= l.Neighborhood[1].ave_no_of_buildings_count;
		self.Report.NeighborhoodStats.NumberOfStoriesRecords	:= l.Neighborhood[1].cnt_no_of_stories_count;
		self.Report.NeighborhoodStats.AverageNumberOfStories	:= l.Neighborhood[1].ave_no_of_stories_count;
		self.Report.NeighborhoodStats.NumberOfRoomsRecords	:= l.Neighborhood[1].cnt_no_of_rooms_count;
		self.Report.NeighborhoodStats.AverageNumberOfRooms	:= l.Neighborhood[1].ave_no_of_rooms_count;
		self.Report.NeighborhoodStats.NumberOfBedroomsRecords	:= l.Neighborhood[1].cnt_no_of_bedrooms_count;
		self.Report.NeighborhoodStats.AverageNumberOfBedrooms	:= l.Neighborhood[1].ave_no_of_bedrooms_count;
		self.Report.NeighborhoodStats.NumberOfBathsRecords	:= l.Neighborhood[1].cnt_no_of_baths_count;
		self.Report.NeighborhoodStats.AverageNumberOfBaths	:= l.Neighborhood[1].ave_no_of_baths_count;
		self.Report.NeighborhoodStats.NumberOfPartiaBathsRecords	:= l.Neighborhood[1].cnt_no_of_partial_baths_count;
		self.Report.NeighborhoodStats.AverageNumberOfPartialBaths	:= l.Neighborhood[1].ave_no_of_partial_baths_count;
		self.Report.NeighborhoodStats.TotalProperty	:= l.Neighborhood[1].total_property_count;
		self.Report.NeighborhoodStats.BankruptcyCount	:= l.Neighborhood[1].bk_cnt;
		self.Report.NeighborhoodStats.Bankruptcy1yr	:= l.Neighborhood[1].bk_1yr;
		self.Report.NeighborhoodStats.Bankruptcy2yr	:= l.Neighborhood[1].bk_2yr;
		self.Report.NeighborhoodStats.Bankruptcy3yr	:= l.Neighborhood[1].bk_3yr;
		self.Report.NeighborhoodStats.Bankruptcy4yr	:= l.Neighborhood[1].bk_4yr;
		self.Report.NeighborhoodStats.Bankruptcy5yr	:= l.Neighborhood[1].bk_5yr;
		self.Report.NeighborhoodStats.BankruptcyCh7	:= l.Neighborhood[1].bk_ch7_cnt;
		self.Report.NeighborhoodStats.BankruptcyCh11	:= l.Neighborhood[1].bk_ch11_cnt;
		self.Report.NeighborhoodStats.BankruptcyCh12	:= l.Neighborhood[1].bk_ch12_cnt;
		self.Report.NeighborhoodStats.BankruptcyCh13	:= l.Neighborhood[1].bk_ch13_cnt;
		self.Report.NeighborhoodStats.BankruptcyDischarged	:= l.Neighborhood[1].bk_discharged_cnt;
		self.Report.NeighborhoodStats.BankruptcyDismissed	:= l.Neighborhood[1].bk_dismissed_cnt;
		self.Report.NeighborhoodStats.BankruptcySelfRepresenting	:= l.Neighborhood[1].bk_pro_se_cnt;
		self.Report.NeighborhoodStats.BankruptcyBusinessFlag	:= l.Neighborhood[1].bk_business_flag_cnt;
		self.Report.NeighborhoodStats.BankruptcyCorpFlag	:= l.Neighborhood[1].bk_corp_flag_cnt;
		
		//Datasets
		self.Report.PublicSafetyFacilities := project(l.PublicSafety, toPS_ESDL(left));
		self.Report.CorrectionalFacilities := project(l.Correctional, toCF_ESDL(left));
		self.Report.Schools  := project(l.School, toSchool_ESDL(left));
		self.Report.Colleges := project(l.College, toCollege_ESDL(left));
		
		self := l;
		self := [];
	end;	
	final_report_iesp := project(final_data, toESDL(left));

///////////////
//FINAL RESULTS

Return final_report_iesp;

END;
