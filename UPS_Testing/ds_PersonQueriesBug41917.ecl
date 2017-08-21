import iesp;
layout_ds := {string25 lname, string25 fname, string100 street, string25 city, string2 st, string5 zip := ''};
DoHighlight := true;

ds := dataset([
{'GIBBS','COLLING','','','MA','01960'},
{'ECKHOUT','MARCI','','KEARNEY','NE',''},	
{'SCHOENBERG','RUSS','2143 W MIDDLEFIELD RD','MOUNTAIN VIEW','CA','94043'},
{'TIANNE','KRAM','','MUSKEGO','WI','53150'},
{'MCHALE','CASSIE','','CALDWELL','WV','24925'},
{'MCHALE','CASSIE','','','WV'},	
{'LATHAM','MAURIANNE','','FAIRVIEW','TN','37062'},
{'NEER','LENA','','LINCOLN','ND','58504'},
{'LENHART','FLYOD','','GRAHAM','WA','98338'},
{'COGLOWEN','GEORGANNA','','LOUISVILLE','KY','40214'},
{'CERISWELL','THOMAS','','','MD','21117'},
{'DAVISON','DERIRCK','','PELL CITY','AL',''},	
{'COGBURN','GEORGANNA','HATCH AVENUE','LOUISVILLE','KY','40214'},
{'DAVISON','DERIRCK','2410 COGEWORTH AVE','PELL CITY','AL',''},	
{'JOHNSON','','7000 EASTHILLS WAY','','GA',''},	
{'PAT TAUSCH','','','ANDREWS','TX','79714'},
{'BRONSON TREVOR','','80 BLACKHAWK STREET','CHICAGO','IL',''},	
{'ANNA EISNER','','928 SCHULER CT','','KY','41017'},
{'CHRISTY GOLDMITH','','','','AL','36322'},
{'GREGORY POLITICCHIO','','','','OH',''},	
{'SHANNA PERKINS','','','HAYWARD','WI','54843'},
{'EMMA HOLTZAPFEL','','2063 BARONS COVE','','KY','41017'}
],
layout_ds
);

// output(ds)
testCases := ds;

SearchRequest := iesp.rightaddress.t_RightAddressSearchRequest;

	SearchRequest SearchRequestTransform(layout_ds tc, integer8 c) := TRANSFORM
		SELF.User.QueryID := (string)c;
		SELF.SearchBy.Name.First := tc.fname;
		SELF.SearchBy.Name.Middle := '';
		SELF.SearchBy.Name.Last := '';
		SELF.SearchBy.Name.CompanyName := '';
		SELF.SearchBy.LastNameOrCompany := tc.lname;
		SELF.SearchBy.Address.StreetAddress1 := tc.street;
		SELF.SearchBy.Address.City := tc.city;
		SELF.SearchBy.Address.State := tc.st;
		SELF.SearchBy.Address.Zip5 := tc.zip;
		SELF.SearchBy.Phone10 := '';
		SELF.SearchBy.EntityType := 'Individual';
		SELF.SearchBy := [];
		SELF.Options.Highlight := DoHighlight;
		SELF.Options := UPS_Testing.DefaultOptions;
		SELF.USER := UPS_Testing.DefaultUser;
		SELF := [];
	END;
				
	requests := project(testCases, SearchRequestTransform(LEFT, COUNTER)) : INDEPENDENT;
	
	// output(requests);


export ds_PersonQueriesBug41917 := requests;