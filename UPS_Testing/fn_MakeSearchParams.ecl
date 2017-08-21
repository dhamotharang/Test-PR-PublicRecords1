import UPS_Services, iesp;

export  fn_MakeSearchParams(UPS_Testing.layout_TestCase inputs) := FUNCTION

	lname := if(inputs.lname <> '', inputs.lname, inputs.cname);
	cname := if(inputs.cname <> '', inputs.cname, inputs.lname);
	
	nameAndCompany := ROW( { '', // string62 Full {xpath('Full')};
													 inputs.fname, // string20 First {xpath('First')};
													 inputs.mname, // string20 Middle {xpath('Middle')};
													 lname, // string20 Last {xpath('Last')};
													 '', // string5 Suffix {xpath('Suffix')};
													 '', // string3 Prefix {xpath('Prefix')};
													 cname }, // string120 CompanyName {xpath('CompanyName')};
													 iesp.share.t_NameAndCompany);

	address := ROW( { '', // string28 StreetName {xpath('StreetName')};
										'', // string10 StreetNumber {xpath('StreetNumber')};
										'', // 	string2 StreetPreDirection {xpath('StreetPreDirection')};
										'', // 	string2 StreetPostDirection {xpath('StreetPostDirection')};
										'', // 	string4 StreetSuffix {xpath('StreetSuffix')};
										'', // 	string10 UnitDesignation {xpath('UnitDesignation')};
										'', // 	string8 UnitNumber {xpath('UnitNumber')};
										inputs.addr, // 	string60 StreetAddress1 {xpath('StreetAddress1')};
										'', // 	string60 StreetAddress2 {xpath('StreetAddress2')};
										inputs.state, // 	string2 State {xpath('State')};
										inputs.city, // 	string25 City {xpath('City')};
										inputs.zip, // 	string5 Zip5 {xpath('Zip5')};
										'', // 	string4 Zip4 {xpath('Zip4')};
										'', // 	string18 County {xpath('County')};
										'', // 	string9 PostalCode {xpath('PostalCode')};
										''}, // 	string50 StateCityZip {xpath('StateCityZip')};
										iesp.share.t_Address);

	phone := inputs.phone;
	
	search_inputs := MODULE(UPS_Services.SearchParams)
		export nameQueryInputs := nameAndCompany;
		export addrQueryInputs := address;
		export phoneQueryInput := phone;
	END;
	
	return search_inputs;
END;