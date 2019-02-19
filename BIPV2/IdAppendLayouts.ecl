import BIPV2;

export IdAppendLayouts := module
	
	// Using commonbase_mod instead of commonbase to avoid large number of code dependencies.
	shared baseLayout := BIPV2.CommonBase_mod.Layout;

	export appendInput := {
		unsigned request_id,
	  baseLayout.company_name,
	  baseLayout.prim_range,
	  baseLayout.prim_name,
	  baseLayout.sec_range,
	  typeof(baseLayout.p_city_name) city,
	  typeof(baseLayout.st) state,
	  typeof(baseLayout.zip) zip5,
		unsigned3 zip_radius_miles := 0;
	  typeof(baseLayout.company_phone) phone10,
	  typeof(baseLayout.company_fein) fein,
	  typeof(baseLayout.company_url) url,
	  typeof(baseLayout.contact_email) email,
	  typeof(baseLayout.fname) contact_fname,
	  typeof(baseLayout.mname) contact_mname,
	  typeof(baseLayout.lname) contact_lname,
	  baseLayout.contact_ssn,
		baseLayout.contact_did,
	  typeof(baseLayout.company_sic_code1) sic_code,
		baseLayout.source,
		baseLayout.source_record_id,
		baseLayout.proxid,
		baseLayout.seleid,
	};

	export IdsOnly := {
		appendInput.request_id,
		BIPV2.IDlayouts.l_xlink_ids,
	};

	// Error code and message added to capture soapcall errors.
	export IdsOnlyOutput := {
		appendInput.request_id,
		BIPV2.IDlayouts.l_xlink_ids,
		integer error_code := 0,
		string error_msg := '',
	};

	// This is the layout returned by BizLinkFull.svcAppend service. If Best is not requested,
	// then only the ids will be populated.
	export svcAppendOut := {
		appendInput.request_id,
		BIPV2.IdLayouts.l_xlink_ids,
		boolean isActive,
		boolean isDefunct,
		baseLayout.company_name,
		baseLayout.prim_range,
		baseLayout.predir,
		baseLayout.prim_name,
		baseLayout.addr_suffix,
		baseLayout.postdir,
		baseLayout.unit_desig,
		baseLayout.sec_range,
		baseLayout.p_city_name,
		baseLayout.v_city_name,
		baseLayout.st,
		baseLayout.zip,
		baseLayout.zip4,
		baseLayout.company_phone,
		baseLayout.company_fein,
		baseLayout.company_url,
		baseLayout.company_incorporation_date,
		baseLayout.duns_number,
		baseLayout.company_sic_code1,
		baseLayout.company_naics_code1,
	};

	// BizLinkFull.svcAppend service also returns a dataset of this layout to return the header records.
	export svcAppendRecsOut := {
		appendInput.request_id,
		IdsOnly or baseLayout,
	};

	// Error code and message added to capture soapcall errors.
	export AppendOutput := {
		svcAppendOut,
	  typeof(baseLayout.dba_name) dba_name,
	  typeof(baseLayout.cnp_btype) company_btype,
	  typeof(baseLayout.fname) contact_fname,
	  typeof(baseLayout.mname) contact_mname,
	  typeof(baseLayout.lname) contact_lname,
	  typeof(baseLayout.contact_job_title_derived) contact_job_title,
		baselayout.contact_did,
		integer error_code := 0,
		string error_msg := '',
	};

	// Error code and message added to capture soapcall errors.
	export AppendWithRecsOutput := {
		svcAppendRecsOut,
		integer error_code := 0,
		string error_msg := '',
	};

	export SoapRequest := {
		dataset(AppendInput) append_input {xpath('append_input/Row')},
		unsigned score_threshold {xpath('score_threshold')},
		unsigned weight_threshold {xpath('weight_threshold')},
		boolean disable_salt_force {xpath('disable_salt_force')},
		boolean prim_force_post {xpath('prim_force_post')},
		boolean use_fuzzy {xpath('use_fuzzy')},
		boolean do_zip_expansion {xpath('do_zip_expansion')},
		boolean re_append {xpath('re_append')},
		boolean from_thor {xpath('from_thor')},

		boolean include_best {xpath('include_best')},
		boolean all_best {xpath('all_best')},
		string fetch_level {xpath('fetch_level')},

		boolean include_records {xpath('include_records')},
	};

end;