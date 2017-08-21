// use this script to help answer AVM questions
// 1.  Why doesn't my property get an AVM?
//     - usually the answer is that we don't have the data on the fidelity records
// 2.  Why does the AVM section show different tax values than the rest of the report?
//		-  the property report shows FARES and FIDELITY data.  AVM can only use Fidelity

#workunit('name', 'AVM Address Troubleshooter');

today := ut.GetDate;
in_addr := '610 MONTROSE AVE';
in_city := '';
in_state := '';
in_zip := '14223';

a1_val2 := in_addr;
a2_val2 := Address.Addr2FromComponents(in_city, in_state, in_zip);
clean_addr := Address.CleanAddress182(a1_val2,a2_val2);
// output(clean_addr, named('clean_address'));

a := record
	string prim_range := '';
	string predir := '';
	string prim_name := '';
	string addr_suffix := '';
	string postdir := '';
	string unit_desig := '';
	string sec_range := '';
	string p_city_name := '';
	string st := '';
	string z5 := '';
	string zip4 := '';
	string lat := '';
	string long := '';
	string addr_type := '';
	string addr_status := '';
	string county := '';
	string geo_blk := '';
	string fips_code := '';
	string county_name := '';
end;

emptyset := dataset([{''}],a);
a parseAddr(emptySet l) := transform
	self.prim_range := clean_addr[1..10];
	self.predir := clean_addr[11..12];
	self.prim_name := clean_addr[13..40];
	self.addr_suffix := clean_addr[41..44];
	self.postdir := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range := clean_addr[57..64];
	self.p_city_name := clean_addr[90..114];
	self.st := clean_addr[115..116];
	self.z5 := clean_addr[117..121];
	self.zip4 := clean_addr[122..125];
	self.lat := clean_addr[146..155];
	self.long := clean_addr[156..166];
	self.addr_type := clean_addr[139];
	self.addr_status := clean_addr[179..182];
	self.county := clean_addr[143..145];
	self.geo_blk := clean_addr[171..177];
	self.fips_code := '';
	self.county_name := '';
end;

clean_a2 := project(emptyset, parseAddr(left));
// output(clean_a2);

// with_fips := join(clean_a2, Census_Data.Key_Fips2County,
							 // LEFT.st<>'' AND LEFT.county<>'' and
					// KEYED(LEFT.st = right.state_code) and
		           // KEYED(LEFT.county = RIGHT.county_fips),
							 // transform(a, 
									// self.fips_code := trim(right.state_fips) + trim(right.county_fips),  // the key doesn't have state_fips field
									// self.county_name := right.county_name,
									// self := left,
									// self := []),
							 // LEFT OUTER, atmost(riskwise.max_atmost), keep(1));
							 
with_fips := join(clean_a2,census_data.File_Fips2County,
							left.st=right.state_code and
							left.county=right.county_fips,
							transform(a, 
									self.fips_code := trim(right.state_fips) + trim(right.county_fips),
									self.county_name := right.county_name,
									self := left,
									self := []), lookup);
output(with_fips, named('input_addr_and_fips'));


avm_addrkey := join(with_fips, avm_v2.Key_AVM_Address,
					left.prim_name!='' and left.z5!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range = right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir,
				  transform(recordof(avm_v2.Key_AVM_Address), self := right));
output(avm_addrkey, named('avm_addrkey'));

ta_update_table := dataset(ut.foreign_prod + 'thor_data400::avm_v2::ta_update_table', recordof(avm_v2.File_TA_UpdateTable), thor, __compressed__);
output(ta_update_table(fips_code in set(with_fips, fips_code)), named('TA_Update_Table'), all);

pi_median_sales := dataset(ut.foreign_prod + 'thor_data400::avm_v2::median_sales_price', recordof(avm_v2.File_PI_Median_Sales), thor, __compressed__);
output(pi_median_sales(fips_code in set(with_fips, fips_code)), named('PI_Median_Sales'), all);


layout_assessments  := RECORDOF (LN_PropertyV2.key_assessor_fid);
layout_deeds        := RECORDOF (LN_PropertyV2.key_deed_fid);

property_by_addr1 := join(with_fips, LN_PropertyV2.Key_Addr_Fid,
					LEFT.prim_name<>'' AND 
					keyed(LEFT.prim_name=RIGHT.prim_name) AND
					keyed(LEFT.prim_range=RIGHT.prim_range) AND
					keyed(LEFT.z5=RIGHT.zip) AND
					keyed(LEFT.predir=RIGHT.predir) AND
					keyed(LEFT.postdir=RIGHT.postdir) AND
					keyed(LEFT.addr_suffix=RIGHT.suffix) AND
					keyed(LEFT.sec_range=RIGHT.sec_range)and
					keyed(right.source_code_2 = 'P'),
				transform(recordof(LN_PropertyV2.key_addr_fid), self := right),
				KEEP(500));
