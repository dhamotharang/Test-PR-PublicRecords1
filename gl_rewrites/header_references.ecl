export header_references(
	gl_rewrites.person_interfaces.i__header_references in_parms) :=
		function
			fetched_did := if(
				(unsigned8)in_parms.did_value <> 0,
				gl_rewrites.Fetch_Header_Did(in_parms));
			Fetched_dups := MAP(
				exists(fetched_did) =>
					fetched_did,
				(unsigned8)in_parms.rid_value <> 0 =>
					gl_rewrites.Fetch_Header_Rid(in_parms),
				length(trim(in_parms.ssn_value)) = 9 =>
					if(
						in_parms.score_threshold_value > 10,
						gl_rewrites.Fetch_header_ssn(in_parms) +
						gl_rewrites.Fetch_header_StNameSmall(in_parms),
						gl_rewrites.Fetch_header_ssn(in_parms)),
				in_parms.phone_value <> '' =>
					gl_rewrites.Fetch_Header_Phone(in_parms),
				in_parms.pname_value <> '' AND
				in_parms.zip_value <> [] AND
				(
					in_parms.prange_value = '' OR
					in_parms.addr_error_value OR
					in_parms.addr_loose) =>
					gl_rewrites.Fetch_Header_Street(in_parms),
				in_parms.pname_value <> '' AND
				(in_parms.prange_value <> '' or in_parms.lname_value = '') AND
				(~in_parms.addr_error_value or in_parms.addr_loose) =>
					gl_rewrites.Fetch_Address(in_parms) +
					IF(
						in_parms.any_addr_error_value,
						gl_rewrites.Fetch_Header_Zip(in_parms)),
				in_parms.lname4_value <> '' =>
					gl_rewrites.Fetch_Header_DA(in_parms),
				in_parms.lname_value = '' =>
					gl_rewrites.Fetch_Header_FnameSmall(in_parms),
				in_parms.zip_value <> [] =>
					gl_rewrites.Fetch_Header_Zip(in_parms),
				in_parms.city_value = '' AND in_parms.state_value = '' =>
					gl_rewrites.Fetch_Header_Name(in_parms),
				in_parms.city_value = '' =>
					gl_rewrites.Fetch_Header_StFLName(in_parms),
				gl_rewrites.Fetch_Header_StCityFLName(in_parms));

			fetched := dedup(Fetched_dups,all);

			adv_references := if(
				in_parms.is_wildcard_search and in_parms.allow_wildcard_val,
				gl_rewrites.header_wild_references(in_parms),
				fetched);

			bd := if(
				in_parms.use_OnlyBestDID,
				gl_rewrites.get_onlyBestDID(in_parms,adv_references),
				adv_references);
			
			return bd;
		END;
		