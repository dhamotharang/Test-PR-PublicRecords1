import codes, doxie_ln, doxie_raw, LN_PropertyV2, LN_PropertyV2_Services;

export asses_records(DATASET(Doxie_Raw.Layout_address_input) addrs, 
                     DATASET(layout_fid) bfids) := FUNCTION

k		:= LN_PropertyV2.key_assessor_fid();
kf	:= LN_PropertyV2.key_addl_fares_tax_fid;

rec := doxie_ln.layout_assessor_records;

string stripz(string s) := (string)((integer8)s);

rec take_right(layout_fid l, k r) := transform
	self.current := 0;  //l.current;
	self.source_code := l.source_code;  
	self.vendor_source_flag := LN_PropertyV2_Services.fn_vendor_source(r.vendor_source_flag);
  self := r;
	self := [];
  end;

addrFids := Location_Services.property_ids(addrs);
fids := dedup(sort(addrFids + bfids, fid),fid);

a := JOIN(fids(fid[2]='A'),k,left.fid=right.ln_fares_id,
          take_right(left, right), keep(1), limit(0));
					
rec addlFares(rec L, kf R) := transform
	self.fares_iris_apn													:= R.fares_iris_apn;
	self.fares_non_parsed_assessee_name					:= R.fares_non_parsed_assessee_name;
	self.fares_non_parsed_second_assessee_name	:= R.fares_non_parsed_second_assessee_name;
	self.fares_legal2														:= '';  // field not in addl fares tax layout
	self.fares_legal3														:= '';  // field not in addl fares tax layout
	self.fares_land_use													:= R.fares_land_use;
	self.fares_seller_name											:= R.fares_seller_name;
	self.fares_calculated_land_value						:= stripz(R.fares_calculated_land_value);
	self.fares_calculated_improvement_value			:= stripz(R.fares_calculated_improvement_value);
	self.fares_calculated_total_value						:= stripz(R.fares_calculated_total_value);
	self.fares_living_square_feet								:= R.fares_living_square_feet;
	self.fares_adjusted_gross_square_feet				:= stripz(R.fares_adjusted_gross_square_feet);
	self.fares_no_of_full_baths									:= R.fares_no_of_full_baths;
	self.fares_no_of_half_baths									:= R.fares_no_of_half_baths;
	self.fares_pool_indicator										:= R.fares_pool_indicator;
	self.fares_frame														:= R.fares_frame;
	self.fares_electric_energy									:= R.fares_electric_energy;
	self.fares_sewer														:= R.fares_sewer;
	self.fares_water														:= R.fares_water;
	self.fares_condition												:= R.fares_condition;
	self.land_use_decoded												:= codes.FARES_2580.land_use(l.vendor_source_flag, R.fares_land_use);
	self := L;
end;

af := join(
	a, kf,
	keyed(left.ln_fares_id=right.ln_fares_id),
	addlFares(left,right),
	left outer, keep(1), limit(0)
);

return af;

end;