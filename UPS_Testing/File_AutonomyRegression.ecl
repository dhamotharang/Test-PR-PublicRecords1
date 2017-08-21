// this file contains the randomly selected records from the larger queries
// file.

export File_AutonomyRegression := MODULE

	export layout := File_AutonomyQueries.layout;
	export filename := '~thor_data400::in::autonomy_random50k_queries';
	export records := dataset(filename, layout, THOR);

	export keyed_records := index(records, 
																{ QueryNo },
																{ fname, mname, lname, street, City, State, Zip, Phone, QueryType },
																'~thor_data400::in::autonomy_random50k_queries_key');
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

	export nrecs := COUNT(keyed_records) : PERSIST('AutonomyRegression_queries_nrecs');	
END;  // File_AutonomyQueries module