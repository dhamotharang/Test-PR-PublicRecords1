import doxie;

export PersonSearchModule(PersonSearchParam p) :=
MODULE

	// Helper functions, not including stringlib
	shared parse_name(STRING str) := addrcleanlib.CleanPerson73(str);
	shared zips_within_radius(string5 zip, integer zipradius) := ziplib.ZipsWithinRadius(zip, zipradius);
	shared phoneticized(STRING str) := metaphonelib.DMetaPhone1(str)[1..6];
	shared nicknamed(STRING str) := datalib.preferredfirst(str);


	// Prepping input
	shared formatted_ssn := Stringlib.StringFilter(p.ssn,'0123456789');
	shared parsed_name := IF(p.fullname<>'', addrcleanlib.CleanPerson73(p.fullname), '');
	shared parsed_fname := p.fullname[6..25];
	shared parsed_lname := p.fullname[46..65];
	shared formatted_fname := Stringlib.StringToUpperCase(IF(parsed_name<>'',parsed_fname,p.fname));
	shared formatted_lname := Stringlib.StringToUpperCase(IF(parsed_name<>'',parsed_lname,p.lname));
	shared formatted_zips := zips_within_radius(p.zip, p.zipradius);

	// Deciding Search method
	shared doSSNsearch := p.ssn <> '';
	shared doZipsearch := p.zip <> '' AND p.lname <> '';
	shared doNamesearch := p.lname <> '';

	// Searching
	shared layout_dids := RECORD
		unsigned6 did;
	END;

	shared limiter(DATASET(layout_dids) ds) := LIMIT(ds, 10000, keyed);

	i := doxie.Key_Header_SSN;
	shared search_ssn := limiter(
											 PROJECT(
											 i(s1=formatted_ssn[1],
												 s2=formatted_ssn[2],
												 s3=formatted_ssn[3],
												 s4=formatted_ssn[4],
												 s5=formatted_ssn[5],
												 s6=formatted_ssn[6],
												 s7=formatted_ssn[7],
												 s8=formatted_ssn[8],
												 s9=formatted_ssn[9],
												 formatted_lname='' OR i.dph_lname=phoneticized(formatted_lname),
												 formatted_fname='' OR i.pfname=nicknamed(formatted_fname)), layout_dids));
	
	i := doxie.key_header_zip;
	shared search_zip := limiter(
											 PROJECT(
											 i(i.zip IN formatted_zips,
												 i.dph_lname=phoneticized(formatted_lname),
												 i.lname=formatted_lname OR p.AllowPhonetics,
												 i.pfname=nicknamed(formatted_fname),
												 i.fname=formatted_fname OR p.AllowNicknames), layout_dids));

	i := doxie.Key_Header_Name;
	shared search_name := limiter(
												PROJECT(
											  i(i.dph_lname=phoneticized(formatted_lname),
												 i.lname=formatted_lname OR p.AllowPhonetics,
												 i.pfname=nicknamed(formatted_fname),
												 i.fname=formatted_fname OR p.AllowNicknames), layout_dids));


	export dids := MAP(doSSNsearch => search_ssn,
										 doZipsearch => search_zip,
										 doNamesearch => search_name,
										 FAIL(layout_dids, 1, ''));


	// Using results to pull records
	shared records_by_dids :=
	FUNCTION
		i := doxie.Key_Header;
	
		j := JOIN(dids, i, keyed(LEFT.did=RIGHT.s_did));
		RETURN j;
	END;

	// formatting results
	export Records :=
	FUNCTION
		// TODO: rollup.  Instruct to keep name/ssn/dob/address differences, and merge date first/last
		RETURN records_by_dids;
	END;
	
END;