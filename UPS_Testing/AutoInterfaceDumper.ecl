IMPORT AutoStandardI, UPS_Services, NID;

export AutoInterfaceDumper(STRING tag, UPS_Services.IF_PartialMatchSearchParams search_mod) := MODULE

	shared IT := AutoStandardI.InterfaceTranslator;
	shared inFirstName := IT.fname_val.val(project(search_mod, IT.fname_val.params));
	shared inMiddleName := IT.mname_val.val(project(search_mod, IT.mname_val.params));
	shared inLastName := IT.lname_val.val(project(search_mod, IT.lname_val.params));

	shared inPreferredFirstName := NID.PreferredFirstNew(inFirstName);
	shared inPhoneticLastName := if(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], '');  //CEM - is the key limited to 6???  because the function will return more.

	shared inStreet := IT.addr_value.val(project(search_mod, IT.addr_value.params));  // FIXME - ignored for now

	shared inPrimRange := IT.prange_value.val(project(search_mod, IT.prange_value.params));
	shared inPredir := search_mod.predir;
	shared inPrimName := IT.pname_value.val(project(search_mod, IT.pname_value.params));
	shared inPostdir := search_mod.postdir;
	shared inSuffix := search_mod.suffix;
	shared inSecRange := IT.sec_range_value.val(project(search_mod, IT.sec_range_value.params));
	shared inCity := IT.city_value.val(project(search_mod, IT.city_value.params));
	shared inState := IT.state_value.val(project(search_mod, IT.state_value.params));
	shared inZip5 := (INTEGER) IT.zip_val.val(project(search_mod, IT.zip_value.params));

	shared inPhone := IT.phone_value.val(project(search_mod, IT.phone_value.params));

	maxResults := IT.maxresults_val.val(project(search_mod, IT.maxresults_val.params));
	shared inMaxResults := if (maxResults = 0, 100, maxResults);

	outLayout := RECORD
	  STRING tag;
		STRING fname;
		STRING mname;
		STRING lname;
		STRING corp_name;
		STRING prim_range;
		STRING predir;
		STRING prim_name;
		STRING suffix;
		STRING postdir;
		STRING sec_range;
		STRING city;
		string state;
		string zip5;
		string phone;
	END;
	
	out_ds := DATASET( [ { tag,
												 inFirstName,
												 inMiddleName,
												 inLastName,
												 '',
												 inPrimRange,
												 inPredir,
												 inPrimName,
												 inSuffix,
												 inPostdir,
												 inSecRange,
												 inCity,
												 inState,
												 (STRING) inZip5,
												 inPhone } ], outLayout);

	export go := output(out_ds, NAMED('AutoInterfaceTranslated'), EXTEND);
END;