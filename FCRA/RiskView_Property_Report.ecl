/*--SOAP--
<message name="RiskView_Property_Report">
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City"  type="xsd:string"/>
	<part name="State"  type="xsd:string"/>
	<part name="Zip"  type="xsd:string"/>
 </message>
*/
/*--INFO-- Search FCRA propery data.  Returns Assessment, Deed and AVM */

IMPORT address, ln_propertyv2, riskwise, avm_v2, codes, risk_indicators;

export RiskView_Property_Report := MACRO

	STRING120 streetLine 	:= '' 	: STORED('StreetAddress');
	STRING25	city			:= ''	: STORED('City');
	STRING2	st			:= ''	: STORED('State');
	STRING5	zip5			:= ''	: STORED('Zip');

	in_base := DATASET([{1}], {INTEGER seq});
	
	in_rec := record
		UNSIGNED4	seq;		
		STRING120 in_streetAddress;
		STRING25 in_city;
		STRING2 in_state;
		STRING5 in_zipCode;
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING2  st;
		STRING5  z5;
		STRING4  zip4;
	end;
	
	in_rec clean_addr(in_base l) := TRANSFORM
		STRING182 clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(streetLine, city, st, zip5);
		
		SELF.seq 			:= l.seq;
		SELF.in_streetAddress := streetLine;
		SELF.in_city 		:= city;
		SELF.in_state 		:= St;
		SELF.in_zipCode 	:= zip5;
		SELF.prim_range 	:= clean_addr[1..10];
		SELF.predir 		:= clean_addr[11..12];
		SELF.prim_name 	:= clean_addr[13..40];
		SELF.addr_suffix 	:= clean_addr[41..44];
		SELF.postdir 		:= clean_addr[45..46];
		SELF.unit_desig 	:= clean_addr[47..56];
		SELF.sec_range 	:= clean_addr[57..64];
		SELF.p_city_name := clean_addr[90..114];
		SELF.st := clean_addr[115..116];
		SELF.z5 := clean_addr[117..121];
		SELF.zip4 := clean_addr[122..125];
	END;
	
	inData := PROJECT(in_base, clean_addr(LEFT));

	valid_input := indata(prim_name!='' and z5!='');
	
	lookup_layout := RECORD
		integer seq;
		STRING12	ln_fares_id;
	END;

	byAddr := JOIN(valid_input, 
				LN_PropertyV2.key_addr_fid(true),
					keyed(LEFT.prim_name=RIGHT.prim_name) AND
					keyed(LEFT.prim_range=RIGHT.prim_range) AND
					keyed(LEFT.z5=RIGHT.zip) AND
					keyed(LEFT.predir=RIGHT.predir) AND
					keyed(LEFT.postdir=RIGHT.postdir) AND
					keyed(LEFT.addr_suffix=RIGHT.suffix) AND
					keyed(LEFT.sec_range=RIGHT.sec_range)and
					keyed(right.source_code_2 = 'P'),
				transform(lookup_layout, self.seq := left.seq, self := right), atmost(riskwise.max_atmost), keep(500));
											
	ids := DEDUP(SORT(byAddr,seq, ln_fares_id), seq, ln_fares_id);
	
	asessor_key := recordof(ln_propertyv2.key_assessor_fid(true));
	assessment_layout := RECORD
		integer seq;
		// ln_propertyv2.layout_property_common_model_base - vendor_source_flag; // remove 1 character vendor source flag to use the 5 character version
		asessor_key - vendor_source_flag; // remove 1 character vendor source flag to use the 5 character version
		string5	vendor_source_flag;
		
		string75	standardized_land_use_desc := '';         
		string10	building_area_desc := '';  
		string25	garage_desc := '';
		string25	pool_desc := '';
		string30	style_desc := '';
		string30 	type_construction_desc := '';
		string30 	exterior_walls_desc := '';
		string15 	foundation_desc := '';
		string20 	basement_desc := '';
		string25 	roof_cover_desc := '';
		string20	roof_type_desc := '';
		string20 	heating_desc := '';
		string10 	heating_fuel_type_desc := '';
		string20 	air_conditioning_desc := '';
	end;
		
	assessments := JOIN(ids, 
					ln_propertyv2.key_assessor_fid(true),
					KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id) and left.ln_fares_id[2]='A',
					transform(assessment_layout, self.seq := left.seq, 
								self.vendor_source_flag  := map(right.vendor_source_flag='F' => 'FAR_F',
										right.vendor_source_flag='S' => 'FAR_S',
										right.vendor_source_flag='O' => 'OKCTY',
										right.vendor_source_flag='D' => 'DAYTN',
										'');
								self := right), atmost(riskwise.max_atmost), keep(500));
	// output(assessments, named('assessments'));
	
	// make dedup more deterministic
	lastAssessment := DEDUP(SORT(assessments, seq, -assessed_value_year, -market_value_year, -recording_date, ln_fares_id), seq);
	// output(lastAssessment, named('lastAssessment'));
	
	deed_key := recordof(ln_propertyv2.key_deed_fid(true));
	deeds_layout := RECORD
		integer seq;
		// LN_PropertyV2.layout_deed_mortgage_common_model_base - vendor_source_flag;  // remove 1 character vendor source flag to use the 5 character version
		deed_key - vendor_source_flag; // remove 1 character vendor source flag to use the 5 character version
		string5	vendor_source_flag;
	end;
	
	deeds := JOIN (ids, ln_propertyv2.key_deed_fid(true),
               keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id[2]='D',
               TRANSFORM (deeds_layout, self.seq := left.seq, self := right), atmost(riskwise.max_atmost), keep(500));
	// output(deeds, named('deeds'));
	
	// make dedup more deterministic
	lastDeed := DEDUP(SORT(deeds, seq, -recording_date, ln_fares_id), seq);
	// output(lastDeed, named('lastDeed'));
	
	avm_rec := record
		integer seq;
		avm_v2.Key_AVM_Address_FCRA;
	end;
		
	avm_addr := join(valid_input, avm_v2.Key_AVM_Address_FCRA,
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range = right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir,
				  transform(avm_rec, self.seq := left.seq, self := right), atmost(riskwise.max_atmost), keep(500));
				  			  			  
					
	// when choosing which AVM to output if the addr returns more than 1 result, 
	// always pick the record with the most information populated, and the most recent record as secondary qualifier
	avm_data := dedup(sort(avm_addr, seq, -prim_name, -unformatted_apn, -recording_date), seq);
	// output(avm_data, named('avm_data'));
	
	
	avm_slim_rec := record
		integer automated_valuation;
		integer confidence_score;
	end;
	
	combined_rec_working := record
		integer seq;
		string5 vendor_source_flag;
		string30	county_name;
		string45	apn_or_pin_number;
		string30	legal_city_municipality_township;
		string40	legal_subdivision_name;
		string130	legal_brief_description;
		string4	standardized_land_use_code;
		string75	standardized_land_use_desc := '';  
		string1	owner_occupied;
		string8	sales_date;  // changed from recording_date to sales_date on final output
		string11	sales_price;
		string11	assessed_land_value;
		string11	assessed_improvement_value;
		string11	assessed_total_value;
		string4	assessed_value_year;
		string11	market_land_value;
		string11	market_improvement_value;
		string11	market_total_value;
		string4	market_value_year;
		string13	tax_amount;
		string4	tax_year;
		string30	land_acres;
		string30	land_square_footage;
		string30  land_dimensions;
		string9	building_area;    
		string1	building_area_indicator;
		string10	building_area_desc := '';  	
		string4	year_built;
		string3	no_of_buildings;
		string5	no_of_stories;
		string5	no_of_units;
		string5	no_of_rooms;
		string5	no_of_bedrooms;
		string8	no_of_baths;
		string5	parking_no_of_cars;
		string3	garage_type_code;
		string25	garage_desc := '';		
		string3	pool_code;
		string25	pool_desc := '';
		string5	style_code;
		string30	style_desc := '';
		string3	type_construction_code;
		string30 	type_construction_desc := '';
		string3	exterior_walls_code;
		string30 	exterior_walls_desc := '';
		string3	foundation_code;
		string15 	foundation_desc := '';
		string3	roof_cover_code;
		string25 	roof_cover_desc := '';
		string5	roof_type_code;
		string20	roof_type_desc := '';
		string3	heating_code;
		string20 	heating_desc := '';
		string3	heating_fuel_type_code;
		string10 	heating_fuel_type_desc := '';
		string3	air_conditioning_code;
		string20 	air_conditioning_desc := '';
		string3	basement_code;
		string20 	basement_desc := '';
		string1	fireplace_indicator;
	end;
	
	combined_rec := record
		// remove any codes we don't need to return if we return descriptions instead
		combined_rec_working - seq - vendor_source_flag
			- standardized_land_use_code
			- building_area_indicator
			- garage_type_code		
			- pool_code
			- style_code
			- type_construction_code
			- exterior_walls_code
			- foundation_code
			- roof_cover_code
			- roof_type_code
			- heating_code
			- heating_fuel_type_code
			- air_conditioning_code
			- basement_code ;		
	end;
		
	master_rec := record
		boolean hit := false;
		in_rec input;
		avm_slim_rec avm;
		combined_rec property_info;
	end;
	
	j1 := join(indata, avm_data, left.seq=right.seq, 
										transform(master_rec, 
															self.hit := right.seq <> 0,
															self.input := left, 
															self.avm := right, self := []), left outer, lookup);
	// output(j1, named('with_avm'));
	
	combined_rec_working combine_prop(lastassessment le, lastdeed rt) := transform
		self.seq := if(le.seq=0, rt.seq, le.seq);
		self.county_name := if(le.county_name='', rt.county_name, le.county_name);
		self.apn_or_pin_number := if(le.apna_or_pin_number='', rt.apnt_or_pin_number, le.apna_or_pin_number);
		self.legal_city_municipality_township := if(le.legal_city_municipality_township='', 
				rt.legal_city_municipality_township, le.legal_city_municipality_township);
		self.legal_subdivision_name := if(le.legal_subdivision_name='', rt.legal_subdivision_name, le.legal_subdivision_name);
		self.legal_brief_description := if(le.legal_brief_description='', rt.legal_brief_description, le.legal_brief_description);
		self.standardized_land_use_code := if(le.standardized_land_use_code='', rt.assessment_match_land_use_code, le.standardized_land_use_code);
		
		// pick the most recent recording_date data, default to deed record for sale price and recording date
		use_ta := (unsigned)le.recording_date > (unsigned)rt.recording_date;
		self.sales_date := if(use_ta, le.recording_date, rt.recording_date);
		self.sales_price := if(use_ta, le.sales_price, rt.sales_price);
		
		self := le;
	end;
	
	j2 := join(lastassessment, lastdeed, left.seq=right.seq, combine_prop(left,right),full outer);
	// output(j2, named('j2'));
	