property_by_addr := dedup(sort(property_by_addr1, ln_fares_id), ln_fares_id);
output(property_by_addr, named('property_by_addr'));	
	
assessments := JOIN (property_by_addr, LN_PropertyV2.key_assessor_fid,
                     keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
                     TRANSFORM (layout_assessments, SELF := Right));
output(assessments, named('assessments'));

a1 := assessments(ln_fares_id[1]!='R' and state_code in avm_v2.filters(today).valid_states and avm_v2.filters(today).valid_date(recording_date)
										and recording_date <= today and prior_recording_date <= today 
										);
a2 := a1(standardized_land_use_code in avm_v2.filters(today).land_use_codes
										and assessed_value_year > '2002');										
										
output(a1, named('valid_avm_assessments'));
output(a2, named('ta_valuation_assessments'));


deeds := JOIN (property_by_addr, LN_PropertyV2.key_deed_fid,
               keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
               TRANSFORM (layout_deeds, SELF := Right), limit(0));
output(deeds, named('deeds'));

d1 := deeds(ln_fares_id[1]!='R' and 
								state in avm_v2.filters(today).valid_states and 
								avm_v2.filters(today).valid_date(recording_date) and
								first_td_loan_type_code not in avm_v2.filters(today).bad_loan_type_codes and
								(integer)sales_price> avm_v2.filters(today).minimum_sale_price								
								and recording_date <= today
								);
output(d1, named('valid_avm_deeds'));



/*

// if you don't have the answer by now, run just the piece below on the 400 way to see if the property was in the build
// but possibly got removed because it was an outlier... copy the ln_fares_ids from the valid tax assessment records
base_layout := RECORD
  string12 ln_fares_id_ta;
  string12 ln_fares_id_pi;
  string45 unformatted_apn;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string10 lat;
  string11 long;
  string7 geo_blk;
  string5 fips_code;
  string1 land_use;
  string8 recording_date;
  string4 assessed_value_year;
  string11 sales_price;
  string11 assessed_total_value;
  string11 market_total_value;
  integer8 tax_assessment_valuation;
  integer8 price_index_valuation;
  integer8 automated_valuation;
  integer8 confidence_score;
  integer8 hedonic_valuation;
  string12 comp1;
  string12 comp2;
  string12 comp3;
  string12 comp4;
  string12 comp5;
  string12 nearby1;
  string12 nearby2;
  string12 nearby3;
  string12 nearby4;
  string12 nearby5;
  integer8 no_of_comps;
  integer8 comp_radius;
  real8 sum_hedonic_distance;
  real8 sum_physical_distance;
  string1 combo_flag;
END;

base_full := dataset(ut.foreign_prod + 'thor_data400::avm_v2::avm_base_full', base_layout, thor, __compressed__);	

set_fares_ids := [
'OA0349630234',
'OA0243635447',
'OA0234331810',
'OA0083279408',
'DA0269368116'];

// output(base_full(ln_fares_id_ta in set_fares_ids), named('base_full_by_fares_id'));
// output(base_full(prim_name=with_fips[1].prim_name AND
					// prim_range=with_fips[1].prim_range AND
					// zip=with_fips[1].z5 AND
					// sec_range=with_fips[1].sec_range), named('base_full_by_addr'));
					
		
			
ta_valuations := dataset(ut.foreign_prod + 'thor_data400::avm_v2::ta_valuations', recordof(AVM_V2.File_TA_Valuations), thor, __compressed__);
// output(ta_valuations(ln_fares_id in set_fares_ids), named('ta_valuations_by_fares_id'));
// output(ta_valuations(prim_name=with_fips[1].prim_name AND
					// prim_range=with_fips[1].prim_range AND
					// zip=with_fips[1].z5 AND
					// sec_range=with_fips[1].sec_range), named('ta_valuations_by_addr'));
					
					

pi_valuations := dataset(ut.foreign_prod + 'thor_data400::avm_v2::pi_valuations', recordof(AVM_V2.File_PI_Valuations), thor, __compressed__);
hedonic_valuations := dataset(ut.foreign_prod + 'thor_data400::avm_v2::hedonic_valuations', recordof(avm_v2.File_Hedonic_Valuations), thor, __compressed__);
*/
