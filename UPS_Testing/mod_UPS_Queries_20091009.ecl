IMPORT UPS_Services, iesp;

export mod_UPS_Queries_20091009 := MODULE

	// raw records as they exist in the file.
	export records := MODULE
		export layout := RECORD
			STRING30 fname;
			STRING30 mname;
			STRING30 lname;
			STRING60 street;
			STRING30 city;
			STRING2  state;
			STRING5  zip;
			STRING10 phone;
			STRING256 powersearch;
			STRING10 queryType;
		END;

		export fileName := '~thor_data50::jcw::ups.20091009.records';
		export records := DATASET(fileName, layout, THOR);
	END;

	// raw records converted to test cases (and assigned a hexadecimal queryID)
	export testCases := MODULE
		export layout := UPS_Testing.layout_TestCase;
		// export fileName := '~thor_data50::jcw::ups.20091009.testcases';
		// export records := DATASET(fileName, layout, THOR);
		export records := 
		project(
			records.records,
			transform(
				layout,
				self.addr := left.street,
				self.entitytype := left.querytype,
				self := left
			)
		);
			
		// export key := INDEX(records, {queryID}, {layout_TestCase and not queryID} , '~thor_data50::jcw::ups.20091009.testcases.key');
	END;

	// test cases as RightAddressService queries (using default user and options settings)
	// export queries(BOOLEAN doHighlight = false, 
								 // UNSIGNED maxResults = 100/*UPS_Services.Constants.DEFAULT_MAX_RESULTS*/) := MODULE
		// export layout := iesp.rightaddress.t_RightAddressSearchRequest;
		// export records := fn_BuildTestCases(testCases.records, doHighlight, maxResults);		
	// END;
END;