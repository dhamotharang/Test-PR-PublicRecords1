import avm_v2, address, ut;

export append_AVM_function(DATASET(Layout_PropHistory_In) inData, BOOLEAN doAVM) := function

	merged_rec := record
		Layout_PropHistory_In.seq;
		avm_v2.key_avm_apn;
	end;
	
	merged_rec getAddr(inData L, avm_v2.Key_AVM_Address R) := transform
		self.seq := L.seq;
		self := R;
	end;
	
	addrkey := join(inData, avm_v2.Key_AVM_Address,
					left.prim_name!='' and left.in_zipcode!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.in_state = right.st) and
					keyed(left.in_zipcode = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range = right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir,
				  getAddr(LEFT,RIGHT), left outer, LIMIT (10000)); // there can be spikes more than 10K
				  			  			  
	merged_rec getAPN(inData l, avm_v2.Key_AVM_APN r) := transform
		self.seq := l.seq;
		self := r;
	end;
	apnkey := join(inData, avm_v2.Key_AVM_APN,
					keyed(left.in_fares_unformatted_apn = right.unformatted_apn)
					and (left.in_zipcode = '' or left.in_Zipcode = right.Zip),					
					getAPN(LEFT,RIGHT), left outer, LIMIT (10000)); // there can be spikes more than 10K
					
	// when choosing which AVM to output if the addr or apn return more than 1 result, 
	// always pick the record with the most information populated, and the most recent record as secondary qualifier
	all_avms := group(sort(addrkey + apnkey, seq, -prim_name, -unformatted_apn, -recording_date), seq);
	avms := rollup(all_avms, true, transform(merged_rec, self := left));
	

		
	avm_out := record
		Layout_PropHistory_In.seq;
		avm_v2.layouts.layout_value_fields;
	end;
	
	land_use_map(string1 land_use) := function
		lu_desc := map(land_use = '1' => 'Single Family Dwelling',
					   land_use = '2' => 'Condominium/Townhouse',
					   '');
		return lu_desc;
	end;
	
	temp_hedonic := record
		integer cntr;
		avm_v2.layouts.layout_property_hedonic;
	end;
	
	get_prop_details(string12 fid, string subj_lat, string subj_long, integer cntr) := function
		prop := if(fid!='', choosen(avm_v2.Key_Hedonic_Comps_FID(keyed(ln_fares_id=fid)), 1), dataset([], recordof(avm_v2.Key_Hedonic_Comps_FID)) );
		prop_out := project(prop, transform(temp_hedonic,
											self.cntr := cntr,
											self.address := address.Addr1FromComponents(left.prim_range,left.predir,left.prim_name,
																			left.suffix,left.postdir,left.unit_desig,left.sec_range),
											self.city := left.p_city_name,
											self.distance := ut.LL_Dist((real)subj_lat, (real)subj_long, (real)left.lat, (real)left.long),
											self.land_use_description := land_use_map(left.land_use_code),
											self.lot_size := left.lot_size,
											self := left));
		return prop_out;
	end;
	
	avm_out add_hedonic_property_details(avms le) := transform
		c1 := get_prop_details(le.comp1, le.lat, le.long, 1);
		c2 := get_prop_details(le.comp2, le.lat, le.long, 2);
		c3 := get_prop_details(le.comp3, le.lat, le.long, 3);
		c4 := get_prop_details(le.comp4, le.lat, le.long, 4);
		c5 := get_prop_details(le.comp5, le.lat, le.long, 5);
		self.comparable := project( sort( c1 + c2 + c3 + c4 + c5, cntr), transform(avm_v2.layouts.layout_property_hedonic, self := left) );
		
		n1 := get_prop_details(le.nearby1, le.lat, le.long, 1);
		n2 := get_prop_details(le.nearby2, le.lat, le.long, 2);
		n3 := get_prop_details(le.nearby3, le.lat, le.long, 3);
		n4 := get_prop_details(le.nearby4, le.lat, le.long, 4);
		n5 := get_prop_details(le.nearby5, le.lat, le.long, 5);
		self.nearby := project( sort( n1 + n2 + n3 + n4 + n5, cntr), transform(avm_v2.layouts.layout_property_hedonic, self := left) );
		
		self.land_use_code := le.land_use;
		self.land_use_description := land_use_map(le.land_use);
		self := le;
	end;
	
	avm_append := project(avms, add_hedonic_property_details(left));
	
	
		// output(apnkey, named('APN_Key'));
 // output(addrkey, named('Addr_Key'));
 
    // output(avms, named('phf_avms'));
	 // output(avm_append, named('phf_avms'));
	
	// output(indata, named('indata') );
	// output(emptyResults, named('emptyResults'));
	// output(withPropValue, named('withPropValue'));
	
	return if(doAVM, ungroup(avm_append), dataset([], avm_out));

end;
