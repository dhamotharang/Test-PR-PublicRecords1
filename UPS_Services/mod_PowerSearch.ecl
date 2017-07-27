import iesp, Address;

export mod_PowerSearch(STRING240 inQuery, boolean isCanada =false) := MODULE

	shared psText := TRIM(stringlib.StringToUpperCase(inQuery), LEFT, RIGHT);

	shared psParts := RECORD
		STRING120 Name;
		STRING120 Addr;
		STRING10  Phone;
	END;
	
	shared psParts getParts() := FUNCTION
		regexPhone := '^(\\d{10})$';
		phone := if(regexFind(regexPhone, psText), regexFind(regexPhone, psText, 1), '');

		regexSplitNameAddr := '^([A-Z ]+) (\\d.+)$';
		regexNameOnly := '^[A-Z ]+$';
		name := map( phone <> '' => '',
								 regexFind(regexSplitNameAddr, psText) => regexFind(regexSplitNameAddr, psText, 1),
						     regexFind(regexNameOnly, psText) => psText,
								 '');
		addr := map( phone <> '' => '',
								 regexFind(regexSplitNameAddr, psText) => regexFind(regexSplitNameAddr, psText, 2),
						     NOT regexFind(regexNameOnly, psText) => psText,
								 '');
								 
		resp := ROW( { name, addr, phone }, psParts);
		return resp;
	END;

	export iesp.share.t_NameAndCompany getName() := FUNCTION
		parts := getParts();
		name := TRIM(parts.name);

		string clnName := if (name <> '', Address.CleanPerson73(name), '');
		clnFirst := TRIM(clnName[6..25]);
		clnMiddle := TRIM(clnName[26..45]);
		clnLast := TRIM(clnName[46..70]);
									 
		return iesp.ECL2ESP.SetNameAndCompany(
			first := clnFirst, 
			middle := clnMiddle, 
			last := clnLast, 
			suffix := '', 
			prefix := '', 
			full := '', 
			company := name);
	END;

		parts := getParts();
		addr := TRIM(parts.addr);

		regexStreetCityStZip := '^(.+ (RD|ST|CT|LN|CIR|DR|HWY|BLVD|TRCE|WAY)) ([A-Z ]+) ([A-Z]{2}) (\\d{5})$';
		regexOtherCityStZip := '^(.*)\\b\\s*([A-Z ]+) ([A-Z]{2}) (\\d{5})$';
		regexStateZip := '\\b([A-Z]{2}) (\\d{5})$';
		regexStreetZip := '(.+) (\\d{5})$';
		regexZip := '(\\b\\d{5})$';
		
		street := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 1), 
									regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 1),
									regexFind(regexStreetZip, addr) => regexFind(regexStreetZip, addr, 1),
									addr);

		city := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 3),
							  regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 2),
								'');

		state := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 4),
							   regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 3),
							   regexFind(regexStateZip, addr) => regexFind(regexStateZip, addr, 1),
								 '');
		zip := MAP(regexFind(regexStreetCityStZip, addr) => regexFind(regexStreetCityStZip, addr, 5),
							 regexFind(regexOtherCityStZip, addr) => regexFind(regexOtherCityStZip, addr, 4),
							 regexFind(regexStateZip, addr) => regexFind(regexStateZip, addr, 2),
							 regexFind(regexStreetZip, addr) => regexFind(regexStreetZip, addr, 2),
							 regexFind(regexZip, addr) => regexFind(regexZip, addr, 1),
							 '');

	export paddr := iesp.ECL2ESP.SetAddress ('', // string28 StreetName {xpath('StreetName')};
										'', // string10 StreetNumber {xpath('StreetNumber')};
										'', // string2 StreetPreDirection {xpath('StreetPreDirection')};
										'', // string2 StreetPostDirection {xpath('StreetPostDirection')};
										'', // string4 StreetSuffix {xpath('StreetSuffix')};
										'', // string10 UnitDesignation {xpath('UnitDesignation')};
										'', // string8 UnitNumber {xpath('UnitNumber')};
										city, // string25 City {xpath('City')};
										state, // string2 State {xpath('State')};
										zip, // string5 Zip5 {xpath('Zip5')};
										'', // string4 Zip4 {xpath('Zip4')};
										'', // string18 County {xpath('County')};
										street, // string60 StreetAddress1 {xpath('StreetAddress1')};
										'', // string60 StreetAddress2 {xpath('StreetAddress2')};
										'', // string9 PostalCode {xpath('PostalCode')};
										''  // string50 StateCityZip {xpath('StateCityZip')};
									);

	export iesp.share.t_Address getAddress() := FUNCTION
		return mod_Address(paddr,isCanada).bestParser();
	END;

	export STRING10 getPhone() := FUNCTION
		parts := getParts();
		return parts.phone;
	END;

END;