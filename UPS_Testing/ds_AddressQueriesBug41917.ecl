//from attachment 5278

import iesp;
layout_ds := { string100 street, string25 city, string2 st, string5 zip := ''};
DoHighlight := true;

ds := dataset([
// {'GIBBS','COLLING','','','MA','01960'},
{'16145 SW 84 ST','MIAMI','FL',''},
{'12355 GRAND PINE LN','HAYWARD','WI','54843'},
{'1245 SHOE','','PA','15108'},
{'78A HC 30	CALDWELL','','WV','24925'},
{'546 FRANKLIN RUN RD','','PA','15108'},
{'6107 S KONA','CHICAGO','IL',''},	
{'10801 CORKSCREW RS','ATLANTA','GA',''},	
{'3702 N HUDSON AVE','CHICAGO','IL',''},	
{'APT 618 APT 618','HOUSTON','TX','77079'},
{'3583 DWIGHT DR','MCLEANSVILLE','NC','27301'},
{'3370 MCALL DR','ATLANTA','GA',''},	
{'N6996 STATE ROAD 70','WINTER','WI',''},	
{'1504 GA HWY 21','','GA','31326'},
{'300 MONTAGUE AVE STE B STE B','','SC','29627'},
{'600 CASTEEL DR','','PA','15108'},
{'91 ISLAND BEACH RD','','MA',''},	
{'11540 W 183RD','','IL',''},	
{'8870 MCDONOUGH RD','','MD','21208'},
{'730 SANTA GRAPEVINE RD','PAMPLICO','',''}		
],
layout_ds
);

// output(ds)
testCases := ds;

SearchRequest := iesp.rightaddress.t_RightAddressSearchRequest;

	SearchRequest SearchRequestTransform(layout_ds tc, integer8 c) := TRANSFORM
		SELF.User.QueryID := (string)c;
		SELF.SearchBy.Name.First := '';
		SELF.SearchBy.Name.Middle := '';
		SELF.SearchBy.Name.Last := '';
		SELF.SearchBy.Name.CompanyName := '';
		SELF.SearchBy.LastNameOrCompany := '';
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
	
output(ds, named('raw_inputs'));
export ds_AddressQueriesBug41917 := requests;