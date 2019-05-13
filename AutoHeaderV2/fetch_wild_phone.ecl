import ut,dx_header,AutoheaderV2, lib_stringlib;

export fetch_wild_phone (dataset (AutoheaderV2.layouts.search) ds_search) := function
	
	_row := ds_search[1];
	
	temp_fname_wild_val := _row.tname.fname;
	temp_lname_wild_val := _row.tname.lname;
	temp_phone_value := _row.tphone.phone10;
	
	i := dx_header.key_wild_phone();

	res_final := project(
		LIMIT (LIMIT (i(temp_phone_value<>'',
			keyed(p7=IF(length(trim(temp_phone_value))=10,temp_phone_value[4..10],(STRING7)temp_phone_value)),
			keyed ((length(trim(temp_phone_value)) <> 10) OR (p3=temp_phone_value[1..3])),
			temp_lname_wild_val = '' or stringlib.StringWildMatch(i.lname, temp_lname_wild_val, true),
			temp_fname_wild_val = '' or stringlib.StringWildMatch(i.fname, temp_fname_wild_val, true)),
	 ut.limits.PHONE_PER_PERSON, keyed, SKIP), 1000, SKIP),
	 transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_PHONE));

	return if(exists(res_final), res_final, AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_PHONE, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;
