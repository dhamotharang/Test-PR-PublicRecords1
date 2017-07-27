
ta_base1 := avm.File_TA_BaseTable;
ta_base := distribute(ta_base1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));

// sort by tax year desc to retain the most recent tax year record
ta_sorted := sort(ta_base, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range,-assessed_value_year, local); 
ta_deduped := dedup(ta_sorted, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range, local); 

ta_update := avm.File_TA_UpdateTable;


layout_ta_record := record
	string12 ln_fares_id;
	string45  unformatted_apn;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  zip;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string3  county := '';
	string7  geo_blk := '';
	string5 fips_code;
	string1 land_use;
	string11 sales_price;
	string8 recording_date;	
	string4 assessed_value_year;
	string11 assessed_total_value;
	string11 market_total_value;
	real value_to_saleprice_ratio;
	integer Tax_Assessment_Valuation;
end;


layout_ta_record add_valuation(ta_deduped le, ta_update rt) := transform
	self.land_use := le.land_use_code;
	// check against assessed bin caps first... if there are no assessment bins, use market bin caps if market value total is present on the TA record
	bin := map((integer)le.assessed_total_value<>0 and (integer)le.assessed_total_value <= (integer)rt.assess_bin1_cap => 'A1',
					  (integer)le.assessed_total_value<>0 and (integer)le.assessed_total_value <= (integer)rt.assess_bin2_cap => 'A2',
					  (integer)le.assessed_total_value<>0 and (integer)le.assessed_total_value <= (integer)rt.assess_bin3_cap => 'A3',
					  (integer)le.assessed_total_value<>0 and (integer)rt.assess_bin3_cap<>0 => 'A4',
					  (integer)le.market_total_value<>0 and (integer)le.market_total_value <= (integer)rt.market_bin1_cap => 'M1',
					  (integer)le.market_total_value<>0 and (integer)le.market_total_value <= (integer)rt.market_bin2_cap => 'M2',
					  (integer)le.market_total_value<>0 and (integer)le.market_total_value <= (integer)rt.market_bin3_cap => 'M3',
					  (integer)le.market_total_value<>0 and (integer)rt.market_bin3_cap<>0 => 'M4',
					  '');
	ratio := map(bin='A1' => rt.assessed_value_to_saleprice_ratio1,
				 bin='A2' => rt.assessed_value_to_saleprice_ratio2,
				 bin='A3' => rt.assessed_value_to_saleprice_ratio3, 
				 bin='A4' => rt.assessed_value_to_saleprice_ratio4, 	
				 bin='M1' => rt.market_value_to_saleprice_ratio1,
				 bin='M2' => rt.market_value_to_saleprice_ratio2,
				 bin='M3' => rt.market_value_to_saleprice_ratio3,
				 bin='M4' => rt.market_value_to_saleprice_ratio4,
				 0);
	self.Tax_Assessment_Valuation := map(bin[1]='A' => (integer)le.assessed_total_value * ratio,
										 bin[1]='M' => (integer)le.market_total_value * ratio,
										 0);
	self.value_to_saleprice_ratio := ratio;	
	self := le;
	self := rt;
end;

with_valuation := join(ta_deduped, ta_update, left.assessed_value_year=right.assessed_value_year and 
									left.fips_code=right.fips_code and 
									left.land_use_code=right.land_use_code,
									add_valuation(left,right), left outer, lookup);
									
output(with_valuation,,'~thor_data400::avm_validate2::ta_valuations_' + thorlib.WUID(), __compressed__);

export File_TA_Valuations := with_valuation;