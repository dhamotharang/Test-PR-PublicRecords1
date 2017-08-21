IMPORT iesp, doxie, UPS_Services, UPS_Testing;

RA := iesp.RightAddress;
Debug := UPS_Services.Debug;
Constants := UPS_Services.Constants;

inputs := module(UPS_Testing.mod_SearchBy.params)
	export LastNameOrCompany := '';
	export First := '';
	export Middle := '';
	export Street := '';
	export City := '';
	export State := '';
	export Zip := '';
	export Phone := '';
	export EntityType := UPS_Services.Constants.TAG_ENTITY_UNK;
END;

BOOLEAN highlight := false;

searchBy := DATASET( [ UPS_Testing.mod_SearchBy.buildSearchBy(inputs) ], RA.t_RightAddressSearchBy);

RA.t_RightAddressSearchRequest SearchRequestTransform(searchBy L) := TRANSFORM
	SELF.Options := if (highlight, UPS_Testing.DefaultOptionsWithHighlighting,
																 UPS_Testing.DefaultOptions);
	SELF.User := UPS_Testing.DefaultUser;
	SELF.RemoteLocations := [];
	SELF.ServiceLocations := [];

	SELF.SearchBy := L;
END;

request := project(searchby, SearchRequestTransform(LEFT));
#stored('RightAddressSearchRequest', request);
OUTPUT(request, NAMED('Request'));
UPS_Services.RightAddressService();

//output(UPS_Services.RightAddress.records);
