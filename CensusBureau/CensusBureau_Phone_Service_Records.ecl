import address, dx_Gong;

export CensusBureau_Phone_Service_Records(
	 dataset(CensusBureau_Phone_Service_Layouts.Batch_In) in_data) := function

	// Clean the input data, provide a seq number for uniqueness
	cleaned_data := project(in_data,transform(CensusBureau_Phone_Service_Layouts.Batch_Post_In,
		self.__seq := counter,
		addressParts := address.GetCleanAddress(left.addr,trim(left.city,left,right) + ' ' + trim(left.state,left,right) + ' ' + trim(left.zip,left,right),address.Components.Country.US).str_addr;
		self.clean_address := address.CleanAddressFieldsFips(addressParts).addressrecord,
		self := left));

	// Look up EDA data by address
	key := dx_Gong.key_address_current(); // Must be current EDA

	// Filter out mismatches on ZIP, prim_name, predir, postdir, suffix
	filtered_data := cleaned_data(
		clean_address.err_stat[2] not in ['1','3','5','7','9','B','D','F'] and // no issue with ZIP
		clean_address.err_stat[3] not in ['1','3','5','7','8','9','A','B','C','D','E','F'] and // no issue with prim name or suffix
		(clean_address.predir = '' or clean_address.err_stat[3] != '2')); // don't allow predir to have been changed to anything but blank

	// Must be exact match on all parts -- including sec range being blank.
	records_from_key := join(filtered_data,key,
		keyed(left.Clean_Address.prim_name = right.prim_name) and
		keyed(left.Clean_Address.st = right.st) and
		keyed(left.Clean_Address.zip = right.z5) and
		keyed(left.Clean_Address.prim_range = right.prim_range) and
		keyed(left.Clean_Address.sec_range = right.sec_range) and
		keyed(left.Clean_Address.predir = right.predir or right.predir = '') and
		keyed(left.Clean_Address.addr_suffix = right.suffix or right.suffix = ''),
		transform(CensusBureau_Phone_Service_Layouts.Batch_Pre_Out,
			// Obviously we need the phone field
			self.phone10 := right.phone10,
			// These next one is for filtering and sorting
			self.publish_code := right.publish_code,
			// Take everything else as it was
			self := left),
		limit(10000,skip));

	// Filter out non-published
	returnable_records := records_from_key(publish_code != 'N');

	// Sort and dedup, to ensure order
	deduped_records := dedup(sort(returnable_records,__seq,record),__seq);

	// Project into final layout, using cleaned data.
	final_records := project(deduped_records,transform(CensusBureau_Phone_Service_Layouts.Batch_Out,
		self.addr := Address.Addr1FromComponents(left.Clean_Address.prim_range,left.Clean_Address.predir,left.Clean_Address.prim_name,left.Clean_Address.addr_suffix,left.Clean_Address.postdir,left.Clean_Address.unit_desig,left.Clean_Address.sec_range),
		self.city := left.Clean_Address.p_city_name,
		self.state := left.Clean_Address.st,
		self.zip := left.Clean_Address.zip,
		self.zip4 := left.Clean_Address.zip4,
		self := left));

	return final_records;

end;
