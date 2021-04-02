import address_attributes, advo, AVM_V2, doxie, EASI, header, LN_PropertyV2, property, Risk_Indicators, ut, dx_property;

export get_SmartGrid_Data(DATASET(Address_Attributes.Layouts.SmartGrid_in) indata = DATASET([],Address_Attributes.Layouts.SmartGrid_in)) := FUNCTION

	//Working Data Layouts
	layout_Valuation := record
		string30	acctno;
		string4 	assessed_value_year;
		string11 	sales_price;  
		string11 	assessed_total_value;
		string11 	market_total_value;
		integer 	tax_assessment_valuation;
		integer 	price_index_valuation;
		integer 	hedonic_valuation;
		integer 	automated_valuation;
	end;
	layout_Hedonics := record
		string30		acctno;
		unsigned4 	built_date;
		unsigned4 	purchase_amount;
		unsigned4 	mortgage_amount;
		string10		standardized_land_use_code;
		unsigned8 	building_area;
		unsigned8		price_per_sf;
		unsigned8 	no_of_buildings;
		unsigned8 	no_of_stories;
		unsigned8 	no_of_rooms;
		unsigned8 	no_of_bedrooms;
		unsigned8 	no_of_baths;
		unsigned8 	no_of_partial_baths;
		string3 		garage_type_code;
		unsigned8 	parking_no_of_cars;
		string3 		style_code;
	end;
	layout_Velocity := RECORD
		string30	acctno;
		integer8 	ssn_ct;
		integer8 	ssn_ct_c6;
		integer8 	did_ct;
		integer8 	did_ct_c6;
	END;
	Layout_Census := record
		string30	acctno;
		string	POP00	;
		string	FAMILIES	;
		string	HHSIZE	;
		string	MED_AGE	;
		string	MED_YEARBLT	;
		string	URBAN_P	;
		string	RURAL_P	;
		string	CHILD	;
		string	YOUNG	;
		string	RETIRED	;
		string	VACANT_P	;
		string	HIGHRENT	;
		string	LOWRENT	;
		string	LOW_HVAL	;
		string	HIGH_HVAL	;
		string	LOWINC	;
		string	HIGHINC	;
		string	LOW_ED	;
		string	HIGH_ED	;
		string	INCOLLEGE	;
		string	UNEMP	;
		string	PROFESSIONAL	;
		string	EDU_INDX	;
		string	BLUE_EMPL	;
		string	EXP_HOMES	;
		string	RICH_ASIAN	;
		string	RICH_BLK	;
		string	RICH_FAM	;
		string	RICH_HISP	;
		string	VERY_RICH	;
		string	RICH_NFAM	;
		string	RICH_WHT	;
		string	WORK_HOME	;
		string	RICH_YOUNG	;
	end;
	layout_ADVO := record
		string30	acctno;
		string12	geolink;
		string1 	address_vacancy_indicator;
		string1 	dnd_indicator;
		string1		Record_Type_Code;
		string1		Seasonal_Delivery_Indicator;
		string1		College_Indicator;
		string1		Address_Style_Flag;
		string1		Residential_or_Business_Ind;
		string1		Address_Type;
		string1		Mixed_Address_Usage;
	end;
	Layout_Foreclosure :=  record
		string30	acctno;
		string3  	deed_category;
		string55 	deed_desc;
		string3  	document_type;
		string40 	document_desc;
		string8  	recording_date;
		string8		data_date;
	end;
	Layout_Vehicle := record
		string30	acctno;
		STRING15	Sequence_Key;
		boolean	is_minor;
		STRING2	state_origin;
		string25	Orig_VIN;
		string5	Orig_Vehicle_Type_Code;
		string2	VINA_Body_Style;
		string1	VINA_Fuel_Code;
		string5	Best_Body_Code;
	end;
	
	Layout_Vehicles := record
		string30	acctno;
		string1	fuel_type1;
		string1	vehicle_code1;
		string1	fuel_type2;
		string1	vehicle_code2;
		string1	fuel_type3;
		string1	vehicle_code3;
		string1	fuel_type4;
		string1	vehicle_code4;
	end;
	
	Layout_advo_in := record
		string5 zip;
		string10 prim_range;
		string28 prim_name;
		string4 addr_suffix;
		string2 predir;
		string2 postdir;
		string8 sec_range;
		string5 zip_5;
		string4 route_num;
		string4 zip_4;
		string9 walk_sequence;
		string10 street_num;
		string2 street_pre_directional;
		string28 street_name;
		string2 street_post_directional;
		string4 street_suffix;
		string4 secondary_unit_designator;
		string8 secondary_unit_number;
		string1 address_vacancy_indicator;
		string1 throw_back_indicator;
		string1 seasonal_delivery_indicator;
		string5 seasonal_start_suppression_date;
		string5 seasonal_end_suppression_date;
		string1 dnd_indicator;
		string1 college_indicator;
		string10 college_start_suppression_date;
		string10 college_end_suppression_date;
		string1 address_style_flag;
		string5 simplify_address_count;
		string1 drop_indicator;
		string1 residential_or_business_ind;
		string2 dpbc_digit;
		string1 dpbc_check_digit;
		string10 update_date;
		string10 file_release_date;
		string10 override_file_release_date;
		string3 county_num;
		string28 county_name;
		string28 city_name;
		string2 state_code;
		string2 state_num;
		string2 congressional_district_number;
		string1 owgm_indicator;
		string1 record_type_code;
		string10 advo_key;
		string1 address_type;
		string1 mixed_address_usage;
		string8 date_first_seen;
		string8 date_last_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string8 vac_begdt;
		string8 vac_enddt;
		string8 months_vac_curr;
		string8 months_vac_max;
		string8 vac_count;
		string10 unit_desig;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string2 fips_county;
		string3 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
	end;

	//		
	
		goodTransIndata := indata(acctno <> '' and  street_address <> '' and  city <> '' and  state <> '' and  zip <> '');			

		//Clean Addresses
		address_attributes.Layouts.SmartGrid_in_clean AddressClean(goodTransIndata l) := TRANSFORM
				//echo input
				self.acctno := l.acctno;
				self.street_address_in := l.street_address;
				self.apt_in := l.apt;
				self.city_in := l.city;
				self.state_in := l.state;
				self.zip_in := l.zip;
				self.zip4_in := l.zip4;
				//cleaned data
				clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(l.street_address, l.city, l.state, l.zip);
				self.prim_range := clean_address [1..10];
				self.predir := clean_address [11..12];
				self.prim_name := clean_address [13..40];
				self.suffix := clean_address [41..44];
				self.postdir := clean_address [45..46];
				self.unit_desig := clean_address [47..56];
				self.sec_range := clean_address [57..65];
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
				//build geolink for AddrRisk
				self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
				self := [];
		end;

		Cleaned := project(goodTransIndata, AddressClean(Left));
			
		//Append Valuation Data
		layout_Valuation addValuation(cleaned l, AVM_V2.Key_AVM_Address r) := transform
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;

		Valuation := join(cleaned(zip!='' and st != '' and prim_name!=''), AVM_V2.Key_AVM_Address,
			keyed(left.prim_name = right.prim_name) and
			keyed(left.st = right.st) and
			keyed(left.zip = right.zip) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.sec_range = right.sec_range or left.sec_range =''),
			addValuation(left, right),Left Outer,
				keep(1));

		//Append Property V2 Data
		layout_Hedonics addProperty(Cleaned l, LN_PropertyV2.Key_Prop_Address_V4 r) := transform
			self.price_per_sf := if(r.building_area > 0, r.purchase_amount DIV r.building_area, 0);
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;

		Hedonics := join(Cleaned(zip!='' and st != '' and prim_name!=''), LN_PropertyV2.Key_Prop_Address_V4,
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.sec_range = right.sec_range or left.sec_range ='') and
			keyed(left.zip = right.zip) and
			keyed(left.suffix = right.suffix) and
			keyed(left.predir = right.predir or left.predir ='') and
			keyed(left.postdir = right.postdir or left.postdir =''),
			addProperty(left, right),Left Outer,
				keep(1));

		//Append Velocity data
		layout_Velocity AddVelocity(Cleaned l, Risk_Indicators.Key_Address_Table_v4 r) := transform
			self.acctno := l.acctno;
			self.ssn_ct := r.combo.ssn_ct;
			self.ssn_ct_c6 := r.combo.ssn_ct_c6;
			self.did_ct := r.combo.did_ct;
			self.did_ct_c6 := r.combo.did_ct_c6;
			self := l;
			self := [];
		end;

		Velocity := join(Cleaned(zip !='' and prim_name !=''), Risk_Indicators.Key_Address_Table_v4,
			keyed(left.zip = right.zip) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.sec_range = right.sec_range or left.sec_range =''),
			addVelocity(left, right),Left Outer,
				keep(1));

		//Append ADVO data
		layout_ADVO addADVO(Cleaned l, Advo.Key_Addr1 r) := transform
			self.acctno := l.acctno;
			self.geolink := l.geolink;
			self.address_vacancy_indicator := r.address_vacancy_indicator;
			self.dnd_indicator := r.dnd_indicator;
			self.Record_Type_Code := r.Record_Type_Code;
			self.Seasonal_Delivery_Indicator := r.Seasonal_Delivery_Indicator;
			self.College_Indicator := r.College_Indicator;
			self.Address_Style_Flag := r.Address_Style_Flag;
			self.Residential_or_Business_Ind := r.Residential_or_Business_Ind;
			self.Address_Type := r.Address_Type;
			self.Mixed_Address_Usage := r.Mixed_Address_Usage;
			self := l;
		end;
			
		single_ADVO := join(Cleaned(zip !='' and st !='' and prim_name !=''), Advo.Key_Addr1,
			keyed(left.zip = right.zip) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.suffix = right.addr_suffix) and
			keyed(left.predir = right.predir or left.predir = '') and
			keyed(left.postdir = right.postdir or left.postdir = ''),
			addADVO(left, right),Left Outer,
				keep(1));

		//Append EASI Data
		layout_Census addEASI(Cleaned l, Easi.Key_Easi_Census r) := transform
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;
		Census := join(Cleaned(geolink != ''), Easi.Key_Easi_Census,
			keyed(left.geolink = right.geolink),
			addEASI(left, right),Left Outer,
				keep(1));

		//Find and Sort Foreclosure Data by address
		layout_Foreclosure addAddrOnlyForeclosures(Cleaned l, dx_property.key_foreclosures_addr r) := TRANSFORM
			self.data_date := if(r.filing_date >= r.recording_date, r.filing_date, r.recording_date);
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;

		Find_Foreclosure_By_Addr := join(Cleaned(zip != '' and prim_name != ''), dx_property.key_foreclosures_addr, 
			keyed(left.zip = right.situs1_zip) and
			keyed(left.prim_range = right.situs1_prim_range) and
			keyed(left.prim_name = right.situs1_prim_name) and
			keyed(left.suffix = right.situs1_addr_suffix) and 
			keyed(left.predir = right.situs1_predir or left.predir = ''),
			addAddrOnlyForeclosures(left, right),Left Outer);

		Foreclosures := sort(Find_Foreclosure_By_Addr, -data_date);

		//Find vehicle records by address
		Layout_Vehicle addVehicleData(Cleaned l, address_attributes.key_vehicles_addr r) := transform
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;
		Find_Vehicles_Addr := join(Cleaned(zip != '' and prim_name != ''), address_attributes.key_vehicles_addr, 
			keyed(left.zip = right.zip5) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.suffix = right.suffix or right.suffix ='') and
			keyed(left.predir = right.predir or left.predir = ''),
			addVehicleData(left, right),Left Outer, KEEP(200));

		bigVehiclesList := Find_Vehicles_Addr(orig_vehicle_type_code IN ['M','P'], vina_body_style in Address_Attributes.functions.filterVehicle, is_minor =false); //filter to vehicles and ensure no minors are present
		finalVehicles := dedup(sort(bigVehiclesList, -acctno, -sequence_key, orig_vin), orig_vin); 	//reduce to single VINs
		protoVehicles := project(cleaned, transform(Layout_Vehicles, self := left; self :=[]));
		
		Layout_Vehicles fillVehicleData(Layout_Vehicles l, Layout_Vehicle r, integer seq) := transform	
			self.acctno := l.acctno;
			self.fuel_type1 		:= if(seq=1, Address_Attributes.functions.getFuelType(r.state_origin, r.VINA_Fuel_Code), l.fuel_type1);
			self.fuel_type2 		:= if(seq=2, Address_Attributes.functions.getFuelType(r.state_origin, r.VINA_Fuel_Code), l.fuel_type2);
			self.fuel_type3 		:= if(seq=3, Address_Attributes.functions.getFuelType(r.state_origin, r.VINA_Fuel_Code), l.fuel_type3);
			self.fuel_type4 		:= if(seq=4, Address_Attributes.functions.getFuelType(r.state_origin, r.VINA_Fuel_Code), l.fuel_type4);
			
			self.vehicle_code1 	:= if(seq=1, Address_Attributes.functions.getBodyType(r.best_body_code), l.vehicle_code1);			
			self.vehicle_code2 	:= if(seq=2, Address_Attributes.functions.getBodyType(r.best_body_code), l.vehicle_code2);			
			self.vehicle_code3 	:= if(seq=3, Address_Attributes.functions.getBodyType(r.best_body_code), l.vehicle_code3);
			self.vehicle_code4 	:= if(seq=4, Address_Attributes.functions.getBodyType(r.best_body_code), l.vehicle_code4);
		end;

		norm_vehicles := DENORMALIZE(protoVehicles, finalVehicles, 
																 left.acctno = right.acctno, 
																 fillVehicleData(left,right,counter)); 

		/////////////////BUILD FINAL////////////////////
		address_attributes.Layouts.final_SmartGrid addCleaned(Cleaned l) := TRANSFORM
			self := l;
			self := [];
		End;
		CleanedFinal := project(Cleaned, addCleaned(Left));

		//Append Valuation Data
		address_attributes.Layouts.final_SmartGrid addValuationFinal(CleanedFinal l, Valuation r) := transform
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;

		ValuationFinal := join(CleanedFinal, Valuation,
			(left.acctno = right.acctno),
			addValuationFinal(left, right),Left Outer, keep(1));

		//Append Property V2 Data
		address_attributes.Layouts.final_SmartGrid addPropertyFinal(ValuationFinal l, Hedonics r) := transform
			self.acctno := l.acctno;
			self := r;
			self := l;
		end;

		HedonicsFinal := join(ValuationFinal, Hedonics,
			(left.acctno = right.acctno),
			addPropertyFinal(left, right),Left Outer, keep(1));

		//Append Velocity data
		address_attributes.Layouts.final_SmartGrid AddVelocityFinal(HedonicsFinal l, Velocity r) := transform
			self.acctno := l.acctno;			
			self := r;
			self := l;
		end;

		VelocityFinal := join(HedonicsFinal, Velocity,
			(left.acctno = right.acctno),
			addVelocityFinal(left, right),Left Outer, keep(1));

		//Append ADVO data
		address_attributes.Layouts.final_SmartGrid addADVOFinal(VelocityFinal l, single_ADVO r) := transform
			self.acctno := l.acctno;			
			self := r;
			self := l;
		end;
			
		ADVOFinal := join(VelocityFinal, single_ADVO,
			(left.acctno = right.acctno),
			addADVOFinal(left, right),Left Outer, keep(1));

		//Append EASI Data
		address_attributes.Layouts.final_SmartGrid addEASIFinal(ADVOFinal l, Census r) := transform
			self.acctno := l.acctno;			
			self := r;
			self := l;
		end;
		CensusFinal := join(ADVOFinal, Census,
			(left.acctno = right.acctno),
			addEASIFinal(left, right),Left Outer, keep(1));

		//Append Foreclosure data
		address_attributes.Layouts.final_SmartGrid addAddrOnlyForeclosuresFinal(CensusFinal l, Foreclosures r) := TRANSFORM
			self.acctno := l.acctno;			
			self := r;
			self := l;
		end;
		ForeclosureFinal := join(CensusFinal, Foreclosures, 
			(left.acctno = right.acctno),
			addAddrOnlyForeclosuresFinal(left, right),Left Outer, 
				keep(1));

		//Append Vehicle Data
		address_attributes.Layouts.final_SmartGrid addVehiclesFinal(ForeclosureFinal l, norm_vehicles r) := TRANSFORM
			self.acctno := l.acctno;			
			self := r;
			self := l;
		end;
		Final_Result_pre := join(ForeclosureFinal, norm_vehicles, 
			(left.acctno = right.acctno),
			addVehiclesFinal(left, right),Left Outer, keep(1));

//Trap incomplete inputs		
		address_attributes.Layouts.final_SmartGrid moveData(indata l) := transform
			//echo input
			self.acctno := l.acctno;
			self.street_address_in := l.street_address;
			self.apt_in := l.apt;
			self.city_in := l.city;
			self.state_in := l.state;
			self.zip_in := l.zip;
			self.zip4_in := l.zip4;			
			self := l;
			self := [];
		end;
		
		BadTrans := project(indata(acctno = '' OR street_address = '' OR city = '' OR state = '' OR zip = ''), moveData(Left));
		
		Final_Result := BadTrans + Final_Result_pre;
		// output(valuation, named('valuation'));
		// output(hedonics, named('hedonics'));
		// output(velocity, named('velocity'));
		// output(single_advo, named('single_advo'));
		// output(census, named('census'));
		// output(foreclosures, named('foreclosures'));
		// output(norm_vehicles, named('vehicles'));			
		Return Final_Result;

END;