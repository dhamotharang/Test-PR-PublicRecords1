export File_AutonomyQueries := MODULE

	export layout := RECORD
		UNSIGNED4 QueryNo;
		STRING26 fname;
		STRING26 mname;
		STRING64 lname;
		STRING60 street;
		STRING60 City;
		STRING2 State;
		STRING10 Zip;
		STRING10 Phone;
		STRING8 QueryType;
		STRING650 Query;
	END;

	export filename := '~thor_data400::in::autonomy_queries4';
	export records := dataset(filename,
														layout,
														csv(separator('\t'), terminator('\n'), quote('')));

	export keyed_records := INDEX(records, 
																{QueryNo}, 
																{fname, mname, lname, street, city, state, zip, phone, querytype }, 
																'~thor_data400::in::autonomy_queries4_key');
	export keyed_layout := RECORD
		keyed_records.QueryNo;
		keyed_records.fname;
		keyed_records.mname;
		keyed_records.lname;
		keyed_records.street;
		keyed_records.city;
		keyed_records.state;
		keyed_records.zip;
		keyed_records.phone;
		keyed_records.querytype;
	END;

		export nrecs := COUNT(records) : PERSIST('AutonomyQueries_NRecs');
END;  // File_AutonomyQueries module