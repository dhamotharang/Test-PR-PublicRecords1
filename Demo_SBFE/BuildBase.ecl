//
// The process for building the base file off of which index files (keys) will be built
//
export BuildBase := function

	//
	// Imports from other modules needed
	//
	import YellowPages,Gong,Risk_Indicators,TopBusiness;
	
	//
	// Yellow Pages Input
	//
	yellow_pages := YellowPages.Files().Base.QA;

	//
	// White Pages Input
	//
	white_pages := Gong.File_History;

	//
	// Filter the White Pages data to include just businesses
	//
	white_page_businesses := white_pages(listing_type_bus = 'B');

	//
	// Transform Yellow Page data to the common layout
	//
	yellow_pages_as_common := normalize(yellow_pages,
		2,
		transform(Demo_SBFE.Layouts.Common,
			self.source := 'Y',
			self.business_name := left.business_name,
			self.street_number := left.prim_range,
			self.street_predirection := left.predir,
			self.street_name := left.prim_name,
			self.street_suffix := left.suffix,
			self.street_postdirection := left.postdir,
			self.unit_number := left.sec_range,
			self.city := choose(counter,left.p_city_name,left.v_city_name),
			self.state := left.st,
			self.zip := left.zip,
			self.phone := stringlib.StringFilter(left.phone10,'0123456789')));

	//
	// Transform White Page data to the common layout
	//
	white_pages_as_common := normalize(white_page_businesses,
		2,
		transform(Demo_SBFE.Layouts.Common,
			self.source := 'W',
			self.business_name := left.listed_name,
			self.street_number := left.prim_range,
			self.street_predirection := choose(counter,left.predir,left.v_predir),
			self.street_name := choose(counter,left.prim_name,left.v_prim_name),
			self.street_suffix := choose(counter,left.suffix,left.v_suffix),
			self.street_postdirection := choose(counter,left.postdir,left.v_postdir),
			self.unit_number := left.sec_range,
			self.city := choose(counter,left.p_city_name,left.v_city_name),
			self.state := left.st,
			self.zip := left.z5,
			self.phone := stringlib.StringFilter(left.phone10,'0123456789')));

	//
	// Combine the two
	//
	all_common_records := yellow_pages_as_common + white_pages_as_common;

	//
	// Eliminate duplicate records
	//
	unique_common_records := dedup(all_common_records,record,all);

	//
	// Filter out records that have a blank business name, street name, or zip code, or a non-10-digit phone number
	//
	filtered_common_records := unique_common_records(
		business_name != '' and street_name != '' and zip != '' and length(trim(phone)) = 10);

	//
	// Attach to each record the state associated with the phone number's area code
	//
	records_with_area_code_state := join(
		filtered_common_records,
		Risk_Indicators.Key_Telcordia_NPA_St,
		left.phone[1..3] = right.npa,
		transform(Demo_SBFE.Layouts.Entity,
			self.state_from_area_code := right.st,
			self := left,
			self := []),
		left outer,
		lookup);

	//
	// Apply an initial entity ID to each record by sequentially numbering them
	//
	records_with_sequence := project(records_with_area_code_state,
		transform(Demo_SBFE.Layouts.Entity,
			self.entity_id := counter,
			self := left));

	//
	// We'll now distribute the records based on their phone number and business name
	//
	distributed_by_phone_and_name := distribute(
		records_with_sequence,
		hash64(phone,business_name));

	//
	// Find the lowest entity ID for a given phone number-business name combination.
	//
	lowest_phone_and_name := table(
		distributed_by_phone_and_name,
		{phone,business_name,min_entity_id := min(group,entity_id)},
		phone,business_name,local);

	//
	// Now, find matches on phone number and business name
	//
	match_phone_and_name := join(
		distributed_by_phone_and_name,
		lowest_phone_and_name,
		left.phone = right.phone and
		left.business_name = right.business_name,
		transform(TopBusiness.Layout_Linking.Match,
			self.matchcode := 1,
			self.beid_low := right.min_entity_id,
			self.beid_high := left.entity_id),
		local);

	//
	// Distribute by phone number and address
	//
	distributed_by_phone_and_address := distribute(
		records_with_sequence,
		hash64(phone,street_number,street_predirection,street_name,street_suffix,street_postdirection,unit_number,city,state,zip));

	//
	// Find the lowest entity ID for a given phone number-address combination.
	//
	lowest_phone_and_address := table(
		distributed_by_phone_and_address,
		{phone,street_number,street_predirection,street_name,street_suffix,street_postdirection,unit_number,city,state,zip,min_entity_id := min(group,entity_id)},
		phone,street_number,street_predirection,street_name,street_suffix,street_postdirection,unit_number,city,state,zip,local);

	//
	// Now, find matches on phone number and address
	//
	match_phone_and_address := join(
		distributed_by_phone_and_address,
		lowest_phone_and_address,
		left.phone = right.phone and
		left.street_number = right.street_number and
		left.street_predirection = right.street_predirection and
		left.street_name = right.street_name and
		left.street_suffix = right.street_suffix and
		left.street_postdirection = right.street_postdirection and
		left.unit_number = right.unit_number and
		left.city = right.city and
		left.state = right.state and
		left.zip = right.zip,
		transform(TopBusiness.Layout_Linking.Match,
			self.matchcode := 2,
			self.beid_low := right.min_entity_id,
			self.beid_high := left.entity_id),
		local);

	//
	// Combine the match records
	//
	combined_match_records := match_phone_and_name + match_phone_and_address;

	//
	// Calculate the transitive closure of the matches
	//
	closed_match_records := TopBusiness.Function_Closure(combined_match_records,5);

	//
	// Apply the new entity IDs to the records
	//
	records_with_new_entity_ids := join(
		records_with_sequence,
		closed_match_records,
		left.entity_id = right.beid_high,
		transform(Demo_SBFE.Layouts.Entity,
			self.entity_id := if(right.beid_high = 0,left.entity_id,right.beid_low),
			self := left),
		left outer);

	//
	// The return value of this function is a set of actions that can be executed in an order that's up to the optimizer
	//
	return parallel(
		output(yellow_pages,named('YellowPages')),
		output(white_pages,named('WhitePages')),
		output(white_page_businesses,named('BusinessWhitePages')),
		output(yellow_pages_as_common,named('CommonYellowPages')),
		output(white_pages_as_common,named('CommonWhitePages')),
		output(all_common_records,named('AllCommon')),
		output(unique_common_records,named('UniqueCommonRecords')),
		output(filtered_common_records,named('FilteredCommonRecords')),
		output(records_with_area_code_state,named('AddAreaCodeState')),
		output(records_with_sequence,named('AddEntityID')),
		output(lowest_phone_and_name,named('LowestPhoneName')),
		output(match_phone_and_name,named('PhoneNameMatches')),
		output(lowest_phone_and_address,named('LowestPhoneAddress')),
		output(match_phone_and_address,named('MatchPhoneAddress')),
		output(combined_match_records,named('CombinedMatches')),
		output(closed_match_records,named('ClosedMatches')),
		output(records_with_new_entity_ids,,Filenames.Base,named('RecordsWithEntityIDs'),overwrite));

end;
