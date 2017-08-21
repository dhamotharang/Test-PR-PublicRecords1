IMPORT iesp;

export DATASET(iesp.rightaddress.t_RightAddressSearchRequest) fn_BuildTestCase(layout_TestCase testCase) := FUNCTION

	iesp.rightaddress.t_RightAddressSearchRequest SearchRequestTransform(layout_TestCase tc) := TRANSFORM
		SELF.SearchBy.Name.First := tc.fname;
		SELF.SearchBy.Name.Middle := tc.mname;
		SELF.SearchBy.Name.Last := tc.lname;
		SELF.SearchBy.Name.CompanyName := tc.cname;
		SELF.SearchBy.Address.StreetAddress1 := tc.addr;
		SELF.SearchBy.Address.City := tc.city;
		SELF.SearchBy.Address.State := tc.state;
		SELF.SearchBy.Address.Zip5 := tc.zip;
		SELF.SearchBy.Phone10 := tc.phone;
		SELF.SearchBy.EntityType := tc.EntityType;
		SELF.SearchBy := [];
		SELF.Options := UPS_Testing.DefaultOptions;
		SELF.User := UPS_Testing.DefaultUser;
		SELF := [];
	END;
				
	request := project(testCase, SearchRequestTransform(LEFT)) : INDEPENDENT;
	return DATASET( [ request ], iesp.rightaddress.t_RightAddressSearchRequest);
END;