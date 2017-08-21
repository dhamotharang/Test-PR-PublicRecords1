import IESP, UPS_Services;

export mod_SearchBy := MODULE

	export params := INTERFACE
		export STRING20  First := '';
		export STRING20  Middle := '';
		export STRING120 LastNameOrCompany := '';
		export STRING60  Street := '';
		export STRING25  City := '';
		export STRING2   State := '';
		export STRING5   Zip := '';
		export STRING10  Phone := '';
		export STRING240 PowerSearch := '';
		export STRING10  EntityType := UPS_Services.Constants.TAG_ENTITY_UNK;
	END;

	export iesp.rightaddress.t_RightAddressSearchBy buildSearchBy(params p) := FUNCTION

											
		iesp.rightaddress.t_RightAddressSearchBy MA() := transform
			self.name.first := p.first,
			self.name.middle := p.middle,
			self.LastNameOrCompany := p.LastNameOrCompany,
			self.PowerSearch := p.PowerSearch,
			self.address.StreetAddress1 := p.Street,
			self.address.City := p.City,
			self.address.State := p.State,
			self.address.Zip5 := p.Zip,
			self.Phone10 := p.Phone,
			self.EntityType := p.EntityType,
			self := [],

		end;
		
		r := DATASET([MA()])[1];														
											
		return r;
	END;
END;