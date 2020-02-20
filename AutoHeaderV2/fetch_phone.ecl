import ut, dx_header, NID, AutoHeaderV2, lib_metaphone;

export fetch_phone (dataset (AutoHeaderV2.layouts.search) ds_search) := function
  _row := ds_search[1];

	temp_fname_value := _row.tname.fname;
	temp_lname_value := _row.tname.lname;
	temp_phone_value := _row.tphone.phone10;

	i := dx_header.key_phone();

	pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);

	res_final := project(
		LIMIT (LIMIT (i(temp_phone_value<>'',
			keyed (p7=IF(length(trim(temp_phone_value))=10,temp_phone_value[4..10],(STRING7)temp_phone_value)),
			keyed ((length(trim(temp_phone_value)) <> 10) OR p3=temp_phone_value[1..3]),
			keyed ((temp_lname_value='') OR dph_lname=(string6)metaphonelib.DMetaPhone1(temp_lname_value)[1..6]),
			keyed ((LENGTH(TRIM(temp_fname_value))<2) OR pfe(pfname,temp_fname_value))),
		ut.limits.PHONE_PER_PERSON, keyed, SKIP), 100, SKIP),
		transform (AutoHeaderV2.layouts.search_out, self.did := left.did, self.fetch_hit := AutoheaderV2.Constants.FetchHit.PHONE));

	return if(exists(res_final), res_final, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.PHONE, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;
