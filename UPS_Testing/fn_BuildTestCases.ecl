IMPORT iesp, UPS_Services;
SearchRequest := iesp.rightaddress.t_RightAddressSearchRequest;

export SearchRequest fn_BuildTestCases(DATASET(layout_TestCase) testCases, 
																			 boolean DoHighlight = true,
																			 UNSIGNED maxResults = 100/*UPS_Services.Constants.DEFAULT_MAX_RESULTS*/) := FUNCTION
	SearchRequest SearchRequestTransform(layout_TestCase tc, integer8 c) := TRANSFORM
		SELF.User.QueryID := if(tc.queryID <> '0', tc.queryID, (string)c);
		SELF.SearchBy.Name.First := tc.fname;
		SELF.SearchBy.Name.Middle := tc.mname;
		SELF.SearchBy.Name.Last := '';
		SELF.SearchBy.Name.CompanyName := '';
		SELF.SearchBy.LastNameOrCompany := IF(tc.cname <> '', tc.cname, tc.lname);
		SELF.SearchBy.Address.StreetAddress1 := tc.addr;
		SELF.SearchBy.Address.City := tc.city;
		SELF.SearchBy.Address.State := tc.state;
		SELF.SearchBy.Address.Zip5 := tc.zip;
		SELF.SearchBy.Phone10 := tc.phone;
		SELF.SearchBy.Powersearch := tc.powersearch;
		SELF.SearchBy.EntityType := tc.EntityType;
		SELF.SearchBy := [];
		SELF.Options.Highlight := DoHighlight;
		SELF.Options.MaxResults := maxResults;
		SELF.Options := UPS_Testing.DefaultOptions;
		SELF.USER := UPS_Testing.DefaultUser;
		SELF := [];
	END;
				
	requests := project(testCases, SearchRequestTransform(LEFT, MAX(testCases, (INTEGER8)QUERYID) + COUNTER)) : INDEPENDENT;
	return requests;
END;