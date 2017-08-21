EXPORT PrepDaily(dataset(Layout_Neustar) daily) := FUNCTION

	// remove dups
	daily1 := DEDUP(daily, RECORD, ALL);

	//identify no-ops: a delete and add without any changes
	sortOrder(string1 acode) := CASE(acode,
		'D' => 1, 'A' => 2, 'I' => 3, 0);
					
	daily2 := SORT(DISTRIBUTE(daily1,HASH64(record_id,record_type,telephone,listing_type,indent,
														business_name, business_captions,category,
														last_name, suffix_name, first_name, middle_name,													
														primary_street_number,pre_dir,primary_street_name,primary_street_suffix,post_dir,
														secondary_address_type, secondary_range,
														city,state,zip_code,zip_plus4,
														add_date,omit_address,data_source)
						),
						record_id,record_type,telephone,listing_type,indent,
														business_name, business_captions,category,
														last_name, suffix_name, first_name, middle_name,													
														primary_street_number,pre_dir,primary_street_name,primary_street_suffix,post_dir,
														secondary_address_type, secondary_range,
														city,state,zip_code,zip_plus4,
														add_date,omit_address,data_source,sortOrder(action_code),LOCAL);

	daily3 := ROLLUP(daily2,
									TRANSFORM(Layout_Neustar,
									self.action_code := IF(LEFT.action_code = 'D' AND RIGHT.action_code in ['A','I'],'N',LEFT.action_code);
									self := RIGHT;),
										record_id,record_type,telephone,listing_type,indent,
														business_name, business_captions,category,
														last_name, suffix_name, first_name, middle_name,													
														primary_street_number,pre_dir,primary_street_name,primary_street_suffix,post_dir,
														secondary_address_type, secondary_range,
														city,state,zip_code,zip_plus4,
														add_date,omit_address,data_source,
									LOCAL);

	return daily3;
END;