Codes.Mac_GetPropertyCode(j2,CD1,Codes.Key_Codes_V3, 'FARES_2580','STANDARDIZED_LAND_USE_CODE',	standardized_land_use_code,standardized_land_use_desc);
Codes.Mac_GetPropertyCode(CD1,CD2,Codes.Key_Codes_V3, 'FARES_2580','BUILDING_AREA_INDICATOR', BUILDING_AREA_INDICATOR , BUILDING_AREA_DESC);	
Codes.Mac_GetPropertyCode(CD2,CD3,Codes.Key_Codes_V3, 'FARES_2580','GARAGE',GARAGE_TYPE_CODE , GARAGE_DESC);	
Codes.Mac_GetPropertyCode(CD3,CD4,Codes.Key_Codes_V3, 'FARES_2580','POOL_CODE',	POOL_CODE , POOL_DESC);	
Codes.Mac_GetPropertyCode(CD4,CD5,Codes.Key_Codes_V3, 'FARES_2580','STYLE',	STYLE_CODE , STYLE_DESC);	
Codes.Mac_GetPropertyCode(CD5,CD6,Codes.Key_Codes_V3, 'FARES_2580','TYPE_CONSTRUCTION_CODE', TYPE_CONSTRUCTION_CODE , TYPE_CONSTRUCTION_DESC);	
Codes.Mac_GetPropertyCode(CD6,CD7,Codes.Key_Codes_V3, 'FARES_2580','EXTERIOR_WALLS', EXTERIOR_WALLS_CODE , EXTERIOR_WALLS_DESC);	
Codes.Mac_GetPropertyCode(CD7,CD8,Codes.Key_Codes_V3, 'FARES_2580','FOUNDATION', FOUNDATION_CODE , FOUNDATION_DESC);	
Codes.Mac_GetPropertyCode(CD8,CD9,Codes.Key_Codes_V3, 'FARES_2580','BASEMENT_CODE', BASEMENT_CODE , BASEMENT_DESC);	
Codes.Mac_GetPropertyCode(CD9,CD10,Codes.Key_Codes_V3, 'FARES_2580','ROOF_COVER', ROOF_COVER_CODE , ROOF_COVER_DESC);	
Codes.Mac_GetPropertyCode(CD10,CD11,Codes.Key_Codes_V3, 'FARES_2580','ROOF_TYPE', ROOF_TYPE_CODE , ROOF_TYPE_DESC);	
Codes.Mac_GetPropertyCode(CD11,CD12,Codes.Key_Codes_V3, 'FARES_2580','HEATING',HEATING_CODE , HEATING_DESC);	
Codes.Mac_GetPropertyCode(CD12,CD13,Codes.Key_Codes_V3, 'FARES_2580','HEATING_FUEL_TYPE_CODE', HEATING_FUEL_TYPE_CODE , HEATING_FUEL_TYPE_DESC);	
Codes.Mac_GetPropertyCode(CD13,with_descriptions,Codes.Key_Codes_V3, 'FARES_2580','AIR_CONDITIONING',AIR_CONDITIONING_CODE , AIR_CONDITIONING_DESC);	
// OUTPUT(with_descriptions, named('with_descriptions'));
	
	
	final := join(j1, with_descriptions, left.input.seq=right.seq, 
				transform(master_rec, 
										self.hit := if(right.seq<>0, true, left.hit),
										self.property_info := right,
									  self := left), left outer, keep(1));
	
output(final, named('Results'));

endmacro;

// fcra.RiskView_Property_Report();
